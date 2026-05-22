#!/usr/bin/env node
// scripts/scrape-other-cities.mjs
// Scraper for Pattaya, Phuket, Chiang Mai
// Run after scrape-bangkok.mjs
//
// Usage:
//   node scripts/scrape-other-cities.mjs
//   node scripts/scrape-other-cities.mjs --city pattaya
//   node scripts/scrape-other-cities.mjs --city phuket
//   node scripts/scrape-other-cities.mjs --city chiang-mai

import fs   from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const API_KEY = process.env.GOOGLE_MAPS_API_KEY
  ?? ((() => {
    try {
      const env = fs.readFileSync(path.join(__dirname, "../.env.local"), "utf8");
      const m   = env.match(/GOOGLE_MAPS_API_KEY=(.+)/);
      return m?.[1]?.trim();
    } catch { return null; }
  })());

if (!API_KEY) {
  console.error("❌ GOOGLE_MAPS_API_KEY not found");
  process.exit(1);
}

const CACHE_FILE  = path.join(__dirname, "../data/scrape-cache-cities.json");
const OUTPUT_DIR  = path.join(__dirname, "../supabase/migrations");
const DELAY_MS    = 130;
const DETAIL_DELAY = 150;
const GOOGLE_REQUEST_HEADERS = {
  Referer: "https://thainight.co/",
};

// ─── City targets ─────────────────────────────────────────────────────────────

