"use client";

// components/CityVenueWall.tsx
// Shared venue card grid for all 4 city pages
// Filters: category, area, price. Sort: freshness/score/foreigner/price/music
// Pagination: 20 per page, client-side

import { useEffect, useState, useMemo, useCallback, type ElementType } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { BrandLockup } from "@/components/BrandLockup";
import { canRenderPublicImage } from "@/lib/media";
import {
  SlidersHorizontal, Search, Grid3X3, List, MapPin,
  ChevronDown, Send, X, Star, Moon, DollarSign,
  Users, Music, Shield, ArrowRight, ArrowLeft,
} from "lucide-react";

// ─── Types ────────────────────────────────────────────────────────────────────

type SortKey  = "freshness" | "score" | "foreigner" | "price" | "music";
type ViewMode = "grid" | "list";

interface Filters {
  category:     string;
  area:         string;
  priceRange:   string;
  verifiedOnly: boolean;
  search:       string;
}

// Use a loose type so it works with whatever Supabase returns
type Venue = Record<string, unknown> & {
  id: string;
  slug: string;
  name: string;
  city: string;
  area_slug: string;
  area_name?: string | null;
  category: string;
  category_name?: string | null;
  tagline?: string | null;
  hero_image_url?: string | null;
  price_range?: string | null;
  opening_hours?: string | null;
  tags?: string[];
  overall_score?: number | null;
  display_score?: number | null;
  score_foreigner_friendly?: number | null;
  score_late_night_reliability?: number | null;
  score_price_transparency?: number | null;
  score_tourist_trap_risk?: number | null;
  score_music_quality?: number | null;
  score_date_night?: number | null;
  last_verified_at?: string | null;
  temporarily_closed?: boolean | null;
  is_verified_this_week?: boolean | null;
};

// ─── Constants ────────────────────────────────────────────────────────────────

const CATEGORIES = [
  { slug: "all",            label: "All Venues",    emoji: "🌃" },
  { slug: "cocktail-bar",   label: "Cocktail Bars", emoji: "🍸" },
  { slug: "nightclub",      label: "Nightclubs",    emoji: "🎧" },
  { slug: "jazz-bar",       label: "Live Music",    emoji: "🎸" },
  { slug: "dive-bar",       label: "Pubs & Bars",   emoji: "🍺" },
  { slug: "rooftop-bar",    label: "Rooftops",      emoji: "🌆" },
];

const SORT_OPTIONS: { key: SortKey; label: string }[] = [
  { key: "freshness", label: "Recently Verified" },
  { key: "score",     label: "Top Rated" },
  { key: "foreigner", label: "Foreigner Friendly" },
  { key: "price",     label: "Price Transparency" },
  { key: "music",     label: "Best Music" },
];

const PAGE_SIZE = 20;

const CITY_ACCENT: Record<string, string> = {
  bangkok:      "bg-amber-500 text-zinc-950",
  pattaya:      "bg-cyan-500  text-zinc-950",
  phuket:       "bg-violet-500 text-white",
  "chiang-mai": "bg-rose-500  text-white",
};

const CITY_TEXT: Record<string, string> = {
  bangkok:      "text-amber-400",
  pattaya:      "text-cyan-400",
  phuket:       "text-violet-400",
  "chiang-mai": "text-rose-400",
};

// ─── Helpers ─────────────────────────────────────────────────────────────────

function isVerified(date?: string | null): boolean {
  if (!date) return false;
  return Date.now() - new Date(date).getTime() < 7 * 24 * 60 * 60 * 1000;
}

function scoreColor(s?: number | null): string {
  if (!s) return "bg-zinc-700";
  return s >= 8 ? "bg-emerald-500" : s >= 6 ? "bg-amber-500" : "bg-red-500";
}

function scoreText(s?: number | null): string {
  if (!s) return "text-zinc-500";
  return s >= 8 ? "text-emerald-400" : s >= 6 ? "text-amber-400" : "text-red-400";
}

function canRenderVenueImage(url?: string | null): boolean {
  return canRenderPublicImage(url);
}

// ─── Mini score bar ───────────────────────────────────────────────────────────

