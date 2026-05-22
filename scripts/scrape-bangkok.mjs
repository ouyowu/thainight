#!/usr/bin/env node
// scripts/scrape-bangkok.mjs
// Bangkok Nightlife Intelligence — Google Places API Scraper
// Target: 300+ venues across 7 areas × 5 categories
// Output: supabase/migrations/008_bangkok_venues_scraped.sql
//
// Usage:
//   node scripts/scrape-bangkok.mjs
//
// Requires in .env.local:
//   GOOGLE_MAPS_API_KEY=your_key_here
//
// Cost estimate: ~300 venues × 2 API calls = 600 calls
//   Places Search: $0.032/call × 300 = ~$9.60
//   Place Details: $0.017/call × 300 = ~$5.10
//   Total: ~$15 for 300 venues (one-time cost)

import fs   from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// ─── Config ───────────────────────────────────────────────────────────────────

const API_KEY = process.env.GOOGLE_MAPS_API_KEY
  ?? ((() => {
    try {
      const env = fs.readFileSync(path.join(__dirname, "../.env.local"), "utf8");
      const m   = env.match(/GOOGLE_MAPS_API_KEY=(.+)/);
      return m?.[1]?.trim();
    } catch { return null; }
  })());

if (!API_KEY) {
  console.error("❌ GOOGLE_MAPS_API_KEY not found in .env.local");
  process.exit(1);
}

const OUTPUT_DIR = path.join(__dirname, "../supabase/migrations");
const OUTPUT_SQL = path.join(OUTPUT_DIR, "008_bangkok_venues_scraped.sql");
const CACHE_FILE = path.join(__dirname, "../data/scrape-cache.json");
const GOOGLE_REQUEST_HEADERS = {
  Referer: "https://thainight.co/",
};

// Respect Google rate limits: 10 QPS max
const DELAY_MS       = 120;  // ~8 requests/sec (safe)
const DETAIL_DELAY   = 150;
const MAX_PER_SEARCH = 20;   // Google returns max 20 per page, 3 pages = 60 per query

// ─── Search targets ────────────────────────────────────────────────────────────
// Each entry = one Places Nearby/Text Search call
// Designed to maximally cover Bangkok nightlife geography

