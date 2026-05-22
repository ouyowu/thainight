"use client";

// components/IntelligenceFeed.tsx
// Horizontal scroll card row showing ThaiNight signals
// Insert above the venue grid on each city page
// Data fetched client-side via SWR-style polling (no SSR needed)

import { useState, useEffect } from "react";
import { TrendingUp, AlertTriangle, ExternalLink, ChevronRight } from "lucide-react";

interface IntelItem {
  id: string; title: string; url: string; subreddit?: string;
  thainight_value?: number; sentiment?: string; freshness?: string;
  is_raid_alert?: boolean; matched_venue_slug?: string;
  matched_venue_name?: string; received_at: string; city?: string;
}

interface Props {
  city: string;
}

export default function IntelligenceFeed({ city }: Props) {
  const [items,   setItems]   = useState<IntelItem[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function load() {
      try {
        // Fetch local ThaiNight intelligence, filtered to this city
        const url = new URL("/api/thainight/intelligence", window.location.origin);
        url.searchParams.set("city",      city);
        url.searchParams.set("min_value", "0.65");
        url.searchParams.set("limit",     "12");

        const res = await fetch(url.toString());

        if (res.ok) {
          const data = await res.json();
          setItems(data.items ?? []);
        }
      } catch (err) {
        console.error("[IntelligenceFeed]", err);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, [city]);

  if (loading) return (
    <div className="max-w-7xl mx-auto px-4 py-3">
      <div className="flex gap-3 overflow-hidden">
        {[1,2,3,4].map(i => (
          <div key={i} className="shrink-0 w-64 h-24 rounded-xl bg-zinc-900/60 border border-zinc-800/60 animate-pulse" />
        ))}
      </div>
    </div>
  );

  if (items.length === 0) return null;

  const raids    = items.filter(i => i.is_raid_alert);
  const nonRaids = items.filter(i => !i.is_raid_alert);

  return (
    <section className="max-w-7xl mx-auto px-4 py-4">
      {/* Header */}
      <div className="flex items-center justify-between mb-3">
        <div className="flex items-center gap-2">
          <TrendingUp className="w-4 h-4 text-emerald-400" />
          <h2 className="text-xs font-bold uppercase tracking-widest text-zinc-500">
            Community Intelligence
          </h2>
          {raids.length > 0 && (
            <span className="flex items-center gap-1 px-2 py-0.5 rounded-full bg-red-500/15 border border-red-500/25 text-red-400 text-[10px] font-bold animate-pulse">
              <AlertTriangle className="w-2.5 h-2.5" /> {raids.length} Alert{raids.length > 1 ? "s" : ""}
            </span>
          )}
        </div>
        <span className="text-[10px] text-zinc-700">via ThaiNight · live</span>
      </div>

      {/* Raid alerts first */}
      {raids.length > 0 && (
        <div className="mb-3 space-y-2">
          {raids.map(item => (
            <a key={item.id} href={item.url} target="_blank" rel="noopener noreferrer"
              className="flex items-center gap-3 p-3 rounded-xl bg-red-500/8 border border-red-500/25 hover:border-red-500/50 transition-all group">
              <AlertTriangle className="w-4 h-4 text-red-400 shrink-0" />
              <p className="text-xs text-red-300 flex-1 line-clamp-1 group-hover:text-red-200 transition-colors">{item.title}</p>
              <span className="text-[10px] text-zinc-600">r/{item.subreddit}</span>
              <ExternalLink className="w-3 h-3 text-zinc-700 shrink-0" />
            </a>
          ))}
        </div>
      )}

      {/* Horizontal scroll cards */}
      <div className="flex gap-3 overflow-x-auto pb-2 scrollbar-hide">
        {nonRaids.map(item => {
          const isHot  = item.freshness === "hot";
          const score  = item.thainight_value ?? 0;
          const barW   = `${Math.round(score * 100)}%`;

          return (
            <a key={item.id} href={item.url} target="_blank" rel="noopener noreferrer"
              className="group shrink-0 w-64 p-3 rounded-xl bg-zinc-900/60 border border-zinc-800/60 hover:border-zinc-700 transition-all flex flex-col gap-2">

              {/* Top row */}
              <div className="flex items-center justify-between">
                <span className="text-[10px] text-zinc-500">r/{item.subreddit}</span>
                <div className="flex items-center gap-1.5">
                  {isHot && <span className="text-[10px] text-amber-400 font-bold">🔥</span>}
                  {item.sentiment === "negative" && <span className="text-[10px] text-red-400">⚠️</span>}
                  <ExternalLink className="w-3 h-3 text-zinc-700 group-hover:text-zinc-500 transition-colors" />
                </div>
              </div>

              {/* Title */}
              <p className="text-xs text-zinc-300 line-clamp-2 leading-relaxed group-hover:text-white transition-colors flex-1">
                {item.title}
              </p>

              {/* Signal strength + venue match */}
              <div className="space-y-1.5">
                <div className="flex items-center gap-2">
                  <div className="flex-1 h-1 bg-zinc-800 rounded-full overflow-hidden">
                    <div
                      className={`h-full rounded-full transition-all ${score >= 0.85 ? "bg-emerald-500" : score >= 0.7 ? "bg-amber-500" : "bg-zinc-600"}`}
                      style={{ width: barW }}
                    />
                  </div>
                  <span className="text-[10px] font-mono text-zinc-500">{(score * 10).toFixed(1)}</span>
                </div>

                {item.matched_venue_slug && (
                  <div className="flex items-center gap-1 text-[10px] text-emerald-500">
                    <ChevronRight className="w-3 h-3" />
                    <span className="truncate">{item.matched_venue_name ?? item.matched_venue_slug}</span>
                  </div>
                )}
              </div>
            </a>
          );
        })}
      </div>
    </section>
  );
}
