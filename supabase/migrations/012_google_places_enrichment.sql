-- Google Places enrichment cache for ThaiNight.co
-- Context: May 2026 | Use Google credits to refresh facts, but keep Google-owned
-- photos/reviews as expiring references instead of permanent owned content.

ALTER TABLE venues
  ADD COLUMN IF NOT EXISTS google_rating NUMERIC(3,2),
  ADD COLUMN IF NOT EXISTS google_user_ratings_total INTEGER,
  ADD COLUMN IF NOT EXISTS google_last_fetched_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS google_cache_expires_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS google_photo_names TEXT[] DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS google_review_signals JSONB DEFAULT '{}'::jsonb,
  ADD COLUMN IF NOT EXISTS data_quality_flags TEXT[] DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS static_map_url TEXT;

COMMENT ON COLUMN venues.google_place_id IS
  'Google Place ID. Place IDs can be stored and refreshed; refresh old IDs periodically.';
COMMENT ON COLUMN venues.google_photo_names IS
  'Google Places photo resource names only. Do not download/rehost Google photos as ThaiNight-owned media.';
COMMENT ON COLUMN venues.google_review_signals IS
  'ThaiNight-owned derived risk signals from review keywords. Do not store raw Google review text here.';
COMMENT ON COLUMN venues.google_cache_expires_at IS
  'Expiry reminder for Google-derived facts. Refresh or stop using stale Google-owned content.';

CREATE TABLE IF NOT EXISTS google_places_enrichment_runs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  city TEXT,
  requested_limit INTEGER NOT NULL DEFAULT 0,
  fetched_count INTEGER NOT NULL DEFAULT 0,
  updated_count INTEGER NOT NULL DEFAULT 0,
  skipped_count INTEGER NOT NULL DEFAULT 0,
  error_count INTEGER NOT NULL DEFAULT 0,
  include_reviews BOOLEAN NOT NULL DEFAULT FALSE,
  apply_score_adjustments BOOLEAN NOT NULL DEFAULT FALSE,
  started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  finished_at TIMESTAMPTZ,
  notes TEXT
);

ALTER TABLE google_places_enrichment_runs ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "google_places_enrichment_runs_service_write" ON google_places_enrichment_runs;
CREATE POLICY "google_places_enrichment_runs_service_write"
  ON google_places_enrichment_runs
  FOR ALL
  USING (auth.role() = 'service_role')
  WITH CHECK (auth.role() = 'service_role');
