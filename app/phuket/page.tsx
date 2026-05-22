// app/phuket/page.tsx
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
  title: "Phuket Nightlife Social Guide: Bars, Clubs & Who's Going Tonight [Updated May 2026] | ThaiNight",
  description:
    "Explore Phuket nightlife through bars, clubs, social hotspots, and venue culture across Patong, Kata, Rawai, Chalong, and Laguna. Updated May 2026.",
  alternates: { canonical: "https://thainight.co/phuket" },
};

async function getVenues(): Promise<VenueCard[]> {
  try {
    const supabase = createClient();
    const { data } = await supabase
      .from("venue_cards")
      .select("*")
      .eq("city", "phuket")
      .order("last_verified_at", { ascending: false, nullsFirst: false })
      .order("overall_score",    { ascending: false })
      .limit(60);
    return (data ?? []) as VenueCard[];
  } catch { return []; }
}

export default async function PhuketPage() {
  const [venues, events, offers, safetyIntel, priceIntel, openingsIntel] = await Promise.all([
    getVenues(),
    getUpcomingEvents({ city: "phuket", limit: 6 }),
    getApprovedOffers({ city: "phuket", limit: 6 }),
    getPublicIntel({ city: "phuket", category: "safety", limit: 4 }),
    getPublicIntel({ city: "phuket", category: "price", limit: 4 }),
    getPublicIntel({ city: "phuket", category: "new_opening", limit: 4 }),
  ]);
  return (
    <>
      <HeroSection city="phuket" />
      <div className="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
        <TonightPlanGrid
          cityName="Phuket"
          citySlug="phuket"
          events={events}
          offers={offers}
          safetyIntel={safetyIntel}
          priceIntel={priceIntel}
        />
      </div>
      <div className="mx-auto max-w-7xl px-4 pb-8 sm:px-6 lg:px-8">
        <CityNightlifeSnapshot
          cityName="Phuket"
          citySlug="phuket"
          areas={areaSummariesFromVenues(venues, 6)}
          events={events}
          offers={offers}
          safetyIntel={safetyIntel}
          priceIntel={priceIntel}
          openingsIntel={openingsIntel}
        />
      </div>
      <IntelligenceFeed city="phuket" />
      <CityVenueWall
        venues={venues}
        city="phuket"
        cityName="Phuket"
        areas={["patong","kata","rawai","chalong","laguna"]}
        areaLabels={{ patong:"Patong", kata:"Kata", rawai:"Rawai", chalong:"Chalong", laguna:"Laguna" }}
      />
    </>
  );
}
