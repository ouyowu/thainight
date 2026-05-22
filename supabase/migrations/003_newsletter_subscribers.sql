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
