import Link from "next/link";
import type { Metadata } from "next";
import {
  ArrowRight,
  BadgePercent,
  CalendarDays,
  MapPin,
  MessageCircle,
  ShieldAlert,
  Sparkles,
  Users,
  WalletCards,
} from "lucide-react";
import { CITY_CONFIGS, type CitySlug } from "@/lib/cities";
import { siteBaseUrl } from "@/lib/config";
import {
  getApprovedOffers,
  getPublicIntel,
  getUpcomingEvents,
} from "@/lib/public-intel";
import type { EventFlyerRow, IntelligenceFeedRow, VenueOfferRow } from "@/lib/database.types";
import { SiteFooter } from "@/components/SiteFooter";
import { NightlifeBriefSignup } from "@/components/NightlifeBriefSignup";
import { PriorityNetworkLinks } from "@/components/PriorityNetworkLinks";
import { PriorityFaq } from "@/components/PriorityFaq";

export const metadata: Metadata = {
  title: "Tonight in Thailand: Events, Warnings, Crowd Flow & Plans | ThaiNight",
  description:
    "Plan tonight in Thailand with nightlife events, people flow, safety warnings, price tips, and same-night bar and club signals across key cities.",
  alternates: {
    canonical: `${siteBaseUrl()}/tonight`,
  },
  openGraph: {
    title: "Tonight in Thailand: same-night nightlife planning across key cities",
    description:
      "Use events, warnings, offers, and crowd signals to build a better Thailand nightlife plan tonight.",
    url: `${siteBaseUrl()}/tonight`,
    siteName: "ThaiNight",
    locale: "en_TH",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Tonight in Thailand: same-night nightlife planning across key cities",
    description:
      "The urgency page for nightlife decisions tonight: events, offers, warnings, and where people are going.",
  },
};

function cityName(value: string | null): string {
  const city = CITY_CONFIGS.find((item) => item.slug === value);
  return city?.name ?? "Thailand";
}

function formatDate(value: string | null): string {
  if (!value) return "Date checking";
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return "Date checking";
  return new Intl.DateTimeFormat("en", {
    timeZone: "Asia/Bangkok",
    month: "short",
    day: "numeric",
    hour: "numeric",
    minute: "2-digit",
  }).format(date);
}

function IntelCard({
  item,
  tone = "amber",
}: {
  item: IntelligenceFeedRow;
  tone?: "amber" | "rose" | "cyan";
}) {
  const toneClass =
    tone === "rose"
      ? "border-rose-300/20 bg-rose-500/10 text-rose-100"
      : tone === "cyan"
        ? "border-cyan-300/20 bg-cyan-500/10 text-cyan-100"
        : "border-amber-300/20 bg-amber-500/10 text-amber-100";

  return (
    <a
      href={item.url}
      target="_blank"
      rel="noreferrer"
      className={`block rounded-2xl border p-4 transition hover:-translate-y-0.5 ${toneClass}`}
    >
      <p className="text-xs font-black uppercase tracking-widest opacity-80">
        {cityName(item.city)} · {item.source || "Intel"}
      </p>
      <h3 className="mt-2 line-clamp-2 text-base font-black leading-6 text-white">
        {item.title}
      </h3>
      <p className="mt-2 line-clamp-2 text-sm leading-6 text-zinc-300">
        {item.body_snippet ?? "Open the source to review the full nightlife signal."}
      </p>
    </a>
  );
}

function EventCard({ event }: { event: EventFlyerRow }) {
  return (
    <a
      href={event.source_url ?? "#"}
      target="_blank"
      rel="noreferrer"
      className="block rounded-2xl border border-rose-300/20 bg-rose-500/10 p-4 transition hover:-translate-y-0.5 hover:border-rose-200/45"
    >
      <p className="text-xs font-black uppercase tracking-widest text-rose-200">
        {cityName(event.city as CitySlug)} · {formatDate(event.event_date)}
      </p>
      <h3 className="mt-2 line-clamp-2 text-base font-black leading-6 text-white">
        {event.title}
      </h3>
      <p className="mt-2 line-clamp-2 text-sm leading-6 text-zinc-300">
        {event.description ?? "Approved event. Check the original source before going."}
      </p>
    </a>
  );
}

function OfferCard({ offer }: { offer: VenueOfferRow }) {
  return (
    <a
      href={offer.source_url ?? "#"}
      target="_blank"
      rel="noreferrer"
      className="block rounded-2xl border border-fuchsia-300/20 bg-fuchsia-500/10 p-4 transition hover:-translate-y-0.5 hover:border-fuchsia-200/45"
    >
      <p className="text-xs font-black uppercase tracking-widest text-fuchsia-200">
        {cityName(offer.city as CitySlug)} · {offer.offer_label ?? "Offer"}
      </p>
      <h3 className="mt-2 line-clamp-2 text-base font-black leading-6 text-white">
        {offer.title}
      </h3>
      <p className="mt-2 line-clamp-2 text-sm leading-6 text-zinc-300">
        {offer.description ?? "Approved offer. Confirm with the venue before going."}
      </p>
    </a>
  );
}

