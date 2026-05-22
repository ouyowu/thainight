#!/usr/bin/env node
// scripts/generate-taglines.mjs
// Batch-generates SEO taglines for venues that have NULL taglines.
// If ANTHROPIC_API_KEY exists, it uses Claude for richer copy.
// Without an API key, it falls back to local template rules at $0 cost.
//
// Usage:
//   node scripts/generate-taglines.mjs
//   node scripts/generate-taglines.mjs --city bangkok
//   node scripts/generate-taglines.mjs --dry-run
//   node scripts/generate-taglines.mjs --local

import fs   from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Load env
const envPath = path.join(__dirname, "../.env.local");
let ANTHROPIC_KEY = process.env.ANTHROPIC_API_KEY;
let SUPABASE_URL, SUPABASE_SERVICE_KEY;

try {
  const env = fs.readFileSync(envPath, "utf8");
  ANTHROPIC_KEY    ??= env.match(/ANTHROPIC_API_KEY=(.+)/)?.[1]?.trim();
  SUPABASE_URL       = env.match(/NEXT_PUBLIC_SUPABASE_URL=(.+)/)?.[1]?.trim();
  SUPABASE_SERVICE_KEY = env.match(/SUPABASE_SERVICE_ROLE_KEY=(.+)/)?.[1]?.trim();
} catch {}

const BATCH_SIZE = 20;  // venues per Claude call
const DRY_RUN    = process.argv.includes("--dry-run");
const FORCE_LOCAL = process.argv.includes("--local");
const CITY_ARG   = process.argv.find((a,i) => process.argv[i-1]==="--city");

const CATEGORY_LABELS = {
  "cocktail-bar": "cocktail bar",
  "rooftop-bar": "rooftop bar",
  nightclub: "nightclub",
  "dive-bar": "pub and local bar",
  pub: "pub and local bar",
  "jazz-bar": "live music bar",
  "live-music-bar": "live music bar",
  "wine-bar": "wine bar",
  "sports-bar": "sports bar",
  karaoke: "karaoke venue",
  "hotel-bar": "hotel bar",
  "beach-club": "beach club",
};

function titleCaseArea(area) {
  return String(area ?? "Thailand")
    .split("-")
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join(" ");
}

// ─── Fetch venues without taglines ───────────────────────────────────────────

async function fetchVenuesWithoutTaglines(city) {
  const url = new URL(`${SUPABASE_URL}/rest/v1/venues`);
  url.searchParams.set("select", "id,slug,name,city,area_slug,category,score_foreigner_friendly,score_tourist_trap_risk,price_range,tags,overall_score");
  url.searchParams.set("tagline", "is.null");
  url.searchParams.set("is_published", "eq.true");
  if (city) url.searchParams.set("city", `eq.${city}`);
  url.searchParams.set("limit", "500");

  const res = await fetch(url.toString(), {
    headers: {
      apikey: SUPABASE_SERVICE_KEY,
      Authorization: `Bearer ${SUPABASE_SERVICE_KEY}`,
    },
  });
  if (!res.ok) throw new Error(`Supabase fetch failed: ${res.status}`);
  return res.json();
}

// ─── Generate taglines via Claude API ────────────────────────────────────────

async function generateTaglines(venues) {
  const venueList = venues.map((v, i) =>
    `${i+1}. Name: "${v.name}" | Area: ${v.area_slug} | Category: ${v.category} | Price: ${v.price_range ?? "฿฿"} | Tags: ${(v.tags??[]).join(",")} | Score: ${v.overall_score?.toFixed(1) ?? "N/A"} | ForeignerFriendly: ${v.score_foreigner_friendly?.toFixed(1)} | TouristTrap: ${v.score_tourist_trap_risk?.toFixed(1)}`
  ).join("\n");

  const prompt = `You are writing SEO-optimized taglines for a Thailand nightlife directory called ThaiNight.

For each venue below, write ONE concise tagline (max 100 chars) that:
- Is honest, specific, and compelling
- Mentions something distinctive (music type, crowd, vibe, location feature)
- Avoids generic phrases like "great atmosphere" or "must visit"
- Uses present tense
- Does NOT start with the venue name

Scoring context:
- TouristTrap score: LOW = good (e.g. 2.0 = not touristy), HIGH = bad (8.0 = tourist trap)
- ForeignerFriendly: how welcoming to non-Thais

Return ONLY a JSON array with objects: [{"id": "1", "tagline": "..."}]
No other text. Just the JSON array.

Venues:
${venueList}`;

  const res = await fetch("https://api.anthropic.com/v1/messages", {
    method: "POST",
    headers: {
      "Content-Type":      "application/json",
      "x-api-key":         ANTHROPIC_KEY,
      "anthropic-version": "2023-06-01",
    },
    body: JSON.stringify({
      model:      "claude-sonnet-4-20250514",
      max_tokens: 2000,
      messages:   [{ role: "user", content: prompt }],
    }),
  });

  if (!res.ok) throw new Error(`Claude API error: ${res.status}`);
  const data = await res.json();
  const text = data.content?.[0]?.text ?? "[]";

  try {
    const clean = text.replace(/```json|```/g, "").trim();
    return JSON.parse(clean);
  } catch {
    console.error("Failed to parse Claude response:", text.substring(0, 200));
    return [];
  }
}

// ─── Generate taglines locally, no paid API required ──────────────────────────

