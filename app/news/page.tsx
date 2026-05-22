import type { Metadata } from "next";
import Link from "next/link";
import { ArrowRight, CalendarDays, ExternalLink, Newspaper, ShieldAlert, Sparkles, WalletCards } from "lucide-react";
import { siteBaseUrl } from "@/lib/config";
import { CITY_CONFIGS } from "@/lib/cities";
import { getLatestPublicIntel } from "@/lib/public-intel";
import type { IntelligenceFeedRow } from "@/lib/database.types";
import { SiteFooter } from "@/components/SiteFooter";
import { PriorityNetworkLinks } from "@/components/PriorityNetworkLinks";
import { PriorityFaq } from "@/components/PriorityFaq";

export const revalidate = 900;

export const metadata: Metadata = {
  title: "Thailand Nightlife News 2026: Openings, Warnings & Events | ThaiNight",
  description:
    "Read fresh Thailand nightlife news for travelers: bar openings, nightlife warnings, event changes, price updates, and tourist-facing nightlife context.",
  alternates: {
    canonical: `${siteBaseUrl()}/news`,
  },
  openGraph: {
    title: "Thailand nightlife news: what changed this week and why it matters",
    description:
      "Fresh nightlife news for travelers, from new openings and warnings to pricing shifts and event changes across Thailand.",
    url: `${siteBaseUrl()}/news`,
    siteName: "ThaiNight",
    locale: "en_TH",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Thailand nightlife news: what changed this week and why it matters",
    description:
      "The editorial freshness layer for ThaiNight, focused on nightlife updates that affect real plans this week.",
  },
};

const NEWS_CATEGORIES = ["nightlife_news", "new_opening", "event", "safety", "price", "offer", "solo"];

const FEATURED_SEARCHES = [
  "Bangkok nightlife news",
  "Pattaya nightlife updates",
  "Phuket Bangla Road safety",
  "Thailand alcohol rules",
  "Bangkok new bar openings",
  "Thailand nightlife prices",
  "Solo traveler nightlife Thailand",
  "Thailand beach club events",
];

function cityLabel(value?: string | null): string {
  return CITY_CONFIGS.find((city) => city.slug === value)?.name ?? value?.replace(/-/g, " ") ?? "Thailand";
}

function sourceLabel(url?: string | null): string {
  if (!url) return "ThaiNight source";
  try {
    return new URL(url).hostname.replace(/^www\./, "");
  } catch {
    return "ThaiNight source";
  }
}

function formatDate(value?: string | null): string {
  if (!value) return "Recently found";
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return "Recently found";
  return new Intl.DateTimeFormat("en", {
    timeZone: "Asia/Bangkok",
    month: "short",
    day: "numeric",
    hour: "numeric",
  }).format(date);
}

function newsLabel(item: IntelligenceFeedRow): string {
  const type = item.venue_type ?? "nightlife_news";
  if (type === "new_opening") return "Opening";
  if (type === "safety") return "Warning";
  if (type === "price") return "Price tip";
  if (type === "event") return "Event";
  if (type === "offer") return "Offer";
  if (type === "solo") return "Traveler question";
  return "Nightlife news";
}

function iconFor(item: IntelligenceFeedRow) {
  if (item.venue_type === "safety") return ShieldAlert;
  if (item.venue_type === "price") return WalletCards;
  if (item.venue_type === "new_opening") return Sparkles;
  return Newspaper;
}

function cleanTitle(title: string): string {
  return title.replace(/\s+-\s+[^-]+$/, "").replace(/^["“]|["”]$/g, "").trim();
}

function NewsCard({ item, featured = false }: { item: IntelligenceFeedRow; featured?: boolean }) {
  const Icon = iconFor(item);

  return (
    <a
      href={item.url}
      target="_blank"
      rel="noreferrer"
      className={`group flex h-full flex-col justify-between rounded-3xl border bg-zinc-950/75 p-5 transition hover:-translate-y-0.5 hover:border-rose-300/35 ${
        featured ? "border-rose-300/25" : "border-zinc-800"
      }`}
    >
      <div>
        <div className="flex flex-wrap items-center gap-2">
          <span className="inline-flex items-center gap-1.5 rounded-full border border-rose-300/20 bg-rose-500/10 px-2.5 py-1 text-[11px] font-black uppercase tracking-widest text-rose-100">
            <Icon className="h-3.5 w-3.5" />
            {newsLabel(item)}
          </span>
          <span className="rounded-full border border-zinc-800 bg-zinc-900 px-2.5 py-1 text-[11px] font-bold text-zinc-400">
            {cityLabel(item.city)}
          </span>
        </div>
        <h2 className={`${featured ? "text-3xl" : "text-xl"} mt-4 line-clamp-3 font-black leading-tight text-white`}>
          {cleanTitle(item.title)}
        </h2>
        <p className="mt-4 line-clamp-4 text-sm leading-7 text-zinc-400">
          {item.body_snippet ?? "Open the source to review the latest Thailand nightlife context before acting on it."}
        </p>
      </div>
      <div className="mt-6 flex items-center justify-between border-t border-white/10 pt-4">
        <span className="truncate text-xs font-bold text-zinc-500">
          {sourceLabel(item.url)} · {formatDate(item.posted_at ?? item.received_at)}
        </span>
        <span className="inline-flex items-center gap-2 text-sm font-black text-rose-100">
          Source
          <ExternalLink className="h-4 w-4 transition group-hover:translate-x-1" />
        </span>
      </div>
    </a>
  );
}

