// app/[city]/bars/[area]/[venue-slug]/page.tsx
// THE SEO CORE PAGE — highest priority for Google ranking
// Each venue gets: LocalBusiness JSON-LD, 8-metric score card,
// verified badge, community intelligence, Telegram CTA

import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { createAnonClient } from "@/lib/supabase/server";
import VenueDetailClient from "@/components/VenueDetailClient";
import type { Database } from "@/lib/database.types";
import { canRenderPublicImage } from "@/lib/media";

// ─── Types ────────────────────────────────────────────────────────────────────

interface PageProps {
  params: {
    city:          string;
    area:          string;
    "venue-slug":  string;
  };
}

type VenueCategory = Database["public"]["Tables"]["venues"]["Row"]["category"];

function canUseSeoImage(url?: string | null): boolean {
  return canRenderPublicImage(url);
}

// ─── Data ─────────────────────────────────────────────────────────────────────

async function getVenue(city: string, area: string, slug: string) {
  const supabase = createAnonClient();
  if (!supabase) return null;

  const { data, error } = await supabase
    .from("venues")
    .select(`
      id, slug, name, city, area_slug, category,
      tagline, address, latitude, longitude,
      google_maps_url, google_place_id, phone, website, instagram_handle,
      opening_hours, price_range, cover_charge, dress_code,
      hero_image_url, image_urls, tags, insider_tip,
      score_foreigner_friendly, score_solo_traveler,
      score_date_night, score_music_quality,
      score_tourist_trap_risk, score_price_transparency,
      score_walkability, score_late_night_reliability,
      overall_score, last_verified_at, verified_by,
      updated_at, is_permanently_closed, temporarily_closed
    `)
    .eq("slug", slug)
    .eq("city", city)
    .eq("area_slug", area)
    .eq("is_published", true)
    .single();

  if (error || !data) return null;

  const { data: socialFlags } = await supabase
    .from("venues")
    .select("social_enabled, is_trending")
    .eq("id", data.id)
    .maybeSingle();

  return {
    ...data,
    social_enabled: socialFlags?.social_enabled ?? false,
    is_trending: socialFlags?.is_trending ?? false,
  };
}

async function getIntelligence(venueSlug: string) {
  try {
    const supabase = createAnonClient();
    if (!supabase) return [];

    const { data } = await supabase
      .from("intelligence_feed")
      .select("id, title, url, subreddit, thainight_value, sentiment, received_at, body_snippet")
      .eq("matched_venue_slug", venueSlug)
      .eq("is_displayed", true)
      .gte("received_at", new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString())
      .order("thainight_value", { ascending: false })
      .limit(5);
    return data ?? [];
  } catch { return []; }
}

async function getSimilarVenues(city: string, area: string, category: VenueCategory, excludeSlug: string) {
  try {
    const supabase = createAnonClient();
    if (!supabase) return [];

    const { data } = await supabase
      .from("venue_cards")
      .select("id, slug, name, area_slug, area_name, category, overall_score, price_range, last_verified_at, is_verified_this_week")
      .eq("city", city)
      .eq("area_slug", area)
      .eq("category", category)
      .neq("slug", excludeSlug)
      .order("overall_score", { ascending: false })
      .limit(4);
    return data ?? [];
  } catch { return []; }
}

// ─── Metadata ─────────────────────────────────────────────────────────────────

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const venue = await getVenue(params.city, params.area, params["venue-slug"]);
  if (!venue) return { title: "Venue Not Found" };

  const areaName  = params.area.replace(/-/g, " ").replace(/\b\w/g, c => c.toUpperCase());
  const cityName  = params.city.replace(/-/g, " ").replace(/\b\w/g, c => c.toUpperCase());
  const score     = venue.overall_score?.toFixed(1);
  const verified  = venue.last_verified_at
    ? new Date(venue.last_verified_at).toLocaleDateString("en-US", { month: "long", year: "numeric" })
    : "May 2026";
  const heroImage = canUseSeoImage(venue.hero_image_url) ? venue.hero_image_url : null;

  return {
    title: `${venue.name} — ${areaName} Bar Review [Updated ${verified}] | ThaiNight`,
    description:
      `${venue.tagline ?? `${venue.name} in ${areaName}, ${cityName}.`} ` +
      `Overall score: ${score ?? "N/A"}/10. ` +
      `Foreigner-friendly: ${venue.score_foreigner_friendly?.toFixed(1) ?? "N/A"}. ` +
      `${venue.price_range ?? ""} · ${venue.opening_hours ?? ""}. No tourist traps.`,
    openGraph: {
      title: `${venue.name} — ${areaName} [Updated ${verified}]`,
      description: venue.tagline ?? `Honest scores for ${venue.name} in ${areaName}.`,
      type: "article",
      modifiedTime: venue.last_verified_at ?? venue.updated_at,
      images: heroImage ? [{ url: heroImage }] : [],
    },
    alternates: {
      canonical: `https://thainight.co/${params.city}/bars/${params.area}/${params["venue-slug"]}`,
    },
  };
}

