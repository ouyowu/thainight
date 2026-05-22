// app/[city]/bars/[area]/page.tsx
// Bangkok Nightlife Intelligence — Area Guide Page
// Route: /bangkok/bars/thonglor, /bangkok/bars/silom, etc.
// SEO target: "[Area] Bars", "[Area] Nightlife 2026", "[Area] Cocktail Bars Bangkok"

import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import {
  MapPin, Clock, TrendingUp, ChevronRight, Star,
  Moon, Users, Zap, Send,
  CheckCircle2, MessageCircle, ArrowRight,
} from "lucide-react";
import { createAnonClient } from "@/lib/supabase/server";
import type { VenueCard, AreaRow } from "@/lib/database.types";
import {
  getStaticAreaOrNull,
  getStaticVenueCardsForArea,
} from "@/lib/fallback-nightlife";
import { siteBaseUrl } from "@/lib/config";
import { absoluteTitle, generateMetaTitle } from "@/lib/seo";

// ─── Types ────────────────────────────────────────────────────────────────────

interface PageProps {
  params: { city: string; area: string };
}

// ─── Data Fetching ────────────────────────────────────────────────────────────

async function getAreaData(areaSlug: string): Promise<AreaRow | null> {
  const supabase = createAnonClient();
  if (supabase) {
    const { data } = await supabase
      .from("areas")
      .select("*")
      .eq("slug", areaSlug)
      .single();
    if (data) return data;
  }
  return getStaticAreaOrNull(areaSlug);
}

async function getAreaVenues(
  city: string,
  areaSlug: string,
  limit = 10
): Promise<VenueCard[]> {
  const supabase = createAnonClient();
  if (supabase) {
    const { data } = await supabase
      .from("venue_cards")
      .select("*")
      .eq("city", city)
      .eq("area_slug", areaSlug)
      .order("last_verified_at", { ascending: false, nullsFirst: false })
      .order("overall_score", { ascending: false })
      .limit(limit);
    if (data?.length) return data;
  }
  return getStaticVenueCardsForArea(city, "bars", areaSlug).slice(0, limit);
}

async function getAreaStats(venues: VenueCard[]) {
  if (!venues.length) return null;
  const scored = venues.filter((v) => v.overall_score !== null);
  return {
    totalVenues: venues.length,
    avgScore: scored.length
      ? scored.reduce((s, v) => s + (v.overall_score ?? 0), 0) / scored.length
      : 0,
    verifiedCount: venues.filter((v) => v.is_verified_this_week).length,
    avgForeignerScore:
      venues
        .filter((v) => v.score_foreigner_friendly !== null)
        .reduce((s, v) => s + (v.score_foreigner_friendly ?? 0), 0) /
      Math.max(1, venues.filter((v) => v.score_foreigner_friendly !== null).length),
  };
}

// ─── Metadata ─────────────────────────────────────────────────────────────────

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const area = await getAreaData(params.area);
  if (!area) return { title: "Area Not Found" };

  const areaName = area.name;
  const cityName = params.city.replace(/-/g, " ").replace(/\b\w/g, c => c.toUpperCase());
  const month = "May 2026"; // keep dynamic in prod: format(new Date(), 'MMM yyyy')
  const title = generateMetaTitle({
    type: "area",
    location: areaName,
  });

  return {
    title: absoluteTitle(title),
    description:
      area.description ??
      `Best bars and nightlife in ${areaName}, ${cityName}. Foreigner-friendly scores, price transparency ratings, and real-time verified data. Updated ${month}.`,
    openGraph: {
      title,
      description: `Ranked bars, honest scores, no tourist traps. ${areaName}, ${cityName}.`,
      type: "website",
    },
    alternates: {
      canonical: `${siteBaseUrl()}/${params.city}/bars/${params.area}`,
    },
  };
}

// ─── Static Params (ISR-compatible) ───────────────────────────────────────────

export async function generateStaticParams() {
  // In production, fetch from Supabase areas table
  const areas = [
    "thonglor", "silom", "ekkamai", "asok", "ari",
    "rca", "khao-san", "sathorn", "sukhumvit", "latkrabang",
  ];
  return areas.map((area) => ({ city: "bangkok", area }));
}

// ─── Sub-components ───────────────────────────────────────────────────────────

function VerifiedDot({ isVerified }: { isVerified: boolean }) {
  if (!isVerified) return null;
  return (
    <span className="relative flex h-2 w-2">
      <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75" />
      <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500" />
    </span>
  );
}

function PriceTag({ range }: { range: string | null }) {
  if (!range) return null;
  return (
    <span className="text-xs font-mono text-emerald-400 bg-emerald-500/10 border border-emerald-500/20 px-2 py-0.5 rounded">
      {range}
    </span>
  );
}

