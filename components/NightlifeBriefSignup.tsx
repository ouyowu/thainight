"use client";

import { FormEvent, useState } from "react";
import { Mail, Send } from "lucide-react";

type Props = {
  cityName?: string;
  citySlug?: string;
  compact?: boolean;
};

export function NightlifeBriefSignup({ cityName, citySlug, compact = false }: Props) {
  const [email, setEmail] = useState("");
  const [status, setStatus] = useState<"idle" | "sending" | "done" | "error">("idle");
  const telegramUrl = process.env.NEXT_PUBLIC_TELEGRAM_URL;

  async function onSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    if (!email.trim()) return;

    setStatus("sending");
    try {
      const response = await fetch("/api/subscribe", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ email, city: citySlug ?? cityName ?? "thainight" }),
      });
      setStatus(response.ok ? "done" : "error");
      if (response.ok) setEmail("");
    } catch {
      setStatus("error");
    }
  }

  return (
    <section
      className={`overflow-hidden rounded-3xl border border-amber-300/20 bg-[linear-gradient(135deg,rgba(24,24,27,0.98),rgba(88,28,135,0.32)),radial-gradient(circle_at_85%_10%,rgba(251,191,36,0.22),transparent_38%)] ${
        compact ? "p-5" : "p-6 sm:p-8"
      }`}
    >
      <div className="grid gap-5 lg:grid-cols-[1fr_1.05fr] lg:items-end">
        <div>
          <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-amber-200">
            <Mail className="h-4 w-4" />
            Nightlife brief
          </p>
          <h2 className={`${compact ? "mt-2 text-2xl" : "mt-3 text-3xl sm:text-4xl"} font-black tracking-tight text-white`}>
            Get the useful stuff before going out
          </h2>
          <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-300">
            Tonight events, approved offers, late-entry fees, safety warnings, and new opening signals for
            {cityName ? ` ${cityName}` : " Thailand nightlife"}.
          </p>
        </div>

        <div className="space-y-3">
          <form onSubmit={onSubmit} className="grid gap-3 sm:grid-cols-[1fr_auto]">
            <input
              type="email"
              value={email}
              onChange={(event) => setEmail(event.target.value)}
              placeholder="you@example.com"
              className="min-h-12 rounded-2xl border border-white/10 bg-black/35 px-4 text-sm text-white outline-none transition placeholder:text-zinc-500 focus:border-amber-300/60"
            />
            <button
              type="submit"
              disabled={status === "sending"}
              className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl bg-amber-300 px-5 text-sm font-black text-zinc-950 transition hover:bg-amber-200 disabled:cursor-not-allowed disabled:opacity-60"
            >
              <Send className="h-4 w-4" />
              {status === "sending" ? "Saving" : "Subscribe"}
            </button>
          </form>

          <div className="flex flex-wrap items-center gap-3 text-xs text-zinc-400">
            <span>
              {status === "done"
                ? "Saved. You are on the ThaiNight brief list."
                : status === "error"
                  ? "Could not save right now. Please try again."
                  : "No spam. Built for travelers checking tonight before they leave."}
            </span>
            {telegramUrl ? (
              <a
                href={telegramUrl}
                target="_blank"
                rel="noreferrer"
                className="font-bold text-amber-200 underline decoration-amber-200/30 underline-offset-4 hover:text-amber-100"
              >
                Join Telegram
              </a>
            ) : (
              <span className="text-zinc-500">Telegram channel can be added when ready.</span>
            )}
          </div>
        </div>
      </div>
    </section>
  );
}
