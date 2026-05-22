import { createServiceClient } from "@/lib/supabase/server";
import { createHash } from "node:crypto";

const DEFAULT_SOURCE_PAGES = ["https://phangan.events/bangkok/"];
const DEFAULT_AUTO_IMPORT_HOSTS = ["phangan.events"];
const MANUAL_REVIEW_HOSTS = new Set(["ra.co", "www.ra.co", "eventpop.me", "www.eventpop.me"]);
const DEFAULT_RSS_FEEDS = [
  "https://news.google.com/rss/search?q=Thailand%20nightlife%20OR%20Bangkok%20nightclub%20OR%20Bangkok%20bar%20opening%20OR%20Pattaya%20nightlife%20OR%20Phuket%20beach%20club%20when%3A14d&hl=en-US&gl=US&ceid=US:en",
  "https://news.google.com/rss/search?q=Bangkok%20restaurant%20bar%20opening%20OR%20Thailand%20new%20club%20OR%20Thailand%20music%20event%20when%3A14d&hl=en-US&gl=US&ceid=US:en",
  "https://news.google.com/rss/search?q=%28Bangkok%20nightlife%20news%20OR%20Pattaya%20nightlife%20news%20OR%20Phuket%20nightlife%20news%20OR%20Thailand%20nightlife%20news%29%20when%3A14d&hl=en-US&gl=US&ceid=US:en",
  "https://news.google.com/rss/search?q=%28Thailand%20alcohol%20law%20OR%20Bangkok%20bar%20hours%20OR%20Thailand%20bar%20closing%20time%20OR%20nightlife%20tourism%20Thailand%29%20when%3A30d&hl=en-US&gl=US&ceid=US:en",
  "https://news.google.com/rss/search?q=%28Bangkok%20new%20bar%20OR%20Bangkok%20cocktail%20bar%20opening%20OR%20Bangkok%20rooftop%20bar%20OR%20Thailand%20beach%20club%20opening%29%20when%3A30d&hl=en-US&gl=US&ceid=US:en",
  "https://news.google.com/rss/search?q=%28Bangla%20Road%20safety%20OR%20Walking%20Street%20Pattaya%20safety%20OR%20Thailand%20tourist%20nightlife%20scam%20OR%20Phuket%20nightlife%20warning%29%20when%3A30d&hl=en-US&gl=US&ceid=US:en",
  "https://www.reddit.com/search.rss?q=%22Bangkok%20nightlife%22%20OR%20%22Pattaya%20nightlife%22%20OR%20%22Phuket%20nightlife%22%20OR%20%22Thailand%20nightlife%22&sort=new",
  "https://www.reddit.com/r/ThailandTourism/search.rss?q=nightlife%20OR%20%22going%20out%22%20OR%20%22solo%20traveler%22%20OR%20bar%20OR%20club%20OR%20Pattaya%20OR%20Phuket&restrict_sr=on&sort=new",
  "https://www.reddit.com/r/Bangkok/search.rss?q=nightlife%20OR%20bar%20OR%20club%20OR%20%22going%20out%22%20OR%20tonight%20OR%20Sukhumvit%20OR%20Thonglor&restrict_sr=on&sort=new",
  "https://www.reddit.com/r/Pattaya/search.rss?q=nightlife%20OR%20%22Walking%20Street%22%20OR%20bar%20OR%20club%20OR%20%22Soi%20Buakhao%22%20OR%20solo&restrict_sr=on&sort=new",
  "https://www.reddit.com/r/phuket/search.rss?q=%22Bangla%20Road%22%20OR%20nightlife%20OR%20bar%20OR%20club%20OR%20Patong%20OR%20solo&restrict_sr=on&sort=new",
  "https://www.reddit.com/r/solotravel/search.rss?q=Thailand%20nightlife%20OR%20Bangkok%20nightlife%20OR%20Pattaya%20OR%20Phuket%20OR%20%22going%20out%22&restrict_sr=on&sort=new",
  "https://news.google.com/rss/search?q=site%3Aaseannow.com%20%28Bangkok%20nightlife%20OR%20Pattaya%20bar%20OR%20Phuket%20nightlife%20OR%20Thailand%20nightlife%29%20when%3A14d&hl=en-US&gl=US&ceid=US:en",
  "https://news.google.com/rss/search?q=site%3Atripadvisor.com%20%28Bangkok%20nightlife%20OR%20Pattaya%20nightlife%20OR%20Bangla%20Road%20OR%20Thailand%20bars%29%20when%3A30d&hl=en-US&gl=US&ceid=US:en",
  "https://travel.stackexchange.com/feeds/tag/thailand",
];

