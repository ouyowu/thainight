import Image from "next/image";
import type { Metadata } from "next";
import Link from "next/link";
import { ArrowUpRight, BadgePercent, CheckCircle2, MapPin, TimerReset } from "lucide-react";
import { siteBaseUrl } from "@/lib/config";
import type { VenueOfferRow } from "@/lib/database.types";
import { getApprovedOffers } from "@/lib/public-intel";
import { PriorityNetworkLinks } from "@/components/PriorityNetworkLinks";
import { PriorityFaq } from "@/components/PriorityFaq";

export const revalidate = 900;

export const metadata: Metadata = {
  title: "Thailand Nightlife Offers 2026: Happy Hour, Guest Lists & Deals | ThaiNight",
  description:
    "Compare approved Thailand nightlife offers, happy hours, early-bird tickets, free-entry windows, and guest-list deals before going out.",
  alternates: {
    canonical: `${siteBaseUrl()}/offers`,
  },
  openGraph: {
    title: "Thailand nightlife offers: happy hour, guest lists, and deal signals",
    description:
      "Use ThaiNight offers to compare nightlife value, entry windows, and event-linked venue deals across Thailand.",
    url: `${siteBaseUrl()}/offers`,
    siteName: "ThaiNight",
    locale: "en_TH",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Thailand nightlife offers: happy hour, guest lists, and deal signals",
    description:
      "Approved nightlife deals across Thailand, designed for price-sensitive same-night decisions.",
  },
};

function formatWindow(from: string | null, until: string | null): string {
  const formatter = new Intl.DateTimeFormat("en", {
    timeZone: "Asia/Bangkok",
    month: "short",
    day: "numeric",
    hour: "numeric",
    minute: "2-digit",
  });

  if (from && until) return `${formatter.format(new Date(from))} - ${formatter.format(new Date(until))}`;
  if (from) return `From ${formatter.format(new Date(from))}`;
  if (until) return `Until ${formatter.format(new Date(until))}`;
  return "Live deal";
}

async function getOffers(): Promise<VenueOfferRow[]> {
  return getApprovedOffers({ limit: 72 });
}

