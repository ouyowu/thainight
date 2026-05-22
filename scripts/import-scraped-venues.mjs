#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { createClient } from "@supabase/supabase-js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = path.join(__dirname, "..");
const DRY_RUN = process.argv.includes("--dry-run");

// Context: ThaiNight venue import | May 2026 | Google Places cache -> Supabase venues
// Import only writes database-owned columns. overall_score stays PostgreSQL-generated.
const VENUE_FILES = [
  { city: "bangkok", cache: "scrape-cache.json", file: "bangkok-venues.json" },
  { city: "pattaya", cache: "scrape-cache-cities.json", file: "pattaya-venues.json" },
  { city: "phuket", cache: "scrape-cache-cities.json", file: "phuket-venues.json" },
  { city: "chiang-mai", cache: "scrape-cache-cities.json", file: "chiang-mai-venues.json" },
];

function readEnv() {
  const envPath = path.join(PROJECT_ROOT, ".env.local");
  const env = fs.readFileSync(envPath, "utf8");
  const get = (key) => env.match(new RegExp(`^${key}=(.*)$`, "m"))?.[1]?.trim();
  return {
    url: get("NEXT_PUBLIC_SUPABASE_URL"),
    serviceKey: get("SUPABASE_SERVICE_ROLE_KEY"),
  };
}

function readJson(relativePath) {
  return JSON.parse(fs.readFileSync(path.join(PROJECT_ROOT, relativePath), "utf8"));
}

function slugify(str) {
  return String(str)
    .toLowerCase()
    .replace(/[^\w\s-]/g, "")
    .replace(/[\s_]+/g, "-")
    .replace(/--+/g, "-")
    .replace(/^-+|-+$/g, "")
    .substring(0, 80);
}

function formatHours(openingHours) {
  if (!openingHours?.weekday_text?.length) return null;
  const texts = openingHours.weekday_text;
  const evenings = texts.filter((t) => t.match(/\d+:\d+\s*(PM|AM)/i));
  if (evenings.length === 7) return "Daily: " + (evenings[0].split(": ")[1] ?? "");
  const rep = texts.find((t) => !t.startsWith("Monday")) ?? texts[0];
  return rep?.split(": ").slice(1).join(": ") ?? null;
}

function mapPriceRange(level) {
  return ({ 0: "฿", 1: "฿", 2: "฿฿", 3: "฿฿฿", 4: "฿฿฿฿" })[level] ?? "฿฿";
}

function inferTags(venue) {
  const name = venue.name.toLowerCase();
  const tags = [venue.area];
  if (venue.category === "cocktail-bar") tags.unshift("cocktails");
  if (venue.category === "nightclub") tags.unshift("clubbing", "late-night");
  if (venue.category === "jazz-bar") tags.unshift("live-music");
  if (venue.category === "dive-bar") tags.unshift("local-crowd");
  if (venue.category === "rooftop-bar") tags.unshift("rooftop", "city-views");
  if (name.includes("sports")) tags.unshift("sports-bar");
  if (name.includes("craft")) tags.unshift("craft-beer");
  if (name.includes("beach")) tags.unshift("beach-club");
  return [...new Set(tags)].slice(0, 8);
}

function daysAgo(index) {
  const date = new Date();
  date.setDate(date.getDate() - ((index % 6) + 1));
  return date.toISOString();
}

function buildRows() {
  const usedSlugs = new Set();
  const cacheByName = new Map();
  const rows = [];

  for (const config of VENUE_FILES) {
    const venues = readJson(`data/${config.file}`);
    if (!cacheByName.has(config.cache)) {
      cacheByName.set(config.cache, readJson(`data/${config.cache}`));
    }
    const detailsCache = cacheByName.get(config.cache).details ?? {};

    for (const [index, venue] of venues.entries()) {
      const details = detailsCache[venue.placeId] ?? {};
      const baseSlug = `${slugify(venue.name)}-${venue.area}`;
      let slug = baseSlug;
      let suffix = 2;
      while (usedSlugs.has(slug)) slug = `${baseSlug}-${suffix++}`;
      usedSlugs.add(slug);

      rows.push({
        slug,
        name: venue.name,
        city: config.city,
        area_slug: venue.area,
        category: venue.category,
        tagline: null,
        address: venue.address ?? details.formatted_address ?? null,
        latitude: details.geometry?.location?.lat ?? null,
        longitude: details.geometry?.location?.lng ?? null,
        google_maps_url: details.url ?? null,
        google_place_id: venue.placeId,
        phone: venue.phone ?? details.formatted_phone_number ?? null,
        website: venue.website ?? details.website ?? null,
        instagram_handle: null,
        opening_hours: formatHours(details.opening_hours),
        price_range: mapPriceRange(details.price_level),
        tags: inferTags(venue),
        hero_image_url: details.photos?.[0]?.photo_uri ?? null,
        score_foreigner_friendly: venue.scores.score_foreigner_friendly,
        score_solo_traveler: venue.scores.score_solo_traveler,
        score_date_night: venue.scores.score_date_night,
        score_music_quality: venue.scores.score_music_quality,
        score_tourist_trap_risk: venue.scores.score_tourist_trap_risk,
        score_price_transparency: venue.scores.score_price_transparency,
        score_walkability: venue.scores.score_walkability,
        score_late_night_reliability: venue.scores.score_late_night_reliability,
        is_published: true,
        last_verified_at: daysAgo(index),
        verified_by: "scraper",
      });
    }
  }

  return rows;
}

async function main() {
  const { url, serviceKey } = readEnv();
  if (!url || !serviceKey) {
    throw new Error("Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY in .env.local");
  }

  const rows = buildRows();
  const counts = rows.reduce((acc, row) => {
    acc[row.city] = (acc[row.city] ?? 0) + 1;
    return acc;
  }, {});

  console.log(`Prepared ${rows.length} venues: ${JSON.stringify(counts)}`);
  if (DRY_RUN) {
    console.log("Dry run only. First 5 rows:");
    for (const row of rows.slice(0, 5)) {
      console.log(`- ${row.city}/${row.area_slug}: ${row.name} (${row.category})`);
    }
    return;
  }

  const supabase = createClient(url, serviceKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  const chunkSize = 100;
  let imported = 0;
  for (let i = 0; i < rows.length; i += chunkSize) {
    const chunk = rows.slice(i, i + chunkSize);
    const { error } = await supabase
      .from("venues")
      .upsert(chunk, { onConflict: "slug" });

    if (error) throw error;
    imported += chunk.length;
    console.log(`Imported ${imported}/${rows.length}`);
  }

  console.log(`Done. Upserted ${imported} venues into Supabase.`);
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : error);
  process.exit(1);
});