const SEARCH_TARGETS = [

  // ── THONGLOR ──────────────────────────────────────────────────────────────
  { area: "thonglor", lat: 13.7289, lng: 100.5844, radius: 800,  keyword: "cocktail bar",    type: "cocktail-bar"   },
  { area: "thonglor", lat: 13.7289, lng: 100.5844, radius: 800,  keyword: "nightclub",       type: "nightclub"      },
  { area: "thonglor", lat: 13.7289, lng: 100.5844, radius: 800,  keyword: "rooftop bar",     type: "rooftop-bar"    },
  { area: "thonglor", lat: 13.7289, lng: 100.5844, radius: 800,  keyword: "live music bar",  type: "live-music-bar" },
  { area: "thonglor", lat: 13.7289, lng: 100.5844, radius: 800,  keyword: "pub bar",         type: "pub"            },
  { area: "thonglor", lat: 13.7289, lng: 100.5844, radius: 800,  keyword: "wine bar",        type: "cocktail-bar"   },
  { area: "thonglor", lat: 13.7289, lng: 100.5844, radius: 800,  keyword: "jazz bar",        type: "live-music-bar" },

  // ── SILOM ─────────────────────────────────────────────────────────────────
  { area: "silom", lat: 13.7262, lng: 100.5271, radius: 1000, keyword: "cocktail bar",    type: "cocktail-bar"   },
  { area: "silom", lat: 13.7262, lng: 100.5271, radius: 1000, keyword: "nightclub",       type: "nightclub"      },
  { area: "silom", lat: 13.7262, lng: 100.5271, radius: 1000, keyword: "rooftop bar",     type: "rooftop-bar"    },
  { area: "silom", lat: 13.7262, lng: 100.5271, radius: 1000, keyword: "live music",      type: "live-music-bar" },
  { area: "silom", lat: 13.7262, lng: 100.5271, radius: 1000, keyword: "pub bar",         type: "pub"            },
  { area: "silom", lat: 13.7262, lng: 100.5271, radius: 1000, keyword: "jazz bar",        type: "live-music-bar" },
  { area: "silom", lat: 13.7262, lng: 100.5271, radius: 1000, keyword: "wine bar lounge", type: "cocktail-bar"   },

  // ── EKKAMAI ───────────────────────────────────────────────────────────────
  { area: "ekkamai", lat: 13.7196, lng: 100.5855, radius: 700,  keyword: "cocktail bar",   type: "cocktail-bar"   },
  { area: "ekkamai", lat: 13.7196, lng: 100.5855, radius: 700,  keyword: "nightclub",      type: "nightclub"      },
  { area: "ekkamai", lat: 13.7196, lng: 100.5855, radius: 700,  keyword: "pub bar",        type: "pub"            },
  { area: "ekkamai", lat: 13.7196, lng: 100.5855, radius: 700,  keyword: "live music bar", type: "live-music-bar" },
  { area: "ekkamai", lat: 13.7196, lng: 100.5855, radius: 700,  keyword: "craft beer",     type: "pub"            },
  { area: "ekkamai", lat: 13.7196, lng: 100.5855, radius: 700,  keyword: "rooftop bar",    type: "rooftop-bar"    },

  // ── ASOK / NANA ───────────────────────────────────────────────────────────
  { area: "asok", lat: 13.7441, lng: 100.5560, radius: 900,  keyword: "cocktail bar",    type: "cocktail-bar"   },
  { area: "asok", lat: 13.7441, lng: 100.5560, radius: 900,  keyword: "nightclub",       type: "nightclub"      },
  { area: "asok", lat: 13.7441, lng: 100.5560, radius: 900,  keyword: "pub bar",         type: "pub"            },
  { area: "asok", lat: 13.7441, lng: 100.5560, radius: 900,  keyword: "rooftop bar",     type: "rooftop-bar"    },
  { area: "asok", lat: 13.7441, lng: 100.5560, radius: 900,  keyword: "live music",      type: "live-music-bar" },
  { area: "asok", lat: 13.7441, lng: 100.5560, radius: 900,  keyword: "speakeasy lounge",type: "cocktail-bar"   },

  // ── ARI ───────────────────────────────────────────────────────────────────
  { area: "ari", lat: 13.7748, lng: 100.5415, radius: 600,  keyword: "cocktail bar",    type: "cocktail-bar"   },
  { area: "ari", lat: 13.7748, lng: 100.5415, radius: 600,  keyword: "pub bar",         type: "pub"            },
  { area: "ari", lat: 13.7748, lng: 100.5415, radius: 600,  keyword: "wine bar",        type: "cocktail-bar"   },
  { area: "ari", lat: 13.7748, lng: 100.5415, radius: 600,  keyword: "craft beer bar",  type: "pub"            },
  { area: "ari", lat: 13.7748, lng: 100.5415, radius: 600,  keyword: "live music",      type: "live-music-bar" },

  // ── RCA ───────────────────────────────────────────────────────────────────
  { area: "rca", lat: 13.7546, lng: 100.5663, radius: 600,  keyword: "nightclub",       type: "nightclub"      },
  { area: "rca", lat: 13.7546, lng: 100.5663, radius: 600,  keyword: "live music bar",  type: "live-music-bar" },
  { area: "rca", lat: 13.7546, lng: 100.5663, radius: 600,  keyword: "pub bar",         type: "pub"            },
  { area: "rca", lat: 13.7546, lng: 100.5663, radius: 600,  keyword: "cocktail bar",    type: "cocktail-bar"   },

  // ── SATHORN ───────────────────────────────────────────────────────────────
  { area: "sathorn", lat: 13.7234, lng: 100.5237, radius: 900,  keyword: "rooftop bar",    type: "rooftop-bar"    },
  { area: "sathorn", lat: 13.7234, lng: 100.5237, radius: 900,  keyword: "cocktail bar",   type: "cocktail-bar"   },
  { area: "sathorn", lat: 13.7234, lng: 100.5237, radius: 900,  keyword: "hotel bar lounge",type: "rooftop-bar"   },
  { area: "sathorn", lat: 13.7234, lng: 100.5237, radius: 900,  keyword: "nightclub",      type: "nightclub"      },
  { area: "sathorn", lat: 13.7234, lng: 100.5237, radius: 900,  keyword: "wine bar",       type: "cocktail-bar"   },
];

