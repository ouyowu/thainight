import Link from "next/link";
import {
  BadgePercent,
  CalendarDays,
  MapPinned,
  ShieldAlert,
  Sparkles,
  WalletCards,
} from "lucide-react";
import type { EventFlyerRow, IntelligenceFeedRow, VenueOfferRow } from "@/lib/database.types";
import type { AreaSummary } from "@/lib/public-intel";
import { NightlifeBriefSignup } from "@/components/NightlifeBriefSignup";
import { PriorityNetworkLinks } from "@/components/PriorityNetworkLinks";

type Props = {
  cityName: string;
  citySlug: string;
  areas: AreaSummary[];
  events: EventFlyerRow[];
  offers: VenueOfferRow[];
  safetyIntel: IntelligenceFeedRow[];
  priceIntel: IntelligenceFeedRow[];
  openingsIntel: IntelligenceFeedRow[];
};

const CITY_EDITORIAL: Record<
  string,
  {
    areasTitle: string;
    areasIntro: string;
    tonightTitle: string;
    tonightEmpty: string;
    offersTitle: string;
    offersEmpty: string;
    soloTitle: string;
    soloTips: string[];
  }
> = {
  bangkok: {
    areasTitle: "Start with neighborhoods, not individual venues",
    areasIntro:
      "Bangkok is too spread out to improvise late. Start by choosing one neighborhood cluster like Thonglor, Silom, Sukhumvit, or RCA, then narrow down venues inside that zone.",
    tonightTitle: "Tonight in Bangkok",
    tonightEmpty:
      "Bangkok flyers will appear here once reviewed. This section works best when it reflects same-night momentum across major nightlife districts.",
    offersTitle: "Bangkok deal flow",
    offersEmpty:
      "No verified Bangkok happy hours, guest lists, or entry deals yet. Once approved, this area should help users compare nightlife cost before crossing the city.",
    soloTitle: "Bangkok solo traveler tips",
    soloTips: [
      "Pick one district and stay there instead of trying to cross Bangkok after midnight.",
      "Check final-entry time and whether a venue is table-heavy before committing to a club night.",
      "Use BTS, Grab, or a hotel zone with easy late-night transport home.",
    ],
  },
  pattaya: {
    areasTitle: "Start with strip vs side-street decisions",
    areasIntro:
      "Pattaya is less about crossing a giant city and more about choosing the right nightlife strip. Decide early whether you want Walking Street energy, Soi Buakhao flexibility, or a beach-club / live-music night.",
    tonightTitle: "Tonight in Pattaya",
    tonightEmpty:
      "No approved Pattaya event signals yet. Once reviewed, this section should help separate genuine same-night energy from generic tourist noise.",
    offersTitle: "Pattaya offers and entry hooks",
    offersEmpty:
      "No verified Pattaya offers yet. Once loaded, this area should help compare guest-list style promotions with more casual bar and club deals.",
    soloTitle: "Pattaya solo traveler tips",
    soloTips: [
      "Choose your street pattern early so you do not bounce between Walking Street, beach areas, and Soi Buakhao without a plan.",
      "Treat touts, inflated tabs, and unclear cover charges as immediate warning signs.",
      "Keep transport home simple and avoid getting stuck in one high-pressure strip after your first stop disappoints.",
    ],
  },
  phuket: {
    areasTitle: "Start with island logistics first",
    areasIntro:
      "Phuket nightlife decisions are shaped by distance more than people expect. First choose whether tonight is Patong and Bangla, a beach-club sunset plan, or a quieter hotel-zone night with easier transport back.",
    tonightTitle: "Tonight in Phuket",
    tonightEmpty:
      "No approved Phuket event signals yet. Once reviewed, this section should help separate beach-club momentum from generic tourist listings.",
    offersTitle: "Phuket beach-club and bar offers",
    offersEmpty:
      "No verified Phuket offers yet. When they arrive, use them together with area planning because island distance matters as much as the price itself.",
    soloTitle: "Phuket solo traveler tips",
    soloTips: [
      "Decide early whether you are committing to Patong / Bangla or staying closer to your beach and hotel zone.",
      "Do not assume a cheap-looking offer is worth it if the return trip is long or expensive.",
      "Check transport home before sunset if your night starts at a beach club or rooftop far from your base.",
    ],
  },
  "chiang-mai": {
    areasTitle: "Start with mood and neighborhood fit",
    areasIntro:
      "Chiang Mai works better when you choose the kind of night first: Nimman for a polished bar run, Old City for easier wandering, or live music and jazz rooms for a slower late-night plan.",
    tonightTitle: "Tonight in Chiang Mai",
    tonightEmpty:
      "No approved Chiang Mai event signals yet. Once reviewed, this section should highlight real live-music and nightlife movement rather than generic city listings.",
    offersTitle: "Chiang Mai value and venue offers",
    offersEmpty:
      "No verified Chiang Mai offers yet. Once loaded, this section should help compare quieter bar value with event-linked specials.",
    soloTitle: "Chiang Mai solo traveler tips",
    soloTips: [
      "Treat Chiang Mai like a neighborhood night, not a citywide sprint between distant stops.",
      "If you want live music or jazz, confirm the venue is actually active that night before building your plan around it.",
      "Use a tighter route and earlier decisions, since the city usually rewards low-friction plans more than chaotic late-night hopping.",
    ],
  },
};

