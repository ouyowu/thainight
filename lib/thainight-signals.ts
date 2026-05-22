import type { CitySlug } from "@/lib/cities";
import { createAnonClient } from "@/lib/supabase/server";
import type { IntelligenceFeedRow } from "@/lib/database.types";

export type ThaiNightSignal = {
  id: string;
  platform: string;
  title: string;
  url: string;
  snippet: string;
  summary: string | null;
  keyword: string;
  location: string | null;
  category: string | null;
  opportunityType: string | null;
  travelIntentScore: number | null;
  credibilityScore: number | null;
  commercialScore: number | null;
  matchedAt: string;
};

function cityName(city?: string | null): string | null {
  if (!city) return null;
  return city
    .split("-")
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join(" ");
}

function platformName(source?: string | null, subreddit?: string | null): string {
  if (subreddit && subreddit !== "search") return `r/${subreddit}`;
  if (!source) return "ThaiNight";
  if (source.startsWith("rss:")) return source.replace(/^rss:/, "");
  if (source === "reddit_rss") return "Reddit";
  if (source === "radarscout") return "ThaiNight Signals";
  return source;
}

function mapSignal(item: IntelligenceFeedRow): ThaiNightSignal {
  const score = item.thainight_value ? Math.round(item.thainight_value * 10) : null;

  return {
    id: item.id,
    platform: platformName(item.source, item.subreddit),
    title: item.title,
    url: item.url,
    snippet: item.body_snippet ?? "",
    summary: item.body_snippet,
    keyword: item.venue_type ?? "Thailand nightlife",
    location: cityName(item.city),
    category: item.venue_type,
    opportunityType: item.sentiment,
    travelIntentScore: score,
    credibilityScore: item.credibility ? Math.round(item.credibility * 10) : null,
    commercialScore: score,
    matchedAt: item.received_at,
  };
}

export async function getThaiNightSignals(options: {
  city?: CitySlug;
  limit?: number;
  minValue?: number;
} = {}): Promise<ThaiNightSignal[]> {
  const supabase = createAnonClient();
  if (!supabase) return [];

  let query = supabase
    .from("intelligence_feed")
    .select("*")
    .eq("is_displayed", true)
    .gte("thainight_value", options.minValue ?? 0.5)
    .order("received_at", { ascending: false })
    .limit(options.limit ?? 12);

  if (options.city) query = query.eq("city", options.city);

  const { data } = await query;
  return ((data ?? []) as IntelligenceFeedRow[]).map(mapSignal);
}

export function signalScore(signal: ThaiNightSignal): number | null {
  return signal.commercialScore ?? signal.travelIntentScore ?? null;
}
