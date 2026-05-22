# Contributing to ThaiNight

This repository powers `thainight.co`.

Before making changes, assume three things:

1. public pages are user-facing travel content
2. admin moderation flows are operationally sensitive
3. import logic can create noisy or misleading content if changed carelessly

## Local setup

```bash
cp .env.example .env.local
npm install
npm run dev
```

Useful local pages:

- `/`
- `/tonight`
- `/intel`
- `/admin?key=YOUR_ADMIN_SECRET_KEY`

## Required checks

Before opening a PR, run:

```bash
npm run lint
npm run build
```

If you changed import logic, also verify:

- `GET /api/cron/import-events`
- admin pending ordering
- event / offer queue behavior

## Commit guidance

Prefer small commits that isolate one type of change:

- import pipeline
- admin review workflow
- SEO / public page content
- Supabase migrations
- visual layout

Use clear commit messages. Avoid vague messages like `fix stuff`.

## Pull request guidance

A good PR should include:

- what changed
- why it changed
- risk level
- how it was validated

If a PR affects production content or moderation:

- say whether it changes public output
- say whether it changes pending queue behavior
- say whether a migration is required

## Things that should not be committed

- `.env.local`
- private JSON credentials
- local-only test repos
- machine-specific artifacts

## Review expectations

Changes will be reviewed for:

- correctness
- queue safety
- production content quality
- SEO side effects
- deploy risk