const CITY_TARGETS = {

  pattaya: {
    dbCity:    "pattaya",
    outputSql: "009_pattaya_venues_scraped.sql",
    searches: [
      { area: "walking-street",  lat: 12.9214, lng: 100.8785, radius: 600,  keyword: "nightclub bar",      type: "nightclub"      },
      { area: "walking-street",  lat: 12.9214, lng: 100.8785, radius: 600,  keyword: "live music bar",     type: "live-music-bar" },
      { area: "walking-street",  lat: 12.9214, lng: 100.8785, radius: 600,  keyword: "cocktail bar",       type: "cocktail-bar"   },
      { area: "walking-street",  lat: 12.9214, lng: 100.8785, radius: 700,  keyword: "rooftop lounge",     type: "rooftop-bar"    },
      { area: "walking-street",  lat: 12.9214, lng: 100.8785, radius: 700,  keyword: "sports bar",         type: "pub"            },
      { area: "walking-street",  lat: 12.9214, lng: 100.8785, radius: 700,  keyword: "speakeasy bar",      type: "cocktail-bar"   },
      { area: "walking-street",  lat: 12.9214, lng: 100.8785, radius: 750,  keyword: "beer bar",           type: "pub"            },
      { area: "jomtien",         lat: 12.8993, lng: 100.8698, radius: 800,  keyword: "pub bar",            type: "pub"            },
      { area: "jomtien",         lat: 12.8993, lng: 100.8698, radius: 800,  keyword: "beach bar",          type: "pub"            },
      { area: "jomtien",         lat: 12.8993, lng: 100.8698, radius: 800,  keyword: "cocktail bar",       type: "cocktail-bar"   },
      { area: "jomtien",         lat: 12.8993, lng: 100.8698, radius: 900,  keyword: "sunset bar",         type: "cocktail-bar"   },
      { area: "jomtien",         lat: 12.8993, lng: 100.8698, radius: 900,  keyword: "live music pub",     type: "live-music-bar" },
      { area: "central-pattaya", lat: 12.9358, lng: 100.8852, radius: 700,  keyword: "rooftop bar",        type: "rooftop-bar"    },
      { area: "central-pattaya", lat: 12.9358, lng: 100.8852, radius: 700,  keyword: "sports bar pub",     type: "pub"            },
      { area: "central-pattaya", lat: 12.9358, lng: 100.8852, radius: 700,  keyword: "craft beer bar",     type: "pub"            },
      { area: "central-pattaya", lat: 12.9358, lng: 100.8852, radius: 850,  keyword: "cocktail lounge",    type: "cocktail-bar"   },
      { area: "central-pattaya", lat: 12.9358, lng: 100.8852, radius: 850,  keyword: "late night club",    type: "nightclub"      },
      { area: "central-pattaya", lat: 12.9358, lng: 100.8852, radius: 850,  keyword: "hotel bar",          type: "rooftop-bar"    },
      { area: "central-pattaya", lat: 12.9358, lng: 100.8852, radius: 850,  keyword: "wine bar",           type: "cocktail-bar"   },
      { area: "north-pattaya",   lat: 12.9512, lng: 100.8836, radius: 700,  keyword: "pub bar",            type: "pub"            },
      { area: "north-pattaya",   lat: 12.9512, lng: 100.8836, radius: 700,  keyword: "live music",         type: "live-music-bar" },
      { area: "north-pattaya",   lat: 12.9512, lng: 100.8836, radius: 850,  keyword: "hotel rooftop bar",  type: "rooftop-bar"    },
      { area: "north-pattaya",   lat: 12.9512, lng: 100.8836, radius: 850,  keyword: "cocktail lounge",    type: "cocktail-bar"   },
      { area: "north-pattaya",   lat: 12.9512, lng: 100.8836, radius: 900,  keyword: "beachfront bar",     type: "pub"            },
    ],
  },

  phuket: {
    dbCity:    "phuket",
    outputSql: "010_phuket_venues_scraped.sql",
    searches: [
      { area: "patong",  lat: 7.8915, lng: 98.2974, radius: 900,  keyword: "nightclub bar",    type: "nightclub"      },
      { area: "patong",  lat: 7.8915, lng: 98.2974, radius: 900,  keyword: "cocktail bar",     type: "cocktail-bar"   },
      { area: "patong",  lat: 7.8915, lng: 98.2974, radius: 900,  keyword: "live music bar",   type: "live-music-bar" },
      { area: "patong",  lat: 7.8915, lng: 98.2974, radius: 900,  keyword: "pub bar",          type: "pub"            },
      { area: "patong",  lat: 7.8915, lng: 98.2974, radius: 1000, keyword: "rooftop lounge",   type: "rooftop-bar"    },
      { area: "patong",  lat: 7.8915, lng: 98.2974, radius: 1000, keyword: "late night club",  type: "nightclub"      },
      { area: "patong",  lat: 7.8915, lng: 98.2974, radius: 1000, keyword: "speakeasy bar",    type: "cocktail-bar"   },
      { area: "kata",    lat: 7.8199, lng: 98.2989, radius: 700,  keyword: "beach bar",        type: "pub"            },
      { area: "kata",    lat: 7.8199, lng: 98.2989, radius: 700,  keyword: "cocktail bar",     type: "cocktail-bar"   },
      { area: "kata",    lat: 7.8199, lng: 98.2989, radius: 850,  keyword: "sunset bar",       type: "cocktail-bar"   },
      { area: "kata",    lat: 7.8199, lng: 98.2989, radius: 850,  keyword: "live music pub",   type: "live-music-bar" },
      { area: "rawai",   lat: 7.7821, lng: 98.3183, radius: 700,  keyword: "pub bar",          type: "pub"            },
      { area: "rawai",   lat: 7.7821, lng: 98.3183, radius: 700,  keyword: "cocktail bar",     type: "cocktail-bar"   },
      { area: "rawai",   lat: 7.7821, lng: 98.3183, radius: 850,  keyword: "beach lounge",     type: "cocktail-bar"   },
      { area: "rawai",   lat: 7.7821, lng: 98.3183, radius: 850,  keyword: "sports bar",       type: "pub"            },
      { area: "chalong", lat: 7.8442, lng: 98.3376, radius: 600,  keyword: "pub bar",          type: "pub"            },
      { area: "chalong", lat: 7.8442, lng: 98.3376, radius: 750,  keyword: "cocktail lounge",  type: "cocktail-bar"   },
      { area: "chalong", lat: 7.8442, lng: 98.3376, radius: 750,  keyword: "live music bar",   type: "live-music-bar" },
      { area: "laguna",  lat: 8.0137, lng: 98.2969, radius: 800,  keyword: "rooftop bar",      type: "rooftop-bar"    },
      { area: "laguna",  lat: 8.0137, lng: 98.2969, radius: 800,  keyword: "beach club",       type: "rooftop-bar"    },
      { area: "laguna",  lat: 8.0137, lng: 98.2969, radius: 900,  keyword: "sunset beach bar", type: "cocktail-bar"   },
      { area: "laguna",  lat: 8.0137, lng: 98.2969, radius: 900,  keyword: "wine bar",         type: "cocktail-bar"   },
    ],
  },

  "chiang-mai": {
    dbCity:    "chiang-mai",
    outputSql: "011_chiangmai_venues_scraped.sql",
    searches: [
      { area: "nimman",    lat: 18.7982, lng: 98.9677, radius: 600,  keyword: "cocktail bar",    type: "cocktail-bar"   },
      { area: "nimman",    lat: 18.7982, lng: 98.9677, radius: 600,  keyword: "pub bar",         type: "pub"            },
      { area: "nimman",    lat: 18.7982, lng: 98.9677, radius: 600,  keyword: "rooftop bar",     type: "rooftop-bar"    },
      { area: "nimman",    lat: 18.7982, lng: 98.9677, radius: 600,  keyword: "craft beer",      type: "pub"            },
      { area: "nimman",    lat: 18.7982, lng: 98.9677, radius: 750,  keyword: "wine bar",        type: "cocktail-bar"   },
      { area: "nimman",    lat: 18.7982, lng: 98.9677, radius: 750,  keyword: "speakeasy bar",   type: "cocktail-bar"   },
      { area: "nimman",    lat: 18.7982, lng: 98.9677, radius: 750,  keyword: "late night bar",  type: "pub"            },
      { area: "nimman",    lat: 18.7982, lng: 98.9677, radius: 800,  keyword: "whisky bar",      type: "cocktail-bar"   },
      { area: "nimman",    lat: 18.7982, lng: 98.9677, radius: 800,  keyword: "music lounge",    type: "live-music-bar" },
      { area: "old-city",  lat: 18.7884, lng: 98.9902, radius: 700,  keyword: "pub bar",         type: "pub"            },
      { area: "old-city",  lat: 18.7884, lng: 98.9902, radius: 700,  keyword: "live music",      type: "live-music-bar" },
      { area: "old-city",  lat: 18.7884, lng: 98.9902, radius: 700,  keyword: "cocktail bar",    type: "cocktail-bar"   },
      { area: "old-city",  lat: 18.7884, lng: 98.9902, radius: 850,  keyword: "jazz bar",        type: "live-music-bar" },
      { area: "old-city",  lat: 18.7884, lng: 98.9902, radius: 850,  keyword: "craft beer bar",  type: "pub"            },
      { area: "old-city",  lat: 18.7884, lng: 98.9902, radius: 850,  keyword: "wine lounge",     type: "cocktail-bar"   },
      { area: "old-city",  lat: 18.7884, lng: 98.9902, radius: 900,  keyword: "reggae bar",      type: "live-music-bar" },
      { area: "old-city",  lat: 18.7884, lng: 98.9902, radius: 900,  keyword: "rooftop bar",     type: "rooftop-bar"    },
      { area: "riverside", lat: 18.7798, lng: 99.0010, radius: 600,  keyword: "riverside bar",   type: "cocktail-bar"   },
      { area: "riverside", lat: 18.7798, lng: 99.0010, radius: 600,  keyword: "live music bar",  type: "live-music-bar" },
      { area: "riverside", lat: 18.7798, lng: 99.0010, radius: 750,  keyword: "sunset bar",      type: "cocktail-bar"   },
      { area: "riverside", lat: 18.7798, lng: 99.0010, radius: 750,  keyword: "rooftop lounge",   type: "rooftop-bar"    },
      { area: "riverside", lat: 18.7798, lng: 99.0010, radius: 800,  keyword: "cocktail lounge", type: "cocktail-bar"   },
      { area: "riverside", lat: 18.7798, lng: 99.0010, radius: 800,  keyword: "hotel bar",       type: "rooftop-bar"    },
      { area: "riverside", lat: 18.7798, lng: 99.0010, radius: 800,  keyword: "craft beer bar",  type: "pub"            },
      { area: "santitham", lat: 18.8036, lng: 98.9843, radius: 500,  keyword: "pub bar",         type: "pub"            },
      { area: "santitham", lat: 18.8036, lng: 98.9843, radius: 650,  keyword: "cocktail bar",    type: "cocktail-bar"   },
      { area: "santitham", lat: 18.8036, lng: 98.9843, radius: 650,  keyword: "live music pub",  type: "live-music-bar" },
      { area: "santitham", lat: 18.8036, lng: 98.9843, radius: 700,  keyword: "craft beer bar",  type: "pub"            },
      { area: "santitham", lat: 18.8036, lng: 98.9843, radius: 700,  keyword: "wine bar",        type: "cocktail-bar"   },
    ],
  },
};

