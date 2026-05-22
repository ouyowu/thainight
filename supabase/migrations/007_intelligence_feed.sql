-- ============================================================
-- Thailand Nightlife Intelligence — Signal Feed
-- File: 007_intelligence_feed.sql
-- Run after 006_auth.sql
-- ============================================================

-- Stores imported intelligence items for ThaiNight.
CREATE TABLE IF NOT EXISTS intelligence_feed (
  id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  radarscout_id       TEXT NOT NULL UNIQUE,   -- Legacy import ID / dedup key

  -- Source
  source              TEXT NOT NULL DEFAULT 'reddit',
  subreddit           TEXT,
  title               TEXT NOT NULL,
  url                 TEXT NOT NULL,
  body_snippet        TEXT,
  author              TEXT,
  posted_at           TIMESTAMPTZ,
  reddit_score        INTEGER,
  comment_count       INTEGER,

  -- Relevance scores
  city                TEXT,                   -- 'bangkok' | 'pattaya' | 'phuket' | 'chiang-mai'
  area                TEXT,
  venue_type          TEXT,
  travel_intent       NUMERIC(4,3),           -- 0.000–1.000
  credibility         NUMERIC(4,3),
  thainight_value     NUMERIC(4,3),           -- PRIMARY sort key — higher = more relevant
  sentiment           TEXT,                   -- 'positive' | 'negative' | 'neutral'
  extracted_venues    TEXT[] DEFAULT '{}',    -- venue names extracted by AI

  -- thainight venue match
  matched_venue_slug  TEXT REFERENCES venues(slug) ON DELETE SET NULL,
  matched_confidence  NUMERIC(4,3),

  -- Flags
  is_raid_alert       BOOLEAN NOT NULL DEFAULT FALSE,
  is_displayed        BOOLEAN NOT NULL DEFAULT TRUE,   -- admin can suppress

  -- Audit
  received_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  telegram_sent_at    TIMESTAMPTZ
);

-- Indexes for feed queries
CREATE INDEX idx_intel_city_value
  ON intelligence_feed (city, thainight_value DESC, received_at DESC)
  WHERE is_displayed = TRUE;

CREATE INDEX idx_intel_venue
  ON intelligence_feed (matched_venue_slug, received_at DESC)
  WHERE matched_venue_slug IS NOT NULL;

CREATE INDEX idx_intel_raids
  ON intelligence_feed (is_raid_alert, received_at DESC)
  WHERE is_raid_alert = TRUE;

CREATE INDEX idx_intel_recent
  ON intelligence_feed (received_at DESC)
  WHERE is_displayed = TRUE;

-- RLS
ALTER TABLE intelligence_feed ENABLE ROW LEVEL SECURITY;

-- Public can read displayed items
CREATE POLICY "intel_public_read" ON intelligence_feed
  FOR SELECT TO anon, authenticated
  USING (is_displayed = TRUE);

-- Service role writes (webhook handler uses service role)
CREATE POLICY "intel_service_write" ON intelligence_feed
  FOR ALL TO service_role
  USING (TRUE) WITH CHECK (TRUE);

-- View for thainight city pages — recent high-value signals
CREATE OR REPLACE VIEW city_intelligence AS
SELECT
  i.id,
  i.radarscout_id,
  i.subreddit,
  i.title,
  i.url,
  i.body_snippet,
  i.posted_at,
  i.reddit_score,
  i.city,
  i.area,
  i.venue_type,
  i.thainight_value,
  i.sentiment,
  i.extracted_venues,
  i.is_raid_alert,
  i.matched_venue_slug,
  i.matched_confidence,
  v.name  AS matched_venue_name,
  i.received_at,
  -- Freshness bucket for UI
  CASE
    WHEN i.received_at >= NOW() - INTERVAL '6 hours'  THEN 'hot'
    WHEN i.received_at >= NOW() - INTERVAL '24 hours' THEN 'recent'
    ELSE 'older'
  END AS freshness
FROM intelligence_feed i
LEFT JOIN venues v ON v.slug = i.matched_venue_slug
WHERE i.is_displayed = TRUE
  AND i.thainight_value >= 0.60
ORDER BY i.is_raid_alert DESC, i.thainight_value DESC, i.received_at DESC;

COMMENT ON VIEW city_intelligence IS
  'High-value intelligence items for display on city pages and venue detail pages. '
  'Minimum thainight_value: 0.60. Raid alerts always floated to top.';
