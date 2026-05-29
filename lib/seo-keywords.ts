// Context: ThaiNight SEO map | May 2026 | Use high-intent nightlife searches as internal links, not keyword stuffing.

import type { CitySlug } from "@/lib/cities";

export type SeoCategorySlug =
  | "cocktail-bars"
  | "rooftop-bars"
  | "nightclubs"
  | "live-music"
  | "happy-hour"
  | "beach-clubs"
  | "hidden-bars";

export type SeoCategory = {
  slug: SeoCategorySlug;
  label: string;
  searchIntent: string;
  titleKeyword: string;
  description: string;
  matchingCategories?: string[];
  matchingTags?: string[];
};

export const SEO_CATEGORIES: SeoCategory[] = [
  {
    slug: "cocktail-bars",
    label: "Cocktail Bars",
    searchIntent: "best cocktail bars",
    titleKeyword: "Best Cocktail Bars",
    description:
      "Cocktail rooms, speakeasies, hotel bars, and date-night drinking spots with freshness and price-transparency signals.",
    matchingCategories: ["cocktail-bar", "hotel-bar", "wine-bar"],
    matchingTags: ["cocktails", "speakeasy", "date_spot", "craft_cocktails"],
  },
  {
    slug: "rooftop-bars",
    label: "Rooftop Bars",
    searchIntent: "best rooftop bars",
    titleKeyword: "Best Rooftop Bars",
    description:
      "Skyline bars, sunset terraces, hotel rooftops, and high-floor lounges for travelers comparing views, dress code, and value.",
    matchingCategories: ["rooftop-bar", "hotel-bar"],
    matchingTags: ["rooftop", "sunset", "view"],
  },
  {
    slug: "nightclubs",
    label: "Nightclubs",
    searchIntent: "best nightclubs",
    titleKeyword: "Best Nightclubs",
    description:
      "High-energy clubs, dance floors, EDM rooms, hip-hop nights, and late venues with crowd and reliability signals.",
    matchingCategories: ["nightclub"],
    matchingTags: ["club", "edm", "dance", "hip-hop", "rave", "high_energy"],
  },
  {
    slug: "live-music",
    label: "Live Music",
    searchIntent: "live music bars",
    titleKeyword: "Best Live Music Bars",
    description:
      "Jazz bars, live bands, open decks, tribute nights, and music-led venues for travelers who want a real scene, not just a drink.",
    matchingCategories: ["jazz-bar", "dive-bar"],
    matchingTags: ["live_music", "jazz", "rock", "music"],
  },
  {
    slug: "happy-hour",
    label: "Happy Hour",
    searchIntent: "happy hour",
    titleKeyword: "Best Happy Hour & Bar Offers",
    description:
      "Happy hours, early bird tickets, free-entry nights, guest lists, and deal-like nightlife signals collected from approved sources.",
    matchingTags: ["happy hour", "offer", "free entry", "guestlist"],
  },
  {
    slug: "beach-clubs",
    label: "Beach Clubs",
    searchIntent: "beach clubs",
    titleKeyword: "Best Beach Clubs",
    description:
      "Beach clubs, pool parties, sunset sessions, and island nightlife for Phuket, Pattaya, and Thailand coastal trips.",
    matchingCategories: ["beach-club"],
    matchingTags: ["beach", "pool_party", "sunset"],
  },
  {
    slug: "hidden-bars",
    label: "Hidden Bars",
    searchIntent: "hidden bars",
    titleKeyword: "Best Hidden Bars",
    description:
      "Speakeasies, small cocktail rooms, locals-first bars, and lower-noise venues that are harder to find from generic maps.",
    matchingCategories: ["cocktail-bar", "dive-bar"],
    matchingTags: ["hidden", "speakeasy", "local", "chill"],
  },
];

export const SEO_CATEGORY_SLUGS = SEO_CATEGORIES.map((category) => category.slug);

export function getSeoCategory(slug: string): SeoCategory | null {
  return SEO_CATEGORIES.find((category) => category.slug === slug) ?? null;
}

