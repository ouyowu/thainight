#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { createClient } from "@supabase/supabase-js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = path.join(__dirname, "..");
const DRY_RUN = process.argv.includes("--dry-run");

// Context: ThaiNight social cleanup | May 2026 | Normalize obvious social links already present in website fields.
function readEnv() {
  const env = fs.readFileSync(path.join(PROJECT_ROOT, ".env.local"), "utf8");
  const get = (key) => env.match(new RegExp(`^${key}=(.*)$`, "m"))?.[1]?.trim();
  return {
    url: get("NEXT_PUBLIC_SUPABASE_URL"),
    serviceKey: get("SUPABASE_SERVICE_ROLE_KEY"),
  };
}

function classify(url) {
  const lower = (url ?? "").toLowerCase();
  if (lower.includes("instagram.com")) return "instagram";
  if (lower.includes("facebook.com") || lower.includes("fb.com")) return "facebook";
  return "website";
}

function instagramHandle(url) {
  const match = url?.match(/instagram\.com\/([^/?#]+)/i);
  const handle = match?.[1]?.replace(/^@/, "");
  if (!handle || ["p", "reel", "stories"].includes(handle.toLowerCase())) return null;
  return handle;
}

async function main() {
  const { url, serviceKey } = readEnv();
  if (!url || !serviceKey) throw new Error("Missing Supabase service credentials.");

  const supabase = createClient(url, serviceKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  const { data, error } = await supabase
    .from("venues")
    .select("id,slug,name,website,instagram_handle")
    .not("website", "is", null)
    .eq("is_published", true);
  if (error) throw error;

  const candidates = (data ?? [])
    .map((venue) => ({
      ...venue,
      kind: classify(venue.website),
      inferredInstagram: instagramHandle(venue.website),
    }));

  const facebookLinks = candidates.filter((venue) => venue.kind === "facebook").length;
  const instagramLinks = candidates.filter((venue) => venue.kind === "instagram").length;
  const updates = candidates.filter((venue) => !venue.instagram_handle && venue.inferredInstagram);

  console.log(JSON.stringify({
    published_with_website: candidates.length,
    facebook_links_in_website: facebookLinks,
    instagram_links_in_website: instagramLinks,
    instagram_handles_to_backfill: updates.length,
    dry_run: DRY_RUN,
  }, null, 2));

  for (const venue of updates.slice(0, 20)) {
    console.log(`- ${venue.name}: @${venue.inferredInstagram}`);
  }

  if (DRY_RUN) return;

  for (const venue of updates) {
    const { error: updateError } = await supabase
      .from("venues")
      .update({ instagram_handle: venue.inferredInstagram })
      .eq("id", venue.id);
    if (updateError) throw updateError;
  }

  console.log(`Updated ${updates.length} venue Instagram handles.`);
}

main().catch((error) => {
  console.error(error.message);
  process.exit(1);
});
