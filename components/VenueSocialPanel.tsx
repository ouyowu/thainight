"use client";

import { useEffect, useMemo, useState } from "react";
import { BadgeCheck, Crown, Flame, Languages, LockKeyhole, MapPin, Plus, Sparkles, Users, X } from "lucide-react";

type Avatar = {
  id: string;
  initials: string;
  city: string;
  vibe: string;
  seed: string;
  home_country?: string | null;
  languages?: string[];
  verification_status?: "unverified" | "email_verified" | "instagram_verified" | "manual_verified";
  persona_tags?: string[];
  overlapping_tonight?: boolean;
};

type Meetup = {
  id: string;
  viewer_is_creator?: boolean;
  title: string;
  note: string;
  meetup_time: string;
  seats_total: number;
  seats_open: number;
  budget_label: string;
  audience_note?: string | null;
  expires_at: string;
  is_featured: boolean;
  created_at: string;
  join_requests?: JoinRequest[];
};

type JoinRequest = {
  id: string;
  meetup_id: string;
  requester_id: string;
  message: string;
  status: "pending" | "approved" | "rejected";
  created_at: string;
};

type Props = {
  venueId: string;
  venueName: string;
  socialEnabled: boolean;
  trending: boolean;
};

type SocialPayload = {
  tonight_count?: number;
  avatars?: Avatar[];
  meetups?: Meetup[];
};

function formatTime(value: string): string {
  return new Date(value).toLocaleString("en-US", {
    month: "short",
    day: "numeric",
    hour: "numeric",
    minute: "2-digit",
  });
}

