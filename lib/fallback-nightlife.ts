/**
 * Offline / no-Supabase fallbacks so `npm run dev` works before DB wiring.
 * Matches seed areas in supabase/migrations/001_schema.sql (subset typed here).
 */
import type { AreaRow, VenueCard, VenueCategory } from "@/lib/database.types";
import { getVenue, listVenuesByArea } from "@/lib/venues";
import type { Venue } from "@/lib/types";

const STATIC_AREAS: AreaRow[] = [
  {
    id: "00000000-0000-0000-0000-000000000001",
    slug: "thonglor",
    name: "Thonglor",
    city: "bangkok",
    description:
      "Bangkok's creative-class nightlife corridor. High-end cocktail bars and Japanese-influenced dining.",
    latitude: 13.7289,
    longitude: 100.5844,
    created_at: "2026-01-01T00:00:00.000Z",
  },
  {
    id: "00000000-0000-0000-0000-000000000002",
    slug: "silom",
    name: "Silom",
    city: "bangkok",
    description:
      "Business district by day, Patpong strip and craft cocktail scene by night.",
    latitude: 13.7267,
    longitude: 100.5274,
    created_at: "2026-01-01T00:00:00.000Z",
  },
  {
    id: "00000000-0000-0000-0000-000000000003",
    slug: "sukhumvit",
    name: "Sukhumvit",
    city: "bangkok",
    description:
      "The main artery. Massive venue variety from dive bars to luxury sky bars.",
    latitude: 13.7308,
    longitude: 100.5673,
    created_at: "2026-01-01T00:00:00.000Z",
  },
];

function mapCategory(v: Venue): VenueCategory {
  if (v.category === "gentlemen-clubs") return "nightclub";
  if (v.slug.includes("sky")) return "rooftop-bar";
  return "cocktail-bar";
}

function mapPriceRange(s: string): VenueCard["price_range"] {
  const t = s.trim();
  if (t === "$" || t === "฿") return "฿";
  if (t === "$$" || t === "฿฿") return "฿฿";
  if (t === "$$$" || t === "฿฿฿") return "฿฿฿";
  return "฿฿฿฿";
}

function toVenueCard(v: Venue): VenueCard {
  const weekMs = 7 * 24 * 60 * 60 * 1000;
  const verified =
    Date.now() - new Date(v.updated_at).getTime() <= weekMs;
  return {
    id: v.slug,
    slug: v.slug,
    name: v.name,
    city: v.city,
    area_slug: v.area,
    area_name: v.area,
    category: mapCategory(v),
    tagline: v.description.slice(0, 120),
    hero_image_url: v.image ?? null,
    price_range: mapPriceRange(v.priceRange),
    opening_hours: "See venue page",
    tags: ["mock-data"],
    overall_score:
      (v.scores.foreignerFriendly * 0.3 +
        v.scores.reliability * 0.4 +
        v.scores.priceTransparency * 0.3) / 10,
    score_foreigner_friendly: v.scores.foreignerFriendly / 10,
    score_late_night_reliability: v.scores.reliability / 10,
    score_price_transparency: v.scores.priceTransparency / 10,
    score_tourist_trap_risk: 3,
    last_verified_at: v.last_verified_at,
    temporarily_closed: false,
    is_verified_this_week: verified,
    days_since_verified: 0,
  };
}

export function getStaticAreaOrNull(slug: string): AreaRow | null {
  return STATIC_AREAS.find((a) => a.slug === slug) ?? null;
}

export function getStaticVenueCardsForArea(
  city: string,
  category: "bars" | "gentlemen-clubs",
  areaSlug: string
): VenueCard[] {
  return listVenuesByArea(city, category, areaSlug).map(toVenueCard);
}

export function getStaticVenueCardsForCity(city: string): VenueCard[] {
  return [
    ...listVenuesByArea(city, "bars", "thonglor"),
    ...listVenuesByArea(city, "bars", "silom"),
    ...listVenuesByArea(city, "gentlemen-clubs", "sukhumvit"),
  ].map(toVenueCard);
}

export function getStaticVenueBySlug(
  city: string,
  category: "bars" | "gentlemen-clubs",
  areaSlug: string,
  slug: string
): Venue | undefined {
  return getVenue(city, category, areaSlug, slug);
}
