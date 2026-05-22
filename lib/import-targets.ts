// Context: ThaiNight Thailand nightlife hub | Current Date: May 2026 | Priority: auditable venue import targets.

import type { CitySlug } from "@/lib/cities";

export type ImportSourceType =
  | "google_places"
  | "official_site"
  | "instagram"
  | "tourism_directory"
  | "manual_research";

export type CityImportTarget = {
  city: CitySlug;
  targetCount: number;
  priorityAreas: string[];
  searchSeeds: string[];
  sourceTypes: ImportSourceType[];
};

export const CITY_IMPORT_TARGETS: CityImportTarget[] = [
  {
    city: "bangkok",
    targetCount: 300,
    priorityAreas: [
      "thonglor",
      "silom",
      "ekkamai",
      "asok",
      "nana",
      "ari",
      "rca",
      "sathorn",
      "sukhumvit",
      "khao-san",
    ],
    searchSeeds: [
      "Bangkok cocktail bars",
      "Bangkok rooftop bars",
      "Bangkok nightclubs",
      "Thonglor bars Bangkok",
      "Silom nightlife Bangkok",
      "Sukhumvit nightlife Bangkok",
    ],
    sourceTypes: ["google_places", "official_site", "instagram", "manual_research"],
  },
  {
    city: "pattaya",
    targetCount: 40,
    priorityAreas: ["walking-street", "soi-buakhao", "beach-road", "jomtien"],
    searchSeeds: [
      "Pattaya nightlife bars",
      "Walking Street Pattaya clubs",
      "Pattaya beach clubs",
    ],
    sourceTypes: ["google_places", "official_site", "manual_research"],
  },
  {
    city: "phuket",
    targetCount: 40,
    priorityAreas: ["patong", "bangla-road", "kata", "rawai", "kamala"],
    searchSeeds: [
      "Phuket nightlife bars",
      "Patong clubs",
      "Bangla Road bars Phuket",
      "Phuket beach clubs",
    ],
    sourceTypes: ["google_places", "official_site", "manual_research"],
  },
  {
    city: "chiang-mai",
    targetCount: 40,
    priorityAreas: ["nimman", "old-city", "night-bazaar", "riverside"],
    searchSeeds: [
      "Chiang Mai nightlife bars",
      "Nimman bars Chiang Mai",
      "Chiang Mai live music bars",
    ],
    sourceTypes: ["google_places", "official_site", "manual_research"],
  },
];

export function getImportTarget(city: string): CityImportTarget | null {
  return CITY_IMPORT_TARGETS.find((target) => target.city === city) ?? null;
}