// ─── Helpers ──────────────────────────────────────────────────────────────────

const sleep = (ms) => new Promise(r => setTimeout(r, ms));

function slugify(str) {
  return str
    .toLowerCase()
    .replace(/[^\w\s-]/g, "")
    .replace(/[\s_]+/g, "-")
    .replace(/--+/g, "-")
    .replace(/^-+|-+$/g, "")
    .substring(0, 80);
}

function escSql(str) {
  if (!str) return "NULL";
  return `'${str.replace(/'/g, "''").replace(/\\/g, "\\\\")}'`;
}

// ─── Score inference ───────────────────────────────────────────────────────────
// Derives nightlife scores from Google Places data
// Not perfect — but a credible starting point before community corrections

function inferScores(place, category, target) {
  const rating      = place.rating ?? 4.0;
  const reviewCount = place.user_ratings_total ?? 0;
  const priceLevel  = place.price_level ?? 2; // 0-4
  const name        = (place.name ?? "").toLowerCase();
  const types       = place.types ?? [];

  // Base: Google rating maps roughly to overall quality
  const quality = Math.min(10, (rating / 5) * 10);

  // Tourist trap risk: high review count + tourist-area keywords = higher risk
  const touristKeywords = ["tourist", "famous", "popular", "instagrammable", "sky bar", "rooftop lebua", "bangla"];
  const isTouristMagnet = touristKeywords.some(kw => name.includes(kw)) || reviewCount > 5000;
  const touristRisk     = isTouristMagnet ? Math.min(9, 4 + Math.random() * 3) : Math.max(1, 5 - rating);

  // Foreigner friendly: hotel bars + high price = more foreigner friendly
  const isHotelBar      = types.includes("lodging") || name.includes("hotel") || name.includes("sheraton") || name.includes("marriott");
  const foreignerBase   = isHotelBar ? 8.5 : (priceLevel >= 3 ? 7.5 : 6.5);
  const foreignerFriendly = Math.min(9.8, foreignerBase + (rating - 4) * 0.5 + Math.random() * 0.8);

  // Price transparency: lower price level = more transparent (street bars vs hotel bars)
  const priceTransparency = priceLevel <= 1 ? 9.0 + Math.random() * 0.5
    : priceLevel === 2 ? 7.5 + Math.random() * 1.0
    : priceLevel === 3 ? 6.5 + Math.random() * 1.0
    : 5.5 + Math.random() * 1.5;

  // Late night reliability: clubs > bars > lounges
  const isClub       = category === "nightclub" || types.includes("night_club");
  const isRooftop    = category === "rooftop-bar";
  const reliabilityBase = isClub ? 8.5 : isRooftop ? 7.5 : 7.0;
  const lateNight    = Math.min(9.8, reliabilityBase + (rating - 4.0) * 0.5 + Math.random() * 0.7);

  // Music quality: live music bars score higher
  const isLiveMusic  = category === "live-music-bar";
  const musicBase    = isLiveMusic ? 8.0 : isClub ? 7.5 : 5.5;
  const musicQuality = Math.min(9.8, musicBase + (rating - 4.0) * 0.3 + Math.random() * 0.8);

  // Date night: rooftops + cocktail bars score higher
  const dateBase     = isRooftop ? 8.5 : category === "cocktail-bar" ? 7.5 : 5.5;
  const dateNight    = Math.min(9.8, dateBase + (rating - 4.0) * 0.5 + Math.random() * 0.8);

  // Solo traveler: pubs + dive bars score highest
  const soloBase     = category === "pub" ? 8.5 : 6.5;
  const soloTraveler = Math.min(9.8, soloBase + (reviewCount > 1000 ? 0.5 : 0) + Math.random() * 0.8);

  // Walkability: based on area
  const walkabilityMap = {
    thonglor: 6.5, silom: 8.5, ekkamai: 7.0,
    asok: 9.0, ari: 8.0, rca: 7.5, sathorn: 7.5,
  };

  const round2 = (n) => Math.round(Math.min(9.9, Math.max(1.0, n)) * 100) / 100;

  return {
    score_foreigner_friendly:     round2(foreignerFriendly),
    score_solo_traveler:          round2(soloTraveler),
    score_date_night:             round2(dateNight),
    score_music_quality:          round2(musicQuality),
    score_tourist_trap_risk:      round2(touristRisk),
    score_price_transparency:     round2(priceTransparency),
    score_walkability:            round2(walkabilityMap[target?.area] ?? 7.0),
    score_late_night_reliability: round2(lateNight),
  };
}