function ScoreBar({ value, icon: Icon }: { value?: number | null; icon: ElementType }) {
  return (
    <div className="flex items-center gap-2">
      <Icon className="w-3 h-3 text-zinc-400 shrink-0" />
      <div className="flex-1 h-1 bg-white/10 rounded-full overflow-hidden">
        <div className={`h-full rounded-full ${scoreColor(value)}`} style={{ width: `${((value ?? 0) / 10) * 100}%` }} />
      </div>
      <span className="text-[10px] font-mono font-bold text-white w-6 text-right">
        {value?.toFixed(1) ?? "—"}
      </span>
    </div>
  );
}

// ─── Venue card (grid) ────────────────────────────────────────────────────────

function VenueCard({ venue, rank, city }: { venue: Venue; rank: number; city: string }) {
  const verified = venue.is_verified_this_week ?? isVerified(venue.last_verified_at);
  const score    = venue.display_score ?? venue.overall_score;
  const trapSafe = venue.score_tourist_trap_risk != null ? 10 - venue.score_tourist_trap_risk : undefined;

  const gradients: Record<string, string> = {
    "cocktail-bar":   "from-violet-950 via-zinc-900 to-zinc-950",
    "nightclub":      "from-zinc-950 via-indigo-950 to-zinc-950",
    "jazz-bar":       "from-zinc-950 via-rose-950 to-zinc-950",
    "dive-bar":       "from-amber-950 via-zinc-900 to-zinc-950",
    "rooftop-bar":    "from-zinc-950 via-sky-950 to-zinc-950",
  };

  const catEmoji = CATEGORIES.find(c => c.slug === venue.category)?.emoji ?? "🌃";
  const catLabel = venue.category_name ?? venue.category.replace(/-/g, " ");
  const showImage = canRenderVenueImage(venue.hero_image_url);

  return (
    <Link
      href={`/${city}/bars/${venue.area_slug}/${venue.slug}`}
      className="group relative block rounded-2xl overflow-hidden aspect-[3/4]"
    >
      {showImage ? (
        <div
          className="absolute inset-0 bg-cover bg-center transition-transform duration-700 group-hover:scale-105"
          style={{ backgroundImage: `url(${venue.hero_image_url})` }}
        />
      ) : (
        <div className={`absolute inset-0 bg-gradient-to-br ${gradients[venue.category] ?? "from-zinc-900 to-zinc-950"}`} />
      )}
      <div className="absolute inset-0 bg-gradient-to-t from-black/90 via-black/25 to-black/10" />

      {/* Rank */}
      <div className="absolute top-3 left-3 w-7 h-7 rounded-full bg-black/50 backdrop-blur-sm border border-white/10 flex items-center justify-center text-[10px] font-black font-mono text-zinc-300">
        {rank}
      </div>

      {/* Top right: verified + score */}
      <div className="absolute top-3 right-3 flex items-center gap-2">
        {verified && (
          <span className="relative flex h-2.5 w-2.5">
            <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75" />
            <span className="relative inline-flex rounded-full h-2.5 w-2.5 bg-emerald-500" />
          </span>
        )}
        {score != null && (
          <div className="w-10 h-10 rounded-xl bg-black/60 backdrop-blur-sm border border-white/10 flex items-center justify-center">
            <span className={`text-base font-black font-mono leading-none ${scoreText(score)}`}>
              {score.toFixed(1)}
            </span>
          </div>
        )}
      </div>

      {/* Bottom content */}
      <div className="absolute bottom-0 left-0 right-0 p-4">
        <div className="mb-2">
          <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full bg-white/10 backdrop-blur-sm border border-white/10 text-[10px] text-zinc-300 font-medium capitalize">
            {catEmoji} {catLabel}
          </span>
        </div>
        <h3 className="text-white font-black text-lg leading-tight mb-0.5 group-hover:text-amber-300 transition-colors">
          {venue.name}
        </h3>
        <div className="flex items-center gap-3 mb-3">
          <span className="flex items-center gap-1 text-xs text-zinc-400">
            <MapPin className="w-3 h-3" />
            {venue.area_name ?? venue.area_slug}
          </span>
          {venue.price_range && (
            <span className="text-xs text-emerald-400 font-mono font-bold">{venue.price_range}</span>
          )}
        </div>
        <div className="space-y-1.5">
          <ScoreBar value={venue.score_foreigner_friendly}     icon={Users} />
          <ScoreBar value={venue.score_price_transparency}     icon={DollarSign} />
          <ScoreBar value={venue.score_late_night_reliability} icon={Moon} />
        </div>
      </div>

      {/* Hover reveal */}
      <div className="absolute inset-0 flex flex-col justify-end p-4 opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
        <div className="bg-black/75 backdrop-blur-md rounded-xl p-3 border border-white/10 mt-auto">
          {venue.tagline && (
            <p className="text-xs text-zinc-300 leading-relaxed mb-3 line-clamp-2">{venue.tagline}</p>
          )}
          <div className="space-y-1.5">
            {venue.score_music_quality != null && <ScoreBar value={venue.score_music_quality} icon={Music} />}
            {trapSafe != null && <ScoreBar value={trapSafe} icon={Shield} />}
            {venue.score_date_night != null && <ScoreBar value={venue.score_date_night} icon={Star} />}
          </div>
          {(venue.tags ?? []).length > 0 && (
            <div className="flex flex-wrap gap-1 mt-2">
              {(venue.tags ?? []).slice(0, 3).map(t => (
                <span key={t} className="text-[9px] px-1.5 py-0.5 bg-white/10 rounded-full text-zinc-400">{t}</span>
              ))}
            </div>
          )}
        </div>
      </div>

      {venue.temporarily_closed && (
        <div className="absolute inset-0 bg-black/60 flex items-center justify-center">
          <span className="px-3 py-1.5 bg-red-500/20 border border-red-500/40 rounded-full text-red-400 text-xs font-bold">
            Temporarily Closed
          </span>
        </div>
      )}
    </Link>
  );
}

