import Link from "next/link";
import {
  BadgePercent,
  CalendarDays,
  ChevronRight,
  MapPin,
  ShieldAlert,
  Sparkles,
} from "lucide-react";
import type { EventFlyerRow, IntelligenceFeedRow, VenueOfferRow } from "@/lib/database.types";

type Props = {
  events: EventFlyerRow[];
  offers: VenueOfferRow[];
  safetyIntel: IntelligenceFeedRow[];
  priceIntel: IntelligenceFeedRow[];
  openingsIntel: IntelligenceFeedRow[];
};

function shortDate(value: string | null): string {
  if (!value) return "Checking date";
  return new Intl.DateTimeFormat("en", {
    timeZone: "Asia/Bangkok",
    weekday: "short",
    month: "short",
    day: "numeric",
  }).format(new Date(value));
}

function topIntelText(items: IntelligenceFeedRow[], fallback: string): string {
  return items[0]?.title ?? fallback;
}

export function InstantIntelStrip({
  events,
  offers,
  safetyIntel,
  priceIntel,
  openingsIntel,
}: Props) {
  const cards = [
    {
      label: "Tonight events",
      value: events.length ? `${events.length} approved` : "Browse cities",
      body: events[0] ? `${events[0].title} · ${shortDate(events[0].event_date)}` : "No verified event yet today. Start with Bangkok, Pattaya, Phuket, or Chiang Mai nightlife areas.",
      href: "/events",
      icon: CalendarDays,
      tone: "text-rose-200 border-rose-300/20 bg-rose-500/10",
    },
    {
      label: "Approved offers",
      value: offers.length ? `${offers.length} live` : "Check venues",
      body: offers[0] ? `${offers[0].offer_label ?? "Offer"} · ${offers[0].title}` : "Verified deals will appear after review. Venue pages are still useful for areas, vibe, and planning.",
      href: "/offers",
      icon: BadgePercent,
      tone: "text-pink-200 border-pink-300/20 bg-pink-500/10",
    },
    {
      label: "Safety / price tips",
      value: safetyIntel.length + priceIntel.length ? `${safetyIntel.length + priceIntel.length} signals` : "Safety guide",
      body: topIntelText(safetyIntel, topIntelText(priceIntel, "No fresh warning approved yet. Use the safety page for baseline price, fee, and scam guidance.")),
      href: "/safety",
      icon: ShieldAlert,
      tone: "text-amber-200 border-amber-300/20 bg-amber-500/10",
    },
    {
      label: "New bars / openings",
      value: openingsIntel.length ? `${openingsIntel.length} leads` : "City picks",
      body: topIntelText(openingsIntel, "New opening news will appear after review. Browse existing city picks while the feed warms up."),
      href: "/bangkok",
      icon: Sparkles,
      tone: "text-cyan-200 border-cyan-300/20 bg-cyan-500/10",
    },
  ];

  return (
    <section className="space-y-4">
      <div className="flex flex-col gap-2 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-amber-200">
            <MapPin className="h-4 w-4" />
            Start here
          </p>
          <h2 className="mt-2 text-3xl font-black tracking-tight text-white">
            What travelers can use tonight
          </h2>
        </div>
        <p className="max-w-xl text-sm leading-6 text-zinc-500">
          Events, offers, warnings, prices, and openings are separated so ad traffic does not land on a messy feed.
        </p>
      </div>

      <div className="grid gap-3 md:grid-cols-2 xl:grid-cols-4">
        {cards.map((card) => {
          const Icon = card.icon;
          return (
            <Link
              key={card.label}
              href={card.href}
              className={`group flex min-h-52 flex-col justify-between rounded-2xl border p-5 transition hover:-translate-y-0.5 ${card.tone}`}
            >
              <div className="flex items-start justify-between gap-3">
                <div>
                  <p className="text-xs font-black uppercase tracking-widest opacity-75">
                    {card.label}
                  </p>
                  <p className="mt-2 text-2xl font-black text-white">{card.value}</p>
                </div>
                <Icon className="h-5 w-5 shrink-0" />
              </div>
              <div>
                <p className="line-clamp-3 text-sm leading-6 text-zinc-300">{card.body}</p>
                <span className="mt-4 inline-flex items-center gap-1 text-sm font-black text-white">
                  Open
                  <ChevronRight className="h-4 w-4 transition group-hover:translate-x-1" />
                </span>
              </div>
            </Link>
          );
        })}
      </div>
    </section>
  );
}