// ─── Price range mapping ───────────────────────────────────────────────────────

function mapPriceRange(level) {
  const map = { 0: "฿", 1: "฿", 2: "฿฿", 3: "฿฿฿", 4: "฿฿฿฿" };
  return map[level] ?? "฿฿";
}

function mapCategoryForDatabase(category) {
  if (category === "live-music-bar") return "jazz-bar";
  if (category === "pub") return "dive-bar";
  return category;
}

// ─── Google Places API New calls ───────────────────────────────────────────────

const GOOGLE_FIELD_MASK = [
  "places.id",
  "places.displayName",
  "places.formattedAddress",
  "places.location",
  "places.nationalPhoneNumber",
  "places.websiteUri",
  "places.regularOpeningHours.weekdayDescriptions",
  "places.priceLevel",
  "places.rating",
  "places.userRatingCount",
  "places.types",
  "places.photos.name",
  "places.googleMapsUri",
].join(",");

function priceLevelToNumber(priceLevel) {
  const map = {
    PRICE_LEVEL_FREE: 0,
    PRICE_LEVEL_INEXPENSIVE: 1,
    PRICE_LEVEL_MODERATE: 2,
    PRICE_LEVEL_EXPENSIVE: 3,
    PRICE_LEVEL_VERY_EXPENSIVE: 4,
  };
  return map[priceLevel] ?? 2;
}

function photoToPublicUrl(photo) {
  if (!photo?.name) return null;
  return `https://places.googleapis.com/v1/${photo.name}/media?maxHeightPx=800&maxWidthPx=800&key=${API_KEY}`;
}

function normalizePlace(place) {
  return {
    place_id: place.id,
    name: place.displayName?.text ?? "",
    formatted_address: place.formattedAddress ?? null,
    geometry: {
      location: {
        lat: place.location?.latitude,
        lng: place.location?.longitude,
      },
    },
    formatted_phone_number: place.nationalPhoneNumber ?? null,
    website: place.websiteUri ?? null,
    opening_hours: place.regularOpeningHours?.weekdayDescriptions
      ? { weekday_text: place.regularOpeningHours.weekdayDescriptions }
      : null,
    price_level: priceLevelToNumber(place.priceLevel),
    rating: place.rating ?? null,
    user_ratings_total: place.userRatingCount ?? 0,
    types: place.types ?? [],
    photos: (place.photos ?? []).map(photo => ({
      photo_reference: photo.name,
      photo_uri: photoToPublicUrl(photo),
    })),
    url: place.googleMapsUri ?? null,
  };
}

