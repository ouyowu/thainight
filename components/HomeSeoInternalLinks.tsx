import Link from "next/link";
import { ArrowRight, Search } from "lucide-react";
import { SEO_MENU_LINKS } from "@/lib/seo-keywords";

const FEATURED_ROUTES = [
  "Bangkok Nightlife",
  "Pattaya Nightlife",
  "Phuket Nightlife",
  "Chiang Mai Nightlife",
  "Thailand Events",
  "Bar Offers",
  "Bangkok Rooftop Bars",
  "Patong Bangla Road",
];

export function HomeSeoInternalLinks() {
  const routes = FEATURED_ROUTES.map((label) =>
    SEO_MENU_LINKS.find((link) => link.label === label)
  ).filter((link): link is (typeof SEO_MENU_LINKS)[number] => Boolean(link));

  return (
    <section className="rounded-[1.75rem] border border-white/10 bg-zinc-950/70 p-4 shadow-[0_20px_80px_rgba(0,0,0,0.22)] sm:p-5">
      <div className="flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
        <div className="max-w-xl">
          <p className="inline-flex items-center gap-2 text-[11px] font-black uppercase tracking-[0.22em] text-rose-300">
            <Search className="h-4 w-4" />
            Popular routes
          </p>
          <h2 className="mt-2 text-xl font-black tracking-tight text-white sm:text-2xl">
            Find the right Thailand nightlife page faster.
          </h2>
          <p className="mt-2 text-sm leading-6 text-zinc-500">
            City guides, tonight events, bar deals, and the nightlife areas travelers search for most.
          </p>
        </div>

        <div className="grid grid-cols-2 gap-2 sm:flex sm:max-w-3xl sm:flex-wrap sm:justify-end">
          {routes.map((link) => (
            <Link
              key={link.href + link.label}
              href={link.href}
              className="group inline-flex min-h-10 items-center justify-between gap-2 rounded-full border border-white/10 bg-white/[0.04] px-3 py-2 text-sm font-bold text-zinc-200 transition hover:border-rose-300/50 hover:bg-rose-300/10 hover:text-white sm:min-h-9"
            >
              <span className="truncate">{link.label}</span>
              <ArrowRight className="h-3.5 w-3.5 shrink-0 text-zinc-500 transition group-hover:translate-x-0.5 group-hover:text-rose-200" />
            </Link>
          ))}
        </div>
      </div>
    </section>
  );
}
