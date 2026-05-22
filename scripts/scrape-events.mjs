#!/usr/bin/env node
// Context: ThaiNight Events Intel | May 2026 | Allowed public event pages -> reviewed homepage flyers.
// Imports event pages only from allowed sources and preserves source attribution.

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { createClient } from "@supabase/supabase-js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, "..");
const DRY_RUN = process.argv.includes("--dry-run");
const MAX_PHANGAN_EVENTS = Number(process.env.EVENT_SCRAPE_LIMIT ?? 60);
const REQUEST_DELAY_MS = Number(process.env.EVENT_SCRAPE_DELAY_MS ?? 450);

const SOURCE_PAGES = [
  "https://phangan.events/bangkok/",
];

const FALLBACK_PHANGAN_EVENT_URLS = [
  "https://phangan.events/events/rah-tah-tah-at-sing-sing-theater/",
  "https://phangan.events/events/radical-roots-at-siwilai-radical-club/",
  "https://phangan.events/events/lucid-dreams-at-baccarat-bangkok/",
  "https://phangan.events/events/melt-livehouse/",
  "https://phangan.events/events/emoncloud-vol-8/",
  "https://phangan.events/events/maurice-fulton-at-bar-temp/",
  "https://phangan.events/events/onfaya-at-baccarat/",
  "https://phangan.events/events/upper-house-presents-kaku/",
  "https://phangan.events/events/train-night-market-ratchada-grand-opening/",
  "https://phangan.events/events/dub-side-of-the-river-2-at-bangkok-island/",
  "https://phangan.events/events/warehouse-flea-market-bangkok/",
  "https://phangan.events/events/alex-fischer-at-bar-yard/",
  "https://phangan.events/events/hard-techno-bangkok-at-subwerk-club-4/",
  "https://phangan.events/events/pure-technoreunion/",
  "https://phangan.events/events/who-jze-at-bar-temp-2/",
  "https://phangan.events/events/goja-friday-at-goja/",
  "https://phangan.events/events/baba-loop-takeover-at-apt-101/",
  "https://phangan.events/events/sacristy-presents-eve/",
  "https://phangan.events/events/hiro-at-mustache-bangkok/",
  "https://phangan.events/events/inakoma-at-amnesia-bangkok-with-hard-techno/",
  "https://phangan.events/events/madstash-pool-party/",
  "https://phangan.events/events/house-groove/",
  "https://phangan.events/events/tranceforma-syncronize/",
  "https://phangan.events/events/mo-shinfish-alex-zaldua-at-12-x-12/",
  "https://phangan.events/events/baile/",
  "https://phangan.events/events/hard-techno-bangkok-21/",
  "https://phangan.events/events/the-underground-sound-vol-6-at-bloq-bangkok/",
  "https://phangan.events/events/yoppa-lounge-at-yoshi-bar/",
  "https://phangan.events/events/time-traveling-at-horn/",
  "https://phangan.events/events/lobomiro-at-mustache-bangkok/",
  "https://phangan.events/events/berlin-bangkok-rim-x-minax/",
  "https://phangan.events/events/who/",
  "https://phangan.events/events/resonate-vol-2/",
  "https://phangan.events/events/tann-at-amnesia-bangkok/",
  "https://phangan.events/events/takky-at-kangkao/",
  "https://phangan.events/events/gegar-nusantara/",
  "https://phangan.events/events/sian-at-baccarat/",
  "https://phangan.events/events/parity-at-bar-temp/",
  "https://phangan.events/events/ben-rau-at-apt-101/",
  "https://phangan.events/events/shogun-vol-2-at-bloq/",
  "https://phangan.events/events/berg-at-veyla/",
  "https://phangan.events/events/loop-market-vol-01/",
  "https://phangan.events/events/bangkok-satellite/",
];

const EVENTPOP_SEEDS = [
  "https://www.eventpop.me/e/149805",
  "https://www.eventpop.me/e/150466/pickwicksmjnight",
  "https://www.eventpop.me/e/141181",
];

