export type VenueCategory = "bars" | "gentlemen-clubs";

export type VenueScores = {
  foreignerFriendly: number;
  reliability: number;
  priceTransparency: number;
};

export type Venue = {
  slug: string;
  name: string;
  city: string;
  area: string;
  category: VenueCategory;
  description: string;
  priceRange: string;
  address: {
    streetAddress: string;
    addressLocality: string;
    addressRegion: string;
    addressCountry: string;
  };
  geo: { lat: number; lng: number };
  scores: VenueScores;
  aggregateRating: { ratingValue: number; reviewCount: number };
  updated_at: string;
  last_verified_at: string;
  image?: string;
};