function ScorePill({ score, label }: { score: number | null; label: string }) {
  if (score === null) return null;
  const color =
    score >= 8 ? "text-emerald-400 bg-emerald-500/10 border-emerald-500/20"
    : score >= 6 ? "text-amber-400 bg-amber-500/10 border-amber-500/20"
    : "text-red-400 bg-red-500/10 border-red-500/20";
  return (
    <span className={`inline-flex items-center gap-1 text-xs border rounded px-2 py-0.5 ${color}`}>
      {label}: {score.toFixed(1)}
    </span>
  );
}

// ─── Venue Card Component ─────────────────────────────────────────────────────

function VenueListCard({
  venue,
  rank,
  city,
}: {
  venue: VenueCard;
  rank: number;
  city: string;
}) {
  const isVerified = venue.is_verified_this_week;

  return (
    <Link
      href={`/${city}/bars/${venue.area_slug}/${venue.slug}`}
      className="group relative flex gap-4 p-4 rounded-2xl bg-zinc-900/60 border border-zinc-800/60 hover:border-zinc-700/80 hover:bg-zinc-900/80 transition-all duration-200"
    >
      {/* Rank */}
      <div className="shrink-0 flex items-center justify-center w-8 h-8 rounded-full bg-zinc-800 text-zinc-500 text-xs font-bold font-mono">
        {rank}
      </div>

      {/* Content */}
      <div className="flex-1 min-w-0">
        <div className="flex items-start justify-between gap-3">
          <div className="min-w-0">
            <div className="flex items-center gap-2 mb-1">
              {isVerified && (
                <span className="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-full bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 text-[10px] font-semibold">
                  <VerifiedDot isVerified />
                  Verified
                </span>
              )}
              {venue.temporarily_closed && (
                <span className="inline-flex items-center px-2 py-0.5 rounded-full bg-red-500/10 border border-red-500/20 text-red-400 text-[10px] font-semibold">
                  Temporarily Closed
                </span>
              )}
            </div>
            <h3 className="font-bold text-white text-base group-hover:text-amber-300 transition-colors leading-tight">
              {venue.name}
            </h3>
            {venue.tagline && (
              <p className="text-zinc-500 text-xs mt-0.5 leading-relaxed line-clamp-2">
                {venue.tagline}
              </p>
            )}
            <div className="flex flex-wrap items-center gap-2 mt-2">
              <PriceTag range={venue.price_range} />
              <ScorePill score={venue.score_foreigner_friendly} label="Foreigner" />
              <ScorePill score={venue.score_late_night_reliability} label="Late Night" />
            </div>
            {venue.tags.length > 0 && (
              <div className="flex flex-wrap gap-1.5 mt-2">
                {venue.tags.slice(0, 4).map((tag) => (
                  <span
                    key={tag}
                    className="text-[10px] px-2 py-0.5 bg-zinc-800 border border-zinc-700/50 rounded-full text-zinc-400"
                  >
                    {tag.replace(/-/g, " ")}
                  </span>
                ))}
              </div>
            )}
          </div>

          {/* Overall Score */}
          {venue.overall_score !== null && (
            <div className="shrink-0 flex flex-col items-center justify-center w-14 h-14 rounded-xl bg-zinc-800/80 border border-zinc-700/50">
              <span className="text-xl font-black text-amber-400 leading-none font-mono">
                {venue.overall_score.toFixed(1)}
              </span>
              <span className="text-[9px] text-zinc-600 mt-0.5">score</span>
            </div>
          )}
        </div>

        {/* Footer row */}
        <div className="flex items-center justify-between mt-3 pt-2 border-t border-zinc-800/60">
          <div className="flex items-center gap-1 text-[10px] text-zinc-600">
            <Clock className="w-3 h-3" />
            {venue.opening_hours ?? "Hours not listed"}
          </div>
          <span className="flex items-center gap-1 text-[10px] text-zinc-600 group-hover:text-amber-400 transition-colors">
            View scores <ArrowRight className="w-3 h-3" />
          </span>
        </div>
      </div>
    </Link>
  );
}

// ─── Area Stats Bar ───────────────────────────────────────────────────────────

