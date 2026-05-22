-- pattaya conservative noise exclusions (post-import cleanup)
-- Generated: 2026-05-14
-- Source total: 239 | Excluded: 0 | Remaining: 239

BEGIN;

SELECT area_slug, COUNT(*) AS venues FROM venues WHERE city='pattaya' GROUP BY area_slug ORDER BY area_slug;
COMMIT;