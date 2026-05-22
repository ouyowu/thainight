#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { createClient } from "@supabase/supabase-js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = path.join(__dirname, "..");
const REPORT_PATH = path.join(PROJECT_ROOT, "data/google-places-enrichment-report.json");

// Context: ThaiNight Google Places enrichment | May 2026 | Refresh facts, store our own risk signals.
// Google-owned reviews/photos are not copied into ThaiNight as permanent content.
const DEFAULT_FIELD_MASK = [
  "id",
  "displayName",
  "formattedAddress",
  "location",
  "nationalPhoneNumber",
  "websiteUri",
  "regularOpeningHours",
  "priceLevel",
  "rating",
  "userRatingCount",
  "types",
  "googleMapsUri",
  "businessStatus",
  "photos.name",
  "photos.authorAttributions",
];

const REVIEW_FIELD_MASK = [
  "reviews.rating",
  "reviews.text",
  "reviews.originalText",
  "reviews.relativePublishTimeDescription",
];

const RISK_KEYWORDS = {
  pricing: ["scam", "overpriced", "overcharged", "rip off", "rip-off", "tourist trap", "expensive"],
  security: ["security", "bouncer", "police", "raid", "unsafe", "threat", "fight"],
  closure: ["closed", "shutdown", "shut down", "permanently closed"],
  service: ["rude", "aggressive", "bad service", "avoid"],
};

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
    limit: Number(args.limit ?? 100),
    offset: Number(args.offset ?? 0),
    dryRun: Boolean(args["dry-run"]),
    force: Boolean(args.force),
    includeReviews: args["include-reviews"] !== "false",
    applyScoreAdjustments: Boolean(args["apply-score-adjustments"]),
    refreshDays: Number(args["refresh-days"] ?? 30),
    photoLimit: Math.min(Number(args.photos ?? 5), 10),
  };
}