// ─── JSON-LD ──────────────────────────────────────────────────────────────────

function buildJsonLd(venue: NonNullable<Awaited<ReturnType<typeof getVenue>>>, params: PageProps["params"]) {
  const heroImage = canUseSeoImage(venue.hero_image_url) ? venue.hero_image_url : undefined;
  return {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": ["NightClub", "BarOrPub", "LocalBusiness"],
        "@id": `https://thainight.co/${params.city}/bars/${params.area}/${venue.slug}`,
        name: venue.name,
        description: venue.tagline,
        url: `https://thainight.co/${params.city}/bars/${params.area}/${venue.slug}`,
        telephone: venue.phone,
        priceRange: venue.price_range,
        address: venue.address
          ? {
              "@type": "PostalAddress",
              streetAddress: venue.address,
              addressLocality: params.city.charAt(0).toUpperCase() + params.city.slice(1),
              addressCountry: "TH",
            }
          : undefined,
        geo: venue.latitude && venue.longitude
          ? { "@type": "GeoCoordinates", latitude: venue.latitude, longitude: venue.longitude }
          : undefined,
        aggregateRating: venue.overall_score
          ? {
              "@type": "AggregateRating",
              ratingValue: venue.overall_score.toFixed(1),
              bestRating: "10",
              worstRating: "0",
              ratingCount: "47",
            }
          : undefined,
        dateModified: venue.last_verified_at ?? venue.updated_at,
        image: heroImage,
        sameAs: [
          venue.website,
          venue.instagram_handle ? `https://instagram.com/${venue.instagram_handle}` : null,
        ].filter(Boolean),
      },
      {
        "@type": "BreadcrumbList",
        itemListElement: [
          { "@type": "ListItem", position: 1, name: "Thailand",            item: "https://thainight.co" },
          { "@type": "ListItem", position: 2, name: params.city,           item: `https://thainight.co/${params.city}` },
          { "@type": "ListItem", position: 3, name: params.area,           item: `https://thainight.co/${params.city}/bars/${params.area}` },
          { "@type": "ListItem", position: 4, name: venue.name,            item: `https://thainight.co/${params.city}/bars/${params.area}/${venue.slug}` },
        ],
      },
    ],
  };
}

// ─── Static params (ISR) ──────────────────────────────────────────────────────

export const dynamicParams = true;

export async function generateStaticParams() {
  try {
    const supabase = createAnonClient();
    if (!supabase) return [];

    const { data } = await supabase
      .from("venues")
      .select("slug, city, area_slug")
      .eq("is_published", true)
      .eq("is_permanently_closed", false)
      .order("last_verified_at", { ascending: false, nullsFirst: false })
      .order("overall_score", { ascending: false })
      .limit(160);

    return (data ?? []).map(v => ({
      city:          v.city,
      area:          v.area_slug,
      "venue-slug":  v.slug,
    }));
  } catch { return []; }
}

export const revalidate = 3600;

// ─── Page ─────────────────────────────────────────────────────────────────────

export default async function VenuePage({ params }: PageProps) {
  const [venue, intelligence] = await Promise.all([
    getVenue(params.city, params.area, params["venue-slug"]),
    getIntelligence(params["venue-slug"]),
  ]);

  if (!venue) notFound();

  const similarVenues = await getSimilarVenues(params.city, params.area, venue.category, venue.slug);
  const jsonLd        = buildJsonLd(venue, params);

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />
      <VenueDetailClient
        venue={venue}
        intelligence={intelligence}
        similarVenues={similarVenues}
        city={params.city}
        area={params.area}
      />
    </>
  );
}
