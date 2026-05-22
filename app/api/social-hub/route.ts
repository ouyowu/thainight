import { NextResponse } from "next/server";
import { createAnonClient } from "@/lib/supabase/server";

// Context: ThaiNight Live Social Hub | Current Date: May 2026 | Homepage nightlife momentum.

export const revalidate = 300;

export async function GET(): Promise<NextResponse> {
  const supabase = createAnonClient();
  if (!supabase) return NextResponse.json({ venues: [] });

  const { data: venues, error } = await supabase
    .from("venues")
    .select("id, slug, name, city, area_slug, category, hero_image_url, overall_score, social_enabled, is_trending")
    .eq("is_published", true)
    .or("social_enabled.eq.true,is_trending.eq.true")
    .order("is_trending", { ascending: false })
    .order("overall_score", { ascending: false })
    .limit(12);

  if (error || !venues) {
    return NextResponse.json({ venues: [] });
  }

  const ids = venues.map((venue) => venue.id);
  const today = new Date().toISOString().slice(0, 10);
  const { data: interests } = await supabase
    .from("venue_social_interests")
    .select("venue_id")
    .in("venue_id", ids)
    .eq("interest_date", today);

  const counts = new Map<string, number>();
  for (const interest of interests ?? []) {
    counts.set(interest.venue_id, (counts.get(interest.venue_id) ?? 0) + 1);
  }

  return NextResponse.json({
    venues: venues.map((venue) => ({
      ...venue,
      tonight_count: counts.get(venue.id) ?? 0,
    })),
  }, {
    headers: {
      "Cache-Control": "public, s-maxage=300, stale-while-revalidate=900",
    },
  });
}
