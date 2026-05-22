"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import Image from "next/image";
import { ArrowRight, BadgeCheck, Flame, Sparkles, Users } from "lucide-react";
import { canRenderPublicImage } from "@/lib/media";

type SocialVenue = {
  id: string;
  slug: string;
  name: string;
  city: string;
  area_slug: string;
  category: string;
  hero_image_url?: string | null;
  overall_score?: number | null;
  tonight_count: number;
};

export function SocialHub() {
  const [venues, setVenues] = useState<SocialVenue[]>([]);
  const [state, setState] = useState<"loading" | "ready" | "empty">("loading");

  useEffect(() => {
    fetch("/api/social-hub")
      .then(async (response) => response.json() as Promise<{ venues?: SocialVenue[] }>)
      .then((payload) => {
        const next = payload.venues ?? [];
        setVenues(next.slice(0, 6));
        setState(next.length ? "ready" : "empty");
      })
      .catch(() => setState("empty"));
  }, []);

  return (
    <section id="tonight-social" className="overflow-hidden rounded-[32px] border border-rose-300/20 bg-[linear-gradient(135deg,rgba(244,63,94,0.14),rgba(9,9,11,0.98)_42%,rgba(245,158,11,0.08))] p-5 sm:p-7 lg:p-8">
      <div className="grid gap-6 xl:grid-cols-[0.92fr_1.08fr] xl:items-end">
        <div>
          <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-rose-300">
            <Flame className="h-4 w-4" />
            ThaiNight Social Core
          </p>
          <h2 className="mt-3 max-w-4xl text-3xl font-black tracking-tight text-white sm:text-4xl lg:text-5xl">
            Going Tonight? This is the heartbeat of ThaiNight.
          </h2>
          <p className="mt-4 max-w-3xl text-sm leading-7 text-zinc-200 sm:text-base">
            We are not just cataloging bars. We are building the live layer around nightlife culture: where people are heading, which venues are gathering momentum, and where a night out can become a real social plan.
          </p>
          <div className="mt-5 flex flex-wrap gap-2">
            {[
              "Tonight attendance",
              "Anonymous social overlap",
              "Meetup-ready venues",
              "Culture-first discovery",
            ].map((item) => (
              <span key={item} className="rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-xs font-bold text-zinc-100">
                {item}
              </span>
            ))}
          </div>
        </div>

        <div className="grid gap-3 sm:grid-cols-3">
          {[
            { icon: Users, label: "Live overlap", value: "Who is out" },
            { icon: BadgeCheck, label: "Trust layer", value: "Verified profiles" },
            { icon: Sparkles, label: "Night culture", value: "Events + places" },
          ].map(({ icon: Icon, label, value }) => (
            <div key={label} className="rounded-2xl border border-white/10 bg-black/20 p-4">
              <Icon className="h-5 w-5 text-rose-200" />
              <p className="mt-4 text-xs font-black uppercase tracking-widest text-zinc-400">{label}</p>
              <p className="mt-1 text-sm font-bold text-white">{value}</p>
            </div>
          ))}
        </div>
      </div>

      {state === "loading" && <p className="mt-6 text-sm text-zinc-400">Loading tonight&apos;s social anchors...</p>}
      {state === "empty" && (
        <div className="mt-6 rounded-2xl border border-dashed border-white/10 bg-black/20 p-5 text-sm leading-7 text-zinc-400">
          The Social Hub is ready. Be the first to start tonight&apos;s table, or check back as members begin marking where they are going.
        </div>
      )}

      {state === "ready" && (
        <div className="mt-7 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
          {venues.map((venue) => (
            <Link
              key={venue.id}
              href={`/${venue.city}/bars/${venue.area_slug}/${venue.slug}`}
              className="group overflow-hidden rounded-[24px] border border-white/10 bg-zinc-950/90 transition hover:-translate-y-0.5 hover:border-rose-300/45"
            >
              <div className="relative aspect-[4/3] overflow-hidden bg-zinc-900">
                {venue.hero_image_url && canRenderPublicImage(venue.hero_image_url) ? (
                  <Image
                    src={venue.hero_image_url}
                    alt={venue.name}
                    fill
                    sizes="(min-width: 1280px) 33vw, (min-width: 768px) 50vw, 100vw"
                    className="object-cover transition duration-500 group-hover:scale-105"
                  />
                ) : null}
                <div className="absolute inset-0 bg-gradient-to-t from-black via-black/30 to-transparent" />
                <span className="absolute left-4 top-4 rounded-full border border-white/15 bg-black/55 px-3 py-1 text-xs font-bold text-white backdrop-blur">
                  {venue.city.replace(/-/g, " ")}
                </span>
                <span className="absolute bottom-4 left-4 rounded-full border border-rose-200/20 bg-rose-500/90 px-3 py-1 text-xs font-black text-white shadow-lg shadow-black/40">
                  Going tonight
                </span>
              </div>
              <div className="p-4">
                <div className="flex items-start justify-between gap-3">
                  <div>
                    <h3 className="text-lg font-black leading-7 text-white">{venue.name}</h3>
                    <p className="mt-1 text-sm capitalize text-zinc-400">{venue.area_slug.replace(/-/g, " ")} · {venue.category.replace(/-/g, " ")}</p>
                  </div>
                  {venue.overall_score != null && (
                    <span className="rounded-xl bg-amber-400 px-2.5 py-1 text-sm font-black text-zinc-950">
                      {venue.overall_score.toFixed(1)}
                    </span>
                  )}
                </div>
                <div className="mt-4 flex items-center justify-between rounded-xl border border-zinc-800 bg-zinc-900 px-3 py-3">
                  <span className="inline-flex items-center gap-2 text-sm font-bold text-rose-200">
                    <Users className="h-4 w-4" />
                    {venue.tonight_count > 0 ? `${venue.tonight_count} going tonight` : "Start tonight's table"}
                  </span>
                  <span className="inline-flex items-center gap-1 text-sm font-black text-white">
                    View
                    <ArrowRight className="h-4 w-4 transition group-hover:translate-x-1" />
                  </span>
                </div>
              </div>
            </Link>
          ))}
        </div>
      )}

      <div className="mt-7 flex flex-col gap-3 rounded-2xl border border-white/10 bg-black/20 px-4 py-4 text-sm leading-7 text-zinc-200 sm:flex-row sm:items-center sm:justify-between">
        <p>
          ThaiNight is built around nightlife as a living culture: places, people, plans, and the stories formed between them.
        </p>
        <Link href="/profile" className="inline-flex h-11 shrink-0 items-center justify-center gap-2 rounded-full bg-white px-4 font-black text-zinc-950 transition hover:bg-zinc-100">
          Build your social profile
          <ArrowRight className="h-4 w-4" />
        </Link>
      </div>
    </section>
  );
}
