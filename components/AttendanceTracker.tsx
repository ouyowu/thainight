"use client";

import { useEffect, useMemo, useState } from "react";
import Image from "next/image";
import { CalendarDays, Flame, MapPin, TicketCheck, Users } from "lucide-react";
import { canRenderPublicImage } from "@/lib/media";

type SocialPayload = {
  tonight_count?: number;
};

type Props = {
  venueId: string;
  venueName: string;
  venueCity: string;
  venueArea: string;
  posterUrl?: string | null;
  headline?: string | null;
};

export function AttendanceTracker({
  venueId,
  venueName,
  venueCity,
  venueArea,
  posterUrl,
  headline,
}: Props) {
  const [tonightCount, setTonightCount] = useState(0);

  useEffect(() => {
    fetch(`/api/social/venue?venueId=${encodeURIComponent(venueId)}`)
      .then(async (response) => response.json() as Promise<SocialPayload>)
      .then((payload) => setTonightCount(payload.tonight_count ?? 0))
      .catch(() => undefined);
  }, [venueId]);

  const line = useMemo(
    () => headline ?? `${venueName} may be one of tonight's stronger overlap spots.`,
    [headline, venueName]
  );
  const countLabel = tonightCount > 0
    ? `${tonightCount} Nomads checked in for tonight`
    : "Be the first to start tonight's table";

  return (
    <section className="overflow-hidden rounded-2xl border border-rose-400/20 bg-zinc-950">
      <div className="grid lg:grid-cols-[0.95fr_1.05fr]">
        <div className="relative min-h-[260px] overflow-hidden bg-zinc-900">
          {posterUrl && canRenderPublicImage(posterUrl) ? (
            <Image
              src={posterUrl}
              alt={`${venueName} live event poster`}
              fill
              sizes="(min-width: 1024px) 50vw, 100vw"
              className="absolute inset-0 object-cover"
            />
          ) : (
            <div className="absolute inset-0 bg-[linear-gradient(135deg,rgba(244,63,94,0.3),rgba(15,23,42,0.96))]" />
          )}
          <div className="absolute inset-0 bg-black/45 backdrop-blur-[1px]" />
          <div className="absolute inset-x-0 bottom-0 p-5">
            <span className="inline-flex items-center gap-2 rounded-full border border-white/15 bg-black/45 px-3 py-1 text-[11px] font-black uppercase tracking-widest text-white/90">
              <Flame className="h-3.5 w-3.5 text-rose-200" />
              Live venue pulse
            </span>
            <h2 className="mt-3 max-w-xl text-2xl font-black leading-tight text-white">
              {line}
            </h2>
          </div>
        </div>

        <div className="flex flex-col justify-between gap-5 p-5 sm:p-6">
          <div>
            <p className="inline-flex items-center gap-2 text-xs font-bold uppercase tracking-widest text-rose-300">
              <TicketCheck className="h-4 w-4" />
              Attendance Tracker
            </p>
            <div className="mt-4 flex items-baseline gap-3">
              {tonightCount > 0 ? (
                <span className="text-4xl font-black tracking-tight text-white">{tonightCount}</span>
              ) : null}
              <span className="text-sm font-semibold text-zinc-400">{countLabel}</span>
            </div>
          </div>

          <div className="grid gap-3 sm:grid-cols-2">
            <div className="rounded-xl border border-zinc-800 bg-zinc-900/70 p-4">
              <p className="inline-flex items-center gap-2 text-xs font-bold uppercase tracking-widest text-zinc-500">
                <MapPin className="h-3.5 w-3.5" />
                Area
              </p>
              <p className="mt-2 text-sm font-bold capitalize text-white">{venueArea.replace(/-/g, " ")}</p>
            </div>
            <div className="rounded-xl border border-zinc-800 bg-zinc-900/70 p-4">
              <p className="inline-flex items-center gap-2 text-xs font-bold uppercase tracking-widest text-zinc-500">
                <CalendarDays className="h-3.5 w-3.5" />
                City
              </p>
              <p className="mt-2 text-sm font-bold capitalize text-white">{venueCity.replace(/-/g, " ")}</p>
            </div>
          </div>

          <div className="rounded-xl border border-rose-300/15 bg-rose-500/10 p-4">
            <p className="inline-flex items-center gap-2 text-sm font-bold text-rose-100">
              <Users className="h-4 w-4" />
              RA-style attendance signal, tuned for ThaiNight meetups.
            </p>
            <p className="mt-2 text-sm leading-6 text-rose-100/80">
              This block measures current social momentum, while the meetup panel below handles group matching and table-partner posts.
            </p>
          </div>
        </div>
      </div>
    </section>
  );
}