type ImportedEvent = {
  city: string;
  title: string;
  description: string | null;
  event_date: string | null;
  flyer_image_url: string | null;
  source_url: string;
  source_type: "manual";
  status: "pending";
  is_featured: boolean;
  submitter_name: string;
};

type ImportedOffer = {
  city: string;
  title: string;
  description: string | null;
  offer_label: string;
  valid_from: string | null;
  valid_until: string | null;
  image_url: string | null;
  source_url: string;
  source_type: "manual";
  status: "pending";
  is_featured: boolean;
  submitter_name: string;
};

export type EventImportResult = {
  discovered: number;
  events: number;
  offers: number;
  rssItems: number;
  eventWrites: number;
  offerWrites: number;
  intelWrites: number;
  eventInserted: number;
  eventUpdated: number;
  offerInserted: number;
  offerUpdated: number;
  skipped: Array<{ url: string; reason: string }>;
};

type RssIntelItem = {
  id: string;
  source: string;
  title: string;
  url: string;
  snippet: string | null;
  postedAt: string | null;
  city: string;
  category: string;
  value: number;
  isRaidAlert: boolean;
};

function listFromEnv(name: string, fallback: string[]): string[] {
  const raw = process.env[name];
  if (!raw) return fallback;
  return raw.split(",").map((value) => value.trim()).filter(Boolean);
}

function decodeHtml(value = ""): string {
  return value
    .replace(/<!\[CDATA\[([\s\S]*?)\]\]>/g, "$1")
    .replace(/&amp;/g, "&")
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&apos;/g, "'")
    .replace(/&lt;/g, "<")
    .replace(/&gt;/g, ">")
    .replace(/&nbsp;/g, " ")
    .replace(/&ndash;|&mdash;/g, "-")
    .replace(/<[^>]*>/g, " ")
    .replace(/\s+/g, " ")
    .trim();
}

