# Three-City Import Runbook (Pattaya / Phuket / Chiang Mai)

Updated: 2026-05-14

This runbook executes all prepared import + cleanup SQL in safe order, then runs read-only verification checks.

## 0) Files prepared

### Main imports
- `supabase/migrations/009_pattaya_venues_scraped.sql`
- `supabase/migrations/010_phuket_venues_scraped.sql`
- `supabase/migrations/011_chiangmai_venues_scraped.sql`

### Conservative cleanup (recommended)
- `supabase/migrations/009b_pattaya_noise_exclusions.sql`
- `supabase/migrations/010b_phuket_noise_exclusions.sql`
- `supabase/migrations/011b_chiangmai_noise_exclusions.sql`

### Manual candidate cleanup (optional)
- `supabase/migrations/009c_pattaya_manual_exclusions.sql`
- `supabase/migrations/010c_phuket_manual_exclusions.sql`
- `supabase/migrations/011c_chiangmai_manual_exclusions.sql`

### Post-import verification
- `supabase/migrations/012_three_city_post_import_verification.sql`

---

## 1) Backup (required)

Run once before imports:

```sql
CREATE TABLE IF NOT EXISTS venues_backup_20260514_three_city AS
SELECT *
FROM venues
WHERE city IN ('pattaya', 'phuket', 'chiang-mai');
```

---

## 2) Execute main imports

Run in order:
1. `009_pattaya_venues_scraped.sql`
2. `010_phuket_venues_scraped.sql`
3. `011_chiangmai_venues_scraped.sql`

---

## 3) Execute conservative cleanup

Run in order:
1. `009b_pattaya_noise_exclusions.sql`
2. `010b_phuket_noise_exclusions.sql`
3. `011b_chiangmai_noise_exclusions.sql`

---

## 4) (Optional) Execute manual candidate cleanup

Only if you decide to remove aggressive candidates:
1. `009c_pattaya_manual_exclusions.sql`
2. `010c_phuket_manual_exclusions.sql`
3. `011c_chiangmai_manual_exclusions.sql`

---

## 5) Run verification pack

Execute:
- `012_three_city_post_import_verification.sql`

Expected checks:
- City totals are non-zero and close to scraped sources
- Area distributions look reasonable
- No obvious duplicate clusters
- Missing geo/place IDs remain low
- Freshness coverage (`last_verified_at`) present

---

## 6) Rollback plan (if needed)

```sql
BEGIN;
DELETE FROM venues WHERE city IN ('pattaya', 'phuket', 'chiang-mai');
INSERT INTO venues
SELECT *
FROM venues_backup_20260514_three_city;
COMMIT;
```

---

## 7) Deployment gate

Safe to deploy when all are true:
- Main import + conservative cleanup completed without SQL errors
- Verification SQL has no critical anomalies
- Frontend build passes (`npm run build`)
- Sitemap/robots unchanged or valid
