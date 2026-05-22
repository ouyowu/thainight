import Link from "next/link";
import type { Metadata } from "next";
import { notFound } from "next/navigation";
import {
  ArrowRight,
  CheckCircle2,
  Clock,
  MapPin,
  ShieldAlert,
  Star,
} from "lucide-react";
import { getCityConfig, getCityStaticParams } from "@/lib/cities";
import { getStaticVenueCardsForCity } from "@/lib/fallback-nightlife";
import type { VenueCard } from "@/lib/database.types";
import { createAnonClient } from "@/lib/supabase/server";
import { getThaiNightSignals } from "@/lib/thainight-signals";
import { ThaiNightSignalFeed } from "@/components/ThaiNightSignalFeed";
import { CityNightlifeSnapshot } from "@/components/CityNightlifeSnapshot";
import { TonightPlanGrid } from "@/components/TonightPlanGrid";
import { PriorityNetworkLinks } from "@/components/PriorityNetworkLinks";
import { PriorityFaq } from "@/components/PriorityFaq";
import { absoluteTitle, formatCategoryName } from "@/lib/seo";
import { siteBaseUrl } from "@/lib/config";
import {
  areaSummariesFromVenues,
  getApprovedOffers,
  getPublicIntel,
  getUpcomingEvents,
} from "@/lib/public-intel";

const CITY_METADATA: Record<
  string,
  {
    title: string;
    description: string;
    ogTitle: string;
    ogDescription: string;
  }
> = {
  bangkok: {
    title: "Bangkok Nightlife Guide 2026: Areas, Bars, Events & Warnings",
    description:
      "Plan Bangkok nightlife with Thonglor, Silom, Sukhumvit, RCA, rooftop bars, approved events, price tips, and late-night warning signals.",
    ogTitle: "Bangkok Nightlife Guide: areas, events, and smarter late-night planning",
    ogDescription:
      "Use Bangkok neighborhood context, event signals, and nightlife warnings to build a better plan before tonight starts.",
  },
  pattaya: {
    title: "Pattaya Nightlife Guide 2026: Walking Street, Bars & Risk Signals",
    description:
      "Compare Walking Street, Soi Buakhao, beach clubs, beer bars, and Pattaya nightlife warnings before choosing where to go tonight.",
    ogTitle: "Pattaya nightlife guide: strip choices, risks, and late-night planning",
    ogDescription:
      "Use Pattaya area fit, tourist-risk notes, and nightlife momentum to choose better bars, clubs, and streets.",
  },
  phuket: {
    title: "Phuket Nightlife Guide 2026: Bangla Road, Beach Clubs & Night Plans",
    description:
      "Plan Phuket nightlife with Patong, Bangla Road, beach clubs, sunset bars, island logistics, and nightlife safety notes.",
    ogTitle: "Phuket nightlife guide: Bangla Road, beach clubs, and island-night planning",
    ogDescription:
      "Compare Patong nightlife, beach clubs, transport friction, and Phuket warning signals before heading out.",
  },
  "chiang-mai": {
    title: "Chiang Mai Nightlife Guide 2026: Nimman, Old City & Live Music",
    description:
      "Explore Chiang Mai nightlife through Nimman, Old City, jazz rooms, live music bars, craft beer spots, and lower-friction late-night routes.",
    ogTitle: "Chiang Mai nightlife guide: Nimman, Old City, and slower late-night routes",
    ogDescription:
      "Use neighborhood fit, live-music context, and quieter nightlife signals to plan a better Chiang Mai night out.",
  },
};

export function generateStaticParams() {
  return getCityStaticParams();
}

async function getCityVenues(citySlug: string, limit = 120): Promise<VenueCard[]> {
  const supabase = createAnonClient();

  if (supabase) {
    const { data, error } = await supabase
      .from("venue_cards")
      .select("*")
      .eq("city", citySlug)
      .order("last_verified_at", { ascending: false, nullsFirst: false })
      .order("overall_score", { ascending: false })
      .limit(limit);

    if (!error && data?.length) {
      return data;
    }
  }

  return getStaticVenueCardsForCity(citySlug).slice(0, limit);
}

