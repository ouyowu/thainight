-- Phuket conservative noise exclusions (post-import cleanup)
-- Generated: 2026-05-14
-- Source total: 246 | Excluded: 2 | Remaining: 244

BEGIN;
DELETE FROM venues
WHERE city = 'phuket'
  AND google_place_id IN (
  'ChIJM2RaMAApUDARGlZuRHSYwtQ',
  'ChIJr_M6wBovUDARMUt9pW41iTY'
  );

-- Verify remaining count by area
SELECT area_slug, COUNT(*) AS venues FROM venues WHERE city='phuket' GROUP BY area_slug ORDER BY area_slug;
COMMIT;