const MEGATIX_SEEDS = [
  "https://megatix.in.th/events/inakoma-x-berlin-bangkok-house-techno",
  "https://megatix.in.th/events/amazonia-may-2026",
  "https://megatix.in.th/events/resonate-rooftop-party",
  "https://megatix.in.th/events/smyliek-friends-bloq-bangkok",
];

const VENUE_OFFICIAL_SEEDS = [
  "https://www.madstash.co/events-1/mad-stash-westin-pool-party-sat-16-may-2026",
];

const RA_SEEDS = [
  "https://ra.co/events/2436091",
  "https://ra.co/events/2437341",
  "https://ra.co/events/2421882",
  "https://ra.co/events/2425606",
];

const MANUAL_SEEDS = (process.env.EVENT_MANUAL_SEEDS ?? "")
  .split(",")
  .map((url) => url.trim())
  .filter(Boolean);

const AUTO_IMPORT_HOSTS = new Set(
  (process.env.EVENT_AUTO_IMPORT_HOSTS ?? "phangan.events,www.eventpop.me,eventpop.me,megatix.in.th,www.megatix.in.th,www.madstash.co,madstash.co,ra.co,www.ra.co,it.ra.co")
    .split(",")
    .map((host) => host.trim().toLowerCase())
    .filter(Boolean)
);

const MANUAL_REVIEW_HOSTS = new Set(["ra.co", "www.ra.co", "eventpop.me", "www.eventpop.me"]);

