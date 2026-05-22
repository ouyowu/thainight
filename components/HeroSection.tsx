"use client";

// components/HeroSection.tsx
// City-aware hero with email signup, stats, member avatars
// Compatible with Codex project structure (no external type imports)

import { useState } from "react";
import { ArrowRight, CheckCircle2, Send, Users, TrendingUp, Shield, Star, Moon, Loader2 } from "lucide-react";

const CITY_CONFIG = {
  bangkok: {
    emoji:    "🌃",
    name:     "Bangkok",
    nameThai: "กรุงเทพฯ",
    accent:   "text-amber-400",
    btnBg:    "bg-amber-500 hover:bg-amber-400",
    tagline:  "Tonight plans, people going out, events, price tips, and safety signals across Bangkok nightlife.",
    venueCount: "300+",
    districts: ["Thonglor", "Silom", "Ekkamai", "Asok", "Ari", "RCA", "Sathorn"],
  },
  pattaya: {
    emoji:    "🏖️",
    name:     "Pattaya",
    nameThai: "พัทยา",
    accent:   "text-cyan-400",
    btnBg:    "bg-cyan-500 hover:bg-cyan-400",
    tagline:  "Tonight plans, people going out, events, price checks, and safety signals around Walking Street and beyond.",
    venueCount: "270+",
    districts: ["Walking Street", "Jomtien", "Central Pattaya", "North Pattaya"],
  },
  phuket: {
    emoji:    "🌴",
    name:     "Phuket",
    nameThai: "ภูเก็ต",
    accent:   "text-violet-400",
    btnBg:    "bg-violet-500 hover:bg-violet-400",
    tagline:  "Tonight plans, people going out, beach clubs, Bangla Road events, price tips, and island safety signals.",
    venueCount: "250+",
    districts: ["Patong", "Kata", "Rawai", "Chalong", "Laguna"],
  },
  "chiang-mai": {
    emoji:    "🏔️",
    name:     "Chiang Mai",
    nameThai: "เชียงใหม่",
    accent:   "text-rose-400",
    btnBg:    "bg-rose-500 hover:bg-rose-400",
    tagline:  "Tonight plans, people going out, live music, craft beer, price tips, and relaxed safety signals around Nimman and Old City.",
    venueCount: "250+",
    districts: ["Nimman", "Old City", "Riverside", "Santitham"],
  },
};

// Mock members for avatar wall — replace with real Supabase query in production
const MEMBERS = [
  { initials: "JM", flag: "🇺🇸", color: "#7c3aed" },
  { initials: "ST", flag: "🇯🇵", color: "#0891b2" },
  { initials: "MD", flag: "🇫🇷", color: "#059669" },
  { initials: "AK", flag: "🇩🇪", color: "#d97706" },
  { initials: "TB", flag: "🇬🇧", color: "#dc2626" },
  { initials: "PS", flag: "🇮🇳", color: "#7c3aed" },
  { initials: "CR", flag: "🇧🇷", color: "#059669" },
];

interface HeroSectionProps {
  city: keyof typeof CITY_CONFIG;
}

