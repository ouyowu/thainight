// app/pattaya/page.tsx
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
  title: "Pattaya Nightlife Social Guide: Bars, Clubs & Who's Going Tonight [Updated May 2026] | ThaiNight",
  description:
    "Explore Pattaya nightlife through bars, clubs, social energy, and current venue culture across Walking Street, Jomtien, Central Pattaya, and North Pattaya. Updated May 2026.",
  alternates: { canonical: "https://thainight.co/pattaya" },
};

async function getVenues(): Promise<VenueCard[]> {
  try {
    const supabase = createClient();
    const { data } = await supabase
      .from("venue_cards")
      .select("*")
      .eq("city", "pattaya")
      .order("last_verified_at", { ascending: false, nullsFirst: false })
      .order("overall_score",    { ascending: false })
      .limit(300);
    return (data ?? []) as VenueCard[];
  } catch { return []; }
}

export default async function PattayaPage() {
  const [venues, events, offers, safetyIntel, priceIntel, openingsIntel] = await Promise.all([
    getVenues(),
    getUpcomingEvents({ city: "pattaya", limit: 6 }),
    getApprovedOffers({ city: "pattaya", limit: 6 }),
    getPublicIntel({ city: "pattaya", category: "safety", limit: 4 }),
    getPublicIntel({ city: "pattaya", category: "price", limit: 4 }),
    getPublicIntel({ city: "pattaya", category: "new_opening", limit: 4 }),
  ]);
  return (
    <>
      <HeroSection city="pattaya" />
      <div className="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
        <TonightPlanGrid
          cityName="Pattaya"
          citySlug="pattaya"
          events={events}
          offers={offers}
          safetyIntel={safetyIntel}
          priceIntel={priceIntel}
        />
      </div>
      <div className="mx-auto max-w-7xl px-4 pb-8 sm:px-6 lg:px-8">
        <CityNightlifeSnapshot
          cityName="Pattaya"
          citySlug="pattaya"
          areas={areaSummariesFromVenues(venues, 6)}
          events={events}
          offers={offers}
          safetyIntel={safetyIntel}
          priceIntel={priceIntel}
          openingsIntel={openingsIntel}
        />
      </div>
      <IntelligenceFeed city="pattaya" />
      <CityVenueWall
        venues={venues}
        city="pattaya"
        cityName="Pattaya"
        areas={["walking-street","jomtien","central-pattaya","north-pattaya"]}
        areaLabels={{ "walking-street":"Walking Street", jomtien:"Jomtien", "central-pattaya":"Central Pattaya", "north-pattaya":"North Pattaya" }}
      />
    </>
  );
}
