-- chiang-mai conservative noise exclusions (post-import cleanup)
-- Generated: 2026-05-14
-- Source total: 248 | Excluded: 2 | Remaining: 246

BEGIN;
DELETE FROM venues
WHERE city = 'chiang-mai'
  AND google_place_id IN (
  'ChIJr1Chu7-Y4jARL-3StzJFOg0',
  'ChIJl4g50yc72jARqxVO1aSK4Hk'
  );

SELECT area_slug, COUNT(*) AS venues FROM venues WHERE city='chiang-mai' GROUP BY area_slug ORDER BY area_slug;
COMMIT;