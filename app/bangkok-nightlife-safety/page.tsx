import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { SeoIntentLanding } from "@/components/SeoIntentLanding";
import { siteBaseUrl } from "@/lib/config";
import { getSeoIntentPage } from "@/lib/seo-intent-pages";

const config = getSeoIntentPage("bangkok-nightlife-safety");

export const metadata: Metadata = config
  ? {
      title: config.metaTitle,
      description: config.metaDescription,
      alternates: { canonical: `${siteBaseUrl()}/${config.slug}` },
    }
  : {};

export default function Page() {
  if (!config) notFound();
  return <SeoIntentLanding config={config} />;
}