// ─── List row ─────────────────────────────────────────────────────────────────

function VenueListRow({ venue, rank, city }: { venue: Venue; rank: number; city: string }) {
  const verified = venue.is_verified_this_week ?? isVerified(venue.last_verified_at);
  const score    = venue.display_score ?? venue.overall_score;
  const showImage = canRenderVenueImage(venue.hero_image_url);
  return (
    <Link
      href={`/${city}/bars/${venue.area_slug}/${venue.slug}`}
      className="group flex items-center gap-4 p-4 rounded-xl bg-zinc-900/60 border border-zinc-800/60 hover:border-zinc-700 hover:bg-zinc-900/80 transition-all"
    >
      <span className="text-xs font-mono text-zinc-600 w-5 shrink-0">{rank}</span>
      <div className="w-12 h-12 rounded-lg shrink-0 bg-zinc-800 overflow-hidden">
        {showImage && (
          <div className="w-full h-full bg-cover bg-center" style={{ backgroundImage: `url(${venue.hero_image_url})` }} />
        )}
      </div>
      <div className="flex-1 min-w-0">
        <div className="flex items-center gap-2 mb-0.5">
          <h3 className="font-bold text-white text-sm truncate group-hover:text-amber-300 transition-colors">{venue.name}</h3>
          {verified && (
            <span className="relative flex h-2 w-2 shrink-0">
              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75" />
              <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500" />
            </span>
          )}
        </div>
        <div className="flex items-center gap-2 text-xs text-zinc-500">
          <span>{venue.area_name ?? venue.area_slug}</span>
          <span>·</span>
          <span className="capitalize">{venue.category.replace(/-/g, " ")}</span>
          {venue.price_range && <><span>·</span><span className="text-emerald-400 font-mono">{venue.price_range}</span></>}
        </div>
      </div>
      <div className="hidden md:flex flex-col gap-1 w-28">
        <ScoreBar value={venue.score_foreigner_friendly}     icon={Users} />
        <ScoreBar value={venue.score_price_transparency}     icon={DollarSign} />
        <ScoreBar value={venue.score_late_night_reliability} icon={Moon} />
      </div>
      <div className={`shrink-0 text-xl font-black font-mono ${scoreText(score)}`}>
        {score?.toFixed(1) ?? "—"}
      </div>
    </Link>
  );
}

// ─── Pagination ───────────────────────────────────────────────────────────────

