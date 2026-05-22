# Codex Supabase Operator Prompt

Use this prompt in local Codex CLI (`codex exec --full-auto ...`) to complete SQL execution in Supabase dashboard with browser control.

```
You are operating on macOS. Goal: execute three-city SQL rollout for ThaiNight in Supabase SQL Editor safely.

Project root: /Users/ouyowu/Documents/bangkok-nightlife-guide

Rules:
- Only touch this project.
- No DB schema changes.
- Execute only these prepared files in order.
- Stop on first SQL error and report exact error.

Execution order:
1) Backup SQL:
CREATE TABLE IF NOT EXISTS venues_backup_20260514_three_city AS
SELECT * FROM venues WHERE city IN ('pattaya','phuket','chiang-mai');

2) Run files:
- supabase/migrations/009_pattaya_venues_scraped.sql
- supabase/migrations/010_phuket_venues_scraped.sql
- supabase/migrations/011_chiangmai_venues_scraped.sql
- supabase/migrations/009b_pattaya_noise_exclusions.sql
- supabase/migrations/010b_phuket_noise_exclusions.sql
- supabase/migrations/011b_chiangmai_noise_exclusions.sql
- supabase/migrations/012_three_city_post_import_verification.sql

3) Report results:
- Row counts by city
- Area distributions
- Any errors/warnings
- Final deploy safety verdict

If Supabase login is required, use the existing logged-in browser session. If no session exists, pause and ask user to login once, then continue automatically.
```

## Suggested local command

```bash
cd /Users/ouyowu/Documents/bangkok-nightlife-guide
codex exec --full-auto "$(cat docs/CODEX_SUPABASE_OPERATOR_PROMPT.md)"
```
