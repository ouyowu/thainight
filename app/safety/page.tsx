import type { Metadata } from "next";
import Link from "next/link";
import { AlertTriangle, ShieldCheck, UserCheck } from "lucide-react";
import { SiteFooter } from "@/components/SiteFooter";

export const metadata: Metadata = {
  title: "Safety & Community Rules | ThaiNight [Updated May 2026]",
  description:
    "ThaiNight safety rules for nightlife meetups, venue reports, verification, and respectful community behavior in Thailand.",
  alternates: { canonical: "/safety" },
};

const RULES = [
  "Meet in public venues first and do not share private addresses in public posts.",
  "Use Instagram verification for meetup posts and join requests when requested.",
  "Report closures, raids, overcharging, scams, or unsafe behavior through Submit Update.",
  "Do not harass, spam, impersonate venues, or pressure anyone to share contact details.",
  "ThaiNight may remove suspicious posts, fake flyers, or unsafe meetup requests.",
];

export default function SafetyPage() {
  return (
    <main className="mx-auto flex min-h-screen max-w-5xl flex-col gap-8 px-4 py-6 sm:px-6 lg:px-8">
      <section className="rounded-3xl border border-zinc-800 bg-zinc-950 p-6 sm:p-8">
        <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-rose-300">
          <ShieldCheck className="h-4 w-4" />
          Safety & community rules
        </p>
        <h1 className="mt-4 text-4xl font-black tracking-tight text-white sm:text-5xl">
          ThaiNight is built for real nightlife plans, not reckless contact swapping.
        </h1>
        <p className="mt-5 max-w-3xl text-base leading-8 text-zinc-300">
          The beta social system is intentionally lightweight: public interest signals, verified meetup requests, and host approval before private details move forward.
        </p>
      </section>

      <section className="rounded-3xl border border-zinc-800 bg-zinc-950 p-6">
        <h2 className="text-2xl font-black text-white">Community rules</h2>
        <div className="mt-5 grid gap-3">
          {RULES.map((rule) => (
            <div key={rule} className="flex gap-3 rounded-2xl border border-zinc-800 bg-zinc-900/55 p-4 text-sm leading-7 text-zinc-300">
              <UserCheck className="mt-1 h-4 w-4 shrink-0 text-emerald-300" />
              <span>{rule}</span>
            </div>
          ))}
        </div>
      </section>

      <section className="rounded-3xl border border-amber-300/20 bg-amber-500/10 p-6">
        <p className="inline-flex items-center gap-2 text-sm font-bold text-amber-100">
          <AlertTriangle className="h-4 w-4" />
          Emergency note
        </p>
        <p className="mt-3 text-sm leading-7 text-amber-100/85">
          ThaiNight is an information and community product, not an emergency service. If there is immediate danger, contact local authorities, venue security, or your hotel first.
        </p>
      </section>

      <Link href="/contact" className="inline-flex w-fit rounded-full bg-white px-5 py-3 text-sm font-black text-zinc-950">
        Contact ThaiNight
      </Link>
      <SiteFooter />
    </main>
  );
}
