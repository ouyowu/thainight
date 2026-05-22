#!/usr/bin/env node

import fs from "node:fs";
import { createClient } from "@supabase/supabase-js";

// Context: ThaiNight SEO fallback | May 2026 | no external AI key required
// Generates concise, factual taglines so scraped venue pages are not empty.
const CATEGORY_LABELS = {
  "cocktail-bar": "cocktail bar",
  "rooftop-bar": "rooftop bar",
  nightclub: "nightclub",
  "dive-bar": "pub and local bar",
  "jazz-bar": "live music bar",
  "wine-bar": "wine bar",
  "sports-bar": "sports bar",
  karaoke: "karaoke venue",
  "hotel-bar": "hotel bar",
  "beach-club": "beach club",
};

function readEnv() {
  const env = fs.readFileSync(".env.local", "utf8");
  const get = (key) => env.match(new RegExp(`^${key}=(.*)$`, "m"))?.[1]?.trim();
  return {
    url: get("NEXT_PUBLIC_SUPABASE_URL"),
    serviceKey: get("SUPABASE_SERVICE_ROLE_KEY"),
  };
}

function titleCaseArea(area) {
  return area
    .split("-")
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join(" ");
}

function makeTagline(venue) {
  const category = CATEGORY_LABELS[venue.category] ?? venue.category.replace(/-/g, " ");
  const area = titleCaseArea(venue.area_slug);
  const score = venue.overall_score ? `${Number(venue.overall_score).toFixed(1)}/10` : "verified";
  return `Verified ${category} in ${area}, rated ${score} by ThaiNight data.`;
}

async function main() {
  const { url, serviceKey } = readEnv();
  if (!url || !serviceKey) throw new Error("Missing Supabase env vars.");

  const supabase = createClient(url, serviceKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  const { data, error } = await supabase
    .from("venues")
    .select("id,name,area_slug,category,overall_score,tagline")
    .eq("verified_by", "scraper")
    .is("tagline", null)
    .limit(1000);

  if (error) throw error;
  console.log(`Found ${data.length} scraped venues without taglines.`);

  let updated = 0;
  for (const venue of data) {
    const { error: updateError } = await supabase
      .from("venues")
      .update({ tagline: makeTagline(venue) })
      .eq("id", venue.id);
    if (updateError) throw updateError;
    updated++;
  }

  console.log(`Updated ${updated} taglines.`);
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : error);
  process.exit(1);
});
