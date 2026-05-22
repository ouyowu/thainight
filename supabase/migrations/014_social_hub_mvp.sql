-- ThaiNight Social Hub MVP
-- Context: May 2026 | Trending venues, tonight interest, and 24-hour meetup posts.

ALTER TABLE venues
  ADD COLUMN IF NOT EXISTS social_enabled BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS is_trending BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS page_views INTEGER NOT NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT,
  bio TEXT,
  ig_handle TEXT,
  interests TEXT[] NOT NULL DEFAULT '{}',
  current_city TEXT,
  traveler_type TEXT,
  avatar_seed TEXT,
  membership_tier TEXT NOT NULL DEFAULT 'free' CHECK (membership_tier IN ('free', 'vip')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS venue_social_interests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  venue_id UUID NOT NULL REFERENCES venues(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  interest_date DATE NOT NULL DEFAULT CURRENT_DATE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (venue_id, user_id, interest_date)
);

CREATE TABLE IF NOT EXISTS venue_flash_meetups (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  venue_id UUID NOT NULL REFERENCES venues(id) ON DELETE CASCADE,
  creator_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  title TEXT NOT NULL CHECK (char_length(title) BETWEEN 8 AND 120),
  note TEXT NOT NULL CHECK (char_length(note) BETWEEN 12 AND 360),
  meetup_time TIMESTAMPTZ NOT NULL,
  seats_total SMALLINT NOT NULL CHECK (seats_total BETWEEN 2 AND 12),
  seats_open SMALLINT NOT NULL CHECK (seats_open BETWEEN 1 AND 11),
  budget_label TEXT NOT NULL CHECK (budget_label IN ('฿', '฿฿', '฿฿฿', '฿฿฿฿')),
  audience_note TEXT,
  expires_at TIMESTAMPTZ NOT NULL DEFAULT (NOW() + INTERVAL '24 hours'),
  status TEXT NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'closed', 'expired')),
  is_featured BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS social_daily_actions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  action_date DATE NOT NULL DEFAULT CURRENT_DATE,
  action_type TEXT NOT NULL CHECK (action_type IN ('count_me_in', 'create_meetup')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_venue_social_interests_venue_day
  ON venue_social_interests (venue_id, interest_date DESC);
CREATE INDEX IF NOT EXISTS idx_venue_flash_meetups_venue_expires
  ON venue_flash_meetups (venue_id, expires_at DESC);
CREATE INDEX IF NOT EXISTS idx_social_daily_actions_user_day
  ON social_daily_actions (user_id, action_date DESC);

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE venue_social_interests ENABLE ROW LEVEL SECURITY;
ALTER TABLE venue_flash_meetups ENABLE ROW LEVEL SECURITY;
ALTER TABLE social_daily_actions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "profiles_public_read" ON profiles;
CREATE POLICY "profiles_public_read"
  ON profiles FOR SELECT
  USING (true);

DROP POLICY IF EXISTS "profiles_owner_write" ON profiles;
CREATE POLICY "profiles_owner_write"
  ON profiles FOR ALL
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

DROP POLICY IF EXISTS "venue_social_interests_public_read" ON venue_social_interests;
CREATE POLICY "venue_social_interests_public_read"
  ON venue_social_interests FOR SELECT
  USING (true);

DROP POLICY IF EXISTS "venue_social_interests_owner_insert" ON venue_social_interests;
CREATE POLICY "venue_social_interests_owner_insert"
  ON venue_social_interests FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "venue_flash_meetups_public_read" ON venue_flash_meetups;
CREATE POLICY "venue_flash_meetups_public_read"
  ON venue_flash_meetups FOR SELECT
  USING (status = 'open' AND expires_at > NOW());

DROP POLICY IF EXISTS "venue_flash_meetups_owner_insert" ON venue_flash_meetups;
CREATE POLICY "venue_flash_meetups_owner_insert"
  ON venue_flash_meetups FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = creator_id);

DROP POLICY IF EXISTS "venue_flash_meetups_owner_update" ON venue_flash_meetups;
CREATE POLICY "venue_flash_meetups_owner_update"
  ON venue_flash_meetups FOR UPDATE
  TO authenticated
  USING (auth.uid() = creator_id)
  WITH CHECK (auth.uid() = creator_id);

DROP POLICY IF EXISTS "social_daily_actions_owner_read" ON social_daily_actions;
CREATE POLICY "social_daily_actions_owner_read"
  ON social_daily_actions FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "social_daily_actions_owner_insert" ON social_daily_actions;
CREATE POLICY "social_daily_actions_owner_insert"
  ON social_daily_actions FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);
