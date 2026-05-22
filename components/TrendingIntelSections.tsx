import Link from "next/link";
import Image from "next/image";
import {
  ArrowRight,
  BadgePercent,
  BadgeCheck,
  CalendarDays,
  Flame,
  MapPin,
  Megaphone,
  Sparkles,
} from "lucide-react";
import type { EventFlyerRow, VenueOfferRow } from "@/lib/database.types";

type Props = {
  curatedEvents?: EventFlyerRow[];
  curatedOffers?: VenueOfferRow[];
};

function posterTone(index: number): string {
  const tones = [
    "from-rose-500/55 via-fuchsia-500/20 to-zinc-950",
    "from-violet-500/55 via-indigo-500/20 to-zinc-950",
    "from-amber-500/55 via-orange-500/20 to-zinc-950",
    "from-cyan-500/55 via-sky-500/20 to-zinc-950",
    "from-emerald-500/55 via-teal-500/20 to-zinc-950",
  ];

  return tones[index % tones.length];
}

type DisplayIntel = {
  id: string;
  title: string;
  summary: string;
  city: string;
  url?: string | null;
  imageUrl?: string | null;
  badge?: string | null;
  platform?: string | null;
  approved?: boolean;
  urgencyLabel?: string | null;
};

function eventUrgencyLabel(value: string | null): string {
  if (!value) return "Approved by ThaiNight";
  const now = new Date();
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return "Approved by ThaiNight";

  const bangkokDay = new Intl.DateTimeFormat("en-CA", {
    timeZone: "Asia/Bangkok",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  });
  if (bangkokDay.format(date) === bangkokDay.format(now)) return "Tonight";

  const daysAway = Math.ceil((date.getTime() - now.getTime()) / 86_400_000);
  if (daysAway <= 7) return "This week";
  return "Upcoming";
}

function fromEvent(event: EventFlyerRow): DisplayIntel {
  return {
    id: event.id,
    title: event.title,
    summary: event.description ?? "Fresh event flyer approved by ThaiNight.",
    city: event.city,
    url: event.source_url,
    imageUrl: event.flyer_image_url,
    badge: event.is_featured ? "Featured" : "Approved",
    platform: "ThaiNight",
    approved: true,
    urgencyLabel: eventUrgencyLabel(event.event_date),
  };
}

function fromOffer(offer: VenueOfferRow): DisplayIntel {
  return {
    id: offer.id,
    title: offer.title,
    summary: offer.description ?? "Verified venue offer approved by ThaiNight.",
    city: offer.city,
    url: offer.source_url,
    imageUrl: offer.image_url,
    badge: offer.offer_label ?? (offer.is_featured ? "Featured" : "Offer"),
    platform: "ThaiNight",
    approved: true,
    urgencyLabel: offer.offer_label ?? "Happy Hour",
  };
}

