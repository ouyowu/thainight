import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { SchemaOrg } from "@/components/SchemaOrg";
import { VerificationBadge } from "@/components/VerificationBadge";
import { VenueScoreCard } from "@/components/VenueScoreCard";
import { getVenue } from "@/lib/venues";
import { siteBaseUrl, verificationReferenceDate } from "@/lib/config";
import {
  absoluteTitle,
  formatLocationName,
  generateMetaTitle,
} from "@/lib/seo";

export function generateStaticParams() {
  return [
    {
      city: "bangkok",
      area: "sukhumvit",
      "venue-slug": "demo-venue-club",
    },
  ];
}

export async function generateMetadata({
  params,
}: {
  params: { city: string; area: string; "venue-slug": string };
}): Promise<Metadata> {
  const v = getVenue(
    params.city,
    "gentlemen-clubs",
    params.area,
    params["venue-slug"]
  );
  if (!v) return { title: "Venue" };
  const area = formatLocationName(params.area);
  const title = generateMetaTitle({
    type: "venue",
    name: v.name,
    category: "Gentlemen's Club",
    location: area,
  });
  const canonical = `${siteBaseUrl()}/${params.city}/gentlemen-clubs/${params.area}/${params["venue-slug"]}`;
  return {
    title: absoluteTitle(title),
    description: v.description,
    openGraph: { title, description: v.description },
    alternates: { canonical },
  };
}

export default function GentlemenVenuePage({
  params,
}: {
  params: { city: string; area: string; "venue-slug": string };
}) {
  const venue = getVenue(
    params.city,
    "gentlemen-clubs",
    params.area,
    params["venue-slug"]
  );
  if (!venue) notFound();

  const path = `/${params.city}/gentlemen-clubs/${params.area}/${params["venue-slug"]}`;
  const canonicalUrl = `${siteBaseUrl()}${path}`;

  return (
    <>
      <SchemaOrg
        venue={venue}
        canonicalUrl={canonicalUrl}
        dateModified={venue.last_verified_at}
      />
      <main className="mx-auto max-w-4xl space-y-8 px-4 py-10">
        <header className="space-y-3">
          <div className="flex flex-wrap items-center gap-3">
            <h1 className="text-3xl font-bold text-white">{venue.name}</h1>
            <VerificationBadge
              updatedAt={venue.updated_at}
              referenceNow={verificationReferenceDate()}
            />
          </div>
          <p className="text-slate-400">{venue.description}</p>
        </header>
        <VenueScoreCard scores={venue.scores} />
      </main>
    </>
  );
}
