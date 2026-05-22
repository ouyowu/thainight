import type { Metadata } from "next";
import { LockKeyhole } from "lucide-react";
import { SiteFooter } from "@/components/SiteFooter";

export const metadata: Metadata = {
  title: "Privacy Policy | ThaiNight [Updated May 2026]",
  description:
    "ThaiNight privacy policy for early members, venue submissions, social profiles, newsletter emails, and nightlife meetup signals.",
  alternates: { canonical: "/privacy" },
};

export default function PrivacyPage() {
  return (
    <main className="mx-auto flex min-h-screen max-w-4xl flex-col gap-8 px-4 py-6 sm:px-6 lg:px-8">
      <section className="rounded-3xl border border-zinc-800 bg-zinc-950 p-6 sm:p-8">
        <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-rose-300">
          <LockKeyhole className="h-4 w-4" />
          Privacy Policy
        </p>
        <h1 className="mt-4 text-4xl font-black tracking-tight text-white">Privacy for ThaiNight beta members.</h1>
        <p className="mt-5 text-sm leading-8 text-zinc-300">
          ThaiNight collects the minimum practical information needed to run venue discovery, newsletters, event submissions, and beta social features.
        </p>
      </section>

      <section className="space-y-5 rounded-3xl border border-zinc-800 bg-zinc-950 p-6 text-sm leading-8 text-zinc-300">
        <h2 className="text-2xl font-black text-white">What we may collect</h2>
        <p>Email address, profile fields you submit, verification proof links, venue update submissions, event flyers, offer submissions, and basic social actions such as Count me in or meetup requests.</p>
        <h2 className="text-2xl font-black text-white">How we use it</h2>
        <p>To operate ThaiNight, moderate submissions, show anonymized social signals, protect the community, improve venue data, and contact venue partners or subscribers when relevant.</p>
        <h2 className="text-2xl font-black text-white">Public social display</h2>
        <p>ThaiNight is designed to show anonymized or limited social previews first. Private contact details should only move forward after user intent and approval.</p>
        <h2 className="text-2xl font-black text-white">Contact</h2>
        <p>For privacy questions or removal requests, email ouyowu@gmail.com.</p>
      </section>
      <SiteFooter />
    </main>
  );
}
