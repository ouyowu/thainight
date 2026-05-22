"use client";

import { useState } from "react";
import { BadgePercent, CalendarDays, Send, UploadCloud } from "lucide-react";

type SubmissionKind = "event" | "offer";

const CITY_OPTIONS = ["bangkok", "chiang-mai", "pattaya", "phuket"];

export function IntelSubmissionPanel() {
  const [kind, setKind] = useState<SubmissionKind>("event");
  const [status, setStatus] = useState<"idle" | "sending" | "success" | "error">("idle");
  const [message, setMessage] = useState("");

  async function handleSubmit(formData: FormData) {
    setStatus("sending");
    setMessage("");

    const payload = {
      kind,
      city: formData.get("city"),
      title: formData.get("title"),
      description: formData.get("description"),
      venue_slug: formData.get("venue_slug"),
      image_url: formData.get("image_url"),
      source_url: formData.get("source_url"),
      event_date: formData.get("event_date"),
      offer_label: formData.get("offer_label"),
      valid_from: formData.get("valid_from"),
      valid_until: formData.get("valid_until"),
      submitter_name: formData.get("submitter_name"),
      submitter_email: formData.get("submitter_email"),
    };

    try {
      const response = await fetch("/api/intel-submissions", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });

      const body = (await response.json()) as { error?: string };
      if (!response.ok) {
        setStatus("error");
        setMessage(body.error ?? "Submission failed.");
        return;
      }

      setStatus("success");
      setMessage("Submitted for ThaiNight review.");
    } catch {
      setStatus("error");
      setMessage("Network error. Please try again.");
    }
  }

  return (
    <section className="overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-950">
      <div className="grid lg:grid-cols-[0.92fr_1.08fr]">
        <div className="border-b border-zinc-800 bg-[linear-gradient(135deg,rgba(244,63,94,0.18),rgba(9,9,11,0.95))] p-6 sm:p-8 lg:border-b-0 lg:border-r">
          <p className="inline-flex items-center gap-2 text-xs font-bold uppercase tracking-widest text-rose-300">
            <UploadCloud className="h-4 w-4" />
            Submit nightlife intel
          </p>
          <h2 className="mt-4 text-3xl font-black tracking-tight text-white">
            Send us a flyer or a deal before it disappears
          </h2>
          <p className="mt-4 max-w-xl text-sm leading-7 text-zinc-300">
            Event posters, happy-hour graphics, free-entry nights, and one-off venue promos all enter a review queue before reaching the homepage.
          </p>
          <div className="mt-6 flex flex-wrap gap-2">
            <button
              type="button"
              onClick={() => setKind("event")}
              className={`inline-flex min-h-11 items-center gap-2 rounded-full px-4 py-2 text-sm font-bold transition ${
                kind === "event"
                  ? "bg-rose-500 text-white"
                  : "border border-white/10 bg-black/30 text-zinc-300 hover:border-white/25"
              }`}
            >
              <CalendarDays className="h-4 w-4" />
              Event flyer
            </button>
            <button
              type="button"
              onClick={() => setKind("offer")}
              className={`inline-flex min-h-11 items-center gap-2 rounded-full px-4 py-2 text-sm font-bold transition ${
                kind === "offer"
                  ? "bg-pink-500 text-white"
                  : "border border-white/10 bg-black/30 text-zinc-300 hover:border-white/25"
              }`}
            >
              <BadgePercent className="h-4 w-4" />
              Special offer
            </button>
          </div>
        </div>

        <form action={handleSubmit} className="grid gap-4 p-6 sm:p-8 md:grid-cols-2">
          <label className="grid gap-2 text-sm text-zinc-300">
            City
            <select name="city" required className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none focus:border-rose-400/70">
              {CITY_OPTIONS.map((city) => (
                <option key={city} value={city}>
                  {city}
                </option>
              ))}
            </select>
          </label>

          <label className="grid gap-2 text-sm text-zinc-300">
            Venue slug
            <input name="venue_slug" placeholder="optional" className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none placeholder:text-zinc-600 focus:border-rose-400/70" />
          </label>

          <label className="grid gap-2 text-sm text-zinc-300 md:col-span-2">
            Title
            <input name="title" required placeholder={kind === "event" ? "Friday DJ night at..." : "Happy hour until 10 PM"} className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none placeholder:text-zinc-600 focus:border-rose-400/70" />
          </label>

          <label className="grid gap-2 text-sm text-zinc-300 md:col-span-2">
            Description
            <textarea name="description" rows={4} placeholder="What should people know?" className="rounded-2xl border border-zinc-800 bg-zinc-900 px-4 py-3 text-white outline-none placeholder:text-zinc-600 focus:border-rose-400/70" />
          </label>

          <label className="grid gap-2 text-sm text-zinc-300 md:col-span-2">
            Flyer / image URL
            <input name="image_url" placeholder="https://..." className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none placeholder:text-zinc-600 focus:border-rose-400/70" />
          </label>

          <label className="grid gap-2 text-sm text-zinc-300 md:col-span-2">
            Source post URL
            <input name="source_url" placeholder="Instagram, Facebook, Telegram, or website link" className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none placeholder:text-zinc-600 focus:border-rose-400/70" />
          </label>

          {kind === "event" ? (
            <label className="grid gap-2 text-sm text-zinc-300">
              Event date
              <input type="datetime-local" name="event_date" className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none focus:border-rose-400/70" />
            </label>
          ) : (
            <>
              <label className="grid gap-2 text-sm text-zinc-300">
                Offer label
                <input name="offer_label" placeholder="BOGO / Free Entry" className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none placeholder:text-zinc-600 focus:border-rose-400/70" />
              </label>
              <label className="grid gap-2 text-sm text-zinc-300">
                Valid from
                <input type="datetime-local" name="valid_from" className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none focus:border-rose-400/70" />
              </label>
              <label className="grid gap-2 text-sm text-zinc-300">
                Valid until
                <input type="datetime-local" name="valid_until" className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none focus:border-rose-400/70" />
              </label>
            </>
          )}

          <label className="grid gap-2 text-sm text-zinc-300">
            Your name
            <input name="submitter_name" placeholder="optional" className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none placeholder:text-zinc-600 focus:border-rose-400/70" />
          </label>

          <label className="grid gap-2 text-sm text-zinc-300">
            Your email
            <input type="email" name="submitter_email" placeholder="optional" className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none placeholder:text-zinc-600 focus:border-rose-400/70" />
          </label>

          <div className="flex flex-col gap-3 md:col-span-2 md:flex-row md:items-center md:justify-between">
            <p className={`text-sm ${status === "error" ? "text-rose-300" : status === "success" ? "text-emerald-300" : "text-zinc-500"}`}>
              {message || "Uploads are reviewed before publication."}
            </p>
            <button
              type="submit"
              disabled={status === "sending"}
              className="inline-flex min-h-12 items-center justify-center gap-2 rounded-2xl bg-rose-500 px-5 py-3 text-sm font-black text-white transition hover:bg-rose-400 disabled:cursor-not-allowed disabled:opacity-60"
            >
              <Send className="h-4 w-4" />
              {status === "sending" ? "Submitting..." : "Submit for review"}
            </button>
          </div>
        </form>
      </div>
    </section>
  );
}