function readEnv() {
  const raw = fs.readFileSync(path.join(ROOT, ".env.local"), "utf8");
  const get = (key) => raw.match(new RegExp(`^${key}=(.*)$`, "m"))?.[1]?.trim().replace(/^["']|["']$/g, "");
  return {
    url: get("NEXT_PUBLIC_SUPABASE_URL"),
    serviceKey: get("SUPABASE_SERVICE_ROLE_KEY"),
  };
}

function decodeHtml(value = "") {
  return value
    .replace(/&amp;/g, "&")
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&#x27;/g, "'")
    .replace(/&#x2F;/g, "/")
    .replace(/&#(\d+);/g, (_, code) => String.fromCharCode(Number(code)))
    .replace(/&#x([0-9a-f]+);/gi, (_, code) => String.fromCharCode(parseInt(code, 16)))
    .replace(/&nbsp;/g, " ")
    .replace(/&ndash;|&mdash;/g, "-")
    .replace(/<[^>]*>/g, " ")
    .replace(/\s+/g, " ")
    .trim();
}

function normalizeTitle(title) {
  return decodeHtml(title)
    .replace(/^Eventpop\s*\|\s*/i, "")
    .replace(/\s*[|·-]\s*(phangan\.events|Eventpop|Resident Advisor|RA)\s*$/i, "")
    .slice(0, 160)
    .trim();
}

function normalizeEventDate(value) {
  if (!value) return null;
  let text = String(value).trim();
  text = text.replace(/T(\d{1,2}):(\d{2})([+-])(\d{1,2}):?(\d{2})?$/, (_, hour, minute, sign, tzHour, tzMinute) => {
    return `T${hour.padStart(2, "0")}:${minute}${sign}${tzHour.padStart(2, "0")}:${tzMinute ?? "00"}`;
  });
  text = text.replace(/^(\d{4})-(\d{1,2})-(\d{1,2})T/, (_, year, month, day) => {
    return `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}T`;
  });
  const date = new Date(text);
  return Number.isNaN(date.getTime()) ? null : date.toISOString();
}

function dateFromText(text) {
  const match = text.match(/(\d{1,2})\s+(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*\s+(20\d{2})\s+at\s+(\d{1,2}):(\d{2})/i);
  if (!match) return null;
  const [, day, monthName, year, hour, minute] = match;
  const month = {
    jan: 0, feb: 1, mar: 2, apr: 3, may: 4, jun: 5,
    jul: 6, aug: 7, sep: 8, oct: 9, nov: 10, dec: 11,
  }[monthName.slice(0, 3).toLowerCase()];
  if (month == null) return null;
  return new Date(Date.UTC(Number(year), month, Number(day), Number(hour) - 7, Number(minute))).toISOString();
}

function meta(html, key) {
  const patterns = [
    new RegExp(`<meta[^>]+property=["']${key}["'][^>]+content=["']([^"']*)["']`, "i"),
    new RegExp(`<meta[^>]+name=["']${key}["'][^>]+content=["']([^"']*)["']`, "i"),
    new RegExp(`<meta[^>]+content=["']([^"']*)["'][^>]+property=["']${key}["']`, "i"),
    new RegExp(`<meta[^>]+content=["']([^"']*)["'][^>]+name=["']${key}["']`, "i"),
  ];
  for (const pattern of patterns) {
    const match = html.match(pattern);
    if (match?.[1]) return decodeHtml(match[1]);
  }
  return null;
}

function absoluteUrl(value, baseUrl) {
  if (!value) return null;
  try {
    return new URL(String(value), baseUrl).toString();
  } catch {
    return String(value);
  }
}

function eventpopPoster(html, baseUrl) {
  const match = html.match(/&quot;previewPosterUrl&quot;:&quot;([^&]+)&quot;/i);
  return match?.[1] ? absoluteUrl(decodeHtml(match[1]), baseUrl) : null;
}

function jsonLdImageUrl(value) {
  const image = Array.isArray(value) ? value[0] : value;
  if (!image) return null;
  if (typeof image === "string") return image;
  if (typeof image === "object" && typeof image.url === "string") return image.url;
  if (typeof image === "object" && typeof image.contentUrl === "string") return image.contentUrl;
  return null;
}

function canonicalUrl(html, fallbackUrl) {
  const canonical = html.match(/<link[^>]+rel=["']canonical["'][^>]+href=["']([^"']+)["']/i)?.[1];
  return decodeHtml(canonical ?? fallbackUrl);
}

function extractJsonLd(html) {
  const blocks = [...html.matchAll(/<script[^>]+application\/ld\+json[^>]*>(.*?)<\/script>/gis)];
  const parsed = [];
  for (const block of blocks) {
    try {
      parsed.push(JSON.parse(block[1].trim()));
    } catch {
      // Ignore malformed JSON-LD blocks.
    }
  }
  return parsed;
}

function findEventJsonLd(html) {
  const queue = [...extractJsonLd(html)];
  while (queue.length) {
    const item = queue.shift();
    if (!item || typeof item !== "object") continue;
    if (item["@type"] === "Event" || (Array.isArray(item["@type"]) && item["@type"].includes("Event"))) {
      return item;
    }
    if (Array.isArray(item["@graph"])) queue.push(...item["@graph"]);
  }
  return null;
}

function eventSourceName(eventUrl) {
  const host = new URL(eventUrl).host.toLowerCase();
  if (host.includes("phangan.events")) return "phangan.events";
  if (host.includes("eventpop.me")) return "Eventpop";
  if (host.includes("megatix")) return "Megatix";
  if (host.includes("madstash")) return "Mad Stash";
  if (host.includes("ra.co")) return "Resident Advisor";
  return host.replace(/^www\./, "");
}

async function fetchHtml(url) {
  const host = new URL(url).host.toLowerCase();
  if (MANUAL_REVIEW_HOSTS.has(host) && !AUTO_IMPORT_HOSTS.has(host)) {
    throw new Error(`${host} is configured for manual review only, not automated import`);
  }
  if (!AUTO_IMPORT_HOSTS.has(host)) {
    throw new Error(`${host} is not in EVENT_AUTO_IMPORT_HOSTS`);
  }

  const response = await fetch(url, {
    headers: {
      "user-agent": "ThaiNightBot/1.0 (+https://thainight.co)",
      "accept-language": "en-US,en;q=0.9",
    },
  });
  if (!response.ok) throw new Error(`${response.status} ${response.statusText}`);
  return response.text();
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function detectCity(text) {
  const lower = text.toLowerCase();
  if (lower.includes("phuket") || lower.includes("patong")) return "phuket";
  if (lower.includes("pattaya")) return "pattaya";
  if (lower.includes("chiang mai") || lower.includes("nimman")) return "chiang-mai";
  return "bangkok";
}

function extractOfferHint(html) {
  const plainText = decodeHtml(html);
  const match = plainText.match(/(.{0,160}(happy hour|buy 1 get 1|bogo|free entry|early bird|flash sale|discount|guestlist|guest list|pre-sale|presale|[0-9]{2,4}\s*thb|[0-9]{2,4}\s*baht).{0,220})/i);
  return match?.[1]?.slice(0, 520) ?? null;
}

function eventPayloadFromHtml(html, url, sourceName) {
  if (/Attention Required! \| Cloudflare|Sorry, you have been blocked|cf-error-code/i.test(html)) {
    return { skipped: true, reason: "Blocked by Cloudflare", url };
  }

  const eventLd = findEventJsonLd(html);
  const title = normalizeTitle(eventLd?.name ?? meta(html, "og:title") ?? html.match(/<title[^>]*>(.*?)<\/title>/is)?.[1] ?? "");
  const description = decodeHtml(
    eventLd?.description ??
    meta(html, "og:description") ??
    meta(html, "description") ??
    ""
  );
  const image = jsonLdImageUrl(eventLd?.image) ?? meta(html, "og:image");
  const imageUrl = absoluteUrl(
    image && !String(image).includes("cover-placeholder") ? image : eventpopPoster(html, url),
    url
  );
  const sourceUrl = canonicalUrl(html, url);
  const locationName = typeof eventLd?.location === "object"
    ? eventLd.location?.name
    : eventLd?.location;
  const city = detectCity(`${title} ${description} ${locationName ?? ""}`);

  if (!title || title.length < 4) {
    return { skipped: true, reason: "No title", url };
  }

  const compactDescription = description.slice(0, 520);
  const eventDate = normalizeEventDate(eventLd?.startDate ?? meta(html, "og:start_time")) ?? dateFromText(`${title} ${description}`);
  const offerHint = extractOfferHint(html);
  return {
    city,
    title,
    description: compactDescription || null,
    event_date: eventDate,
    flyer_image_url: imageUrl,
    source_url: sourceUrl,
    source_type: "manual",
    status: "approved",
    is_featured: /boatchella|sacristy|madstash|pool|rooftop/i.test(`${sourceUrl} ${title}`),
    submitter_name: sourceName,
    reviewed_at: new Date().toISOString(),
    offer_hint: offerHint,
  };
}

function offerPayloadFromEvent(event) {
  const text = `${event.title} ${event.description ?? ""} ${event.offer_hint ?? ""}`;
  const matched = text.match(/(happy hour|buy 1 get 1|bogo|free entry|early bird|flash sale|guestlist|guest list|pre-sale|presale|walk-in|discount|[0-9]{2,4}\s*thb|[0-9]{2,4}\s*baht)/i);
  if (!matched) return null;

  const label = /happy hour/i.test(text)
    ? "Happy Hour"
    : /buy 1 get 1|bogo/i.test(text)
      ? "Buy 1 Get 1"
      : /free entry/i.test(text)
        ? "Free Entry"
        : /early bird/i.test(text)
          ? "Early Bird"
          : /flash sale/i.test(text)
            ? "Flash Sale"
            : /guestlist|guest list/i.test(text)
              ? "Guest List"
              : /pre-sale|presale/i.test(text)
                ? "Pre-sale"
                : "Special Offer";

  return {
    city: event.city,
    title: `${label}: ${event.title}`,
    description: event.offer_hint ?? event.description,
    offer_label: label,
    valid_from: event.event_date,
    valid_until: null,
    image_url: event.flyer_image_url,
    source_url: event.source_url,
    source_type: "manual",
    status: "approved",
    is_featured: true,
    submitter_name: event.submitter_name,
    reviewed_at: new Date().toISOString(),
  };
}

async function discoverPhanganEvents() {
  const urls = new Set();
  for (const pageUrl of SOURCE_PAGES) {
    try {
      const html = await fetchHtml(pageUrl);
      for (const match of html.matchAll(/href=["']([^"']*\/events\/[^"']+)["']/gi)) {
        const url = new URL(match[1], pageUrl).toString().replace(/#.*$/, "");
        urls.add(url);
      }
    } catch (error) {
      console.warn(`Source page skipped: ${pageUrl} (${error instanceof Error ? error.message : String(error)})`);
    }
  }
  if (urls.size === 0) {
    return FALLBACK_PHANGAN_EVENT_URLS.slice(0, MAX_PHANGAN_EVENTS);
  }
  return [...urls].slice(0, MAX_PHANGAN_EVENTS);
}

async function upsertBySourceUrl(supabase, table, row, imageColumn) {
  const { offer_hint: _offerHint, ...dbRow } = row;
  const { data: existing, error: lookupError } = await supabase
    .from(table)
    .select("id, status")
    .eq("source_url", dbRow.source_url)
    .maybeSingle();
  if (lookupError) throw lookupError;

  if (existing?.id) {
    const { error } = await supabase
      .from(table)
      .update({
        ...dbRow,
        [imageColumn]: dbRow[imageColumn] ?? undefined,
        updated_at: new Date().toISOString(),
      })
      .eq("id", existing.id);
    if (error) throw error;
    return "updated";
  }

  const { error } = await supabase.from(table).insert(dbRow);
  if (error) throw error;
  return "inserted";
}

async function main() {
  const { url, serviceKey } = readEnv();
  if (!url || !serviceKey) throw new Error("Missing Supabase credentials in .env.local");

  const discovered = await discoverPhanganEvents();
  const urls = [...new Set([
    ...discovered,
    ...EVENTPOP_SEEDS,
    ...MEGATIX_SEEDS,
    ...VENUE_OFFICIAL_SEEDS,
    ...RA_SEEDS,
    ...MANUAL_SEEDS,
  ])];
  const events = [];
  const skipped = [];

  for (const eventUrl of urls) {
    try {
      await sleep(REQUEST_DELAY_MS);
      const html = await fetchHtml(eventUrl);
      const sourceName = eventSourceName(eventUrl);
      const parsed = eventPayloadFromHtml(html, eventUrl, sourceName);
      if ("skipped" in parsed) skipped.push(parsed);
      else events.push(parsed);
    } catch (error) {
      skipped.push({ url: eventUrl, reason: error instanceof Error ? error.message : String(error) });
    }
  }

  const offers = events.map(offerPayloadFromEvent).filter(Boolean);

  console.log(JSON.stringify({
    discovered: discovered.length,
    events: events.length,
    offers: offers.length,
    skipped: skipped.slice(0, 8),
  }, null, 2));

  if (DRY_RUN) {
    for (const event of events.slice(0, 8)) {
      console.log(`- ${event.title} | ${event.city} | ${event.event_date ?? "date n/a"}`);
    }
    return;
  }

  const supabase = createClient(url, serviceKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  let eventWrites = 0;
  for (const event of events) {
    await upsertBySourceUrl(supabase, "event_flyers", event, "flyer_image_url");
    eventWrites++;
  }

  let offerWrites = 0;
  for (const offer of offers) {
    await upsertBySourceUrl(supabase, "venue_offers", offer, "image_url");
    offerWrites++;
  }

  console.log(JSON.stringify({ eventWrites, offerWrites }, null, 2));
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : error);
  process.exit(1);
});
