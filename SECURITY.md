# Security Policy

## Supported scope

This repository includes:

- public Next.js application code
- admin moderation routes
- import pipeline logic
- Supabase integration

## Reporting a vulnerability

Do not open a public GitHub issue for security-sensitive findings.

For anything involving:

- admin access
- secrets exposure
- auth bypass
- SSRF / import abuse
- Supabase privilege misuse
- data leakage

report it privately to the repository owner first.

## Sensitive areas

The most sensitive parts of this codebase are:

- `/app/admin`
- `/app/api/admin-*`
- `/app/api/cron/import-events`
- `/lib/supabase`
- environment variable handling

## Secrets handling

Never commit:

- `.env.local`
- service role keys
- admin secrets
- OAuth client secrets
- private JSON credentials

If a secret was committed by mistake:

1. rotate it
2. remove it from git history if needed
3. redeploy affected services

## Production caution

Import and moderation bugs can become content-quality or trust problems even when they are not classic security bugs.

Treat these as high-sensitivity changes:

- auto-import source expansion
- dedup logic
- pending queue status handling
- anything that can auto-publish unsafe nightlife content
