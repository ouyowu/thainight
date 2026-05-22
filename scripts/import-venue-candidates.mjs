#!/usr/bin/env node

import { readFile } from "node:fs/promises";
import { createClient } from "@supabase/supabase-js";

const SOURCE_TYPES = new Set([
  "google_places",
  "official_site",
  "instagram",
  "tourism_directory",
  "manual_research",
]);

const CITY_SLUGS = new Set(["bangkok", "pattaya", "phuket", "chiang-mai"]);

function usage() {
  console.error(
    "Usage: npm run import:candidates -- ./path/to/candidates.json"
  );
}

function slugify(value) {
  return String(value)
    .normalize("NFKD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/&/g, " and ")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, 90);
}

function trimOrNull(value) {
  if (typeof value !== "string") return null;
  const trimmed = value.trim();
  return trimmed.length > 0 ? trimmed : null;
}

function parseNumber(value) {
  if (typeof value === "number" && Number.isFinite(value)) return value;
  if (typeof value !== "string") return null;
  const parsed = Number(value.trim());
  return Number.isFinite(parsed) ? parsed : null;
}

function parseTags(value) {
  if (Array.isArray(value)) {
    return value
      .filter((tag) => typeof tag === "string")
      .map((tag) => slugify(tag))
      .filter(Boolean);
  }

  if (typeof value === "string") {
    return value
      .split(",")
      .map((tag) => slugify(tag))
      .filter(Boolean);
  }

  return [];
}

function normalizeCandidate(raw, index) {
  const city = slugify(raw.city ?? "");
  if (!CITY_SLUGS.has(city)) {
    throw new Error(`Row ${index + 1}: unsupported city "${raw.city}".`);
  }

  const name = trimOrNull(raw.name);
  if (!name) throw new Error(`Row ${index + 1}: name is required.`);

  const sourceType = SOURCE_TYPES.has(raw.source_type)
    ? raw.source_type
    : "manual_research";
  const areaSlug = trimOrNull(raw.area_slug)
    ? slugify(raw.area_slug)
    : null;
  const sourcePlaceId = trimOrNull(raw.source_place_id);
  const confidenceScore = parseNumber(raw.confidence_score);

  if (
    confidenceScore !== null &&
    (confidenceScore < 0 || confidenceScore > 10)
  ) {
    throw new Error(`Row ${index + 1}: confidence_score must be 0-10.`);
  }

  return {
    city,
    area_slug: areaSlug,
    source_type: sourceType,
    source_name: trimOrNull(raw.source_name) ?? "manual import",
    source_url: trimOrNull(raw.source_url),
    source_place_id: sourcePlaceId,
    name,
    slug: slugify(name),
    category: trimOrNull(raw.category),
    address: trimOrNull(raw.address),
    latitude: parseNumber(raw.latitude),
    longitude: parseNumber(raw.longitude),
    phone: trimOrNull(raw.phone),
    website: trimOrNull(raw.website),
    instagram_handle: trimOrNull(raw.instagram_handle),
    opening_hours: trimOrNull(raw.opening_hours),
    price_range: trimOrNull(raw.price_range),
    tags: parseTags(raw.tags),
    raw_payload: raw.raw_payload ?? raw,
    confidence_score: confidenceScore,
    dedupe_key: sourcePlaceId
      ? `place:${sourcePlaceId}`
      : [city, areaSlug ?? "unknown-area", slugify(name)].join(":"),
    status: "new",
  };
}

async function main() {
  const inputPath = process.argv[2];
  if (!inputPath) {
    usage();
    process.exit(1);
  }

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !serviceKey) {
    console.error(
      "Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY."
    );
    process.exit(1);
  }

  const file = await readFile(inputPath, "utf8");
  const parsed = JSON.parse(file);
  if (!Array.isArray(parsed)) {
    throw new Error("Input file must be a JSON array.");
  }

  const candidates = parsed.map(normalizeCandidate);
  const supabase = createClient(url, serviceKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  const chunkSize = 100;
  let inserted = 0;

  for (let i = 0; i < candidates.length; i += chunkSize) {
    const chunk = candidates.slice(i, i + chunkSize);
    const { error, count } = await supabase
      .from("venue_import_candidates")
      .upsert(chunk, { onConflict: "dedupe_key", ignoreDuplicates: true })
      .select("id", { count: "exact", head: true });

    if (error) throw error;
    inserted += count ?? 0;
  }

  console.log(
    `Imported ${inserted} new candidates from ${candidates.length} rows.`
  );
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : error);
  process.exit(1);
});