export async function generateMetadata({
  params,
}: {
  params: { city: string };
}): Promise<Metadata> {
  const city = getCityConfig(params.city);
  if (!city) return { title: "City Not Found" };
  const meta = CITY_METADATA[city.slug] ?? {
    title: `${city.name} Bars & Nightlife Guide [Updated May 2026]`,
    description: `${city.name} nightlife social guide with bars, clubs, live venues, tonight's crowd signals, verified updates, and culture-aware venue intelligence. Updated May 2026.`,
    ogTitle: `${city.name} nightlife guide`,
    ogDescription: `${city.name} nightlife guide with fresh venue, event, and nightlife-planning context.`,
  };
  const canonical = `${siteBaseUrl()}/${city.slug}`;

  return {
    title: absoluteTitle(meta.title),
    description: meta.description,
    alternates: {
      canonical,
    },
    openGraph: {
      title: meta.ogTitle,
      description: meta.ogDescription,
      url: canonical,
      siteName: "ThaiNight",
      locale: "en_TH",
      type: "website",
    },
    twitter: {
      card: "summary_large_image",
      title: meta.ogTitle,
      description: meta.ogDescription,
    },
  };
}

function scoreColor(score: number | null): string {
  if (score === null) return "text-zinc-500";
  if (score >= 8) return "text-emerald-300";
  if (score >= 6) return "text-amber-300";
  return "text-rose-300";
}

function venueHref(city: string, venue: VenueCard): string {
  const broadCategory =
    venue.category === "nightclub" && venue.tags.includes("gentlemen-club")
      ? "gentlemen-clubs"
      : "bars";
  return `/${city}/${broadCategory}/${venue.area_slug}/${venue.slug}`;
}

function VenueWallCard({
  city,
  venue,
}: {
  city: string;
  venue: VenueCard;
}) {
  return (
    <Link
      href={venueHref(city, venue)}
      className="group flex min-h-44 flex-col justify-between rounded-lg border border-zinc-800 bg-zinc-900/60 p-4 transition hover:border-amber-400/50 hover:bg-zinc-900"
    >
      <div>
        <div className="mb-3 flex items-start justify-between gap-3">
          <div>
            <h2 className="text-lg font-bold leading-tight text-white group-hover:text-amber-200">
              {venue.name}
            </h2>
            <p className="mt-1 text-xs capitalize text-zinc-500">
              {venue.area_name ?? venue.area_slug} ·{" "}
              {formatCategoryName(venue.category)}
            </p>
          </div>
          {venue.overall_score !== null && (
            <div className="rounded-lg border border-zinc-700 bg-zinc-950 px-2 py-1 text-right">
              <span
                className={`block font-mono text-lg font-black ${scoreColor(
                  venue.overall_score
                )}`}
              >
                {venue.overall_score.toFixed(1)}
              </span>
              <span className="block text-[10px] text-zinc-600">score</span>
            </div>
          )}
        </div>

        {venue.tagline && (
          <p className="line-clamp-2 text-sm leading-relaxed text-zinc-400">
            {venue.tagline}
          </p>
        )}
      </div>

      <div className="mt-5 flex items-center justify-between gap-3 border-t border-zinc-800 pt-3">
        <span className="inline-flex items-center gap-1.5 text-xs text-zinc-500">
          <Clock className="size-3.5" aria-hidden />
          {venue.days_since_verified === null
            ? "Freshness pending"
            : `${venue.days_since_verified}d verified`}
        </span>
        {venue.is_verified_this_week && (
          <span className="inline-flex items-center gap-1.5 text-xs font-semibold text-emerald-300">
            <span className="relative flex size-2">
              <span className="absolute inline-flex size-full animate-ping rounded-full bg-emerald-400 opacity-75" />
              <span className="relative inline-flex size-2 rounded-full bg-emerald-400" />
            </span>
            Verified
          </span>
        )}
      </div>
    </Link>
  );
}

