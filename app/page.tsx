import Link from "next/link";
import type { Metadata } from "next";
import {
  ArrowRight,
  Mail,
  MapPin,
  Megaphone,
  ShieldCheck,
  Sparkles,
} from "lucide-react";
import { CITY_CONFIGS, type CitySlug } from "@/lib/cities";
import { createAnonClient, createServerClient } from "@/lib/supabase/server";
import { siteBaseUrl } from "@/lib/config";
import type { EventFlyerRow, IntelligenceFeedRow, VenueOfferRow } from "@/lib/database.types";
import { HomeSearchHero } from "@/components/HomeSearchHero";
import { HomeMembershipHero } from "@/components/HomeMembershipHero";
import { SocialHub } from "@/components/SocialHub";
import { TrendingIntelSections } from "@/components/TrendingIntelSections";
import { IntelSubmissionPanel } from "@/components/IntelSubmissionPanel";
import { SiteFooter } from "@/components/SiteFooter";
import { canRenderPublicImage } from "@/lib/media";
import { NightlifeBriefSignup } from "@/components/NightlifeBriefSignup";
import { getApprovedOffers, getPublicIntel, getUpcomingEvents } from "@/lib/public-intel";
import { GoingTonightGateway } from "@/components/GoingTonightGateway";
import { PriorityNetworkLinks } from "@/components/PriorityNetworkLinks";
import { PriorityFaq } from "@/components/PriorityFaq";

type CityImageMap = Partial<Record<CitySlug, string>>;

function formatHomepageUpdatedAt(items: Array<{ created_at?: string | null; received_at?: string | null; updated_at?: string | null }>): string {
  const latest = items
    .flatMap((item) => [item.received_at, item.updated_at, item.created_at])
    .filter((value): value is string => Boolean(value))
    .map((value) => new Date(value))
    .filter((date) => !Number.isNaN(date.getTime()))
    .sort((a, b) => b.getTime() - a.getTime())[0];

  const date = latest ?? new Date();

  return new Intl.DateTimeFormat("en", {
    timeZone: "Asia/Bangkok",
    month: "short",
    day: "numeric",
    hour: "numeric",
    minute: "2-digit",
  }).format(date);
}

export const metadata: Metadata = {
  title: "Thailand Nightlife Guide [Updated May 2026] | ThaiNight",
  description:
    "Track nightlife across Bangkok, Pattaya, Phuket, and Chiang Mai with fresh venue verification, social momentum, events, and special offers.",
  alternates: {
    canonical: `${siteBaseUrl()}/`,
  },
};

async function getCityImages(): Promise<CityImageMap> {
  const supabase = createAnonClient();
  if (!supabase) return {};

  const map: CityImageMap = {};
  for (const city of CITY_CONFIGS) {
    const { data } = await supabase
      .from("venues")
      .select("hero_image_url")
      .eq("city", city.slug)
      .eq("is_published", true)
      .not("hero_image_url", "is", null)
      .order("overall_score", { ascending: false })
      .limit(1)
      .maybeSingle();

    if (data?.hero_image_url && canRenderPublicImage(data.hero_image_url)) {
      map[city.slug] = data.hero_image_url;
    }
  }
  return map;
}

async function getMembershipImages(): Promise<string[]> {
  const supabase = createAnonClient();
  if (!supabase) return [];

  const { data } = await supabase
    .from("venues")
    .select("hero_image_url")
    .eq("is_published", true)
    .not("hero_image_url", "is", null)
    .order("overall_score", { ascending: false })
    .limit(8);

  return (data ?? [])
    .map((venue) => venue.hero_image_url)
    .filter((url): url is string => canRenderPublicImage(url));
}

async function getCuratedIntel(): Promise<{
  events: EventFlyerRow[];
  offers: VenueOfferRow[];
  safetyIntel: IntelligenceFeedRow[];
  priceIntel: IntelligenceFeedRow[];
  openingsIntel: IntelligenceFeedRow[];
}> {
  const [events, offers, safetyIntel, priceIntel, openingsIntel] = await Promise.all([
    getUpcomingEvents({ limit: 9 }),
    getApprovedOffers({ limit: 6 }),
    getPublicIntel({ category: "safety", limit: 12 }),
    getPublicIntel({ category: "price", limit: 12 }),
    getPublicIntel({ category: "new_opening", limit: 12 }),
  ]);

  return {
    events,
    offers,
    safetyIntel,
    priceIntel,
    openingsIntel,
  };
}