function formatDate(value: string | null): string {
  if (!value) return "Date checking";
  return new Intl.DateTimeFormat("en", {
    timeZone: "Asia/Bangkok",
    month: "short",
    day: "numeric",
    hour: "numeric",
  }).format(new Date(value));
}

function EmptyNote({ text }: { text: string }) {
  return <p className="rounded-2xl border border-dashed border-zinc-800 bg-zinc-950/70 p-4 text-sm leading-6 text-zinc-500">{text}</p>;
}

function IntelList({
  title,
  icon: Icon,
  items,
  empty,
}: {
  title: string;
  icon: typeof ShieldAlert;
  items: IntelligenceFeedRow[];
  empty: string;
}) {
  return (
    <section className="rounded-3xl border border-zinc-800 bg-zinc-950/80 p-5">
      <h3 className="inline-flex items-center gap-2 text-sm font-black uppercase tracking-widest text-white">
        <Icon className="h-4 w-4 text-amber-300" />
        {title}
      </h3>
      <div className="mt-4 space-y-3">
        {items.length ? (
          items.slice(0, 3).map((item) => (
            <a
              key={item.id}
              href={item.url}
              target="_blank"
              rel="noreferrer"
              className="block rounded-2xl border border-zinc-800 bg-black/25 p-4 transition hover:border-amber-300/40"
            >
              <p className="line-clamp-2 text-sm font-bold leading-6 text-zinc-100">{item.title}</p>
              <p className="mt-2 line-clamp-2 text-xs leading-5 text-zinc-500">
                {item.body_snippet ?? item.source}
              </p>
            </a>
          ))
        ) : (
          <EmptyNote text={empty} />
        )}
      </div>
    </section>
  );
}