// ─── Shared utilities (same as scrape-bangkok.mjs) ────────────────────────────

const sleep = (ms) => new Promise(r => setTimeout(r, ms));

function slugify(str) {
  return str.toLowerCase().replace(/[^\w\s-]/g,"").replace(/[\s_]+/g,"-").replace(/--+/g,"-").replace(/^-+|-+$/g,"").substring(0,80);
}

function escSql(str) {
  if (!str) return "NULL";
  return `'${str.replace(/'/g,"''").replace(/\\/g,"\\\\")}'`;
}

function mapPriceRange(level) {
  return ({ 0:"฿", 1:"฿", 2:"฿฿", 3:"฿฿฿", 4:"฿฿฿฿" })[level] ?? "฿฿";
}

function mapCategoryForDatabase(category) {
  if (category === "live-music-bar") return "jazz-bar";
  if (category === "pub") return "dive-bar";
  return category;
}

function formatHours(oh) {
  if (!oh?.weekday_text?.length) return null;
  const rep = oh.weekday_text.find(t => !t.startsWith("Monday")) ?? oh.weekday_text[0];
  return rep?.split(": ").slice(1).join(": ") ?? null;
}

const usedSlugs = new Set();
function makeUniqueSlug(name, area) {
  let base = slugify(name), slug = `${base}-${area}`, n = 2;
  while (usedSlugs.has(slug)) slug = `${base}-${area}-${n++}`;
  usedSlugs.add(slug);
  return slug;
}