function readEnv() {
  const envPath = path.join(PROJECT_ROOT, ".env.local");
  const raw = fs.existsSync(envPath) ? fs.readFileSync(envPath, "utf8") : "";
  const get = (key) => {
    const value = raw.match(new RegExp(`^${key}=(.*)$`, "m"))?.[1]?.trim() ?? process.env[key];
    return value?.replace(/^["']|["']$/g, "");
  };
  return {
    supabaseUrl: get("NEXT_PUBLIC_SUPABASE_URL"),
    serviceKey: get("SUPABASE_SERVICE_ROLE_KEY"),
    googleKey: get("GOOGLE_MAPS_API_KEY") || get("NEXT_PUBLIC_GOOGLE_MAPS_API_KEY"),
    useLiveGoogleData: get("USE_LIVE_GOOGLE_DATA"),
    cacheDays: Number(get("GOOGLE_PLACES_CACHE_DAYS") ?? 30),
  };
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function compactHours(hours) {
  const descriptions = hours?.weekdayDescriptions;
  if (!Array.isArray(descriptions) || descriptions.length === 0) return null;

  const openLines = descriptions.filter((line) => !line.toLowerCase().includes("closed"));
  if (openLines.length === 0) return "Closed";

  const firstHours = openLines[0]?.split(": ").slice(1).join(": ");
  const allSame = openLines.every((line) => line.split(": ").slice(1).join(": ") === firstHours);
  if (allSame && firstHours) return `Daily: ${firstHours}`;

  return openLines[0] ?? null;
}

function countRiskSignals(reviews = []) {
  const signals = {
    pricing: 0,
    security: 0,
    closure: 0,
    service: 0,
    total_reviews_checked: 0,
    lowest_review_rating_seen: null,
  };

  for (const review of reviews) {
    const text = [
      review?.text?.text,
      review?.originalText?.text,
    ].filter(Boolean).join(" ").toLowerCase();

    if (!text) continue;
    signals.total_reviews_checked += 1;
    if (typeof review.rating === "number") {
      signals.lowest_review_rating_seen = signals.lowest_review_rating_seen == null
        ? review.rating
        : Math.min(signals.lowest_review_rating_seen, review.rating);
    }

    for (const [bucket, keywords] of Object.entries(RISK_KEYWORDS)) {
      if (keywords.some((keyword) => text.includes(keyword))) {
        signals[bucket] += 1;
      }
    }
  }

  return signals;
}

function buildFlags(place, signals) {
  const flags = new Set();
  const rating = Number(place.rating ?? 0);
  const reviews = Number(place.userRatingCount ?? 0);

  if (place.businessStatus === "CLOSED_PERMANENTLY") flags.add("closed_on_google");
  if (rating >= 4.6 && reviews > 0 && reviews < 20) flags.add("new_unverified");
  if (reviews > 0 && reviews < 10) flags.add("low_review_count");
  if (signals.pricing > 0) flags.add("pricing_complaints");
  if (signals.security > 0) flags.add("security_complaints");
  if (signals.closure > 0) flags.add("closure_mentions");
  if (signals.pricing + signals.security >= 2) flags.add("possible_tourist_trap");

  return [...flags];
}

function photoMediaUrl(photoName, apiKey) {
  if (!photoName) return null;
  const url = new URL(`https://places.googleapis.com/v1/${photoName}/media`);
  url.searchParams.set("maxWidthPx", "1200");
  url.searchParams.set("maxHeightPx", "900");
  url.searchParams.set("key", apiKey);
  return url.toString();
}

async function fetchPlace(placeId, env, includeReviews) {
  const fields = includeReviews
    ? [...DEFAULT_FIELD_MASK, ...REVIEW_FIELD_MASK]
    : DEFAULT_FIELD_MASK;
  const url = new URL(`https://places.googleapis.com/v1/places/${placeId}`);
  url.searchParams.set("languageCode", "en");

  const res = await fetch(url, {
    headers: {
      "X-Goog-Api-Key": env.googleKey,
      "X-Goog-FieldMask": fields.join(","),
      Referer: "https://thainight.co/",
    },
  });

  if (!res.ok) {
    const text = await res.text();
    throw new Error(`Google Places ${res.status}: ${text.slice(0, 240)}`);
  }

  return res.json();
}

async function hasColumn(supabase, column) {
  const { error } = await supabase
    .from("venues")
    .select(column)
    .limit(1);
  return !error;
}

async function maybeCreateRun(supabase, args, hasRunTable) {
  if (!hasRunTable) return null;
  const { data, error } = await supabase
    .from("google_places_enrichment_runs")
    .insert({
      city: args.city ?? null,
      requested_limit: args.limit,
      include_reviews: args.includeReviews,
      apply_score_adjustments: args.applyScoreAdjustments,
      notes: "Started by scripts/enrich-google-places.mjs",
    })
    .select("id")
    .single();
  if (error) return null;
  return data.id;
}

async function finishRun(supabase, runId, stats) {
  if (!runId) return;
  await supabase
    .from("google_places_enrichment_runs")
    .update({
      fetched_count: stats.fetched,
      updated_count: stats.updated,
      skipped_count: stats.skipped,
      error_count: stats.errors,
      finished_at: new Date().toISOString(),
      notes: `Report: data/google-places-enrichment-report.json`,
    })
    .eq("id", runId);
}

function shouldSkip(row, refreshDays, hasEnrichmentColumns) {
  if (!hasEnrichmentColumns || !row.google_last_fetched_at) return false;
  const age = Date.now() - new Date(row.google_last_fetched_at).getTime();
  return age < refreshDays * 24 * 60 * 60 * 1000;
}

async function main() {
  const args = parseArgs();
  const env = readEnv();
  if (!env.supabaseUrl || !env.serviceKey || !env.googleKey) {
    throw new Error("Missing Supabase service key or Google Maps API key in .env.local");
  }

  const liveDisabled = env.useLiveGoogleData === "false";
  if (liveDisabled && !args.force && !args.dryRun) {
    throw new Error("USE_LIVE_GOOGLE_DATA=false. Re-run with --force when you intentionally want to spend Google credits.");
  }

  const supabase = createClient(env.supabaseUrl, env.serviceKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  let query = supabase
    .from("venues")
    .select([
      "id",
      "slug",
      "name",
      "city",
      "area_slug",
      "google_place_id",
      "address",
      "latitude",
      "longitude",
      "phone",
      "website",
      "opening_hours",
      "google_maps_url",
      "insider_tip",
      "score_price_transparency",
      "score_tourist_trap_risk",
    ].join(","))
    .not("google_place_id", "is", null)
    .eq("is_published", true)
    .order("last_verified_at", { ascending: true })
    .range(args.offset, args.offset + args.limit - 1);

  if (args.city) query = query.eq("city", args.city);

  const { data: venues, error } = await query;
  if (error) throw error;

  console.log(`Eligible venues: ${venues.length}`);
  console.log(`Google API mode: ${args.dryRun ? "dry run, no API calls" : "live calls"}${args.force ? " (forced)" : ""}`);
  if (args.dryRun) {
    for (const venue of venues.slice(0, 12)) {
      console.log(`- ${venue.city}/${venue.area_slug}: ${venue.name}`);
    }
    return;
  }

  const hasEnrichmentColumns = await hasColumn(supabase, "google_last_fetched_at");
  const hasRunTable = await hasColumn(supabase, "id")
    .then(async () => {
      const { error: runError } = await supabase.from("google_places_enrichment_runs").select("id").limit(1);
      return !runError;
    });
  const runId = await maybeCreateRun(supabase, args, hasRunTable);

  const stats = { fetched: 0, updated: 0, skipped: 0, errors: 0 };
  const report = [];
  const now = new Date();
  const expiresAt = new Date(now.getTime() + env.cacheDays * 24 * 60 * 60 * 1000).toISOString();

  for (const venue of venues) {
    if (shouldSkip(venue, args.refreshDays, hasEnrichmentColumns) && !args.force) {
      stats.skipped += 1;
      continue;
    }

    try {
      const place = await fetchPlace(venue.google_place_id, env, args.includeReviews);
      stats.fetched += 1;

      const signals = countRiskSignals(place.reviews ?? []);
      const flags = buildFlags(place, signals);
      const photoNames = (place.photos ?? []).map((photo) => photo.name).filter(Boolean).slice(0, args.photoLimit);

      const update = {
        address: place.formattedAddress ?? venue.address,
        latitude: place.location?.latitude ?? venue.latitude,
        longitude: place.location?.longitude ?? venue.longitude,
        phone: place.nationalPhoneNumber ?? venue.phone,
        website: place.websiteUri ?? venue.website,
        opening_hours: compactHours(place.regularOpeningHours) ?? venue.opening_hours,
        opening_hours_json: place.regularOpeningHours ?? null,
        google_maps_url: place.googleMapsUri ?? venue.google_maps_url,
        last_verified_at: now.toISOString(),
        verified_by: "google_places_enrichment",
      };

      if (hasEnrichmentColumns) {
        update.google_rating = place.rating ?? null;
        update.google_user_ratings_total = place.userRatingCount ?? null;
        update.google_last_fetched_at = now.toISOString();
        update.google_cache_expires_at = expiresAt;
        update.google_photo_names = photoNames;
        update.google_review_signals = signals;
        update.data_quality_flags = flags;
        update.static_map_url = place.location
          ? `https://maps.googleapis.com/maps/api/staticmap?center=${place.location.latitude},${place.location.longitude}&zoom=15&size=640x360&scale=2&maptype=roadmap&markers=color:orange%7C${place.location.latitude},${place.location.longitude}&key=${env.googleKey}`
          : null;
      }

      if (args.applyScoreAdjustments) {
        const pricingPenalty = Math.min(signals.pricing * 0.7, 2.0);
        const safetyPenalty = Math.min(signals.security * 0.4, 1.2);
        if (pricingPenalty > 0 && typeof venue.score_price_transparency === "number") {
          update.score_price_transparency = Math.max(1, venue.score_price_transparency - pricingPenalty);
        }
        if (safetyPenalty > 0 && typeof venue.score_tourist_trap_risk === "number") {
          update.score_tourist_trap_risk = Math.min(10, venue.score_tourist_trap_risk + safetyPenalty);
        }
      }

      if (flags.length && !venue.insider_tip) {
        update.insider_tip = `Google review signals flagged ${flags.map((flag) => flag.replace(/_/g, " ")).join(", ")}. ThaiNight should manually verify before featuring.`;
      }

      const { error: updateError } = await supabase
        .from("venues")
        .update(update)
        .eq("id", venue.id);
      if (updateError) throw updateError;

      stats.updated += 1;
      report.push({
        id: venue.id,
        slug: venue.slug,
        name: venue.name,
        city: venue.city,
        google_place_id: venue.google_place_id,
        google_rating: place.rating ?? null,
        google_user_ratings_total: place.userRatingCount ?? null,
        photo_names_found: photoNames.length,
        data_quality_flags: flags,
        review_signals: signals,
        sample_photo_media_url: photoNames[0] ? photoMediaUrl(photoNames[0], env.googleKey).replace(env.googleKey, "GOOGLE_MAPS_API_KEY") : null,
      });

      console.log(`✓ ${stats.updated}/${venues.length} ${venue.city}: ${venue.name}`);
      await sleep(120);
    } catch (err) {
      stats.errors += 1;
      console.error(`✗ ${venue.name}: ${err.message}`);
      report.push({
        id: venue.id,
        slug: venue.slug,
        name: venue.name,
        city: venue.city,
        error: err.message,
      });
    }
  }

  fs.writeFileSync(REPORT_PATH, JSON.stringify({ generated_at: now.toISOString(), args, stats, venues: report }, null, 2));
  await finishRun(supabase, runId, stats);
  console.log(`Done. ${JSON.stringify(stats)}`);
  console.log(`Report written: ${path.relative(PROJECT_ROOT, REPORT_PATH)}`);
}

main().catch((err) => {
  console.error(err.message);
  process.exit(1);
});