function FeaturedPoster({
  intel,
  index,
}: {
  intel: DisplayIntel;
  index: number;
}) {
  const content = (
    <>
      {intel.imageUrl ? (
        <Image
          src={intel.imageUrl}
          alt={intel.title}
          fill
          sizes="(min-width: 1280px) 33vw, (min-width: 768px) 50vw, 100vw"
          className="absolute inset-0 object-cover"
        />
      ) : (
        <div className={`absolute inset-0 bg-gradient-to-br ${posterTone(index)}`} />
      )}
      <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(255,255,255,0.18),transparent_35%)]" />
      <div className="absolute inset-0 bg-gradient-to-t from-black via-black/40 to-black/10" />

      <div className="relative flex h-full flex-col justify-between p-5">
        <div className="flex items-center justify-between gap-3">
          <div className="flex flex-wrap items-center gap-2">
            <span className="inline-flex items-center gap-2 rounded-full border border-white/15 bg-black/35 px-3 py-1 text-[11px] font-bold uppercase tracking-widest text-white/90 backdrop-blur">
              <Flame className="h-3.5 w-3.5 text-rose-200" />
              Tonight Intel
            </span>
            {intel.approved ? (
              <span className="inline-flex items-center gap-1 rounded-full bg-emerald-400/15 px-3 py-1 text-[11px] font-black uppercase tracking-wide text-emerald-100">
                <BadgeCheck className="h-3.5 w-3.5" />
                Approved by ThaiNight
              </span>
            ) : null}
          </div>
          <span className="rounded-full bg-rose-500 px-3 py-1 text-[11px] font-black uppercase tracking-wide text-white">
            {intel.badge ?? "Live"}
          </span>
        </div>

        <div>
          <p className="inline-flex items-center gap-2 text-xs font-semibold uppercase tracking-widest text-white/70">
            <MapPin className="h-3.5 w-3.5" />
            {intel.city}
          </p>
          {intel.urgencyLabel ? (
            <div className="mt-3 inline-flex rounded-full bg-amber-400 px-3 py-1 text-[11px] font-black uppercase tracking-wide text-zinc-950">
              {intel.urgencyLabel}
            </div>
          ) : null}
          <h3 className="mt-3 line-clamp-3 text-2xl font-black leading-tight text-white">
            {intel.title}
          </h3>
          <p className="mt-3 line-clamp-3 text-sm leading-6 text-white/78">
            {intel.summary}
          </p>
          <div className="mt-5 inline-flex items-center gap-2 text-sm font-bold text-white">
            {intel.url ? "Open source" : "ThaiNight intel"}
            <ArrowRight className="h-4 w-4 transition group-hover:translate-x-1" />
          </div>
        </div>
      </div>
    </>
  );

  if (!intel.url) {
    return (
      <div className="group relative min-h-[260px] overflow-hidden rounded-3xl border border-white/10 bg-zinc-950">
        {content}
      </div>
    );
  }

  return (
    <a
      href={intel.url}
      target="_blank"
      rel="noreferrer"
      className="group relative min-h-[260px] overflow-hidden rounded-3xl border border-white/10 bg-zinc-950"
    >
      {content}
    </a>
  );
}

function OfferCard({
  intel,
  index,
}: {
  intel: DisplayIntel;
  index: number;
}) {
  return (
    <a
      href={intel.url ?? "#"}
      target="_blank"
      rel="noreferrer"
      className="group overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-950/95 transition hover:-translate-y-0.5 hover:border-pink-400/50"
    >
      <div className={`relative h-36 bg-gradient-to-br ${posterTone(index + 1)}`}>
        {intel.imageUrl ? (
          <Image
            src={intel.imageUrl}
            alt={intel.title}
            fill
            sizes="(min-width: 1280px) 33vw, (min-width: 768px) 50vw, 100vw"
            className="absolute inset-0 object-cover"
          />
        ) : null}
        <div className="absolute inset-0 bg-black/25" />
        <span className="absolute right-4 top-4 inline-flex items-center gap-1 rounded-full bg-pink-500 px-3 py-1 text-[11px] font-black uppercase tracking-wide text-white">
          <BadgePercent className="h-3.5 w-3.5" />
          {intel.badge ?? "Special Offer"}
        </span>
        {intel.approved ? (
          <span className="absolute left-4 top-4 rounded-full bg-emerald-400/15 px-3 py-1 text-[11px] font-black uppercase tracking-wide text-emerald-100">
            Approved by ThaiNight
          </span>
        ) : null}
      </div>
      <div className="p-4">
        <p className="inline-flex items-center gap-2 text-xs font-semibold uppercase tracking-widest text-zinc-500">
          <MapPin className="h-3.5 w-3.5" />
          {intel.city}
        </p>
        {intel.urgencyLabel ? (
          <div className="mt-3 inline-flex rounded-full bg-amber-400 px-3 py-1 text-[11px] font-black uppercase tracking-wide text-zinc-950">
            {intel.urgencyLabel}
          </div>
        ) : null}
        <h3 className="mt-3 line-clamp-3 text-lg font-black leading-7 text-white">
          {intel.title}
        </h3>
        <p className="mt-3 line-clamp-3 text-sm leading-6 text-zinc-400">
          {intel.summary}
        </p>
      </div>
    </a>
  );
}