export function CityNightlifeSnapshot({
  cityName,
  citySlug,
  areas,
  events,
  offers,
  safetyIntel,
  priceIntel,
  openingsIntel,
}: Props) {
  const editorial = CITY_EDITORIAL[citySlug] ?? {
    areasTitle: `Where to start in ${cityName}`,
    areasIntro: `Use the strongest nightlife areas in ${cityName} as your first filter, then narrow down venues, events, and deals from there.`,
    tonightTitle: "Tonight / this week",
    tonightEmpty: "No approved upcoming events yet. The importer can fill this once items are reviewed.",
    offersTitle: "Approved offers",
    offersEmpty: "No verified happy hour, free-entry, or guest-list offers yet.",
    soloTitle: "Solo traveler tips",
    soloTips: [
      "Pick one nightlife area per night instead of crossing the city late.",
      "Check cover charge, final-entry time, and recent comments before buying tickets.",
      "Use Grab, official taxis, or walkable hotel zones after midnight.",
    ],
  };

  return (
    <div className="space-y-6">
      <section className="grid gap-4 lg:grid-cols-[1.1fr_0.9fr]">
        <div className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
          <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-amber-300">
            <MapPinned className="h-4 w-4" />
            Best areas by city
          </p>
          <h2 className="mt-3 text-3xl font-black tracking-tight text-white">
            {editorial.areasTitle}
          </h2>
          <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-400">
            {editorial.areasIntro}
          </p>
          <div className="mt-5 grid gap-3 sm:grid-cols-2">
            {areas.length ? (
              areas.map((area) => (
                <Link
                  key={area.areaSlug}
                  href={`/${citySlug}/bars/${area.areaSlug}`}
                  className="rounded-2xl border border-zinc-800 bg-zinc-900/50 p-4 transition hover:border-amber-300/50"
                >
                  <div className="flex items-start justify-between gap-3">
                    <div>
                      <h3 className="font-black capitalize text-white">{area.areaName}</h3>
                      <p className="mt-1 text-xs text-zinc-500">{area.venueCount} venues loaded</p>
                    </div>
                    <span className="rounded-full bg-amber-300 px-2.5 py-1 text-xs font-black text-zinc-950">
                      {area.averageScore === null ? "new" : area.averageScore.toFixed(1)}
                    </span>
                  </div>
                  {area.topTags.length ? (
                    <p className="mt-3 line-clamp-1 text-xs capitalize text-zinc-400">
                      {area.topTags.join(" · ")}
                    </p>
                  ) : null}
                </Link>
              ))
            ) : (
              <EmptyNote text="Area rankings will appear after more verified venues are imported." />
            )}
          </div>
        </div>

        <div className="grid gap-4">
          <section className="rounded-3xl border border-rose-300/20 bg-rose-500/10 p-5">
            <h3 className="inline-flex items-center gap-2 text-sm font-black uppercase tracking-widest text-rose-100">
              <CalendarDays className="h-4 w-4" />
              {editorial.tonightTitle}
            </h3>
            <div className="mt-4 space-y-3">
              {events.length ? (
                events.slice(0, 3).map((event) => (
                  <a key={event.id} href={event.source_url ?? "#"} target="_blank" rel="noreferrer" className="block rounded-2xl border border-white/10 bg-black/25 p-4">
                    <p className="text-xs font-black uppercase tracking-widest text-rose-200">{formatDate(event.event_date)}</p>
                    <p className="mt-2 line-clamp-2 text-sm font-bold leading-6 text-white">{event.title}</p>
                  </a>
                ))
              ) : (
                <EmptyNote text={editorial.tonightEmpty} />
              )}
            </div>
          </section>

          <section className="rounded-3xl border border-pink-300/20 bg-pink-500/10 p-5">
            <h3 className="inline-flex items-center gap-2 text-sm font-black uppercase tracking-widest text-pink-100">
              <BadgePercent className="h-4 w-4" />
              {editorial.offersTitle}
            </h3>
            <div className="mt-4 space-y-3">
              {offers.length ? (
                offers.slice(0, 3).map((offer) => (
                  <a key={offer.id} href={offer.source_url ?? "#"} target="_blank" rel="noreferrer" className="block rounded-2xl border border-white/10 bg-black/25 p-4">
                    <p className="text-xs font-black uppercase tracking-widest text-pink-200">{offer.offer_label ?? "Offer"}</p>
                    <p className="mt-2 line-clamp-2 text-sm font-bold leading-6 text-white">{offer.title}</p>
                  </a>
                ))
              ) : (
                <EmptyNote text={editorial.offersEmpty} />
              )}
            </div>
          </section>
        </div>
      </section>

      <section className="grid gap-4 lg:grid-cols-3">
        <IntelList title="Safety warnings" icon={ShieldAlert} items={safetyIntel} empty="Scam, raid, overcharge, and avoid-area signals will appear here after review." />
        <IntelList title="Price tips" icon={WalletCards} items={priceIntel} empty="Cover charge, late-entry fee, drink price, and ticket-window notes will appear here." />
        <IntelList title="New bars / openings" icon={Sparkles} items={openingsIntel} empty="New venue and opening news will appear here after source checks." />
      </section>

      <section className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
        <h2 className="text-2xl font-black tracking-tight text-white">{editorial.soloTitle}</h2>
        <div className="mt-4 grid gap-3 md:grid-cols-3">
          {editorial.soloTips.map((tip) => (
            <p key={tip} className="rounded-2xl border border-zinc-800 bg-zinc-900/45 p-4 text-sm leading-6 text-zinc-300">
              {tip}
            </p>
          ))}
        </div>
      </section>

      <PriorityNetworkLinks
        title={`Keep moving through ${cityName} without losing the main nightlife path`}
        description={`After scanning the best areas, use these links to move from ${cityName} into Thailand-wide sections like tonight, events, offers, and intel. This keeps the city guide connected to the rest of the site instead of acting like an isolated page.`}
        currentCity={citySlug as "bangkok" | "pattaya" | "phuket" | "chiang-mai"}
        hubLinks={[
          {
            href: "/tonight",
            label: "Tonight",
            description: `See fast-moving plans, warnings, and traveler flow tied back to ${cityName}.`,
          },
          {
            href: "/events",
            label: "Events",
            description: `Jump into approved events and nightlife flyers from around Thailand.`,
          },
          {
            href: "/offers",
            label: "Offers",
            description: `Check happy hours, guest lists, and deal-heavy venues before going out.`,
          },
          {
            href: "/intel",
            label: "Intel",
            description: `Review openings, warnings, and pricing shifts that affect tonight.`,
          },
          {
            href: "/news",
            label: "News",
            description: `Read broader nightlife updates and opening stories around Thailand.`,
          },
        ]}
      />

      <NightlifeBriefSignup cityName={cityName} citySlug={citySlug} compact />
    </div>
  );
}
