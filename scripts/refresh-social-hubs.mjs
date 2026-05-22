#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { createClient } from "@supabase/supabase-js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, "..");

// Context: ThaiNight Social Hub | May 2026 | Pick daily social anchors by popularity and score.

function env(name) {
  const raw = fs.readFileSync(path.join(ROOT, ".env.local"), "utf8");
  return raw.match(new RegExp(`^${name}=(.*)$`, "m"))?.[1]?.trim().replace(/^["']|["']$/g, "");
}

async function main() {
  const supabase = createClient(env("NEXT_PUBLIC_SUPABASE_URL"), env("SUPABASE_SERVICE_ROLE_KEY"), {
    auth: { persistSession: false, autoRefreshToken: false },
  });
  const { data, error } = await supabase
    .from("venues")
    .select("id, city, page_views, overall_score")
    .eq("is_published", true)
    .eq("is_permanently_closed", false);
  if (error) throw error;

  const byCity = new Map();
  for (const venue of data ?? []) {
    const list = byCity.get(venue.city) ?? [];
    list.push(venue);
    byCity.set(venue.city, list);
  }

  const chosen = [];
  for (const venues of byCity.values()) {
    venues.sort((a, b) => {
      const scoreA = Number(a.page_views ?? 0) * 10 + Number(a.overall_score ?? 0);
      const scoreB = Number(b.page_views ?? 0) * 10 + Number(b.overall_score ?? 0);
      return scoreB - scoreA;
    });
    chosen.push(...venues.slice(0, 3).map((venue) => venue.id));
  }

  await supabase.from("venues").update({ is_trending: false }).neq("id", "00000000-0000-0000-0000-000000000000");
  if (chosen.length > 0) {
    await supabase.from("venues").update({ social_enabled: true, is_trending: true }).in("id", chosen);
  }
  console.log(JSON.stringify({ promoted: chosen.length }, null, 2));
}

main().catch((error) => {
  console.error(error.message);
  process.exit(1);
});
