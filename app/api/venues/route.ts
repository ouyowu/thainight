// app/api/venues/route.ts
// Venue feed for internal matching and trusted integrations.
// GET /api/venues
// GET /api/venues?city=bangkok
// GET /api/venues?city=bangkok&category=cocktail-bar

import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import type { VenueCategory } from "@/lib/database.types";

export const revalidate = 3600; // cache 1 hour

const VENUE_CATEGORIES: readonly VenueCategory[] = [
  "cocktail-bar",
  "rooftop-bar",
  "nightclub",
  "dive-bar",
  "wine-bar",
  "sports-bar",
  "karaoke",
  "jazz-bar",
  "hotel-bar",
  "beach-club",
];

function isVenueCategory(value: string): value is VenueCategory {
  return VENUE_CATEGORIES.includes(value as VenueCategory);
}

export async function GET(req: NextRequest): Promise<NextResponse> {
  const { searchParams } = new URL(req.url);
  const city     = searchParams.get("city");
  const category = searchParams.get("category");

  try {
    const supabase = createClient();

    let query = supabase
      .from("venues")
      .select("slug, name, city, area_slug, category, tags, overall_score")
      .eq("is_published", true)
      .eq("is_permanently_closed", false)
      .order("overall_score", { ascending: false });

    if (city)     query = query.eq("city", city);
    if (category && isVenueCategory(category)) query = query.eq("category", category);

    const { data, error } = await query;
    if (error) throw error;

    return NextResponse.json(data ?? [], {
      headers: {
        "Cache-Control": "public, s-maxage=3600, stale-while-revalidate=86400",
        "Access-Control-Allow-Origin": "*",
      },
    });
  } catch (err) {
    console.error("[/api/venues]", err);
    return NextResponse.json({ error: "Failed to fetch venues" }, { status: 500 });
  }
}
