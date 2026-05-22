-- ============================================================
-- 001_schema.sql
-- ============================================================
-- ============================================================
-- Bangkok Nightlife Intelligence — Supabase Schema
-- File: 001_schema.sql
-- Run this in Supabase SQL Editor (Dashboard → SQL Editor → New Query)
-- Context: Bangkok Nightlife SEO Hub | Current Date: May 2026 | Priority: freshness & scorable venue data.
-- Creates venues, venue_updates, RLS, indexes, and venue_cards view for SEO-first nightlife pages.
-- ============================================================

-- ── Extensions ───────────────────────────────────────────────
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";     -- fuzzy search on venue names
CREATE EXTENSION IF NOT EXISTS "unaccent";     -- normalize Thai-romanized slugs

-- ============================================================
-- TABLE: areas
-- Reference table for Bangkok neighbourhoods.
-- Kept separate so you can add area-level metadata later
-- (e.g. area hero image, SEO description, coordinates bbox).
-- ============================================================
CREATE TABLE IF NOT EXISTS areas (
  id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  slug          TEXT NOT NULL UNIQUE,          -- 'thonglor', 'silom', 'rca'
  name          TEXT NOT NULL,                 -- 'Thonglor', 'Silom', 'RCA'
  city          TEXT NOT NULL DEFAULT 'bangkok',
  description   TEXT,                          -- used in area page meta description
  latitude      NUMERIC(9,6),                  -- centre-point of area
  longitude     NUMERIC(9,6),
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Seed Bangkok core areas
INSERT INTO areas (slug, name, description, latitude, longitude) VALUES
  ('thonglor',   'Thonglor',      'Bangkok''s creative-class nightlife corridor. High-end cocktail bars and Japanese-influenced dining.', 13.7289, 100.5844),
  ('silom',      'Silom',         'Business district by day, Patpong strip and craft cocktail scene by night.', 13.7267, 100.5274),
  ('ekkamai',    'Ekkamai',       'Thonglor''s younger sibling. Indie bars, rooftop venues, and the Bangkok craft beer scene.', 13.7182, 100.5856),
  ('asok',       'Asok / Nana',   'Transit hub nightlife. Dense venue count, mixed foreigner crowd, easy BTS access.', 13.7368, 100.5600),
  ('ari',        'Ari',           'Neighbourhood locals bars. Low tourist trap risk, strong craft coffee and wine bar scene.', 13.7748, 100.5415),
  ('rca',        'RCA',           'Royal City Avenue — Bangkok''s dedicated club strip. Peak hours 11pm–4am.', 13.7546, 100.5663),
  ('khao-san',   'Khao San Road', 'Backpacker epicentre. High tourist trap risk. Fun chaos if you know what you''re doing.', 13.7589, 100.4979),
  ('sathorn',    'Sathorn',       'Corporate rooftop bars and upscale hotel lounges. Best date-night area per score.', 13.7221, 100.5237),
  ('sukhumvit',  'Sukhumvit',     'The main artery. Massive venue variety from dive bars to luxury sky bars.', 13.7308, 100.5673),
  ('latkrabang', 'Lat Krabang',   'Near Suvarnabhumi Airport. Emerging late-night scene, near-zero tourist presence.', 13.7291, 100.7474)
ON CONFLICT (slug) DO NOTHING;


-- ============================================================
-- TABLE: venues
-- Core entity. One row = one bar / club / venue.
-- ============================================================
CREATE TABLE IF NOT EXISTS venues (

  -- ── Identity ─────────────────────────────────────────────
  id                    UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  slug                  TEXT NOT NULL UNIQUE,        -- 'rabbit-hole-bar-eatery'
  name                  TEXT NOT NULL,               -- 'Rabbit Hole Bar & Eatery'
  city                  TEXT NOT NULL DEFAULT 'bangkok',
  area_id               UUID REFERENCES areas(id) ON DELETE SET NULL,
  area_slug             TEXT NOT NULL,               -- denormalised for fast URL routing
  category              TEXT NOT NULL,               -- see CHECK constraint below
  tagline               TEXT,                        -- one-line SEO hook

  -- ── Location ─────────────────────────────────────────────
  address               TEXT,
  latitude              NUMERIC(9,6),
  longitude             NUMERIC(9,6),
  google_maps_url       TEXT,
  google_place_id       TEXT,                        -- for future Places API integration

  -- ── Contact ──────────────────────────────────────────────
  phone                 TEXT,
  website               TEXT,
  instagram_handle      TEXT,
  line_id               TEXT,                        -- LINE app, common in Thailand

  -- ── Operations ───────────────────────────────────────────
  opening_hours         TEXT,                        -- human-readable: 'Tue–Sun: 6pm–2am'
  opening_hours_json    JSONB,                       -- machine-readable for structured data
  price_range           TEXT CHECK (price_range IN ('฿','฿฿','฿฿฿','฿฿฿฿')),
  cover_charge          INTEGER,                     -- in THB, NULL if none
  dress_code            TEXT,                        -- 'smart casual', 'no flip flops', etc.
  reservation_required  BOOLEAN DEFAULT FALSE,
  accepts_walk_in       BOOLEAN DEFAULT TRUE,

  -- ── Media ────────────────────────────────────────────────
  hero_image_url        TEXT,
  image_urls            JSONB DEFAULT '[]'::JSONB,   -- array of image URLs

  -- ── Nightlife Scores (0.00–10.00) ────────────────────────
  -- Core weighted score formula:
  -- overall_score = (foreigner_friendly * 0.3) + (late_night_reliability * 0.4) + (price_transparency * 0.3)
  score_foreigner_friendly    NUMERIC(4,2) CHECK (score_foreigner_friendly BETWEEN 0 AND 10),
  score_solo_traveler         NUMERIC(4,2) CHECK (score_solo_traveler BETWEEN 0 AND 10),
  score_date_night            NUMERIC(4,2) CHECK (score_date_night BETWEEN 0 AND 10),
  score_music_quality         NUMERIC(4,2) CHECK (score_music_quality BETWEEN 0 AND 10),
  score_tourist_trap_risk     NUMERIC(4,2) CHECK (score_tourist_trap_risk BETWEEN 0 AND 10), -- LOW = good
  score_price_transparency    NUMERIC(4,2) CHECK (score_price_transparency BETWEEN 0 AND 10),
  score_walkability           NUMERIC(4,2) CHECK (score_walkability BETWEEN 0 AND 10),
  score_late_night_reliability NUMERIC(4,2) CHECK (score_late_night_reliability BETWEEN 0 AND 10),

  -- Computed overall score (maintained by trigger, do not write manually)
  overall_score               NUMERIC(4,2) GENERATED ALWAYS AS (
    ROUND(
      (COALESCE(score_foreigner_friendly, 5) * 0.3) +
      (COALESCE(score_late_night_reliability, 5) * 0.4) +
      (COALESCE(score_price_transparency, 5) * 0.3),
    2)
  ) STORED,

  -- ── SEO & Content ────────────────────────────────────────
  insider_tip           TEXT,
  tags                  TEXT[] DEFAULT '{}',         -- ['cocktails','date-night','rooftop']
  seo_title_override    TEXT,                        -- if NULL, auto-generated in app layer
  seo_description       TEXT,

  -- ── Status ───────────────────────────────────────────────
  is_published          BOOLEAN NOT NULL DEFAULT FALSE,
  is_permanently_closed BOOLEAN NOT NULL DEFAULT FALSE,
  temporarily_closed    BOOLEAN NOT NULL DEFAULT FALSE,

  -- ── Freshness Signals ────────────────────────────────────
  -- THIS IS YOUR SEO ENGINE:
  -- last_verified_at is the single most important field for the "Verified This Week" badge.
  -- Google treats recently-modified pages as fresher signals.
  last_verified_at      TIMESTAMPTZ,
  verified_by           TEXT,                        -- 'admin', 'community', 'scraper'

  -- ── Audit ────────────────────────────────────────────────
  created_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- ── Constraints ──────────────────────────────────────────
  CONSTRAINT venue_category_check CHECK (category IN (
    'cocktail-bar',
    'rooftop-bar',
    'nightclub',
    'dive-bar',
    'wine-bar',
    'sports-bar',
    'karaoke',
    'jazz-bar',
    'hotel-bar',
    'beach-club'    -- for future Pattaya / Koh Samui expansion
  ))
);

-- Comment the formula for future devs
COMMENT ON COLUMN venues.overall_score IS
  'Auto-computed: (foreigner_friendly×0.3) + (late_night_reliability×0.4) + (price_transparency×0.3). Do not write manually.';
COMMENT ON COLUMN venues.score_tourist_trap_risk IS
  'INVERSE metric: lower score = less touristy = better. Displayed as (10 - value) in UI.';
COMMENT ON COLUMN venues.last_verified_at IS
  'Core SEO freshness signal. Set this whenever a human confirms the venue data is current.';


-- ============================================================
-- TABLE: venue_updates
-- Crowdsourced update submissions. The "living data" engine.
-- Users submit -> goes here -> admin approves -> venues updated.
-- ============================================================
CREATE TABLE IF NOT EXISTS venue_updates (

  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  venue_id        UUID NOT NULL REFERENCES venues(id) ON DELETE CASCADE,
  venue_slug      TEXT NOT NULL,                    -- denormalised for easy querying

  -- ── Submission Content ────────────────────────────────────
  update_type     TEXT NOT NULL CHECK (update_type IN (
    'score_correction',     -- "This bar is actually very tourist-friendly"
    'hours_change',         -- "Now open Mondays"
    'closure_report',       -- "Permanently closed"
    'temporary_closure',    -- "Closed for renovation until July"
    'price_change',         -- "Cocktails now 400 THB not 250"
    'new_info',             -- Generic new information
    'raid_alert',           -- "Police raid reported" → triggers Telegram push
    'reopened',             -- "Was closed, now back open"
    'photo_submission'      -- Image upload (URL stored in content_json)
  )),

  -- The actual update content (flexible JSONB + human note)
  content_text    TEXT,                             -- human-written note from submitter
  content_json    JSONB DEFAULT '{}'::JSONB,        -- structured data (e.g. new hours object)

  -- ── Score Suggestions ────────────────────────────────────
  -- Submitter can suggest score corrections. NULL = no change suggested.
  suggested_foreigner_friendly    NUMERIC(4,2),
  suggested_late_night_reliability NUMERIC(4,2),
  suggested_price_transparency    NUMERIC(4,2),

  -- ── Submitter ────────────────────────────────────────────
  submitter_name      TEXT,                         -- optional, anonymous by default
  submitter_email     TEXT,                         -- for follow-up, never displayed
  submitter_ip        INET,                         -- for rate-limiting spam
  submitter_user_agent TEXT,

  -- ── Admin Workflow ────────────────────────────────────────
  status          TEXT NOT NULL DEFAULT 'pending' CHECK (status IN (
    'pending',      -- just submitted, not reviewed
    'approved',     -- admin approved, venues table updated
    'rejected',     -- admin rejected
    'auto_applied'  -- applied via automated rule (e.g. raid_alert → Telegram push)
  )),
  reviewed_by     TEXT,                             -- admin identifier
  reviewed_at     TIMESTAMPTZ,
  admin_notes     TEXT,                             -- internal admin memo

  -- ── Audit ────────────────────────────────────────────────
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE venue_updates IS
  'Crowdsourced submissions. pending → approved: triggers venues.last_verified_at update. raid_alert type → triggers Telegram notification.';


-- ============================================================
-- TRIGGER: auto-update venues.updated_at on any row change
-- ============================================================
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER venues_updated_at
  BEFORE UPDATE ON venues
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ============================================================
-- TRIGGER: when venue_update is approved, stamp last_verified_at
-- on the parent venue. This is the key automation.
-- ============================================================
CREATE OR REPLACE FUNCTION apply_approved_venue_update()
RETURNS TRIGGER AS $$
BEGIN
  -- Only act on status changing TO 'approved'
  IF NEW.status = 'approved' AND OLD.status != 'approved' THEN

    -- Always update the freshness timestamp
    UPDATE venues SET
      last_verified_at = NOW(),
      verified_by      = 'community',
      updated_at       = NOW()
    WHERE id = NEW.venue_id;

    -- Apply score corrections if provided
    UPDATE venues SET
      score_foreigner_friendly     = COALESCE(NEW.suggested_foreigner_friendly, score_foreigner_friendly),
      score_late_night_reliability = COALESCE(NEW.suggested_late_night_reliability, score_late_night_reliability),
      score_price_transparency     = COALESCE(NEW.suggested_price_transparency, score_price_transparency)
    WHERE id = NEW.venue_id
      AND (
        NEW.suggested_foreigner_friendly IS NOT NULL OR
        NEW.suggested_late_night_reliability IS NOT NULL OR
        NEW.suggested_price_transparency IS NOT NULL
      );

    -- Handle closure reports
    IF NEW.update_type = 'closure_report' THEN
      UPDATE venues SET is_permanently_closed = TRUE WHERE id = NEW.venue_id;
    END IF;

    IF NEW.update_type = 'temporary_closure' THEN
      UPDATE venues SET temporarily_closed = TRUE WHERE id = NEW.venue_id;
    END IF;

    IF NEW.update_type = 'reopened' THEN
      UPDATE venues SET temporarily_closed = FALSE WHERE id = NEW.venue_id;
    END IF;

    -- Stamp reviewed_at if not already set
    NEW.reviewed_at = COALESCE(NEW.reviewed_at, NOW());

  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER venue_update_approval
  BEFORE UPDATE ON venue_updates
  FOR EACH ROW EXECUTE FUNCTION apply_approved_venue_update();


-- ============================================================
-- INDEXES — Performance + SEO query patterns
-- ============================================================

-- PRIMARY SEO QUERY: "show me published venues in area X, sorted by freshness"
-- This is the exact query your area pages will run on every request.
CREATE INDEX idx_venues_area_published_freshness
  ON venues (area_slug, is_published, last_verified_at DESC NULLS LAST)
  WHERE is_published = TRUE AND is_permanently_closed = FALSE;

-- CATEGORY PAGES: /bangkok/cocktail-bars
CREATE INDEX idx_venues_category_published
  ON venues (city, category, is_published, overall_score DESC)
  WHERE is_published = TRUE AND is_permanently_closed = FALSE;

-- SLUG LOOKUP: fast single-venue fetch by slug (used on every venue detail page load)
CREATE UNIQUE INDEX idx_venues_slug ON venues (slug);

-- FRESHNESS LEADERBOARD: "most recently verified venues" (homepage widget)
CREATE INDEX idx_venues_last_verified
  ON venues (last_verified_at DESC NULLS LAST)
  WHERE is_published = TRUE;

-- SCORE SORT: top-rated venues globally
CREATE INDEX idx_venues_overall_score
  ON venues (overall_score DESC NULLS LAST)
  WHERE is_published = TRUE AND is_permanently_closed = FALSE;

-- FUZZY NAME SEARCH (uses pg_trgm extension)
CREATE INDEX idx_venues_name_trgm
  ON venues USING GIN (name gin_trgm_ops);

-- ADMIN QUEUE: pending updates sorted by submission time
CREATE INDEX idx_venue_updates_pending
  ON venue_updates (status, created_at DESC)
  WHERE status = 'pending';

-- VENUE UPDATE HISTORY: all updates for a given venue
CREATE INDEX idx_venue_updates_venue_id
  ON venue_updates (venue_id, created_at DESC);

-- RAID ALERTS: fast query for Telegram push pipeline
CREATE INDEX idx_venue_updates_raid_alerts
  ON venue_updates (update_type, created_at DESC)
  WHERE update_type = 'raid_alert' AND status = 'pending';


-- ============================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================
ALTER TABLE venues        ENABLE ROW LEVEL SECURITY;
ALTER TABLE areas         ENABLE ROW LEVEL SECURITY;
ALTER TABLE venue_updates ENABLE ROW LEVEL SECURITY;

-- Public can read published, non-closed venues
CREATE POLICY "venues_public_read" ON venues
  FOR SELECT
  TO anon, authenticated
  USING (is_published = TRUE AND is_permanently_closed = FALSE);

-- Only service_role (your backend / admin) can write venues
CREATE POLICY "venues_service_write" ON venues
  FOR ALL
  TO service_role
  USING (TRUE) WITH CHECK (TRUE);

-- Public can read all areas
CREATE POLICY "areas_public_read" ON areas
  FOR SELECT TO anon, authenticated USING (TRUE);

-- Anyone can INSERT a venue_update (submit form)
CREATE POLICY "venue_updates_public_insert" ON venue_updates
  FOR INSERT TO anon, authenticated
  WITH CHECK (status = 'pending');

-- Only service_role can read/update submissions (admin dashboard)
CREATE POLICY "venue_updates_service_all" ON venue_updates
  FOR ALL TO service_role
  USING (TRUE) WITH CHECK (TRUE);


-- ============================================================
-- VIEW: venue_cards
-- Optimised read shape for list pages (area pages, category pages).
-- Only the fields you need for cards — avoids over-fetching.
-- ============================================================
CREATE OR REPLACE VIEW venue_cards AS
SELECT
  v.id,
  v.slug,
  v.name,
  v.city,
  v.area_slug,
  a.name                          AS area_name,
  v.category,
  v.tagline,
  v.hero_image_url,
  v.price_range,
  v.opening_hours,
  v.tags,
  v.overall_score,
  v.score_foreigner_friendly,
  v.score_late_night_reliability,
  v.score_price_transparency,
  v.score_tourist_trap_risk,
  v.last_verified_at,
  v.temporarily_closed,
  -- Derived freshness flag (replaces app-layer logic for simple queries)
  (v.last_verified_at >= NOW() - INTERVAL '7 days') AS is_verified_this_week,
  -- Days since last verification (for display)
  EXTRACT(DAY FROM NOW() - v.last_verified_at)::INTEGER AS days_since_verified
FROM venues v
LEFT JOIN areas a ON a.slug = v.area_slug
WHERE v.is_published = TRUE
  AND v.is_permanently_closed = FALSE;

COMMENT ON VIEW venue_cards IS
  'Optimised read view for list/area pages. Use this instead of querying venues directly from the frontend.';


-- ============================================================
-- SEED: Sample venues (minimum viable dataset to test queries)
-- ============================================================
DO $$
DECLARE
  thonglor_id UUID;
  silom_id    UUID;
  ekkamai_id  UUID;
BEGIN
  SELECT id INTO thonglor_id FROM areas WHERE slug = 'thonglor';
  SELECT id INTO silom_id    FROM areas WHERE slug = 'silom';
  SELECT id INTO ekkamai_id  FROM areas WHERE slug = 'ekkamai';

  INSERT INTO venues (
    slug, name, area_id, area_slug, category, tagline,
    address, latitude, longitude,
    phone, website, opening_hours, price_range,
    score_foreigner_friendly, score_solo_traveler, score_date_night,
    score_music_quality, score_tourist_trap_risk, score_price_transparency,
    score_walkability, score_late_night_reliability,
    insider_tip, tags, is_published, last_verified_at, verified_by
  ) VALUES
  (
    'rabbit-hole-bar-eatery',
    'Rabbit Hole Bar & Eatery',
    thonglor_id, 'thonglor', 'cocktail-bar',
    'Underground cocktail den where Thonglor''s creative class disappears after midnight.',
    '125 Sukhumvit 55 (Thonglor), Bangkok 10110',
    13.7289, 100.5844,
    '+66 2 185 2471', 'https://rabbitholebangkok.com',
    'Tue–Sun: 6pm–2am', '฿฿฿',
    8.4, 7.9, 9.1, 8.7, 2.3, 8.0, 6.5, 8.6,
    'Ask for the off-menu Bangkok Sling. Staff respond well to Thai greetings.',
    ARRAY['cocktails','date-night','creative-crowd','no-menu-tricks','late-night'],
    TRUE, NOW() - INTERVAL '3 days', 'admin'
  ),
  (
    'hair-of-the-dog-ekkamai',
    'Hair of the Dog',
    ekkamai_id, 'ekkamai', 'dive-bar',
    'Bangkok''s most honest dive bar. No cocktail menus, no pretension, just cold Chang and rock ''n'' roll.',
    '2/F, Ekkamai Soi 10, Bangkok',
    13.7182, 100.5856,
    NULL, NULL,
    'Daily: 6pm–1am', '฿',
    7.0, 9.2, 4.5, 7.8, 1.5, 9.5, 7.8, 7.2,
    'The rooftop fills up by 9pm on Fridays. Get there before 8 or you''re standing on the street.',
    ARRAY['dive-bar','solo-traveler','cheap-drinks','no-bs','local-crowd'],
    TRUE, NOW() - INTERVAL '2 days', 'community'
  ),
  (
    'smalls-bar-silom',
    'Smalls',
    silom_id, 'silom', 'jazz-bar',
    'Silom''s tucked-away jazz basement. Serious drinks, serious music, zero irony.',
    '186/3 Surawong Road, Silom, Bangkok',
    13.7267, 100.5274,
    '+66 2 635 4699', NULL,
    'Mon–Sat: 8pm–2am', '฿฿฿',
    7.5, 8.0, 9.5, 9.8, 1.8, 7.8, 8.2, 8.0,
    'The jazz sets start at 10pm sharp. Arrive 30 min early and order a Negroni at the bar.',
    ARRAY['jazz','date-night','live-music','sophisticated','no-tourists'],
    TRUE, NOW() - INTERVAL '5 days', 'admin'
  )
  ON CONFLICT (slug) DO NOTHING;
END $$;

-- ============================================================
-- 002_fix_venue_updates_insert_policy.sql
-- ============================================================
-- Fix: public INSERT with status='auto_applied' for raid_alert was blocked by
-- original WITH CHECK (status = 'pending'). Run after 001_schema.sql.

DROP POLICY IF EXISTS "venue_updates_public_insert" ON venue_updates;

CREATE POLICY "venue_updates_public_insert" ON venue_updates
  FOR INSERT TO anon, authenticated
  WITH CHECK (
    status = 'pending'
    OR (status = 'auto_applied' AND update_type = 'raid_alert')
  );

-- ============================================================
-- 003_newsletter_subscribers.sql
-- ============================================================
-- Context: Bangkok Nightlife SEO Hub | Current Date: May 2026 | Priority: email capture for community growth.
-- Stores newsletter subscribers from the homepage join module for later Resend/Mailchimp sync.

CREATE TABLE IF NOT EXISTS newsletter_subscribers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email TEXT NOT NULL UNIQUE,
  source TEXT NOT NULL DEFAULT 'homepage_join_card',
  subscribed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

ALTER TABLE newsletter_subscribers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "newsletter_public_insert" ON newsletter_subscribers
  FOR INSERT TO anon, authenticated
  WITH CHECK (email IS NOT NULL AND length(email) <= 320);

CREATE POLICY "newsletter_service_all" ON newsletter_subscribers
  FOR ALL TO service_role
  USING (TRUE) WITH CHECK (TRUE);

-- ============================================================
-- 004_venue_import_pipeline.sql
-- ============================================================
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

-- ============================================================
-- 007_intelligence_feed.sql
-- ============================================================
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
