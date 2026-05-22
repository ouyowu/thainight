#!/usr/bin/env bash
set -euo pipefail

# Execute three-city import + cleanup SQL against Supabase Postgres.
# Requires: psql and SUPABASE_DB_URL in env.

if ! command -v psql >/dev/null 2>&1; then
  echo "ERROR: psql not found. Install PostgreSQL client first." >&2
  exit 1
fi

if [[ -z "${SUPABASE_DB_URL:-}" ]]; then
  echo "ERROR: SUPABASE_DB_URL is not set." >&2
  echo "Example: export SUPABASE_DB_URL='postgresql://postgres:<PASSWORD>@db.<PROJECT>.supabase.co:5432/postgres?sslmode=require'" >&2
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

run_sql() {
  local file="$1"
  echo "\n==> Running $file"
  psql "$SUPABASE_DB_URL" -v ON_ERROR_STOP=1 -f "$file"
}

echo "==> Creating backup table"
psql "$SUPABASE_DB_URL" -v ON_ERROR_STOP=1 <<'SQL'
CREATE TABLE IF NOT EXISTS venues_backup_20260514_three_city AS
SELECT *
FROM venues
WHERE city IN ('pattaya', 'phuket', 'chiang-mai');
SQL

# Main imports
run_sql "supabase/migrations/009_pattaya_venues_scraped.sql"
run_sql "supabase/migrations/010_phuket_venues_scraped.sql"
run_sql "supabase/migrations/011_chiangmai_venues_scraped.sql"

# Conservative cleanup
run_sql "supabase/migrations/009b_pattaya_noise_exclusions.sql"
run_sql "supabase/migrations/010b_phuket_noise_exclusions.sql"
run_sql "supabase/migrations/011b_chiangmai_noise_exclusions.sql"

# Read-only verification pack
run_sql "supabase/migrations/012_three_city_post_import_verification.sql"

echo "\n✅ Done: three-city import + conservative cleanup + verification"