function Pagination({ page, total, perPage, onPage }: {
  page: number; total: number; perPage: number; onPage: (p: number) => void;
}) {
  const totalPages = Math.ceil(total / perPage);
  if (totalPages <= 1) return null;
  return (
    <div className="flex items-center justify-center gap-3 mt-10">
      <button onClick={() => onPage(page - 1)} disabled={page === 1}
        className="flex items-center gap-1.5 px-4 py-2 rounded-xl bg-zinc-800/60 border border-zinc-700/50 text-sm text-zinc-400 hover:text-white disabled:opacity-30 transition-colors">
        <ArrowLeft className="w-3.5 h-3.5" /> Prev
      </button>
      <div className="flex items-center gap-1">
        {Array.from({ length: totalPages }, (_, i) => i + 1).map(p => (
          <button key={p} onClick={() => onPage(p)}
            className={`w-9 h-9 rounded-lg text-sm font-mono transition-colors ${p === page ? "bg-amber-500 text-zinc-950 font-bold" : "bg-zinc-800/60 border border-zinc-700/50 text-zinc-400 hover:text-white"}`}>
            {p}
          </button>
        ))}
      </div>
      <button onClick={() => onPage(page + 1)} disabled={page === Math.ceil(total / perPage)}
        className="flex items-center gap-1.5 px-4 py-2 rounded-xl bg-zinc-800/60 border border-zinc-700/50 text-sm text-zinc-400 hover:text-white disabled:opacity-30 transition-colors">
        Next <ArrowRight className="w-3.5 h-3.5" />
      </button>
    </div>
  );
}

// ─── Main export ──────────────────────────────────────────────────────────────

interface CityVenueWallProps {
  venues:     Venue[];
  city:       string;
  cityName:   string;
  areas:      string[];
  areaLabels: Record<string, string>;
}

