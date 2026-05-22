// app/chiang-mai/page.tsx
import type { Metadata } from "next";
import { createClient } from "@/lib/supabase/server";
import CityVenueWall from "@/components/CityVenueWall";
import HeroSection from "@/components/HeroSection";
import IntelligenceFeed from "@/components/IntelligenceFeed";
import { CityNightlifeSnapshot } from "@/components/CityNightlifeSnapshot";
import { TonightPlanGrid } from "@/components/TonightPlanGrid";
import type { VenueCard } from "@/lib/database.types";
import {
  areaSummariesFromVenues,
  getApprovedOffers,
  getPublicIntel,
  getUpcomingEvents,
} from "@/lib/public-intel";

export const metadata: Metadata = {
  title: "Chiang Mai Nightlife Social Guide: Bars, Clubs & Who's Going Tonight [Updated May 2026] | ThaiNight",
  description:
    "Explore Chiang Mai nightlife through bars, clubs, relaxed social scenes, and venue culture across Nimman, Old City, Riverside, and Santitham. Updated May 2026.",
  alternates: { canonical: "https://thainight.co/chiang-mai" },
};

async function getVenues(): Promise<VenueCard[]> {
  try {
    const supabase = createClient();
    const { data } = await supabase
      .from("venue_cards")
      .select("*")
      .eq("city", "chiang-mai")
      .order("last_verified_at", { ascending: false, nullsFirst: false })
      .order("overall_score",    { ascending: false })
      .limit(60);
    return (data ?? []) as VenueCard[];
  } catch { return []; }
}

export default async function ChiangMaiPage() {
  const [venues, events, offers, safetyIntel, priceIntel, openingsIntel] = await Promise.all([
    getVenues(),
    getUpcomingEvents({ city: "chiang-mai", limit: 6 }),
    getApprovedOffers({ city: "chiang-mai", limit: 6 }),
    getPublicIntel({ city: "chiang-mai", category: "safety", limit: 4 }),
    getPublicIntel({ city: "chiang-mai", category: "price", limit: 4 }),
    getPublicIntel({ city: "chiang-mai", category: "new_opening", limit: 4 }),
  ]);
  return (
    <>
      <HeroSection city="chiang-mai" />
      <div className="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
        <TonightPlanGrid
          cityName="Chiang Mai"
          citySlug="chiang-mai"
          events={events}
          offers={offers}
          safetyIntel={safetyIntel}
          priceIntel={priceIntel}
        />
      </div>
      <div className="mx-auto max-w-7xl px-4 pb-8 sm:px-6 lg:px-8">
        <CityNightlifeSnapshot
          cityName="Chiang Mai"
          citySlug="chiang-mai"
          areas={areaSummariesFromVenues(venues, 6)}
          events={events}
          offers={offers}
          safetyIntel={safetyIntel}
          priceIntel={priceIntel}
          openingsIntel={openingsIntel}
        />
      </div>
      <IntelligenceFeed city="chiang-mai" />
      <CityVenueWall
        venues={venues}
        city="chiang-mai"
        cityName="Chiang Mai"
        areas={["nimman","old-city","riverside","santitham"]}
        areaLabels={{ nimman:"Nimman", "old-city":"Old City", riverside:"Riverside", santitham:"Santitham" }}
      />
    </>
  );
}