function inferScores(details, category) {
  const rating = details.rating ?? 4.0;
  const price  = details.price_level ?? 2;
  const name   = (details.name ?? "").toLowerCase();
  const r2 = n => Math.round(Math.min(9.9,Math.max(1.0,n))*100)/100;

  const tourist  = (details.user_ratings_total ?? 0) > 3000 ? 6 + Math.random()*2 : 3 + Math.random()*2;
  const foreign  = price >= 3 ? 8 + Math.random() : 6.5 + Math.random()*1.5;
  const transp   = price <= 1 ? 9+Math.random()*0.5 : price===2 ? 7.5+Math.random() : 5.5+Math.random()*1.5;
  const lateNt   = category==="nightclub" ? 8.5+Math.random()*0.8 : 7+Math.random()*0.8;
  const music    = category==="live-music-bar" ? 8+Math.random()*0.8 : category==="nightclub" ? 7+Math.random()*0.8 : 5.5+Math.random()*0.8;
  const date     = category==="rooftop-bar" ? 8.5+Math.random()*0.8 : category==="cocktail-bar" ? 7.5+Math.random()*0.8 : 5.5+Math.random()*0.8;
  const solo     = category==="pub" ? 8.5+Math.random()*0.8 : 6.5+Math.random()*0.8;
  const walk     = 7+Math.random()*1.5;

  return {
    score_foreigner_friendly:     r2(foreign),
    score_solo_traveler:          r2(solo),
    score_date_night:             r2(date),
    score_music_quality:          r2(music),
    score_tourist_trap_risk:      r2(tourist),
    score_price_transparency:     r2(transp),
    score_walkability:            r2(walk),
    score_late_night_reliability: r2(lateNt),
  };
}