export default async function NewsPage() {
  const items = await getLatestPublicIntel({
    categories: NEWS_CATEGORIES,
    limit: 36,
    minValue: 0.58,
  });

  const featured = items[0];
  const rest = items.slice(1);
  const warningItems = items.filter((item) => item.venue_type === "safety").slice(0, 4);
  const openingItems = items.filter((item) => item.venue_type === "new_opening").slice(0, 4);

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "CollectionPage",
    name: "Thailand Nightlife News",
    description:
      "Fresh Thailand nightlife news, openings, safety notes, price tips, events, and traveler questions collected from public sources.",
    url: `${siteBaseUrl()}/news`,
    inLanguage: "en",
  };

  return (
    <main className="mx-auto flex min-h-screen max-w-7xl flex-col gap-8 px-4 py-6 sm:px-6 lg:px-8">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />

      <section className="rounded-[32px] border border-rose-300/20 bg-[linear-gradient(135deg,rgba(244,63,94,0.18),rgba(9,9,11,0.98)_48%,rgba(14,165,233,0.1))] p-5 sm:p-8">
        <nav className="mb-6 flex items-center gap-2 text-xs font-bold text-zinc-500">
          <Link href="/" className="hover:text-zinc-300">
            ThaiNight
          </Link>
          <ArrowRight className="h-3.5 w-3.5" />
          <span className="text-zinc-300">News</span>
        </nav>
        <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-rose-200">
          <Newspaper className="h-4 w-4" />
          Thailand nightlife news feed
        </p>
        <h1 className="mt-3 max-w-4xl text-balance text-4xl font-black tracking-tight text-white sm:text-6xl">
          Thailand nightlife news for travelers going out this week.
        </h1>
        <p className="mt-4 max-w-3xl text-base leading-8 text-zinc-300">
          Fresh public signals about bar openings, club events, alcohol rules, tourist warnings, price changes, and the nightlife questions foreigners are asking before they go out.
        </p>
        <p className="mt-3 max-w-3xl text-sm leading-7 text-zinc-400">
          News is the freshest editorial layer on the site. It should explain what changed, why it matters this week, and when a reader should jump from a headline into guides, events, or tonight planning.
        </p>
        <div className="mt-6 flex flex-wrap gap-2">
          {FEATURED_SEARCHES.map((item) => (
            <span key={item} className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-2 text-xs font-black text-zinc-200">
              {item}
            </span>
          ))}
        </div>
      </section>

      {featured ? (
        <section className="grid gap-4 lg:grid-cols-[1.2fr_0.8fr]">
          <NewsCard item={featured} featured />
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-1">
            <div className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5">
              <p className="text-xs font-black uppercase tracking-widest text-amber-200">What this section tracks</p>
              <ul className="mt-4 space-y-3 text-sm leading-6 text-zinc-400">
                <li>New bar, club, rooftop, and beach club openings.</li>
                <li>Tourist-facing warnings: fees, scams, safety, and transport.</li>
                <li>Alcohol law, closing-time, event, and ticket changes.</li>
                <li>Questions from travelers planning tonight or this weekend.</li>
              </ul>
            </div>
            <div className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5">
              <p className="text-xs font-black uppercase tracking-widest text-cyan-200">Updated automatically</p>
              <p className="mt-4 text-sm leading-7 text-zinc-400">
                The feed refreshes from public news, RSS, and forum signals. Use original source links to verify exact event details before going out.
              </p>
            </div>
          </div>
        </section>
      ) : (
        <section className="rounded-3xl border border-dashed border-zinc-800 bg-zinc-950 p-8 text-zinc-400">
          News items will appear here after the next import. The crawler is already configured for nightlife news, openings, safety, price, and event signals.
        </section>
      )}

      <section className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
        {rest.map((item) => (
          <NewsCard key={item.id} item={item} />
        ))}
      </section>

      {(warningItems.length > 0 || openingItems.length > 0) && (
        <section className="grid gap-4 lg:grid-cols-2">
          {warningItems.length > 0 && (
            <div className="rounded-3xl border border-red-300/20 bg-red-500/10 p-5">
              <h2 className="flex items-center gap-2 text-2xl font-black text-white">
                <ShieldAlert className="h-5 w-5 text-red-200" />
                Recent warning signals
              </h2>
              <div className="mt-4 space-y-3">
                {warningItems.map((item) => (
                  <a key={item.id} href={item.url} target="_blank" rel="noreferrer" className="block rounded-2xl border border-red-200/10 bg-black/25 p-4 hover:border-red-200/30">
                    <p className="line-clamp-2 text-sm font-black text-white">{cleanTitle(item.title)}</p>
                    <p className="mt-1 text-xs font-bold text-red-100/70">{cityLabel(item.city)} · {sourceLabel(item.url)}</p>
                  </a>
                ))}
              </div>
            </div>
          )}

          {openingItems.length > 0 && (
            <div className="rounded-3xl border border-cyan-300/20 bg-cyan-500/10 p-5">
              <h2 className="flex items-center gap-2 text-2xl font-black text-white">
                <Sparkles className="h-5 w-5 text-cyan-200" />
                New opening signals
              </h2>
              <div className="mt-4 space-y-3">
                {openingItems.map((item) => (
                  <a key={item.id} href={item.url} target="_blank" rel="noreferrer" className="block rounded-2xl border border-cyan-200/10 bg-black/25 p-4 hover:border-cyan-200/30">
                    <p className="line-clamp-2 text-sm font-black text-white">{cleanTitle(item.title)}</p>
                    <p className="mt-1 text-xs font-bold text-cyan-100/70">{cityLabel(item.city)} · {sourceLabel(item.url)}</p>
                  </a>
                ))}
              </div>
            </div>
          )}
        </section>
      )}

      <section className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5">
        <h2 className="flex items-center gap-2 text-2xl font-black text-white">
          <CalendarDays className="h-5 w-5 text-rose-200" />
          Turn news into tonight plans
        </h2>
        <p className="mt-3 max-w-3xl text-sm leading-7 text-zinc-400">
          For practical planning, use the news feed together with ThaiNight city guides, events, offers, and safety notes.
        </p>
        <div className="mt-5 flex flex-wrap gap-2">
          {[
            ["/tonight", "Tonight"],
            ["/intel", "Intel"],
            ["/events", "Events"],
            ["/offers", "Offers"],
            ["/phuket-bangla-road-safety", "Bangla Road safety"],
            ["/pattaya-nightlife-guide", "Pattaya guide"],
          ].map(([href, label]) => (
            <Link key={href} href={href} className="rounded-full border border-zinc-800 bg-zinc-900 px-4 py-2 text-sm font-black text-zinc-100 hover:border-rose-300/35">
              {label}
            </Link>
          ))}
        </div>
      </section>

      <PriorityNetworkLinks
        title="Use news as the editorial layer, then push visitors back into city and planning pages"
        description="News builds freshness and authority, but city guides, tonight plans, events, and offers are what turn curiosity into action. These links keep that path obvious for both users and Google."
        hubLinks={[
          {
            href: "/tonight",
            label: "Tonight",
            description: "Turn nightlife headlines into a same-night plan with warnings and crowd flow.",
          },
          {
            href: "/events",
            label: "Events",
            description: "Pair nightlife updates with approved flyers and current event listings.",
          },
          {
            href: "/offers",
            label: "Offers",
            description: "Check which deals and guest lists are worth acting on after reading the news.",
          },
          {
            href: "/intel",
            label: "Intel",
            description: "Move into the reviewed signal library for warnings, openings, and price context.",
          },
        ]}
      />

      <PriorityFaq
        pageUrl="/news"
        title="News FAQ and best next steps"
        intro="News helps freshness and topical authority, but users still need strong paths back into city planning, events, offers, and reviewed nightlife intel."
        items={[
          {
            question: "What kind of stories belong on ThaiNight News?",
            answer:
              "The news feed focuses on nightlife openings, warnings, pricing changes, event momentum, and traveler-facing nightlife updates rather than generic tourism headlines.",
          },
          {
            question: "How should users move on after reading a nightlife news item?",
            answer:
              "The best follow-up is usually a city guide, Tonight, Events, or Intel so the user can turn a headline into a real nightlife decision.",
          },
          {
            question: "Why is the News page different from the Intel page?",
            answer:
              "News is broader and more editorial. Intel is the reviewed signal library for warnings, openings, price notes, and public nightlife information that is easier to act on directly.",
          },
        ]}
        nextSteps={[
          {
            href: "/tonight",
            label: "Move from headlines to tonight's plan",
            description: "Best next click when a news item makes you want a quick same-night plan.",
          },
          {
            href: "/intel",
            label: "Open the reviewed intel library",
            description: "Use this when you want the cleaner signal layer behind the broader nightlife headlines.",
          },
          {
            href: "/bangkok",
            label: "Jump back into a city guide",
            description: "Use a city guide when you want to apply nightlife news to real areas, venues, and local planning.",
          },
        ]}
      />

      <SiteFooter />
    </main>
  );
}