export const SEO_MENU_LINKS: Array<{
  label: string;
  href: string;
  keyword: string;
  group: "city" | "category" | "district" | "intent";
}> = [
  { label: "Thailand Nightlife", href: "/", keyword: "thailand nightlife", group: "city" },
  { label: "Bangkok Nightlife Tonight", href: "/bangkok-nightlife-tonight", keyword: "bangkok nightlife tonight", group: "intent" },
  { label: "Pattaya Nightlife Guide", href: "/pattaya-nightlife-guide", keyword: "pattaya nightlife guide", group: "intent" },
  { label: "Phuket Nightlife Tonight", href: "/phuket-nightlife-tonight", keyword: "phuket nightlife tonight", group: "intent" },
  { label: "Pattaya Nightlife Tonight", href: "/pattaya-nightlife-tonight", keyword: "pattaya nightlife tonight", group: "intent" },
  { label: "Chiang Mai Nightlife Tonight", href: "/chiang-mai-nightlife-tonight", keyword: "chiang mai nightlife tonight", group: "intent" },
  { label: "Walking Street Pattaya Safety", href: "/walking-street-pattaya-safety", keyword: "walking street pattaya safety", group: "intent" },
  { label: "Phuket Bangla Road Safety", href: "/phuket-bangla-road-safety", keyword: "phuket bangla road safety", group: "intent" },
  { label: "Bangkok Rooftop Bars 2026", href: "/bangkok-rooftop-bars-2026", keyword: "bangkok rooftop bars 2026", group: "intent" },
  { label: "Thailand Nightlife Price Tips", href: "/thailand-nightlife-price-tips", keyword: "thailand nightlife price tips", group: "intent" },
  { label: "Solo Traveler Bangkok Nightlife", href: "/solo-traveler-bangkok-nightlife", keyword: "solo traveler bangkok nightlife", group: "intent" },
  { label: "Bangkok Nightlife", href: "/bangkok", keyword: "bangkok nightlife", group: "city" },
  { label: "Phuket Nightlife", href: "/phuket", keyword: "phuket nightlife", group: "city" },
  { label: "Pattaya Nightlife", href: "/pattaya", keyword: "pattaya nightlife", group: "city" },
  { label: "Chiang Mai Nightlife", href: "/chiang-mai", keyword: "chiang mai nightlife", group: "city" },
  { label: "Bangkok Rooftop Bars", href: "/bangkok/rooftop-bars", keyword: "bangkok rooftop bars", group: "category" },
  { label: "Bangkok Cocktail Bars", href: "/bangkok/cocktail-bars", keyword: "bangkok cocktail bars", group: "category" },
  { label: "Bangkok Nightclubs", href: "/bangkok/nightclubs", keyword: "bangkok nightclubs", group: "category" },
  { label: "Bangkok Live Music", href: "/bangkok/live-music", keyword: "bangkok live music", group: "category" },
  { label: "Happy Hour Bangkok", href: "/bangkok/happy-hour", keyword: "happy hour bangkok", group: "intent" },
  { label: "Patong Bangla Road", href: "/phuket?search=bangla%20road", keyword: "bangla road nightlife", group: "district" },
  { label: "Pattaya Walking Street", href: "/pattaya?search=walking%20street", keyword: "pattaya walking street bars", group: "district" },
  { label: "Thonglor Bars", href: "/bangkok/bars/thonglor", keyword: "thonglor bars", group: "district" },
  { label: "Sukhumvit Soi 11", href: "/bangkok?search=sukhumvit%20soi%2011", keyword: "sukhumvit soi 11 nightlife", group: "district" },
  { label: "RCA Clubs", href: "/bangkok/bars/rca", keyword: "rca bangkok clubs", group: "district" },
  { label: "Nimman Bars", href: "/chiang-mai/bars/nimman", keyword: "nimman bars chiang mai", group: "district" },
  { label: "Thailand Events", href: "/events", keyword: "thailand nightlife events", group: "intent" },
  { label: "Bar Offers", href: "/offers", keyword: "bangkok bar offers", group: "intent" },
];

export function categoryStaticParams(cities: CitySlug[]) {
  return cities.flatMap((city) =>
    SEO_CATEGORY_SLUGS.map((category) => ({ city, category }))
  );
}
