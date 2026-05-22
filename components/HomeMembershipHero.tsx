"use client";

import { useState } from "react";
import Image from "next/image";
import {
  ArrowRight,
  BellRing,
  CalendarDays,
  Mail,
  MapPinned,
  ShieldCheck,
  Sparkles,
  Users,
} from "lucide-react";

type Props = {
  backgroundImage?: string | null;
  imageStrip?: string[];
};

type SubscribeState = "idle" | "submitting" | "success" | "error";

const VALUE_POINTS = [
  {
    icon: CalendarDays,
    text: "Track fresh events, social hotspots, and nightlife signals city by city.",
  },
  {
    icon: ShieldCheck,
    text: "Find venues with clearer prices, verified freshness, and a more trustworthy social layer.",
  },
  {
    icon: MapPinned,
    text: "Explore Bangkok, Pattaya, Phuket, and Chiang Mai through places, scenes, and who is moving tonight.",
  },
  {
    icon: BellRing,
    text: "Join the free ThaiNight list for culture drops, social launches, and member-only updates.",
  },
];

export function HomeMembershipHero({ imageStrip = [] }: Props) {
  const [email, setEmail] = useState("");
  const [status, setStatus] = useState<SubscribeState>("idle");
  const [message, setMessage] = useState("");

  async function subscribe(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setStatus("submitting");
    setMessage("");

    try {
      const response = await fetch("/api/newsletter", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email }),
      });
      const payload = await response.json() as { message?: string; error?: string };
      if (!response.ok) {
        setStatus("error");
        setMessage(payload.error ?? "Could not add this email right now.");
        return;
      }

      setStatus("success");
      setMessage(payload.message ?? "Welcome to ThaiNight.");
      setEmail("");
    } catch {
      setStatus("error");
      setMessage("Membership signup is temporarily unavailable.");
    }
  }

  return (
    <section className="overflow-hidden rounded-[28px] border border-zinc-800 bg-zinc-950">
      <div className="grid gap-8 px-5 py-6 sm:px-8 sm:py-8 lg:grid-cols-[1.05fr_0.95fr] lg:items-center lg:px-10">
        <div className="max-w-3xl">
          <div className="inline-flex items-center gap-2 rounded-full border border-zinc-800 bg-zinc-900 px-3 py-1.5 text-xs font-bold uppercase tracking-widest text-zinc-200">
            <Sparkles className="h-3.5 w-3.5 text-amber-300" />
            Nightlife culture, people, and places
          </div>

          <h2 className="mt-5 text-balance text-3xl font-black tracking-tight text-white sm:text-4xl lg:text-5xl">
            ThaiNight is where nightlife discovery becomes a social decision.
          </h2>
          <p className="mt-4 max-w-2xl text-base leading-8 text-zinc-300 sm:text-lg">
            Fresh venue walls, event intelligence, tonight&apos;s crowd signals, and social overlap tools built for travelers, expats, and serious night owls.
          </p>

          {imageStrip.length > 0 && (
            <div className="mt-6 flex flex-wrap items-center gap-3">
              <div className="flex -space-x-3">
                {imageStrip.slice(0, 8).map((image, index) => (
                  <div
                    key={`${image}-${index}`}
                    className="relative h-12 w-12 overflow-hidden rounded-full border-2 border-white bg-zinc-900 shadow-xl shadow-black/30"
                  >
                    <Image
                      src={image}
                      alt=""
                      fill
                      sizes="48px"
                      className="object-cover"
                    />
                  </div>
                ))}
              </div>
              <div className="rounded-full border border-zinc-800 bg-zinc-900 px-3 py-2 text-sm font-semibold text-zinc-200">
                Free member list for venue drops and nightlife alerts
              </div>
            </div>
          )}

          <div className="mt-7 space-y-4">
            {VALUE_POINTS.map(({ icon: Icon, text }) => (
              <div key={text} className="flex items-start gap-3 text-sm leading-7 text-zinc-200 sm:text-base">
                <span className="mt-0.5 inline-flex h-8 w-8 shrink-0 items-center justify-center rounded-full border border-zinc-800 bg-zinc-900">
                  <Icon className="h-4 w-4 text-amber-300" />
                </span>
                <span>{text}</span>
              </div>
            ))}
          </div>
        </div>

        <aside className="rounded-[24px] border border-zinc-200 bg-white p-4 text-zinc-950 shadow-xl shadow-black/20">
          <div className="rounded-[22px] border border-zinc-200 bg-white p-4">
            <div className="flex items-center gap-2 text-xs font-black uppercase tracking-widest text-zinc-500">
              <Users className="h-4 w-4" />
              Free ThaiNight member list
            </div>
            <h3 className="mt-3 text-2xl font-black tracking-tight text-zinc-950">
              Get the next best night in your inbox.
            </h3>
            <p className="mt-2 text-sm leading-6 text-zinc-600">
              Join free for curated venue updates, events, safety notes, and selected city drops.
            </p>

            <form onSubmit={subscribe} className="mt-4 space-y-3">
              <label className="sr-only" htmlFor="home-membership-email">
                Email address
              </label>
              <div className="relative">
                <Mail className="pointer-events-none absolute left-4 top-1/2 h-5 w-5 -translate-y-1/2 text-zinc-400" />
                <input
                  id="home-membership-email"
                  type="email"
                  required
                  value={email}
                  onChange={(event) => setEmail(event.target.value)}
                  placeholder="Type your email..."
                  className="h-16 w-full rounded-2xl border border-zinc-300 bg-white pl-12 pr-4 text-base text-zinc-950 outline-none transition placeholder:text-zinc-400 focus:border-amber-500"
                />
              </div>
              <button
                type="submit"
                disabled={status === "submitting"}
                className="inline-flex h-16 w-full items-center justify-center gap-2 rounded-2xl bg-amber-400 px-5 text-base font-black text-zinc-950 transition hover:bg-amber-300 disabled:cursor-not-allowed disabled:opacity-60"
              >
                {status === "submitting" ? "Joining..." : "Join ThaiNight Free"}
                <ArrowRight className="h-5 w-5" />
              </button>
            </form>

            {message && (
              <p className={`mt-3 text-sm ${status === "success" ? "text-emerald-700" : "text-rose-700"}`}>
                {message}
              </p>
            )}
          </div>
        </aside>
      </div>
    </section>
  );
}
