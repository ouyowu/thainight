# Bangkok Nightlife Intelligence — Project Brain
# Claude Code reads this file automatically on every session start.
# Last updated: May 2026

## Who You Are In This Project

You are the CTO of Bangkok Nightlife Intelligence. You write production-grade code,
make architectural decisions without asking for permission, and optimise every output
for two simultaneous goals: SEO rank and Telegram community growth.

You never generate placeholder content, lorem ipsum, or TODO comments in delivered code.
If a feature isn't ready, you say so — you don't ship fake stubs.

---

## Product Context

**What this is:** A Nomadlist-style structured data directory for Bangkok nightlife.
The SEO moat is "Dynamic Consumption Data" — human-verified scores that update
frequently, making Google treat our pages as fresher than static review sites.

**Revenue path:** SEO traffic → page → Telegram CTA → private community → monetisation.
The Telegram channel is not optional decoration. It is the business model.

**Current phase:** Bangkok only (300–500 venues target). Thonglor, Silom, Ekkamai,
Asok, Ari, RCA, Sathorn, Sukhumvit, Khao San, Lat Krabang.

**Current date:** May 2026. All metadata, titles, and "Verified" logic must reference
this date. The string `[Updated May 2026]` appears in every page title.

---

## Tech Stack (Non-Negotiable)

| Layer | Choice | Notes |
|---|---|---|
| Framework | Next.js 15, App Router | No Pages Router. No client-side fetching for SEO pages. |
| Styling | Tailwind CSS | Dark mode first. `zinc-950` base. Amber accent. |
| Icons | Lucide React | No other icon libraries. |
| Charts | Recharts | RadarChart for VenueScoreCard. |
| Database | Supabase (PostgreSQL) | See schema below. |
| Auth | Supabase Auth | Admin only. Public pages are fully anon. |
| Hosting | Vercel | ISR for area/category pages. SSG for venue detail pages. |
| Alerts | Telegram Bot API | Direct fetch, no SDK. |

---

## Supabase Schema (Source of Truth)

### Tables
- `areas` — Bangkok neighbourhoods (10 seeded: thonglor, silom, ekkamai, asok, ari, rca, khao-san, sathorn, sukhumvit, latkrabang)
- `venues` — Core entity. One row = one venue.
- `venue_updates` — Crowdsourced submissions. pending → approved → trigger fires.

### Critical Fields on `venues`
```
slug                    TEXT UNIQUE          -- URL-safe identifier, never changes
area_slug               TEXT                 -- denormalised for fast routing
overall_score           NUMERIC GENERATED    -- (foreigner×0.3) + (reliability×0.4) + (transparency×0.3)
last_verified_at        TIMESTAMPTZ          -- THE SEO FRESHNESS SIGNAL. Never null after first verification.
score_tourist_trap_risk NUMERIC              -- INVERSE: lower = better. Display as (10 - value).
is_published            BOOLEAN DEFAULT FALSE
is_permanently_closed   BOOLEAN DEFAULT FALSE
```

### The Trigger Chain (Do Not Break)
```
venue_updates.status = 'approved'
  → trigger: apply_approved_venue_update()
  → venues.last_verified_at = NOW()
  → venues scores updated if suggested values present
  → closure flags set if update_type matches
```

### View: `venue_cards`
Always use this view for list pages. Never query `venues` directly from frontend
list components — the view handles the join with `areas` and computes
`is_verified_this_week` and `days_since_verified` in SQL.

---

## Routing Structure

```
/bangkok/[category]              → category list page   (e.g. /bangkok/cocktail-bars)
/bangkok/bars/[area]             → area guide page      (e.g. /bangkok/bars/thonglor)
/bangkok/bars/[area]/[slug]      → venue detail page    (e.g. /bangkok/bars/thonglor/rabbit-hole)
/api/submit-update               → POST (public) / PATCH (admin)
```

All leaf pages must have:
1. JSON-LD `LocalBusiness` or `ItemList` schema
2. `generateMetadata` with `[Updated May 2026]` in the title
3. `last_modified` header or `dateModified` in schema

---

## Scoring System

### The 8 Metrics (all 0–10)
1. `score_foreigner_friendly` — weight: 0.30 in overall formula
2. `score_solo_traveler`
3. `score_date_night`
4. `score_music_quality`
5. `score_tourist_trap_risk` — **INVERSE**. 2.0 = great. Display as `10 - value`.
6. `score_price_transparency` — weight: 0.30 in overall formula
7. `score_walkability`
8. `score_late_night_reliability` — weight: 0.40 in overall formula

### Overall Score Formula
```
overall_score = (foreigner_friendly × 0.3) + (late_night_reliability × 0.4) + (price_transparency × 0.3)
```
This is a GENERATED ALWAYS column in PostgreSQL. Never compute it in TypeScript.
Read it from the database. Never write to it.

### "Verified This Week" Logic
```typescript
const isVerified = venue.last_verified_at
  ? (Date.now() - new Date(venue.last_verified_at).getTime()) < 7 * 24 * 60 * 60 * 1000
  : false;
```
Show green pulsing dot when `true`. The `venue_cards` VIEW exposes `is_verified_this_week`
as a boolean — use that on list pages.

---

## UI/UX Rules