export default async function OffersPage() {
  const offers = await getOffers();
  const baseUrl = siteBaseUrl();
  const offersUrl = `${baseUrl}/offers`;
  const offersJsonLd = {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": ["CollectionPage", "ItemList"],
        "@id": `${offersUrl}#collection`,
        url: offersUrl,
        name: "Thailand Nightlife Special Offers",
        dateModified: new Date().toISOString(),
        numberOfItems: offers.length,
        itemListElement: offers.slice(0, 36).map((offer, index) => ({
          "@type": "ListItem",
          position: index + 1,
          url: offer.source_url ?? offersUrl,
          name: offer.title,
        })),
      },
    ],
  };

  return (
    <main className="mx-auto flex min-h-screen max-w-[1440px] flex-col gap-8 px-4 py-6 sm:px-6 lg:px-8">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(offersJsonLd) }}
      />
      <section className="rounded-[2rem] border border-zinc-800 bg-zinc-950 px-5 py-8 sm:px-8">
        <Link href="/" className="text-sm font-bold text-zinc-500 transition hover:text-pink-200">
          ThaiNight.co
        </Link>
        <div className="mt-6 max-w-4xl">
          <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-pink-300">
            <BadgePercent className="h-4 w-4" />
            Special Offer Intel
          </p>
          <h1 className="mt-3 text-4xl font-black tracking-tight text-white sm:text-6xl">
            Happy hours, early birds, guest lists, and venue deals
          </h1>
          <p className="mt-4 max-w-2xl text-base leading-8 text-zinc-400">
            ThaiNight extracts offer-like language from approved event flyers and owner submissions, then keeps the
            original source link visible for user verification.
          </p>
          <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-500">
            Treat this as a conversion page for price-sensitive nightlife decisions. Users land here looking for value, time windows, and whether a deal changes tonight&apos;s plan.
          </p>
        </div>
      </section>

      {offers.length > 0 ? (
        <section className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
          {offers.map((offer, index) => (
            <a
              key={offer.id}
              href={offer.source_url ?? "#"}
              target="_blank"
              rel="noreferrer"
              className="group overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-950 transition hover:-translate-y-0.5 hover:border-pink-400/50"
            >
              <div className="relative aspect-[16/10] bg-zinc-900">
                {offer.image_url ? (
                  <Image
                    src={offer.image_url}
                    alt={`${offer.title} nightlife offer - ThaiNight`}
                    fill
                    sizes="(min-width: 1280px) 33vw, (min-width: 768px) 50vw, 100vw"
                    className="h-full w-full object-cover transition duration-500 group-hover:scale-105 group-hover:brightness-90"
                  />
                ) : (
                  <div
                    className={`h-full w-full bg-gradient-to-br ${
                      index % 2 === 0
                        ? "from-pink-500/55 via-rose-500/20 to-zinc-950"
                        : "from-amber-500/50 via-orange-500/20 to-zinc-950"
                    }`}
                  />
                )}
                <div className="absolute inset-0 bg-gradient-to-t from-black/85 via-black/25 to-transparent" />
                <div className="absolute left-4 top-4 flex flex-wrap gap-2">
                  <span className="inline-flex items-center gap-1 rounded-full bg-emerald-400/15 px-3 py-1 text-[11px] font-black uppercase tracking-wide text-emerald-100 backdrop-blur">
                    <CheckCircle2 className="h-3.5 w-3.5" />
                    Approved by ThaiNight
                  </span>
                </div>
                <span className="absolute bottom-4 left-4 rounded-full bg-pink-500 px-3 py-1 text-[11px] font-black uppercase tracking-wide text-white">
                  {offer.offer_label ?? "Special Offer"}
                </span>
              </div>
              <div className="p-5">
                <div className="flex flex-wrap items-center gap-3 text-xs font-semibold uppercase tracking-widest text-zinc-500">
                  <span className="inline-flex items-center gap-1.5">
                    <MapPin className="h-3.5 w-3.5" />
                    {offer.city}
                  </span>
                  <span className="inline-flex items-center gap-1.5">
                    <TimerReset className="h-3.5 w-3.5" />
                    {formatWindow(offer.valid_from, offer.valid_until)}
                  </span>
                </div>
                <h2 className="mt-3 line-clamp-2 text-xl font-black leading-7 text-white">
                  {offer.title}
                </h2>
                <p className="mt-3 line-clamp-4 text-sm leading-6 text-zinc-400">
                  {offer.description ?? "Offer details are being verified by ThaiNight."}
                </p>
                <div className="mt-5 inline-flex items-center gap-2 text-sm font-bold text-pink-100">
                  Open source
                  <ArrowUpRight className="h-4 w-4" />
                </div>
              </div>
            </a>
          ))}
        </section>
      ) : (
        <section className="rounded-3xl border border-dashed border-zinc-800 bg-zinc-950 p-8">
          <h2 className="text-2xl font-black text-white">No approved offers yet</h2>
          <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-400">
            Happy Hour and Special Offer cards will appear here after approved flyer imports or venue owner submissions.
          </p>
        </section>
      )}

      <PriorityNetworkLinks
        title="Use offers as a shortcut into tonight, events, and city guides"
        description="Offers attract high-intent clicks, so this page should feed users back into the city guides, event wall, and tonight planner instead of ending the journey after one deal."
        hubLinks={[
          {
            href: "/tonight",
            label: "Tonight",
            description: "See which cities and venues feel worth visiting tonight after checking deals.",
          },
          {
            href: "/events",
            label: "Events",
            description: "Layer event flyers on top of special offers and guest-list windows.",
          },
          {
            href: "/intel",
            label: "Intel",
            description: "Check warnings, openings, and pricing context before acting on any offer.",
          },
          {
            href: "/news",
            label: "News",
            description: "Read nightlife updates that explain why venues are discounting or pushing special nights.",
          },
        ]}
      />

      <PriorityFaq
        pageUrl="/offers"
        title="Offers FAQ and best next clicks"
        intro="Offer pages attract high-intent traffic, but users still need city context, event fit, and reviewed nightlife intel to decide whether a deal is actually worth acting on."
        items={[
          {
            question: "Are these offers guaranteed?",
            answer:
              "No nightlife offer should be treated as permanent. ThaiNight links back to the source so users can verify current terms with the venue before they go.",
          },
          {
            question: "What should I compare before acting on an offer?",
            answer:
              "Check the city guide, related events, and nightlife intel first. A deal can look attractive on its own but still be weak once crowd, safety, or pricing context is added.",
          },
          {
            question: "Why link offers back into Events and Tonight?",
            answer:
              "Travelers usually do not want a deal in isolation. They want a plan for tonight, and that means combining venue offers with events, people flow, and city-level context.",
          },
        ]}
        nextSteps={[
          {
            href: "/tonight",
            label: "Turn offers into a same-night plan",
            description: "Best next click if you already know you want to go out tonight and need a fast shortlist.",
          },
          {
            href: "/events",
            label: "Layer deals on top of events",
            description: "Compare current venue offers with party flyers and guest-list momentum.",
          },
          {
            href: "/bangkok",
            label: "Return to a city guide",
            description: "Use a city page when you need area context, nearby alternatives, and broader nightlife planning.",
          },
        ]}
      />
    </main>
  );
}
