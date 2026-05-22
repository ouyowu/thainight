"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { BrandLockup } from "@/components/BrandLockup";
import {
  Building2,
  Compass,
  MessageCircle,
  Martini,
  MapPin,
  Send,
  Newspaper,
  Music2,
  Search,
  Sparkles,
  Users,
  Wine,
} from "lucide-react";

const QUICK_LINKS = [
  {
    label: "Near me",
    icon: MapPin,
    query: "near-me",
    iconClassName: "bg-rose-400/15 text-rose-200 ring-rose-300/20",
  },
  {
    label: "Nightclubs",
    icon: Sparkles,
    query: "nightclubs",
    iconClassName: "bg-fuchsia-400/15 text-fuchsia-200 ring-fuchsia-300/20",
  },
  {
    label: "Rooftop Bars",
    icon: Building2,
    query: "rooftop bars",
    iconClassName: "bg-cyan-400/15 text-cyan-200 ring-cyan-300/20",
  },
  {
    label: "Happy Hour",
    icon: Wine,
    query: "happy hour",
    iconClassName: "bg-amber-400/15 text-amber-200 ring-amber-300/20",
  },
  {
    label: "Cocktail Bars",
    icon: Martini,
    query: "cocktail bars",
    iconClassName: "bg-emerald-400/15 text-emerald-200 ring-emerald-300/20",
  },
  {
    label: "Live Music",
    icon: Music2,
    query: "live music bars",
    iconClassName: "bg-violet-400/15 text-violet-200 ring-violet-300/20",
  },
  {
    label: "Solo Travelers",
    icon: Compass,
    query: "solo traveler meetup",
    iconClassName: "bg-sky-400/15 text-sky-200 ring-sky-300/20",
  },
];

const PRIMARY_ROUTES = [
  {
    label: "Tonight",
    href: "/tonight",
    description: "Events and people going out",
    icon: Users,
  },
  {
    label: "Intel",
    href: "/intel",
    description: "Openings, warnings, price tips",
    icon: Newspaper,
  },
  {
    label: "News",
    href: "/news",
    description: "Fresh nightlife updates",
    icon: Newspaper,
  },
  {
    label: "Explore",
    href: "/explore",
    description: "Cities and popular routes",
    icon: Compass,
  },
];