function meta(html: string, key: string): string | null {
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

function canonicalUrl(html: string, fallbackUrl: string): string {
  const canonical = html.match(/<link[^>]+rel=["']canonical["'][^>]+href=["']([^"']+)["']/i)?.[1];
  return decodeHtml(canonical ?? fallbackUrl);
}

function extractJsonLd(html: string): unknown[] {
  const pattern = /<script[^>]+application\/ld\+json[^>]*>([\s\S]*?)<\/script>/gi;
  const parsed: unknown[] = [];
  let block: RegExpExecArray | null;
  while ((block = pattern.exec(html)) !== null) {
    try {
      parsed.push(JSON.parse(block[1].trim()));
    } catch {
      // Ignore malformed JSON-LD blocks.
    }
  }
  return parsed;
}

function findEventJsonLd(html: string): Record<string, unknown> | null {
  const queue = [...extractJsonLd(html)];
  while (queue.length) {
    const item = queue.shift();
    if (!item || typeof item !== "object") continue;
    const record = item as Record<string, unknown>;
    const type = record["@type"];
    if (type === "Event" || (Array.isArray(type) && type.includes("Event"))) return record;
    if (Array.isArray(record["@graph"])) queue.push(...record["@graph"]);
  }
  return null;
}

function detectCity(text: string): string {
  const lower = text.toLowerCase();
  if (lower.includes("phuket") || lower.includes("patong")) return "phuket";
  if (lower.includes("pattaya")) return "pattaya";
  if (lower.includes("chiang mai") || lower.includes("nimman")) return "chiang-mai";
  return "bangkok";
}

function detectIntelCategory(text: string): string {
  const lower = text.toLowerCase();
  if (/law|legal|ban|alcohol sale|closing time|opening hour|regulation|police order|tourism policy/.test(lower)) return "nightlife_news";
  if (/scam|overcharge|unsafe|police|raid|warning|avoid|danger|stolen|robbed/.test(lower)) return "safety";
  if (/solo|meet|join|going out|anyone going|travel buddy|friend|friends|date|dating/.test(lower)) return "solo";
  if (/opening|opened|launch|new venue|new bar|new club|grand opening/.test(lower)) return "new_opening";
  if (/event|festival|concert|dj|lineup|ticket|party|tonight|weekend/.test(lower)) return "event";
  if (/happy hour|discount|free entry|early bird|offer|deal|promotion/.test(lower)) return "offer";
  if (/price|cost|fee|cover charge|entry/.test(lower)) return "price";
  return "nightlife_news";
}

function intelValue(text: string, category: string): number {
  const lower = text.toLowerCase();
  let score = 0.58;
  if (/(bangkok|pattaya|phuket|chiang mai|thailand)/.test(lower)) score += 0.08;
  if (/(nightlife|bar|club|rooftop|party|event|dj|venue|walking street|bangla)/.test(lower)) score += 0.1;
  if (/(opening|tonight|this weekend|warning|scam|fee|price|ticket|lineup)/.test(lower)) score += 0.1;
  if (/(anyone|recommend|where|how much|is it safe|solo|meet|join|going out|travel buddy|first time)/.test(lower)) score += 0.08;
  if (category === "safety" || category === "new_opening" || category === "event" || category === "solo") score += 0.06;
  return Math.min(0.95, Number(score.toFixed(2)));
}

function safeIsoDate(value: unknown): string | null {
  if (!value) return null;
  const date = new Date(String(value));
  if (Number.isNaN(date.getTime())) return null;
  return date.toISOString();
}

function hashId(value: string): string {
  return createHash("sha1").update(value).digest("hex").slice(0, 24);
}

function tagValue(xml: string, tag: string): string | null {
  const match = xml.match(new RegExp(`<${tag}[^>]*>([\\s\\S]*?)<\\/${tag}>`, "i"));
  return match?.[1] ? decodeHtml(match[1]) : null;
}

function atomLink(xml: string): string | null {
  const href = xml.match(/<link[^>]+href=["']([^"']+)["']/i)?.[1];
  return href ? decodeHtml(href) : null;
}

function normalizeFeedLink(value: string, feedUrl: string): string {
  try {
    const url = new URL(value, feedUrl);
    const target = url.searchParams.get("url");
    if (url.host.includes("news.google.com") && target) return target;
    return url.toString();
  } catch {
    return value;
  }
}

function parseRssItems(xml: string, feedUrl: string): RssIntelItem[] {
  const blocks = Array.from(xml.matchAll(/<(item|entry)\b[^>]*>([\s\S]*?)<\/\1>/gi));
  return blocks.flatMap(([, , block]) => {
    const rawLink = tagValue(block, "link") ?? atomLink(block);
    const title = tagValue(block, "title");
    if (!rawLink || !title) return [];

    const url = normalizeFeedLink(rawLink, feedUrl);
    const snippet = tagValue(block, "description") ?? tagValue(block, "summary") ?? tagValue(block, "content");
    const postedAt = safeIsoDate(tagValue(block, "pubDate") ?? tagValue(block, "updated") ?? tagValue(block, "published"));
    const text = `${title} ${snippet ?? ""} ${url}`;
    const category = detectIntelCategory(text);
    const city = detectCity(text);
    const sourceHost = new URL(url).host.replace(/^www\./, "");
    const value = intelValue(text, category);

    if (value < 0.6) return [];

    return [{
      id: `rss:${hashId(url)}`,
      source: sourceHost.includes("reddit.com") ? "reddit_rss" : `rss:${sourceHost}`,
      title: title.slice(0, 240),
      url,
      snippet: snippet?.slice(0, 620) ?? null,
      postedAt,
      city,
      category,
      value,
      isRaidAlert: category === "safety" && /raid|police|unsafe|scam|overcharge|warning|avoid/i.test(text),
    }];
  });
}

async function fetchRssFeed(feedUrl: string): Promise<RssIntelItem[]> {
  const response = await fetch(feedUrl, {
    headers: {
      "user-agent": "ThaiNightBot/1.0 (+https://thainight.co)",
      accept: "application/rss+xml, application/atom+xml, application/xml, text/xml;q=0.9, */*;q=0.8",
    },
    signal: AbortSignal.timeout(8_000),
  });
  if (!response.ok) throw new Error(`${response.status} ${response.statusText}`);
  return parseRssItems(await response.text(), feedUrl);
}

function hostAllowed(url: string, allowedHosts: Set<string>): boolean {
  const host = new URL(url).host.toLowerCase();
  return allowedHosts.has(host) && !MANUAL_REVIEW_HOSTS.has(host);
}

async function fetchHtml(url: string, allowedHosts: Set<string>): Promise<string> {
  if (!hostAllowed(url, allowedHosts)) {
    throw new Error(`${new URL(url).host} is not configured for automated import`);
  }

  const response = await fetch(url, {
    headers: {
      "user-agent": "ThaiNightBot/1.0 (+https://thainight.co)",
      "accept-language": "en-US,en;q=0.9",
    },
    signal: AbortSignal.timeout(8_000),
  });
  if (!response.ok) throw new Error(`${response.status} ${response.statusText}`);
  return response.text();
}

function eventPayloadFromHtml(html: string, url: string, sourceName: string): ImportedEvent | null {
  const eventLd = findEventJsonLd(html);
  const location = eventLd?.location;
  const locationName =
    location && typeof location === "object"
      ? String((location as Record<string, unknown>).name ?? "")
      : String(location ?? "");
  const rawImage = eventLd?.image;
  const image = Array.isArray(rawImage) ? rawImage[0] : rawImage ?? meta(html, "og:image");
  const title = decodeHtml(
    String(eventLd?.name ?? meta(html, "og:title") ?? html.match(/<title[^>]*>([\s\S]*?)<\/title>/i)?.[1] ?? "")
  );
  const description = decodeHtml(
    String(eventLd?.description ?? meta(html, "og:description") ?? meta(html, "description") ?? "")
  );
  const sourceUrl = canonicalUrl(html, url);

  if (!title || title.length < 4) return null;

  return {
    city: detectCity(`${title} ${description} ${locationName}`),
    title,
    description: description.slice(0, 520) || null,
    event_date: safeIsoDate(eventLd?.startDate),
    flyer_image_url: image ? String(image) : null,
    source_url: sourceUrl,
    source_type: "manual",
    status: "pending",
    is_featured: /boatchella|sacristy|madstash|pool|rooftop/i.test(`${sourceUrl} ${title}`),
    submitter_name: sourceName,
  };
}

function offerPayloadFromEvent(event: ImportedEvent): ImportedOffer | null {
  const text = `${event.title} ${event.description ?? ""}`;
  const matched = text.match(/(happy hour|buy 1 get 1|bogo|free entry|guest list|ladies night|early bird|discount|promo code)/i);
  if (!matched) return null;

  const label = /happy hour/i.test(text)
    ? "Happy Hour"
    : /buy 1 get 1|bogo/i.test(text)
      ? "Buy 1 Get 1"
      : /free entry/i.test(text)
        ? "Free Entry"
        : /guest list/i.test(text)
          ? "Guest List"
          : /ladies night/i.test(text)
            ? "Ladies Night"
            : /early bird/i.test(text)
              ? "Early Bird"
              : "Discount";

  return {
    city: event.city,
    title: `${label}: ${event.title}`,
    description: event.description,
    offer_label: label,
    valid_from: event.event_date,
    valid_until: null,
    image_url: event.flyer_image_url,
    source_url: event.source_url,
    source_type: "manual",
    status: "pending",
    is_featured: true,
    submitter_name: event.submitter_name,
  };
}

async function discoverEventUrls(sourcePages: string[], allowedHosts: Set<string>, limit: number): Promise<string[]> {
  const urls = new Set<string>();
  for (const pageUrl of sourcePages) {
    const html = await fetchHtml(pageUrl, allowedHosts);
    for (const match of Array.from(html.matchAll(/href=["']([^"']*\/events\/[^"']+)["']/gi))) {
      const url = new URL(match[1], pageUrl).toString().replace(/#.*$/, "");
      if (hostAllowed(url, allowedHosts)) urls.add(url);
      if (urls.size >= limit) break;
    }
  }
  return Array.from(urls).slice(0, limit);
}

async function upsertEvent(row: ImportedEvent): Promise<"inserted" | "updated"> {
  const supabase = createServiceClient();
  if (!supabase) throw new Error("Missing Supabase service credentials");

  const { data: existingRows, error: lookupError } = await supabase
    .from("event_flyers")
    .select("id,status,created_at,updated_at")
    .eq("source_url", row.source_url)
    .order("updated_at", { ascending: false, nullsFirst: false })
    .order("created_at", { ascending: false })
    .limit(10);
  if (lookupError) throw lookupError;

  const existing = existingRows?.[0];
  if (existing?.id) {
    const { error } = await supabase
      .from("event_flyers")
      .update({
        ...row,
        status: existing.status === "pending" ? "pending" : existing.status,
        updated_at: new Date().toISOString(),
      })
      .eq("id", existing.id);
    if (error) throw error;
    return "updated";
  }

  const { error } = await supabase.from("event_flyers").insert(row);
  if (error) throw error;
  return "inserted";
}

async function upsertOffer(row: ImportedOffer): Promise<"inserted" | "updated"> {
  const supabase = createServiceClient();
  if (!supabase) throw new Error("Missing Supabase service credentials");

  const { data: existingRows, error: lookupError } = await supabase
    .from("venue_offers")
    .select("id,status,created_at,updated_at")
    .eq("source_url", row.source_url)
    .order("updated_at", { ascending: false, nullsFirst: false })
    .order("created_at", { ascending: false })
    .limit(10);
  if (lookupError) throw lookupError;

  const existing = existingRows?.[0];
  if (existing?.id) {
    const { error } = await supabase
      .from("venue_offers")
      .update({
        ...row,
        status: existing.status === "pending" ? "pending" : existing.status,
        updated_at: new Date().toISOString(),
      })
      .eq("id", existing.id);
    if (error) throw error;
    return "updated";
  }

  const { error } = await supabase.from("venue_offers").insert(row);
  if (error) throw error;
  return "inserted";
}

async function upsertIntel(item: RssIntelItem): Promise<"inserted" | "updated"> {
  const supabase = createServiceClient();
  if (!supabase) throw new Error("Missing Supabase service credentials");

  const payload = {
    radarscout_id: item.id,
    source: item.source,
    subreddit: item.source === "reddit_rss" ? "search" : null,
    title: item.title,
    url: item.url,
    body_snippet: item.snippet,
    posted_at: item.postedAt,
    city: item.city,
    venue_type: item.category,
    travel_intent: item.value,
    credibility: item.source.startsWith("rss:") ? 0.72 : 0.64,
    thainight_value: item.value,
    sentiment: item.isRaidAlert ? "negative" : "neutral",
    extracted_venues: [],
    is_raid_alert: item.isRaidAlert,
    is_displayed: true,
    received_at: new Date().toISOString(),
  };

  const { error } = await supabase
    .from("intelligence_feed")
    .upsert(payload, { onConflict: "radarscout_id" });
  if (error) throw error;
  return "updated";
}

async function importRssIntel(limit: number, skipped: EventImportResult["skipped"]): Promise<{
  rssItems: number;
  intelWrites: number;
}> {
  const feeds = listFromEnv("NIGHTLIFE_RSS_FEEDS", DEFAULT_RSS_FEEDS);
  const perFeedLimit = Math.max(1, Math.ceil(limit / Math.max(feeds.length, 1)));
  const seen = new Set<string>();
  const items: RssIntelItem[] = [];

  for (const feed of feeds) {
    try {
      const feedItems = await fetchRssFeed(feed);
      for (const item of feedItems) {
        if (seen.has(item.url)) continue;
        seen.add(item.url);
        items.push(item);
        if (items.length >= limit) break;
      }
    } catch (error) {
      skipped.push({ url: feed, reason: error instanceof Error ? error.message : String(error) });
    }
    if (items.length >= limit) break;
    if (items.length >= perFeedLimit * feeds.length) break;
  }

  let intelWrites = 0;
  for (const item of items.slice(0, limit)) {
    await upsertIntel(item);
    intelWrites++;
  }

  return { rssItems: items.length, intelWrites };
}

export async function importAllowedEvents(limit = 18): Promise<EventImportResult> {
  const sourcePages = listFromEnv("EVENT_SOURCE_PAGES", DEFAULT_SOURCE_PAGES);
  const allowedHosts = new Set(listFromEnv("EVENT_AUTO_IMPORT_HOSTS", DEFAULT_AUTO_IMPORT_HOSTS));
  const skipped: EventImportResult["skipped"] = [];

  let discovered: string[] = [];
  try {
    discovered = await discoverEventUrls(sourcePages, allowedHosts, limit);
  } catch (error) {
    skipped.push({
      url: sourcePages.join(","),
      reason: error instanceof Error ? error.message : String(error),
    });
  }

  const events: ImportedEvent[] = [];
  for (const eventUrl of discovered) {
    try {
      const html = await fetchHtml(eventUrl, allowedHosts);
      const sourceName = new URL(eventUrl).host.replace(/^www\./, "");
      const parsed = eventPayloadFromHtml(html, eventUrl, sourceName);
      if (parsed) events.push(parsed);
      else skipped.push({ url: eventUrl, reason: "No event metadata found" });
    } catch (error) {
      skipped.push({ url: eventUrl, reason: error instanceof Error ? error.message : String(error) });
    }
  }

  const offers = events.map(offerPayloadFromEvent).filter((offer): offer is ImportedOffer => Boolean(offer));
  const rssLimit = Number(process.env.NIGHTLIFE_RSS_IMPORT_LIMIT ?? 24);
  const rssResult = await importRssIntel(Number.isFinite(rssLimit) ? rssLimit : 24, skipped);
  let eventWrites = 0;
  let offerWrites = 0;
  let eventInserted = 0;
  let eventUpdated = 0;
  let offerInserted = 0;
  let offerUpdated = 0;

  for (const event of events) {
    try {
      const outcome = await upsertEvent(event);
      eventWrites++;
      if (outcome === "inserted") eventInserted++;
      else eventUpdated++;
    } catch (error) {
      skipped.push({
        url: event.source_url,
        reason: error instanceof Error ? error.message : String(error),
      });
    }
  }

  for (const offer of offers) {
    try {
      const outcome = await upsertOffer(offer);
      offerWrites++;
      if (outcome === "inserted") offerInserted++;
      else offerUpdated++;
    } catch (error) {
      skipped.push({
        url: offer.source_url,
        reason: error instanceof Error ? error.message : String(error),
      });
    }
  }

  return {
    discovered: discovered.length,
    events: events.length,
    offers: offers.length,
    rssItems: rssResult.rssItems,
    eventWrites,
    offerWrites,
    intelWrites: rssResult.intelWrites,
    eventInserted,
    eventUpdated,
    offerInserted,
    offerUpdated,
    skipped: skipped.slice(0, 20),
  };
}