export function TrendingIntelSections({
  curatedEvents = [],
  curatedOffers = [],
}: Props) {
  const eventIntel = curatedEvents.map(fromEvent);
  const offerIntel = curatedOffers.map(fromOffer);

  return (
    <>
      <section className="space-y-5">
        <div className="flex flex-col gap-3 md:flex-row md:items-end md:justify-between">
          <div>
            <p className="inline-flex items-center gap-2 text-xs font-semibold uppercase tracking-widest text-rose-300">
              <Megaphone className="h-4 w-4" />
              Trending Events
            </p>
            <h2 className="mt-2 text-3xl font-black tracking-tight text-white">
              Approved events and nightlife flyers
            </h2>
          </div>
          <p className="max-w-xl text-sm leading-6 text-zinc-500">
            Only manually approved event items appear here. ThaiNight discussion signals stay out of this shelf.
          </p>
          <Link
            href="/events"
            className="inline-flex min-h-11 items-center gap-2 rounded-full border border-rose-400/20 bg-rose-500/10 px-4 py-2 text-sm font-bold text-rose-100 transition hover:border-rose-300/50 hover:bg-rose-500/15"
          >
            <CalendarDays className="h-4 w-4" />
            View all events
          </Link>
        </div>

        {eventIntel.length > 0 ? (
            <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
              {eventIntel.slice(0, 9).map((intel, index) => (
                <FeaturedPoster key={intel.id} intel={intel} index={index} />
              ))}
            </div>
        ) : (
          <div className="rounded-3xl border border-dashed border-zinc-800 bg-zinc-950/70 p-6">
            <div className="max-w-3xl">
              <h3 className="text-xl font-black text-white">No verified events yet today</h3>
              <p className="mt-2 text-sm leading-7 text-zinc-400">
                The import system is checking allowed sources, but only approved events appear here. In the meantime,
                start with city nightlife areas and venue guides instead of waiting on a raw feed.
              </p>
              <div className="mt-4 flex flex-wrap gap-2">
                {[
                  ["Bangkok nightlife", "/bangkok"],
                  ["Pattaya nightlife", "/pattaya"],
                  ["Phuket nightlife", "/phuket"],
                  ["Chiang Mai nightlife", "/chiang-mai"],
                ].map(([label, href]) => (
                  <Link
                    key={href}
                    href={href}
                    className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-2 text-xs font-black text-zinc-200 transition hover:border-rose-300/40 hover:text-white"
                  >
                    {label}
                  </Link>
                ))}
              </div>
            </div>
          </div>
        )}
      </section>

      <section className="space-y-5">
        <div className="flex flex-col gap-3 md:flex-row md:items-end md:justify-between">
          <div>
            <p className="inline-flex items-center gap-2 text-xs font-semibold uppercase tracking-widest text-pink-300">
              <BadgePercent className="h-4 w-4" />
              Special Offers
            </p>
            <h2 className="mt-2 text-3xl font-black tracking-tight text-white">
              Approved happy hours, free entry, and venue deals
            </h2>
          </div>
          <Link
            href="/offers"
            className="inline-flex min-h-11 items-center gap-2 rounded-full border border-pink-400/20 bg-pink-500/10 px-4 py-2 text-sm font-bold text-pink-100 transition hover:border-pink-300/50 hover:bg-pink-500/15"
          >
            <Sparkles className="h-4 w-4" />
            View all offers
          </Link>
        </div>

        {offerIntel.length > 0 ? (
          <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
            {offerIntel.slice(0, 6).map((intel, index) => (
              <OfferCard key={intel.id} intel={intel} index={index} />
            ))}
          </div>
        ) : (
          <div className="rounded-3xl border border-dashed border-zinc-800 bg-zinc-950/70 p-6">
            <div className="max-w-3xl">
              <h3 className="text-xl font-black text-white">No approved offers yet</h3>
              <p className="mt-2 text-sm leading-7 text-zinc-400">
                ThaiNight only shows deals after they are submitted, detected from allowed sources, or reviewed by an operator.
                Until then, use venue pages for area, vibe, and safety planning.
              </p>
              <Link
                href="/bangkok"
                className="mt-4 inline-flex rounded-full border border-pink-400/20 bg-pink-500/10 px-4 py-2 text-sm font-black text-pink-100 transition hover:border-pink-300/50"
              >
                Browse Bangkok venues
              </Link>
            </div>
          </div>
        )}
      </section>
    </>
  );
}
