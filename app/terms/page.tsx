import type { Metadata } from "next";
import { FileText } from "lucide-react";
import { SiteFooter } from "@/components/SiteFooter";

export const metadata: Metadata = {
  title: "Terms of Use | ThaiNight [Updated May 2026]",
  description:
    "ThaiNight terms for venue discovery, nightlife information, event flyers, special offers, beta membership, and social meetup tools.",
  alternates: { canonical: "/terms" },
};

export default function TermsPage() {
  return (
    <main className="mx-auto flex min-h-screen max-w-4xl flex-col gap-8 px-4 py-6 sm:px-6 lg:px-8">
      <section className="rounded-3xl border border-zinc-800 bg-zinc-950 p-6 sm:p-8">
        <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-rose-300">
          <FileText className="h-4 w-4" />
          Terms of Use
        </p>
        <h1 className="mt-4 text-4xl font-black tracking-tight text-white">Terms for using ThaiNight.</h1>
        <p className="mt-5 text-sm leading-8 text-zinc-300">
          ThaiNight is currently in beta. Early member access is free while we test nightlife discovery, event intelligence, and social meetup features.
        </p>
      </section>

      <section className="space-y-5 rounded-3xl border border-zinc-800 bg-zinc-950 p-6 text-sm leading-8 text-zinc-300">
        <h2 className="text-2xl font-black text-white">Information accuracy</h2>
        <p>Venue details, hours, events, offers, and social signals may change quickly. ThaiNight works to keep information fresh, but users should verify critical details with the venue when needed.</p>
        <h2 className="text-2xl font-black text-white">User submissions</h2>
        <p>By submitting updates, flyers, offers, reviews, or meetup posts, you confirm you have the right to share them and that the information is not intentionally misleading.</p>
        <h2 className="text-2xl font-black text-white">Community behavior</h2>
        <p>Spam, harassment, impersonation, unsafe meetup behavior, or fake venue claims may lead to removal or account restrictions.</p>
        <h2 className="text-2xl font-black text-white">Beta membership</h2>
        <p>ThaiNight Pass is free for early beta members. Future paid benefits may be introduced with clearer pricing and plan details before payment is required.</p>
      </section>
      <SiteFooter />
    </main>
  );
}