export default function CityVenueWall({ venues, city, cityName, areas, areaLabels }: CityVenueWallProps) {
  const router = useRouter();
  const accentBtn  = CITY_ACCENT[city] ?? CITY_ACCENT.bangkok;
  const accentText = CITY_TEXT[city]   ?? "text-amber-400";

  const [filters, setFilters] = useState<Filters>({
    category: "all",
    area: "all",
    priceRange: "all",
    verifiedOnly: false,
    search: "",
  });
  const [sortKey,     setSortKey]     = useState<SortKey>("freshness");
  const [viewMode,    setViewMode]    = useState<ViewMode>("grid");
  const [showFilters, setShowFilters] = useState(false);
  const [page,        setPage]        = useState(1);

  const setFilter = useCallback(<K extends keyof Filters>(k: K, v: Filters[K]) => {
    setFilters(p => ({ ...p, [k]: v }));
    setPage(1);
  }, []);

  const clearFilters = useCallback(() => {
    setFilters({ category: "all", area: "all", priceRange: "all", verifiedOnly: false, search: "" });
    setPage(1);
  }, []);

  useEffect(() => {
    const initialSearch = new URLSearchParams(window.location.search).get("search");
    if (!initialSearch) return;
    setFilters((current) => ({ ...current, search: initialSearch }));
    setPage(1);
  }, []);

  const filtered = useMemo(() => {
    let r = [...venues];
    if (filters.category  !== "all") r = r.filter(v => v.category  === filters.category);
    if (filters.area      !== "all") r = r.filter(v => v.area_slug  === filters.area);
    if (filters.priceRange !== "all") r = r.filter(v => v.price_range === filters.priceRange);
    if (filters.verifiedOnly) r = r.filter(v => v.is_verified_this_week ?? isVerified(v.last_verified_at));
    if (filters.search.trim()) {
      const q = filters.search.toLowerCase();
      r = r.filter(v =>
        v.name.toLowerCase().includes(q) ||
        v.area_slug.includes(q) ||
        (v.tags ?? []).some((t: string) => t.includes(q))
      );
    }
    r.sort((a, b) => {
      switch (sortKey) {
        case "freshness": return new Date(b.last_verified_at ?? 0).getTime() - new Date(a.last_verified_at ?? 0).getTime();
        case "score":     return (b.display_score ?? b.overall_score ?? 0) - (a.display_score ?? a.overall_score ?? 0);
        case "foreigner": return (b.score_foreigner_friendly ?? 0) - (a.score_foreigner_friendly ?? 0);
        case "price":     return (b.score_price_transparency ?? 0) - (a.score_price_transparency ?? 0);
        case "music":     return (b.score_music_quality ?? 0) - (a.score_music_quality ?? 0);
        default:          return 0;
      }
    });
    return r;
  }, [venues, filters, sortKey]);

  const paged         = filtered.slice((page - 1) * PAGE_SIZE, page * PAGE_SIZE);
  const verifiedCount = filtered.filter(v => v.is_verified_this_week ?? isVerified(v.last_verified_at)).length;
  const hasFilters    = filters.category !== "all" || filters.area !== "all" || filters.priceRange !== "all" || filters.verifiedOnly || !!filters.search;

  return (
    <div className="bg-zinc-950 text-white">

      {/* ── Sticky nav ── */}
      <header className="sticky top-0 z-40 border-b border-zinc-800/60 bg-zinc-950/90 backdrop-blur-md">
        <div className="max-w-7xl mx-auto px-4 min-h-16 py-2 flex items-center gap-3">

          <button onClick={() => router.push("/")}
            className="hidden shrink-0 items-center gap-1 text-xs text-zinc-500 transition-colors hover:text-white sm:flex">
            <ArrowLeft className="w-3.5 h-3.5" /> All Cities
          </button>
          <BrandLockup size="sm" href="/" showTagline={false} className="border-zinc-800 bg-zinc-950/70" />
          <span className={`hidden text-sm font-bold ${accentText} md:inline`}>{cityName}</span>

          <div className="flex-1 relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-zinc-500" />
            <input
              type="text"
              placeholder={`Search ${cityName} venues...`}
              value={filters.search}
              onChange={e => setFilter("search", e.target.value)}
              className="w-full h-9 pl-9 pr-4 rounded-xl bg-zinc-800/60 border border-zinc-700/50 text-sm text-white placeholder:text-zinc-500 focus:outline-none focus:border-amber-500/50"
            />
          </div>

          <div className="relative shrink-0 hidden md:block">
            <select value={sortKey} onChange={e => setSortKey(e.target.value as SortKey)}
              className="h-9 pl-3 pr-8 rounded-xl bg-zinc-800/60 border border-zinc-700/50 text-sm text-white appearance-none focus:outline-none cursor-pointer">
              {SORT_OPTIONS.map(o => <option key={o.key} value={o.key}>{o.label}</option>)}
            </select>
            <ChevronDown className="absolute right-2 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-zinc-400 pointer-events-none" />
          </div>

          <div className="flex items-center gap-1 bg-zinc-800/60 border border-zinc-700/50 rounded-xl p-1">
            <button onClick={() => setViewMode("grid")}
              className={`p-1.5 rounded-lg transition-colors ${viewMode === "grid" ? "bg-zinc-700 text-white" : "text-zinc-500 hover:text-zinc-300"}`}>
              <Grid3X3 className="w-3.5 h-3.5" />
            </button>
            <button onClick={() => setViewMode("list")}
              className={`p-1.5 rounded-lg transition-colors ${viewMode === "list" ? "bg-zinc-700 text-white" : "text-zinc-500 hover:text-zinc-300"}`}>
              <List className="w-3.5 h-3.5" />
            </button>
          </div>

          <button onClick={() => setShowFilters(p => !p)}
            className={`shrink-0 flex items-center gap-1.5 h-9 px-3 rounded-xl border text-sm font-medium transition-colors ${
              hasFilters ? `${accentBtn} border-transparent` : "bg-zinc-800/60 border-zinc-700/50 text-zinc-300 hover:border-zinc-500"
            }`}>
            <SlidersHorizontal className="w-3.5 h-3.5" />
            <span className="hidden sm:block">Filters</span>
          </button>
        </div>

        {/* Category tabs */}
        <div className="max-w-7xl mx-auto px-4 pb-3 flex items-center gap-2 overflow-x-auto">
          {CATEGORIES.map(cat => (
            <button key={cat.slug} onClick={() => setFilter("category", cat.slug)}
              className={`shrink-0 flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-semibold border transition-all ${
                filters.category === cat.slug
                  ? `${accentBtn} border-transparent`
                  : "bg-zinc-800/60 border-zinc-700/40 text-zinc-400 hover:text-white hover:border-zinc-500"
              }`}>
              <span>{cat.emoji}</span>{cat.label}
            </button>
          ))}
        </div>

        {/* Filter panel */}
        {showFilters && (
          <div className="max-w-7xl mx-auto px-4 pb-4 border-t border-zinc-800/60 pt-4">
            <div className="flex flex-wrap gap-4 items-center">
              <div>
                <p className="text-[10px] text-zinc-500 uppercase tracking-widest mb-1.5 font-semibold">Area</p>
                <div className="flex flex-wrap gap-1.5">
                  {[{ slug: "all", label: "All Areas" }, ...areas.map(a => ({ slug: a, label: areaLabels[a] ?? a }))].map(a => (
                    <button key={a.slug} onClick={() => setFilter("area", a.slug)}
                      className={`px-2.5 py-1 rounded-full text-xs border transition-colors ${
                        filters.area === a.slug ? "bg-zinc-200 text-zinc-950 border-zinc-200" : "bg-zinc-800/60 text-zinc-400 border-zinc-700/40 hover:text-white"
                      }`}>
                      {a.label}
                    </button>
                  ))}
                </div>
              </div>
              <div>
                <p className="text-[10px] text-zinc-500 uppercase tracking-widest mb-1.5 font-semibold">Price</p>
                <div className="flex gap-1.5">
                  {["all","฿","฿฿","฿฿฿","฿฿฿฿"].map(p => (
                    <button key={p} onClick={() => setFilter("priceRange", p)}
                      className={`px-2.5 py-1 rounded-full text-xs font-mono border transition-colors ${
                        filters.priceRange === p ? "bg-emerald-500 text-zinc-950 border-emerald-500" : "bg-zinc-800/60 text-zinc-400 border-zinc-700/40 hover:text-white"
                      }`}>
                      {p === "all" ? "Any" : p}
                    </button>
                  ))}
                </div>
              </div>
              <div>
                <p className="text-[10px] text-zinc-500 uppercase tracking-widest mb-1.5 font-semibold">Freshness</p>
                <button onClick={() => setFilter("verifiedOnly", !filters.verifiedOnly)}
                  className={`flex items-center gap-1.5 px-3 py-1 rounded-full text-xs border transition-colors ${
                    filters.verifiedOnly ? "bg-emerald-500/20 text-emerald-400 border-emerald-500/40" : "bg-zinc-800/60 text-zinc-400 border-zinc-700/40 hover:text-white"
                  }`}>
                  <span className="relative flex h-2 w-2">
                    {filters.verifiedOnly && <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75" />}
                    <span className={`relative inline-flex rounded-full h-2 w-2 ${filters.verifiedOnly ? "bg-emerald-500" : "bg-zinc-600"}`} />
                  </span>
                  Verified This Week
                </button>
              </div>
              {hasFilters && (
                <button onClick={clearFilters} className="flex items-center gap-1 text-xs text-zinc-500 hover:text-white transition-colors ml-auto">
                  <X className="w-3 h-3" /> Clear all
                </button>
              )}
            </div>
          </div>
        )}
      </header>

      {/* ── Results bar ── */}
      <div className="max-w-7xl mx-auto px-4 py-4 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <span className="text-sm text-zinc-400">
            <span className="text-white font-bold">{filtered.length}</span> venues in {cityName}
          </span>
          {verifiedCount > 0 && (
            <span className="flex items-center gap-1.5 text-xs text-emerald-400">
              <span className="relative flex h-2 w-2">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75" />
                <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500" />
              </span>
              {verifiedCount} verified this week
            </span>
          )}
        </div>
        <span className="text-xs text-zinc-600">Updated May 2026</span>
      </div>

      {/* ── Grid / List ── */}
      <main className="max-w-7xl mx-auto px-4 pb-8">
        {paged.length === 0 ? (
          <div className="flex flex-col items-center py-24 text-zinc-600">
            <Moon className="w-10 h-10 mb-4 opacity-30" />
            <p className="text-lg font-semibold">No venues match</p>
            <button onClick={clearFilters} className={`mt-3 text-sm ${accentText} hover:opacity-80`}>Clear filters</button>
          </div>
        ) : viewMode === "grid" ? (
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-3">
            {paged.map((v, i) => (
              <VenueCard key={v.id} venue={v} rank={(page - 1) * PAGE_SIZE + i + 1} city={city} />
            ))}
          </div>
        ) : (
          <div className="space-y-2 max-w-3xl">
            {paged.map((v, i) => (
              <VenueListRow key={v.id} venue={v} rank={(page - 1) * PAGE_SIZE + i + 1} city={city} />
            ))}
          </div>
        )}
        <Pagination
          page={page} total={filtered.length} perPage={PAGE_SIZE}
          onPage={p => { setPage(p); window.scrollTo({ top: 0, behavior: "smooth" }); }}
        />
      </main>

      {/* ── Telegram float ── */}
      <div className="fixed bottom-6 right-4 z-50">
        <a href="https://t.me/ThainightTelegram" target="_blank" rel="noopener noreferrer"
          className="flex items-center gap-2 px-4 py-3 rounded-2xl bg-[#2AABEE] hover:bg-[#2AABEE]/90 text-white text-sm font-bold shadow-2xl shadow-[#2AABEE]/20 transition-all">
          <Send className="w-4 h-4" /> Raid Alerts
        </a>
      </div>
    </div>
  );
}