export function HomeSearchHero({
  signedIn = false,
  lastUpdated,
}: {
  signedIn?: boolean;
  lastUpdated?: string;
}) {
  const router = useRouter();
  const [query, setQuery] = useState("");
  const [locating, setLocating] = useState(false);

  function submitSearch(value = query) {
    const trimmed = value.trim();
    router.push(trimmed ? `/bangkok?search=${encodeURIComponent(trimmed)}` : "/bangkok");
  }

  function handleNearMe() {
    setLocating(true);
    if (!navigator.geolocation) {
      router.push("/bangkok?near=me");
      setLocating(false);
      return;
    }

    navigator.geolocation.getCurrentPosition(
      ({ coords }) => {
        router.push(`/bangkok?near=me&lat=${coords.latitude}&lng=${coords.longitude}`);
        setLocating(false);
      },
      () => {
        router.push("/bangkok?near=me");
        setLocating(false);
      },
      { enableHighAccuracy: false, timeout: 8000 }
    );
  }

  return (
    <section className="rounded-[28px] border border-zinc-800 bg-zinc-950 px-4 py-5 sm:px-6 sm:py-6 lg:px-8">
      <div className="mx-auto flex max-w-7xl flex-col gap-7">
        <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
          <BrandLockup size="lg" href="/" />
          <div className="flex flex-wrap items-center gap-2">
            {signedIn ? (
              <>
                <button type="button" onClick={() => router.push("/profile")} className="rounded-full border border-zinc-800 bg-zinc-900 px-3 py-2 text-xs font-bold text-zinc-200 hover:border-zinc-600">
                  Profile
                </button>
                <button type="button" onClick={() => router.push("/verify")} className="rounded-full border border-zinc-800 bg-zinc-900 px-3 py-2 text-xs font-bold text-zinc-200 hover:border-zinc-600">
                  Verify
                </button>
              </>
            ) : null}
          </div>
        </div>

        <div className="grid gap-6 lg:grid-cols-[0.9fr_1.1fr] lg:items-center">
          <div className="max-w-3xl text-left">
            <div className="flex flex-wrap items-center gap-2">
              <p className="rounded-full border border-rose-300/20 bg-rose-500/10 px-3 py-1.5 text-xs font-bold uppercase tracking-widest text-rose-200">
                Thailand nightlife guide 2026
              </p>
              {lastUpdated ? (
                <p className="rounded-full border border-emerald-300/20 bg-emerald-500/10 px-3 py-1.5 text-xs font-bold uppercase tracking-widest text-emerald-200">
                  Updated {lastUpdated}
                </p>
              ) : null}
            </div>
            <h1 className="mt-3 max-w-4xl text-balance text-3xl font-black tracking-tight text-white sm:text-4xl lg:text-5xl">
              Find Thailand nightlife events, fresh openings, price tips, and people going out tonight.
            </h1>
            <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-400 sm:text-base">
              ThaiNight helps travelers quickly see where to go tonight, what is new, what prices or fees to check, and which nightlife areas feel active in Bangkok, Pattaya, Phuket, and Chiang Mai.
            </p>
            <div className="mt-5 grid gap-2 sm:grid-cols-3">
              <a
                href="/tonight#people"
                className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl bg-rose-500 px-4 text-sm font-black text-white transition hover:bg-rose-400"
              >
                <MessageCircle className="h-4 w-4" />
                Join tonight&apos;s nightlife chat
              </a>
              <a
                href="/tonight"
                className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl border border-rose-300/25 bg-rose-500/10 px-4 text-sm font-black text-rose-100 transition hover:border-rose-200/50 hover:bg-rose-500/15"
              >
                <Users className="h-4 w-4" />
                See who is going out tonight
              </a>
              <button
                type="button"
                onClick={() => router.push("/profile")}
                className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl border border-zinc-700 bg-zinc-900 px-4 text-sm font-black text-zinc-100 transition hover:border-zinc-500 hover:bg-zinc-800"
              >
                <Send className="h-4 w-4" />
                Post your plan
              </button>
            </div>
            <div className="mt-5 flex flex-wrap gap-2">
              {[
                "Tonight in Bangkok",
                "Solo travelers looking to go out",
                "Warnings today",
                "New events this week",
              ].map((item) => (
                <span key={item} className="rounded-full border border-rose-300/20 bg-rose-500/10 px-3 py-1.5 text-xs font-bold text-rose-100">
                  {item}
                </span>
              ))}
            </div>
            <nav aria-label="Primary ThaiNight routes" className="mt-4 flex flex-wrap gap-2">
              {PRIMARY_ROUTES.map(({ label, href, description, icon: Icon }) => (
                <a
                  key={href}
                  href={href}
                  className="group inline-flex min-h-11 items-center gap-2 rounded-full border border-zinc-800 bg-zinc-900/70 px-3 py-2 text-left transition hover:border-rose-300/40 hover:bg-rose-500/10"
                >
                  <Icon className="h-4 w-4 shrink-0 text-rose-200" />
                  <span>
                    <span className="block text-xs font-black text-white">{label}</span>
                    <span className="hidden text-[11px] font-semibold text-zinc-500 group-hover:text-zinc-400 sm:block">
                      {description}
                    </span>
                  </span>
                </a>
              ))}
            </nav>
          </div>

          <div className="w-full rounded-[24px] border border-zinc-800 bg-zinc-900/70 p-3 sm:p-4">
            <form
              className="flex flex-col gap-3 rounded-[20px] border border-zinc-800 bg-zinc-950 p-2 sm:flex-row"
              onSubmit={(event) => {
                event.preventDefault();
                submitSearch();
              }}
            >
              <div className="relative flex-1">
                <Search className="pointer-events-none absolute left-4 top-1/2 h-5 w-5 -translate-y-1/2 text-zinc-500" />
                <input
                  value={query}
                  onChange={(event) => setQuery(event.target.value)}
                  placeholder="Search Bangkok nightlife, rooftop bars, nightclubs, happy hour..."
                  className="h-14 w-full rounded-2xl border border-zinc-800 bg-zinc-950 pl-12 pr-4 text-sm text-white outline-none placeholder:text-zinc-500 focus:border-rose-400/70 sm:text-base"
                />
              </div>
              <button
                type="submit"
                className="inline-flex h-14 items-center justify-center gap-2 rounded-2xl bg-rose-500 px-6 text-sm font-bold text-white transition hover:bg-rose-400 sm:w-16"
              >
                <Search className="h-5 w-5" />
              </button>
            </form>

            <div className="mt-3 grid gap-2 sm:grid-cols-2 xl:grid-cols-3">
              {QUICK_LINKS.map(({ label, icon: Icon, query: shortcut, iconClassName }) => (
                <button
                  key={label}
                  type="button"
                  onClick={() => {
                    if (label === "Near me") {
                      handleNearMe();
                      return;
                    }
                    submitSearch(shortcut);
                  }}
                  className="inline-flex min-h-11 items-center gap-2 rounded-2xl border border-zinc-800 bg-zinc-950 px-3 py-2 text-sm font-semibold text-zinc-100 transition hover:border-zinc-600 hover:bg-zinc-900"
                >
                  <span className={`inline-flex h-8 w-8 items-center justify-center rounded-full ring-1 ${iconClassName}`}>
                    <Icon className="h-4 w-4" />
                  </span>
                  <span>{locating && label === "Near me" ? "Locating..." : label}</span>
                </button>
              ))}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
