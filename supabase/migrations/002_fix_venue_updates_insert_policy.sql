-- Fix: public INSERT with status='auto_applied' for raid_alert was blocked by
-- original WITH CHECK (status = 'pending'). Run after 001_schema.sql.

DROP POLICY IF EXISTS "venue_updates_public_insert" ON venue_updates;

CREATE POLICY "venue_updates_public_insert" ON venue_updates
  FOR INSERT TO anon, authenticated
  WITH CHECK (
    status = 'pending'
    OR (status = 'auto_applied' AND update_type = 'raid_alert')
  );