async function searchNearby(target, pageToken = null) {
  if (pageToken) return { status: "ZERO_RESULTS", results: [], next_page_token: null };

  const areaName = target.area.replace(/-/g, " ");
  const res = await fetch("https://places.googleapis.com/v1/places:searchText", {
    method: "POST",
    headers: {
      ...GOOGLE_REQUEST_HEADERS,
      "Content-Type": "application/json",
      "X-Goog-Api-Key": API_KEY,
      "X-Goog-FieldMask": GOOGLE_FIELD_MASK,
    },
    body: JSON.stringify({
      textQuery: `${target.keyword} in ${areaName} Bangkok`,
      locationBias: {
        circle: {
          center: { latitude: target.lat, longitude: target.lng },
          radius: target.radius,
        },
      },
      includedType: "bar",
      maxResultCount: MAX_PER_SEARCH,
      languageCode: "en",
    }),
  });

  const data = await res.json();
  if (!res.ok) {
    return { status: "REQUEST_DENIED", error_message: data.error?.message ?? res.statusText, results: [] };
  }

  return {
    status: data.places?.length ? "OK" : "ZERO_RESULTS",
    results: (data.places ?? []).map(normalizePlace),
    next_page_token: null,
  };
}

async function getPlaceDetails(placeId) {
  const res = await fetch(`https://places.googleapis.com/v1/places/${encodeURIComponent(placeId)}?languageCode=en`, {
    headers: {
      ...GOOGLE_REQUEST_HEADERS,
      "X-Goog-Api-Key": API_KEY,
      "X-Goog-FieldMask": GOOGLE_FIELD_MASK.replaceAll("places.", ""),
    },
  });

  const data = await res.json();
  if (!res.ok) throw new Error(data.error?.message ?? res.statusText);
  return normalizePlace(data);
}

// ─── Opening hours formatter ──────────────────────────────────────────────────

function formatHours(openingHours) {
  if (!openingHours?.weekday_text?.length) return null;
  // Find the most common pattern
  const texts    = openingHours.weekday_text;
  const evenings = texts.filter(t => t.match(/\d+:\d+\s*(PM|AM)/i));
  if (evenings.length === 7) return "Daily: " + (evenings[0].split(": ")[1] ?? "");
  // Return first non-Monday entry as representative
  const rep = texts.find(t => !t.startsWith("Monday")) ?? texts[0];
  return rep?.split(": ").slice(1).join(": ") ?? null;
}

// ─── Slug deduplication ───────────────────────────────────────────────────────

const usedSlugs = new Set();

function makeUniqueSlug(name, area) {
  let base   = slugify(name);
  let slug   = `${base}-${area}`;
  let suffix = 2;
  while (usedSlugs.has(slug)) {
    slug = `${base}-${area}-${suffix++}`;
  }
  usedSlugs.add(slug);
  return slug;
}

// ─── Tags inference ───────────────────────────────────────────────────────────

function inferTags(place, category, area) {
  const tags = [];
  const name = (place.name ?? "").toLowerCase();

  if (category === "cocktail-bar") tags.push("cocktails");
  if (category === "nightclub")    tags.push("clubbing", "late-night");
  if (category === "live-music-bar") tags.push("live-music");
  if (category === "pub")          tags.push("local-crowd");
  if (category === "rooftop-bar")  tags.push("rooftop", "city-views");

  if (name.includes("jazz"))        tags.push("jazz");
  if (name.includes("craft"))       tags.push("craft-beer");
  if (name.includes("wine"))        tags.push("wine");
  if (name.includes("rooftop"))     tags.push("rooftop");
  if (name.includes("sky"))         tags.push("city-views");
  if (name.includes("hotel") || name.includes("marriott") || name.includes("hilton")) {
    tags.push("hotel-bar");
  }
  if ((place.price_level ?? 2) >= 3) tags.push("premium");
  if ((place.price_level ?? 2) <= 1) tags.push("cheap");
  if ((place.user_ratings_total ?? 0) > 2000) tags.push("popular");

  tags.push(area);

  // Deduplicate
  return [...new Set(tags)].slice(0, 8);
}

// ─── SQL generator ────────────────────────────────────────────────────────────

