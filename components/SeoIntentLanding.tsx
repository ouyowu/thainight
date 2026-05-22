import Link from "next/link";
import {
  ArrowRight,
  CalendarDays,
  ExternalLink,
  MapPin,
  ShieldAlert,
  Sparkles,
  WalletCards,
} from "lucide-react";
import type { SeoIntentPageConfig } from "@/lib/seo-intent-pages";
import { getStaticVenueCardsForCity } from "@/lib/fallback-nightlife";
import { createAnonClient } from "@/lib/supabase/server";
import { areaSummariesFromVenues, getApprovedOffers, getPublicIntel, getUpcomingEvents } from "@/lib/public-intel";
import type { IntelligenceFeedRow, VenueCard } from "@/lib/database.types";

async function getSeoVenues(city: string | undefined): Promise<VenueCard[]> {
  if (!city) return [];
  const supabase = createAnonClient();

  if (supabase) {
    const { data } = await supabase
      .from("venue_cards")
      .select("*")
      .eq("city", city)
      .order("overall_score", { ascending: false, nullsFirst: false })
      .limit(24);

    if (data?.length) return data as VenueCard[];
  }

  return getStaticVenueCardsForCity(city).slice(0, 24);
}

function signalTitle(item: IntelligenceFeedRow): string {
  return item.title.replace(/\s+-\s+[^-]+$/, "").trim();
}

function sourceLabel(url: string): string {
  try {
    return new URL(url).hostname.replace(/^www\./, "");
  } catch {
    return "source";
  }
}

