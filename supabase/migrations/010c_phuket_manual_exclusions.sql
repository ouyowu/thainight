-- Phuket manual exclusions (candidate SQL, review before execute)
-- Generated: 2026-05-14
-- Candidates from aggressive review: 3
-- NOTE: This file is OPTIONAL. Execute only after manual verification.

BEGIN;
DELETE FROM venues
WHERE city = 'phuket'
  AND google_place_id IN (
  'ChIJo39AJdg5UDARns10nmhDhos',
  'ChIJkb-ijWE7UDAR6Xa8KMFYzsU',
  'ChIJmyHSCI8lUDARUkAV3GH2VAc'
  );

SELECT area_slug, COUNT(*) AS venues FROM venues WHERE city='phuket' GROUP BY area_slug ORDER BY area_slug;
COMMIT;