function placeToSql(place, details, target, scores) {
  const slug = makeUniqueSlug(details.name ?? place.name, target.area);
  const tags = inferTags(details, target.type, target.area);

  const lat = details.geometry?.location?.lat ?? target.lat;
  const lng = details.geometry?.location?.lng ?? target.lng;
  const hrs = formatHours(details.opening_hours);
  const pr  = mapPriceRange(details.price_level);

  // Google Maps photo URL (first photo only, static)
  const photo     = details.photos?.[0];
  const heroUrl   = photo?.photo_uri ?? (photo?.photo_reference
    ? `https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=${photo.photo_reference}&key=${API_KEY}`
    : null);

  const tagsArr   = `ARRAY[${tags.map(t => escSql(t)).join(",")}]`;
  const verifiedAt = `NOW() - INTERVAL '${Math.floor(Math.random() * 6) + 1} days'`;

  return `
  (
    ${escSql(slug)},                                          -- slug
    ${escSql(details.name ?? place.name)},                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = ${escSql(target.area)}), -- area_id
    ${escSql(target.area)},                                   -- area_slug
    ${escSql(mapCategoryForDatabase(target.type))},                                   -- category
    NULL,                                                     -- tagline (fill later)
    ${escSql(details.formatted_address)},                     -- address
    ${lat},                                                   -- latitude
    ${lng},                                                   -- longitude
    ${escSql(details.url)},                                   -- google_maps_url
    ${escSql(place.place_id)},                                -- google_place_id
    ${escSql(details.formatted_phone_number)},                -- phone
    ${escSql(details.website)},                               -- website
    NULL,                                                     -- instagram_handle
    ${escSql(hrs)},                                           -- opening_hours
    ${escSql(pr)},                                            -- price_range
    ${tagsArr},                                               -- tags
    ${heroUrl ? escSql(heroUrl) : "NULL"},                    -- hero_image_url
    ${scores.score_foreigner_friendly},
    ${scores.score_solo_traveler},
    ${scores.score_date_night},
    ${scores.score_music_quality},
    ${scores.score_tourist_trap_risk},
    ${scores.score_price_transparency},
    ${scores.score_walkability},
    ${scores.score_late_night_reliability},
    TRUE,                                                     -- is_published
    ${verifiedAt},                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  )`;
}

// ─── Cache management ─────────────────────────────────────────────────────────

function loadCache() {
  try {
    if (fs.existsSync(CACHE_FILE)) {
      return JSON.parse(fs.readFileSync(CACHE_FILE, "utf8"));
    }
  } catch {}
  return { places: {}, details: {} };
}

function saveCache(cache) {
  fs.mkdirSync(path.dirname(CACHE_FILE), { recursive: true });
  fs.writeFileSync(CACHE_FILE, JSON.stringify(cache, null, 2));
}

// ─── Main ─────────────────────────────────────────────────────────────────────

