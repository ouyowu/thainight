import { createAnonClient } from "@/lib/supabase/server";
import type {
  EventFlyerRow,
  IntelligenceFeedRow,
  VenueCard,
  VenueOfferRow,
} from "@/lib/database.types";

const REAL_OFFER_LABELS = [
  "happy hour",
  "buy 1 get 1",
  "bogo",
  "free entry",
  "early bird",
  "guest list",
  "discount",
  "ladies night",
];

const THAILAND_RELEVANCE_TERMS = [
  "thailand",
  "thai",
  "bangkok",
  "pattaya",
  "phuket",
  "chiang mai",
  "chiangmai",
  "patong",
  "bangla",
  "natai",
  "samui",
  "koh phangan",
  "koh tao",
  "sukhumvit",
  "thonglor",
  "ekkamai",
  "silom",
  "rca",
  "nimman",
];

export type AreaSummary = {
  areaSlug: string;
  areaName: string;
  venueCount: number;
  averageScore: number | null;
  topTags: string[];
};

export function publicNowIso(): string {
  return new Date().toISOString();
}

export function isRealOffer(offer: Pick<VenueOfferRow, "offer_label" | "title">): boolean {
  const text = `${offer.offer_label ?? ""} ${offer.title}`.toLowerCase();
  if (text.startsWith("special offer:")) return false;
  return REAL_OFFER_LABELS.some((label) => text.includes(label));
}

export function isThailandRelevantIntel(item: Pick<IntelligenceFeedRow, "title" | "body_snippet" | "city" | "url">): boolean {
  const text = [
    item.title,
    item.body_snippet ?? "",
    item.city ?? "",
    item.url,
  ].join(" ").toLowerCase();

  return THAILAND_RELEVANCE_TERMS.some((term) => text.includes(term));
}

export function areaSummariesFromVenues(venues: VenueCard[], limit = 4): AreaSummary[] {
  const groups = new Map<string, VenueCard[]>();
  for (const venue of venues) {
    const key = venue.area_slug ?? "unknown";
    groups.set(key, [...(groups.get(key) ?? []), venue]);
  }

  return Array.from(groups.entries())
    .map(([areaSlug, items]) => {
      const scored = items.filter((item) => item.overall_score !== null);
      const tagCounts = new Map<string, number>();
      for (const item of items) {
        for (const tag of item.tags ?? []) {
          tagCounts.set(tag, (tagCounts.get(tag) ?? 0) + 1);
        }
      }

      return {
        areaSlug,
        areaName: items[0]?.area_name ?? areaSlug.replace(/-/g, " "),
        venueCount: items.length,
        averageScore: scored.length
          ? scored.reduce((sum, item) => sum + (item.overall_score ?? 0), 0) / scored.length
          : null,
        topTags: Array.from(tagCounts.entries())
          .sort((a, b) => b[1] - a[1])
          .slice(0, 3)
          .map(([tag]) => tag.replace(/_/g, " ")),
      };
    })
    .sort((a, b) => {
      const scoreDiff = (b.averageScore ?? 0) - (a.averageScore ?? 0);
      return scoreDiff !== 0 ? scoreDiff : b.venueCount - a.venueCount;
    })
    .slice(0, limit);
}

export async function getUpcomingEvents(options: {
  city?: string;
  limit?: number;
} = {}): Promise<EventFlyerRow[]> {
  const supabase = createAnonClient();
  if (!supabase) return [];

  let query = supabase
    .from("event_flyers")
    .select("*")
    .eq("status", "approved")
    .gte("event_date", publicNowIso())
    .order("is_featured", { ascending: false })
    .order("event_date", { ascending: true, nullsFirst: false })
    .order("created_at", { ascending: false })
    .limit(options.limit ?? 9);

  if (options.city) query = query.eq("city", options.city);

  const { data } = await query;
  return (data ?? []) as EventFlyerRow[];
}

export async function getApprovedOffers(options: {
  city?: string;
  limit?: number;
} = {}): Promise<VenueOfferRow[]> {
  const supabase = createAnonClient();
  if (!supabase) return [];

  let query = supabase
    .from("venue_offers")
    .select("*")
    .eq("status", "approved")
    .or(`valid_until.is.null,valid_until.gte.${publicNowIso()}`)
    .order("is_featured", { ascending: false })
    .order("created_at", { ascending: false })
    .limit((options.limit ?? 6) * 3);

  if (options.city) query = query.eq("city", options.city);

  const { data } = await query;
  return ((data ?? []) as VenueOfferRow[]).filter(isRealOffer).slice(0, options.limit ?? 6);
}

export async function getPublicIntel(options: {
  city?: string;
  category?: string;
  limit?: number;
  minValue?: number;
} = {}): Promise<IntelligenceFeedRow[]> {
  const supabase = createAnonClient();
  if (!supabase) return [];

  let query = supabase
    .from("intelligence_feed")
    .select("*")
    .eq("is_displayed", true)
    .gte("thainight_value", options.minValue ?? 0.6)
    .order("thainight_value", { ascending: false })
    .order("received_at", { ascending: false })
    .limit(options.limit ?? 6);

  if (options.city) query = query.eq("city", options.city);
  if (options.category) query = query.eq("venue_type", options.category);

  const { data } = await query;
  const items = (data ?? []) as IntelligenceFeedRow[];
  const filtered = items.filter(isThailandRelevantIntel);

  return filtered.slice(0, options.limit ?? 6);
}

export async function getLatestPublicIntel(options: {
  city?: string;
  categories?: string[];
  limit?: number;
  minValue?: number;
} = {}): Promise<IntelligenceFeedRow[]> {
  const supabase = createAnonClient();
  if (!supabase) return [];

  let query = supabase
    .from("intelligence_feed")
    .select("*")
    .eq("is_displayed", true)
    .gte("thainight_value", options.minValue ?? 0.58)
    .order("received_at", { ascending: false })
    .limit((options.limit ?? 24) * 2);

  if (options.city) query = query.eq("city", options.city);
  if (options.categories?.length) query = query.in("venue_type", options.categories);

  const { data } = await query;
  const items = (data ?? []) as IntelligenceFeedRow[];
  return items.filter(isThailandRelevantIntel).slice(0, options.limit ?? 24);
}