function AreaStatsBar({
  stats,
}: {
  stats: NonNullable<Awaited<ReturnType<typeof getAreaStats>>>;
}) {
  return (
    <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
      {[
        { icon: Star, label: "Avg Score", value: stats.avgScore.toFixed(1), color: "text-amber-400" },
        { icon: CheckCircle2, label: "Verified This Week", value: stats.verifiedCount.toString(), color: "text-emerald-400" },
        { icon: Users, label: "Foreigner Score", value: stats.avgForeignerScore.toFixed(1), color: "text-blue-400" },
        { icon: Moon, label: "Venues Listed", value: stats.totalVenues.toString(), color: "text-purple-400" },
      ].map(({ icon: Icon, label, value, color }) => (
        <div
          key={label}
          className="flex flex-col gap-1 p-3 rounded-xl bg-zinc-900/60 border border-zinc-800/60"
        >
          <div className="flex items-center gap-1.5">
            <Icon className={`w-3.5 h-3.5 ${color}`} />
            <span className="text-[10px] text-zinc-500 uppercase tracking-wider">{label}</span>
          </div>
          <span className={`text-xl font-black font-mono ${color}`}>{value}</span>
        </div>
      ))}
    </div>
  );
}

// ─── JSON-LD: ItemList + Place ────────────────────────────────────────────────

function AreaJsonLd({ area, venues, city }: { area: AreaRow; venues: VenueCard[]; city: string }) {
  const base = siteBaseUrl();
  const cityName = city.replace(/-/g, " ").replace(/\b\w/g, c => c.toUpperCase());
  const jsonLd = {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "ItemList",
        name: `Best Bars in ${area.name}, ${cityName}`,
        description: area.description,
        url: `${base}/${city}/bars/${area.slug}`,
        numberOfItems: venues.length,
        itemListElement: venues.map((v, i) => ({
          "@type": "ListItem",
          position: i + 1,
          item: {
            "@type": ["BarOrPub", "NightClub", "LocalBusiness"],
            name: v.name,
            url: `${base}/${city}/bars/${area.slug}/${v.slug}`,
            description: v.tagline,
            priceRange: v.price_range,
            aggregateRating: v.overall_score
              ? {
                  "@type": "AggregateRating",
                  ratingValue: v.overall_score.toFixed(1),
                  bestRating: "10",
                  worstRating: "0",
                }
              : undefined,
          },
        })),
      },
      {
        "@type": "Place",
        name: `${area.name}, ${cityName}`,
        description: area.description,
        geo: area.latitude && area.longitude
          ? { "@type": "GeoCoordinates", latitude: area.latitude, longitude: area.longitude }
          : undefined,
      },
    ],
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
    />
  );
}

// ─── Page ─────────────────────────────────────────────────────────────────────

