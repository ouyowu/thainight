import type { Metadata } from "next";
import type { ReactNode } from "react";
import Link from "next/link";
import {
  ArrowRight,
  BadgePercent,
  CalendarDays,
  ExternalLink,
  Radio,
  ShieldAlert,
  Sparkles,
  WalletCards,
} from "lucide-react";
import { CITY_CONFIGS } from "@/lib/cities";
import { SiteFooter } from "@/components/SiteFooter";
import { siteBaseUrl } from "@/lib/config";
import { getApprovedOffers, getPublicIntel, getUpcomingEvents } from "@/lib/public-intel";
import type { EventFlyerRow, VenueOfferRow } from "@/lib/database.types";
import { PriorityNetworkLinks } from "@/components/PriorityNetworkLinks";
import { PriorityFaq } from "@/components/PriorityFaq";

export const metadata: Metadata = {
  title: "Thailand Nightlife Intel 2026: Openings, Warnings & Price Tips | ThaiNight",
  description:
    "Review Thailand nightlife intel for openings, safety warnings, price tips, offers, and event signals across Bangkok, Pattaya, Phuket, and Chiang Mai.",
  alternates: {
    canonical: `${siteBaseUrl()}/intel`,
  },
  openGraph: {
    title: "Thailand nightlife intel: reviewed openings, warnings, and price signals",
    description:
      "ThaiNight's reviewed signal library for nightlife decisions, not just a news feed.",
    url: `${siteBaseUrl()}/intel`,
    siteName: "ThaiNight",
    locale: "en_TH",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Thailand nightlife intel: reviewed openings, warnings, and price signals",
    description:
      "A curated nightlife signal library covering openings, warnings, event clues, and pricing shifts across Thailand.",
  },
};

function cityLabel(value?: string | null): string {
  return CITY_CONFIGS.find((city) => city.slug === value)?.name ?? value?.replace(/-/g, " ") ?? "Thailand";
}

function sourceLabel(url?: string | null): string {
  if (!url) return "Reviewed source";
  try {
    return new URL(url).hostname.replace(/^www\./, "");
  } catch {
    return "Reviewed source";
  }
}

function formatDate(value?: string | null): string {
  if (!value) return "Date checking";
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return "Date checking";
  return new Intl.DateTimeFormat("en", {
    timeZone: "Asia/Bangkok",
    month: "short",
    day: "numeric",
    hour: "numeric",
  }).format(date);
}

type SectionTone = "cyan" | "rose" | "amber" | "pink" | "violet";

const TONE_CLASSES: Record<SectionTone, string> = {
  cyan: "border-cyan-300/20 bg-cyan-500/10 text-cyan-100",
  rose: "border-rose-300/20 bg-rose-500/10 text-rose-100",
  amber: "border-amber-300/20 bg-amber-500/10 text-amber-100",
  pink: "border-pink-300/20 bg-pink-500/10 text-pink-100",
  violet: "border-violet-300/20 bg-violet-500/10 text-violet-100",
};

function ContentCard({
  eyebrow,
  title,
  body,
  href,
  source,
  tone,
}: {
  eyebrow: string;
  title: string;
  body?: string | null;
  href?: string | null;
  source?: string | null;
  tone: SectionTone;
}) {
  const card = (
    <article className={`group flex min-h-56 flex-col justify-between rounded-3xl border p-5 transition hover:-translate-y-0.5 ${TONE_CLASSES[tone]}`}>
      <div>
        <p className="text-xs font-black uppercase tracking-widest opacity-80">{eyebrow}</p>
        <h3 className="mt-3 line-clamp-3 text-2xl font-black leading-tight text-white">
          {title}
        </h3>
        <p className="mt-4 line-clamp-3 text-sm leading-6 text-zinc-300">
          {body || "Human-reviewed nightlife item. Open the source for the original context before acting on it."}
        </p>
      </div>
      <div className="mt-5 flex items-center justify-between border-t border-white/10 pt-4">
        <span className="truncate text-xs font-bold text-zinc-500">{source ?? "ThaiNight reviewed"}</span>
        <span className="inline-flex items-center gap-2 text-sm font-black text-white">
          Open
          <ExternalLink className="h-4 w-4 transition group-hover:translate-x-1" />
        </span>
      </div>
    </article>
  );

  if (!href) return card;

  return (
    <a href={href} target="_blank" rel="noreferrer">
      {card}
    </a>
  );
}

function EmptyState({ text }: { text: string }) {
  return (
    <div className="rounded-3xl border border-dashed border-zinc-800 bg-zinc-950/70 p-6 text-sm leading-6 text-zinc-500">
      {text}
    </div>
  );
}

