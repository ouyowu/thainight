"use client";

import { useEffect, useState } from "react";
import { BadgeCheck, Crown, LockKeyhole, Users } from "lucide-react";

type Avatar = {
  id: string;
  initials: string;
  city: string;
  vibe: string;
  verification_status?: "unverified" | "email_verified" | "instagram_verified" | "manual_verified";
  home_country?: string | null;
  languages?: string[];
  persona_tags?: string[];
  overlapping_tonight?: boolean;
};

type Props = {
  venueId: string;
  venueName: string;
  enabled: boolean;
};

export function OverlapTonightCard({ venueId, venueName, enabled }: Props) {
  const [avatars, setAvatars] = useState<Avatar[]>([]);
  const [count, setCount] = useState(0);
  const [passUnlocked, setPassUnlocked] = useState(false);
  const [viewerTier, setViewerTier] = useState<"free" | "vip">("free");

  useEffect(() => {
    if (!enabled) return;
    fetch(`/api/social/venue?venueId=${encodeURIComponent(venueId)}`)
      .then(async (response) => response.json() as Promise<{
        tonight_count?: number;
        avatars?: Avatar[];
        viewer?: { tier?: "free" | "vip"; pass_unlocked?: boolean };
      }>)
      .then((payload) => {
        setCount(payload.tonight_count ?? 0);
        setAvatars(payload.avatars ?? []);
        setPassUnlocked(Boolean(payload.viewer?.pass_unlocked));
        setViewerTier(payload.viewer?.tier === "vip" ? "vip" : "free");
      })
      .catch(() => undefined);
  }, [enabled, venueId]);

  if (!enabled) return null;

  return (
    <section className="rounded-2xl border border-amber-300/15 bg-zinc-950 p-5">
      <div className="flex flex-col gap-4 md:flex-row md:items-start md:justify-between">
        <div>
          <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-amber-300">
            <Users className="h-4 w-4" />
            Who overlaps tonight?
          </p>
          <h2 className="mt-3 text-2xl font-black text-white">{venueName} is drawing {count} active travelers</h2>
          <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-400">
            Free members see the crowd signal. ThaiNight Pass unlocks the richer overlap view, trust markers, and contact pathways.
          </p>
        </div>
        <span className="inline-flex h-11 items-center gap-2 rounded-full border border-amber-300/20 bg-amber-400/10 px-4 text-sm font-bold text-amber-100">
          <Crown className="h-4 w-4" />
          {passUnlocked ? "Pass unlocked" : "Pass preview"}
        </span>
      </div>

      <div className="mt-5 grid gap-4 lg:grid-cols-[0.92fr_1.08fr]">
        <div className="rounded-2xl border border-zinc-800 bg-zinc-900/70 p-4">
          <div className="flex -space-x-3">
            {avatars.slice(0, 6).map((avatar) => (
              <div key={avatar.id} className="flex h-12 w-12 items-center justify-center rounded-full border-2 border-zinc-950 bg-[linear-gradient(135deg,#f59e0b,#f43f5e)] text-sm font-black text-white">
                {avatar.initials}
              </div>
            ))}
          </div>
          <div className="mt-4 space-y-2">
            {avatars.slice(0, 3).map((avatar) => (
              <div key={`${avatar.id}-row`} className="flex flex-wrap items-center gap-2 text-xs text-zinc-300">
                <span className="font-bold text-white">{avatar.city}</span>
                <span>·</span>
                <span>{avatar.vibe}</span>
                {avatar.verification_status && avatar.verification_status !== "unverified" ? (
                  <span className="inline-flex items-center gap-1 rounded-full bg-emerald-400/10 px-2 py-0.5 font-bold text-emerald-200">
                    <BadgeCheck className="h-3 w-3" />
                    Verified
                  </span>
                ) : null}
                {passUnlocked && avatar.home_country ? <span>· {avatar.home_country}</span> : null}
              </div>
            ))}
          </div>
          {passUnlocked ? (
            <div className="mt-4 grid gap-2">
              {avatars.slice(0, 3).map((avatar) => (
                <div key={`${avatar.id}-depth`} className="rounded-xl border border-zinc-800 bg-zinc-950/80 px-3 py-3 text-xs leading-6 text-zinc-300">
                  <div className="flex flex-wrap gap-2">
                    {avatar.languages?.slice(0, 2).map((language) => (
                      <span key={`${avatar.id}-${language}`} className="rounded-full bg-white/5 px-2 py-0.5 text-zinc-200">
                        {language}
                      </span>
                    ))}
                    {avatar.persona_tags?.slice(0, 2).map((tag) => (
                      <span key={`${avatar.id}-${tag}`} className="rounded-full bg-amber-400/10 px-2 py-0.5 text-amber-100">
                        {tag}
                      </span>
                    ))}
                  </div>
                  <p className="mt-2 text-zinc-400">
                    {avatar.overlapping_tonight ? "Trip window overlaps tonight." : "Traveler profile available through Pass."}
                  </p>
                </div>
              ))}
            </div>
          ) : null}
        </div>

        <div className="rounded-2xl border border-amber-300/15 bg-amber-400/10 p-4">
          <p className="inline-flex items-center gap-2 text-sm font-black text-amber-100">
            <LockKeyhole className="h-4 w-4" />
            {passUnlocked ? "ThaiNight Pass active:" : "ThaiNight Pass unlocks:"}
          </p>
          <div className="mt-3 grid gap-2 text-sm leading-6 text-amber-50/90 sm:grid-cols-2">
            {passUnlocked ? (
              <>
                <span>Full traveler overlap details</span>
                <span>Persona and language depth</span>
                <span>Verified profile visibility</span>
                <span>Priority for future contact unlocks</span>
              </>
            ) : (
              <>
                <span>Full traveler overlap list</span>
                <span>Verified-only filters</span>
                <span>Profile and persona depth</span>
                <span>Future contact unlocks</span>
              </>
            )}
          </div>
          {!passUnlocked ? (
            <p className="mt-4 text-xs leading-6 text-amber-100/80">
              Current access: {viewerTier === "vip" ? "VIP recognized" : "free preview only"}.
            </p>
          ) : null}
        </div>
      </div>
    </section>
  );
}
