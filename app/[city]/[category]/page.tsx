import Image from "next/image";
import Link from "next/link";
import type { Metadata } from "next";
import { notFound } from "next/navigation";
import {
  absoluteTitle,
  formatCategoryName,
  formatLocationName,
  generateMetaTitle,
} from "@/lib/seo";
import { siteBaseUrl } from "@/lib/config";
import { getCityConfig, getCityStaticParams } from "@/lib/cities";
import { categoryStaticParams, getSeoCategory } from "@/lib/seo-keywords";
import { createAnonClient } from "@/lib/supabase/server";
import type { VenueCard } from "@/lib/database.types";
import { canRenderPublicImage } from "@/lib/media";
import { PriorityFaq } from "@/components/PriorityFaq";

export function generateStaticParams() {
  return categoryStaticParams(getCityStaticParams().map((param) => param.city));
}

export async function generateMetadata({
  params,
}: {
  params: { city: string; category: string };
}): Promise<Metadata> {
  const seoCategory = getSeoCategory(params.category);
  const label = seoCategory?.titleKeyword ?? formatCategoryName(params.category);
  const city = formatLocationName(params.city);
  return {
    title: absoluteTitle(
      generateMetaTitle({ type: "category", category: label, location: city })
    ),
    description: `${label} in ${city}: ${seoCategory?.description ?? "ranked by freshness, filters, and nightlife scores."} Updated May 2026 by ThaiNight.`,
    alternates: {
      canonical: `${siteBaseUrl()}/${params.city}/${params.category}`,
    },
    openGraph: {
      title: `${label} in ${city} | ThaiNight`,
      description: `${label} in ${city}: ${seoCategory?.description ?? "ranked by freshness, filters, and nightlife scores."}`,
      url: `${siteBaseUrl()}/${params.city}/${params.category}`,
      siteName: "ThaiNight",
      locale: "en_TH",
      type: "website",
    },
    twitter: {
      card: "summary_large_image",
      title: `${label} in ${city} | ThaiNight`,
      description: `${label} in ${city}: ${seoCategory?.description ?? "ranked by freshness, filters, and nightlife scores."}`,
    },
  };
}

function venueHref(city: string, venue: VenueCard): string {
  const broadCategory =
    venue.category === "nightclub" && venue.tags.includes("gentlemen-club")
      ? "gentlemen-clubs"
      : "bars";
  return `/${city}/${broadCategory}/${venue.area_slug}/${venue.slug}`;
}

async function getCategoryVenues(city: string, categorySlug: string): Promise<VenueCard[]> {
  const seoCategory = getSeoCategory(categorySlug);
  const supabase = createAnonClient();
  if (!supabase || !seoCategory) return [];

  const { data } = await supabase
    .from("venue_cards")
    .select("*")
    .eq("city", city)
    .order("last_verified_at", { ascending: false, nullsFirst: false })
    .order("overall_score", { ascending: false })
    .limit(160);

  const venues = ((data ?? []) as VenueCard[]).filter((venue) => {
    const categoryMatch = seoCategory.matchingCategories?.includes(venue.category);
    const tagMatch = seoCategory.matchingTags?.some((tag) =>
      venue.tags.map((item) => item.toLowerCase()).includes(tag.toLowerCase())
    );
    return categoryMatch || tagMatch;
  });

  return venues.slice(0, 36);
}

