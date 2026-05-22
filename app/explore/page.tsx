import type { Metadata } from "next";
import Link from "next/link";
import { ArrowRight, Compass } from "lucide-react";
import { HomeSeoInternalLinks } from "@/components/HomeSeoInternalLinks";
import { SiteFooter } from "@/components/SiteFooter";
import { siteBaseUrl } from "@/lib/config";

export const metadata: Metadata = {
  title: "Explore Thailand Nightlife Pages | ThaiNight",
  description:
    "Fast routes to ThaiNight city guides, nightlife events, bar offers, rooftop bars, clubs, and high-intent Thailand nightlife pages.",
  alternates: {
    canonical: `${siteBaseUrl()}/explore`,
  },
};

export default function ExplorePage() {
  return (
    <main className="mx-auto flex min-h-screen max-w-7xl flex-col gap-8 px-4 py-6 sm:px-6 lg:px-8">
      <section className="rounded-[32px] border border-rose-300/20 bg-zinc-950 p-5 sm:p-8">
        <nav className="mb-6 flex items-center gap-2 text-xs font-bold text-zinc-500">
          <Link href="/" className="hover:text-zinc-300">
            ThaiNight
          </Link>
          <ArrowRight className="h-3.5 w-3.5" />
          <span className="text-zinc-300">Explore</span>
        </nav>
        <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-rose-200">
          <Compass className="h-4 w-4" />
          Popular routes
        </p>
        <h1 className="mt-3 max-w-4xl text-balance text-4xl font-black tracking-tight text-white sm:text-5xl">
          Find the right Thailand nightlife page faster.
        </h1>
        <p className="mt-4 max-w-2xl text-base leading-8 text-zinc-400">
          City guides, tonight events, bar deals, nightlife areas, rooftop bars, and high-intent search pages in one clean place.
        </p>
      </section>

      <HomeSeoInternalLinks />
      <SiteFooter />
    </main>
  );
}