export default function HeroSection({ city }: HeroSectionProps) {
  const cfg = CITY_CONFIG[city] ?? CITY_CONFIG.bangkok;

  const [email,     setEmail]     = useState("");
  const [loading,   setLoading]   = useState(false);
  const [submitted, setSubmitted] = useState(false);
  const [error,     setError]     = useState<string | null>(null);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!email.includes("@")) return;
    setLoading(true);
    setError(null);
    try {
      const res = await fetch("/api/subscribe", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email, city }),
      });
      if (!res.ok) throw new Error("Subscription failed");
      setSubmitted(true);
    } catch {
      setError("Something went wrong. Please try again.");
    } finally {
      setLoading(false);
    }
  }

  return (
    <section className="relative overflow-hidden bg-zinc-950 border-b border-zinc-800/40">
      {/* Ambient glow */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-0 left-1/4 w-96 h-64 bg-amber-500/3 rounded-full blur-3xl" />
        <div className="absolute top-10 right-1/4 w-64 h-64 bg-violet-500/3 rounded-full blur-3xl" />
      </div>

      <div className="relative max-w-7xl mx-auto px-4 py-12">
        <div className="grid lg:grid-cols-[1fr_360px] gap-10 items-start">

          {/* ── Left ── */}
          <div>
            {/* Trust badge */}
            <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-zinc-800/60 border border-zinc-700/40 text-xs text-zinc-400 mb-5">
              <TrendingUp className="w-3.5 h-3.5 text-amber-400" />
              Thailand&apos;s only verified nightlife intelligence platform
            </div>

            {/* Headline */}
            <div className="flex items-center gap-3 mb-2">
              <span className="text-4xl">{cfg.emoji}</span>
              <h1 className="text-4xl md:text-5xl font-black tracking-tight leading-tight">
                <span className="text-white">{cfg.name}</span>
                <br />
                <span className={cfg.accent}>Nightlife.</span>
              </h1>
            </div>
            <p className="text-zinc-400 text-sm mb-2 ml-1">{cfg.nameThai}</p>
            <p className="text-zinc-300 text-base leading-relaxed mb-6 max-w-xl">
              {cfg.tagline}
            </p>

            {/* District pills */}
            <div className="flex flex-wrap gap-2 mb-7">
              {cfg.districts.map((d) => (
                <span
                  key={d}
                  className="px-2.5 py-1 bg-zinc-800/60 border border-zinc-700/40 rounded-full text-xs text-zinc-400"
                >
                  {d}
                </span>
              ))}
            </div>

            {/* Tonight action structure */}
            <div className="grid sm:grid-cols-2 gap-2.5 mb-8">
              {[
                { icon: Moon,        text: "Tonight: where to go before midnight" },
                { icon: Users,       text: "People: solo travelers and social plans" },
                { icon: Star,        text: "Events: flyers, club nights, openings" },
                { icon: Shield,      text: "Safety: fees, scams, transport notes" },
              ].map(({ icon: Icon, text }) => (
                <div key={text} className="flex items-center gap-2.5 text-sm text-zinc-400">
                  <Icon className="w-4 h-4 text-amber-400 shrink-0" />
                  {text}
                </div>
              ))}
            </div>

            {/* Stats */}
            <div className="grid grid-cols-4 gap-3">
              {[
                { value: cfg.venueCount, label: "Venues" },
                { value: "4,200+",       label: "Telegram Members" },
                { value: "Free",         label: "Always" },
                { value: "May 2026",     label: "Last Updated" },
              ].map(({ value, label }) => (
                <div key={label} className="p-3 bg-zinc-900/60 border border-zinc-800/60 rounded-xl">
                  <div className="text-lg font-black font-mono text-white">{value}</div>
                  <div className="text-[10px] text-zinc-500 mt-0.5">{label}</div>
                </div>
              ))}
            </div>
          </div>

          {/* ── Right: Signup Card ── */}
          <div className="lg:pt-2">
            <div className="relative overflow-hidden rounded-2xl bg-zinc-900/80 border border-zinc-700/60 p-6">
              <div className="absolute -top-16 -right-16 w-48 h-48 bg-amber-500/4 rounded-full blur-3xl pointer-events-none" />

              {/* Live indicator */}
              <div className="flex items-center gap-2 mb-4">
                <span className="relative flex h-2.5 w-2.5">
                  <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75" />
                  <span className="relative inline-flex rounded-full h-2.5 w-2.5 bg-emerald-500" />
                </span>
                <span className="text-xs text-emerald-400 font-semibold">4,200+ members in community</span>
              </div>

              {/* Member count banner */}
              <div className="flex items-center gap-2 px-3 py-2 rounded-xl border border-amber-500/20 bg-amber-500/5 mb-4">
                <Users className="w-3.5 h-3.5 text-amber-400 shrink-0" />
                <span className="text-xs font-bold text-amber-400">4,200 members</span>
                <span className="text-zinc-600 text-xs">+</span>
                <span className="text-xs font-bold text-emerald-400">618 joined this month</span>
              </div>

              {/* Avatar stack */}
              <div className="flex items-center gap-3 mb-5">
                <div className="flex -space-x-2">
                  {MEMBERS.map((m) => (
                    <div
                      key={m.initials}
                      className="relative w-8 h-8 rounded-full border-2 border-zinc-900 flex items-center justify-center text-[10px] font-bold text-white shrink-0"
                      style={{ background: m.color }}
                    >
                      {m.initials}
                      <span className="absolute -bottom-0.5 -right-0.5 text-[9px] leading-none">{m.flag}</span>
                    </div>
                  ))}
                </div>
                <span className="text-xs text-zinc-500">Verified this week</span>
              </div>

              {/* Mode tabs */}
              <div className="flex rounded-xl bg-zinc-800/60 p-1 mb-4">
                <button className="flex-1 py-2 rounded-lg text-xs font-semibold bg-zinc-700 text-white">
                  Sign In / Join
                </button>
                <button className="flex-1 py-2 rounded-lg text-xs font-semibold text-zinc-500 hover:text-zinc-300 transition-colors">
                  Newsletter Only
                </button>
              </div>

              {/* Google + Apple */}
              <div className="space-y-2.5 mb-4">
                <button
                  onClick={() => {
                    // Supabase OAuth — configure in Dashboard
                    // import { createClient } from "@/lib/supabase/client"
                    // createClient().auth.signInWithOAuth({ provider: "google", options: { redirectTo: "/auth/callback" } })
                    alert("Configure Google OAuth in Supabase Dashboard → Authentication → Providers → Google");
                  }}
                  className="w-full flex items-center justify-center gap-3 h-11 rounded-xl bg-white hover:bg-zinc-100 text-zinc-900 font-semibold text-sm border border-zinc-200 transition-colors"
                >
                  <svg width="18" height="18" viewBox="0 0 18 18">
                    <path fill="#4285F4" d="M17.64 9.2c0-.637-.057-1.251-.164-1.84H9v3.481h4.844a4.14 4.14 0 0 1-1.796 2.716v2.259h2.908c1.702-1.567 2.684-3.875 2.684-6.615Z"/>
                    <path fill="#34A853" d="M9 18c2.43 0 4.467-.806 5.956-2.18l-2.908-2.259c-.806.54-1.837.86-3.048.86-2.344 0-4.328-1.584-5.036-3.711H.957v2.332A8.997 8.997 0 0 0 9 18Z"/>
                    <path fill="#FBBC05" d="M3.964 10.71A5.41 5.41 0 0 1 3.682 9c0-.593.102-1.17.282-1.71V4.958H.957A8.996 8.996 0 0 0 0 9c0 1.452.348 2.827.957 4.042l3.007-2.332Z"/>
                    <path fill="#EA4335" d="M9 3.58c1.321 0 2.508.454 3.44 1.345l2.582-2.58C13.463.891 11.426 0 9 0A8.997 8.997 0 0 0 .957 4.958L3.964 6.29C4.672 4.163 6.656 3.58 9 3.58Z"/>
                  </svg>
                  Continue with Google
                </button>

                <button
                  onClick={() => {
                    alert("Configure Apple OAuth in Supabase Dashboard → Authentication → Providers → Apple");
                  }}
                  className="w-full flex items-center justify-center gap-3 h-11 rounded-xl bg-zinc-900 hover:bg-zinc-800 text-white font-semibold text-sm border border-zinc-700 transition-colors"
                >
                  <svg width="14" height="17" viewBox="0 0 814 1000" fill="white">
                    <path d="M788.1 340.9c-5.8 4.5-108.2 62.2-108.2 190.5 0 148.4 130.3 200.9 134.2 202.2-.6 3.2-20.7 71.9-68.7 141.9-42.8 61.6-87.5 123.1-155.5 123.1s-85.5-39.5-164-39.5c-76.5 0-103.7 40.8-165.9 40.8s-105.3-57.4-155.5-127.4C62.3 783 0 634.5 0 486.3 0 310.1 114.3 217 226.7 217c59.5 0 109 38.8 146.5 38.8 35.5 0 91.4-41.1 159.5-41.1 25.4 0 108.2 2.6 168.5 79.7zm-140.4-130.6c25.4-30.4 43.5-72.2 43.5-114 0-5.8-.6-11.6-1.3-16.7-41.4 1.9-90.3 27.5-119.4 60.4-22.4 25.1-43.9 65.8-43.9 108.4 0 6.4.6 12.9 1.9 18 3.2.6 8.4 1.3 13.6 1.3 37.4 0 84.9-24.2 105.6-57.4z"/>
                  </svg>
                  Continue with Apple
                </button>
              </div>

              {/* Divider */}
              <div className="flex items-center gap-3 mb-4">
                <div className="flex-1 h-px bg-zinc-800" />
                <span className="text-xs text-zinc-600">or email</span>
                <div className="flex-1 h-px bg-zinc-800" />
              </div>

              {/* Email form */}
              {error && (
                <div className="mb-3 px-3 py-2 rounded-lg bg-red-500/10 border border-red-500/20 text-red-400 text-xs">
                  {error}
                </div>
              )}

              {submitted ? (
                <div className="flex items-center gap-2 py-3 text-emerald-400 text-sm">
                  <CheckCircle2 className="w-4 h-4 shrink-0" />
                  You&apos;re in. Check your inbox!
                </div>
              ) : (
                <form onSubmit={handleSubmit} className="space-y-2.5">
                  <input
                    type="email"
                    placeholder="your@email.com"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                    className="w-full h-11 px-4 rounded-xl bg-zinc-800 border border-zinc-700 text-white text-sm placeholder:text-zinc-500 focus:outline-none focus:border-amber-500/60 transition-colors"
                  />
                  <button
                    type="submit"
                    disabled={loading}
                    className={`w-full h-11 rounded-xl ${cfg.btnBg} disabled:opacity-60 text-zinc-950 font-bold text-sm flex items-center justify-center gap-2 transition-colors`}
                  >
                    {loading
                      ? <Loader2 className="w-4 h-4 animate-spin" />
                      : <>Get Access <ArrowRight className="w-4 h-4" /></>
                    }
                  </button>
                </form>
              )}

              <p className="text-center text-[10px] text-zinc-600 mt-3">
                Free forever · No spam · No paywalls
              </p>

              {/* Telegram upsell */}
              <a
                href="https://t.me/ThainightTelegram"
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center gap-2.5 mt-4 pt-4 border-t border-zinc-800/60 group"
              >
                <div className="w-8 h-8 rounded-lg bg-[#2AABEE]/10 border border-[#2AABEE]/20 flex items-center justify-center shrink-0">
                  <Send className="w-3.5 h-3.5 text-[#2AABEE]" />
                </div>
                <div className="flex-1">
                  <p className="text-xs font-semibold text-white group-hover:text-[#2AABEE] transition-colors">
                    Prefer Telegram?
                  </p>
                  <p className="text-[10px] text-zinc-500">4,200+ members · Raid alerts · Free</p>
                </div>
                <ArrowRight className="w-3.5 h-3.5 text-zinc-600 group-hover:text-[#2AABEE] transition-colors" />
              </a>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
