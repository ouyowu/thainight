-- Context: ThaiNight Thailand nightlife hub | Current Date: May 2026 | Priority: auditable multi-city venue import pipeline.
-- Candidate table for crawled/API/manual venue leads before they become published venues.

CREATE TABLE IF NOT EXISTS venue_import_candidates (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

  city TEXT NOT NULL,
  area_slug TEXT,
  source_type TEXT NOT NULL CHECK (source_type IN (
    'google_places',
    'official_site',
    'instagram',
    'tourism_directory',
    'manual_research'
  )),
  source_name TEXT NOT NULL,
  source_url TEXT,
  source_place_id TEXT,

  name TEXT NOT NULL,
  slug TEXT,
  category TEXT,
  address TEXT,
  latitude NUMERIC(9,6),
  longitude NUMERIC(9,6),
  phone TEXT,
  website TEXT,
  instagram_handle TEXT,
  opening_hours TEXT,
  price_range TEXT,
  tags TEXT[] DEFAULT '{}',

  raw_payload JSONB NOT NULL DEFAULT '{}'::JSONB,
  confidence_score NUMERIC(4,2) CHECK (confidence_score BETWEEN 0 AND 10),
  dedupe_key TEXT,
  status TEXT NOT NULL DEFAULT 'new' CHECK (status IN (
    'new',
    'needs_review',
    'approved',
    'rejected',
    'imported'
  )),
  reviewed_by TEXT,
  reviewed_at TIMESTAMPTZ,

  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_venue_import_candidates_city_status
  ON venue_import_candidates (city, status, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_venue_import_candidates_dedupe
  ON venue_import_candidates (dedupe_key)
  WHERE dedupe_key IS NOT NULL;

CREATE UNIQUE INDEX IF NOT EXISTS uniq_venue_import_candidates_dedupe
  ON venue_import_candidates (dedupe_key)
  WHERE dedupe_key IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_venue_import_candidates_name_trgm
  ON venue_import_candidates USING GIN (name gin_trgm_ops);

DROP TRIGGER IF EXISTS venue_import_candidates_updated_at ON venue_import_candidates;
CREATE TRIGGER venue_import_candidates_updated_at
  BEFORE UPDATE ON venue_import_candidates
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

ALTER TABLE venue_import_candidates ENABLE ROW LEVEL SECURITY;

CREATE POLICY "venue_import_candidates_service_all" ON venue_import_candidates
  FOR ALL TO service_role
  USING (TRUE) WITH CHECK (TRUE);

COMMENT ON TABLE venue_import_candidates IS
  'Staging table for venue leads collected from allowed APIs, public sources, and manual research before publishing to venues.';