export default async function HomePage() {
  const authClient = createServerClient();
  const [cityImages, membershipImages, curatedIntel, authResult] = await Promise.all([
    getCityImages(),
    getMembershipImages(),
    getCuratedIntel(),
    authClient?.auth.getUser() ?? Promise.resolve({ data: { user: null } }),
  ]);
  const homepageUpdatedAt = formatHomepageUpdatedAt([
    ...curatedIntel.events,
    ...curatedIntel.offers,
    ...curatedIntel.safetyIntel,
    ...curatedIntel.priceIntel,
    ...curatedIntel.openingsIntel,
  ]);

  const baseUrl = siteBaseUrl();
  const siteJsonLd = {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "Organization",
        "@id": `${baseUrl}/#organization`,
        name: "ThaiNight",
        url: baseUrl,
        email: "ouyowu@gmail.com",
      },
      {
        "@type": "WebSite",
        "@id": `${baseUrl}/#website`,
        url: baseUrl,
        name: "ThaiNight",
        publisher: {
          "@id": `${baseUrl}/#organization`,
        },
        potentialAction: {
          "@type": "SearchAction",
          target: `${baseUrl}/bangkok?search={search_term_string}`,
          "query-input": "required name=search_term_string",
        },
      },
    ],
  };

  return (
    <main className="mx-auto flex min-h-screen max-w-[1440px] flex-col gap-12 px-4 py-4 sm:px-6 sm:py-6 lg:px-8">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(siteJsonLd) }}
      />
      <HomeSearchHero signedIn={Boolean(authResult.data.user)} lastUpdated={homepageUpdatedAt} />
      <GoingTonightGateway />
      <NightlifeBriefSignup />
      <SocialHub />
      <TrendingIntelSections
        curatedEvents={curatedIntel.events}
        curatedOffers={curatedIntel.offers}
      />
      <IntelSubmissionPanel />
      <HomeMembershipHero imageStrip={membershipImages} />

      <section className="space-y-5">
        <div className="flex items-end justify-between gap-4">
          <div>
            <p className="text-xs font-semibold uppercase tracking-widest text-amber-300">
              Explore by city
            </p>
            <h2 className="mt-2 text-3xl font-black tracking-tight text-white sm:text-4xl">
              Pick your nightlife base
            </h2>
          </div>
          <span className="hidden text-sm text-zinc-500 sm:block">
            Verified venue walls by freshness and fit
          </span>
        </div>

        <div className="grid gap-4 lg:grid-cols-4">
          {CITY_CONFIGS.map((city) => (
            <Link
              key={city.slug}
              href={city.href}
              className="group relative min-h-[320px] overflow-hidden rounded-2xl border border-zinc-800 bg-zinc-900"
            >
              {cityImages[city.slug] ? (
                <div
                  className="absolute inset-0 bg-cover bg-center transition duration-700 group-hover:scale-105"
                  style={{ backgroundImage: `url(${cityImages[city.slug]})` }}
                />
              ) : (
                <div className={`absolute inset-0 bg-gradient-to-br ${city.accent}`} />
              )}
              <div className="absolute inset-0 bg-gradient-to-t from-black via-black/55 to-black/15" />
              <div className="relative flex h-full flex-col justify-between p-5">
                <div className="flex items-center justify-between">
                  <span className="inline-flex items-center gap-2 rounded-full border border-white/15 bg-black/40 px-3 py-1 text-xs font-semibold text-white/90 backdrop-blur">
                    <MapPin className="h-3.5 w-3.5" />
                    {city.region}
                  </span>
                  <span className="rounded-full bg-white/10 px-2.5 py-1 text-[11px] font-semibold text-white/85">
                    {city.targetVenueCount}+ target
                  </span>
                </div>

                <div>
                  <h3 className="text-3xl font-black tracking-tight text-white">{city.name}</h3>
                  <p className="mt-3 line-clamp-3 text-sm leading-6 text-white/80">{city.description}</p>
                  <div className="mt-5 flex items-center justify-between border-t border-white/15 pt-4 text-sm">
                    <span className="inline-flex items-center gap-2 font-semibold text-emerald-200">
                      <ShieldCheck className="h-4 w-4" />
                      Updated May 2026
                    </span>
                    <span className="inline-flex items-center gap-1 font-bold text-white">
                      Open city
                      <ArrowRight className="h-4 w-4 transition group-hover:translate-x-1" />
                    </span>
                  </div>
                </div>
              </div>
            </Link>
          ))}
        </div>
      </section>

      <PriorityNetworkLinks
        title="Start with a city, then follow the highest-intent nightlife sections"
        description="For early indexing and easier browsing, ThaiNight keeps a clear spine between the homepage, four city guides, and the sections travelers use most often before going out."
      />

      <PriorityFaq
        pageUrl="/"
        title="Questions travelers usually have before they start on ThaiNight"
        intro="The homepage should answer the broadest nightlife planning questions first, then send people into a city guide or high-intent section without making them guess where to click next."
        items={[
          {
            question: "What should I click first on ThaiNight?",
            answer:
              "Start with the city you are actually going out in. Bangkok, Pattaya, Phuket, and Chiang Mai each have different nightlife patterns, venue types, and risk signals.",
          },
          {
            question: "When should I use Tonight instead of a city guide?",
            answer:
              "Use Tonight when you need a fast same-night answer. Use a city guide when you want area context, venue type comparisons, and a broader nightlife plan.",
          },
          {
            question: "Why does ThaiNight keep linking back to source material?",
            answer:
              "Nightlife changes quickly. Source links help travelers verify event timing, guest lists, deals, and venue claims before they spend money or move around the city.",
          },
        ]}
        nextSteps={[
          {
            href: "/bangkok",
            label: "Start with Bangkok",
            description: "Best first click for users planning around Sukhumvit, Thonglor, Silom, RCA, rooftops, and late-night neighborhoods.",
          },
          {
            href: "/tonight",
            label: "Open tonight's fast planner",
            description: "Use events, offers, warnings, and people flow when you need a quick same-night nightlife plan.",
          },
          {
            href: "/intel",
            label: "See the reviewed intel library",
            description: "Best follow-up when you want warnings, openings, price notes, and nightlife signals in one place.",
          },
        ]}
      />

      <section className="overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-950">
        <div className="grid lg:grid-cols-[0.9fr_1.1fr]">
          <div className="min-h-[320px] bg-[linear-gradient(135deg,rgba(24,24,27,0.96),rgba(17,24,39,0.8)),radial-gradient(circle_at_30%_20%,rgba(251,191,36,0.26),transparent_55%)] p-6 sm:p-8">
            <p className="inline-flex items-center gap-2 text-xs font-semibold uppercase tracking-widest text-amber-300">
              <Megaphone className="h-4 w-4" />
              Venue partners
            </p>
            <h2 className="mt-4 max-w-xl text-3xl font-black tracking-tight text-white sm:text-4xl">
              Are you a bar or nightclub owner?
            </h2>
            <p className="mt-4 max-w-xl text-sm leading-7 text-zinc-300">
              ThaiNight can help with featured placement, venue advertising, and reservation-system development for nightlife operators.
            </p>
          </div>

          <div className="flex flex-col justify-center gap-5 border-t border-zinc-800 p-6 sm:p-8 lg:border-l lg:border-t-0">
            {[
              "Venue advertising and featured placements",
              "Custom reservation systems and booking flows",
              "Partner visibility across guides and city pages",
              "Lead capture for tourists, expats, and local nightlife seekers",
            ].map((item) => (
              <div key={item} className="flex items-start gap-3 text-sm leading-7 text-zinc-300">
                <Sparkles className="mt-1 h-4 w-4 shrink-0 text-amber-300" />
                <span>{item}</span>
              </div>
            ))}
            <a
              href="mailto:ouyowu@gmail.com?subject=ThaiNight%20venue%20partnership"
              className="mt-2 inline-flex w-fit items-center gap-2 rounded-xl bg-blue-600 px-5 py-3 text-sm font-bold text-white transition hover:bg-blue-500"
            >
              <Mail className="h-4 w-4" />
              Contact ouyowu@gmail.com
            </a>
          </div>
        </div>
      </section>
      <SiteFooter />
    </main>
  );
}
