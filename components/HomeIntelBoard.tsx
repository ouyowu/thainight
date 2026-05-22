"use client";

import { useMemo, useState } from "react";
import { ArrowRight, MapPin, ShieldAlert, Sparkles, WalletCards } from "lucide-react";
import type { IntelligenceFeedRow } from "@/lib/database.types";
import { CITY_CONFIGS, type CitySlug } from "@/lib/cities";

type Props = {
  openings: IntelligenceFeedRow[];
  warnings: IntelligenceFeedRow[];
  priceTips: IntelligenceFeedRow[];
};

type IntelTab = "openings" | "warnings" | "price";
type CityFilter = "all" | CitySlug;

const TABS: Array<{
  id: IntelTab;
  label: string;
  eyebrow: string;
  icon: typeof Sparkles;
  tone: string;
}> = [
  {
    id: "openings",
    label: "Openings",
    eyebrow: "New bars / menus / venues",
    icon: Sparkles,
    tone: "text-cyan-200 border-cyan-300/20 bg-cyan-500/10",
  },
  {
    id: "warnings",
    label: "Warnings",
    eyebrow: "Safety and avoid signals",
    icon: ShieldAlert,
    tone: "text-red-200 border-red-300/20 bg-red-500/10",
  },
  {
    id: "price",
    label: "Price Tips",
    eyebrow: "Fees, tickets, cover charge",
    icon: WalletCards,
    tone: "text-amber-200 border-amber-300/20 bg-amber-500/10",
  },
];

const CITY_FILTERS: Array<{ id: CityFilter; label: string }> = [
  { id: "all", label: "All cities" },
  ...CITY_CONFIGS.map((city) => ({ id: city.slug, label: city.name })),
];

function cityLabel(city?: string | null): string {
  return CITY_CONFIGS.find((item) => item.slug === city)?.name ?? city?.replace(/-/g, " ") ?? "Thailand";
}

function shortSource(url: string): string {
  try {
    return new URL(url).hostname.replace(/^www\./, "");
  } catch {
    return "Source";
  }
}

function IntelCard({ item, tab }: { item: IntelligenceFeedRow; tab: IntelTab }) {
  const meta = TABS.find((candidate) => candidate.id === tab) ?? TABS[0];
  const Icon = meta.icon;

  return (
    <a
      href={item.url}
      target="_blank"
      rel="noreferrer"
      className="group flex min-h-48 flex-col justify-between rounded-3xl border border-zinc-800 bg-zinc-950/90 p-5 transition hover:-translate-y-0.5 hover:border-white/20"
    >
      <div>
        <div className="flex items-start justify-between gap-3">
          <span className={`inline-flex items-center gap-2 rounded-full border px-3 py-1 text-[11px] font-black uppercase tracking-wider ${meta.tone}`}>
            <Icon className="h-3.5 w-3.5" />
            {meta.label}
          </span>
          <span className="inline-flex items-center gap-1 text-[11px] font-bold uppercase tracking-widest text-zinc-500">
            <MapPin className="h-3.5 w-3.5" />
            {cityLabel(item.city)}
          </span>
        </div>

        <h3 className="mt-4 line-clamp-3 text-xl font-black leading-7 text-white">
          {item.title}
        </h3>
        <p className="mt-3 line-clamp-2 text-sm leading-6 text-zinc-500">
          {item.body_snippet ?? shortSource(item.url)}
        </p>
      </div>

      <div className="mt-5 flex items-center justify-between border-t border-white/10 pt-4">
        <span className="text-xs font-semibold text-zinc-600">{shortSource(item.url)}</span>
        <span className="inline-flex items-center gap-2 text-sm font-black text-white">
          Open
          <ArrowRight className="h-4 w-4 transition group-hover:translate-x-1" />
        </span>
      </div>
    </a>
  );
}

export function HomeIntelBoard({ openings, warnings, priceTips }: Props) {
  const [tab, setTab] = useState<IntelTab>("openings");
  const [city, setCity] = useState<CityFilter>("all");

  const items = useMemo(() => {
    const itemsByTab = {
      openings,
      warnings,
      price: priceTips,
    };
    const base = itemsByTab[tab];
    return city === "all" ? base : base.filter((item) => item.city === city);
  }, [city, openings, priceTips, tab, warnings]);

  return (
    <section className="space-y-5 rounded-[1.75rem] border border-zinc-800 bg-zinc-950/70 p-4 sm:p-6">
      <div className="flex flex-col gap-3 lg:flex-row lg:items-end lg:justify-between">
        <div>
          <p className="text-xs font-black uppercase tracking-[0.24em] text-cyan-200">
            Fresh intel
          </p>
          <h2 className="mt-2 text-3xl font-black tracking-tight text-white">
            Openings, warnings, and price tips by city
          </h2>
          <p className="mt-2 max-w-2xl text-sm leading-6 text-zinc-500">
            Approved signals are rewritten into short public titles before they appear here.
          </p>
        </div>
      </div>

      <div className="flex flex-col gap-3 lg:flex-row lg:items-center lg:justify-between">
        <div className="grid grid-cols-3 gap-2 rounded-2xl border border-zinc-800 bg-black/25 p-1">
          {TABS.map((item) => {
            const Icon = item.icon;
            const active = tab === item.id;
            return (
              <button
                key={item.id}
                type="button"
                onClick={() => setTab(item.id)}
                className={`rounded-xl px-3 py-2 text-left transition ${
                  active ? item.tone : "text-zinc-500 hover:bg-zinc-900 hover:text-zinc-200"
                }`}
              >
                <span className="flex items-center gap-2 text-xs font-black uppercase tracking-wider">
                  <Icon className="h-4 w-4" />
                  {item.label}
                </span>
                <span className="mt-1 hidden text-[11px] leading-4 opacity-70 sm:block">{item.eyebrow}</span>
              </button>
            );
          })}
        </div>

        <div className="flex gap-2 overflow-x-auto pb-1">
          {CITY_FILTERS.map((item) => (
            <button
              key={item.id}
              type="button"
              onClick={() => setCity(item.id)}
              className={`shrink-0 rounded-full border px-3 py-2 text-xs font-black transition ${
                city === item.id
                  ? "border-white/25 bg-white text-zinc-950"
                  : "border-zinc-800 bg-zinc-900/70 text-zinc-400 hover:border-zinc-600 hover:text-white"
              }`}
            >
              {item.label}
            </button>
          ))}
        </div>
      </div>

      {items.length ? (
        <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
          {items.slice(0, 6).map((item) => (
            <IntelCard key={item.id} item={item} tab={tab} />
          ))}
        </div>
      ) : (
        <div className="rounded-3xl border border-dashed border-zinc-800 bg-black/20 p-6">
          <h3 className="text-xl font-black text-white">No approved items for this city yet</h3>
          <p className="mt-2 text-sm leading-6 text-zinc-500">
            Pick another city or approve more ThaiNight signals from the admin queue.
          </p>
        </div>
      )}
    </section>
  );
}
