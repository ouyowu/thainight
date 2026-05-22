// app/bangkok/page.tsx
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
  title: "Bangkok Nightlife Social Guide: Bars, Clubs & Who's Going Tonight [Updated May 2026] | ThaiNight",
  description:
    "Explore Bangkok nightlife through bars, clubs, live music, events, and tonight's social momentum across Thonglor, Silom, Ekkamai, Asok, Ari, RCA, and Sathorn. Updated May 2026.",
  alternates: { canonical: "https://thainight.co/bangkok" },
};

const JSON_LD = {
  "@context": "https://schema.org",
  "@type": "CollectionPage",
  name: "Bangkok Nightlife Guide [Updated May 2026]",
  url: "https://thainight.co/bangkok",
  breadcrumb: {
    "@type": "BreadcrumbList",
    itemListElement: [
      { "@type": "ListItem", position: 1, name: "Thailand", item: "https://thainight.co" },
      { "@type": "ListItem", position: 2, name: "Bangkok",  item: "https://thainight.co/bangkok" },
    ],
  },
};

async function getVenues(): Promise<VenueCard[]> {
  try {
    const supabase = createClient();
    const { data } = await supabase
      .from("venue_cards")
      .select("*")
      .eq("city", "bangkok")
      .order("last_verified_at", { ascending: false, nullsFirst: false })
      .order("overall_score",    { ascending: false })
      .limit(100);
    return (data ?? []) as VenueCard[];
  } catch { return []; }
}

export default async function BangkokPage() {
  const [venues, events, offers, safetyIntel, priceIntel, openingsIntel] = await Promise.all([
    getVenues(),
    getUpcomingEvents({ city: "bangkok", limit: 6 }),
    getApprovedOffers({ city: "bangkok", limit: 6 }),
    getPublicIntel({ city: "bangkok", category: "safety", limit: 4 }),
    getPublicIntel({ city: "bangkok", category: "price", limit: 4 }),
    getPublicIntel({ city: "bangkok", category: "new_opening", limit: 4 }),
  ]);
  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(JSON_LD) }} />
      <HeroSection city="bangkok" />
      <div className="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
        <TonightPlanGrid
          cityName="Bangkok"
          citySlug="bangkok"
          events={events}
          offers={offers}
          safetyIntel={safetyIntel}
          priceIntel={priceIntel}
        />
      </div>
      <div className="mx-auto max-w-7xl px-4 pb-8 sm:px-6 lg:px-8">
        <CityNightlifeSnapshot
          cityName="Bangkok"
          citySlug="bangkok"
          areas={areaSummariesFromVenues(venues, 6)}
          events={events}
          offers={offers}
          safetyIntel={safetyIntel}
          priceIntel={priceIntel}
          openingsIntel={openingsIntel}
        />
      </div>
      <IntelligenceFeed city="bangkok" />
      <CityVenueWall
        venues={venues}
        city="bangkok"
        cityName="Bangkok"
        areas={["thonglor","silom","ekkamai","asok","ari","rca","sathorn"]}
        areaLabels={{ thonglor:"Thonglor", silom:"Silom", ekkamai:"Ekkamai", asok:"Asok", ari:"Ari", rca:"RCA", sathorn:"Sathorn" }}
      />
    </>
  );
}
