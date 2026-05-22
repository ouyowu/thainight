import Link from "next/link";
import type { Metadata } from "next";
import { listAreasForCategory } from "@/lib/venues";
import {
  absoluteTitle,
  formatLocationName,
  generateMetaTitle,
} from "@/lib/seo";
import { siteBaseUrl } from "@/lib/config";

export function generateStaticParams() {
  return [{ city: "bangkok" }];
}

export async function generateMetadata({
  params,
}: {
  params: { city: string };
}): Promise<Metadata> {
  const city = formatLocationName(params.city);
  return {
    title: absoluteTitle(
      generateMetaTitle({
        type: "category",
        category: "Gentlemen's Clubs",
        location: city,
      })
    ),
    description: `Best gentlemen's clubs in ${city}, ranked by freshness, verification, and nightlife score signals.`,
    alternates: {
      canonical: `${siteBaseUrl()}/${params.city}/gentlemen-clubs`,
    },
  };
}

export default function GentlemenIndexPage({
  params,
}: {
  params: { city: string };
}) {
  const areas = listAreasForCategory(params.city, "gentlemen-clubs");
  return (
    <main className="mx-auto max-w-4xl space-y-8 px-4 py-10">
      <h1 className="text-3xl font-bold text-white">Gentlemen&apos;s clubs</h1>
      <ul className="flex flex-wrap gap-2">
        {areas.map((area) => (
          <li key={area}>
            <Link
              href={`/${params.city}/gentlemen-clubs/${area}`}
              className="inline-flex min-h-11 items-center rounded-full border border-slate-700 px-4 py-2 capitalize hover:border-rose-500/50"
            >
              {area}
            </Link>
          </li>
        ))}
      </ul>
    </main>
  );
}
