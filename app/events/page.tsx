import Image from "next/image";
import type { Metadata } from "next";
import Link from "next/link";
import { ArrowUpRight, CalendarDays, CheckCircle2, MapPin, Sparkles } from "lucide-react";
import { siteBaseUrl } from "@/lib/config";
import type { EventFlyerRow } from "@/lib/database.types";
import { getUpcomingEvents } from "@/lib/public-intel";
import { PriorityNetworkLinks } from "@/components/PriorityNetworkLinks";
import { PriorityFaq } from "@/components/PriorityFaq";

export const revalidate = 900;

export const metadata: Metadata = {
  title: "Thailand Nightlife Events 2026: Flyers, Parties & Guest Lists | ThaiNight",
  description:
    "Browse approved Thailand nightlife events, party flyers, guest-list signals, and public event momentum across Bangkok, Pattaya, Phuket, and Chiang Mai.",
  alternates: {
    canonical: `${siteBaseUrl()}/events`,
  },
  openGraph: {
    title: "Thailand nightlife events: flyers, parties, and event momentum",
    description:
      "Use ThaiNight's approved event wall to compare nightlife flyers, guest lists, and same-week event demand across Thailand.",
    url: `${siteBaseUrl()}/events`,
    siteName: "ThaiNight",
    locale: "en_TH",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Thailand nightlife events: flyers, parties, and event momentum",
    description:
      "Approved nightlife events, flyers, and guest-list signals across Thailand's main going-out cities.",
  },
};

function formatEventDate(value: string | null): string {
  if (!value) return "Date checking";
  return new Intl.DateTimeFormat("en", {
    timeZone: "Asia/Bangkok",
    weekday: "short",
    month: "short",
    day: "numeric",
    hour: "numeric",
    minute: "2-digit",
  }).format(new Date(value));
}

async function getEvents(): Promise<EventFlyerRow[]> {
  return getUpcomingEvents({ limit: 72 });
}

