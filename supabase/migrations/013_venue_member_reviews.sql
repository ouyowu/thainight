-- ThaiNight first-party venue reviews
-- Context: May 2026 | Registered users can leave one editable field report per venue.

CREATE TABLE IF NOT EXISTS venue_member_reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  venue_id UUID NOT NULL REFERENCES venues(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT,
  rating SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  body TEXT NOT NULL CHECK (char_length(body) BETWEEN 12 AND 1200),
  recommendation TEXT NOT NULL CHECK (recommendation IN ('thumbs_up', 'tomato')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (venue_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_venue_member_reviews_venue_created
  ON venue_member_reviews (venue_id, created_at DESC);

ALTER TABLE venue_member_reviews ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "venue_member_reviews_public_read" ON venue_member_reviews;
CREATE POLICY "venue_member_reviews_public_read"
  ON venue_member_reviews
  FOR SELECT
  USING (true);

DROP POLICY IF EXISTS "venue_member_reviews_authenticated_insert" ON venue_member_reviews;
CREATE POLICY "venue_member_reviews_authenticated_insert"
  ON venue_member_reviews
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "venue_member_reviews_owner_update" ON venue_member_reviews;
CREATE POLICY "venue_member_reviews_owner_update"
  ON venue_member_reviews
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "venue_member_reviews_owner_delete" ON venue_member_reviews;
CREATE POLICY "venue_member_reviews_owner_delete"
  ON venue_member_reviews
  FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);