export default async function CategoryPage({
  params,
}: {
  params: { city: string; category: string };
}) {
  const city = getCityConfig(params.city);
  const seoCategory = getSeoCategory(params.category);
  if (!city || !seoCategory) notFound();

  const venues = await getCategoryVenues(city.slug, seoCategory.slug);
  const relatedLinks = [
    { label: `${city.name} nightlife`, href: `/${city.slug}` },
    { label: `${city.name} bars`, href: `/${city.slug}/bars` },
    { label: "Thailand events", href: "/events" },
    { label: "Happy hour offers", href: "/offers" },
  ];
  const baseUrl = siteBaseUrl();
  const categoryUrl = `${baseUrl}/${city.slug}/${seoCategory.slug}`;
  const categoryJsonLd = {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": ["CollectionPage", "ItemList"],
        "@id": `${categoryUrl}#collection`,
        url: categoryUrl,
        name: `${seoCategory.titleKeyword} in ${city.name}`,
        dateModified: new Date().toISOString(),
        numberOfItems: venues.length,
        itemListElement: venues.slice(0, 24).map((venue, index) => ({
          "@type": "ListItem",
          position: index + 1,
          url: `${baseUrl}${venueHref(city.slug, venue)}`,
          name: venue.name,
        })),
      },
    ],
  };

  return (
    <main className="mx-auto min-h-screen max-w-7xl space-y-8 px-4 py-8 sm:py-10">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(categoryJsonLd) }}
      />
      <section className="rounded-3xl border border-zinc-800 bg-zinc-950 p-6 sm:p-8">
        <nav className="mb-5 flex flex-wrap items-center gap-2 text-xs text-zinc-600">
          <Link href="/" className="hover:text-zinc-300">ThaiNight</Link>
          <span>/</span>
          <Link href={`/${city.slug}`} className="hover:text-zinc-300">{city.name}</Link>
          <span>/</span>
          <span className="text-zinc-400">{seoCategory.label}</span>
        </nav>
        <p className="text-xs font-black uppercase tracking-widest text-rose-300">
          {city.name} {seoCategory.searchIntent} guide
        </p>
        <h1 className="mt-3 text-balance text-4xl font-black tracking-tight text-white md:text-6xl">
          {seoCategory.titleKeyword} in {city.name}
        </h1>
        <p className="mt-4 max-w-3xl text-base leading-8 text-zinc-400">
          {seoCategory.description} ThaiNight ranks these pages around freshness, traveler fit,
          price transparency, reliability, and verified May 2026 venue intelligence.
        </p>
        <div className="mt-6 flex flex-wrap gap-2">
          {relatedLinks.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              className="rounded-full border border-zinc-800 bg-zinc-900 px-4 py-2 text-sm font-bold text-zinc-200 transition hover:border-rose-400/50"
            >
              {link.label}
            </Link>
          ))}
        </div>
      </section>

      <PriorityFaq
        pageUrl={`/${city.slug}/${seoCategory.slug}`}
        title={`${seoCategory.label} in ${city.name}: common questions before opening a venue`}
        intro={`Category pages help users narrow down venue type and intent. The strongest next move is usually to open a venue, bounce back to the ${city.name} guide, or compare this list with events and offers.`}
        items={[
          {
            question: `What is this ${city.name} ${seoCategory.label.toLowerCase()} page for?`,
            answer:
              `It narrows the nightlife wall into a tighter intent, so users can compare a focused list of ${seoCategory.label.toLowerCase()} instead of scanning the whole city guide.`,
          },
          {
            question: `How should I use this page with the main ${city.name} guide?`,
            answer:
              `Use the city guide for area context and overall planning, then use this category page when you already know the kind of venue you want tonight.`,
          },
          {
            question: "What should I click after this category page?",
            answer:
              "The best next step is usually an individual venue page, then either Events for listings, Offers for deals, or the city guide for broader neighborhood context.",
          },
        ]}
        nextSteps={[
          {
            href: `/${city.slug}`,
            label: `Back to ${city.name} nightlife guide`,
            description: `Use the full ${city.name} guide when you need area context, nightlife breadth, and a wider planning view.`,
          },
          {
            href: "/events",
            label: "Open approved events",
            description: "Good follow-up if venue type is clear and you now want party listings, flyers, or guest-list momentum.",
          },
          {
            href: "/offers",
            label: "Check current offers",
            description: "Best next click when you want to compare venue fit with guest-list windows, happy hours, or entry deals.",
          },
        ]}
      />

      {venues.length > 0 ? (
        <section className="grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
          {venues.map((venue) => (
            <Link
              key={venue.id}
              href={venueHref(city.slug, venue)}
              className="group overflow-hidden rounded-2xl border border-zinc-800 bg-zinc-950 transition hover:-translate-y-0.5 hover:border-rose-400/50"
            >
              <div className="relative aspect-[16/10] bg-zinc-900">
                {venue.hero_image_url && canRenderPublicImage(venue.hero_image_url) ? (
                  <Image
                    src={venue.hero_image_url}
                    alt={`${venue.name} ${seoCategory.label} in ${city.name} - ThaiNight`}
                    fill
                    sizes="(min-width: 1280px) 33vw, (min-width: 640px) 50vw, 100vw"
                    className="h-full w-full object-cover transition duration-500 group-hover:scale-105 group-hover:brightness-90"
                  />
                ) : (
                  <div className="h-full w-full bg-gradient-to-br from-rose-500/25 via-zinc-900 to-zinc-950" />
                )}
              </div>
              <div className="p-4">
                <p className="text-xs font-semibold uppercase tracking-widest text-zinc-500">
                  {venue.area_name ?? venue.area_slug} · {formatCategoryName(venue.category)}
                </p>
                <h2 className="mt-2 line-clamp-2 text-lg font-black leading-7 text-white group-hover:text-rose-100">
                  {venue.name}
                </h2>
                <p className="mt-2 line-clamp-2 text-sm leading-6 text-zinc-400">
                  {venue.tagline ?? `${seoCategory.label} option in ${city.name}.`}
                </p>
              </div>
            </Link>
          ))}
        </section>
      ) : (
        <section className="rounded-3xl border border-dashed border-zinc-800 bg-zinc-950 p-8">
          <h2 className="text-2xl font-black text-white">
            {seoCategory.label} list is being verified
          </h2>
          <p className="mt-3 max-w-2xl text-sm leading-7 text-zinc-400">
            This SEO landing page is live for indexing. Matching venue cards will appear automatically as
            more {city.name} places are tagged and verified.
          </p>
        </section>
      )}
    </main>
  );
}
