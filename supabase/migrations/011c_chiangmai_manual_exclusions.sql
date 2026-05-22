-- chiang-mai manual exclusions (candidate SQL, review before execute)
-- Generated: 2026-05-14
-- Candidates from aggressive review: 1
-- NOTE: OPTIONAL. Execute only after manual verification.

BEGIN;
DELETE FROM venues
WHERE city = 'chiang-mai'
  AND google_place_id IN (
  'ChIJjS2cFWU72jARcp4hM7wSLFU'
  );

SELECT area_slug, COUNT(*) AS venues FROM venues WHERE city='chiang-mai' GROUP BY area_slug ORDER BY area_slug;
COMMIT;