export default async function EventsPage() {
  const events = await getEvents();
  const baseUrl = siteBaseUrl();
  const eventsUrl = `${baseUrl}/events`;
  const eventsJsonLd = {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": ["CollectionPage", "ItemList"],
        "@id": `${eventsUrl}#collection`,
        url: eventsUrl,
        name: "Thailand Nightlife Events",
        dateModified: new Date().toISOString(),
        numberOfItems: events.length,
        itemListElement: events.slice(0, 36).map((event, index) => ({
          "@type": "ListItem",
          position: index + 1,
          url: event.source_url ?? eventsUrl,
          name: event.title,
        })),
      },
    ],
  };

  return (
    <main className="mx-auto flex min-h-screen max-w-[1440px] flex-col gap-8 px-4 py-6 sm:px-6 lg:px-8">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(eventsJsonLd) }}
      />
      <section className="rounded-[2rem] border border-zinc-800 bg-zinc-950 px-5 py-8 sm:px-8">
        <Link href="/" className="text-sm font-bold text-zinc-500 transition hover:text-rose-200">
          ThaiNight.co
        </Link>
        <div className="mt-6 max-w-4xl">
          <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-rose-300">
            <CalendarDays className="h-4 w-4" />
            Approved Event Wall
          </p>
          <h1 className="mt-3 text-4xl font-black tracking-tight text-white sm:text-6xl">
            Thailand nightlife events, flyers, and tonight-only signals
          </h1>
          <p className="mt-4 max-w-2xl text-base leading-8 text-zinc-400">
            Public event pages, community uploads, and ThaiNight signals are reviewed before they appear here.
            ThaiNight keeps source links visible so users can verify details before going out.
          </p>
          <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-500">
            This page should feel like a live event wall, not a generic nightlife blog. Use it when you already care about specific parties, flyer momentum, and date-driven planning.
          </p>
        </div>
      </section>

      {events.length > 0 ? (
        <section className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
          {events.map((event) => (
            <a
              key={event.id}
              href={event.source_url ?? "#"}
              target="_blank"
              rel="noreferrer"
              className="group overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-950 transition hover:-translate-y-0.5 hover:border-rose-400/50"
            >
              <div className="relative aspect-[4/3] bg-zinc-900">
                {event.flyer_image_url ? (
                  <Image
                    src={event.flyer_image_url}
                    alt={`${event.title} event flyer - ThaiNight`}
                    fill
                    sizes="(min-width: 1280px) 33vw, (min-width: 768px) 50vw, 100vw"
                    className="h-full w-full object-cover transition duration-500 group-hover:scale-105 group-hover:brightness-90"
                  />
                ) : (
                  <div className="h-full w-full bg-gradient-to-br from-rose-500/50 via-violet-500/25 to-zinc-950" />
                )}
                <div className="absolute inset-0 bg-gradient-to-t from-black/85 via-black/20 to-transparent" />
                <div className="absolute left-4 top-4 flex flex-wrap gap-2">
                  <span className="inline-flex items-center gap-1 rounded-full bg-emerald-400/15 px-3 py-1 text-[11px] font-black uppercase tracking-wide text-emerald-100 backdrop-blur">
                    <CheckCircle2 className="h-3.5 w-3.5" />
                    Approved by ThaiNight
                  </span>
                  {event.is_featured ? (
                    <span className="inline-flex items-center gap-1 rounded-full bg-rose-500 px-3 py-1 text-[11px] font-black uppercase tracking-wide text-white">
                      <Sparkles className="h-3.5 w-3.5" />
                      Featured
                    </span>
                  ) : null}
                </div>
              </div>
              <div className="p-5">
                <div className="flex flex-wrap items-center gap-3 text-xs font-semibold uppercase tracking-widest text-zinc-500">
                  <span className="inline-flex items-center gap-1.5">
                    <MapPin className="h-3.5 w-3.5" />
                    {event.city}
                  </span>
                  <span>{formatEventDate(event.event_date)}</span>
                </div>
                <h2 className="mt-3 line-clamp-2 text-xl font-black leading-7 text-white">
                  {event.title}
                </h2>
                <p className="mt-3 line-clamp-4 text-sm leading-6 text-zinc-400">
                  {event.description ?? "Event details are being verified by ThaiNight."}
                </p>
                <div className="mt-5 inline-flex items-center gap-2 text-sm font-bold text-rose-100">
                  Open source
                  <ArrowUpRight className="h-4 w-4" />
                </div>
              </div>
            </a>
          ))}
        </section>
      ) : (
        <section className="rounded-3xl border border-dashed border-zinc-800 bg-zinc-950 p-8">
          <h2 className="text-2xl font-black text-white">No approved events yet</h2>
          <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-400">
            The event scraper and owner upload pipeline are ready. Once approved flyers are imported, this page will
            show the public event wall automatically.
          </p>
        </section>
      )}

      <PriorityNetworkLinks
        title="Use events as a route back into city planning"
        description="Events are one of ThaiNight's strongest demand signals. From here, users should be able to jump back into the city guides, tonight planning, and offers without getting stuck on a single list page."
        hubLinks={[
          {
            href: "/tonight",
            label: "Tonight",
            description: "Turn the event wall into a same-night plan with warnings and people flow.",
          },
          {
            href: "/offers",
            label: "Offers",
            description: "Pair events with guest lists, free-entry windows, and drink deals.",
          },
          {
            href: "/intel",
            label: "Intel",
            description: "Review opening, warning, and price signals behind what is worth attending.",
          },
          {
            href: "/news",
            label: "News",
            description: "Read nightlife updates that explain why certain events are gaining momentum.",
          },
        ]}
      />

      <PriorityFaq
        pageUrl="/events"
        title="Events FAQ and best next clicks"
        intro="The event wall is a high-intent page, but it works best when it sends people back into city planning, offers, and nightlife intel instead of becoming a dead-end list."
        items={[
          {
            question: "Are these events manually reviewed?",
            answer:
              "ThaiNight reviews public event sources and owner submissions before they appear here, and keeps the original source link visible so travelers can verify details.",
          },
          {
            question: "What should I do after finding an event I like?",
            answer:
              "Most users should check the city guide, compare current offers, and review warnings or price tips before committing to a night out.",
          },
          {
            question: "Why does this page link back to city guides so often?",
            answer:
              "An event flyer tells you what is happening, but city guides explain area fit, nightlife patterns, and what else is nearby if your first plan changes.",
          },
        ]}
        nextSteps={[
          {
            href: "/bangkok",
            label: "Go back into Bangkok planning",
            description: "Best follow-up for the biggest event demand cluster on the site.",
          },
          {
            href: "/offers",
            label: "Pair events with current offers",
            description: "Check guest-list windows, happy hours, and venue deals before you choose where to go.",
          },
          {
            href: "/intel",
            label: "Review warnings and openings",
            description: "Use reviewed nightlife intel to avoid weak picks and spot stronger same-night alternatives.",
          },
        ]}
      />
    </main>
  );
}