export default async function CityPage({
  params,
}: {
  params: { city: string };
}) {
  const city = getCityConfig(params.city);
  if (!city) notFound();

  const [venues, signals, events, offers, safetyIntel, priceIntel, openingsIntel] = await Promise.all([
    getCityVenues(city.slug),
    getThaiNightSignals({ city: city.slug, limit: 6, minValue: 0.5 }),
    getUpcomingEvents({ city: city.slug, limit: 6 }),
    getApprovedOffers({ city: city.slug, limit: 6 }),
    getPublicIntel({ city: city.slug, category: "safety", limit: 4 }),
    getPublicIntel({ city: city.slug, category: "price", limit: 4 }),
    getPublicIntel({ city: city.slug, category: "new_opening", limit: 4 }),
  ]);
  const areas = areaSummariesFromVenues(venues, 6);
  const verifiedCount = venues.filter((venue) => venue.is_verified_this_week).length;
  const scored = venues.filter((venue) => venue.overall_score !== null);
  const averageScore =
    scored.length > 0
      ? scored.reduce((sum, venue) => sum + (venue.overall_score ?? 0), 0) /
        scored.length
      : null;
  const baseUrl = siteBaseUrl();
  const cityUrl = `${baseUrl}/${city.slug}`;
  const cityJsonLd = {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": ["Place", "ItemList"],
        "@id": `${cityUrl}#place`,
        name: `${city.name} Nightlife Guide`,
        url: cityUrl,
        dateModified: new Date().toISOString(),
        numberOfItems: venues.length,
        itemListElement: venues.slice(0, 24).map((venue, index) => ({
          "@type": "ListItem",
          position: index + 1,
          url: `${baseUrl}${venueHref(city.slug, venue)}`,
          name: venue.name,
        })),
      },
    ],
  };

  return (
    <main className="mx-auto min-h-screen max-w-7xl px-4 py-8 sm:py-10">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(cityJsonLd) }}
      />
      <header className="mb-8 grid gap-6 lg:grid-cols-[1fr_360px]">
        <div>
          <nav className="mb-5 flex items-center gap-2 text-xs text-zinc-600">
            <Link href="/" className="hover:text-zinc-300">
              ThaiNight
            </Link>
            <ArrowRight className="size-3" aria-hidden />
            <span className="text-zinc-400">{city.name}</span>
          </nav>
          <p className="mb-2 text-sm uppercase tracking-widest text-amber-400">
            {city.region}
          </p>
          <h1 className="text-balance text-4xl font-black tracking-tight text-white md:text-6xl">
            Tonight in {city.name}: nightlife areas, events, people, and safety tips
          </h1>
          <p className="mt-4 max-w-3xl text-lg leading-relaxed text-zinc-400">
            {city.description}
          </p>
          <div className="mt-6 flex flex-col gap-3 sm:flex-row">
            <Link
              href="/tonight"
              className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl bg-rose-500 px-5 text-sm font-black text-white transition hover:bg-rose-400"
            >
              See who is going out tonight
              <ArrowRight className="h-4 w-4" />
            </Link>
            <Link
              href="/profile"
              className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl border border-zinc-700 bg-zinc-900 px-5 text-sm font-black text-zinc-100 transition hover:border-zinc-500 hover:bg-zinc-800"
            >
              Post your plan
            </Link>
          </div>
        </div>

        <section className="grid grid-cols-2 gap-3">
          <div className="rounded-lg border border-zinc-800 bg-zinc-900/60 p-4">
            <MapPin className="mb-3 size-5 text-amber-300" aria-hidden />
            <p className="text-2xl font-black text-white">{venues.length}</p>
            <p className="text-xs text-zinc-500">venues loaded</p>
          </div>
          <div className="rounded-lg border border-zinc-800 bg-zinc-900/60 p-4">
            <CheckCircle2 className="mb-3 size-5 text-emerald-300" aria-hidden />
            <p className="text-2xl font-black text-white">{verifiedCount}</p>
            <p className="text-xs text-zinc-500">verified this week</p>
          </div>
          <div className="rounded-lg border border-zinc-800 bg-zinc-900/60 p-4">
            <Star className="mb-3 size-5 text-amber-300" aria-hidden />
            <p className="text-2xl font-black text-white">
              {averageScore === null ? "—" : averageScore.toFixed(1)}
            </p>
            <p className="text-xs text-zinc-500">avg score</p>
          </div>
          <div className="rounded-lg border border-zinc-800 bg-zinc-900/60 p-4">
            <ShieldAlert className="mb-3 size-5 text-rose-300" aria-hidden />
            <p className="text-2xl font-black text-white">
              {city.targetVenueCount}
            </p>
            <p className="text-xs text-zinc-500">crawl target</p>
          </div>
        </section>
      </header>

      <div className="mb-8">
        <PriorityNetworkLinks
          title={`Use ${city.name} as a base, then branch into tonight, events, offers, and intel`}
          description={`This city page is one of ThaiNight's strongest entry points. From here, users should be able to move into tonight planning, approved events, active offers, and reviewed nightlife intel without losing the ${city.name} context.`}
          currentCity={city.slug}
          hubLinks={[
            {
              href: "/tonight",
              label: "Tonight",
              description: `Fast planning page for ${city.name} and the rest of Thailand.`,
            },
            {
              href: "/events",
              label: "Events",
              description: `Approved nightlife flyers and guest-list signals tied to ${city.name}.`,
            },
            {
              href: "/offers",
              label: "Offers",
              description: `Happy hours, free-entry windows, and venue deals for ${city.name}.`,
            },
            {
              href: "/intel",
              label: "Intel",
              description: `Openings, warnings, and price notes that shape going out in ${city.name}.`,
            },
            {
              href: "/news",
              label: "News",
              description: `Thailand nightlife updates that support planning around ${city.name}.`,
            },
          ]}
        />
      </div>

      <div className="mb-8">
        <TonightPlanGrid
          cityName={city.name}
          citySlug={city.slug}
          events={events}
          offers={offers}
          safetyIntel={safetyIntel}
          priceIntel={priceIntel}
        />
      </div>

      <div className="mb-8">
        <CityNightlifeSnapshot
          cityName={city.name}
          citySlug={city.slug}
          areas={areas}
          events={events}
          offers={offers}
          safetyIntel={safetyIntel}
          priceIntel={priceIntel}
          openingsIntel={openingsIntel}
        />
      </div>

      <div className="mb-8">
        <PriorityFaq
          pageUrl={`/${city.slug}`}
          title={`${city.name} nightlife FAQ and best next clicks`}
          intro={`This city page should answer the broad planning questions first, then move users into tonight planning, approved events, active offers, and reviewed nightlife intel without losing the ${city.name} context.`}
          items={[
            {
              question: `What should I check first in ${city.name}?`,
              answer: `Start with Tonight if you need a same-night answer. If you are still choosing areas or venue types, browse the main ${city.name} nightlife wall first.`,
            },
            {
              question: `How does ThaiNight rank nightlife options in ${city.name}?`,
              answer:
                "ThaiNight favors freshness, recent verification, nightlife fit, area context, and venue quality signals instead of relying on one raw popularity metric.",
            },
            {
              question: `Where should I go after the ${city.name} guide?`,
              answer:
                "Most users should continue into Tonight, Events, Offers, or Intel depending on whether they need immediate plans, party listings, deal hunting, or reviewed warnings and openings.",
            },
          ]}
          nextSteps={[
            {
              href: "/tonight",
              label: `Plan tonight in ${city.name}`,
              description: `Best next click when you need fast same-night planning after reviewing the ${city.name} guide.`,
            },
            {
              href: "/events",
              label: "Check approved events",
              description: `Use this after the city guide when you want guest lists, flyers, and nightlife momentum tied to ${city.name}.`,
            },
            {
              href: "/intel",
              label: "Review warnings and openings",
              description: `Best follow-up if you want price context, safety notes, and new venue signals around ${city.name}.`,
            },
          ]}
        />
      </div>

      <div className="mb-8">
        <ThaiNightSignalFeed
          signals={signals}
          title={`${city.name} traveler signals`}
          emptyText={`ThaiNight has not found fresh ${city.name} nightlife signals yet.`}
        />
      </div>

      {venues.length > 0 ? (
        <section className="grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
          {venues.map((venue) => (
            <VenueWallCard key={venue.id} city={city.slug} venue={venue} />
          ))}
        </section>
      ) : (
        <section className="rounded-lg border border-dashed border-zinc-700 bg-zinc-900/40 p-8 text-center">
          <h2 className="text-2xl font-black text-white">
            {city.name} import queue is ready
          </h2>
          <p className="mx-auto mt-3 max-w-2xl text-sm leading-relaxed text-zinc-400">
            This city wall is wired. The next step is to import roughly{" "}
            {city.seedVenueCount} verified venues into Supabase, then the cards
            will appear here automatically.
          </p>
        </section>
      )}
    </main>
  );
}
