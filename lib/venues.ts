import type { Venue, VenueCategory } from "./types";

const MOCK: Venue[] = [
  {
    slug: "tropic-city",
    name: "Tropic City",
    city: "bangkok",
    area: "thonglor",
    category: "bars",
    description: "Award-winning cocktail bar with a tropical vinyl vibe.",
    priceRange: "$$$",
    address: {
      streetAddress: "1108 Sukhumvit Rd",
      addressLocality: "Bangkok",
      addressRegion: "Bangkok",
      addressCountry: "TH",
    },
    geo: { lat: 13.7244, lng: 100.5841 },
    scores: {
      foreignerFriendly: 92,
      reliability: 88,
      priceTransparency: 85,
    },
    aggregateRating: { ratingValue: 4.8, reviewCount: 214 },
    updated_at: "2026-05-11T10:00:00.000Z",
    last_verified_at: "2026-05-11T09:00:00.000Z",
  },
  {
    slug: "mahanakhon-sky",
    name: "Sky Beach Mahanakhon",
    city: "bangkok",
    area: "silom",
    category: "bars",
    description: "Rooftop bar with city views — tourist-heavy but reliable hours.",
    priceRange: "$$$$",
    address: {
      streetAddress: "114 Naradhiwat Rajanagarindra Rd",
      addressLocality: "Bangkok",
      addressRegion: "Bangkok",
      addressCountry: "TH",
    },
    geo: { lat: 13.7236, lng: 100.5281 },
    scores: {
      foreignerFriendly: 95,
      reliability: 82,
      priceTransparency: 70,
    },
    aggregateRating: { ratingValue: 4.5, reviewCount: 1203 },
    updated_at: "2026-04-01T12:00:00.000Z",
    last_verified_at: "2026-04-01T08:00:00.000Z",
  },
  {
    slug: "demo-venue-club",
    name: "Demo Gentlemen's Club",
    city: "bangkok",
    area: "sukhumvit",
    category: "gentlemen-clubs",
    description: "Sample listing for the gentlemen-clubs vertical.",
    priceRange: "$$$$",
    address: {
      streetAddress: "1 Sukhumvit Rd",
      addressLocality: "Bangkok",
      addressRegion: "Bangkok",
      addressCountry: "TH",
    },
    geo: { lat: 13.7373, lng: 100.5607 },
    scores: {
      foreignerFriendly: 78,
      reliability: 80,
      priceTransparency: 72,
    },
    aggregateRating: { ratingValue: 4.1, reviewCount: 56 },
    updated_at: "2026-05-11T16:00:00.000Z",
    last_verified_at: "2026-05-11T15:30:00.000Z",
  },
];

export function listCities(): string[] {
  return Array.from(new Set(MOCK.map((v) => v.city)));
}

export function listVenuesByCityAndCategory(
  city: string,
  category: VenueCategory
): Venue[] {
  return MOCK.filter((v) => v.city === city && v.category === category);
}

export function listVenuesByArea(
  city: string,
  category: VenueCategory,
  area: string
): Venue[] {
  return MOCK.filter(
    (v) => v.city === city && v.category === category && v.area === area
  );
}

export function getVenue(
  city: string,
  category: VenueCategory,
  area: string,
  slug: string
): Venue | undefined {
  return MOCK.find(
    (v) =>
      v.city === city &&
      v.category === category &&
      v.area === area &&
      v.slug === slug
  );
}

export function listAreasForCategory(
  city: string,
  category: VenueCategory
): string[] {
  return Array.from(
    new Set(
      MOCK.filter((v) => v.city === city && v.category === category).map(
        (v) => v.area
      )
    )
  );
}
