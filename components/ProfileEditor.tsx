"use client";

import { useMemo, useState } from "react";
import type { ProfileRow } from "@/lib/database.types";

type Props = {
  initialProfile: ProfileRow | null;
};

const CITY_OPTIONS = ["bangkok", "chiang-mai", "pattaya", "phuket"];
const TRAVELER_TYPES = ["Solo Traveler", "Digital Nomad", "Local Explorer", "Couple", "Nightlife Regular"];
const PERSONA_TAGS = ["Techno", "Cocktails", "Rooftops", "Live Music", "Date Night", "Social Tables", "Hidden Bars", "Afterhours"];
const LANGUAGE_OPTIONS = ["English", "Korean", "Japanese", "Chinese", "Thai", "French"];

export function ProfileEditor({ initialProfile }: Props) {
  const [form, setForm] = useState({
    display_name: initialProfile?.display_name ?? "",
    bio: initialProfile?.bio ?? "",
    ig_handle: initialProfile?.ig_handle ?? "",
    current_city: initialProfile?.current_city ?? "bangkok",
    traveler_type: initialProfile?.traveler_type ?? TRAVELER_TYPES[0],
    home_country: initialProfile?.home_country ?? "",
    visit_window_start: initialProfile?.visit_window_start ?? "",
    visit_window_end: initialProfile?.visit_window_end ?? "",
    languages_spoken: initialProfile?.languages_spoken ?? ["English"],
    interests: initialProfile?.interests ?? [],
    persona_tags: initialProfile?.persona_tags ?? [],
  });
  const [status, setStatus] = useState<"idle" | "saving" | "saved" | "error">("idle");

  const selectedLanguages = useMemo(() => new Set(form.languages_spoken), [form.languages_spoken]);
  const selectedPersonas = useMemo(() => new Set(form.persona_tags), [form.persona_tags]);

  function toggleList(field: "languages_spoken" | "persona_tags", value: string) {
    setForm((current) => {
      const existing = new Set(current[field]);
      if (existing.has(value)) existing.delete(value);
      else existing.add(value);
      return { ...current, [field]: Array.from(existing) };
    });
  }

  async function saveProfile(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setStatus("saving");
    const response = await fetch("/api/profile", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(form),
    });
    setStatus(response.ok ? "saved" : "error");
  }

  return (
    <form onSubmit={saveProfile} className="grid gap-5 rounded-[28px] border border-zinc-800 bg-zinc-950 p-5 sm:p-6 lg:grid-cols-2">
      <div className="space-y-5">
        <div>
          <p className="text-xs font-black uppercase tracking-widest text-rose-300">Traveler profile</p>
          <h1 className="mt-2 text-3xl font-black tracking-tight text-white">Build your nightlife passport</h1>
          <p className="mt-3 text-sm leading-7 text-zinc-400">
            This powers overlap matching, meetup quality, and the future ThaiNight Pass layer.
          </p>
        </div>

        <label className="grid gap-2 text-sm text-zinc-300">
          Display name
          <input value={form.display_name} onChange={(event) => setForm((current) => ({ ...current, display_name: event.target.value }))} className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none focus:border-rose-400/70" />
        </label>

        <label className="grid gap-2 text-sm text-zinc-300">
          Bio
          <textarea value={form.bio} onChange={(event) => setForm((current) => ({ ...current, bio: event.target.value }))} rows={4} className="rounded-2xl border border-zinc-800 bg-zinc-900 px-4 py-3 text-white outline-none focus:border-rose-400/70" />
        </label>

        <div className="grid gap-4 sm:grid-cols-2">
          <label className="grid gap-2 text-sm text-zinc-300">
            Current city
            <select value={form.current_city} onChange={(event) => setForm((current) => ({ ...current, current_city: event.target.value }))} className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none focus:border-rose-400/70">
              {CITY_OPTIONS.map((city) => <option key={city} value={city}>{city}</option>)}
            </select>
          </label>
          <label className="grid gap-2 text-sm text-zinc-300">
            Traveler type
            <select value={form.traveler_type} onChange={(event) => setForm((current) => ({ ...current, traveler_type: event.target.value }))} className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none focus:border-rose-400/70">
              {TRAVELER_TYPES.map((type) => <option key={type} value={type}>{type}</option>)}
            </select>
          </label>
        </div>
      </div>

      <div className="space-y-5">
        <div className="grid gap-4 sm:grid-cols-2">
          <label className="grid gap-2 text-sm text-zinc-300">
            Home country
            <input value={form.home_country} onChange={(event) => setForm((current) => ({ ...current, home_country: event.target.value }))} className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none focus:border-rose-400/70" />
          </label>
          <label className="grid gap-2 text-sm text-zinc-300">
            Instagram
            <input value={form.ig_handle} onChange={(event) => setForm((current) => ({ ...current, ig_handle: event.target.value }))} placeholder="@handle" className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none placeholder:text-zinc-600 focus:border-rose-400/70" />
          </label>
        </div>

        <div className="grid gap-4 sm:grid-cols-2">
          <label className="grid gap-2 text-sm text-zinc-300">
            In town from
            <input type="date" value={form.visit_window_start} onChange={(event) => setForm((current) => ({ ...current, visit_window_start: event.target.value }))} className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none focus:border-rose-400/70" />
          </label>
          <label className="grid gap-2 text-sm text-zinc-300">
            Until
            <input type="date" value={form.visit_window_end} onChange={(event) => setForm((current) => ({ ...current, visit_window_end: event.target.value }))} className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none focus:border-rose-400/70" />
          </label>
        </div>

        <div>
          <p className="text-sm text-zinc-300">Languages</p>
          <div className="mt-2 flex flex-wrap gap-2">
            {LANGUAGE_OPTIONS.map((language) => (
              <button key={language} type="button" onClick={() => toggleList("languages_spoken", language)} className={`rounded-full px-3 py-2 text-sm font-bold transition ${selectedLanguages.has(language) ? "bg-rose-500 text-white" : "border border-zinc-800 bg-zinc-900 text-zinc-300"}`}>
                {language}
              </button>
            ))}
          </div>
        </div>

        <div>
          <p className="text-sm text-zinc-300">Nightlife persona</p>
          <div className="mt-2 flex flex-wrap gap-2">
            {PERSONA_TAGS.map((tag) => (
              <button key={tag} type="button" onClick={() => toggleList("persona_tags", tag)} className={`rounded-full px-3 py-2 text-sm font-bold transition ${selectedPersonas.has(tag) ? "bg-amber-400 text-zinc-950" : "border border-zinc-800 bg-zinc-900 text-zinc-300"}`}>
                {tag}
              </button>
            ))}
          </div>
        </div>

        <div className="flex items-center justify-between gap-3">
          <p className={`text-sm ${status === "saved" ? "text-emerald-300" : status === "error" ? "text-rose-300" : "text-zinc-500"}`}>
            {status === "saved" ? "Profile saved." : status === "error" ? "Could not save profile." : "Your profile powers overlap matching."}
          </p>
          <button type="submit" disabled={status === "saving"} className="inline-flex min-h-12 items-center rounded-2xl bg-rose-500 px-5 py-3 text-sm font-black text-white hover:bg-rose-400 disabled:opacity-60">
            {status === "saving" ? "Saving..." : "Save profile"}
          </button>
        </div>
      </div>
    </form>
  );
}
