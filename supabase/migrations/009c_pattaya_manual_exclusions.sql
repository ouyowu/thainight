-- pattaya manual exclusions (candidate SQL, review before execute)
-- Generated: 2026-05-14
-- Candidates from aggressive review: 5
-- NOTE: OPTIONAL. Execute only after manual verification.

BEGIN;
DELETE FROM venues
WHERE city = 'pattaya'
  AND google_place_id IN (
  'ChIJCcRwSACXAjER5inTdeYCHpg',
  'ChIJVznALX-XAjERzdzAUTseQXc',
  'ChIJS3JEdQC9AjERf_8A9_zbJ9U',
  'ChIJgfhnFtSXAjERtjD05AplRik',
  'ChIJxbWse6C_AjERsUDifm4YWlo'
  );

SELECT area_slug, COUNT(*) AS venues FROM venues WHERE city='pattaya' GROUP BY area_slug ORDER BY area_slug;
COMMIT;