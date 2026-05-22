// Context: ThaiNight Thailand nightlife hub | Current Date: May 2026 | Priority: multi-city venue walls.

export type CitySlug = "bangkok" | "pattaya" | "phuket" | "chiang-mai";

export type CityConfig = {
  slug: CitySlug;
  name: string;
  region: string;
  description: string;
  targetVenueCount: number;
  seedVenueCount: number;
  accent: string;
  href: `/${CitySlug}`;
};

export const CITY_CONFIGS: CityConfig[] = [
  {
    slug: "bangkok",
    name: "Bangkok",
    region: "Central Thailand",
    description:
      "Bangkok nightlife guide for Sukhumvit, Thonglor, Silom, RCA, rooftop bars, cocktail bars, live music, nightclubs, and late-night districts ranked by freshness.",
    targetVenueCount: 300,
    seedVenueCount: 300,
    accent: "from-amber-500/20 to-rose-500/10",
    href: "/bangkok",
  },
  {
    slug: "pattaya",
    name: "Pattaya",
    region: "Eastern Gulf",
    description:
      "Pattaya nightlife guide for Walking Street, Soi Buakhao, Central Pattaya, beach clubs, beer bars, live music, nightclubs, and tourist-trap risk signals.",
    targetVenueCount: 270,
    seedVenueCount: 270,
    accent: "from-cyan-500/20 to-amber-500/10",
    href: "/pattaya",
  },
  {
    slug: "phuket",
    name: "Phuket",
    region: "Andaman Coast",
    description:
      "Phuket nightlife guide for Patong, Bangla Road, beach clubs, cocktail rooms, sunset bars, late-night lounges, and island safety notes.",
    targetVenueCount: 250,
    seedVenueCount: 250,
    accent: "from-emerald-500/20 to-cyan-500/10",
    href: "/phuket",
  },
  {
    slug: "chiang-mai",
    name: "Chiang Mai",
    region: "Northern Thailand",
    description:
      "Chiang Mai nightlife guide for Nimman, Old City, live music bars, jazz rooms, craft beer, cocktail bars, and quieter late-night options.",
    targetVenueCount: 250,
    seedVenueCount: 250,
    accent: "from-lime-500/20 to-amber-500/10",
    href: "/chiang-mai",
  },
];

export function getCityConfig(slug: string): CityConfig | null {
  return CITY_CONFIGS.find((city) => city.slug === slug) ?? null;
}

export function getCityStaticParams(): Array<{ city: CitySlug }> {
  return CITY_CONFIGS.map((city) => ({ city: city.slug }));
}