function EmptyCard({ text }: { text: string }) {
  return (
    <div className="rounded-2xl border border-dashed border-zinc-800 bg-zinc-950/70 p-5 text-sm leading-6 text-zinc-500">
      {text}
    </div>
  );
}

export default async function TonightPage() {
  const [events, offers, safetyIntel, priceIntel, openingsIntel] = await Promise.all([
    getUpcomingEvents({ limit: 12 }),
    getApprovedOffers({ limit: 8 }),
    getPublicIntel({ category: "safety", limit: 8 }),
    getPublicIntel({ category: "price", limit: 8 }),
    getPublicIntel({ category: "new_opening", limit: 8 }),
  ]);

  const quickStats = [
    { label: "Approved events", value: events.length, icon: CalendarDays },
    { label: "Offers", value: offers.length, icon: BadgePercent },
    { label: "Warnings", value: safetyIntel.length, icon: ShieldAlert },
    { label: "Price tips", value: priceIntel.length, icon: WalletCards },
  ];

  return (
    <main className="mx-auto flex min-h-screen max-w-7xl flex-col gap-10 px-4 py-6 sm:px-6 lg:px-8">
      <section className="overflow-hidden rounded-[32px] border border-rose-300/20 bg-[linear-gradient(135deg,rgba(244,63,94,0.2),rgba(9,9,11,0.98)_42%,rgba(251,191,36,0.12))] p-5 sm:p-8">
        <nav className="mb-6 flex items-center gap-2 text-xs font-bold text-zinc-500">
          <Link href="/" className="hover:text-zinc-300">
            ThaiNight
          </Link>
          <ArrowRight className="h-3.5 w-3.5" />
          <span className="text-zinc-300">Tonight</span>
        </nav>

        <div className="grid gap-8 lg:grid-cols-[1fr_380px] lg:items-end">
          <div>
            <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-rose-200">
              <Sparkles className="h-4 w-4" />
              Tonight in Thailand
            </p>
            <h1 className="mt-3 max-w-4xl text-balance text-4xl font-black tracking-tight text-white sm:text-5xl lg:text-6xl">
              Find events, people going out, warnings, and price tips before tonight starts.
            </h1>
            <p className="mt-4 max-w-2xl text-base leading-8 text-zinc-300">
              A fast nightlife planning page for Bangkok, Pattaya, Phuket, and Chiang Mai. Use it to pick an area, check what is happening, avoid bad surprises, and join the traveler flow.
            </p>
            <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-400">
              This is the urgency page. It should help a traveler build a same-night plan quickly, not read broad nightlife background for ten minutes.
            </p>
            <div className="mt-6 flex flex-col gap-3 sm:flex-row">
              <Link
                href="#people"
                className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl bg-rose-500 px-5 text-sm font-black text-white transition hover:bg-rose-400"
              >
                <Users className="h-4 w-4" />
                See who is going out tonight
              </Link>
              <Link
                href="/profile"
                className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl border border-white/15 bg-white/5 px-5 text-sm font-black text-white transition hover:border-white/30 hover:bg-white/10"
              >
                <MessageCircle className="h-4 w-4" />
                Post your plan
              </Link>
            </div>
          </div>

          <div className="grid grid-cols-2 gap-3">
            {quickStats.map(({ label, value, icon: Icon }) => (
              <div key={label} className="rounded-2xl border border-white/10 bg-black/25 p-4">
                <Icon className="mb-3 h-5 w-5 text-amber-200" />
                <p className="text-2xl font-black text-white">{value}</p>
                <p className="mt-1 text-xs font-bold uppercase tracking-widest text-zinc-500">
                  {label}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section id="people" className="grid gap-4 lg:grid-cols-4">
        {CITY_CONFIGS.map((city) => (
          <Link
            key={city.slug}
            href={`${city.href}?intent=going-tonight`}
            className="group rounded-3xl border border-zinc-800 bg-zinc-950 p-5 transition hover:-translate-y-0.5 hover:border-rose-300/40"
          >
            <div className="flex items-start justify-between gap-3">
              <span className="inline-flex items-center gap-2 rounded-full border border-rose-300/20 bg-rose-500/10 px-3 py-1 text-xs font-black text-rose-100">
                <MapPin className="h-3.5 w-3.5" />
                {city.name}
              </span>
              <ArrowRight className="h-4 w-4 text-zinc-500 transition group-hover:translate-x-1 group-hover:text-white" />
            </div>
            <h2 className="mt-5 text-2xl font-black tracking-tight text-white">
              Tonight in {city.name}
            </h2>
            <p className="mt-3 line-clamp-3 text-sm leading-6 text-zinc-400">
              Best areas, solo-friendly plans, events, warnings, and fresh nightlife notes for {city.name}.
            </p>
            <p className="mt-5 rounded-full bg-white/10 px-3 py-1 text-center text-xs font-black text-white">
              See city plan
            </p>
          </Link>
        ))}
      </section>

      <section className="grid gap-4 lg:grid-cols-2">
        <div className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
          <h2 className="text-2xl font-black tracking-tight text-white">Tonight events</h2>
          <div className="mt-4 grid gap-3">
            {events.length ? events.slice(0, 5).map((event) => <EventCard key={event.id} event={event} />) : <EmptyCard text="No approved events yet. Review pending flyers in admin and they will appear here." />}
          </div>
        </div>

        <div className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
          <h2 className="text-2xl font-black tracking-tight text-white">Offers and new openings</h2>
          <div className="mt-4 grid gap-3">
            {offers.length ? offers.slice(0, 3).map((offer) => <OfferCard key={offer.id} offer={offer} />) : <EmptyCard text="Approved happy hour, free-entry, and guest-list offers will appear here." />}
            {openingsIntel.length ? openingsIntel.slice(0, 2).map((item) => <IntelCard key={item.id} item={item} />) : null}
          </div>
        </div>
      </section>

      <section className="grid gap-4 lg:grid-cols-2">
        <div className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
          <h2 className="text-2xl font-black tracking-tight text-white">Warnings today</h2>
          <div className="mt-4 grid gap-3">
            {safetyIntel.length ? safetyIntel.slice(0, 4).map((item) => <IntelCard key={item.id} item={item} tone="rose" />) : <EmptyCard text="Safety warnings from reviewed traveler intel will appear here." />}
          </div>
        </div>

        <div className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
          <h2 className="text-2xl font-black tracking-tight text-white">Price tips</h2>
          <div className="mt-4 grid gap-3">
            {priceIntel.length ? priceIntel.slice(0, 4).map((item) => <IntelCard key={item.id} item={item} tone="cyan" />) : <EmptyCard text="Cover charge, late-entry fee, drink price, and ticket-window notes will appear here." />}
          </div>
        </div>
      </section>

      <PriorityNetworkLinks
        title="Tonight is the fast planner, but the city guides still carry the deeper context"
        description="This page is ideal for urgency, but users still need city guides, events, offers, and intel to make better nightlife decisions. These links keep the planning path compact and clear."
        hubLinks={[
          {
            href: "/events",
            label: "Events",
            description: "Jump into approved nightlife flyers and guest-list momentum.",
          },
          {
            href: "/offers",
            label: "Offers",
            description: "Check venue deals, happy hours, and free-entry windows before leaving.",
          },
          {
            href: "/intel",
            label: "Intel",
            description: "Review warnings, new openings, and price signals shaping tonight.",
          },
          {
            href: "/news",
            label: "News",
            description: "Read broader nightlife updates that help explain city momentum this week.",
          },
        ]}
      />

      <PriorityFaq
        pageUrl="/tonight"
        title="Tonight planner FAQ and next-step paths"
        intro="Tonight is the urgency page. It should answer immediate planning questions, then route users into cities, events, offers, and intel when they need more confidence."
        items={[
          {
            question: "When should I use Tonight instead of a city guide?",
            answer:
              "Use Tonight when you need a fast same-night answer. Use a city guide when you still need neighborhood context, venue type comparisons, or broader nightlife planning.",
          },
          {
            question: "What makes a good next click from the Tonight page?",
            answer:
              "If you need more detail, go to Events for flyers, Offers for deals, Intel for warnings and openings, or a city page for area-by-area nightlife context.",
          },
          {
            question: "Why does Tonight still link into slower pages?",
            answer:
              "Urgency helps users act, but better nightlife choices usually come from combining speed with context. The slower pages add that context without breaking the planning flow.",
          },
        ]}
        nextSteps={[
          {
            href: "/bangkok",
            label: "Open a city guide",
            description: "Best next click if you need area context after the first quick shortlist.",
          },
          {
            href: "/events",
            label: "Check events",
            description: "Use event flyers when tonight's plan depends on a specific party or guest-list push.",
          },
          {
            href: "/intel",
            label: "Review warnings and price tips",
            description: "Good follow-up if you want to avoid weak picks before leaving.",
          },
        ]}
      />

      <NightlifeBriefSignup compact />
      <SiteFooter />
    </main>
  );
}