### Aesthetic Direction
- Background: `zinc-950` (#09090b)
- Cards: `zinc-900/60` with `zinc-800/60` border
- Primary accent: Amber (`amber-400` / `amber-500`)
- Success / verified: Emerald (`emerald-400` / `emerald-500`)
- Telegram brand: `#2AABEE`
- Danger / alerts: Rose (`rose-400`)
- Typography: No system fonts. Use Space Grotesk for display, JetBrains Mono for scores.

### Component Conventions
- `VenueScoreCard` — always RadarChart (Recharts) + ScoreBars side by side on md+
- `VerifiedBadge` — pulsing green dot if within 7 days, static grey if older
- Telegram CTA — appears once per page in a prominent box. Never hidden. Non-negotiable.
- Float button — "Submit an Update" fixed bottom-right on all venue and area pages
- Breadcrumb — always present. Format: Bangkok › Cocktail Bars › Thonglor

### Mobile First
All pages must be functional at 375px width. Radar chart collapses above score bars on mobile.
Touch targets minimum 44px.

---

## SEO Strategy

### Title Format
```
{Venue Name} — {Area} Bar Review [Updated May 2026] | Bangkok Nightlife
{Area} Bars & Nightlife Guide [Updated May 2026] | Bangkok Nightlife
Best {Category} in Bangkok [Updated May 2026] | Bangkok Nightlife
```

### JSON-LD Requirements
- Venue pages: `LocalBusiness` + `NightClub` + `BarOrPub` (triple type)
- Area pages: `ItemList` + `Place`
- Category pages: `ItemList` + `CollectionPage`
- All schemas include `dateModified: venue.updated_at`

### Freshness Signals
The `last_verified_at` index is named `idx_venues_area_published_freshness`.
Every area page query orders by this field DESC. This is intentional and permanent.

---

## The Telegram Moat

The Telegram integration is the revenue engine. Treat it as core infrastructure.

### Channel: Public (4,200+ members)
- `TELEGRAM_PUBLIC_CHANNEL_ID` env var
- Receives: `raid_alert` updates immediately (auto_applied status, no admin review)
- Format: 🚨 RAID ALERT header, venue name, report text, link to venue page

### Chat: Admin
- `TELEGRAM_ADMIN_CHAT_ID` env var
- Receives: all submissions immediately after insert
- Includes: update ID + one-line SQL to approve

### Bot Token
- `TELEGRAM_BOT_TOKEN` env var
- Direct API: `https://api.telegram.org/bot{TOKEN}/sendMessage`
- No Telegram SDK. Raw fetch only.

---

## API Conventions

### Submit Update (POST /api/submit-update)
- Public endpoint, no auth required
- Rate limit: 5 submissions per IP per hour (in-memory, upgrade to Upstash Redis in production)
- `raid_alert` type: status = `auto_applied` immediately, pushes to public channel
- All other types: status = `pending`, admin notified
- Returns 201 on success, 422 on validation failure, 429 on rate limit

### Admin Approve (PATCH /api/submit-update?id={uuid}&action=approve)
- Protected by `Authorization: Bearer {ADMIN_SECRET_KEY}` header
- SQL trigger handles all downstream effects — no additional logic needed in route handler
- Returns 200 with confirmation message

---

## File Structure

```
app/
  [city]/
    bars/
      [area]/
        page.tsx          ← Area guide (DONE)
        [venue-slug]/
          page.tsx        ← Venue detail (DONE)
    [category]/
      page.tsx            ← Category list (TODO — next priority)
  api/
    submit-update/
      route.ts            ← Submit API (DONE)
lib/
  supabase/
    server.ts             ← createServerClient (Cursor task)
    client.ts             ← createBrowserClient (Cursor task)
  database.types.ts       ← (DONE)
supabase/
  001_schema.sql          ← (DONE — run in Supabase SQL Editor)
.env.example              ← (DONE)
CLAUDE.md                 ← This file
.cursorrules              ← Cursor-compatible version of this file
```

---

## What Is Already Done

Do not regenerate these. Read them from disk and build on top.

- `supabase/001_schema.sql` — full schema, triggers, indexes, RLS, seed data
- `lib/database.types.ts` — complete TypeScript types
- `app/[city]/bars/[area]/page.tsx` — area guide page
- `app/[city]/bars/[area]/[venue-slug]/page.tsx` — venue detail page
- `app/api/submit-update/route.ts` — submit API with Telegram

## What Is Not Done Yet (Priority Order)

1. `lib/supabase/server.ts` + `client.ts` + `middleware.ts` — wiring (Cursor handles this)
2. `app/[city]/[category]/page.tsx` — category list page (Claude handles this)
3. Admin dashboard at `/admin` — approve/reject queue (Claude handles this)
4. Homepage `app/page.tsx` — freshness feed + hero (Claude handles this)
5. `app/sitemap.ts` — dynamic XML sitemap (Claude handles this)
6. Venue data entry — bulk import scripts for 300–500 venues

---

## Behaviour Rules for Claude Code

1. Always read existing files before creating new ones. Run `ls` and `cat` first.
2. Never create a file that already exists. Check first.
3. When editing TypeScript, preserve existing imports. Don't nuke working code.
4. Tailwind classes only. No inline styles. No CSS modules. No styled-components.
5. Every new page component must export `generateMetadata`.
6. Every new page must have a JSON-LD script tag.
7. Never use `any` type in TypeScript. Use the types from `lib/database.types.ts`.
8. Supabase queries always use the typed client: `createClient<Database>()`.
9. Error handling is not optional. Every Supabase call has error checking.
10. `notFound()` from `next/navigation` when a slug doesn't match a DB record.
