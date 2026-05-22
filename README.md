# ThaiNight

ThaiNight is a Thailand nightlife discovery platform for travelers who want to decide where to go out tonight, what to avoid, and which events or offers are worth attention.

Live site:

- `https://thainight.co`

Repository:

- `https://github.com/ouyowu/thainight`

## What the product does

ThaiNight combines nightlife content, event discovery, and review workflows into one site:

- tonight events by city
- approved bar and club offers
- nightlife warnings and price tips
- city nightlife guides
- solo traveler / going-out context
- admin moderation for imported nightlife signals

## Main product areas

Public pages:

- `/`
- `/tonight`
- `/intel`
- `/news`
- `/offers`
- `/events`
- `/bangkok`
- `/pattaya`
- `/phuket`
- `/chiang-mai`

Admin / internal routes:

- `/admin?key=YOUR_ADMIN_SECRET_KEY`
- `GET /api/cron/import-events`
- `POST /api/admin-intel`
- `POST /api/admin-signal`
- `POST /api/admin-verification`
- `GET /api/thainight/intelligence`

## Stack

- Next.js 14
- React 18
- Tailwind CSS
- Supabase
- Vercel

## Import and review model

ThaiNight does not treat raw imports as publish-ready content.

Current workflow:

1. import events and offers from approved sources
2. store candidates in pending queues
3. review in admin
4. approve only the items worth showing publicly

The production import route is:

- `GET /api/cron/import-events`

Current import behavior:

- discovers event URLs from approved source pages
- parses event metadata
- upserts `event_flyers`
- extracts offer candidates into `venue_offers`
- imports RSS items into `intelligence_feed`

Recent queue logic improvements:

- pending queues sort by `updated_at` first
- cron result distinguishes `inserted` vs `updated`
- duplicate-history cases around `source_url` no longer assume a single-row match

## Local development

```bash
cp .env.example .env.local
npm install
npm run dev
```

Open:

- `http://localhost:3000`
- `http://localhost:3000/admin?key=YOUR_ADMIN_SECRET_KEY`

## Environment variables

Minimum local variables:

```bash
NEXT_PUBLIC_SITE_URL=http://localhost:3000
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=
ADMIN_SECRET_KEY=
```

Optional import variables:

```bash
EVENT_SOURCE_PAGES=
EVENT_AUTO_IMPORT_HOSTS=
NIGHTLIFE_RSS_FEEDS=
NIGHTLIFE_RSS_IMPORT_LIMIT=
CRON_SECRET=
```

## Build and validation

```bash
npm run lint
npm run build
```

## Git and deployment

The project is now connected to:

- GitHub repository: `ouyowu/thainight`
- Vercel project: `thainight`

Pushes to `main` now trigger Vercel production deployments automatically.

## CI

GitHub Actions runs on:

- pushes to `main`
- pull requests targeting `main`

Current checks:

- `npm run lint`
- `npm run build`

Workflow file:

- `.github/workflows/ci.yml`

## Collaboration notes

If someone else works on this project, they should:

1. clone the repository
2. copy `.env.example` to `.env.local`
3. install dependencies with `npm install`
4. run `npm run dev`
5. verify the admin route and at least one city page before changing import logic

When changing import or admin queue behavior:

- run `npm run lint`
- run `npm run build`
- verify `/api/cron/import-events`
- check pending ordering in `/admin`

Do not commit:

- `.env.local`
- private JSON credentials
- local machine-only nested repos

Prefer small commits for:

- import pipeline changes
- Supabase migration changes
- SEO page generation
- admin moderation workflow

## Notes

- `codex_test/` is intentionally ignored as a local nested test repo
- production content quality depends on manual review, not raw auto-publish
