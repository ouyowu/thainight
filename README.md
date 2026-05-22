# Bangkok Nightlife Guide

Next.js 14 App Router directory: `/[city]/bars/[area]/[venue-slug]`, weighted scores, `SchemaOrg` (LocalBusiness-style JSON-LD), and **Verified This Week** from `updated_at` vs the week containing the reference date (default May 2026 — see `NEXT_PUBLIC_VERIFICATION_REFERENCE`).

## Supabase (from Claude zip)

1. Create a Supabase project.
2. In SQL Editor, run **in order**:
   - `supabase/migrations/001_schema.sql`
   - `supabase/migrations/002_fix_venue_updates_insert_policy.sql` (fixes `raid_alert` + `auto_applied` RLS)
3. Copy keys into `.env.local` (`NEXT_PUBLIC_*` and `SUPABASE_SERVICE_ROLE_KEY` for admin PATCH).

Without Supabase, **area bar pages** still render using in-repo mock data (`lib/venues.ts` + `lib/fallback-nightlife.ts`). `POST /api/submit-update` returns **503** until Supabase is configured.

## Local

```bash
cp .env.example .env.local
npm install
npm run dev
```

Try: [http://localhost:3000/bangkok/bars/thonglor](http://localhost:3000/bangkok/bars/thonglor) (rich area page) and [http://localhost:3000/bangkok/bars/thonglor/tropic-city](http://localhost:3000/bangkok/bars/thonglor/tropic-city) (venue detail).

## Deploy (Vercel)

1. Push this folder to GitHub/GitLab/Bitbucket.
2. [Vercel](https://vercel.com/new) → Import repository → Framework Preset: **Next.js**.
3. Environment variables (Production + Preview):
   - `NEXT_PUBLIC_APP_URL` or `NEXT_PUBLIC_SITE_URL` = public site URL (metadata + JSON-LD + Telegram links).
   - `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY` for live data + public submissions.
   - `SUPABASE_SERVICE_ROLE_KEY`, `ADMIN_SECRET_KEY` if you use `PATCH /api/submit-update`.
   - Optional Telegram + `NEXT_PUBLIC_VERIFICATION_REFERENCE` (venue badge anchor).
4. Deploy. After first deploy, set `NEXT_PUBLIC_SITE_URL` to the final URL and redeploy so `metadataBase` and JSON-LD URLs match.

## API

- `POST /api/submit-update` — validates payload, rate limits, inserts `venue_updates` (requires Supabase + migration **002** for `raid_alert`). Optional Telegram.
- `PATCH /api/submit-update?id=&action=approve|reject` — Bearer `ADMIN_SECRET_KEY`; uses **service role** client.
- `GET /api/venues?city=bangkok&category=bars` — mock list (legacy helper).

## Google Search Console report

Use OAuth, not service-account JSON keys. Create a Google Cloud OAuth Client for a desktop app, save the downloaded JSON as `secrets/gsc-oauth-client.json`, then run:

```bash
npm run gsc:auth
npm run gsc:report
```

The first command opens Google login once and stores a local refresh token in `secrets/gsc-oauth-token.json`. The second command writes `data/gsc-latest.json`.

## Docs

- Original Cursor bootstrap prompt: [docs/CURSOR_INIT_PROMPT.md](docs/CURSOR_INIT_PROMPT.md)