function generateLocalTaglines(venues) {
  return venues.map((venue, index) => {
    const category = CATEGORY_LABELS[venue.category] ?? String(venue.category).replace(/-/g, " ");
    const area = titleCaseArea(venue.area_slug);
    const price = venue.price_range ? `${venue.price_range} ` : "";
    const score = Number.isFinite(Number(venue.overall_score))
      ? `${Number(venue.overall_score).toFixed(1)}/10`
      : "verified";
    const touristTrapRisk = Number(venue.score_tourist_trap_risk);
    const lowTrap = Number.isFinite(touristTrapRisk) && touristTrapRisk <= 3.5;
    const foreignerFriendly = Number(venue.score_foreigner_friendly);
    const easyForVisitors = Number.isFinite(foreignerFriendly) && foreignerFriendly >= 7.5;

    let angle = `rated ${score} by ThaiNight data`;
    if (lowTrap) angle = `low tourist-trap risk, rated ${score}`;
    else if (easyForVisitors) angle = `foreigner-friendly, rated ${score}`;

    return {
      id: String(index + 1),
      tagline: `Verified ${price}${category} in ${area}, ${angle}.`,
    };
  });
}

// ─── Update taglines in Supabase ──────────────────────────────────────────────

async function updateTagline(venueId, tagline) {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/venues?id=eq.${venueId}`, {
    method: "PATCH",
    headers: {
      apikey:        SUPABASE_SERVICE_KEY,
      Authorization: `Bearer ${SUPABASE_SERVICE_KEY}`,
      "Content-Type": "application/json",
      Prefer:        "return=minimal",
    },
    body: JSON.stringify({ tagline }),
  });
  if (!res.ok) throw new Error(`Update failed for ${venueId}: ${res.status}`);
}

// ─── Main ─────────────────────────────────────────────────────────────────────

async function main() {
  if (!SUPABASE_URL || !SUPABASE_SERVICE_KEY) {
    console.error("❌ SUPABASE_URL or SERVICE_ROLE_KEY not found");
    process.exit(1);
  }

  const mode = ANTHROPIC_KEY && !FORCE_LOCAL ? "claude" : "local";
  console.log("✍️  ThaiNight Tagline Generator");
  console.log(`   City filter: ${CITY_ARG ?? "all"}`);
   console.log(`   Dry run: ${DRY_RUN}`);
  console.log(`   Mode: ${mode === "claude" ? "Claude API" : "local templates ($0)"}`);

  const venues = await fetchVenuesWithoutTaglines(CITY_ARG);
  console.log(`\n📍 Found ${venues.length} venues without taglines`);

  if (venues.length === 0) {
    console.log("✅ All venues already have taglines!");
    return;
  }

  const batches = Math.ceil(venues.length / BATCH_SIZE);
  if (mode === "claude") {
    const estTokens = venues.length * 60 + batches * 400; // rough estimate
    const estCost = (estTokens / 1_000_000) * 3.0; // Sonnet pricing
    console.log(`\n💰 Estimate: ${batches} API calls, ~${estTokens.toLocaleString()} tokens, ~$${estCost.toFixed(3)}`);
  } else {
    console.log("\n💰 Estimate: $0 — using local template rules");
  }

  if (DRY_RUN) {
    console.log("\n[DRY RUN] Would process these venues:");
    const preview = mode === "claude"
      ? venues.slice(0, 5).map((v) => ({ venue: v, tagline: "(Claude would generate this)" }))
      : generateLocalTaglines(venues.slice(0, 5)).map((item, index) => ({
          venue: venues[index],
          tagline: item.tagline,
        }));
    preview.forEach(({ venue, tagline }) => console.log(`  - ${venue.name} (${venue.area_slug}): ${tagline}`));
    if (venues.length > 5) console.log(`  ... and ${venues.length - 5} more`);
    return;
  }

  let updated = 0;
  let failed  = 0;

  for (let i = 0; i < venues.length; i += BATCH_SIZE) {
    const batch   = venues.slice(i, i + BATCH_SIZE);
    const batchNo = Math.floor(i / BATCH_SIZE) + 1;

    console.log(`\n📝 Batch ${batchNo}/${batches} (${batch.length} venues)...`);

    try {
      const taglines = mode === "claude"
        ? await generateTaglines(batch)
        : generateLocalTaglines(batch);

      for (const { id: indexStr, tagline } of taglines) {
        const idx   = parseInt(indexStr) - 1;
        const venue = batch[idx];
        if (!venue || !tagline) continue;

        if (DRY_RUN) {
          console.log(`  ✓ ${venue.name}: "${tagline}"`);
        } else {
          try {
            await updateTagline(venue.id, tagline);
            console.log(`  ✓ ${venue.name}: "${tagline.substring(0, 60)}..."`);
            updated++;
          } catch (err) {
            console.error(`  ❌ ${venue.name}: ${err.message}`);
            failed++;
          }
        }
      }

      // Rate limit: Claude calls need spacing. Local mode can continue immediately.
      if (mode === "claude" && batchNo < batches) {
        process.stdout.write("  ⏳ Waiting 1.5s...");
        await new Promise(r => setTimeout(r, 1500));
        process.stdout.write(" done\n");
      }

    } catch (err) {
      console.error(`  ❌ Batch ${batchNo} failed: ${err.message}`);
      failed += batch.length;
    }
  }

  console.log("\n" + "═".repeat(50));
  console.log(`✅ DONE: ${updated} taglines written, ${failed} failed`);
  console.log("═".repeat(50));
  console.log("\n🚀 Next: Review taglines at /admin or directly in Supabase");
  console.log("   SELECT name, tagline FROM venues WHERE verified_by='scraper' LIMIT 20;");
}

main().catch(err => {
  console.error("❌ Fatal:", err.message);
  process.exit(1);
});