export default async function AreaPage({ params }: PageProps) {
  const [area, venues] = await Promise.all([
    getAreaData(params.area),
    getAreaVenues(params.city, params.area, 10),
  ]);

  if (!area) notFound();

  const stats = await getAreaStats(venues);
  const month = "May 2026";
  const areaTitle = `${area.name} Nightlife Guide ${month}`;

  return (
    <>
      <AreaJsonLd area={area} venues={venues} city={params.city} />

      <main className="min-h-screen bg-zinc-950 text-white">

        {/* ── Page Header ── */}
        <section className="relative overflow-hidden px-4 pt-8 pb-6 md:px-8 max-w-4xl mx-auto">
          {/* Ambient glow */}
          <div className="pointer-events-none absolute -top-24 left-1/2 -translate-x-1/2 w-96 h-48 rounded-full bg-amber-500/5 blur-3xl" />

          {/* Breadcrumb */}
          <nav className="flex items-center gap-1.5 text-xs text-zinc-600 mb-6">
            <Link href={`/${params.city}`} className="hover:text-zinc-400 transition-colors capitalize">
              {params.city.replace(/-/g, " ")}
            </Link>
            <ChevronRight className="w-3 h-3" />
            <Link href={`/${params.city}/bars`} className="hover:text-zinc-400 transition-colors">Bars</Link>
            <ChevronRight className="w-3 h-3" />
            <span className="text-zinc-400">{area.name}</span>
          </nav>

          {/* Dynamic H1 — SEO-critical */}
          <h1 className="text-3xl md:text-4xl font-black tracking-tight leading-tight mb-3">
            {areaTitle}
          </h1>

          {area.description && (
            <p className="text-zinc-400 text-sm leading-relaxed max-w-2xl mb-6">
              {area.description}
            </p>
          )}

          {/* Location pill */}
          <div className="flex items-center gap-4 flex-wrap">
            <span className="inline-flex items-center gap-1.5 text-xs text-zinc-500">
              <MapPin className="w-3.5 h-3.5 text-rose-400" />
              {area.name}, {params.city.replace(/-/g, " ")}, Thailand
            </span>
            <span className="inline-flex items-center gap-1.5 text-xs text-zinc-500">
              <TrendingUp className="w-3.5 h-3.5 text-amber-400" />
              Ranked by Freshness × Score
            </span>
          </div>
        </section>

        {/* ── Stats Bar ── */}
        {stats && (
          <section className="px-4 md:px-8 pb-6 max-w-4xl mx-auto">
            <AreaStatsBar stats={stats} />
          </section>
        )}

        {/* ── Venue List ── */}
        <section className="px-4 md:px-8 max-w-4xl mx-auto pb-8">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-xs font-bold uppercase tracking-widest text-zinc-500 flex items-center gap-2">
              <Star className="w-3.5 h-3.5 text-amber-400" />
              Top {venues.length} Venues — Sorted by Verified Date
            </h2>
            <span className="text-[10px] text-zinc-600">Updated {month}</span>
          </div>

          {venues.length === 0 ? (
            <div className="text-center py-16 text-zinc-600">
              <Moon className="w-8 h-8 mx-auto mb-3 opacity-50" />
              <p>No venues listed yet for {area.name}.</p>
              <p className="text-xs mt-1">Be the first to submit one.</p>
            </div>
          ) : (
            <div className="space-y-3">
              {venues.map((venue, i) => (
                <VenueListCard key={venue.id} venue={venue} rank={i + 1} city={params.city} />
              ))}
            </div>
          )}
        </section>

        {/* ── Telegram CTA ── */}
        <section className="px-4 md:px-8 pb-8 max-w-4xl mx-auto">
          <div className="relative overflow-hidden rounded-2xl border border-[#2AABEE]/20 bg-zinc-900/60 p-6">
            <div className="absolute -top-12 -right-12 w-48 h-48 bg-[#2AABEE]/5 rounded-full blur-3xl pointer-events-none" />
            <div className="flex items-start gap-4 relative">
              <div className="shrink-0 w-12 h-12 rounded-xl bg-[#2AABEE]/10 border border-[#2AABEE]/20 flex items-center justify-center">
                <Send className="w-5 h-5 text-[#2AABEE]" />
              </div>
              <div className="flex-1">
                <h3 className="font-bold text-white mb-1">
                  Get {area.name} Raid Alerts & Closing Notices
                </h3>
                <p className="text-zinc-400 text-sm mb-4">
                  Real-time alerts for {area.name} and all {params.city.replace(/-/g, " ")} nightlife areas. 4,200+ members. Free.
                </p>
                <a
                  href="https://t.me/ThainightTelegram"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center gap-2 px-4 py-2.5 bg-[#2AABEE] hover:bg-[#2AABEE]/90 text-white text-sm font-bold rounded-xl transition-colors"
                >
                  <MessageCircle className="w-4 h-4" />
                  Join Free on Telegram
                </a>
              </div>
            </div>
          </div>
        </section>

        {/* ── Nearby Areas ── */}
        <section className="px-4 md:px-8 pb-16 max-w-4xl mx-auto">
          <h2 className="text-xs font-bold uppercase tracking-widest text-zinc-600 mb-4">
            Explore Other Areas
          </h2>
          <div className="flex flex-wrap gap-2">
            {[
              { slug: "thonglor", name: "Thonglor" },
              { slug: "silom", name: "Silom" },
              { slug: "ekkamai", name: "Ekkamai" },
              { slug: "asok", name: "Asok" },
              { slug: "ari", name: "Ari" },
              { slug: "rca", name: "RCA" },
              { slug: "sathorn", name: "Sathorn" },
            ]
              .filter((a) => a.slug !== params.area)
              .map((a) => (
                <Link
                  key={a.slug}
                  href={`/${params.city}/bars/${a.slug}`}
                  className="px-4 py-2 text-sm bg-zinc-900 border border-zinc-800 hover:border-zinc-600 text-zinc-400 hover:text-white rounded-xl transition-all duration-200 flex items-center gap-1.5"
                >
                  {a.name}
                  <ChevronRight className="w-3 h-3 opacity-50" />
                </Link>
              ))}
          </div>
        </section>

        {/* ── Floating Submit Update ── */}
        <div className="fixed bottom-6 right-4 z-50">
          <Link
            href={`/submit-update?area=${params.area}`}
            className="flex items-center gap-2 px-4 py-3 bg-zinc-900 hover:bg-zinc-800 border border-zinc-700 hover:border-zinc-500 text-white text-sm font-semibold rounded-2xl shadow-2xl shadow-black/40 transition-all duration-200 group"
          >
            <Zap className="w-4 h-4 text-amber-400 group-hover:scale-110 transition-transform" />
            Submit an Update
          </Link>
        </div>
      </main>
    </>
  );
}
