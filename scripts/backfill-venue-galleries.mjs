#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { createClient } from "@supabase/supabase-js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = path.join(__dirname, "..");

// Context: ThaiNight venue galleries | May 2026 | Promote already-cached Google photo URIs into venue detail galleries.
const CACHE_FILES = [
  path.join(PROJECT_ROOT, "data/scrape-cache.json"),
  path.join(PROJECT_ROOT, "data/scrape-cache-cities.json"),
];

function envValue(name) {
  const file = path.join(PROJECT_ROOT, ".env.local");
  const raw = fs.existsSync(file) ? fs.readFileSync(file, "utf8") : "";
  return raw.match(new RegExp(`^${name}=(.*)$`, "m"))?.[1]?.trim().replace(/^["']|["']$/g, "")
    ?? process.env[name];
}

function photoMediaUrl(photoName, apiKey) {
  if (!photoName || !apiKey) return null;
  const url = new URL(`https://places.googleapis.com/v1/${photoName}/media`);
  url.searchParams.set("maxWidthPx", "1200");
  url.searchParams.set("maxHeightPx", "900");
  url.searchParams.set("key", apiKey);
  return url.toString();
}

async function fetchLivePhotoUris(placeId, apiKey) {
  if (!placeId || !apiKey) return [];
  const url = new URL(`https://places.googleapis.com/v1/places/${placeId}`);
  url.searchParams.set("languageCode", "en");
  const response = await fetch(url, {
    headers: {
      "X-Goog-Api-Key": apiKey,
      "X-Goog-FieldMask": "photos.name",
      Referer: "https://thainight.co/",
    },
  });
  if (!response.ok) return [];
  const payload = await response.json();
  return (payload.photos ?? [])
    .map((photo) => photoMediaUrl(photo?.name, apiKey))
    .filter((url) => typeof url === "string")
    .slice(0, 5);
}

function loadPhotosByPlaceId() {
  const result = new Map();
  for (const file of CACHE_FILES) {
    if (!fs.existsSync(file)) continue;
    const payload = JSON.parse(fs.readFileSync(file, "utf8"));
    const placeCache = payload.places && typeof payload.places === "object"
      ? payload.places
      : payload;
    for (const entry of Object.values(placeCache)) {
      for (const place of entry?.results ?? []) {
        if (!place?.place_id) continue;
        const photos = (place.photos ?? [])
          .map((photo) => photo?.photo_uri)
          .filter((url) => typeof url === "string");
        if (photos.length === 0) continue;
        const current = result.get(place.place_id) ?? [];
        result.set(place.place_id, Array.from(new Set([...current, ...photos])).slice(0, 5));
      }
    }
  }
  return result;
}

function normalizeImages(hero, imageUrls) {
  const current = Array.isArray(imageUrls) ? imageUrls.filter((url) => typeof url === "string") : [];
  return Array.from(new Set([hero, ...current].filter(Boolean)));
}

async function main() {
  const dryRun = process.argv.includes("--dry-run");
  const liveMissing = process.argv.includes("--live-missing");
  const url = envValue("NEXT_PUBLIC_SUPABASE_URL");
  const key = envValue("SUPABASE_SERVICE_ROLE_KEY");
  const googleKey = envValue("GOOGLE_MAPS_API_KEY") ?? envValue("NEXT_PUBLIC_GOOGLE_MAPS_API_KEY");
  if (!url || !key) throw new Error("Missing Supabase service env vars.");

  const supabase = createClient(url, key, { auth: { persistSession: false, autoRefreshToken: false } });
  const photosByPlaceId = loadPhotosByPlaceId();
  const { data: venues, error } = await supabase
    .from("venues")
    .select("id, name, google_place_id, hero_image_url, image_urls")
    .eq("is_published", true);
  if (error) throw error;

  let eligible = 0;
  let updated = 0;
  let skipped = 0;
  let liveFetched = 0;

  for (const venue of venues ?? []) {
    const currentImages = normalizeImages(venue.hero_image_url, venue.image_urls);
    const cached = photosByPlaceId.get(venue.google_place_id ?? "") ?? [];
    let merged = Array.from(new Set([...currentImages, ...cached])).slice(0, 5);
    if (liveMissing && merged.length < 5 && venue.google_place_id) {
      const livePhotos = await fetchLivePhotoUris(venue.google_place_id, googleKey);
      if (livePhotos.length > 0) liveFetched += 1;
      merged = Array.from(new Set([...merged, ...livePhotos])).slice(0, 5);
    }
    if (merged.length < 2) {
      skipped += 1;
      continue;
    }
    eligible += 1;
    if (currentImages.length >= Math.min(5, merged.length)) {
      skipped += 1;
      continue;
    }
    if (!dryRun) {
      const { error: updateError } = await supabase
        .from("venues")
        .update({
          hero_image_url: venue.hero_image_url ?? merged[0],
          image_urls: merged.slice(1),
        })
        .eq("id", venue.id);
      if (updateError) throw updateError;
    }
    updated += 1;
  }

  console.log(JSON.stringify({ dryRun, liveMissing, cached_place_ids: photosByPlaceId.size, liveFetched, eligible, updated, skipped }, null, 2));
}

main().catch((error) => {
  console.error(error.message);
  process.exit(1);
});
