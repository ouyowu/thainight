#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { createClient } from "@supabase/supabase-js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = path.join(__dirname, "..");

function readEnv(name) {
  const envPath = path.join(PROJECT_ROOT, ".env.local");
  const raw = fs.existsSync(envPath) ? fs.readFileSync(envPath, "utf8") : "";
  return raw.match(new RegExp(`^${name}=(.*)$`, "m"))?.[1]?.trim().replace(/^["']|["']$/g, "")
    ?? process.env[name];
}

function parseArgs() {
  const args = Object.fromEntries(
    process.argv.slice(2).map((arg) => {
      if (!arg.startsWith("--")) return [arg, true];
      const [key, value] = arg.slice(2).split("=");
      return [key, value ?? true];
    })
  );

  return {
    city: typeof args.city === "string" ? args.city : undefined,
    limit: Number(args.limit ?? 250),
    offset: Number(args.offset ?? 0),
    dryRun: Boolean(args["dry-run"]),
    photoLimit: Math.min(Number(args.photos ?? 5), 10),
  };
}

function mediaUrl(photoName, apiKey) {
  const url = new URL(`https://places.googleapis.com/v1/${photoName}/media`);
  url.searchParams.set("maxWidthPx", "1200");
  url.searchParams.set("maxHeightPx", "900");
  url.searchParams.set("key", apiKey);
  return url.toString();
}

async function resolveMediaUrl(url) {
  const response = await fetch(url, {
    method: "GET",
    redirect: "manual",
    headers: {
      Referer: "https://thainight.co/",
    },
  });

  if (response.status >= 300 && response.status < 400) {
    const location = response.headers.get("location");
    if (location) return location;
  }

  if (response.ok) return url;

  const text = await response.text();
  throw new Error(`Google Places media ${response.status}: ${text.slice(0, 180)}`);
}

async function fetchPhotoUrls(placeId, apiKey, photoLimit) {
  const url = new URL(`https://places.googleapis.com/v1/places/${placeId}`);
  url.searchParams.set("languageCode", "en");

  const response = await fetch(url, {
    headers: {
      "X-Goog-Api-Key": apiKey,
      "X-Goog-FieldMask": "photos.name",
      Referer: "https://thainight.co/",
    },
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`Google Places ${response.status}: ${text.slice(0, 180)}`);
  }

  const payload = await response.json();
  const mediaUrls = (payload.photos ?? [])
    .map((photo) => photo?.name)
    .filter((name) => typeof name === "string")
    .slice(0, photoLimit)
    .map((name) => mediaUrl(name, apiKey));

  const resolvedUrls = [];
  for (const url of mediaUrls) {
    resolvedUrls.push(await resolveMediaUrl(url));
  }

  return resolvedUrls;
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function main() {
  const args = parseArgs();
  const supabaseUrl = readEnv("NEXT_PUBLIC_SUPABASE_URL");
  const serviceKey = readEnv("SUPABASE_SERVICE_ROLE_KEY");
  const googleKey = readEnv("GOOGLE_MAPS_API_KEY") ?? readEnv("NEXT_PUBLIC_GOOGLE_MAPS_API_KEY");

  if (!supabaseUrl || !serviceKey || !googleKey) {
    throw new Error("Missing Supabase or Google Maps credentials.");
  }

  const supabase = createClient(supabaseUrl, serviceKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  let query = supabase
    .from("venues")
    .select("id, city, name, google_place_id")
    .eq("is_published", true)
    .not("google_place_id", "is", null)
    .order("city", { ascending: true })
    .range(args.offset, args.offset + args.limit - 1);

  if (args.city) query = query.eq("city", args.city);

  const { data: venues, error } = await query;
  if (error) throw error;

  const stats = { dryRun: args.dryRun, requested: venues?.length ?? 0, updated: 0, noPhotos: 0, errors: 0 };

  for (const venue of venues ?? []) {
    try {
      const photos = await fetchPhotoUrls(venue.google_place_id, googleKey, args.photoLimit);
      if (photos.length === 0) {
        stats.noPhotos += 1;
        continue;
      }

      if (!args.dryRun) {
        const { error: updateError } = await supabase
          .from("venues")
          .update({
            hero_image_url: photos[0],
            image_urls: photos.slice(1),
            updated_at: new Date().toISOString(),
          })
          .eq("id", venue.id);
        if (updateError) throw updateError;
      }

      stats.updated += 1;
      console.log(`✓ ${venue.city}: ${venue.name}`);
      await sleep(120);
    } catch (error) {
      stats.errors += 1;
      console.error(`✗ ${venue.city}: ${venue.name}: ${error.message}`);
    }
  }

  console.log(JSON.stringify(stats, null, 2));
}

main().catch((error) => {
  console.error(error.message);
  process.exit(1);
});