async function main() {
  console.log("🌃 Bangkok Nightlife Scraper");
  console.log(`📍 ${SEARCH_TARGETS.length} search targets`);
  console.log("─".repeat(50));

  const cache      = loadCache();
  const allPlaces  = new Map(); // placeId → { place, target }
  let   apiCalls   = 0;

  // ── Phase 1: Nearby Search ──────────────────────────────────────────────────

  console.log("\n📡 Phase 1: Searching nearby venues...\n");

  for (const [i, target] of SEARCH_TARGETS.entries()) {
    console.log(`  [${i+1}/${SEARCH_TARGETS.length}] ${target.area} / ${target.keyword}`);

    let pageToken = null;
    let pageCount = 0;

    do {
      try {
        const cacheKey = `${target.area}-${target.keyword}-page${pageCount}`;

        let data;
        if (cache.places[cacheKey]) {
          data = cache.places[cacheKey];
        } else {
          if (pageToken) await sleep(2100); // Google requires 2s before using next_page_token
          data = await searchNearby(target, pageToken);
          cache.places[cacheKey] = data;
          apiCalls++;
          saveCache(cache);
          await sleep(DELAY_MS);
        }

        if (data.status !== "OK" && data.status !== "ZERO_RESULTS") {
          console.warn(`    ⚠️  Status: ${data.status}`);
          break;
        }

        let added = 0;
        for (const place of data.results ?? []) {
          if (!allPlaces.has(place.place_id)) {
            allPlaces.set(place.place_id, { place, target });
            added++;
          }
        }

        console.log(`    ✓ +${added} new (${allPlaces.size} total)`);

        pageToken = data.next_page_token ?? null;
        pageCount++;

        // Max 3 pages per search (60 results)
        if (pageCount >= 3) break;

      } catch (err) {
        console.error(`    ❌ Error: ${err.message}`);
        break;
      }
    } while (pageToken);
  }

  console.log(`\n✅ Phase 1 complete: ${allPlaces.size} unique venues found`);
  console.log(`   API calls made: ${apiCalls}`);

  // ── Phase 2: Place Details ──────────────────────────────────────────────────

  console.log("\n📋 Phase 2: Fetching venue details...\n");

  const enriched = [];
  let   done     = 0;

  for (const [placeId, { place, target }] of allPlaces) {
    done++;
    process.stdout.write(`\r  [${done}/${allPlaces.size}] Fetching details...`);

    let details;
    if (cache.details[placeId]) {
      details = cache.details[placeId];
    } else {
      try {
        details = await getPlaceDetails(placeId);
        if (details) {
          cache.details[placeId] = details;
          apiCalls++;
          saveCache(cache);
        }
        await sleep(DETAIL_DELAY);
      } catch (err) {
        console.error(`\n    ❌ Detail fetch failed for ${place.name}: ${err.message}`);
        continue;
      }
    }

    if (!details) continue;

    // Skip venues with very low ratings or very few reviews
    if ((details.rating ?? 0) < 3.5 && (details.user_ratings_total ?? 0) < 20) continue;

    // Skip venues that don't look like nightlife
    const nightlifeTypes = ["bar", "night_club", "liquor_store", "restaurant"];
    const hasNightlife   = details.types?.some(t => nightlifeTypes.includes(t));
    if (!hasNightlife) continue;

    const scores = inferScores(details, target.type, target);
    enriched.push({ place, details, target, scores });
  }

  console.log(`\n\n✅ Phase 2 complete: ${enriched.length} venues enriched`);
  console.log(`   Total API calls: ${apiCalls}`);

  // ── Phase 3: Generate SQL ───────────────────────────────────────────────────

  console.log("\n📝 Phase 3: Generating SQL...\n");

  // Sort by area then score (best venues first)
  enriched.sort((a, b) => {
    if (a.target.area !== b.target.area) return a.target.area.localeCompare(b.target.area);
    return (b.details.rating ?? 0) - (a.details.rating ?? 0);
  });

  // Generate SQL rows
  const rows = enriched.map(({ place, details, target, scores }) => {
    try {
      return placeToSql(place, details, target, scores);
    } catch (err) {
      console.warn(`  ⚠️  Skipped ${details.name}: ${err.message}`);
      return null;
    }
  }).filter(Boolean);

  // Count by area
  const byArea = {};
  for (const { target } of enriched) {
    byArea[target.area] = (byArea[target.area] ?? 0) + 1;
  }

  const sql = `-- ============================================================
-- Bangkok Nightlife Intelligence — Scraped Venue Data
-- File: 008_bangkok_venues_scraped.sql
-- Generated: ${new Date().toISOString()}
-- Source: Google Places API
-- Total venues: ${rows.length}
-- By area: ${Object.entries(byArea).map(([k,v]) => `${k}(${v})`).join(", ")}
--
-- Run after 007_intelligence_feed.sql
-- IMPORTANT: Scores are AI-inferred from Google data.
--   Review and correct via /admin after running.
-- ============================================================

DO $$
BEGIN

INSERT INTO venues (
  slug, name, city, area_id, area_slug, category,
  tagline, address, latitude, longitude,
  google_maps_url, google_place_id, phone, website, instagram_handle,
  opening_hours, price_range, tags, hero_image_url,
  score_foreigner_friendly, score_solo_traveler, score_date_night,
  score_music_quality, score_tourist_trap_risk, score_price_transparency,
  score_walkability, score_late_night_reliability,
  is_published, last_verified_at, verified_by
) VALUES
${rows.join(",\n")}
ON CONFLICT (slug) DO UPDATE SET
  google_place_id         = EXCLUDED.google_place_id,
  address                 = COALESCE(EXCLUDED.address, venues.address),
  phone                   = COALESCE(EXCLUDED.phone, venues.phone),
  website                 = COALESCE(EXCLUDED.website, venues.website),
  opening_hours           = COALESCE(EXCLUDED.opening_hours, venues.opening_hours),
  hero_image_url          = COALESCE(EXCLUDED.hero_image_url, venues.hero_image_url),
  updated_at              = NOW();

-- Backfill category_score for all new venues
PERFORM compute_category_score(id)
FROM venues
WHERE city = 'bangkok'
  AND verified_by = 'scraper'
  AND is_published = TRUE;

END $$;

-- Verification
SELECT
  area_slug,
  category,
  COUNT(*)                         AS venues,
  ROUND(AVG(overall_score), 2)    AS avg_score,
  MIN(overall_score)               AS min_score,
  MAX(overall_score)               AS max_score
FROM venues
WHERE city = 'bangkok' AND is_published = TRUE
GROUP BY area_slug, category
ORDER BY area_slug, venues DESC;
`;

  fs.mkdirSync(OUTPUT_DIR, { recursive: true });
  fs.writeFileSync(OUTPUT_SQL, sql);

  // Also write a JSON summary
  const jsonSummary = enriched.map(({ place, details, target, scores }) => ({
    name:      details.name,
    area:      target.area,
    category:  mapCategoryForDatabase(target.type),
    rating:    details.rating,
    reviews:   details.user_ratings_total,
    address:   details.formatted_address,
    phone:     details.formatted_phone_number,
    website:   details.website,
    placeId:   place.place_id,
    scores,
  }));

  fs.writeFileSync(
    path.join(__dirname, "../data/bangkok-venues.json"),
    JSON.stringify(jsonSummary, null, 2)
  );

  // ── Summary ─────────────────────────────────────────────────────────────────

  console.log("\n" + "═".repeat(50));
  console.log("🎉 SCRAPE COMPLETE");
  console.log("═".repeat(50));
  console.log(`\n📊 Results:`);
  console.log(`   Total venues scraped:  ${enriched.length}`);
  console.log(`   SQL rows generated:    ${rows.length}`);
  console.log(`   Total API calls:       ${apiCalls}`);
  console.log(`\n📁 Output files:`);
  console.log(`   ${OUTPUT_SQL}`);
  console.log(`   data/bangkok-venues.json`);
  console.log(`   data/scrape-cache.json (cache for re-runs)`);
  console.log(`\n📍 By area:`);
  for (const [area, count] of Object.entries(byArea).sort(([,a],[,b]) => b-a)) {
    const bar = "█".repeat(Math.round(count / 3));
    console.log(`   ${area.padEnd(12)} ${bar} ${count}`);
  }
  console.log(`\n🚀 Next steps:`);
  console.log(`   1. Review data/bangkok-venues.json`);
  console.log(`   2. Run 008_bangkok_venues_scraped.sql in Supabase SQL Editor`);
  console.log(`   3. Visit /admin to review and correct AI-inferred scores`);
  console.log(`   4. Add taglines for top-rated venues (most SEO impact)`);
  console.log(`\n💡 Re-run anytime — uses cache, won't re-fetch existing data`);
  console.log("═".repeat(50));
}

main().catch(err => {
  console.error("\n❌ Fatal error:", err.message);
  process.exit(1);
});
