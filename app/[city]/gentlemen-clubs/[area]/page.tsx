import Link from "next/link";
import type { Metadata } from "next";
import { NeighborhoodFilter } from "@/components/NeighborhoodFilter";
import {
  listAreasForCategory,
  listVenuesByArea,
} from "@/lib/venues";
import { overallScore } from "@/lib/utils";
import {
  absoluteTitle,
  formatLocationName,
  generateMetaTitle,
} from "@/lib/seo";
import { siteBaseUrl } from "@/lib/config";

export function generateStaticParams() {
  return [{ city: "bangkok", area: "sukhumvit" }];
}

export async function generateMetadata({
  params,
}: {
  params: { city: string; area: string };
}): Promise<Metadata> {
  const area = formatLocationName(params.area);
  return {
    title: absoluteTitle(
      generateMetaTitle({
        type: "area",
        location: area,
      })
    ),
    description: `${area} nightlife guide for gentlemen's clubs, bars, and late-night venue intelligence. Verified May 2026.`,
    alternates: {
      canonical: `${siteBaseUrl()}/${params.city}/gentlemen-clubs/${params.area}`,
    },
  };
}

export default function GentlemenAreaPage({
  params,
}: {
  params: { city: string; area: string };
}) {
  const venues = listVenuesByArea(
    params.city,
    "gentlemen-clubs",
    params.area
  );
  const areas = listAreasForCategory(params.city, "gentlemen-clubs");
  return (
    <main className="mx-auto max-w-4xl space-y-8 px-4 py-10">
      <h1 className="text-3xl font-bold capitalize text-white">
        {params.area.replace(/-/g, " ")}
      </h1>
      <NeighborhoodFilter
        city={params.city}
        category="gentlemen-clubs"
        areas={areas}
        activeArea={params.area}
      />
      <ul className="space-y-3">
        {venues.map((v) => (
          <li key={v.slug}>
            <Link
              href={`/${params.city}/gentlemen-clubs/${params.area}/${v.slug}`}
              className="block min-h-11 rounded-2xl border border-slate-800 bg-slate-900/40 px-4 py-3 hover:border-rose-500/30"
            >
              <span className="font-medium text-white">{v.name}</span>
              <span className="text-sm text-slate-500">
                {" "}
                · {overallScore(v.scores).toFixed(1)}
              </span>
            </Link>
          </li>
        ))}
      </ul>
    </main>
  );
}
