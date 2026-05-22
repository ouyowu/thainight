// app/sitemap.ts
// Dynamic XML sitemap — covers all published venues, areas, cities
// Google re-crawls this on each build + ISR revalidation
// Priority: venue detail pages (0.9) > area pages (0.8) > city pages (0.7) > home (1.0)

import type { MetadataRoute } from "next";
import { siteBaseUrl } from "@/lib/config";
import { createAnonClient } from "@/lib/supabase/server";
import { SEO_CATEGORY_SLUGS } from "@/lib/seo-keywords";
import { SEO_INTENT_PAGES } from "@/lib/seo-intent-pages";

const BASE_URL = siteBaseUrl();

const CITIES = ["bangkok", "pattaya", "phuket", "chiang-mai"];

const AREA_SLUGS: Record<string, string[]> = {
  bangkok:      ["thonglor", "silom", "ekkamai", "asok", "ari", "rca", "sathorn"],
  pattaya:      ["walking-street", "jomtien", "central-pattaya", "north-pattaya"],
  phuket:       ["patong", "kata", "rawai", "chalong", "laguna"],
  "chiang-mai": ["nimman", "old-city", "riverside", "santitham"],
};

const CATEGORIES = SEO_CATEGORY_SLUGS;
const STATIC_PAGES = [
  { path: "/about", priority: 0.55, changeFrequency: "monthly" as const },
  { path: "/safety", priority: 0.55, changeFrequency: "monthly" as const },
  { path: "/contact", priority: 0.6, changeFrequency: "monthly" as const },
  { path: "/privacy", priority: 0.35, changeFrequency: "yearly" as const },
  { path: "/terms", priority: 0.35, changeFrequency: "yearly" as const },
];

type SitemapEntry = MetadataRoute.Sitemap[number];

export const revalidate = 3600; // rebuild sitemap hourly

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const entries: SitemapEntry[] = [];
  const now = new Date();

  // ── 1. Root pages ─────────────────────────────────────────────────────────
  entries.push({
    url:              `${BASE_URL}`,
    lastModified:     now,
    changeFrequency:  "daily",
    priority:         1.0,
  });

  entries.push({
    url:             `${BASE_URL}/events`,
    lastModified:    now,
    changeFrequency: "hourly",
    priority:        0.85,
  });

  entries.push({
    url:             `${BASE_URL}/offers`,
    lastModified:    now,
    changeFrequency: "hourly",
    priority:        0.8,
  });

  entries.push({
    url:             `${BASE_URL}/tonight`,
    lastModified:    now,
    changeFrequency: "daily",
    priority:        0.85,
  });

  entries.push({
    url:             `${BASE_URL}/intel`,
    lastModified:    now,
    changeFrequency: "daily",
    priority:        0.8,
  });

  entries.push({
    url:             `${BASE_URL}/news`,
    lastModified:    now,
    changeFrequency: "hourly",
    priority:        0.86,
  });

  entries.push({
    url:             `${BASE_URL}/explore`,
    lastModified:    now,
    changeFrequency: "weekly",
    priority:        0.65,
  });

  for (const page of SEO_INTENT_PAGES) {
    entries.push({
      url:             `${BASE_URL}/${page.slug}`,
      lastModified:    now,
      changeFrequency: "weekly",
      priority:        0.82,
    });
  }

  for (const page of STATIC_PAGES) {
    entries.push({
      url:             `${BASE_URL}${page.path}`,
      lastModified:    now,
      changeFrequency: page.changeFrequency,
      priority:        page.priority,
    });
  }

  // ── 2. City pages ─────────────────────────────────────────────────────────
  for (const city of CITIES) {
    entries.push({
      url:             `${BASE_URL}/${city}`,
      lastModified:    now,
      changeFrequency: "daily",
      priority:        0.7,
    });

    entries.push({
      url:             `${BASE_URL}/${city}/bars`,
      lastModified:    now,
      changeFrequency: "daily",
      priority:        0.75,
    });

    // ── 3. Area pages ──────────────────────────────────────────────────────
    for (const area of AREA_SLUGS[city] ?? []) {
      entries.push({
        url:             `${BASE_URL}/${city}/bars/${area}`,
        lastModified:    now,
        changeFrequency: "daily",
        priority:        0.8,
      });
    }

    // ── 4. Category pages ──────────────────────────────────────────────────
    for (const cat of CATEGORIES) {
      entries.push({
        url:             `${BASE_URL}/${city}/${cat}`,
        lastModified:    now,
        changeFrequency: "weekly",
        priority:        0.6,
      });
    }
  }

  entries.push({
    url:             `${BASE_URL}/bangkok/gentlemen-clubs`,
    lastModified:    now,
    changeFrequency: "weekly",
    priority:        0.55,
  });

  entries.push({
    url:             `${BASE_URL}/bangkok/gentlemen-clubs/sukhumvit`,
    lastModified:    now,
    changeFrequency: "weekly",
    priority:        0.55,
  });

  // ── 5. Venue detail pages (highest SEO value) ─────────────────────────────
  try {
    const supabase = createAnonClient();
    if (!supabase) return entries;

    const { data: venues } = await supabase
      .from("venues")
      .select("slug, city, area_slug, updated_at, last_verified_at")
      .eq("is_published", true)
      .eq("is_permanently_closed", false)
      .order("last_verified_at", { ascending: false });

    if (venues) {
      for (const v of venues) {
        entries.push({
          url: `${BASE_URL}/${v.city}/bars/${v.area_slug}/${v.slug}`,
          // Use last_verified_at so recently verified venues appear fresher to Google
          lastModified:    new Date(v.last_verified_at ?? v.updated_at ?? now),
          changeFrequency: "weekly",
          priority:        0.9,
        });
      }
    }
  } catch (err) {
    console.error("[sitemap] venue fetch failed:", err);
  }

  return entries;
}
