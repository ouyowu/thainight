import type { Metadata } from "next";
import Link from "next/link";
import { ArrowRight, MapPin, Sparkles, Users } from "lucide-react";
import { SiteFooter } from "@/components/SiteFooter";

export const metadata: Metadata = {
  title: "About ThaiNight | Thailand Nightlife Social Guide [Updated May 2026]",
  description:
    "ThaiNight is a Thailand nightlife guide for venues, events, happy hours, and people going out tonight in Bangkok, Phuket, Pattaya, and Chiang Mai.",
  alternates: { canonical: "/about" },
};

export default function AboutPage() {
  return (
    <main className="mx-auto flex min-h-screen max-w-5xl flex-col gap-8 px-4 py-6 sm:px-6 lg:px-8">
      <section className="rounded-3xl border border-zinc-800 bg-zinc-950 p-6 sm:p-8">
        <p className="text-xs font-black uppercase tracking-widest text-rose-300">About ThaiNight</p>
        <h1 className="mt-4 text-4xl font-black tracking-tight text-white sm:text-5xl">
          A nightlife guide built around places, events, and who is going out tonight.
        </h1>
        <p className="mt-5 max-w-3xl text-base leading-8 text-zinc-300">
          ThaiNight helps travelers, expats, and local nightlife seekers discover Thailand&apos;s bars, clubs, rooftop venues, live music rooms, happy hours, and fresh event flyers. The social layer is the difference: users can mark interest, find overlap, and start lightweight table-partner plans.
        </p>
      </section>

      <section className="grid gap-4 md:grid-cols-3">
        {[
          { icon: MapPin, title: "Venue intelligence", body: "Structured city and category pages for Bangkok, Phuket, Pattaya, and Chiang Mai." },
          { icon: Sparkles, title: "Live nightlife culture", body: "Events, offers, flyers, social signals, and freshness tags updated for May 2026." },
          { icon: Users, title: "Free early access", body: "ThaiNight Pass is free during beta while we learn from real member behavior." },
        ].map(({ icon: Icon, title, body }) => (
          <div key={title} className="rounded-2xl border border-zinc-800 bg-zinc-950 p-5">
            <Icon className="h-5 w-5 text-rose-300" />
            <h2 className="mt-4 text-lg font-black text-white">{title}</h2>
            <p className="mt-3 text-sm leading-7 text-zinc-400">{body}</p>
          </div>
        ))}
      </section>

      <Link href="/" className="inline-flex w-fit items-center gap-2 rounded-full bg-white px-5 py-3 text-sm font-black text-zinc-950">
        Back to ThaiNight
        <ArrowRight className="h-4 w-4" />
      </Link>
      <SiteFooter />
    </main>
  );
}
