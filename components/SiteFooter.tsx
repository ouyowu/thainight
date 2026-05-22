import Link from "next/link";
import { Mail, ShieldCheck, Sparkles } from "lucide-react";
import { BrandLockup } from "@/components/BrandLockup";

const LINKS = [
  { href: "/about", label: "About" },
  { href: "/safety", label: "Safety" },
  { href: "/contact", label: "Contact" },
  { href: "/privacy", label: "Privacy" },
  { href: "/terms", label: "Terms" },
];

export function SiteFooter() {
  return (
    <footer className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
      <div className="grid gap-6 lg:grid-cols-[1.1fr_0.9fr] lg:items-end">
        <div>
          <div className="flex flex-wrap items-center gap-3">
            <BrandLockup size="md" href="/" />
            <p className="inline-flex items-center gap-2 rounded-full border border-rose-300/15 bg-rose-500/10 px-3 py-2 text-xs font-black uppercase tracking-widest text-rose-200">
              <Sparkles className="h-4 w-4" />
              Beta
            </p>
          </div>
          <h2 className="mt-3 text-2xl font-black tracking-tight text-white">
            Thailand nightlife guide, events, and people going out tonight.
          </h2>
          <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-400">
            Free early member access is open during beta. Venue owners can contact ThaiNight for listings, featured placement, offers, and reservation-system partnerships.
          </p>
        </div>

        <div className="flex flex-col gap-4 lg:items-end">
          <nav className="flex flex-wrap gap-2">
            {LINKS.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                className="rounded-full border border-zinc-800 bg-zinc-900 px-3 py-2 text-xs font-bold text-zinc-200 transition hover:border-rose-300/40 hover:text-white"
              >
                {link.label}
              </Link>
            ))}
          </nav>
          <a
            href="mailto:ouyowu@gmail.com?subject=ThaiNight%20partnership"
            className="inline-flex min-h-11 items-center gap-2 rounded-full bg-white px-4 text-sm font-black text-zinc-950 transition hover:bg-zinc-100"
          >
            <Mail className="h-4 w-4" />
            ouyowu@gmail.com
          </a>
          <p className="inline-flex items-center gap-2 text-xs font-semibold text-zinc-500">
            <ShieldCheck className="h-4 w-4" />
            English-first nightlife intelligence for Thailand
          </p>
        </div>
      </div>
    </footer>
  );
}
