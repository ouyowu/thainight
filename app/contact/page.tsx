import type { Metadata } from "next";
import { Mail, Megaphone, Sparkles } from "lucide-react";
import { SiteFooter } from "@/components/SiteFooter";

export const metadata: Metadata = {
  title: "Contact ThaiNight | Venue Advertising & Partnerships [Updated May 2026]",
  description:
    "Contact ThaiNight for venue advertising, featured listings, special offers, event flyers, reservation systems, and Thailand nightlife partnerships.",
  alternates: { canonical: "/contact" },
};

export default function ContactPage() {
  return (
    <main className="mx-auto flex min-h-screen max-w-5xl flex-col gap-8 px-4 py-6 sm:px-6 lg:px-8">
      <section className="rounded-3xl border border-zinc-800 bg-zinc-950 p-6 sm:p-8">
        <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-rose-300">
          <Megaphone className="h-4 w-4" />
          Venue partnerships
        </p>
        <h1 className="mt-4 text-4xl font-black tracking-tight text-white sm:text-5xl">
          Work with ThaiNight on advertising, offers, events, and booking systems.
        </h1>
        <p className="mt-5 max-w-3xl text-base leading-8 text-zinc-300">
          Bar, club, lounge, and event operators can reach out for featured placement, flyer promotion, happy hour visibility, table booking workflows, or custom nightlife reservation systems.
        </p>
        <a
          href="mailto:ouyowu@gmail.com?subject=ThaiNight%20venue%20partnership"
          className="mt-6 inline-flex min-h-12 items-center gap-2 rounded-full bg-white px-5 text-sm font-black text-zinc-950"
        >
          <Mail className="h-4 w-4" />
          ouyowu@gmail.com
        </a>
      </section>

      <section className="grid gap-4 md:grid-cols-3">
        {[
          "Featured venue placement",
          "Event flyer and offer promotion",
          "Reservation-system development",
          "ThaiNight verified partner tags",
          "City and category sponsorships",
          "Custom lead capture for venues",
        ].map((item) => (
          <div key={item} className="rounded-2xl border border-zinc-800 bg-zinc-950 p-5 text-sm font-bold text-zinc-200">
            <Sparkles className="mb-4 h-5 w-5 text-amber-300" />
            {item}
          </div>
        ))}
      </section>
      <SiteFooter />
    </main>
  );
}
