-- Three-city post-import verification pack (read-only)
-- Generated: 2026-05-14
-- Scope: pattaya, phuket, chiang-mai

-- 1) Total counts by city
SELECT city, COUNT(*) AS venues
FROM venues
WHERE city IN ('pattaya', 'phuket', 'chiang-mai')
GROUP BY city
ORDER BY city;

-- 2) Area distribution by city
SELECT city, area_slug, COUNT(*) AS venues
FROM venues
WHERE city IN ('pattaya', 'phuket', 'chiang-mai')
GROUP BY city, area_slug
ORDER BY city, area_slug;

-- 3) Category distribution by city
SELECT city, category, COUNT(*) AS venues
FROM venues
WHERE city IN ('pattaya', 'phuket', 'chiang-mai')
GROUP BY city, category
ORDER BY city, venues DESC;

-- 4) Freshness signal coverage (verified this week)
SELECT
  city,
  COUNT(*) FILTER (WHERE last_verified_at >= NOW() - INTERVAL '7 days') AS verified_this_week,
  COUNT(*) AS total,
  ROUND(
    (COUNT(*) FILTER (WHERE last_verified_at >= NOW() - INTERVAL '7 days')::numeric / NULLIF(COUNT(*), 0)) * 100,
    2
  ) AS verified_this_week_pct
FROM venues
WHERE city IN ('pattaya', 'phuket', 'chiang-mai')
GROUP BY city
ORDER BY city;

-- 5) Possible duplicates by (city, normalized name)
SELECT
  city,
  LOWER(REGEXP_REPLACE(name, '\\s+', ' ', 'g')) AS normalized_name,
  COUNT(*) AS duplicates,
  STRING_AGG(slug, ', ' ORDER BY slug) AS slugs
FROM venues
WHERE city IN ('pattaya', 'phuket', 'chiang-mai')
GROUP BY city, LOWER(REGEXP_REPLACE(name, '\\s+', ' ', 'g'))
HAVING COUNT(*) > 1
ORDER BY duplicates DESC, city, normalized_name;

-- 6) Missing geo coverage
SELECT city, COUNT(*) AS missing_geo
FROM venues
WHERE city IN ('pattaya', 'phuket', 'chiang-mai')
  AND (latitude IS NULL OR longitude IS NULL)
GROUP BY city
ORDER BY city;

-- 7) Missing maps/place identity coverage
SELECT city,
  COUNT(*) FILTER (WHERE google_place_id IS NULL) AS missing_place_id,
  COUNT(*) FILTER (WHERE google_maps_url IS NULL) AS missing_maps_url,
  COUNT(*) AS total
FROM venues
WHERE city IN ('pattaya', 'phuket', 'chiang-mai')
GROUP BY city
ORDER BY city;
