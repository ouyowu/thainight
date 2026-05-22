# ThaiNight

ThaiNight is a Thailand nightlife discovery platform focused on:

- tonight events
- approved offers
- nightlife intel and warnings
- city nightlife guides
- solo traveler / going-out context

The current production domain is:

- `https://thainight.co`

## Stack

- Next.js 14
- React 18
- Tailwind CSS
- Supabase
- Vercel

## Core areas

- Public site pages for Bangkok, Pattaya, Phuket, and Chiang Mai
- Admin review queue for pending event flyers, offers, and intel
- Cron-driven event import pipeline
- RSS / nightlife source ingestion
- SEO landing pages for nightlife search intent

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

Optional import and automation variables:

```bash
EVENT_SOURCE_PAGES=
EVENT_AUTO_IMPORT_HOSTS=
NIGHTLIFE_RSS_FEEDS=
NIGHTLIFE_RSS_IMPORT_LIMIT=
CRON_SECRET=
```

## Important routes

Public:

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

Admin / API:

- `/admin?key=YOUR_ADMIN_SECRET_KEY`
- `GET /api/cron/import-events`
- `POST /api/admin-intel`
- `POST /api/admin-signal`
- `POST /api/admin-verification`
- `GET /api/thainight/intelligence`

## Import pipeline

The production import route is:

- `GET /api/cron/import-events`

Current behavior:

- discovers event URLs from approved source pages
- parses event metadata
- upserts `event_flyers`
- extracts offer candidates into `venue_offers`
- imports RSS items into `intelligence_feed`

Recent fix:

- admin pending queues now sort by `updated_at` first
- cron result now distinguishes inserted vs updated records
- duplicate-history cases around `source_url` no longer rely on a single-row assumption

## Admin review workflow

Typical daily workflow:

1. Open `/admin?key=...`
2. Review `Pending Event Flyers`
3. Review `Pending Offers`
4. Move useful intel into openings / warnings / price tips as needed

## Build and validation

```bash
npm run lint
npm run build
```

## Deployment

This project is configured for Vercel and linked to the `thainight` Vercel project.

Typical deployment options:

1. Push to GitHub and let Vercel deploy from the connected repository
2. Deploy manually from the project root with Vercel CLI

## Repository

GitHub repository:

- `https://github.com/ouyowu/thainight`

## Collaboration

If someone else needs to work on this project, they should follow this order:

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
- local machine-only test repos

Prefer small commits with clear messages, especially for:

- import pipeline changes
- Supabase migration changes
- SEO page generation
- admin moderation workflow

## Notes

- `codex_test/` is intentionally ignored as a local nested test repo
- local secrets should stay out of git
- production content quality depends on manual review, not raw auto-publish
