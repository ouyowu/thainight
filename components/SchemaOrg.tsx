import type { Venue } from "@/lib/types";

type Props = { venue: Venue; canonicalUrl: string; dateModified: string };

export function SchemaOrg({ venue, canonicalUrl, dateModified }: Props) {
  const structured = {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "BarOrPub",
        "@id": canonicalUrl,
        name: venue.name,
        description: venue.description,
        url: canonicalUrl,
        priceRange: venue.priceRange,
        address: {
          "@type": "PostalAddress",
          streetAddress: venue.address.streetAddress,
          addressLocality: venue.address.addressLocality,
          addressRegion: venue.address.addressRegion,
          addressCountry: venue.address.addressCountry,
        },
        geo: {
          "@type": "GeoCoordinates",
          latitude: venue.geo.lat,
          longitude: venue.geo.lng,
        },
        aggregateRating: {
          "@type": "AggregateRating",
          ratingValue: venue.aggregateRating.ratingValue,
          reviewCount: venue.aggregateRating.reviewCount,
        },
        dateModified,
      },
      {
        "@type": "Review",
        itemReviewed: { "@id": canonicalUrl },
        author: {
          "@type": "Organization",
          name: "ThaiNight",
        },
        reviewBody: venue.description,
        reviewRating: {
          "@type": "Rating",
          ratingValue: venue.aggregateRating.ratingValue,
          bestRating: 5,
        },
        datePublished: venue.last_verified_at,
      },
    ],
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(structured) }}
    />
  );
}
