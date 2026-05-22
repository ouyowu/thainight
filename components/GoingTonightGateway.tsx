import Link from "next/link";
import { ArrowRight, CalendarDays, MapPin, MessageCircle, ShieldAlert, Users } from "lucide-react";
import { CITY_CONFIGS } from "@/lib/cities";
import type { CitySlug } from "@/lib/cities";

type CityGoingStat = {
  city: CitySlug;
  label: string;
  href: string;
  focus: string;
  prompt: string;
  countLabel: string;
};

const CITY_FOCUS: Record<CitySlug, { focus: string; prompt: string }> = {
  bangkok: {
    focus: "Rooftops, clubs, cocktail bars, RCA, Thonglor",
    prompt: "Find Bangkok events, solo travelers, and late-night warnings.",
  },
  pattaya: {
    focus: "Walking Street, beach bars, live music, price checks",
    prompt: "See who is heading out in Pattaya and what to avoid tonight.",
  },
  phuket: {
    focus: "Bangla Road, beach clubs, Patong, sunset plans",
    prompt: "Track Phuket parties, tourist questions, and island nightlife tips.",
  },
  "chiang-mai": {
    focus: "Nimman, Old City, jazz bars, quieter social nights",
    prompt: "Find Chiang Mai plans for live music, craft beer, and meetups.",
  },
};

export function GoingTonightGateway() {
  const cityStats: CityGoingStat[] = CITY_CONFIGS.map((city) => ({
    city: city.slug,
    label: city.name,
    href: `${city.href}?intent=going-tonight`,
    focus: CITY_FOCUS[city.slug].focus,
    prompt: CITY_FOCUS[city.slug].prompt,
    countLabel: `${city.targetVenueCount}+ nightlife spots`,
  }));

  return (
    <section
      id="going-tonight"
      className="overflow-hidden rounded-[32px] border border-rose-300/20 bg-[linear-gradient(135deg,rgba(244,63,94,0.18),rgba(9,9,11,0.98)_44%,rgba(251,191,36,0.1))] p-5 sm:p-7 lg:p-8"
    >
      <div className="grid gap-7 lg:grid-cols-[0.85fr_1.15fr] lg:items-start">
        <div>
          <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-rose-300">
            <Users className="h-4 w-4" />
            Who&apos;s going out tonight?
          </p>
          <h2 className="mt-3 max-w-3xl text-3xl font-black tracking-tight text-white sm:text-4xl lg:text-5xl">
            Pick a city, find the night, and make a plan before you go.
          </h2>
          <p className="mt-4 max-w-2xl text-sm leading-7 text-zinc-300 sm:text-base">
            ThaiNight is built for travelers who want more than a list of bars: see tonight&apos;s events, people planning to go out, safety notes, price signals, and fresh openings in one place.
          </p>

          <div className="mt-6 grid gap-3 sm:grid-cols-3">
            <Link
              href="/profile"
              className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl bg-white px-4 text-sm font-black text-zinc-950 transition hover:bg-zinc-100"
            >
              <MessageCircle className="h-4 w-4" />
              Join tonight&apos;s nightlife chat
            </Link>
            <Link
              href="/events"
              className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl border border-white/15 bg-white/5 px-4 text-sm font-black text-white transition hover:border-white/30 hover:bg-white/10"
            >
              <CalendarDays className="h-4 w-4" />
              New events this week
            </Link>
            <Link
              href="/profile"
              className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl border border-rose-200/25 bg-rose-500/15 px-4 text-sm font-black text-rose-100 transition hover:border-rose-100/45 hover:bg-rose-500/20"
            >
              <ArrowRight className="h-4 w-4" />
              Post your plan
            </Link>
          </div>
        </div>

        <div className="grid gap-3 md:grid-cols-2">
          {cityStats.map((city) => (
            <Link
              key={city.city}
              href={city.href}
              className="group flex min-h-56 flex-col justify-between rounded-2xl border border-white/10 bg-black/25 p-5 transition hover:-translate-y-0.5 hover:border-rose-200/35 hover:bg-black/35"
            >
              <div>
                <div className="flex items-start justify-between gap-3">
                  <span className="inline-flex items-center gap-2 rounded-full border border-white/10 bg-white/5 px-3 py-1 text-xs font-bold text-zinc-200">
                    <MapPin className="h-3.5 w-3.5 text-rose-200" />
                    {city.label}
                  </span>
                  <span className="rounded-full bg-rose-500 px-2.5 py-1 text-[11px] font-black text-white">
                    Tonight
                  </span>
                </div>
                <h3 className="mt-5 text-2xl font-black tracking-tight text-white">{city.label}</h3>
                <p className="mt-2 text-sm font-semibold text-rose-100">{city.focus}</p>
                <p className="mt-3 text-sm leading-6 text-zinc-400">{city.prompt}</p>
              </div>

              <div className="mt-5 flex items-center justify-between border-t border-white/10 pt-4">
                <span className="inline-flex items-center gap-2 text-xs font-bold text-amber-200">
                  <ShieldAlert className="h-4 w-4" />
                  {city.countLabel}
                </span>
                <span className="inline-flex items-center gap-1 text-sm font-black text-white">
                  Open
                  <ArrowRight className="h-4 w-4 transition group-hover:translate-x-1" />
                </span>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </section>
  );
}