export async function SeoIntentLanding({ config }: { config: SeoIntentPageConfig }) {
  const [venues, events, offers, categoryIntel, safetyIntel, priceIntel] = await Promise.all([
    getSeoVenues(config.city),
    getUpcomingEvents({ city: config.city, limit: 4 }),
    getApprovedOffers({ city: config.city, limit: 4 }),
    config.category ? getPublicIntel({ city: config.city, category: config.category, limit: 6 }) : Promise.resolve([]),
    getPublicIntel({ city: config.city, category: "safety", limit: 4 }),
    getPublicIntel({ city: config.city, category: "price", limit: 4 }),
  ]);
  const areas = areaSummariesFromVenues(venues, 5);
  const intel = categoryIntel.length ? categoryIntel : [...safetyIntel, ...priceIntel].slice(0, 6);

  return (
    <main className="mx-auto flex min-h-screen max-w-7xl flex-col gap-10 px-4 py-6 sm:px-6 lg:px-8">
      <section className="rounded-[32px] border border-rose-300/20 bg-[linear-gradient(135deg,rgba(244,63,94,0.18),rgba(9,9,11,0.98)_46%,rgba(251,191,36,0.1))] p-5 sm:p-8">
        <nav className="mb-6 flex items-center gap-2 text-xs font-bold text-zinc-500">
          <Link href="/" className="hover:text-zinc-300">ThaiNight</Link>
          <ArrowRight className="h-3.5 w-3.5" />
          <span className="text-zinc-300">{config.keyword}</span>
        </nav>
        <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-rose-200">
          <Sparkles className="h-4 w-4" />
          {config.heroLabel}
        </p>
        <h1 className="mt-3 max-w-4xl text-balance text-4xl font-black tracking-tight text-white sm:text-5xl lg:text-6xl">
          {config.title}
        </h1>
        <p className="mt-4 max-w-3xl text-base leading-8 text-zinc-300">{config.intro}</p>
        <div className="mt-6 flex flex-col gap-3 sm:flex-row">
          <Link
            href={config.primaryCta.href}
            className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl bg-rose-500 px-5 text-sm font-black text-white transition hover:bg-rose-400"
          >
            {config.primaryCta.label}
            <ArrowRight className="h-4 w-4" />
          </Link>
          <Link
            href={config.secondaryCta.href}
            className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl border border-white/15 bg-white/5 px-5 text-sm font-black text-white transition hover:border-white/30 hover:bg-white/10"
          >
            {config.secondaryCta.label}
          </Link>
        </div>
      </section>

      <section className="grid gap-4 lg:grid-cols-3">
        {config.sections.map((section) => (
          <article key={section.title} className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5">
            <h2 className="text-2xl font-black tracking-tight text-white">{section.title}</h2>
            <p className="mt-3 text-sm leading-7 text-zinc-400">{section.body}</p>
          </article>
        ))}
      </section>

      {areas.length ? (
        <section className="space-y-4">
          <div>
            <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-amber-300">
              <MapPin className="h-4 w-4" />
              Area snapshot
            </p>
            <h2 className="mt-2 text-3xl font-black tracking-tight text-white">Best areas to compare first</h2>
          </div>
          <div className="grid gap-3 md:grid-cols-2 xl:grid-cols-5">
            {areas.map((area) => (
              <Link
                key={area.areaSlug}
                href={`/${config.city}/bars/${area.areaSlug}`}
                className="rounded-2xl border border-zinc-800 bg-zinc-950 p-4 transition hover:border-amber-300/50"
              >
                <p className="text-lg font-black capitalize text-white">{area.areaName}</p>
                <p className="mt-2 text-xs text-zinc-500">{area.venueCount} venues loaded</p>
                <p className="mt-3 line-clamp-1 text-xs capitalize text-zinc-400">{area.topTags.join(" · ") || "nightlife area"}</p>
              </Link>
            ))}
          </div>
        </section>
      ) : null}

      <section className="grid gap-4 lg:grid-cols-2">
        <div className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
          <h2 className="inline-flex items-center gap-2 text-2xl font-black tracking-tight text-white">
            <CalendarDays className="h-5 w-5 text-rose-200" />
            Current events and offers
          </h2>
          <div className="mt-4 space-y-3">
            {[...events, ...offers].slice(0, 5).map((item) => (
              <a
                key={item.id}
                href={item.source_url ?? "#"}
                target="_blank"
                rel="noreferrer"
                className="block rounded-2xl border border-zinc-800 bg-black/25 p-4 transition hover:border-rose-300/40"
              >
                <p className="line-clamp-2 text-sm font-black leading-6 text-white">{item.title}</p>
                <p className="mt-2 text-xs font-bold text-zinc-500">{item.city} · approved</p>
              </a>
            ))}
            {events.length + offers.length === 0 ? (
              <p className="rounded-2xl border border-dashed border-zinc-800 p-4 text-sm text-zinc-500">
                Approved events and offers will appear here after review.
              </p>
            ) : null}
          </div>
        </div>

        <div className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
          <h2 className="inline-flex items-center gap-2 text-2xl font-black tracking-tight text-white">
            {config.category === "price" ? <WalletCards className="h-5 w-5 text-amber-200" /> : <ShieldAlert className="h-5 w-5 text-amber-200" />}
            Reviewed intel
          </h2>
          <div className="mt-4 space-y-3">
            {intel.slice(0, 5).map((item) => (
              <a
                key={item.id}
                href={item.url}
                target="_blank"
                rel="noreferrer"
                className="block rounded-2xl border border-zinc-800 bg-black/25 p-4 transition hover:border-amber-300/40"
              >
                <p className="line-clamp-2 text-sm font-black leading-6 text-white">{signalTitle(item)}</p>
                <p className="mt-2 text-xs font-bold text-zinc-500">{sourceLabel(item.url)}</p>
              </a>
            ))}
            {intel.length === 0 ? (
              <p className="rounded-2xl border border-dashed border-zinc-800 p-4 text-sm text-zinc-500">
                Reviewed warnings and price tips will appear here after approval.
              </p>
            ) : null}
          </div>
        </div>
      </section>

      <section className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
        <h2 className="text-2xl font-black tracking-tight text-white">Related ThaiNight pages</h2>
        <div className="mt-4 flex flex-wrap gap-2">
          {config.internalLinks.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              className="inline-flex min-h-10 items-center gap-2 rounded-full border border-white/10 bg-white/[0.04] px-3 py-2 text-sm font-bold text-zinc-200 transition hover:border-rose-300/50 hover:bg-rose-300/10 hover:text-white"
            >
              {link.label}
              <ExternalLink className="h-3.5 w-3.5 text-zinc-500" />
            </Link>
          ))}
        </div>
      </section>
    </main>
  );
}
