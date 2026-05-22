// Context: ThaiNight Thailand nightlife hub | Current Date: May 2026 | Priority: safe venue candidate ingestion.

import type {
  Json,
  VenueImportCandidateInsert,
  VenueImportSourceType,
} from "@/lib/database.types";
import { getCityConfig, type CitySlug } from "@/lib/cities";

const SOURCE_TYPES: VenueImportSourceType[] = [
  "google_places",
  "official_site",
  "instagram",
  "tourism_directory",
  "manual_research",
];

export type RawVenueCandidate = {
  city: string;
  name: string;
  area_slug?: string | null;
  source_type?: string | null;
  source_name?: string | null;
  source_url?: string | null;
  source_place_id?: string | null;
  category?: string | null;
  address?: string | null;
  latitude?: number | string | null;
  longitude?: number | string | null;
  phone?: string | null;
  website?: string | null;
  instagram_handle?: string | null;
  opening_hours?: string | null;
  price_range?: string | null;
  tags?: string[] | string | null;
  raw_payload?: Json;
  confidence_score?: number | string | null;
};

export type CandidateNormalizationResult =
  | { ok: true; candidate: VenueImportCandidateInsert }
  | { ok: false; error: string };

function trimOrNull(value: unknown): string | null {
  if (typeof value !== "string") return null;
  const trimmed = value.trim();
  return trimmed.length > 0 ? trimmed : null;
}

export function slugify(value: string): string {
  return value
    .normalize("NFKD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/&/g, " and ")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, 90);
}

function parseNumber(value: unknown): number | null {
  if (typeof value === "number" && Number.isFinite(value)) return value;
  if (typeof value !== "string") return null;
  const parsed = Number(value.trim());
  return Number.isFinite(parsed) ? parsed : null;
}

function parseTags(value: unknown): string[] {
  if (Array.isArray(value)) {
    return value
      .filter((tag): tag is string => typeof tag === "string")
      .map((tag) => slugify(tag))
      .filter(Boolean);
  }

  if (typeof value === "string") {
    return value
      .split(",")
      .map((tag) => slugify(tag))
      .filter(Boolean);
  }

  return [];
}

function parseSourceType(value: unknown): VenueImportSourceType {
  if (typeof value === "string") {
    const sourceType = value.trim() as VenueImportSourceType;
    if (SOURCE_TYPES.includes(sourceType)) return sourceType;
  }
  return "manual_research";
}

function normalizeCity(value: string): CitySlug | null {
  const slug = slugify(value);
  return getCityConfig(slug)?.slug ?? null;
}

export function buildDedupeKey({
  city,
  name,
  areaSlug,
  sourcePlaceId,
}: {
  city: string;
  name: string;
  areaSlug: string | null;
  sourcePlaceId: string | null;
}): string {
  if (sourcePlaceId) return `place:${sourcePlaceId}`;
  return [city, areaSlug ?? "unknown-area", slugify(name)].join(":");
}

export function normalizeVenueCandidate(
  raw: RawVenueCandidate
): CandidateNormalizationResult {
  const city = normalizeCity(raw.city);
  if (!city) return { ok: false, error: `Unsupported city: ${raw.city}` };

  const name = trimOrNull(raw.name);
  if (!name) return { ok: false, error: "Candidate name is required." };

  const areaSlug = trimOrNull(raw.area_slug)
    ? slugify(trimOrNull(raw.area_slug) ?? "")
    : null;
  const sourcePlaceId = trimOrNull(raw.source_place_id);
  const confidenceScore = parseNumber(raw.confidence_score);

  if (
    confidenceScore !== null &&
    (confidenceScore < 0 || confidenceScore > 10)
  ) {
    return { ok: false, error: `${name}: confidence_score must be 0-10.` };
  }

  const candidate: VenueImportCandidateInsert = {
    city,
    area_slug: areaSlug,
    source_type: parseSourceType(raw.source_type),
    source_name: trimOrNull(raw.source_name) ?? "manual import",
    source_url: trimOrNull(raw.source_url),
    source_place_id: sourcePlaceId,
    name,
    slug: slugify(name),
    category: trimOrNull(raw.category),
    address: trimOrNull(raw.address),
    latitude: parseNumber(raw.latitude),
    longitude: parseNumber(raw.longitude),
    phone: trimOrNull(raw.phone),
    website: trimOrNull(raw.website),
    instagram_handle: trimOrNull(raw.instagram_handle),
    opening_hours: trimOrNull(raw.opening_hours),
    price_range: trimOrNull(raw.price_range),
    tags: parseTags(raw.tags),
    raw_payload: raw.raw_payload ?? {},
    confidence_score: confidenceScore,
    dedupe_key: buildDedupeKey({
      city,
      name,
      areaSlug,
      sourcePlaceId,
    }),
    status: "new",
  };

  return { ok: true, candidate };
}

export function normalizeVenueCandidates(rawItems: RawVenueCandidate[]): {
  candidates: VenueImportCandidateInsert[];
  errors: string[];
} {
  const candidates: VenueImportCandidateInsert[] = [];
  const errors: string[] = [];

  rawItems.forEach((item, index) => {
    const result = normalizeVenueCandidate(item);
    if (result.ok) {
      candidates.push(result.candidate);
      return;
    }
    errors.push(`Row ${index + 1}: ${result.error}`);
  });

  return { candidates, errors };
}
