import Link from "next/link";
import {
  ArrowRight,
  CalendarDays,
  MessageCircle,
  Moon,
  ShieldAlert,
  Users,
} from "lucide-react";
import type { EventFlyerRow, IntelligenceFeedRow, VenueOfferRow } from "@/lib/database.types";

type Props = {
  cityName?: string;
  citySlug?: string;
  events: EventFlyerRow[];
  offers: VenueOfferRow[];
  safetyIntel: IntelligenceFeedRow[];
  priceIntel: IntelligenceFeedRow[];
};

function topText(items: Array<{ title?: string | null }>, fallback: string): string {
  return items[0]?.title ?? fallback;
}

export function TonightPlanGrid({
  cityName = "Thailand",
  citySlug,
  events,
  offers,
  safetyIntel,
  priceIntel,
}: Props) {
  const cityPath = citySlug ? `/${citySlug}` : "";
  const signalCount = safetyIntel.length + priceIntel.length;
  const tonightCount = events.length + offers.length;

  const cards = [
    {
      label: "Tonight",
      title: cityName === "Thailand" ? "What can I do tonight?" : `Tonight in ${cityName}`,
      body: events[0]
        ? topText(events, "Approved nightlife events and going-out plans.")
        : "No verified event yet? Start with Bangkok, Pattaya, Phuket, or Chiang Mai nightlife areas that already have venue guides.",
      value: tonightCount ? `${tonightCount} live leads` : "Browse areas",
      href: citySlug ? `${cityPath}?intent=tonight` : "/bangkok?intent=tonight",
      icon: Moon,
      tone: "border-rose-300/20 bg-rose-500/10 text-rose-100",
    },
    {
      label: "People",
      title: "Who is going out?",
      body: "Join the nightlife chat, build a simple traveler profile, or post your plan before heading out.",
      value: "Solo-friendly",
      href: "/profile",
      icon: Users,
      tone: "border-fuchsia-300/20 bg-fuchsia-500/10 text-fuchsia-100",
    },
    {
      label: "Events",
      title: "New events this week",
      body: events[0]
        ? topText(events, "Approved flyers and events after review.")
        : "Approved flyers will appear here after review. Until then, use city guides to pick a reliable nightlife base.",
      value: events.length ? `${events.length} approved` : "Review pending",
      href: citySlug ? `${cityPath}?intent=events` : "/events",
      icon: CalendarDays,
      tone: "border-amber-300/20 bg-amber-500/10 text-amber-100",
    },
    {
      label: "Safety",
      title: "Warnings and price tips",
      body: signalCount
        ? topText(safetyIntel, topText(priceIntel, "Recent nightlife safety and price signals."))
        : "Late-entry fees, scam warnings, cover charges, and transport notes will appear after review. Basic safety guidance is always available.",
      value: signalCount ? `${signalCount} signals` : "Safety guide",
      href: "/safety",
      icon: ShieldAlert,
      tone: "border-cyan-300/20 bg-cyan-500/10 text-cyan-100",
    },
  ];

  return (
    <section className="space-y-4">
      <div className="flex flex-col gap-2 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-rose-300">
            <MessageCircle className="h-4 w-4" />
            Tonight / People / Events / Safety
          </p>
          <h2 className="mt-2 text-3xl font-black tracking-tight text-white">
            Use ThaiNight before you go out, not after.
          </h2>
        </div>
        <p className="max-w-xl text-sm leading-6 text-zinc-500">
          One screen for tonight&apos;s plan: where to go, who may go with you, what is happening, and what to watch out for.
        </p>
      </div>

      <div className="grid gap-3 md:grid-cols-2 xl:grid-cols-4">
        {cards.map((card) => {
          const Icon = card.icon;
          return (
            <Link
              key={card.label}
              href={card.href}
              className={`group flex min-h-60 flex-col justify-between rounded-2xl border p-5 transition hover:-translate-y-0.5 ${card.tone}`}
            >
              <div>
                <div className="flex items-start justify-between gap-3">
                  <div>
                    <p className="text-xs font-black uppercase tracking-widest opacity-75">
                      {card.label}
                    </p>
                    <h3 className="mt-2 text-2xl font-black tracking-tight text-white">
                      {card.title}
                    </h3>
                  </div>
                  <Icon className="h-5 w-5 shrink-0" />
                </div>
                <p className="mt-4 line-clamp-4 text-sm leading-6 text-zinc-300">{card.body}</p>
              </div>

              <div className="mt-5 flex items-center justify-between border-t border-white/10 pt-4">
                <span className="rounded-full bg-white/10 px-2.5 py-1 text-xs font-black text-white">
                  {card.value}
                </span>
                <span className="inline-flex items-center gap-1 text-sm font-black text-white">
                  Open
                  <ArrowRight className="h-4 w-4 transition group-hover:translate-x-1" />
                </span>
              </div>
            </Link>
          );
        })}
      </div>
    </section>
  );
}
