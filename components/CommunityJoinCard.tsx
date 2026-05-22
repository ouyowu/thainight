"use client";

import { useEffect, useMemo, useState } from "react";
import { ArrowRight, KeyRound, Mail, ShieldCheck, Users } from "lucide-react";
import { createClient } from "@/lib/supabase/client";
import {
  formatCommunityStats,
  getCommunityStats,
  type CommunityStats,
} from "@/lib/community";

type SubscribeState = "idle" | "submitting" | "success" | "error";

function getRedirectTo(): string {
  return `${window.location.origin}/auth/callback?next=/bangkok`;
}

export function CommunityJoinCard() {
  const initialStats = useMemo(() => getCommunityStats(), []);
  const [stats, setStats] = useState<CommunityStats>(initialStats);
  const [email, setEmail] = useState("");
  const [status, setStatus] = useState<SubscribeState>("idle");
  const [message, setMessage] = useState("");

  useEffect(() => {
    const timer = window.setInterval(() => setStats(getCommunityStats()), 60000);
    return () => window.clearInterval(timer);
  }, []);

  async function signInWithProvider(provider: "google" | "apple") {
    setMessage("");

    try {
      const supabase = createClient();
      const { error } = await supabase.auth.signInWithOAuth({
        provider,
        options: {
          redirectTo: getRedirectTo(),
        },
      });

      if (error) {
        setStatus("error");
        setMessage(error.message);
      }
    } catch {
      setStatus("error");
      setMessage("Supabase Auth is not configured yet.");
    }
  }

  async function submitNewsletter(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setStatus("submitting");
    setMessage("");

    try {
      const response = await fetch("/api/newsletter", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email }),
      });
      const body = (await response.json()) as { message?: string; error?: string };

      if (!response.ok) {
        setStatus("error");
        setMessage(body.error ?? "Could not subscribe this email.");
        return;
      }

      setStatus("success");
      setMessage(body.message ?? "You're on the Bangkok nightlife list.");
      setEmail("");
    } catch {
      setStatus("error");
      setMessage("Newsletter signup is temporarily unavailable.");
    }
  }

  return (
    <section className="w-full rounded-lg border border-zinc-800 bg-zinc-900/70 p-4 shadow-2xl shadow-black/30 sm:p-6">
      <div className="mb-5 flex items-center justify-center gap-2 rounded-lg border border-amber-500/40 bg-amber-500/10 px-3 py-2 text-center text-lg font-black text-amber-300 sm:text-2xl">
        <Users className="size-5 shrink-0" aria-hidden />
        <span>{formatCommunityStats(stats)}</span>
      </div>

      <div className="grid gap-3 sm:grid-cols-2">
        <button
          type="button"
          onClick={() => signInWithProvider("google")}
          className="inline-flex min-h-11 items-center justify-center gap-2 rounded-lg border border-zinc-700 bg-zinc-950 px-4 text-sm font-semibold text-white transition hover:border-amber-400/60 hover:bg-zinc-900"
        >
          <KeyRound className="size-4 text-amber-300" aria-hidden />
          Continue with Google
        </button>
        <button
          type="button"
          onClick={() => signInWithProvider("apple")}
          className="inline-flex min-h-11 items-center justify-center gap-2 rounded-lg border border-zinc-700 bg-zinc-950 px-4 text-sm font-semibold text-white transition hover:border-amber-400/60 hover:bg-zinc-900"
        >
          <ShieldCheck className="size-4 text-emerald-300" aria-hidden />
          Continue with Apple
        </button>
      </div>

      <form onSubmit={submitNewsletter} className="mt-4 space-y-3">
        <label className="sr-only" htmlFor="newsletter-email">
          Email address
        </label>
        <div className="flex flex-col gap-3 sm:flex-row">
          <div className="relative flex-1">
            <Mail
              className="pointer-events-none absolute left-4 top-1/2 size-5 -translate-y-1/2 text-zinc-500"
              aria-hidden
            />
            <input
              id="newsletter-email"
              type="email"
              required
              value={email}
              onChange={(event) => setEmail(event.target.value)}
              placeholder="Type your email..."
              className="min-h-14 w-full rounded-lg border-2 border-zinc-700 bg-zinc-950 py-3 pl-12 pr-4 text-base text-white outline-none transition placeholder:text-zinc-500 focus:border-amber-400"
            />
          </div>
          <button
            type="submit"
            disabled={status === "submitting"}
            className="inline-flex min-h-14 items-center justify-center gap-2 rounded-lg bg-amber-500 px-6 text-base font-black text-zinc-950 transition hover:bg-amber-300 disabled:cursor-not-allowed disabled:opacity-60"
          >
            Join
            <ArrowRight className="size-5" aria-hidden />
          </button>
        </div>
      </form>

      {message && (
        <p
          className={`mt-3 text-sm ${
            status === "success" ? "text-emerald-300" : "text-rose-300"
          }`}
        >
          {message}
        </p>
      )}
    </section>
  );
}