export function VenueSocialPanel({ venueId, venueName, socialEnabled, trending }: Props) {
  const [tonightCount, setTonightCount] = useState(0);
  const [avatars, setAvatars] = useState<Avatar[]>([]);
  const [meetups, setMeetups] = useState<Meetup[]>([]);
  const [formOpen, setFormOpen] = useState(false);
  const [paywallOpen, setPaywallOpen] = useState(false);
  const [notice, setNotice] = useState("");
  const [busy, setBusy] = useState<"interest" | "meetup" | "join" | "approve" | null>(null);
  const [joinMessageByMeetup, setJoinMessageByMeetup] = useState<Record<string, string>>({});
  const [form, setForm] = useState({
    title: "",
    note: "",
    meetup_time: "",
    seats_total: "4",
    budget_label: "฿฿",
    audience_note: "",
  });

  useEffect(() => {
    if (!socialEnabled && !trending) return;
    fetch(`/api/social/venue?venueId=${encodeURIComponent(venueId)}`)
      .then(async (response) => response.json() as Promise<SocialPayload>)
      .then((payload) => {
        setTonightCount(payload.tonight_count ?? 0);
        setAvatars(payload.avatars ?? []);
        setMeetups(payload.meetups ?? []);
      })
      .catch(() => undefined);
  }, [socialEnabled, trending, venueId]);

  const compactAvatars = useMemo(() => avatars.slice(0, 8), [avatars]);
  const verifiedOverlapCount = useMemo(
    () => avatars.filter((avatar) => avatar.overlapping_tonight && avatar.verification_status !== "unverified").length,
    [avatars]
  );

  async function countMeIn() {
    setBusy("interest");
    setNotice("");
    const response = await fetch("/api/social/venue", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ action: "count_me_in", venue_id: venueId }),
    });
    const payload = await response.json() as { paywall?: boolean; error?: string };
    setBusy(null);
    if (response.status === 401) {
      setNotice("Sign in first to add yourself to tonight's crowd.");
      return;
    }
    if (payload.paywall) {
      setPaywallOpen(true);
      return;
    }
    if (!response.ok) {
      setNotice(payload.error ?? "Could not save your interest.");
      return;
    }
    setTonightCount((count) => count + 1);
    setNotice("You are counted in for tonight.");
  }

  async function createMeetup(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setBusy("meetup");
    setNotice("");
    const response = await fetch("/api/social/venue", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        action: "create_meetup",
        venue_id: venueId,
        ...form,
        seats_total: Number(form.seats_total),
      }),
    });
    const payload = await response.json() as { meetup?: Meetup; paywall?: boolean; error?: string };
    setBusy(null);
    if (response.status === 401) {
      setNotice("Sign in first to publish a meetup.");
      return;
    }
    if (response.status === 403) {
      setNotice("Instagram verification is required before you can create a table-partner post.");
      return;
    }
    if (payload.paywall) {
      setPaywallOpen(true);
      return;
    }
    if (!response.ok || !payload.meetup) {
      setNotice(payload.error ?? "Could not create this meetup.");
      return;
    }
    setMeetups((current) => [payload.meetup!, ...current]);
    setFormOpen(false);
    setNotice("Your 24-hour meetup is live.");
  }

  async function requestJoin(meetupId: string) {
    setBusy("join");
    setNotice("");
    const response = await fetch("/api/social/venue", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        action: "request_join",
        venue_id: venueId,
        meetup_id: meetupId,
        message: joinMessageByMeetup[meetupId] ?? "I would like to join this table tonight.",
      }),
    });
    const payload = await response.json() as { paywall?: boolean; verification_required?: boolean; error?: string };
    setBusy(null);
    if (response.status === 401) {
      setNotice("Sign in first to request a seat.");
      return;
    }
    if (payload.paywall) {
      setPaywallOpen(true);
      return;
    }
    if (payload.verification_required || response.status === 403) {
      setNotice("Instagram verification is required before you can request to join.");
      return;
    }
    if (!response.ok) {
      setNotice(payload.error ?? "Could not submit this request.");
      return;
    }
    setMeetups((current) => current.map((meetup) => meetup.id === meetupId ? {
      ...meetup,
      join_requests: [
        ...(meetup.join_requests ?? []),
        {
          id: `pending-${Date.now()}`,
          meetup_id: meetupId,
          requester_id: "me",
          message: joinMessageByMeetup[meetupId] ?? "I would like to join this table tonight.",
          status: "pending",
          created_at: new Date().toISOString(),
        },
      ],
    } : meetup));
    setNotice("Request sent. The meetup host can approve it before contact details are shared.");
  }

  async function approveJoin(requestId: string) {
    setBusy("approve");
    setNotice("");
    const response = await fetch("/api/social/venue", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ action: "approve_join", venue_id: venueId, request_id: requestId }),
    });
    const payload = await response.json() as { error?: string };
    setBusy(null);
    if (!response.ok) {
      setNotice(payload.error ?? "Could not approve this request.");
      return;
    }
    setMeetups((current) => current.map((meetup) => ({
      ...meetup,
      seats_open: Math.max(0, meetup.seats_open - 1),
      join_requests: (meetup.join_requests ?? []).map((request) =>
        request.id === requestId ? { ...request, status: "approved" } : request
      ),
    })));
    setNotice("Request approved. This seat is now reserved.");
  }

  if (!socialEnabled && !trending) {
    return (
      <section className="rounded-2xl border border-dashed border-zinc-800 bg-zinc-900/35 p-6">
        <p className="text-xs font-black uppercase tracking-widest text-zinc-500">Social layer</p>
        <h2 className="mt-3 text-2xl font-black text-white">Follow this venue to unlock social features later.</h2>
        <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-400">
          ThaiNight activates live meetup features on the most active venues first, so social energy stays concentrated instead of looking empty.
        </p>
      </section>
    );
  }

  return (
    <>
      <section className="rounded-2xl border border-rose-400/20 bg-[linear-gradient(135deg,rgba(244,63,94,0.12),rgba(9,9,11,0.96))] p-6">
        <div className="flex flex-col gap-4 md:flex-row md:items-start md:justify-between">
          <div>
            <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-rose-300">
              <Flame className="h-4 w-4" />
              Going Tonight?
            </p>
            <h2 className="mt-3 text-2xl font-black text-white">{venueName} overlap tonight</h2>
            <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-300">
              Borrowing the strongest travel-social idea: people matter more when their plans overlap. See who is interested in the same venue tonight, then decide whether to join in.
            </p>
          </div>
          <button
            type="button"
            onClick={countMeIn}
            disabled={busy === "interest"}
            className="inline-flex h-12 items-center justify-center rounded-xl bg-rose-500 px-5 text-sm font-black text-white transition hover:bg-rose-400 disabled:cursor-not-allowed disabled:opacity-60"
          >
            {busy === "interest" ? "Saving..." : "Count me in"}
          </button>
        </div>

        <div className="mt-5 grid gap-4 lg:grid-cols-[0.82fr_1.18fr]">
          <div className="rounded-2xl border border-white/10 bg-black/25 p-4">
            <div className="flex items-center justify-between gap-3">
              <span className="inline-flex items-center gap-2 text-sm font-black text-white">
                <Users className="h-4 w-4 text-rose-300" />
                {tonightCount > 0 ? `${tonightCount} people tonight` : "Be the first to start tonight's table"}
              </span>
              <span className="rounded-full bg-white/10 px-2.5 py-1 text-xs font-semibold text-zinc-200">
                Live shelf
              </span>
            </div>
            <div className="mt-4 flex -space-x-3">
              {compactAvatars.length ? compactAvatars.map((avatar) => (
                <div
                  key={avatar.id}
                  title={`${avatar.city} · ${avatar.vibe}`}
                  className="flex h-12 w-12 items-center justify-center rounded-full border-2 border-zinc-950 bg-[linear-gradient(135deg,#f43f5e,#fb7185)] text-sm font-black text-white shadow-xl"
                >
                  {avatar.initials}
                </div>
              )) : (
                <p className="text-sm text-zinc-400">Be among the first social signals for tonight.</p>
              )}
            </div>
            {compactAvatars.length > 0 && (
              <div className="mt-4 space-y-2">
                {compactAvatars.slice(0, 3).map((avatar) => (
                  <div key={`${avatar.id}-meta`} className="rounded-xl border border-white/10 bg-white/[0.03] p-3 text-xs leading-6 text-zinc-300">
                    <div className="flex flex-wrap items-center gap-2">
                      <span className="font-bold text-white">{avatar.city}</span>
                      <span>·</span>
                      <span>{avatar.vibe}</span>
                      {avatar.verification_status && avatar.verification_status !== "unverified" ? (
                        <span className="inline-flex items-center gap-1 rounded-full bg-emerald-400/10 px-2 py-0.5 font-bold text-emerald-200">
                          <BadgeCheck className="h-3 w-3" />
                          Verified
                        </span>
                      ) : null}
                    </div>
                    <div className="mt-2 flex flex-wrap items-center gap-3 text-zinc-400">
                      {avatar.home_country ? (
                        <span className="inline-flex items-center gap-1">
                          <MapPin className="h-3 w-3" />
                          {avatar.home_country}
                        </span>
                      ) : null}
                      {avatar.languages?.length ? (
                        <span className="inline-flex items-center gap-1">
                          <Languages className="h-3 w-3" />
                          {avatar.languages.slice(0, 2).join(", ")}
                        </span>
                      ) : null}
                    </div>
                  </div>
                ))}
              </div>
            )}
            <div className="mt-4 rounded-xl border border-rose-300/15 bg-rose-500/10 px-3 py-3 text-sm text-rose-100">
              {verifiedOverlapCount > 0
                ? `${verifiedOverlapCount} verified travelers overlap with this venue tonight.`
                : "Verified traveler overlap appears here once early members count themselves in."}
            </div>
          </div>

          <div className="rounded-2xl border border-white/10 bg-black/25 p-4">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div>
                <p className="text-xs font-black uppercase tracking-widest text-zinc-500">Flash Meetups</p>
                <h3 className="mt-2 text-lg font-black text-white">Seek a Table Partner</h3>
              </div>
              <button
                type="button"
                onClick={() => setFormOpen((open) => !open)}
                className="inline-flex h-11 items-center gap-2 rounded-xl border border-white/10 bg-white/10 px-4 text-sm font-bold text-white transition hover:bg-white/15"
              >
                <Plus className="h-4 w-4" />
                Create post
              </button>
            </div>

            <div className="mt-4 space-y-3">
              {meetups.length === 0 && (
                <div className="rounded-xl border border-dashed border-white/10 px-4 py-5 text-sm leading-7 text-zinc-400">
                  No active meetup post yet. Publish a 24-hour request for a table partner or small group.
                </div>
              )}
              {meetups.map((meetup) => (
                <article key={meetup.id} className="rounded-xl border border-white/10 bg-zinc-950/80 p-4">
                  <div className="flex flex-wrap items-center justify-between gap-2">
                    <h4 className="text-sm font-black text-white">{meetup.title}</h4>
                    <span className="rounded-full bg-rose-500/15 px-2.5 py-1 text-xs font-bold text-rose-200">
                      {meetup.seats_open} open / {meetup.seats_total}
                    </span>
                  </div>
                  <p className="mt-3 text-sm leading-7 text-zinc-300">{meetup.note}</p>
                  <div className="mt-3 flex flex-wrap gap-2 text-xs font-semibold text-zinc-400">
                    <span>{formatTime(meetup.meetup_time)}</span>
                    <span>·</span>
                    <span>{meetup.budget_label}</span>
                    {meetup.audience_note ? <span>· {meetup.audience_note}</span> : null}
                  </div>
                  {!meetup.viewer_is_creator ? (
                    <div className="mt-4 rounded-xl border border-white/10 bg-black/25 p-3">
                      <input
                        value={joinMessageByMeetup[meetup.id] ?? ""}
                        onChange={(event) => setJoinMessageByMeetup((current) => ({ ...current, [meetup.id]: event.target.value }))}
                        placeholder="Short intro for the host"
                        className="h-10 w-full rounded-lg border border-zinc-700 bg-zinc-900 px-3 text-xs text-white outline-none focus:border-rose-400"
                      />
                      <button
                        type="button"
                        onClick={() => requestJoin(meetup.id)}
                        disabled={busy === "join"}
                        className="mt-2 inline-flex h-10 w-full items-center justify-center rounded-lg bg-white px-3 text-xs font-black text-zinc-950 transition hover:bg-zinc-100 disabled:cursor-not-allowed disabled:opacity-60"
                      >
                        {busy === "join" ? "Sending..." : "Request to join"}
                      </button>
                      <p className="mt-2 text-[11px] leading-5 text-zinc-500">
                        Instagram-verified users only. The host approves before private contact moves forward.
                      </p>
                    </div>
                  ) : null}
                  {meetup.viewer_is_creator && (meetup.join_requests ?? []).length > 0 ? (
                    <div className="mt-4 space-y-2 rounded-xl border border-rose-300/15 bg-rose-500/5 p-3">
                      <p className="text-xs font-black uppercase tracking-widest text-rose-200">Pending join requests</p>
                      {(meetup.join_requests ?? []).map((request) => (
                        <div key={request.id} className="rounded-lg border border-white/10 bg-black/25 p-3">
                          <p className="text-xs leading-6 text-zinc-300">{request.message}</p>
                          <div className="mt-2 flex items-center justify-between gap-2">
                            <span className="text-[11px] font-bold uppercase text-zinc-500">{request.status}</span>
                            {request.status === "pending" ? (
                              <button
                                type="button"
                                onClick={() => approveJoin(request.id)}
                                disabled={busy === "approve"}
                                className="rounded-lg bg-rose-500 px-3 py-1.5 text-[11px] font-black text-white disabled:cursor-not-allowed disabled:opacity-60"
                              >
                                Approve
                              </button>
                            ) : null}
                          </div>
                        </div>
                      ))}
                    </div>
                  ) : null}
                </article>
              ))}
            </div>
          </div>
        </div>

        {notice && <p className="mt-4 text-sm text-amber-200">{notice}</p>}

        {formOpen && (
          <form onSubmit={createMeetup} className="mt-5 grid gap-3 rounded-2xl border border-white/10 bg-zinc-950/90 p-4 md:grid-cols-2">
            <input
              value={form.title}
              onChange={(event) => setForm((current) => ({ ...current, title: event.target.value }))}
              placeholder="Tonight 23:00, table split for 4"
              className="h-12 rounded-xl border border-zinc-700 bg-zinc-900 px-4 text-sm text-white outline-none focus:border-rose-400"
            />
            <input
              type="datetime-local"
              value={form.meetup_time}
              onChange={(event) => setForm((current) => ({ ...current, meetup_time: event.target.value }))}
              className="h-12 rounded-xl border border-zinc-700 bg-zinc-900 px-4 text-sm text-white outline-none focus:border-rose-400"
            />
            <textarea
              value={form.note}
              onChange={(event) => setForm((current) => ({ ...current, note: event.target.value }))}
              placeholder="Three friends going, looking for two more easygoing travelers."
              className="min-h-28 rounded-xl border border-zinc-700 bg-zinc-900 px-4 py-3 text-sm leading-7 text-white outline-none focus:border-rose-400 md:col-span-2"
            />
            <input
              value={form.audience_note}
              onChange={(event) => setForm((current) => ({ ...current, audience_note: event.target.value }))}
              placeholder="Audience note: solo travelers / digital nomads"
              className="h-12 rounded-xl border border-zinc-700 bg-zinc-900 px-4 text-sm text-white outline-none focus:border-rose-400"
            />
            <div className="grid grid-cols-2 gap-3">
              <select
                value={form.seats_total}
                onChange={(event) => setForm((current) => ({ ...current, seats_total: event.target.value }))}
                className="h-12 rounded-xl border border-zinc-700 bg-zinc-900 px-3 text-sm text-white outline-none focus:border-rose-400"
              >
                {[2, 3, 4, 5, 6, 8, 10, 12].map((count) => <option key={count} value={count}>{count} seats</option>)}
              </select>
              <select
                value={form.budget_label}
                onChange={(event) => setForm((current) => ({ ...current, budget_label: event.target.value }))}
                className="h-12 rounded-xl border border-zinc-700 bg-zinc-900 px-3 text-sm text-white outline-none focus:border-rose-400"
              >
                {["฿", "฿฿", "฿฿฿", "฿฿฿฿"].map((budget) => <option key={budget} value={budget}>{budget}</option>)}
              </select>
            </div>
            <button
              type="submit"
              disabled={busy === "meetup"}
              className="inline-flex h-12 items-center justify-center rounded-xl bg-rose-500 px-5 text-sm font-black text-white transition hover:bg-rose-400 disabled:cursor-not-allowed disabled:opacity-60 md:col-span-2"
            >
              {busy === "meetup" ? "Publishing..." : "Publish 24-hour meetup"}
            </button>
          </form>
        )}
      </section>

      {paywallOpen && (
        <div className="fixed inset-0 z-[90] flex items-center justify-center bg-black/80 p-4">
          <div className="w-full max-w-lg rounded-[28px] border border-rose-300/25 bg-zinc-950 p-6 shadow-2xl shadow-black/50">
            <div className="flex items-start justify-between gap-4">
              <div className="inline-flex h-12 w-12 items-center justify-center rounded-2xl bg-rose-500/15 text-rose-200">
                <Crown className="h-6 w-6" />
              </div>
              <button type="button" onClick={() => setPaywallOpen(false)} className="rounded-full border border-zinc-700 p-2 text-zinc-400 hover:text-white">
                <X className="h-4 w-4" />
              </button>
            </div>
            <h3 className="mt-5 text-2xl font-black text-white">ThaiNight Pass unlocks deeper nightlife social tools.</h3>
            <p className="mt-3 text-sm leading-7 text-zinc-300">
              ThaiNight Pass is free for early beta members. Later, paid Pass benefits may unlock more meetup visibility, richer profile previews, and priority table-partner tools.
            </p>
            <div className="mt-5 grid gap-3">
              {[
                "Free early access while ThaiNight is in beta",
                "Priority visibility for future table-partner posts",
                "Early access to social credit and private matching tools",
              ].map((item) => (
                <div key={item} className="flex items-start gap-3 rounded-xl border border-white/10 bg-white/5 px-4 py-3 text-sm leading-6 text-zinc-200">
                  <LockKeyhole className="mt-0.5 h-4 w-4 shrink-0 text-rose-300" />
                  <span>{item}</span>
                </div>
              ))}
            </div>
            <button type="button" className="mt-5 inline-flex h-12 w-full items-center justify-center gap-2 rounded-xl bg-rose-500 px-5 text-sm font-black text-white">
              <Sparkles className="h-4 w-4" />
              Early member access is free now
            </button>
          </div>
        </div>
      )}
    </>
  );
}