function LibrarySection({
  id,
  label,
  title,
  description,
  icon: Icon,
  tone,
  children,
}: {
  id: string;
  label: string;
  title: string;
  description: string;
  icon: typeof Sparkles;
  tone: SectionTone;
  children: ReactNode;
}) {
  return (
    <section id={id} className="space-y-4">
      <div className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p className={`inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest ${TONE_CLASSES[tone].split(" ")[2]}`}>
            <Icon className="h-4 w-4" />
            {label}
          </p>
          <h2 className="mt-2 text-3xl font-black tracking-tight text-white">{title}</h2>
          <p className="mt-2 max-w-2xl text-sm leading-6 text-zinc-500">{description}</p>
        </div>
      </div>
      <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">{children}</div>
    </section>
  );
}

export default async function IntelPage() {
  const [events, offers, warnings, priceTips, openings] = await Promise.all([
    getUpcomingEvents({ limit: 12 }),
    getApprovedOffers({ limit: 12 }),
    getPublicIntel({ category: "safety", limit: 12 }),
    getPublicIntel({ category: "price", limit: 12 }),
    getPublicIntel({ category: "new_opening", limit: 12 }),
  ]);

  const navItems = [
    ["New openings", "#new-openings"],
    ["Warnings", "#warnings"],
    ["Price tips", "#price-tips"],
    ["Events", "#events"],
    ["Offers", "#offers"],
  ] as const;

  return (
    <main className="mx-auto flex min-h-screen max-w-7xl flex-col gap-10 px-4 py-6 sm:px-6 lg:px-8">
      <section className="rounded-[32px] border border-cyan-300/20 bg-[linear-gradient(135deg,rgba(8,145,178,0.18),rgba(9,9,11,0.98)_48%,rgba(244,63,94,0.1))] p-5 sm:p-8">
        <nav className="mb-6 flex items-center gap-2 text-xs font-bold text-zinc-500">
          <Link href="/" className="hover:text-zinc-300">
            ThaiNight
          </Link>
          <ArrowRight className="h-3.5 w-3.5" />
          <span className="text-zinc-300">Intel</span>
        </nav>
        <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-cyan-200">
          <Radio className="h-4 w-4" />
          Human-reviewed content library
        </p>
        <h1 className="mt-3 max-w-4xl text-balance text-4xl font-black tracking-tight text-white sm:text-5xl">
          Approved Thailand nightlife intel, rewritten into public-ready cards.
        </h1>
        <p className="mt-4 max-w-2xl text-base leading-8 text-zinc-300">
          New openings, warnings, price tips, events, and offers only appear here after review. Titles are shortened for travelers instead of exposing raw feed noise.
        </p>
        <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-400">
          This is ThaiNight&apos;s reviewed signal library. It should feel more curated and decision-oriented than the news feed, with stronger emphasis on what changes real nightlife choices.
        </p>
        <div className="mt-6 flex flex-wrap gap-2">
          {navItems.map(([label, href]) => (
            <a
              key={href}
              href={href}
              className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-2 text-xs font-black text-zinc-200 transition hover:border-cyan-200/40 hover:bg-cyan-500/10 hover:text-white"
            >
              {label}
            </a>
          ))}
        </div>
      </section>

      <LibrarySection
        id="new-openings"
        label="New openings"
        title="New bars, clubs, menus, and venue launches"
        description="Reviewed opening signals from news, traveler posts, and public nightlife sources."
        icon={Sparkles}
        tone="cyan"
      >
        {openings.length ? (
          openings.map((item) => (
            <ContentCard
              key={item.id}
              eyebrow={`${cityLabel(item.city)} · ${item.source}`}
              title={item.title}
              body={item.body_snippet}
              href={item.url}
              source={sourceLabel(item.url)}
              tone="cyan"
            />
          ))
        ) : (
          <EmptyState text="No reviewed opening items yet. Approve suitable ThaiNight signals as Openings from the admin queue." />
        )}
      </LibrarySection>

      <LibrarySection
        id="warnings"
        label="Warnings"
        title="Safety notes and avoid signals"
        description="Fee, scam, overcharge, closure, police, and tourist-risk signals after manual review."
        icon={ShieldAlert}
        tone="rose"
      >
        {warnings.length ? (
          warnings.map((item) => (
            <ContentCard
              key={item.id}
              eyebrow={`${cityLabel(item.city)} · warning`}
              title={item.title}
              body={item.body_snippet}
              href={item.url}
              source={sourceLabel(item.url)}
              tone="rose"
            />
          ))
        ) : (
          <EmptyState text="No reviewed warning items yet. Approve suitable ThaiNight signals as Warnings from the admin queue." />
        )}
      </LibrarySection>

      <LibrarySection
        id="price-tips"
        label="Price tips"
        title="Cover charges, tickets, drink prices, and fees"
        description="Practical price notes that help travelers avoid surprises before going out."
        icon={WalletCards}
        tone="amber"
      >
        {priceTips.length ? (
          priceTips.map((item) => (
            <ContentCard
              key={item.id}
              eyebrow={`${cityLabel(item.city)} · price tip`}
              title={item.title}
              body={item.body_snippet}
              href={item.url}
              source={sourceLabel(item.url)}
              tone="amber"
            />
          ))
        ) : (
          <EmptyState text="No reviewed price tips yet. Approve suitable ThaiNight signals as Price Tips from the admin queue." />
        )}
      </LibrarySection>

      <LibrarySection
        id="events"
        label="Events"
        title="Approved events and flyers"
        description="Only events with enough source context or manual approval are shown here."
        icon={CalendarDays}
        tone="violet"
      >
        {events.length ? (
          events.map((event: EventFlyerRow) => (
            <ContentCard
              key={event.id}
              eyebrow={`${cityLabel(event.city)} · ${formatDate(event.event_date)}`}
              title={event.title}
              body={event.description}
              href={event.source_url}
              source={sourceLabel(event.source_url)}
              tone="violet"
            />
          ))
        ) : (
          <EmptyState text="No approved upcoming events yet. Review pending event flyers in the admin panel." />
        )}
      </LibrarySection>

      <LibrarySection
        id="offers"
        label="Offers"
        title="Approved deals, happy hours, and guest-list notes"
        description="Only real offers stay here. Generic promotional copy is filtered out."
        icon={BadgePercent}
        tone="pink"
      >
        {offers.length ? (
          offers.map((offer: VenueOfferRow) => (
            <ContentCard
              key={offer.id}
              eyebrow={`${cityLabel(offer.city)} · ${offer.offer_label ?? "offer"}`}
              title={offer.title}
              body={offer.description}
              href={offer.source_url}
              source={sourceLabel(offer.source_url)}
              tone="pink"
            />
          ))
        ) : (
          <EmptyState text="No approved offers yet. Review pending offers in the admin panel." />
        )}
      </LibrarySection>

      <PriorityNetworkLinks
        title="Use the intel library to feed city guides, tonight planning, and conversion pages"
        description="Intel explains why certain venues, events, and offers matter. This section should send readers back into the city guides and the high-intent planning pages instead of trapping them in the library."
        hubLinks={[
          {
            href: "/bangkok-nightlife-tonight",
            label: "Bangkok tonight",
            description: "Best next step when a Bangkok signal should turn into a same-night area and event choice.",
          },
          {
            href: "/pattaya-nightlife-tonight",
            label: "Pattaya tonight",
            description: "Use this when Walking Street, Soi Buakhao, or Pattaya pricing signals affect tonight's plan.",
          },
          {
            href: "/phuket-nightlife-tonight",
            label: "Phuket tonight",
            description: "A better handoff when Patong, Bangla Road, or beach-club intel changes a Phuket night.",
          },
          {
            href: "/walking-street-pattaya-safety",
            label: "Walking Street safety",
            description: "Send tourist-risk and overcharge signals into a dedicated Pattaya safety page instead of leaving them abstract.",
          },
          {
            href: "/tonight",
            label: "Tonight",
            description: "Apply opening, warning, and price signals to an immediate nightlife plan.",
          },
          {
            href: "/offers",
            label: "Offers",
            description: "Check which nightlife deals are worth pairing with tonight's plan.",
          },
          {
            href: "/news",
            label: "News",
            description: "Read the broader editorial layer behind the reviewed signals in this library.",
          },
        ]}
      />

      <PriorityFaq
        pageUrl="/intel"
        title="Intel library FAQ and best follow-up clicks"
        intro="Intel adds explanation and trust, but most users still need to move from reviewed signals into a city guide, tonight planner, event wall, or offer page to actually decide what to do."
        items={[
          {
            question: "What is the difference between Intel and News?",
            answer:
              "Intel is the reviewed signal library. It is organized around practical nightlife categories like openings, warnings, and price tips. News is broader and more editorial.",
          },
          {
            question: "When should I use Intel before going out?",
            answer:
              "Use it when you want to reduce risk, compare nightlife price context, or verify whether a venue or area is trending for the right reasons.",
          },
          {
            question: "What should I click after reading Intel?",
            answer:
              "If the signal changes your plan, move into a city guide, Tonight, Events, or Offers so you can translate that insight into an actual nightlife choice.",
          },
        ]}
        nextSteps={[
          {
            href: "/tonight",
            label: "Turn intel into tonight's plan",
            description: "Best next click when you want to convert warnings, openings, and pricing context into an immediate nightlife route.",
          },
          {
            href: "/phuket-nightlife-tonight",
            label: "Use a city-specific tonight page",
            description: "Better follow-up when the signal clearly belongs to a real city plan instead of a broad Thailand overview.",
          },
          {
            href: "/news",
            label: "Read broader nightlife news",
            description: "Good next step if you want more editorial context around the reviewed signals.",
          },
        ]}
      />

      <SiteFooter />
    </main>
  );
}