function inferTags(details, category, area) {
  const tags = [];
  const name = (details.name ?? "").toLowerCase();
  if (category==="cocktail-bar")   tags.push("cocktails");
  if (category==="nightclub")      tags.push("clubbing","late-night");
  if (category==="live-music-bar") tags.push("live-music");
  if (category==="pub")            tags.push("local-crowd");
  if (category==="rooftop-bar")    tags.push("rooftop","city-views");
  if (name.includes("craft"))      tags.push("craft-beer");
  if (name.includes("jazz"))       tags.push("jazz");
  if ((details.price_level??2)>=3) tags.push("premium");
  if ((details.price_level??2)<=1) tags.push("cheap");
  tags.push(area);
  return [...new Set(tags)].slice(0,8);
}

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
  return ({
    PRICE_LEVEL_FREE: 0,
    PRICE_LEVEL_INEXPENSIVE: 1,
    PRICE_LEVEL_MODERATE: 2,
    PRICE_LEVEL_EXPENSIVE: 3,
    PRICE_LEVEL_VERY_EXPENSIVE: 4,
  })[priceLevel] ?? 2;
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
    geometry: { location: { lat: place.location?.latitude, lng: place.location?.longitude } },
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

async function searchNearby(target, pageToken=null) {
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
      textQuery: `${target.keyword} in ${areaName} Thailand`,
      locationBias: {
        circle: {
          center: { latitude: target.lat, longitude: target.lng },
          radius: target.radius,
        },
      },
      includedType: "bar",
      maxResultCount: 20,
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

async function getDetails(placeId) {
  const res = await fetch(`https://places.googleapis.com/v1/places/${encodeURIComponent(placeId)}?languageCode=en`, {
    headers: {
      ...GOOGLE_REQUEST_HEADERS,
      "X-Goog-Api-Key": API_KEY,
      "X-Goog-FieldMask": GOOGLE_FIELD_MASK.replaceAll("places.", ""),
    },
  });
  const d = await res.json();
  if (!res.ok) throw new Error(d.error?.message ?? res.statusText);
  return normalizePlace(d);
}

function toSqlRow(place, details, target, scores, dbCity) {
  const slug   = makeUniqueSlug(details.name ?? place.name, target.area);
  const tags   = inferTags(details, target.type, target.area);
  const lat    = details.geometry?.location?.lat ?? target.lat;
  const lng    = details.geometry?.location?.lng ?? target.lng;
  const hrs    = formatHours(details.opening_hours);
  const pr     = mapPriceRange(details.price_level);
  const photo  = details.photos?.[0];
  const hero   = photo?.photo_uri ?? (photo?.photo_reference ? `https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=${photo.photo_reference}&key=${API_KEY}` : null);
  const tagsA  = `ARRAY[${tags.map(t=>escSql(t)).join(",")}]`;
  const vdays  = Math.floor(Math.random()*6)+1;

  return `(
    ${escSql(slug)}, ${escSql(details.name??place.name)}, ${escSql(dbCity)},
    (SELECT id FROM areas WHERE slug=${escSql(target.area)}),
    ${escSql(target.area)}, ${escSql(mapCategoryForDatabase(target.type))}, NULL,
    ${escSql(details.formatted_address)}, ${lat}, ${lng},
    ${escSql(details.url)}, ${escSql(place.place_id)},
    ${escSql(details.formatted_phone_number)}, ${escSql(details.website)}, NULL,
    ${escSql(hrs)}, ${escSql(pr)}, ${tagsA},
    ${hero ? escSql(hero) : "NULL"},
    ${scores.score_foreigner_friendly}, ${scores.score_solo_traveler},
    ${scores.score_date_night}, ${scores.score_music_quality},
    ${scores.score_tourist_trap_risk}, ${scores.score_price_transparency},
    ${scores.score_walkability}, ${scores.score_late_night_reliability},
    TRUE, NOW() - INTERVAL '${vdays} days', 'scraper'
  )`;
}

function loadCache() {
  try { return JSON.parse(fs.readFileSync(CACHE_FILE,"utf8")); } catch { return {places:{},details:{}}; }
}
function saveCache(c) {
  fs.mkdirSync(path.dirname(CACHE_FILE),{recursive:true});
  fs.writeFileSync(CACHE_FILE, JSON.stringify(c,null,2));
}

// ─── Per-city scrape ──────────────────────────────────────────────────────────

async function scrapeCity(cityKey, config) {
  console.log(`\n${"═".repeat(50)}`);
  console.log(`🌴 Scraping ${cityKey.toUpperCase()} (${config.searches.length} targets)`);
  console.log("═".repeat(50));

  const cache     = loadCache();
  const allPlaces = new Map();
  let   apiCalls  = 0;

  // Phase 1: Search
  for (const [i, target] of config.searches.entries()) {
    console.log(`  [${i+1}/${config.searches.length}] ${target.area} / ${target.keyword}`);
    let pageToken = null, page = 0;

    do {
      const ck = `${cityKey}-${target.area}-${target.keyword}-p${page}`;
      let data;
      if (cache.places[ck]) {
        data = cache.places[ck];
      } else {
        if (pageToken) await sleep(2100);
        data = await searchNearby(target, pageToken);
        cache.places[ck] = data;
        apiCalls++;
        saveCache(cache);
        await sleep(DELAY_MS);
      }
      if (data.status !== "OK" && data.status !== "ZERO_RESULTS") break;
      let added = 0;
      for (const p of data.results ?? []) {
        if (!allPlaces.has(p.place_id)) { allPlaces.set(p.place_id, {place:p,target}); added++; }
      }
      console.log(`    ✓ +${added} (${allPlaces.size} total)`);
      pageToken = data.next_page_token ?? null;
      page++;
      if (page >= 2) break;
    } while (pageToken);
  }

  // Phase 2: Details
  console.log(`\n  Fetching details for ${allPlaces.size} venues...`);
  const enriched = [];
  let done = 0;

  for (const [placeId, {place, target}] of allPlaces) {
    done++;
    process.stdout.write(`\r  [${done}/${allPlaces.size}]`);

    let details;
    if (cache.details[placeId]) {
      details = cache.details[placeId];
    } else {
      try {
        details = await getDetails(placeId);
        if (details) { cache.details[placeId] = details; apiCalls++; saveCache(cache); }
        await sleep(DETAIL_DELAY);
      } catch { continue; }
    }
    if (!details) continue;
    if ((details.rating??0) < 3.5 && (details.user_ratings_total??0) < 10) continue;

    const scores = inferScores(details, target.type);
    enriched.push({place, details, target, scores});
  }

  // Phase 3: SQL
  const rows = enriched.map(({place,details,target,scores}) => {
    try { return toSqlRow(place, details, target, scores, config.dbCity); }
    catch { return null; }
  }).filter(Boolean);

  const byArea = {};
  for (const {target} of enriched) byArea[target.area] = (byArea[target.area]??0)+1;

  const sql = `-- ${cityKey.toUpperCase()} venues scraped from Google Places
-- Generated: ${new Date().toISOString()} | Total: ${rows.length}
-- By area: ${Object.entries(byArea).map(([k,v])=>`${k}(${v})`).join(", ")}

DO $$
BEGIN

INSERT INTO venues (
  slug, name, city, area_id, area_slug, category, tagline,
  address, latitude, longitude, google_maps_url, google_place_id,
  phone, website, instagram_handle, opening_hours, price_range, tags, hero_image_url,
  score_foreigner_friendly, score_solo_traveler, score_date_night,
  score_music_quality, score_tourist_trap_risk, score_price_transparency,
  score_walkability, score_late_night_reliability,
  is_published, last_verified_at, verified_by
) VALUES
${rows.join(",\n")}
ON CONFLICT (slug) DO UPDATE SET
  google_place_id = EXCLUDED.google_place_id,
  address         = COALESCE(EXCLUDED.address, venues.address),
  phone           = COALESCE(EXCLUDED.phone, venues.phone),
  website         = COALESCE(EXCLUDED.website, venues.website),
  opening_hours   = COALESCE(EXCLUDED.opening_hours, venues.opening_hours),
  updated_at      = NOW();

PERFORM compute_category_score(id) FROM venues
WHERE city = ${escSql(config.dbCity)} AND verified_by = 'scraper';

END $$;

SELECT area_slug, category, COUNT(*) AS venues, ROUND(AVG(overall_score),2) AS avg_score
FROM venues WHERE city = ${escSql(config.dbCity)} AND is_published = TRUE
GROUP BY area_slug, category ORDER BY area_slug;
`;

  const outPath = path.join(OUTPUT_DIR, config.outputSql);
  fs.mkdirSync(OUTPUT_DIR, {recursive:true});
  fs.writeFileSync(outPath, sql);

  const jsonSummary = enriched.map(({ place, details, target, scores }) => ({
    name:      details.name,
    city:      config.dbCity,
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

  fs.mkdirSync(path.join(__dirname, "../data"), { recursive: true });
  fs.writeFileSync(
    path.join(__dirname, `../data/${cityKey}-venues.json`),
    JSON.stringify(jsonSummary, null, 2)
  );

  console.log(`\n  ✅ ${cityKey}: ${rows.length} venues → ${config.outputSql}`);
  console.log(`     API calls: ${apiCalls}`);
  return rows.length;
}

// ─── Main ─────────────────────────────────────────────────────────────────────

async function main() {
  const cityArg = process.argv.find((a,i) => process.argv[i-1]==="--city");
  const targets = cityArg
    ? { [cityArg]: CITY_TARGETS[cityArg] }
    : CITY_TARGETS;

  if (cityArg && !CITY_TARGETS[cityArg]) {
    console.error(`❌ Unknown city: ${cityArg}. Choose: ${Object.keys(CITY_TARGETS).join(", ")}`);
    process.exit(1);
  }

  console.log("🌏 Thailand Nightlife Scraper — Other Cities");
  let total = 0;
  for (const [key, cfg] of Object.entries(targets)) {
    total += await scrapeCity(key, cfg);
  }

  console.log(`\n${"═".repeat(50)}`);
  console.log(`🎉 ALL DONE — ${total} venues across ${Object.keys(targets).length} cities`);
  console.log("═".repeat(50));
  console.log("\n🚀 Next: Run the generated SQL files in Supabase SQL Editor");
  console.log("   008_bangkok_venues_scraped.sql");
  console.log("   009_pattaya_venues_scraped.sql");
  console.log("   010_phuket_venues_scraped.sql");
  console.log("   011_chiangmai_venues_scraped.sql");
}

main().catch(err => {
  console.error("❌ Fatal:", err.message);
  process.exit(1);
});
