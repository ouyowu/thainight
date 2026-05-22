-- ============================================================
-- Bangkok Nightlife Intelligence — Scraped Venue Data
-- File: 008_bangkok_venues_scraped.sql
-- Generated: 2026-05-12T14:30:08.817Z
-- Source: Google Places API
-- Total venues: 339
-- By area: ari(40), asok(71), ekkamai(38), rca(23), sathorn(23), silom(73), thonglor(71)
--
-- Run after 007_intelligence_feed.sql
-- IMPORTANT: Scores are AI-inferred from Google data.
--   Review and correct via /admin after running.
-- ============================================================

DO $$
BEGIN

INSERT INTO venues (
  slug, name, city, area_id, area_slug, category,
  tagline, address, latitude, longitude,
  google_maps_url, google_place_id, phone, website, instagram_handle,
  opening_hours, price_range, tags, hero_image_url,
  score_foreigner_friendly, score_solo_traveler, score_date_night,
  score_music_quality, score_tourist_trap_risk, score_price_transparency,
  score_walkability, score_late_night_reliability,
  is_published, last_verified_at, verified_by
) VALUES

  (
    'accentari-ari',                                          -- slug
    'accent.Ari',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '9/3 Soi Si Fa, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.784879199999999,                                                   -- latitude
    100.5451889,                                                   -- longitude
    'https://maps.google.com/?cid=14896663304488243098&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJQRNgOwCd4jARmk-eelmUu84',                                -- google_place_id
    '098 585 2485',                -- phone
    'https://www.openlink.co/accentari',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJQRNgOwCd4jARmk-eelmUu84/photos/Ab43m-s025M-AR1WwrA1muMinV1tJb5-utKjP9PH_MK5aBK5RRmJiz6hSv1HsXrB7L3IQXJYLYSn0QXRPug1w9YEQKixQvIVazwhqsOX0qUbnh-Z2JCDGBFo3aMEE_AOd8KL42nCf1JQWkvd0xtu9dh3ay0pjg6gjwoAHajNOmjUzDRQbyAd3Jyvs3qwrRvAOra6PUp6CMJzpTOeTpRXFaCCJ_ax4f4YTxr3AT5pqUAGLeCW7iZ_7AxZY_o_5QW0o09oLqgislx0OSeIhnUnND5ZxLvB7CbraolJYMau3kV0yOs3SQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.18,
    7.24,
    8.62,
    6.28,
    1,
    8.3,
    8,
    8.07,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'obsessionbkk-cocktails-spirits-ari',                                          -- slug
    '#OBSESSION.BKK (Cocktails & Spirits)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '4th Floor, 1011-3/4 Phahon Yothin Road, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7714748,                                                   -- latitude
    100.54150659999999,                                                   -- longitude
    'https://maps.google.com/?cid=17992920715437723181&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJz1em9C2f4jARLc5uYw-ys_k',                                -- google_place_id
    '061 919 3664',                -- phone
    'http://www.instagram.com/obsession.bkk',                               -- website
    NULL,                                                     -- instagram_handle
    '6:30 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJz1em9C2f4jARLc5uYw-ys_k/photos/Ab43m-vu223GDTommEeqvRjHBa6u-a1mk760xkVizHOxNVTXeQlr50zumTrUHAUzw9_y7aHyDLX9rGWD9dsBqMxoEKaOk6ka5xKjv1KsbtPxhDSOmeT9BUy6z_lCiZLXoOj8Mw1WmF_tdNlk7aAPcZkRm-BxoWhdASLi2dRgDpedfjNIaHS5mY5qt0Uv3r_DGQWrHsHLOvVYKqjLiVYCTzybb_SutOlNJtXIN_UsxsOyou0LzctpGe8l6O2HoRUS_sCDANbcg3PA73NYjGgtX4siFxpWKesMc7LW1lNixfdfYFFP6A/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.12,
    6.51,
    8.26,
    5.94,
    1,
    8.14,
    8,
    8.05,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'goodies-ari-ari',                                          -- slug
    'Goodies Ari',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '490/15 Aqua Soi Phahon Yothin Road, Samsen, Phaya Thai Bangkok 10400 Samsen Khwaeng Samsen Nai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.788569599999999,                                                   -- latitude
    100.5481679,                                                   -- longitude
    'https://maps.google.com/?cid=1024956413678317852&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJYR2FO9ed4jARHPGNg21gOQ4',                                -- google_place_id
    '099 191 5505',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJYR2FO9ed4jARHPGNg21gOQ4/photos/Ab43m-v_0JduD4gfAuSo4nx4DZUSBpJWxhfJwqPkIu19pKc05Ht78O8AuKPyGOXvdChcqTTWf_USABy0w-97kIEit_UxTdBvqq78GvPfT46lwEBQ4BhX7jXIMA-dGHtkrp4eKdFaBPxfCOf0Wy8CLz4kiEZ_kTAWttvbOJxc-cZGifF92Cank4f30rcSGZIvr0kp0rJwqd-sat7_saCK0jrWi9a8dZEUJNGLBPLl5Wjbql4Rv5JafCjbG2zf66RNMqLoSn2OiTA1nNHgZJaQ3OXIJ5CC4ja3hlfHdw5S4VjtMZxoeA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.74,
    8.74,
    6.54,
    5.81,
    1,
    8.21,
    8,
    7.72,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'fruit-bar-the-social-club-ari',                                          -- slug
    'FRUIT BAR - The Social Club',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1, 1 Soi Ari Samphan 4, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.778661699999999,                                                   -- latitude
    100.5382705,                                                   -- longitude
    'https://maps.google.com/?cid=11755622208693729715&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJm8lZOqif4jARs_nhZh1cJKM',                                -- google_place_id
    '080 596 7892',                -- phone
    'https://www.facebook.com/fruitbar.thesocialclub/',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJm8lZOqif4jARs_nhZh1cJKM/photos/Ab43m-uZ-Bj8ZnoV0Doh8PAgebq2ZR8Tc6EpmN2G_TcCxx8J8OvwnIi9CfYxueHwXNssYC0RPcV9LXOQ7sPyX-1wYrYnBJqa_mvnmV0VAW1qD5hpXqFSF577Ljk9ER1oMBEmhzH1DG25OPd0MhqmSEwC-ju0JdGjc2LDhUHJPJ3HLefYBUOodxx5eyjfd_CWrzGIyMUiPg3U7_O5bRFgGMyxykLiymUquY8nNTC9xX6qie1QD5MgNYigUIbKSTj77nd4y4ICec5UHJLBgsDvt3pb5MshU7gIpVakD9GK_ftTLtmSgA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.06,
    6.88,
    8.73,
    6.59,
    1,
    8.35,
    8,
    8.04,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'braytonbkk-ari-ari',                                          -- slug
    'Brayton.bkk Ari',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '466, โครงการ The Hub 31 Phahon-Ari Khwaeng Samsen Nai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.787460000000001,                                                   -- latitude
    100.54805929999999,                                                   -- longitude
    'https://maps.google.com/?cid=5700952545873907425&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ-zAGAt-d4jAR4U4ssiLaHU8',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    NULL,                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ-zAGAt-d4jAR4U4ssiLaHU8/photos/Ab43m-slmCZFm1dsfJ0MnMA9z_ytnNK6EOzPWpKqSsmY-qQX7gJyjBU49W5NM2bzJ__tlhuagD_R3KxXtC4rJXwWMaZW3j8UVs_pUeiTlii2DCPIMlrkX_YgTQXLtt3plmD0UE83EyN2zPv5GZzdvFUBQt6Uc2SOrtWV0eXUHvCN8_gep-EiHzeCt4F8fTqYOQzAoORcfX8ybNK28p4um4A2JhctyES_TSkeV4J3gn0vijc2Fb3zUX8ro28FV9H5GaVuoWwkevIRZgMlsF1gkeTGYkCh-Plfm4LJcXjZ-fGeDHbUXXElQMbRvXyjTbg3mJea11mKq9LKuVvnspL3R63bQ5JjVzUlQwvJt6z_A47k7R1kfrM47dENhbcxkauBwM5-lngmLaLXnASrmNZtL5X0PCrlQXWBHtV9TeHMN6_djQIynyho/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.34,
    6.9,
    6.27,
    8.84,
    1,
    7.99,
    8,
    7.58,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'farmers-bar-ari',                                          -- slug
    'Farmer’s bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '51 Soi Phahon Yothin 5, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.776085,                                                   -- latitude
    100.5418256,                                                   -- longitude
    'https://maps.google.com/?cid=12131434900036935321&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJLSCvaLWf4jARmV56OMSDW6g',                                -- google_place_id
    '090 247 5019',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 – 11:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJLSCvaLWf4jARmV56OMSDW6g/photos/Ab43m-uJcGBheS1jIq5SBndREwVDXlpi_gyvvhxBIcc3GbfBB_2CldIUeIVjoW-rJ8B6HKrA9bF60UQh-aS9fLY-Nkq5_qTccQDpFCf8DNV0wGm37Ftbmt1KdJso87Gt-_mcflxkasuUJC_He86svWsTHC8y14CGwfYhT5nT2bZ1QXMH4KLuF8_u4s2wjG27OXLoTKGI2DLXrni9Wva_UqsUabSJRVE7Vy5pxY_Ti3K97YpQ4kS1NZ8jrAhIvBk8b-OI-GddySMfh-IpbXABaWJy_QvVqqy5QenMaLyXmZvZBv058w/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.98,
    6.72,
    8.42,
    6.54,
    1,
    8.28,
    8,
    7.57,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'dryft-bar-ari',                                          -- slug
    'dryft bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '33 Soi Ari 3, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.779616299999999,                                                   -- latitude
    100.5407578,                                                   -- longitude
    'https://maps.google.com/?cid=12826321374386299002&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJTz8ArLuf4jAReqBLT1U_ALI',                                -- google_place_id
    '092 265 0899',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJTz8ArLuf4jAReqBLT1U_ALI/photos/Ab43m-u5wPUIyEpSmHcj_sMNlKFcw-0B5lWW1LWP4ZudQMFP5LeIKQ1gbC__-2-bnzigcmMIPjhwoslfdGNPV04uB6C_39XtSUwEjV-TabNIMfOIGcpzcswD9rFiNPNGYNXK8jgPmfrKWdSNWnEKbNS6oWFk7Tp51CyKO8hC9KmwpGS1nQeLoUzZGh5TvD91OxcrDHQn3I0tHyL16HAr5x7rF2338kQCsPFg4UTVa8Zz-tImapvoBr21GInjcin9WrSq9FPkirCiajDqr-iite84e2iazEu5gtO8oPFPB04x-Z2JMLRK8bI7hoxtVyPWLr1rU1pMpXTpC_fre5cMQQVSt5LnyvsEPlySiUScavLSO9E4pG6qFaMgs0O7YXZK3JbCKdsndtEdk5JeJwn87h__xUg0Tt2pF_x-7SYT5DVvtt8Jm3LdjPury5Mz86S_HQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.5,
    6.84,
    8.57,
    6.29,
    1,
    7.58,
    8,
    7.99,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'tempo-bar-ari-ari',                                          -- slug
    'Tempo Bar Ari',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '50/4 Soi Ari 4 Nua, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.783636200000002,                                                   -- latitude
    100.54354649999999,                                                   -- longitude
    'https://maps.google.com/?cid=11309720561378786454&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJoROfxQOd4jARlvzp2e0y9Jw',                                -- google_place_id
    '089 497 8926',                -- phone
    'https://www.facebook.com/profile.php?id=61563102242631',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJoROfxQOd4jARlvzp2e0y9Jw/photos/Ab43m-uQ65l4MUyhju8TpuPxUTf3cNaImwaTh_pJkfqztm9ds1ZpAHtuYTQZj7povNA5O74kcZ8BWmcPoRzlx09oQBRlmeI0E5qeAI2yDXmSm9RpQxJ1snbJ7equg6bcJO_FDKRvdS3l98FpDeUKqswPIw2HR0sAtF8uIkeoHpjPsy6wk7_Q8SjgPLePnzoUmUxtrZzkhKhM3NHldJ-ExlCX9jrnm2me8D5lGjXfbVleetCqEifwy_hNIIFX7dfgGn9FxVG-veL2V3ziZMbS-UbVLWtyP9nHJYKMEA9sbeiKkQ2i3Q/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.62,
    6.83,
    8.19,
    6.37,
    1,
    8.22,
    8,
    7.69,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'lemonadedatenight-ari',                                          -- slug
    'Lemonade.Date.Night',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '48 Phahonyothin Soi 7, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.783116600000001,                                                   -- latitude
    100.542925,                                                   -- longitude
    'https://maps.google.com/?cid=1920352876549000550&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJufosxCGd4jARZk0aSsR2pho',                                -- google_place_id
    '082 804 8358',                -- phone
    'https://m.facebook.com/Lemonade.date.night/',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJufosxCGd4jARZk0aSsR2pho/photos/Ab43m-styJoZuyKa2Lr4eA-KZB3MkJl4x1gOYQLGnI6mv70Uif-pH6kmqC9yqtmc9SexSVDTnxJ1-bkikznByssb7kWKqpb3yRFsKK7MS_OVa9A7CuQNeEXOPN1kWOGLqEhROqGsnQ5eMJHzw_T1Qszv5k6lPlrWyl8EI9Trq8v-rtGGARbcvMeQVxejCQSyl2CSzca-4Dj8nrknStO-xKFduqqx3dmPK9quC-UxcOaE3QYqT7E0FWOYp93pVDjR_B6UxuVEkWhb2Bp-1tJMv4mwJvKbOPiyBQOTN0s7ABSnjOXvc67vYX5MdbL4lOcJkej8zf3u93NyY71gcfL6BNjbtTc7M1fXKzh7lDsW9Ztxw8zVIpoSAyXdQUZHnEEoqZdEbW5rqq9_SYDlHOJtOkDOa3xdHWyGAiUaRDTPPegNumhhCg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.13,
    6.66,
    8.01,
    5.93,
    1,
    7.51,
    8,
    7.76,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'brewave-x-ari-ari',                                          -- slug
    'Brewave x Ari',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'rooftop, Café Amazon Flagship Soi Phahon Yothin 7, Khwaeng Samsen Nai, ม, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7789495,                                                   -- latitude
    100.5445572,                                                   -- longitude
    'https://maps.google.com/?cid=16976875986408782608&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJof3-2FGF4jAREDvBJcP6mes',                                -- google_place_id
    '081 981 9056',                -- phone
    'https://www.facebook.com/brewavexari/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','popular','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJof3-2FGF4jAREDvBJcP6mes/photos/Ab43m-soUVDzWfWHK0RT867sSHrsptr81ZkJkCRjoBAkRub2FIcB2JL1NyanPLVBjGN79ZlJpKBQXjOpgFJ75gKb3giSnIfXNARC-27rIf0YpLjOPMJYkW60k30juemcrcpI23c56TCZ36KES5H9HDL7iT50god36_s7X_C593hSFOjZbEryG4TALMwhIqvarrLhaw1Smm4jkT2POtJvuY8czEc78H75ZrLvQ0_1x7XJDB0q1Yx1R55D4LcypXKeyK0q-OnRBak2XzIFnwrOJkf6cmAcP-w6lW8j4jCBbjPk8qxWUQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.56,
    7.21,
    8.65,
    6.51,
    1,
    8.31,
    8,
    8.14,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    '224-winesphere-ari',                                          -- slug
    '224 Winesphere',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2/24 Soi Ari 1st Floor Phahon Yotin 5, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.783626700000001,                                                   -- latitude
    100.5415944,                                                   -- longitude
    'https://maps.google.com/?cid=15975697923921937484&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJRz5u42md4jARTARQcp4Utd0',                                -- google_place_id
    '081 159 7007',                -- phone
    'https://web.facebook.com/profile.php?id=61566361422141',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 – 10:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJRz5u42md4jARTARQcp4Utd0/photos/Ab43m-vA4G1P87SovT3a5JKTK1gbJzZxTZNqoZ0pPpPiD_Mp0WIV1SqNJYA9sLI4W3MWkYX_Qnvv6Iwd1tQ7REWyj85n5p4hALQyazlUpAtrfI1_vlXJAIaCxgjc2wvB4bTxPqCLyA4s84VsyiTjLoR-IqDVqarcH8XetM-yxQWeltYBxZIbj8HB3ahuPeJ2EResZZEbqkwiOGgvu31EIlRehsbeTsuhskFa2quS02l_Cv7qoUpeaxzR-Qc6Aul4poJRkzImcItnbw-ZWy7w8s5z792EuuH-RTUkAZmfIj3oeuAVoQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.65,
    7.09,
    8.12,
    6.05,
    1,
    8.17,
    8,
    8.1,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'churchillbkk-ari',                                          -- slug
    'Churchill.Bkk',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '466, 38-39 Phahon Yothin Road, Khwaeng Samsen Nai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7873866,                                                   -- latitude
    100.54832870000001,                                                   -- longitude
    'https://maps.google.com/?cid=5441970105417113851&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJxRr1WwCd4jAR-6CuY_rChUs',                                -- google_place_id
    '093 006 1918',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJxRr1WwCd4jAR-6CuY_rChUs/photos/Ab43m-uMUL5KWetYkRfn9Mb2Ga8oyRE7qg4ser_iYkteMbKsNJHPieYZz2taG3u8jcouCkrA2isz9ROaAMOQwrV0EsM7GdBNFdIyQXV3U41acmJfzW2z_e0x17C_y5abPJ9-VTHBCA8HHcESVc2PIOjkF_oAp3jWiJ_bLzhRuXVqNc8ghfOg8-tRdYtSd5CjOjuUQG2qZV2aKQc1W5Ya9owypTDjp5K2q_jGWIeAgn2I5AHhpB9UWbZIF--54XTuOU9hL633Ia1ErBZO6T5utk-S1lhI0usJO6BW01hIzXuNcpcFoA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.48,
    8.8,
    6.66,
    6.36,
    1,
    8.32,
    8,
    8.05,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'tiger-ari-ari',                                          -- slug
    'Tiger 虎 Ari',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '356 โครงการ ลาวิลล่า ชั้น3 Phahon Yothin Road, Khwaeng Samsen Nai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7798875,                                                   -- latitude
    100.5450862,                                                   -- longitude
    'https://maps.google.com/?cid=5618930607934807864&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJMfRYaQCf4jAROB-GF55z-k0',                                -- google_place_id
    '082 984 6665',                -- phone
    'https://www.facebook.com/tiger.lavillaari?mibextid=ZbWKwL',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:30 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJMfRYaQCf4jAROB-GF55z-k0/photos/Ab43m-s3O5huRBPsaxghS_2SH9VvYnB5AbbBL7mSsqbesX--zFBvOkWudbWQG-AGLyJhWOeuicg8lqjCkPsHbA_dm5ihFbr_vf9mm_unNaUXfcjHFizS_9OSRC3TLzDcBBKd80tLQ4DsbkXTsHx47KLDWIpNDgs0r4BtBakcMudp5jl-LLdK225hebn3D83v-o72H_HhkfsLBvycFPuI4Zm0tYF_7qGnyZf_dpSJLdxxechYxqWLHkrYKTi5_W-G0ZvTDo9Nc3g3lMOnWWHuKb7a2Xq3m7FQg5p92AYXrxY-9_eIbFnvErnzNglLEHKygu6dPDsi_iTSqGJSrZxc5cjdxtUMLNgNQ_hxtXuwnmq9EbiGFwS5yS3XKEy7H7divFrfmwBE5Ne6keOAZUMsunivAA2d6ERTpv7sxI4Xm7-Ng1M/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.91,
    7.35,
    8.34,
    6.33,
    1,
    8.47,
    8,
    7.58,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'old-dirty-ari',                                          -- slug
    'Old Dirty',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '490/21 Phahon Yothin Road, Khwaeng Samsen Nai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7884903,                                                   -- latitude
    100.54839849999999,                                                   -- longitude
    'https://maps.google.com/?cid=2656121832225783732&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJjT5Iphmc4jARtD_60btw3CQ',                                -- google_place_id
    '062 730 6444',                -- phone
    'http://www.facebook.com/olddirty.gastrobar',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJjT5Iphmc4jARtD_60btw3CQ/photos/Ab43m-v9nceM1g3x8CjLBoeZiT4TEcpSdI-oCIv4J_dx-sCX7kqgny-QKsU068ZHB1Kf9ox9exGCWjVQQ7MjNRAKkwX0Xh914Y_SOoA2nDMF9OK1ahHYJENPcwOgvhiB5k_qotvRAK16mAbfEaRbCXXPdPS-S0Ec0qoApb4n7Il-ldZZrEcQhk6zG1IWdsGR8iDYRuSWWQLTznr6baGv5RzKL_l-46JsPNRgXuv0xHcw-ei5oZURPPIkNOzicgchQQXl-C1URvWJRma-ksteP16BByhVbHaAVeIAmFU85jOUQIBvHg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.39,
    7.07,
    8.51,
    6.22,
    1,
    8.3,
    8,
    7.45,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'kizza-arinian-ari',                                          -- slug
    'KIZZA ARINIAN',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '19 9 Soi Si Fa, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.783800699999999,                                                   -- latitude
    100.54393499999999,                                                   -- longitude
    'https://maps.google.com/?cid=5100421887827675985&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJG5ocYTqd4jARUYuYDK9WyEY',                                -- google_place_id
    '081 552 7352',                -- phone
    'https://www.facebook.com/KizzaArinian',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJG5ocYTqd4jARUYuYDK9WyEY/photos/Ab43m-sxYHLUGSsLeOCuhMhJBsT3UNksHu5mozKtoM4ZPevCosDYp03unsNjOf3Uw3rmaQdrU33SPL2DtmgSGx8pv-l2r95BNY3z6VO4xYtBEVToR9yPvFXtgILMkBP1DskuChLWLK8N0Mf2Nh9LsZQT53cm3Px7OHTIYRcHya7ty0f4MdzzURy6JjbuSXbX4x_WIehdg2t0_msaVDYZB9RIHlDQ4zyv9mMtOjM_ShjL1f0eKhUOkNhW95LFMHvaqZLPFFy4dwa4cqgivVkk5SwBcxwJ_PUMPP9FuGfpzyOn8D-yJg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.24,
    6.89,
    8.52,
    5.81,
    1,
    8.18,
    8,
    7.78,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-pickles-ari-ari',                                          -- slug
    'THE PICKLES ARI',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '144 Rama VI Soi 30, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7785285,                                                   -- latitude
    100.53859130000001,                                                   -- longitude
    'https://maps.google.com/?cid=14677289821406022850&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJm3ANUACf4jARwsxcNlQ1sMs',                                -- google_place_id
    '082 986 7927',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:30 AM – 11:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJm3ANUACf4jARwsxcNlQ1sMs/photos/Ab43m-tofWR6Ve2rxw-u3pMCYJMjENLZKYYPB1DNgbxtsKTDNwvi29k4iELT0gdL77JJkLyMyc01TFu6pg3Qn3S_CaHGgIuoBvhSnoq_n0g6qSIvGIn_gg0ap7W3aSpxS_KH2GwRcorxmJok_xN1WHJ3JpjpH5S3X0SIGBdpmbbY0du-jfzGps4So_O8r9Xnax3PFVFDJht4Clel8billJNdzW3eC24uJWNO0sIfsWEPOh5yBCYlJRfAaFxQlnSxLP8K4OvP71RkahLiT1mweaoKMFznCEu0jdNdxeWqhldEzMQoSg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.53,
    6.7,
    8.02,
    5.76,
    1,
    8.2,
    8,
    7.81,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'perfect-strangers-ari',                                          -- slug
    'Perfect Strangers',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '196/6 ตึกดำ, ประดิพัทธ์ แขวงพญาไท เขตพญาไท กรุงเทพมหานคร 10400, Thailand',                     -- address
    13.7905216,                                                   -- latitude
    100.5440168,                                                   -- longitude
    'https://maps.google.com/?cid=3737512320488899823&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJL7nHwE6d4jAR7wRjPqdP3jM',                                -- google_place_id
    '081 354 0069',                -- phone
    'https://www.facebook.com/PerfectStrangersBKK/?ref=pages_you_manage',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:30 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJL7nHwE6d4jAR7wRjPqdP3jM/photos/Ab43m-sPoCzSB-02cTGl-JtL8oQI1kn4Hlj-E-TIoNNWJ5KO7_B2q-rU_CCCF_A9YneWTPqWHNfb0C8ISKhk92jAHB8FqGy7kTdtDEuN24Imk1t7RZ-bjGhzaU-Zw3HsXwlQek3D05Jzsu_koOg6fM871mnfPSST_jRQ27TV0CDXKWQD-s0t7_HSUI7gmMZ_NCLJEe8hjQrEPrbS9sOijcz5ZQPohVg7fKiRkuENOKyd8ztOeEOvP-UUOAD4aJE8OvGCDMBD8Bl1Dc3mqwJcB-5_vs9IaiMn3RNcQ6spOTd3e-62Ww/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.14,
    7.53,
    8.17,
    5.82,
    1,
    8.3,
    8,
    7.6,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'maribuari-ari',                                          -- slug
    'Maribu.Ari',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Soi Phahon Yothin 13, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.788011599999999,                                                   -- latitude
    100.547454,                                                   -- longitude
    'https://maps.google.com/?cid=1728429614514612125&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJfWa_RQCd4jARnadoqJOd_Bc',                                -- google_place_id
    NULL,                -- phone
    'https://www.facebook.com/share/1ER9oeqPNi/?mibextid=wwXIfr',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJfWa_RQCd4jARnadoqJOd_Bc/photos/Ab43m-sVdFgSXt_xZW_HATp1xvVPFbLEVRU-ACKvFadCUx0EfXjllS2qFwSnLmBYePnovMnnFK7AHrO1F6I0nG_GGMeIYoFt9ltRuQGCHuKgCZsjtSuGhgdCKSX_VOcH7O1MDzAo96ldVXZA0yFXCXeA13qbhg8FFgCBK9HdvC-Db2L3hBqjdzQI1ZcIDNupEizwDJImRflronBLbGKjqo-NSW-QwHEJ8-i7R20iE5eZ5vbGOYZnM7ox55dQlBp_WustZdaNIbkBu7Z6WU6uijz8C59EQzC5Ew1lBAaUT5Wb5ZYW1FUpe_AzHGq8QPHhWMdKGmU8AsrgSLkLg36SpTGiHNbGl8wK9jB7loqA8ASLcYnHOTdFVSoJc24Ygna28-PJo4fSE-GK7SaUdgytjiC5DI-3uubIMxCueEHSFRpEdaLGE1SgSD6D5kKCNZElGzHE/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.21,
    8.99,
    5.95,
    5.86,
    1,
    8.36,
    8,
    7.93,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'eight-days-a-week-homebar-ari',                                          -- slug
    'Eight Days A Week Homebar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '24 Soi Pradiphat 14, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7884725,                                                   -- latitude
    100.54364079999999,                                                   -- longitude
    'https://maps.google.com/?cid=12585376497124397989&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJPVhhDjSd4jARpVOmcz49qK4',                                -- google_place_id
    '082 365 1529',                -- phone
    'http://www.facebook.com/EightDaysAWeekHomebar',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJPVhhDjSd4jARpVOmcz49qK4/photos/Ab43m-vy1DXYAriOL54XgTPXzDq3GiVpjKcZPPQbTkmZQ9t3D2ZuceBZk4YlS2HDrgPjNT0O692iQnn0Auq-dhqLgj8fuBb0BEQms-rag2NIDD77r7-ZjBYX1A-FFYNg9SY-8GeQ2oLvjvwrrAe91ifODj5GIBTvZzY-F2JfO5gqZzlkHbwcDU-ICjWeG1KX5O6s8zve12QrRn3hKycRMXG5N76qKanaHQ1Ly_BeaQuw4actlMH34H2_BawWmXW1D3wdveOiGQuwLlje_bdBxU7GIsFjJ4gHyj53C0B5IXcRM9pkJ-59Xbo8OS02Mi1AtRNdqzu-bhyRFlVCTKak3lUjiuMOVtdbNya0CDQIXgc_lmHjc3rRJPjb-HvL3Rz51oxxmSIZ5y6bfCh0ha1qj1OAH-S5PJYfCzY7o6jfnf2G0518M-k4/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.06,
    8.88,
    6.23,
    5.94,
    1,
    8.08,
    8,
    8,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'chit-hole-royal-river-ari',                                          -- slug
    'CHIT HOLE Royal River',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '439 Thanon Ratchawithi, Khwaeng Bang Phlat, Khet Bang Phlat, Krung Thep Maha Nakhon 10700, Thailand',                     -- address
    13.7831244,                                                   -- latitude
    100.5016754,                                                   -- longitude
    'https://maps.google.com/?cid=82161434468747989&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ0euT5qmb4jAR1Qq_q2PlIwE',                                -- google_place_id
    '064 954 6616',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ0euT5qmb4jAR1Qq_q2PlIwE/photos/Ab43m-svhXlOaaz8MLaekSmrzFHj5dLtNJ8qiLDvbly0-VXGJYFenfI5wMGivXEqGM-rpJTy2Q1eHx4_1hkEmqPkRWRGGODjIdwamjQJmIBAF5f2r-WPrAOUn-nEKFhyyeJE8m0HJspMj22h54t1cgF0gP8ltxsU8jagY9N8D-tcmnz2SHQQbfvVEE3n1EATelJi1PhiOmHKQH8ue7FGQm95RxQYft20JfZUAWunuV0vD8kaCkG15E8pr_ZEgDUszcF3E5U5GadDx7_KlGtTu2s2fgsDJUJNJb6bSsW74ulgoABcE63pSx0dPuQuD08j-25lGRrUwSKHpiNPcHAKYZuBVRL64UszZ0knDZJX-nswNR05d15IfOkGu87SzkWwqd6XL84Ru-gzmb0xbrPiOEk-1ISNnNrFs9UmqJKpNQFMylfsUg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.39,
    9.29,
    6.52,
    5.87,
    1,
    7.71,
    8,
    7.55,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bar-lookkrung-ari-ari',                                          -- slug
    'บาร์ลูกกรุง อารีย์ (Bar Lookkrung Ari)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '127, แขวงสามเสนใน เขตพญาไท กรุงเทพมหานคร 10400, Thailand',                     -- address
    13.778833899999999,                                                   -- latitude
    100.5383154,                                                   -- longitude
    'https://maps.google.com/?cid=15494736653975091057&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJVWregTSf4jARcfdoZORcCNc',                                -- google_place_id
    '082 114 6339',                -- phone
    'https://www.instagram.com/barlookkrung.ari?igsh=MTUyamthbHprMHVsdA==',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJVWregTSf4jARcfdoZORcCNc/photos/Ab43m-sKBHjvCcb_UelFjMgBo6s04ZWw_AgNvzU8Cow38JoSsdSSJFz3yynBJ2fDqc1CAIO5vWr-TB3eD93YOiwZ8AcEN4sripVDnzQI4jgCq-MuywE-crfjtZ22qGuE1irpT9Oxs9eXcN83W5In0QT7ijU7ZYKI7nJtiP0qnBDtF34hNNFyeQea1dVTurtrjuW9impjCj-JOYZYIm6cN1vYjRAvSTfkCtbETBfLkmnxLz88VT5Htzv95YAhRMeYwbeyRfCWVwjqRlkQbUb2n1j29XhIkV9sjBwSE3BNw2oIeOrnVYI0vhr2ZPNuQchn_P2KpWhxNNrY8rrGK5GfGTnoAtBVngs-nNndvQp1164AOEtIKXlCF7skC03PnQ70CDDDNy4dKW6YfieD4wxlhabH83YqXc1873RnzH0r29HSo3DdFR59xq_s9dtFsTvIXw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.19,
    7.13,
    8.38,
    6.39,
    1,
    7.98,
    8,
    8.04,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'khaoya-archive-ari',                                          -- slug
    'Khaoya Archive | ข้าวยา อาร์ไคฟ์',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2nd Floor, 128/10 Soi, ถ. พหลโยธิน แขวงสามเสนใน เขตพญาไท กรุงเทพมหานคร 10400, Thailand',                     -- address
    13.778296399999999,                                                   -- latitude
    100.5467537,                                                   -- longitude
    'https://maps.google.com/?cid=14460433725345507542&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJoT2Cdjud4jAR1ihMydvHrcg',                                -- google_place_id
    '098 939 0858',                -- phone
    'http://instagram.com/khaoya.archive',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJoT2Cdjud4jAR1ihMydvHrcg/photos/Ab43m-s66CFFhL0WlhTaeuz72Mykuz93bvTUjBpJ-erSC2rv8yMOMJKGI_SpnFBOj9krRP5HRvL7tpnRAU01-WdhqJU1RM1L4wvvEq7rqGc-aye28NAUDrB3DaIjeNZFav1kPtcAcFPjRObuGfSkgMVIQNc3au0b_-yP_TKIH-gZ1kWw5xcfjY8bJoBV97jaXhbuHN1tnsoy8Bc4vtqIVpKmi-scRxOWoVkUdUwrZN-_4xoX1wYSbx6kcBihUeuHb8ZJ4jfJQyALFGZ-Nvl73lo_NLJRgQkXlqk-ghXsR5kZJhXLWg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.85,
    6.96,
    8.38,
    6.18,
    1,
    8.34,
    8,
    7.84,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'no-bar-wine-bar-ari',                                          -- slug
    'No Bar Wine Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '128, 10 Soi Phahon Yothin 2, Khwaeng Samsen Nai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7783389,                                                   -- latitude
    100.5467704,                                                   -- longitude
    'https://maps.google.com/?cid=10661722147599036675&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJwdigwBSd4jARAzGOFc4L9pM',                                -- google_place_id
    '099 229 7465',                -- phone
    'http://instagram.com/nobar.winebar',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJwdigwBSd4jARAzGOFc4L9pM/photos/Ab43m-szlC6lbVbyzxQcTj1FV0dGO7_KU2bLdHOxOVQdDAeoZRs-LeRWJ0re0tgaMVFdXMlgqWjPmUB36gvYMObdwvf2jcTl2NZB_TZG8s6MBZiwU7buigpiIA9omSuejYSZp12ZEAdXodDVJw3hsowKt2E7iU0uHBnMwGDqDS-JJwgXQxjoR4G1iWWXhaRxgcYgvMRGBtUXqYC6pW158jlK_vTGGDNJQgZtxJPvIQCudji4zQBq0bYtbwOITnFw-Ld2ZbFKWkOKpefEpCJrOdmtArjHAuqRtMrIlCuAATcZnd8j7g/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.19,
    6.68,
    8,
    6.23,
    1,
    8.1,
    8,
    7.75,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'monty-ari-ari',                                          -- slug
    'MONTY ARI',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '460, 462 Phahon Yothin Road, Khwaeng Samsen Nai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7873288,                                                   -- latitude
    100.547556,                                                   -- longitude
    'https://maps.google.com/?cid=17194500964300867592&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJMX9_dACd4jARCMhD04Yjn-4',                                -- google_place_id
    '099 124 1963',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJMX9_dACd4jARCMhD04Yjn-4/photos/Ab43m-vcbCVX4d10M78RxJBfE7L4tsaPGO_wges1Kvw4aHLYWq5XtGfcio2wXt_A04uvEfZbe-33IUIUheoKElAixwE7LdHQZClpojAiNoYKJ6zKpIRkGlZO7VtEsd2DqH2io7nqJ3m4WXP6gjhF5BgsBB8n1j1_h67SuGdvjWpEZrp9OJgvuKyM6n3pe4udCyukeeY9n4icyWAov_xkgnNRM0k3iMKzPipXZswIayK0GdIz-vKCFs5QfQG77VGr9u5p7px1FzBTpz1MagBgIiCkbHKyv2Z0sibyiSyyo8ditiWhFc5PhTHk7sE7-HIfZa0tI0ofzZQ9pt9U6UCKLvcUUlYlAIqykd_oj8XBlRfhLaJJacc95gGGNiEPMImCugYV9oV0lT9yu0-Yjpfh1XjeCCla4lh_7farVYNurjWd5v8McNyeXUiB0mQomoXtSA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.87,
    8.58,
    5.97,
    5.86,
    1,
    8.41,
    8,
    7.94,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'e-san-to-2-ari',                                          -- slug
    'E-San-to อารีย์สัมพัน์ 2',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '56 Soi Ari Samphan 2, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7776944,                                                   -- latitude
    100.5390644,                                                   -- longitude
    'https://maps.google.com/?cid=15467281141492845970&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJTYRPPgCf4jARko3Hvz_SptY',                                -- google_place_id
    '02 271 1735',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:30 AM – 11:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJTYRPPgCf4jARko3Hvz_SptY/photos/Ab43m-vjhfy_EXJ7V4_97whkMQt0-waaIxkL7V6J1QUk0Sd1GrvuJxQncFNDNIKP4DxmrugHP1ReBuDUGeNibO-bjetVWBGir_OWF1kQGlFSOYu3qP9dvWoMCO_s2C6U5WIS5X9elC20ph4_FSzSn4lcgRWrt-t9LCXr4QQGww8aCYky61CMTwxL7RYjlFHWSQHgoxdAvaNqhEX5JE12nwJ3Ll8p2ObpNlXFZW539vSkBAKuUopQJHDjo7DjJan4w8ycm-4QoDLJKlIn6Bhx1EvP1Is0fkBLeX8_2aKvhYFhOhdZoeCHmQr6aVXs5818PoAKMalE5tG1IHvRJyVxZjo4bPgoxEh67FXzvHaBjToJ-r_Fd26xHsFJHPPW-lwqJ42bmIz4otZMf_rbf9XKV1iVTCUaZPw0y7f3moGCl_4NYMiIQaYInPlJZzgJvkwfR1gb/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.53,
    8.57,
    6.36,
    6.12,
    1,
    7.78,
    8,
    7.65,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'cantina-italian-kitchen-ari-ari',                                          -- slug
    'Cantina Italian Kitchen (Ari)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '142 Rama VI Soi 30, Khwaeng Samsen Nai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7784803,                                                   -- latitude
    100.538545,                                                   -- longitude
    'https://maps.google.com/?cid=1523164297628647806&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJB7NJSKie4jARfoG2zttdIxU',                                -- google_place_id
    '02 038 5114',                -- phone
    'http://www.cantinabkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 – 11:00 PM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['cocktails','premium','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJB7NJSKie4jARfoG2zttdIxU/photos/Ab43m-vTkrP9U_tPu5Qd_RPTZrhkmfUXDpHvT89yXYtoVZnZL_fv1IKr2FIDvlzrsFqI3g5Ss7NxARxhXpEW5gJLrONe_jVeUrIif1e0Nv3cS_GKoKuDA_VlVNknSj52RRW5HQ1fA2YZ9fHbcMXW3dYdzo33BFZ6xa6ytCbCeHFa-d6bN03SaeJ3ysaQPlq3-rlkxuas_GORFZj0G_Jd3pUQCu-FPSBj2lmLWF4tufX5aahL0c-5AkqUT_f9JeUI8O84kiM0VAPRjRbtbmMDJH2KyNdLzNs_Z_0XWhXJdj9BG99Y6Q/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.44,
    6.69,
    7.91,
    5.82,
    1,
    7.28,
    8,
    7.35,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'uncle-bar-ari',                                          -- slug
    'uncle Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'ย, 19/2 Soi Ari 4 Nua, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.783583400000001,                                                   -- latitude
    100.54412119999999,                                                   -- longitude
    'https://maps.google.com/?cid=162977997509047594&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJFzIV_a6d4jARKjW7D6ADQwI',                                -- google_place_id
    '099 191 4292',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJFzIV_a6d4jARKjW7D6ADQwI/photos/Ab43m-uMOIdCC-69lvrz1z9LsdmjuDCqvu8YVqzdu01fOm4E65XxmgxpMz7Jvd_2hNSIBRnUa5HoVEczCDZ332T5y9nTK2EcMiln85oRcTK8yHG2A7HGELTinhFCvZpMPVswX72sIeKjfJw_86bX-9UsJgImA_jdylrWYyjqk_YcfcBqe8M7fBYdC4eUojsVTIVaQ5GYtugMvzQyM7wd-eNDAJE9lWqi9_LJ4uXkGdRteKkl1S20612cT6UlXCO1HEpi8OeDxB9xZrCM4zVCdQTcwAgv4Ws0YS__MUqCqKFHEJqB0w/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.08,
    6.63,
    8.22,
    6.25,
    1,
    7.93,
    8,
    7.91,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'dok-kaew-house-bar-ari',                                          -- slug
    'Dok Kaew House Bar บ้านดอกแก้ว',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '71 Rama 6 Soi 28, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7763666,                                                   -- latitude
    100.5330142,                                                   -- longitude
    'https://maps.google.com/?cid=9791930748687683840&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJIwqFpque4jARABHB1CLt44c',                                -- google_place_id
    '086 398 8563',                -- phone
    'https://www.facebook.com/DokKaewHouseBar/',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJIwqFpque4jARABHB1CLt44c/photos/Ab43m-uK_zuD5aVcYnprfKszRcBzm0rXPit43y2Zrbp2o3QM6Z3Q1qAd5av42wCNx6-GyEckfZ597S8qffBKa6F-ojkrT8boLh34xtFipVZ_SZtcp0I44JG7ajEODYoMnAG35z0h_cgd0NSSJ-86GBpbHgjMJOl8S1IpOUNXyrtFsuAi9vQAi9aBdlk3WEByt8hFhGDVqngi6PCzEiGN3fozy5GAlHN7VrbLBg9K9KXbsQ_Nq7pedsIFU7LajACDKXZ1uoXl_8UoBSPHTb5qqQ1zJU8ZHsxEbexoij9PLF5mHr1TOA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.57,
    8.86,
    5.92,
    6.18,
    1,
    7.9,
    8,
    7.34,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-key-room-no-72-ari',                                          -- slug
    'The Key Room No. 72',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '19/2 Soi Ari 4 Nua, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7836389,                                                   -- latitude
    100.5441207,                                                   -- longitude
    'https://maps.google.com/?cid=17130155984506927308&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJKaTJ_CSd4jARzDiRwxuKuu0',                                -- google_place_id
    '02 102 4999',                -- phone
    'https://m.facebook.com/thekey.joshhotel',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJKaTJ_CSd4jARzDiRwxuKuu0/photos/Ab43m-tAUAPkWtHUN_NMF45JIjjxTHsk9eqlrEMx1UpmoVGJXLFKMtrGTuXyw2F0KYZKsQ1fON_JHRI0KcmMsQ9OR0cTxtVBsz0z9GyarMpl60x7v03hcFx0gmg2XZKlC9iAcmjJJu3_yfeoQXhXZ5tfFr8fpOeLEmCFGzIVXp1uIp9BSlSC9F1Pl-I3fQRlDpIMkIhJ0jKPAVA9fk6g0TYRu8-ez9SVT_lX8hHhb8KDu9pMZ2rIb4SGq6hVdsABRrzwcXI1A3ni_Mmmz3Wuf6HcsHIwzEMvwgji_SGwtgKme4yAgw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.11,
    6.93,
    7.77,
    5.92,
    1,
    8.34,
    8,
    7.43,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'baobao-bar-ari',                                          -- slug
    'baobao.. bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1029, 12 Phahon Yothin Road, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.773184400000002,                                                   -- latitude
    100.5420146,                                                   -- longitude
    'https://maps.google.com/?cid=1961114734511918013&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJw2jn1B2f4jARvQte6nVHNxs',                                -- google_place_id
    '081 542 5965',                -- phone
    'https://www.instagram.com/baobaobar.bkk?igsh=MWg4ZzVsdnhwbGFmdQ==',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 1:45 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJw2jn1B2f4jARvQte6nVHNxs/photos/Ab43m-uU5JQ9YrVI2uOyd2NilNYeaRAvMVOi6tFOO4xRJOBFvUOAA2SfltPjQJFkDiHKqS9hxgKwjGVKuy0jkydbS5j6oJDkOGHdIrpUquccamD4m1U37DpuXZlMRWmZCiwmBN5gElrHNeSfqIa23pFSIccFci3uPaFdCALmXYEaJ6yYCJoHHCBeQjYgWLL7T7PdS3kpHpSSsp_eDjAUPgPLQkeuOnguwhwHQ9z5v5-32A5rF62yaSFBTvwJg7TfHDXr8AXdOqNJ90383_T9vrq0zqatRNJ5oHcuOPQRXhROoXNHCA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.99,
    6.95,
    8.03,
    6.44,
    1,
    7.85,
    8,
    7.68,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-rock-pub-ari',                                          -- slug
    'The Rock Pub',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1011/3-4 Phahon Yothin Road, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7714594,                                                   -- latitude
    100.5415361,                                                   -- longitude
    'https://maps.google.com/?cid=17518997702805214143&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJFejkoMye4jARv9OWUJf7H_M',                                -- google_place_id
    '099 191 5666',                -- phone
    'http://www.facebook.com/therockpub',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 12:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJFejkoMye4jARv9OWUJf7H_M/photos/Ab43m-uDdak02s_URDVjJveBNtfiSo5_2atrOnccXGxqYo7tMmpCg-twjMeacp6C9L7PMLTRattEb5Xj0uG_sNWxWrlnwO4-7kGww9aX2d0qezCixkr7JJhfmJiM4tbmWGefeX7EsLW0YajjXJdTGq7ICY9wglKYYVMC_AGEXBk3kXH2OctwXvaU0ThmeFOeeuIt9uVmraKBUBEgmKAk2J4SutCNa0A2Yb_4iTfCinIKsS9HX3g7T7MQAzRu1Jk-I7OijAeqIdqEJ27-SKp2r0KLX8HfViX3zwH5jDXSEAj5jwNNgQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.25,
    7.25,
    6.26,
    8.4,
    1,
    7.65,
    8,
    7.83,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'hidden-agenda-ari-ari',                                          -- slug
    'Hidden Agenda Ari',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1017, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.776543100000001,                                                   -- latitude
    100.5433403,                                                   -- longitude
    'https://maps.google.com/?cid=2202569762733457738&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJz9TmVR6f4jARSoG-jIcZkR4',                                -- google_place_id
    '062 149 1959',                -- phone
    'https://www.facebook.com/profile.php?id=61576157260697',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJz9TmVR6f4jARSoG-jIcZkR4/photos/Ab43m-stcQIm8mTElDvPQAqU_LqJgq_GnKSfChJpeRHTLSjjKQax5BJCBnMOiaqUZWFP40sx-X68A86KGGpnNdnzvh-mRoHTx_AU0zypNb56GhgPgnZawW7LbmKycqcW2KwCnF-tFbyPrtSAHi6w9sgzgp4fy_sIFBWFoBrNRhe905bWq1yEGXvGrxNln_FKqyIG3rbu8QRTHxRPzoGLtSAnBq8gyE7jafoAwEw90048doHT37P578kkkOTciCyyWnIVQb99rgbmADUxkzi9jrwVeGgAnnxYVPxYCAR32NEdS04tMw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.42,
    6.55,
    8.13,
    5.74,
    1,
    7.9,
    8,
    7.49,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'oglee-ari',                                          -- slug
    'O''glee',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '18/1 Soi Ari 1, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7799599,                                                   -- latitude
    100.5436799,                                                   -- longitude
    'https://maps.google.com/?cid=3220494354002933035&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJdVqNgKee4jARK_V-U41-sSw',                                -- google_place_id
    '064 146 4983',                -- phone
    'https://www.facebook.com/ogleeari1',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJdVqNgKee4jARK_V-U41-sSw/photos/Ab43m-uhABU_G8znKtNzKRdZKl9DnFxsZC7nnfznM6d1224prx_F3G7irmaY9c9xnPKqMo_nf-DOPjbiXIvxemP2uAHxLHWRC97eKdiNG0GovyAgWKSakLXhj8jt52Mdjr0Kt1rsLyhuAZSn-aKyxcep_FtDJOBuXsP1IFDHtaKbVINAVPAn4XFxunYvv4OM_S-BDdsVn6LTn3A5SxC09Bju3_Mb8cWd_Bl851hYV3HNOQmOawX_u9TGB7DWUQGTB5Gu_7e0i6DP21d3TXpYt7G2QxXEpwz6s8h2ygFmjkehD0oMCQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.76,
    8.53,
    5.72,
    5.75,
    1,
    7.62,
    8,
    7.48,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'laf-caffe-bar-ari',                                          -- slug
    'LAF Caffe Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '3 Soi Phahon Yothin 5, Phaya Thai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.776945999999999,                                                   -- latitude
    100.543363,                                                   -- longitude
    'https://maps.google.com/?cid=4284443224454546464&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ8UnFVKae4jARIETxpWlmdTs',                                -- google_place_id
    '090 902 1942',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 8:00 AM – 10:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ8UnFVKae4jARIETxpWlmdTs/photos/Ab43m-shO5HCEYP3jAFh79QA5BE6iWhPPHeNgvgA1hfAUGDnvmasNj_r0arDEkXMHekhUJfDKKO2y7i0waBD1LVO0Oc0YV_gb8rMEHYfaxN0fV9CcOE4zl-K39Jl-xgEKCqqJ93IQb0MGTRhwBxvd0a37KIk9r0iMci-EpSLoKdeDSP0ECVkJEiTJLw5JESSXr0bnwhEEH2HrhqTYyt4cPIMAPg6YzE1UrXleFMpTgKcEYCROzXIY5oWz9ohndqZtOcGeUrSbvdfQ6rmNF7uIqUAnpdwdg7NI4D981T9b5mrfOfzLA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.23,
    9.04,
    6.32,
    5.89,
    1,
    8.48,
    8,
    7.65,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'flow-ari',                                          -- slug
    'Flow',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '21 Soi Si Fa, Khwaeng Samsen Nai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7861856,                                                   -- latitude
    100.54552,                                                   -- longitude
    'https://maps.google.com/?cid=10544485580686914062&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJq2TG8Ruc4jARDnISwMSJVZI',                                -- google_place_id
    '082 892 6226',                -- phone
    'https://www.facebook.com/Flowrestaurant/',                               -- website
    NULL,                                                     -- instagram_handle
    '11:00 AM – 10:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJq2TG8Ruc4jARDnISwMSJVZI/photos/Ab43m-twe6prDXKasTEZVMPAw_1zGpO4dq4dg2T9CGZ7OD4UCXNjn0Qjx7fSfVKY3Tc-z0iiExbMEaXWPxS_XJHbqmh-wJmZhVgfTfvfcKMIEPtpzWmTOyerbMxT9sJhxGz3FgrrPNLML0-Ml_lRzXmMOcKtnTHNqsM3z4cGewq7bwZ8d1PG78B_hkgVy5kfIESx4Mf8r0l2132ErT1o3cPIPaqubFBmQB5NQgFgdWHU71-BIxHN77HQSrGJkMFi3DXGjNuh-2jTi_0hV7keouiB9PIgREB1L8qlWBe5-DTglbco4g/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.11,
    6.52,
    6.22,
    8.53,
    1,
    8.2,
    8,
    7.76,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'aiya-bkk-ari',                                          -- slug
    'aiya bkk',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '466/32, The HUB (Phahol - Ari, แขวงสามเสนใน เขตพญาไท กรุงเทพมหานคร 10400, Thailand',                     -- address
    13.7874222,                                                   -- latitude
    100.5481189,                                                   -- longitude
    'https://maps.google.com/?cid=17594639572034390315&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJbw6TVBed4jARKwkkani3LPQ',                                -- google_place_id
    '062 254 5050',                -- phone
    'https://www.facebook.com/Aiya.Bkk/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJbw6TVBed4jARKwkkani3LPQ/photos/Ab43m-ufs4fzBqJ6xNyk6leQgUSdH5FC5TBAvGw40TSrdlkl_PLgrtnp7hRQ3GngZE41aKWQ8teQMQy4vZi5Het_JyvZ6Tp0LWlPZC8UbkL6D3e7g6nX1UTFuhRMsQYMXZBWghsg966TuQFREz2xa6OK2C-sWhgVRr1Hv0ZvxIRGlxX3NRJGkcOE89ha92r9nBuTeL_tDYYaCPjpuvmmWTlIUW40BKLKVQ8srIHTpHCyl68BjnxHYlW4PWEb-vDX8YG_nUIj_FD0sUkwJF6n1ZEEqip5YWu5cDVSXr9P6D4x-FpYcQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.71,
    7.29,
    8.35,
    5.76,
    1,
    7.56,
    8,
    7.22,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-garrison-ari',                                          -- slug
    'The Garrison',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '490 Phahon Yothin Road, Khwaeng Samsen Nai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.788456199999999,                                                   -- latitude
    100.5479734,                                                   -- longitude
    'https://maps.google.com/?cid=10506088805302097336&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ-er6jsCd4jARuFW90hogzZE',                                -- google_place_id
    '065 042 4200',                -- phone
    'https://m.facebook.com/thegarrisonbangkok/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ-er6jsCd4jARuFW90hogzZE/photos/Ab43m-srLkN64flcCWbXgYcLfpgtkCdJlKeZzx1qVnJJDc6AwiOPfZA--OoQuDYRY5FL1nE1NvUw-wkEmXM2fjmY-L21ElWR-J7ruvWBU6dlDQpY2iU-EpUveblhyPjExob0HTw81foc_k14KM0orsfZHgtJA_Yli-ss0Txw4D5uwUlsX_ov_ylYkGVcphXNk5If3plXJa2Dfh0znsDIOEuyoE08oTsNWlIyJCSB-MZQbwfFhUNPCD1jP_sKQ1klHktUShbAp19gyWfWOar6-MK-8E984IiY_haegFJHUwtSvrFmT0sJ0G8F14k2sQDFlmJ83MtyA-Cm4dWbFq8e6Jbh6v7Ry1yO0-uta83lSPclBU8NJAPBSK5Ul34f5z7jK9XJ0dHrl5Xi381_9TEi-2tC2KM0QTh49VAOSetcOfxO9OmfoXCG/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.15,
    9.2,
    6.32,
    6.34,
    1,
    8.33,
    8,
    7.21,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'repeat-ari-ari',                                          -- slug
    'Repeat Ari',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '466, 4 Phahon Yothin Road, Khwaeng Samsen Nai, Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7876019,                                                   -- latitude
    100.54759450000002,                                                   -- longitude
    'https://maps.google.com/?cid=6717220824662513941&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJA6KrE-Of4jARFZndK8BcOF0',                                -- google_place_id
    '096 164 6065',                -- phone
    'https://www.facebook.com/repeat.ari?mibextid=LQQJ4d',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:30 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJA6KrE-Of4jARFZndK8BcOF0/photos/Ab43m-vCpZQawD6QMWYpIvFop4juZoyRgPrn_Bw6XBjnBam7SbclWoGh2eAuyRsgki4X-LW2unn2lRzHEkixnK8dIICqN4UXITnxURdUFI0lMv-kkT6kuyNB5ohjvKctJrXEfMIay4tRfp34VBuO5ndSzGyvSjNtJrK4r1V0tWOdhSGffUA33316FzKtpOJUU9hNJCnP9qW2D6XC3KI2oE3uMrCmap8sQ66aJx3M2VUXNEcojf7l-7N-Vsz35bgSpNVk89qNAGJImlGutuqe6KeXh292SOZsiMM7LtR1TGe8edHnIg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.12,
    6.58,
    8.13,
    5.9,
    1,
    7.68,
    8,
    7.59,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'long-play-music-bar-ari',                                          -- slug
    'Long Play Music & Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '19/2 Soi Ari 4 Nua, พญาไท Khet Phaya Thai, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.783583400000001,                                                   -- latitude
    100.54412119999999,                                                   -- longitude
    'https://maps.google.com/?cid=17909299419206121795&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJDyy5Uemd4jARQ_njKe-civg',                                -- google_place_id
    '062 942 0338',                -- phone
    'https://www.joshhotel.com/long-play-music-bar/',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJDyy5Uemd4jARQ_njKe-civg/photos/Ab43m-t8Yhavioy9-IT8_sA0LjtIGckOSwnGfhX2yvMTf59AvDBMxR62uVs7dbaFTmVqec2owqByo3u46c00TP3XdPkjt7WrjR9ECtIYaRpmVc3ug41zmtWw5HkLE2Gs5hcOlwOpwppCDofrhwj3GiffgdRRmGQoIiWYwnlNnDzwBeC0zC4Lwy8VA0idscIYYZHIFGJ_cmqxRM-BpyWd5AN741ACo7AdwaEBt7WV1pTaDxc9sPRXhi90cVvwVwmqdsFiebm0SChWzflgmTBFWcDjNQQY-dCrM8ikHVErEsAvwF4vPA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.8,
    9.19,
    5.76,
    6.27,
    1,
    8.33,
    8,
    7.66,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'aaari-ba-ari',                                          -- slug
    'Aaari Ba',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ari'), -- area_id
    'ari',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Phaya Thai, Bangkok 10400, Thailand',                     -- address
    13.782458499999999,                                                   -- latitude
    100.5432292,                                                   -- longitude
    'https://maps.google.com/?cid=14404723676660800971&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJxw9Wpx2c4jARy50GS93b58c',                                -- google_place_id
    '02 279 7660',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ari'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJxw9Wpx2c4jARy50GS93b58c/photos/Ab43m-vgFjrJ10_Z0HXCIhsMAv0rYZA_sPK65zKD5ts0__iEMqmLBOk96hU1jT9p-SXQgS0JOpbN900uFneT0-Y5OAwoAHkLtMV9J6WbuBjlB9voOwGMCNcub8JZR-xt04Gndp55JQjX06sELmtL2CQtvAO3cUGD9KDJ3ldxn9hbVnpH5D6j8rPhrDn0xNQSB4CnSeMlZiIMm8lh_dRNZN-hYqPty8W38oXXIeRv-lfS08sUuVr4G35s1Vb7iE2iftUfdTE6hJ931ZYGYJMf0BKThxUaakuNIBk5i3riqwN1Egtdg5D4t3Mp25PE2vl6BYkaoZ0M2aHmt6BoJgQAqwmZgXMLTrWGaNi1nPgFwqZW5k0_EAKU4_KBAaWMqZFmer8tYiFOwIQHau5oTZbZQxB7F6cXST1_ByuwwZMRX8YjzEwn3bMX/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.06,
    8.83,
    6.24,
    6.03,
    1,
    8.28,
    8,
    7.14,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'margarita-bar-asok',                                          -- slug
    'Margarita Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2nd Floor, 2 Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.739416499999999,                                                   -- latitude
    100.5573144,                                                   -- longitude
    'https://maps.google.com/?cid=14364403674097111544&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ3fEwjauf4jAR-NHfJAmdWMc',                                -- google_place_id
    '02 253 8375',                -- phone
    'https://www.instagram.com/margaritabarbkk/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ3fEwjauf4jAR-NHfJAmdWMc/photos/Ab43m-tFW9-CHQFbgN-Vh9TL6zg34aMgWXHQsnZ_wOrbOPq0G_XSxz-WS1Bj9WGhufEvQK3RhjLrNACgJ2i_s8ITuRoZ4vWthr9PpL0IHWYq8CpjOyrlrNRkmGK1x0rm5vOv3bNt50D60Cx_tAmIDjBflAEaCTzVoAVNO2_La1pPB7pesrzilXept_AbLsKX702BVqSKqri8JTLJXf5OJdOUSaTLZ8bxCwaqihTGAMHGxmkWPITPvoAJ19glzs90XkA1M12-Xbqq0iBB0jncVMTWyc907IhcYMQQ-LIPcXWqBYxhmg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.2,
    6.83,
    8.64,
    6.01,
    1,
    7.61,
    9,
    7.98,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'alley-cocktail-bar-asok',                                          -- slug
    'Alley Cocktail Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2 Soi Sukhumvit 11, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7401249,                                                   -- latitude
    100.5563104,                                                   -- longitude
    'https://maps.google.com/?cid=18108125901076279007&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJL2LH5LWf4jAR366z6ZD8TPs',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 4:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJL2LH5LWf4jAR366z6ZD8TPs/photos/Ab43m-veCaC0e5SR74ID94z1hzaZY4NRTqfpth-JC2B2RLYpyEYgOK8Z1jZ-tPOayDltLg_S6AV74koAEv_jzMUCuqenwMx_w6kWJNcH5bNiKwMMwRHcFAzsd90UAlV8Px4QC5VZIFzA4j6R7poTiaEeKBmQIKw47n-YO1_RtiTqIROamyhkKcxzAzgG3cbLhcEv49Taax_I9OndSG5GvOktWrSvmhJDj5BSG6Cl-Q-bEdiVtHwdbtPe7hA-3xG8K52T7ZfvStz8Makl5OFhbItZpQj3nJF-lG8hHfcwbxrFsuz-r_7QlpuWgp_q4nb0nQkx3KWZJyi85STStOOT2_YZGyK6yZ12tAfhEbJgHAuDA4zY-2wCfTp2t0PdSQpJxYbNYyY_QVK_stUVStz1NQJcAbuXTHTUkroEB8UvdfymRzYc36ji/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.66,
    6.7,
    8.75,
    6.52,
    1,
    7.69,
    9,
    8.01,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-ledger-room-asok',                                          -- slug
    'The Ledger Room',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '32nd Floor, SKYVIEW Hotel Bangkok, 12 Soi Sukhumvit 24, Khwaeng Khlong Tan, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.729228899999999,                                                   -- latitude
    100.56908879999999,                                                   -- longitude
    'https://maps.google.com/?cid=13915565825204147175&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJC_MPMUqf4jAR59Pb42MFHsE',                                -- google_place_id
    '02 011 1133',                -- phone
    'https://linktr.ee/theledgerroom.bkk',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJC_MPMUqf4jAR59Pb42MFHsE/photos/Ab43m-tFGryrW5Bin8mLJb4FRzxSbwzoKIhVtxXDVaLq7YuUHyCXIULPPJoO0KPBuu8UzJbO6ntl5NFMoBecPcTKWm0Rb3sSD-dOJjqO9ipBoOa3I5q0o6mmdL_nJy6Mzh0Qz9n7H0Eqx2k_bIc0k6WHNjB9sKP7H2vyRSLPJiS81NJRygrt2y65ITbZdgQfIbvJOkYB_WGqnA_givf3X7-Ga4xgEFUsm0b7pf8HQHgI958wIew7UbeobhD5hNV5B4sfEqbhfW7Q5QvpwQQSqQ0hhI-lrOREmgMF0kkjAcKGpQ9imeMEM0gLpQOVU100-w7VxABpFmmiFSUVlssWCnp5gOKmv5S2mFA2w4lmQEjDlQ4ffG3TyDjziqRN3yR1h0lPxsMlCg0Q_1tMNK92buSM7Ast1kW2x9FAEH3cMZM3RhMq-SYZOC37Z4t01HtFZ3pH/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.17,
    7.11,
    8.6,
    6.23,
    1,
    7.93,
    9,
    7.81,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'after-te-time-asok',                                          -- slug
    'After TE Time',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '50/5 Soi Saeng Ngoen, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.739822,                                                   -- latitude
    100.5808021,                                                   -- longitude
    'https://maps.google.com/?cid=9736362019650918360&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJgdV3CPSf4jAR2Nfl4auBHoc',                                -- google_place_id
    '085 329 2647',                -- phone
    'https://linktr.ee/aftertetimebar',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJgdV3CPSf4jAR2Nfl4auBHoc/photos/Ab43m-t1zp51Z_PW5UVduDiiIwoZxH6McJY2EZlgK34YpdRWAupLU5aTBPKqg5JMczFQU17ggPvK4kpm_yqgNdIhV0ZbvXtweLSg1gkb1GxMIjiIUsyMEmu5EuG2wtr-7THcdQtmUJNnVY8WgtldNj7349GeDdMjNW2WkfNQG4HQ72ctsfVKSZ8K9YCF61ZX4xv6KgzMPWEt-SseN6E0yxaj6friBBA2hVBLsncRUx5esKtq7yZPMRDSdhakgaKEYEsZqlQlqtb5VAtIUtWLOyaA9cLn_3uLrdFTjS4WkE4ZqyPqYQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.67,
    6.59,
    8.17,
    6.13,
    1,
    7.53,
    9,
    7.55,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'wyws-cocktail-bar-asoke-asok',                                          -- slug
    'WYWS Cocktail Bar - Asoke',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Sukhumvit 21, Asoke Montree Klongtoey, Nua, เขตวัฒนา กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.746497600000001,                                                   -- latitude
    100.56232179999999,                                                   -- longitude
    'https://maps.google.com/?cid=17887024886835189863&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJI4iwRXGf4jARZxhidF16O_g',                                -- google_place_id
    '080 081 5392',                -- phone
    'http://www.facebook.com/wywsbar',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJI4iwRXGf4jARZxhidF16O_g/photos/Ab43m-sOJcFA5fLkv_VTyumMvGm-C7cn10XIbWojYALzbOUK9ykjhF_OnJw_3EZFVbunU-ZYKW806pCoKuvRIzK3hDE0RWWp05gHovIC8PfOvpLmFUFhqLmdiYkqr_yNG8Yo-4sSkvik0ZACKxKAM-ZF9wHlHwtYNWf9OHfST1RvSOfAfk6hgU_Eh0UW3bZhCLoOYSRV9d-rkAD0dEWQ6sZ496iTAW1vbq9FCp4lg-kcyw7a-KoxEKqfzK1ym7y7Flk5aJWrPaa2PQD85XWg6RFQvNTAX1VXD8NkCwb308irLVMampl4JyREoD_6oxM3dzWualOEFthisrJics4zC_Im44iwpE1FHlCi6f0SPVOnrez9Hvh_F3mw2xgV1lB-4LW5QgJC1pOhlqFg4lRof8lXQFlQA5ElCGkSu5C_vUQiQwceYmI/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.39,
    7.04,
    8.13,
    6.1,
    1,
    7.72,
    9,
    8.01,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'heaven-17-bar-lounge-asok',                                          -- slug
    'Heaven 17 (Bar & Lounge)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '221 Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7384136,                                                   -- latitude
    100.55874759999999,                                                   -- longitude
    'https://maps.google.com/?cid=10723789244140946540&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJp49BbCaf4jARbAQtH4CN0pQ',                                -- google_place_id
    '063 268 2814',                -- phone
    'https://heavenseventeen.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJp49BbCaf4jARbAQtH4CN0pQ/photos/Ab43m-sAyZQWoDl8CsCGkajQPmYTDhcVwL0-sXzFqzUdTudDi_yqh96SPDtRYgUGybBmwVwytcNxb9FM5nx19ZZeAfDt1M4E9aA-Vw0hUB6Gw2udSlaIMKcK4e48gNHKNlxzGi6uOaON9yuCGngm3QIh-LuAo_n7hRMWEmlK4j7iLnqCHONXBPycSW8g5o-MA8bzL3LXa1Iy_M-ovqN7RXWLE0GgxJ-hsAgW829aW8T6X0rkwPo10S1mi0Pnx0WOp6OKv1CJQd0k4q2Bhj4RtvC6C5lJJE-NdWgeb8ZL_3qA5P_yqHyB9Ap9TdLuxdPtDQqs9eotUtmHCsp2J6p_KQlt2xvefa3tDg_GYvQk3XgAqQlQAGAw-bF7hPSoHQTxD1RcRMXSTHG1qK3k59ie1zycQJUmeK_qyFMSsfJCrzpuOA_xGt0FaJoeH8Oom-g6vv2p/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.16,
    6.95,
    8.59,
    8.28,
    1,
    8.42,
    9,
    9.11,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'door-no6-asok',                                          -- slug
    'Door No.6',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '25/1 Sukhumvit Soi 6, Khwaeng Khlong Toei, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.738968499999999,                                                   -- latitude
    100.5536145,                                                   -- longitude
    'https://maps.google.com/?cid=2281507319749346470&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJPVZsRf-f4jARpgQdwtGKqR8',                                -- google_place_id
    '080 356 3959',                -- phone
    'https://doorno6bkk.netlify.app/',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJPVZsRf-f4jARpgQdwtGKqR8/photos/Ab43m-sg447CRzAVyDIRd8j1EVrCPS6eYYVzx2Pl6qqQ5EJXf1L5Xbf4MVuuaNqa9MYe47C1_neK9o_9-5Rlnxq0o6c2bXKupWItdz8EzMsl2LoHt_x9Qi4Q3Nt1r4VQQ3qj_-t7l5yrg7gMOSaOoYFtou3dhqfp_WldGl17mFeEs8NZK1az4gfEBnW5-GSt60DW09W8P8CzVMZmvUvQ6CtIj2kLj3Ym8kCwn2XmoQSLDYdY2ll77hjeTC6pnGH7qlYDa3H6XqC4ODrimTvbaT56B2kc48MNuto5-_ttPwqmAiNXuw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.28,
    6.78,
    8.06,
    5.83,
    1,
    7.94,
    9,
    8.03,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'blessing-shophouse-asok',                                          -- slug
    'BLESSING SHOPHOUSE',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '6 5 Soi Phraek Samakkhi, Khwaeng Khlong Toei, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7366716,                                                   -- latitude
    100.5598426,                                                   -- longitude
    'https://maps.google.com/?cid=8131373250632642175&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJeZTFssOf4jARf24SvONw2HA',                                -- google_place_id
    '095 596 4655',                -- phone
    'https://blessingshophouse.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJeZTFssOf4jARf24SvONw2HA/photos/Ab43m-snw-oE7wTtIkT6acE_NCMMgfde3sp1E2qJkRT_rQVJRa_hioKEik2XIfewyCv2tq2laY3T-lipV2Jq17rUvzJK0Gexhvhofmqg0FxFcTL608mku7uLDS4KUcQnJt2DFFasKQhS1Oqee11-h4HovZDF5R99zMrWSOEOWp1xyvHTPh4FepKV7huUjW0d33_2fEonL-mSjkqB0DlK_Wz5ky_JUfIveoDQ-5bolLDsFZAqV7qKChXS8pCIwiz3Kge2Y0QC0xyZQaK3T2ort6p3uOYmlqjstjloLueHMbl64znG3A/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.56,
    7.03,
    8.48,
    7.81,
    1,
    7.6,
    9,
    9.36,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bloom-bar-asok',                                          -- slug
    'Bloom Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '24/3 Soi Sukhumvit 23, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7397767,                                                   -- latitude
    100.5633146,                                                   -- longitude
    'https://maps.google.com/?cid=9235910412369035555&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ9Wv6YmSf4jARI4GWCpaLLIA',                                -- google_place_id
    '098 324 7300',                -- phone
    'https://m.facebook.com/61550645740196/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ9Wv6YmSf4jARI4GWCpaLLIA/photos/Ab43m-vQTEEnADSb-w_NOlmR_ylLPI-mxqHfbLASpk85exVyDXmjiIbVV1-MjuwIB_F_NT9HPvAlXku_8cLsBl2BKV87kdjyJYOlAwhOqo6e32EKexdV9n5mqYX7qaVGFPxyxp4VR6YhOp1iqUsvgdru48SETvXxB7Nku1bmoCbaZtJ7VCV3JBZHU9sFXEN_Hnl84ykmLob5aojSrrr432M2K1RyFLDI3IwaUjBV20DTWT31gcA8muWCdg2RltqO8s1EzwTchQc9XFP6NQE4G7f7Z6jKVzmHhtHhUnwO4OIfgGkTQA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.59,
    7.12,
    8.49,
    6.4,
    1,
    7.71,
    9,
    7.52,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'mimosa-cocktail-bar-dispensary-asok',                                          -- slug
    'MIMOSA Cocktail Bar & Dispensary',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '21, 16 Soi Sukhumvit 4, Khwaeng Khlong Toei, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.740021899999999,                                                   -- latitude
    100.5530806,                                                   -- longitude
    'https://maps.google.com/?cid=17055533590370325182&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJjxnGrnGf4jARvhLEtG9tsew',                                -- google_place_id
    '099 785 1124',                -- phone
    'https://www.instagram.com/mimosabarnana/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJjxnGrnGf4jARvhLEtG9tsew/photos/Ab43m-snF0yx5Pj3nGdUM0lp2dUlDoIhErE9jKPUoztMSIuvjwaNLrRTofdPXSh2VKqqrRQgepnFYt_pK_n11EYunxFsNkaLovkg2deUehwbTzD6-dhNy-LUFei7-Xjm6nFtDg3M23nWeP9C2_Tx4SzDAtp4MJW6CwF7__pex5jgDTVz_XWv9vSWJK_MDLhS022EaaVwvpSO9vS0S4K8XDVVcUlczgxLS8_WHvg64dWE1u_Rpr1YBgPA9VGGh8v8BcqR-lYxwev07RDmI6kXq9dfKa9xMLsJyS_wTl1MgyOY1A6inQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.06,
    6.52,
    8.15,
    6.34,
    1,
    8.11,
    9,
    8.05,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'kino-night-bar-asok',                                          -- slug
    'Kino Night Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '3/1-1 Soi Sukhumvit 4, Khwaeng Khlong Toei, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7414771,                                                   -- latitude
    100.5531456,                                                   -- longitude
    'https://maps.google.com/?cid=8267113412111069252&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJkRyscUKf4jARRHC_5tivunI',                                -- google_place_id
    '063 990 9333',                -- phone
    'http://kinobkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:30 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJkRyscUKf4jARRHC_5tivunI/photos/Ab43m-tTMEX83JSqZe9YqTKq9qpemtrkZnKqayqJn7dHPHxP8NlrzBIqv35p-6018I_pc1OqzLG7tO-6fOTbfVGseLdHOCjCE1NM-XyzWiBPJ1thHseG-gc-e4gqpRzdv_Z81npws4Q9O4rBPQ8s-iiIvii3xTrMt7uK3uJFNhHeuuI42wl-0RGVZWXspBSS_CTKcaj_3kCFatkG3GngojGwDSBrvQxhvBwPCItHXV-qI_Wieu2msAKzxjkmfm4PQ4YPVrGZUyZ1D-BUKw9pbi7NHUNQKdE1X0edraM7jGm4PlPwGw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.72,
    6.91,
    6.05,
    8.35,
    1,
    8.13,
    9,
    9.15,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'club-millesime-lounge-sofitel-bangkok-asok',                                          -- slug
    'Club Millesime Lounge |. Sofitel Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '189 Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7396427,                                                   -- latitude
    100.5578286,                                                   -- longitude
    'https://maps.google.com/?cid=15364507776931700674&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJrVMvEACf4jARwp-9IGuyOdU',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    NULL,                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJrVMvEACf4jARwp-9IGuyOdU/photos/Ab43m-vZnyI1_RsdkxiNTyyD9d5MfjH73GboQyVFW1PXwK6pi5pnu2-aqz6VonRjhwBc531pC55W-teAe1qAzL2wI3r781eKANeqWYqy6-RacQp8W0gv0e8DaEzbrHg80Mp7JewaCI_W-btBp6B6oSvQRlwq9prgQvYLlZwxiBy8JFxrBWnPJ7syqvqrPx7kd9tg9ol2AN9_PfWgJHRpPbyfFMYdnbOZMuepbIxL6CAxhh9AXxAsvtKhLB4agYmF6zJnbaSqR7NO-W1D3aTRo5iExsWQcXPC2MxJGTHunLfLcCvu4v-mu4glJ373qX1JDSOCB3HoYeBhNSfExTpGF33DrN9mOpLv-0GlEihPO7oHhbLNAHp1jSNAaaGqoWG8WcsY2A0au0SbsSORtE58ioaTt10ycitHgdN-aMNIrhYuXABPyjH78z4RtVQ1SklNf5QS/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.6,
    6.52,
    6.15,
    8.09,
    1,
    8.39,
    9,
    9.17,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'axis-spin-rooftop-restaurant-bar-38th-floor-asok',                                          -- slug
    'Axis & Spin Rooftop Restaurant & Bar (38th floor)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '38th Floor 413 Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.736114899999999,                                                   -- latitude
    100.5619832,                                                   -- longitude
    'https://maps.google.com/?cid=188608822989421452&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJFQlcIOOe4jARjPvJp7kSngI',                                -- google_place_id
    '02 686 7000',                -- phone
    'https://montraj.com/continent-hotel/axis-and-spin-restaurant/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJFQlcIOOe4jARjPvJp7kSngI/photos/Ab43m-tW6oGyK5m2foZlkTPK2Y55zklzxfu0R40GvBh7M3tr1LLOod2t53kBAJ1WchDikhinbeYWw0kjBLNa59KWYBN5PRkFfTSYnBVXB4sjVAXjCWUwgfgs9nJc0EOXnx34wLSV7IJfnnHtY9etP7ebMPST5IDm6BILo80q7jM4YozVvKYTfDiNW9EkdnLQUKNmqLlSnuquP07PZOPC44SCgt4glB_wBGIab2GFPBTt6-6QqVrp-E79WhMRzp1KsGxQ-WMAqBramdJBLTuqaNGJmjgYQ9Z6wKyK5zkA0NPA5Z9fDA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.7,
    7.3,
    8.64,
    8.01,
    1,
    8.25,
    9,
    9.01,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bangkok-heightz-rooftop-restaurant-bar-39th-floor-asok',                                          -- slug
    'Bangkok Heightz Rooftop (Restaurant & Bar 39th floor)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '413 ชั้น 39, โรงแรม เดอะ คอนทิเนนท์, Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.736264,                                                   -- latitude
    100.5621587,                                                   -- longitude
    'https://maps.google.com/?cid=17213417022055717828&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ_QYAIOOe4jARxBtLupRX4u4',                                -- google_place_id
    '02 686 7000',                -- phone
    'https://montraj.com/continent-hotel/bangkok-heightz-rooftop-restaurant-sukhumvit/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','popular','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ_QYAIOOe4jARxBtLupRX4u4/photos/Ab43m-tteRweXnacXx_MOUlAopw1zF7dSsi7_YgnJ02mkuW7qYVwD_5AK6q5tf3nW__yJFDLdXFoQbO6QawFyBIJ_xYrByhrPE-z9LpvJErQ_9oA3bguOB_pBOHCTtyDuKzzU93XOToXzKpDcI6mvvF1zbdccZCGCzSl9xvEYQF8Gp6oHgL7lLuG4O45llmQ3QNcNoFttXRQlYQs-ieZk3-U4tI5HiR6nIjfrhONRglPPhUx94g1hMmKuPO_u96KfPmuqQenWytVsTGyCyyQ0OKQdgRc59Iq0FfU3v2ubFJCVYkASw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.04,
    7.74,
    8.23,
    6.39,
    1,
    7.6,
    9,
    7.96,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'cigar-lounge-in-bangkok-sukumvit-at-abandoned-mansion-asok',                                          -- slug
    'Cigar Lounge in Bangkok Sukumvit at Abandoned Mansion',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '41 Soi Phraek Samakkhi, Khwaeng Khlong Toei, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.735258,                                                   -- latitude
    100.5601969,                                                   -- longitude
    'https://maps.google.com/?cid=8581162538238651557&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ31MsDa-f4jARpayaE91pFnc',                                -- google_place_id
    '02 259 7007',                -- phone
    'https://www.thecoachbangkok.com/abandoned-mansion-bangkok/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ31MsDa-f4jARpayaE91pFnc/photos/Ab43m-tvFUAnS_j04A6nbRQ-UXiRNKg5wt7VaTParjGN8MyD1FbGhYvPE1O5XzED7sempTNMEcbjbDC_aBKhelLJQ5RM5X5AQfVq2JgURSvaBAFYT7aD5NmPQfV9q6czF-YxLheTD2-LWTAlPYmDSyZz3UPo2skLNDczGt0Iv-B_-hMK2wrf9EL5O8OcUW8lRIH25aeFWN1O1Ziz4jiCBK6HDPnbT_uDBWHiXZ-Adi0bAMuvkufvp8QtE8zXx-JGhdyoAKj3t_9LLh_QBhWhQDLlMb65inLn5zXyoFVB8YNtfWvrcw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.39,
    6.66,
    8.5,
    6.1,
    1,
    7.5,
    9,
    8.07,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'abandoned-mansion-asok',                                          -- slug
    'Abandoned Mansion',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '41 Soi Sukhumvit 14, Klongtoey, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.735256999999999,                                                   -- latitude
    100.5600491,                                                   -- longitude
    'https://maps.google.com/?cid=15870122832082825760&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ82hpAWaf4jARIPIc3KEAPtw',                                -- google_place_id
    '02 259 7007',                -- phone
    'https://montraj.com/coach-hotel/abandoned-mansion-bangkok/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:30 PM – 2:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['cocktails','premium','popular','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ82hpAWaf4jARIPIc3KEAPtw/photos/Ab43m-tQcpY9I-JvG6OnGvPpqr05XrJw6zgefmh8oVcOmX-UQQqvV1Ikq3eQoOcKM9kskKfLiluqcfnyPL6ujXWAwepXa-I76vAuJbTQFMsmKf3eHC8dAUjV8Kkg4YrhtbBQi9AYRLldI8LxQu681seFmw_K_zV7LVKlEs-h-ZbjJ6tFNJUgzbUwLC4txE8vQUsq6WudL5WV0ajboaztr0nkgmlk1h-M5eALDT9hJ_gGH0VB3vNPMk2wA-hM_rpe6XIchAe_pdFQMznQRP8HcvWbRMFSwuGiNIuzfag-f3O0iurn_g/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.7,
    7.21,
    8.23,
    8.1,
    5.18,
    7.07,
    9,
    9.21,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'rb-karaoke-asoke-asok',                                          -- slug
    'R&B Karaoke (Asoke)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '163 อาคารรัชต์ภาคย์ ชั้น18 Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7419008,                                                   -- latitude
    100.5617691,                                                   -- longitude
    'https://maps.google.com/?cid=14013819256390789857&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJff9tl_2f4jAR4aqzg10We8I',                                -- google_place_id
    '02 675 4224',                -- phone
    'https://www.karaoke.co.th/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJff9tl_2f4jAR4aqzg10We8I/photos/Ab43m-sQmdMjoA4QKiWfloePu02m1PrswYCVuRZt3mLUm_IMniFJDsGvTqQkl6IFATX7b9RbNvewdM73H2vNaid_jc2TLWriDUx_NA_jY4hVsVWH-bXaRWwJZoau1hwFxUx7QOJGt09kruzpbNpsdkjkKMhPocvKpkSUd4Z75Ck2hO_gXPCnd_h1iYn2cbTBCOWbCLMELvGcbOV2jH8J6vjnbaZi8z6x5mOBAHGj4APdzvRK6zknmGealcjCJq0y7kUv6XlHCAyG6OEMQbzE9X64IkUxtXucUg8A5cyPOKap4SFkXQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.25,
    6.51,
    6.06,
    7.89,
    1,
    8.12,
    9,
    9.56,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'lulu-rooftop-bar-asok',                                          -- slug
    'Lulu Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'PHV3+FCG ซอย สุขุมวิท 3/1 แขวงคลองเตยเหนือ แขวงคลองตันเหนือ Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.743659200000002,                                                   -- latitude
    100.5536416,                                                   -- longitude
    'https://maps.google.com/?cid=1251637169404436682&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJpzSQHwCf4jARyuAGxl-1XhE',                                -- google_place_id
    '096 196 3445',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 5:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJpzSQHwCf4jARyuAGxl-1XhE/photos/Ab43m-vgCigzxmqsQQwmUkf5wqUxoOV0twSL8QcSIW8pRnFqtJtf5eGSMwlOw6Obj-4KmkquJO5gBEOrqSkzLSPFGW4OJHuUJ8l_A-zSITIFpemohackQhShsn07JQCOMP4dFVt-RQuYuLFwjFTkMvNCgu9Fsa1FrVL74AokaISRzVeWrbcaFD0Z8R6KMvN2lyRevgTAUVPOwLFK1cw8hxC6FXlqJB23VC-ES21V3nr3NotsmHR4Xv0powwhC5IUFo8m4DY9kD3Z5nOeHZ3mn-xx_JuUGoVclzji3b8ODyTAe06ZiQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.56,
    7.18,
    9.25,
    6.37,
    1,
    8.39,
    9,
    8.33,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'flashback-rooftop-bar-asok',                                          -- slug
    'Flashback Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'เลขที่ 7 Soi Sukhumvit 20, Khwaeng Khlong Toei, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7332129,                                                   -- latitude
    100.5641052,                                                   -- longitude
    'https://maps.google.com/?cid=12133889609204162982&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJs4VdW8Cf4jARpuFqvE88ZKg',                                -- google_place_id
    '065 819 4478',                -- phone
    'https://web.facebook.com/Flashback-Rooftop-Bar-112581337206045/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJs4VdW8Cf4jARpuFqvE88ZKg/photos/Ab43m-uP20Fb7FNT9SAUET1dq41JDR9WlOEjVyPSr9wGoVFmTK9mjMc6fdFCeW7N7uZaOk_SHQLG5xnLyjaK7pYtfetwHx4HR9RPfZm1w7ktAOatb02ftZneATmAbrloJPLqkhNspPsWy7DDDbQmDwuvLMUSiSZziXzCFwSxXfhx5PyOQTfArnKY-EJGtRAlwSJGXCW1udgzx-UPv5Kl4tinQW-jWX47cuGY7B-TXrWf0LcxAq9uYP4BbzbTd-C11sAkHp_LgtMLkvlBWbMkeXLkfIOBYMbTnHZotEYx63ZW5YJLsw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.09,
    6.64,
    9.32,
    6.4,
    1,
    8.28,
    9,
    8.07,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-brew-house-sukhumvit-8-asok',                                          -- slug
    'The Brew House Sukhumvit 8',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '4 18 Soi Sukhumvit 8, Khwaeng Khlong Toei, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7394664,                                                   -- latitude
    100.5559887,                                                   -- longitude
    'https://maps.google.com/?cid=7794445098375031790&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ8VQq2Eaf4jAR7qvtLYVuK2w',                                -- google_place_id
    '063 215 9998',                -- phone
    'https://www.facebook.com/people/The-Brew-House-Bkk/61554425905235/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 AM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ8VQq2Eaf4jAR7qvtLYVuK2w/photos/Ab43m-slGKLNbupk-BDuQGaWhpVobcVM02bg8jFwF5lgBADq3hehzsN2w5e9LEn90w8CQwDPOlfQ_51kQ_CMzYP4ylW_X2AoDsBb2gd9vcYmrlSGh-Y1nD69raPp04WrQC9nwE39-hCkpOFqGrjbwC2-D5KspImcMCaJlFdj1nyp0XP3yhHTIh5lsziySJ3qFAcs1yHeDJQatUZfbpWzEfrJaqX1ML7GFMmVO3sBSthhf6V0VV2aZgMxgmekTUzpmN1yAYLjOnRqjNm1sgHt-MpcXxeY6J-T665Y0UzL-3WgadMqth-656iM4FrZ8DyF173lInDET4LLwjfZ7eIP2u8ZqXoQ-lKLYEPQ1LhPuY5iudQpnP-LZ1rwJpuuBc5Zx3P8bhd0eLS7c1SDIDTHJKyJaFYUMwPGsKOrBAofffGr0s4YZk3RiLAr65CRDDeWluSu/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.13,
    7.09,
    6.49,
    8.74,
    1,
    7.75,
    9,
    8,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'midori-music-bar-bangkok-asok',                                          -- slug
    'Midori Music Bar Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '3rd Floor, RR Space, Soi Sukhumvit 33, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.7319544,                                                   -- latitude
    100.567856,                                                   -- longitude
    'https://maps.google.com/?cid=12335434684313254412&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ45Cvsq2f4jARDDqGTH1EMKs',                                -- google_place_id
    '084 174 7161',                -- phone
    'https://nightify.co/book/midori-music-bar/google',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ45Cvsq2f4jARDDqGTH1EMKs/photos/Ab43m-vLHhWOEeM5dtSXKqr3IC0Kxb472SzzOu0vtTLQ7pxwLdYx8TzpdK9z9iPNi3DFJBDla6CS-sLRSAryK5lD4nzJgm1RFqY7i45h5nufvfxeXx0iLYPE113ATUCiScQw3oA6m7Z-pyZfwIxfQCnzmyel-Gb0hxmzoKi-LqOwCseBeu9H5chDhqKGJckl30lHsLB2cqHu5S8V_rWLLy5u7XIVCEIi1P7WUbk3CLfa58Q8plQ5f2EghnM9wPUfGu4VAgVfZCE-1WHZe3wnSJLDXrFDvOAcD4o4XMp7R0kCinI_7HvhZElTC48B4t2_5l0vJBJ9-nIIJ8_8jiR7Gp8KS8nwHF9xqh6D8-GV7jBxha3vSOHRZPnG3ekHcA-UJNw1ZT0zdHSOVdg8IZg5FZ5MP9jjeapgv7gkMwUDIw6u-MvBlLLSk4OLod2hnJOwPotE/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.63,
    7.12,
    6.35,
    8.77,
    1,
    7.68,
    9,
    9.1,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'indulge-restaurant-cocktail-bar-asok',                                          -- slug
    'Indulge Restaurant & Cocktail Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '403-403/1, 407 407/1 Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.736193,                                                   -- latitude
    100.56193999999999,                                                   -- longitude
    'https://maps.google.com/?cid=6866603430692210742&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJvcw2HuOe4jARNkjje3ATS18',                                -- google_place_id
    '095 551 8400',                -- phone
    'http://www.indulgebangkok.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:30 AM – 1:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['cocktails','premium','popular','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJvcw2HuOe4jARNkjje3ATS18/photos/Ab43m-tkOQYPr3n6UNZdAkTcS3tz3KRhjEhFYI71k08qUQUJa4_BWqCagoFs-X5Y0TiZJoEWSuBqCeAs1RXthjoUYwlFmJxpSG89yeNmenwo8UVMgebYYugspwVXp9rP0zv2A2GHvTuJA8lFxf54_Y-2gyDXcNhzda4u9GuAGUvZkHjAaOtm2qkBBlamr5hFnZLwDoonmZHfcYZA-It_hXvUinTuUkE6F6IER0NwcT-jyoqdiYwgiN-sgYFFmGlh9Bc-8YADcV_MoXP-Yms_J5IF-0DcmuwX4pD92xiogASWBfssAg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.41,
    7.13,
    7.98,
    6.46,
    1,
    7.48,
    9,
    7.76,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bar-us-asok',                                          -- slug
    'Bar Us',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Opposite side of security kiosk ( Glass door) Floor 1, 61/37 Floor, 1 สุขุมวิท 26 แขวงคลองตัน เขตคลองเตย กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.725582399999999,                                                   -- latitude
    100.5694437,                                                   -- longitude
    'https://maps.google.com/?cid=9250142891970817842&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJG5QaZUKf4jARMm-GbfMbX4A',                                -- google_place_id
    '080 510 2686',                -- phone
    'http://www.us-bar.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJG5QaZUKf4jARMm-GbfMbX4A/photos/Ab43m-uf0uA1wtg0xnxLDSQ23xoCr__TOGogc194jQAAgHPxSC3fKOzkt9BzzbueTz9hlrFb0hQpjnAuBhI2XyJu4L_WI8P1ln9ggI8JoHGo4vMgw5EhvVFITih7AKfbgunu_n3PJGqcmvANkNb3B77H1rkGgcm-vWINUKyVTbbVDkr92AWkjx_C1t7T4TghdsD3tp-1-nsMuvsuLzNqatlidE0nyr9tnUaDR0bxeYwRPU49sk8IHirG0EVi1CPMllJaXcc8VMbZD4WxV6oAqp_KWjDUeLzp7s6YRfic0N6k4NtzEnLbCi7yetWzreOyi4bnYUJIjnpmloKmwyVkZm06Uf8EmrHPQEx43mh2zD0d2jj4HBFJugwg20OQpk2FPaERxpYvqDSdchHbKclj9dER_4_2mlezL1a15OAaw-dnjpIpeYE58BkRfKe3PAnBRp1o/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.23,
    7.14,
    8.03,
    6.12,
    1,
    7.76,
    9,
    8.03,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'apt-101-asok',                                          -- slug
    'APT 101',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '3rd Floor, 233 Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7385325,                                                   -- latitude
    100.5590861,                                                   -- longitude
    'https://maps.google.com/?cid=11694982698015530578&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ30Iy7SOf4jARUh6OGc3sTKI',                                -- google_place_id
    '02 821 5813',                -- phone
    'https://www.apt101club.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ30Iy7SOf4jARUh6OGc3sTKI/photos/Ab43m-sW8p-k3buQGQoNwu0FKpAK7dvQrvr-SiJk-YzSZpFxk1WDXUbVS6me9wn_Y0nAsQPyzh1Y38IZZea2H_FPuFoQrWoAzoGqodiKZX6nBbnoRdqZLqjQKt1kdNpry3BgIN1kqAmQoRk24o81I-6qMYJzpm2lUI3AFsLU97rMGcAFdVGSrRdMFnGXyc-FsAAW5XmgFvQlJpjGaLjMFFjkiDguJ1MHIwui4EjisJsQiKUC8FN4bg9TAC3hka8Hyw8ZHp6LUjopCqPQn6PpzNVdIQ1QR1j8OjGeibSP6CqUO6NM-g/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.41,
    6.99,
    6.07,
    7.99,
    1,
    8.3,
    9,
    9.11,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-consul-club-asok',                                          -- slug
    'The Consul Club',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'B129 JLK Tower 30th Floor, Units 3001 Sukhumvit Road, Klong Toei, Nua, เขตวัฒนา กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.7409381,                                                   -- latitude
    100.5552524,                                                   -- longitude
    'https://maps.google.com/?cid=2826850477650253510&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJMW2XGFWf4jARxpZ8OYj9Oic',                                -- google_place_id
    '098 010 9936',                -- phone
    'https://www.theconsul.club/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJMW2XGFWf4jARxpZ8OYj9Oic/photos/Ab43m-vAL0ynp36gFzobITg2UpRctUcHz8Z7fQyNBmAgVtyj4smuqfD2jP4ol-YimrpRda1xLteTTVTQqCe3SKeLxrWj3PSiKaPAwtU4Yyke1CHVV-QR0wzdIdaGs9W4lsKxKoImf1Mw7Fnz4aOcGwbTvdNidhivGiXEUraRA89KH4aAGPC3On5GyTTfM7seCtN1viX0guFhT5OpCW9XThDmegCHze38q-n3A9WCh8qcekhuhXOeKXWBJeiisUR_CEgtexq2Vk_7PnICvB98wAbmswUeVqj7dhp5dbVj95bLBQfm-A/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.07,
    7.03,
    6.41,
    8.23,
    1,
    7.86,
    9,
    8.94,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'green-room-bangkok-asok',                                          -- slug
    'Green Room Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '131, 29 Sukhumvit Rd, Klongtoey Nua, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.741391499999999,                                                   -- latitude
    100.5557491,                                                   -- longitude
    'https://maps.google.com/?cid=1121106416240732342&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJf7M4x2Of4jARtqhwf1j4jg8',                                -- google_place_id
    '080 993 2299',                -- phone
    'http://www.greenroombangkok.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJf7M4x2Of4jARtqhwf1j4jg8/photos/Ab43m-sDXXuv2cu3MJit4xtdWp86Nn6c6V_0iGf93gPIiLn_7XGvarmMq0a9w3qpI9KhMPblETvvpd8P04wG8U-9OppQQf223D2YFlvmX8Ib-3RY0pKyVTjWDGiXuzo7FAxK9-zhnbx4hlaBx90ahyufZgASuuv1W0HsKJtNFzB_efLEzVsqD0oZihY5bTlFZjRsbjupfdyiVyvt6Jwr_fgdnsiCzMxNVFW31pDBlIZw1-hOjH0d6io2S1g1_Em2X9Xsi5CBPImC7pwE-xndfhjtGqTHarusrApe2GAsZSN-se4Njw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.03,
    6.56,
    6.53,
    7.83,
    1,
    7.58,
    9,
    9.41,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'blueprint-livehouse-asok',                                          -- slug
    'Blueprint Livehouse',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '120/1 Sukhumvit 26 (Soi Ari) Khlong Tan A Square, 2nd Floor, @Flow House BKK, แขวงคลองตัน เขตคลองเตย กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.7204737,                                                   -- latitude
    100.567219,                                                   -- longitude
    'https://maps.google.com/?cid=13262677132257774961&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJPQ1Fep2f4jARcc3rRpV-Drg',                                -- google_place_id
    NULL,                -- phone
    'https://linktr.ee/blueprintlivehouse',                               -- website
    NULL,                                                     -- instagram_handle
    NULL,                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJPQ1Fep2f4jARcc3rRpV-Drg/photos/Ab43m-uElfvft6FrwrYcq6xZj6tLO-0KkpBXII34ZP0LXutghYhY3OqNcjmnvz5u-s2LYG4Oa3kN-0gYSIV54kcTOOmX8XdwSqaIOeShvfejUFjVuh74wzjNMTdvnIGu00UeaXjlCqodpy6YAK_uZ1VHZVR64ggKorURgGaKnlefErUtRnSKvXu5LvR0e73ZnZl65UGNv39HmFBPRBbz_DgnKNT0ZgDtDpGlpDzU7YJnjW9RicfEUU1L4oK6RFiYxewlFzCtn-xT1ua0vHrL3dBqeZqwhwsWHj0o5gemOfPJdf9-3g/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.88,
    7.07,
    6.62,
    8.85,
    1,
    8.21,
    9,
    7.71,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-speakeasy-rooftop-bar-bangkok-asok',                                          -- slug
    'The Speakeasy Rooftop Bar Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '55, 555 Lang Suan Rd, Khwaeng Lumphini, Pathum Wan, Krung Thep Maha Nakhon 10330, Thailand',                     -- address
    13.740205699999999,                                                   -- latitude
    100.5436412,                                                   -- longitude
    'https://maps.google.com/?cid=1574445971265003876&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ5178Viqf4jARZKFL40SO2RU',                                -- google_place_id
    '02 630 4000',                -- phone
    'https://www.thespeakeasyrooftopbarbangkok.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','premium','popular','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ5178Viqf4jARZKFL40SO2RU/photos/Ab43m-vNizc8UzdH5bkuK1QTqz0NERV0hd2fqtWFE0blXJ_w6Gc_ZoqqBAbHoZGWETp6LYe62VRiYqokHrf3_qwFme9tPXGrMjeLI-3CjIMkH0masD6nkGjUKohsDRLzvVqfAS5Xc_DuapVRe_qUaLdfdgwYj7JQ7w3tts7b4gqpKFfeNNyhDtlVvlox2J6jt1c5VuXcgf6C9KUQ6TQGjPiuuILF7Pp4VFDvAHHv4gPFc218AywmBtNLHbn-jx7HcvlPHBzYuO91zqoEjos1yxJWjyIWx2V0pg2XE88FCJpCMyk9ss3LNrQS2UuaGYRt7NsaqU3ytoydJprmIQc_x2K6Lms5gAU5C_-e7CbgO6kxCTybb-6oOhl7YW2neAYHsGVNUlCn9oDieOwr4cizavdQc2TqswywdcmMs-2pb74WRZGCHO18G4cMT9BzMf46ztt1/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.86,
    7.36,
    7.93,
    6.06,
    1,
    6.68,
    9,
    7.88,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'sugar-ray-youve-just-been-poisoned-asok',                                          -- slug
    'Sugar Ray, You''ve Just Been Poisoned',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2 Soi Sukhumvit 24, Khwaeng Khlong Tan, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7268425,                                                   -- latitude
    100.56753259999999,                                                   -- longitude
    'https://maps.google.com/?cid=10708367330301106660&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJybdzZU-e4jAR5Nn-_lnDm5Q',                                -- google_place_id
    '095 687 1041',                -- phone
    'https://facebook.com/Sugarraybkk/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJybdzZU-e4jAR5Nn-_lnDm5Q/photos/Ab43m-uEEZb2JA9tq5k6G4uIaF7j9OkGwdHQTNaxlmgSbcAkpD4j-3EPsAjA4qWkjVka5HVK8iQ1F3s-VRtFuI9ze2mH8SgKgA3JCIFzxkOopE6GqmSWTZXNg9-PP7zGsOvbAhZVEV_bRlegS7ilthyN2jQ8xjgDucXAl4VkNiesciQ80uOMqw5MRMfX-lfDu00MNQR9RbJpQkHiKOYBc7ZovXxdR3cCDXuQRX-dUtSjsU72PtrikB6aPzu2p6PEJda8K66JR80p9o-Tah-T3QgoYTyhYL_RZuDXkBklGJCEbJTh-g/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.46,
    6.51,
    8.12,
    6.09,
    1,
    8.26,
    9,
    7.57,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'stellas-secret-bar-asok',                                          -- slug
    'STELLA''S SECRET BAR',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2/31 Soi Sukhumvit 41, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.729362400000001,                                                   -- latitude
    100.5727156,                                                   -- longitude
    'https://maps.google.com/?cid=15730114169899628010&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJrd5qnACf4jAR6rU07X6XTNo',                                -- google_place_id
    '063 647 9888',                -- phone
    'https://stellasecretbar.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJrd5qnACf4jAR6rU07X6XTNo/photos/Ab43m-tJ-gaG8XrGyfDcyKMy3ME9UJunu75DxRca5qeq84O7yXY9zehCfAM0XME7uA5aKuFy_8gB-UgAz42DAt3FezqmxRQNhIzGZbWsjN8xhOkSm-hQnmpmAFecSvX0uMBHTLpNB4hb_CCOTUw9yddQrRKoALAUzSWg1232icoZXT3lIg6TYO2VaKDjWmZk-FI6FXGyGFtVWW02a3llGZiN3wj6NqS_ne767JZu9cOKePmPkdjDEpqqdAb1DZxSEFkF7mXVc6szwq9xMDnn2vjNLIDWePXNPiWmq1G0YlVA3xqalA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.64,
    6.96,
    7.89,
    6.12,
    1,
    8.17,
    9,
    7.78,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-look-lounge-asok',                                          -- slug
    'THE LOOK LOUNGE',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '795 797 Sukhumvit Rd, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.728344400000001,                                                   -- latitude
    100.5730215,                                                   -- longitude
    'https://maps.google.com/?cid=8037764179717121112&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJP6yApLKf4jARWORlgO_fi28',                                -- google_place_id
    '02 091 0600',                -- phone
    'https://www.parrishjones.com/lounge/',                               -- website
    NULL,                                                     -- instagram_handle
    '10:00 AM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJP6yApLKf4jARWORlgO_fi28/photos/Ab43m-vd5KfzraLvznRKZWD4xzkAkQJLZaxwdQlEGomdwnB2Ww69qg6VJXhOjsJGfD0qGxiN50FabaodQPB2Om20HVD-WMTsdXZlYy-8sQmPcyow6GpOSfnKeCj9pl5hnbeYu-oFC-2hs5mL3mj6YwA02ge9JnDTDMgOxa3OwReu-3BQgB0Guh1hzWE_q6NSNrQdVGRvjFX_zsoTQSBhhxt18F8GORTitxOzCPAbcDuj5vctCyOy7Wl4ZF1BV8Z5ZERMCmqDQO95UBQcIxjJH-T8Mm48dd82B1G2zAUBb842hp9ZltkrAqy2qbmvLzFPgBI02uSVmp64ezWV4hY8XtMuW90iYjHwburPi2nMSRahlMhZiL-5qA7Lavdd9nh4H0P2CUTZ9FL5ssfFLs4jRNmAnvk3f78_BrcYi9P1XC8iuquyow/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.41,
    7.2,
    8.61,
    6.29,
    1,
    7.82,
    9,
    7.48,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'hidden-square-bistro-rooftop-bar-asok',                                          -- slug
    'Hidden Square - Bistro & Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '44/10 Sukhumvit 21( Asoke Klong-toey, Nua, เขตวัฒนา กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.7425458,                                                   -- latitude
    100.5625725,                                                   -- longitude
    'https://maps.google.com/?cid=8942602839548060031&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ08U2F5uf4jARf2GpEueBGnw',                                -- google_place_id
    '063 043 5484',                -- phone
    'https://www.facebook.com/HiddenSquareBkk?mibextid=LQQJ4d',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ08U2F5uf4jARf2GpEueBGnw/photos/Ab43m-tN-3FMsQUHXhj3_0oxTgtYYNsMvFsdmEZwffWlm1Xr_tOMdNDb5gQg1aX7817O3iUvDO7rXhV9ZcE6fhue3XKm6cPmpRHM1iGcA6iNdWW2rt9gTxyP066oZWFKUzRHbTki_hPgb9502cC6SjVXAt3GpH9qkHHZbrOZeaKCp8oAUxi7XoVCxHGGz_ucSc4msO-sSFi9LijlaAx7qAwe475f6Q0oZkGi4hc0VtT7ReqzCwi5d3zfZRXP5z5yG1Jct4uwUm4Z2QR1WKS0GEHBzho9XegnlnlOyWwZwSjp3jF9wpwe6QCo_njaxVJCUxK6NjVtQlvGxshmrsR82BS9akZj3YXzVMc2Ju05lPTnZhZxa5eZyeBbGZkYxq9vclC_v0s1Lz4gHGg7Pgxpfu6ei6v9XV1Roqv0IG_3iet6ZXVSDD864GGXNvPHMjqTFw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.02,
    7.26,
    8.25,
    5.81,
    1,
    7.82,
    9,
    7.34,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'inblu-bar-terrace-asok',                                          -- slug
    'InBlu Bar & Terrace',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '30 Sukhumvit 21 Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7390223,                                                   -- latitude
    100.56209589999999,                                                   -- longitude
    'https://maps.google.com/?cid=16937338964686405641&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJCVQnYM6f4jARCQCE7gyEDes',                                -- google_place_id
    '02 204 4000',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 2:00 – 10:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJCVQnYM6f4jARCQCE7gyEDes/photos/Ab43m-tYP3hH9lRFTL9xyltm569UnGReZrzj7r4p6TzEDRo47_-wtnCCSEumcJRkOpM2de2dZFCT0XQgX24nNbAdbZ1h1HyzPgRsgecVW1K50VPA5umWe2qGs0BICqYEY4ZIttou2C8OIZLuNyhpAGlN26DfBPhYiKHSfD3JKHJ1ku4yoO28rWntrpFYQPaibogDZwEsE2WxslF7fR3SB3DVkEe7pa1ZiB4bwkvkiakEioAGSfSThDYee1g8AUKuCc6sYMRva18OvDwKqeFbO5CnRFkBk96R1siNf-aWV8kIVseU0_tGRICLbQHc6kqKoTxRKAFwcQX8_BueQpcm4PQ_Q0gTBT2XLTU_kgEA4QUkZ-K1Zjy5t0pSMcAwr9YwiFk-jraO16sDRyyu0k8mcxHSCGtrYtAeclFVajHsNV-hDZ7WALcchcqnN6q9Lr0Vuw9g/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.82,
    7.11,
    7.96,
    6.36,
    1,
    8.08,
    9,
    7.36,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'sweethearts-bar-asok',                                          -- slug
    'Sweethearts Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '7/1 Sukhumvit Rd, Khwaeng Phra Khanong, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7414972,                                                   -- latitude
    100.555776,                                                   -- longitude
    'https://maps.google.com/?cid=11490085628877130446&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ40Et7uae4jARzsoKnAD8dJ8',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 3:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ40Et7uae4jARzsoKnAD8dJ8/photos/Ab43m-tEqYLfdV6PIs1TbvBJFq14tHmZ1MnluQ8cLBPPsR_240aVSg5UXxci-vrGNpL8M9OITOATmA6JOoN4p1TdtakAowofGBjDDejTAPNAKxPJBopuN7udhL0CGTc10koz5QzM3jY_IEe9EAxrMHd6YQUUE87-hGxT3V3RCrLY2kiItwYeQo7QA2BcOTThk9kNdVEk1y9unTtKA-ze5FWdmTr-WsXEUvhON7SWKcSd0Ede-7yDmlviMd2VVHbP9MZRB2hF5ZUg5CjH2khYJ-KXk-fli_iVK10lPubRRmnBHn88wEybFaIGahS0sVRPsxyyWBHMtbozv6-KMXKlrrsC4auD3ijpxWNls9s7yMRPqVPkMsSXNegVxiJ_Q_lC6AAC53rNmqfYI5OtztsguRLbI0TgSklcixnrGCNFLaPV1pWscZpu6ZMRWwjuqpTqEBiq/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.98,
    6.56,
    6.05,
    7.72,
    1,
    7.6,
    9,
    9.41,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-living-room-asok',                                          -- slug
    'The Living Room',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '250 Sukhumvit Rd, Khwaeng Khlong Toei, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.737479599999999,                                                   -- latitude
    100.5591285,                                                   -- longitude
    'https://maps.google.com/?cid=1118289693836761883&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJG1WVC-ug4jARG9seNY32hA8',                                -- google_place_id
    '02 649 8353',                -- phone
    'https://www.marriott.com/en-us/dining/restaurant-bar/bkklc-sheraton-grande-sukhumvit-a-luxury-collection-hotel-bangkok/6072682-the-living-room.mi',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 9:00 AM – 11:30 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJG1WVC-ug4jARG9seNY32hA8/photos/Ab43m-vjxR992cqoaDCTS-CbJzOnWlA_oB45qb_ehs_-3lP4oXi4lSftfZPBDTyxylCjNPVnaI3sSp8yvJTt0U-ecMQwCwTF3JzuX8S5alu47t3afbZ3dMyCj7CAwiJ9wuNNPVoIkgmr4cv4Z3czwjfXb7pWAB_FVoqjlwXae-r071TiRpCH-bLVLjvL6luFlMILU1_pl71YkPFwBMIJ50Q-8ajWuEBVKGfCMPkQFEn4MSJsdTuIfPwGtx7orpmoZx3IRoPGils3TFjcoywuuIGx-moQ3AB2TB-qR2d29l_5DynosQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.57,
    7.13,
    6.1,
    8.31,
    1,
    7.69,
    9,
    9.04,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'changwon-chicken-beer-asok',                                          -- slug
    'Changwon (Chicken & Beer)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '37 Asoke-Dindaeng Rd., Makasan, Ratchathewi, Bangkok 10310, Thailand',                     -- address
    13.7494038,                                                   -- latitude
    100.5633493,                                                   -- longitude
    'https://maps.google.com/?cid=10233660441041697081&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJF-kA4vGe4jAROflBbPNDBY4',                                -- google_place_id
    '083 606 6510',                -- phone
    'https://www.facebook.com/changwonexpress',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 2:00 – 11:30 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJF-kA4vGe4jAROflBbPNDBY4/photos/Ab43m-vRwYSbkt52xeN0_5TClVy_RLYICoLhftBCs1J-bQHu8PLNx-54CbqQC6nqa1GyqHzgpitRD98d9bPoBtxjkWfM3_V5RvPfeIMfSl9CEtWmAmEhq30x5jIxGTXUjyaw0uBrxm0itXOHdlns8qDTEkCe53KE0KH2qBxCrHui9zBt_WN-rkJxvqTRco284h_JjJSorqVOLk5-SasLaJFuZgsgZ7b_O9LPjeN9zBCL_8S8uGI2ntO7S-SEZXye7Ti2o0WMx622Fy0fEAfO0T3DEsiWFFWBQ9Jy00wzQ0Qrf6zOTxsBkqtxB6urbON8s5yZ2W3l2NvpY7Tvl94Fq-QuVruDyZYX3x5stWa63xnibzYNO2UkVyxA81kfSZIjLNZ8os0EtUUzReALgkhFFVDtK-e9evUsuQ4z6kBKTI-XkLail4OwFLXZRmt29OH0453-/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.19,
    8.95,
    6.21,
    5.83,
    1,
    7.7,
    9,
    7.31,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'belga-rooftop-bar-brasserie-asok',                                          -- slug
    'Belga Rooftop Bar & Brasserie',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '189 Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.739263,                                                   -- latitude
    100.5577752,                                                   -- longitude
    'https://maps.google.com/?cid=17694330496049567431&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ6zSro52f4jARx1Zla9bjjvU',                                -- google_place_id
    '02 126 9999',                -- phone
    'https://belgarestaurantbangkok.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ6zSro52f4jARx1Zla9bjjvU/photos/Ab43m-vrOdwnUd03mW2op8ICDefP9vm3L6Gf-eEFwFHH2R6szYlxjvqtD0ct5gZ3JzxeZue_PFqYDyELaFuqrEjvS-isWbT1V35siSDe9FHpeRnXo1D0tpffniqoJZfaCk5c4q9Tnlluqlr4VvW4hPsSa4PoOOcgGB_6brA74K367E-FPXFheh3gOBhafCNkqkHYGfp73fxsg-kCiVqElOtk0MGu86FRkEvTY55mLssI7d_IYlxTPW4wwsu57v_OdGj1M5RcIqt1xxdR-mWmUmmKvVEEbdq42ejcJjhaDrf4566vT1AhqJ5DO1pejH7qBv0oDHyn4o9sRK_XYSo_3HgXEIqEqs788M2Mwpdc7ovgwoHc2i2oMIGNsq_uEMQ5iK7FUBQ84KoKFY5oL7NRZBLuXXlnjeOrSqYSbsOYv9MfFmad-7k6MY6cM7SrssEZKMCD/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7,
    7.78,
    9.11,
    6.32,
    1,
    8.32,
    9,
    8.5,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'rainforest-rooftop-bar-asok',                                          -- slug
    'Rainforest Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Soi Sukhumvit 15, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.742320099999999,                                                   -- latitude
    100.5584143,                                                   -- longitude
    'https://maps.google.com/?cid=6865650624454026352&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJqWC1EBUTAzERcGSF_t2wR18',                                -- google_place_id
    '02 119 3100',                -- phone
    'https://www.movenpickbangkoksukhumvit15.com/restaurants-bars/rainforest-rooftop-bar/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 9:00 AM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJqWC1EBUTAzERcGSF_t2wR18/photos/Ab43m-uFWmnW-G1OB4trbPE82246MyMkm4ZYYaNDbYIedQ6yUdtq-o2xVHo2XXPhAcS55upp6HasXhT_nZAqppMg4n28x33OBmIMGe2DgRcrABDtrQDk5eayMmlMycRXnNBrzxUmHyn9doZNhmJ2z-0quHMnrV4yLhPLuQ2fVJq36XHHDCA_gSKOWVrWXUzzGHSe2HVY68L0wKxj2UOZjQ-cdo0EkRSQrxreuYrxuxzBE9TYMGbdIwIMlgdKg0AzXnnjsSumqqxEQ076d5jXPlBYVDaOCa-Zy06PU7X9V-TYCRTyuw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.82,
    6.87,
    9.11,
    6.1,
    1,
    7.52,
    9,
    8.48,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'above-eleven-rooftop-bar-restaurant-asok',                                          -- slug
    'Above Eleven Rooftop Bar & Restaurant',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Fraser Suites, 38/8 Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7456558,                                                   -- latitude
    100.5567655,                                                   -- longitude
    'https://maps.google.com/?cid=9609542074168818811&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJAVT7t-ie4jARe7wAWZrzW4U',                                -- google_place_id
    '02 038 5111',                -- phone
    'https://aboveeleven.com/bangkok/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','premium','popular','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJAVT7t-ie4jARe7wAWZrzW4U/photos/Ab43m-u4XiNH4a1O7FpA-XR46zcYhFEIUtLoknwXq5Jbutu-3umWejYydaod63fnL4yHk2-PnAeWvvkNAweFUifxGzLdhao8PltBXtVNxjlJMIq5Op1fYux5rtTISE7oxankcYtTElyczJ57G5AT6UnyWN-uB82TBLcqVJYpOeA_HcpvlOLPY20bg9HeZmgnu71jZ8YKKSvo2_dPssjZb5IQyscPVbk4jG1g3dy7fu6WNDiTonPTH44ubfCf2avZGpjjAML-dCJ5Vq3_33kiCCFuSvpo6m53Pa4nWjk9vSsvroynIw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.94,
    7.06,
    9.16,
    6.24,
    4.65,
    7.04,
    9,
    8.24,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'cooling-tower-rooftop-bar-asok',                                          -- slug
    'Cooling Tower, Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '34th floor, Carlton Hotel Bangkok Sukhumvit 491 Sukhumvit Road Klongtoey Nua, 491 ถ. สุขุมวิท แขวงคลองเตยเหนือ เขตวัฒนา กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.734612,                                                   -- latitude
    100.56453470000001,                                                   -- longitude
    'https://maps.google.com/?cid=16098623010267313001&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJnyhvJLef4jARabPpa1XMad8',                                -- google_place_id
    '02 090 7888',                -- phone
    'https://www.carltonhotel.co.th/dining/cooling-tower',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJnyhvJLef4jARabPpa1XMad8/photos/Ab43m-vojtd8xt7hF3dWwwj0fjk5BwT0c8Hj9HY1VSetOyxCY0MgivSB5-T9pU5gkDuiM19dIQadbO9beySyCdxM3TsUqMeT4wo7G9EODeUvsgLL-_W4YN5Igdlym6c1yibc9g4j4OS-91iPKTvU43LGpfo8SM7v8UsCNIr-hzA8Dd6VZKqBUsZNFPfbRUL_Mbg3n5JLBfx79RsVG1MfAPAlqTNezgal6SoOryJZYaspVzjdW_5Vd-8ysP-KRMM0DNTUOhP9nRKxetPt3l5DvO-i4xV9BfoePSV4kV4U01vUL71JnA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.06,
    6.76,
    9.1,
    6.27,
    1,
    7.87,
    9,
    8.36,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'dont-open-the-fridge-asok',                                          -- slug
    'Don''t Open The Fridge',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '26/3 Soi Sukhumvit 11, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7447444,                                                   -- latitude
    100.55691189999999,                                                   -- longitude
    'https://maps.google.com/?cid=16346240406850628256&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJxzg-EcGf4jARoOp3PwuD2eI',                                -- google_place_id
    '02 821 5262',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJxzg-EcGf4jARoOp3PwuD2eI/photos/Ab43m-v2nzP25XqqAH9H0jt27b_gyPdCjJhos_XMfmQN_oJt_S6UFBkYrWIdP3t3BrrxeXs-mRDSWqyfIJIIccs9sKSIo_6W-FJSv0-6ymapl4jTS6kPzLMwiNyh2ExSfxd_QWM3dTCEzcxutx8Ch1p3rom0hADO359Y6qzsl8O3WSk0LoSrV00AWMjCiQ0qW1Erd_Kmk5_g4VWUat3cuJ_cWJ4ktrLddQWmYcsPLdZWkLXVbw8qir5W3tg20AJNJpZprj7kMbS53do3nRMlmGs1n7IE1dis0DOMqGPGKmpngbFa6g/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.09,
    6.67,
    8.49,
    6.12,
    1,
    7.57,
    9,
    7.66,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'whisgars-sukhumvit-23-asok',                                          -- slug
    'WHISGARS (Sukhumvit 23)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '16 Soi Sukhumvit 23, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.738200700000002,                                                   -- latitude
    100.56320339999999,                                                   -- longitude
    'https://maps.google.com/?cid=358296330386510719&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ_RCzsvye4jARf5MDOZ3s-AQ',                                -- google_place_id
    '02 664 4252',                -- phone
    'http://whisgars23.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 3:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['cocktails','premium','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ_RCzsvye4jARf5MDOZ3s-AQ/photos/Ab43m-uiP4ySMtso5E2WSQwqLddp3TkqExYV1uc8LuLvHzCvLdfKbHCJZro_0J5-3KeDEdkFeAaIZeoijyJQsByaJqBph2vyOWTzLjswiONUrU4RluciCdt2vV7GMPwoMgFtJHbQeeNmuo-JtpZojsCNHVP0rQuzbWk4MUNJWUsR4OwFRF_datXOJnzZmO403FzBdlZUinSDd5426xf2UlUtynMjOpycHCw32DPFoQYjMSVXs_WOsROA3DAZ5jFGRCWIZX__tOUincuK2aWwjzVealBRO2R62QJ0z24es2RBr4XuaQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.29,
    6.99,
    7.75,
    8.3,
    1,
    7.01,
    9,
    9.41,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'pastel-rooftop-bar-mediterranean-dining-asok',                                          -- slug
    'Pastel Rooftop Bar & Mediterranean Dining',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '22nd floor, Aira Hotel, 14 Soi Sukhumvit 11, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7425924,                                                   -- latitude
    100.55662660000002,                                                   -- longitude
    'https://maps.google.com/?cid=3529346565977538357&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJbY9lxyKf4jARNf9VogDC-jA',                                -- google_place_id
    '095 703 5679',                -- phone
    'https://www.pastelbangkok.com/?utm_source=google-business-profile&utm_medium=organic',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','popular','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJbY9lxyKf4jARNf9VogDC-jA/photos/Ab43m-sp8Ay4gY1xwvX95ioJ3phAsmzh1N__Ho8OCA8OD056UTOUqkRS_aM2faolsleCbNyhqKpqIgEEaB2-Ha9urRlZjxeZhW2g6Oa6DnQxEt70n7mM-I25slj9BSPvhSvigPWmBp9q5pBq8Nzx8e0e9KvWG9n28dJZNXg2OgUbKT9X6Ag0El1uE5HT8czaWm3oua4-lT-wTL_SxWf4XF4lXnUNS5sS_eeSgIEQkcE6a3CsD11Gu72fzXRtyGZ7HxtwasSkUeOANuHk0mT80O4KAuBgzXgtW8IfDZ2iaCIXnK8wxA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.29,
    7.15,
    9.3,
    5.84,
    1,
    7.96,
    9,
    8.29,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-golden-giraffe-asok',                                          -- slug
    'The Golden Giraffe',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '33, 27 Soi Sukhumvit 11, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7449724,                                                   -- latitude
    100.55628420000001,                                                   -- longitude
    'https://maps.google.com/?cid=1641391838599441281&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ4zWrWNSf4jARgevxRC5lxxY',                                -- google_place_id
    NULL,                -- phone
    'https://www.facebook.com/thegoldengiraffe',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 2:00 PM – 2:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ4zWrWNSf4jARgevxRC5lxxY/photos/Ab43m-sWfJkDx7KFPDgAunGAxic8hWEdmc-HuG3MgjVFujekkBY6TFY3zzbjGKTXxWtCCZ9A8Y3ISC6Wer6X5GWrYMklTPbT9Ba2CcpaSiT7VJURfxJoR5Za11ju7fpH29bx5IoT6lIwhhf5hQpXlDpfJLbxXafGjgYX9UMLBEq2VHMUEfkPKd2JKJJzwwLOdoUciOYIeEU6HbG7BzF4A1oA_6KkH2b4J8MNs-8RKITr9UJVGtZGdK3N826yWQ4mu1jTgVtvFickKEdlDEdYtRb3voCIpTJakXpxGvrsLIr3sXnJ_A/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.85,
    7.06,
    5.97,
    8.25,
    1,
    7.74,
    9,
    7.65,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'oftr-bar-asok',                                          -- slug
    'OFTR Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '245, 11 Sukhumvit 31, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.737993099999999,                                                   -- latitude
    100.56661969999999,                                                   -- longitude
    'https://maps.google.com/?cid=18052439236120263722&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJxyBV3JCf4jARKrxF3tYlh_o',                                -- google_place_id
    '02 004 2429',                -- phone
    'https://oftrthailand.wixsite.com/oftr',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJxyBV3JCf4jARKrxF3tYlh_o/photos/Ab43m-s4KZnyPCpLyAN56Rk1j7lBTnhc33z77p048cf8aGHDG_wv9gkM0OtAntJMznx-_7WHcQ77ncKw8U_3_u8H1XEYh9zGqIoM0mq2dzI7U-_uklrX0wQzoDYhF3oubMddFMK7Ngf9iUm_7ziQPoguQSd-KVnWLxlO5ydBuOsa8sdbDrHZxcgk2m9ugadSa-uVLa9cZiJNPF5wzbdZ4l3Y9lc5921Q2IKA3HeCptePUDXVrQsp095RVY8IVHPOtAKfF4JWbI3feEjQF4ybtvSRzwgYg_sJX6fM0qxWX_MtC2MSTw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.53,
    7.29,
    5.81,
    8.43,
    1,
    8.21,
    9,
    7.45,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'sugar-lounge-asok',                                          -- slug
    'Sugar Lounge',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Sugar Club Complex, 37 Soi Sukhumvit 11, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7430819,                                                   -- latitude
    100.5564814,                                                   -- longitude
    'https://maps.google.com/?cid=8857454252474963211&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJt7oOxPif4jARCxULvbb_63o',                                -- google_place_id
    '092 642 7895',                -- phone
    'https://sugar-lounge.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJt7oOxPif4jARCxULvbb_63o/photos/Ab43m-v5_e3mqGIc7p7U62TNLueIWhdEdeoErrBiN-fubQ3KlCFt142SeF1nUC_jxpPb7aEK9QpwyBTv6WG6Xn2CHTgubZgKGXkNaCBydv5ML5aexoTjLX1apHsBppeXzztCa5G7OwFifCbJhfRD1EXpzwjmG54WAM_Nk380ue_GviD8Zg7hTeNCiq9-mWXFgte-JzCam0F_AfgN9dplFc83rloiXRKkf8bkF3YoxV3-qkn2lCoimJ8ymhRpk7STfErdiNqEkG1x58DkWtKamj2SEwPEhelxOL54_PKes_w_TCbo0w/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.38,
    7.05,
    6.36,
    7.79,
    1,
    8.29,
    9,
    9,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bafros-asok',                                          -- slug
    'Bafros',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '37 Soi Sukhumvit 11, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7430492,                                                   -- latitude
    100.5565062,                                                   -- longitude
    'https://maps.google.com/?cid=9324129056865119418&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJD7Cf-waf4jARuuxX0vn1ZYE',                                -- google_place_id
    '063 039 8700',                -- phone
    'https://bafros.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 10:00 PM – 4:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJD7Cf-waf4jARuuxX0vn1ZYE/photos/Ab43m-syKZaqHpczGE_cPelEeZnUmiRVP3znlv8Rsx5dEt2YEp20-1kIeVwcOT6oQr1GlYWdMz75WHOEfK3mz2rJksRgyBJbD_tJ7eYcLCcOBSYHboqO1uvyuEk8tib83BgekRo9XF-4URNTwbKJb0utSvJLIm4BLWRHP5cN_qAg0mQc5UFYG1Mw65Jtd_dgScV306n7lWoVHEEGHIqAccql-9y_xGzm_NBppaV1h46pDkdyhtOCGbr_q1gYVHoia8m0AsmD_nGq3PKP-JUbePAu5hLJXRsJNYvR3zr2OUje-3H9bA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.19,
    6.97,
    6.49,
    8.41,
    1,
    7.63,
    9,
    9.11,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'havana-social-asok',                                          -- slug
    'Havana Social',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '41, 3 Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7455856,                                                   -- latitude
    100.5558721,                                                   -- longitude
    'https://maps.google.com/?cid=9662200656097148450&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJPzDk6BGf4jARIn43300IF4Y',                                -- google_place_id
    '02 821 6111',                -- phone
    'https://havanasocialbkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','premium','popular','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJPzDk6BGf4jARIn43300IF4Y/photos/Ab43m-ujQBPecdnSPWHdYhCQXzZpeIMkudUtOgjQqRGQXS6Q6FW2pdoJLa-L3k1IVEH1QlWeCXI4rS3uAZWNp8mNN8DXQs1RdRaoUW03AHbaNdgkAbvovdLM-cdmp9EEXoGHAi2HcKiPrmsTVr97DkhOcP6AJJ-DTiB3_gjOx6KsjrnkgU6XAVt1rjFBhYqfLB6PeM5TzrGiUxLnwKJ9xeOMx_f5CVurOxvs0Tkgjezd2JrU6KE9rDKb4pKgVhv159ViqRcg-19b89JZzo5TZDLe-U3HUkRVqnv_oOKeLAega4pUbg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.99,
    7.05,
    6.05,
    7.89,
    1,
    6.94,
    9,
    9.17,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'shakariki-432-asoke-asok',                                          -- slug
    'Shakariki 432 ASOKE',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'อาคารพี เอส ทาวเวอร์ 36/1-2 Sukhumvit 21 Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7412557,                                                   -- latitude
    100.5621977,                                                   -- longitude
    'https://maps.google.com/?cid=14359792337757168652&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJYTMe3OSe4jARDGRkvAw7SMc',                                -- google_place_id
    '02 664 0927',                -- phone
    'https://aroimaru.com/restaurants/shakariki432-asoke/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 10:00 AM – 4:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJYTMe3OSe4jARDGRkvAw7SMc/photos/Ab43m-s17Ox9b2SfEeV-eNhOs1PPeN7911mcYarQUbdrrf77CSYDkISA7X4gz6EcBV0wMwoM52jD1LRFMBxjCYaBZ59x65hWhTzJ1FUwmFB7kV668EmUiFxUZQR0TBd1p3CPCr6e4ac2tGOJJ6rc944vNJQythljbEEza6oeBm3WYhPUKAFOjmk84FqwQvz5awcDuflGRD0Ty0aeccn_F3oXdMPa4zVin7UJLZ4KG83cVZLVsmxiTEPqvZ1XaXXIclb863wvIjJgrcagU95vyyzIPetXKW_rMAEeEcPG_BMXvtmAPg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.02,
    7.5,
    6.49,
    7.9,
    1,
    8.36,
    9,
    9.18,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'redsquare-rooftop-bar-asok',                                          -- slug
    'RedSquare Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '25th floor of Novotel Bangkok, 27 ซ. สุขุมวิท 4 แขวงคลองเตย Klongtoey, กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.7392776,                                                   -- latitude
    100.5532563,                                                   -- longitude
    'https://maps.google.com/?cid=6982685257395845934&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJdeGRKy2f4jARLrtv6T5752A',                                -- google_place_id
    '02 080 5388',                -- phone
    'http://www.facebook.com/RedSquareRooftopBar/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJdeGRKy2f4jARLrtv6T5752A/photos/Ab43m-stXFHbfoSzKEFvfYCT2b3LcJpB_GYAG7qAkRflsWzCmcKfGV5t-gtVkfxBIlOBLhzhCs5KCQbwq0pZSnSCR6kPr3TB5R3U4YoFPVkK5Qggm46tTQuoNFv9_8uLhHAlo1podaLxPNwLdN5RTa3JrwHVsmz_QCl7i96hKktaMNxPtkkJWFCWo4gz9k5ROnRqsLgLqLpMTabahRzwey7T8QCGdBf9nJKabOAWP98GY3WsBOtyKzQiKZP1BG4MyFy_TvuDvTGXhGhM-n73B-hovwC2QkN47Nc1wQeNvi7QZlt9Bw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.8,
    7.09,
    9.02,
    5.72,
    1,
    8.29,
    9,
    8.19,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'sky-on-20-asok',                                          -- slug
    'Sky on 20',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '26th floor, Novotel Bangkok, 19/9 Soi Sukhumvit 20, Khwaeng Khlong Toei, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.731514299999999,                                                   -- latitude
    100.5642055,                                                   -- longitude
    'https://maps.google.com/?cid=12077571983238980459&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJQ5P0xgKf4jARa2MroronnKc',                                -- google_place_id
    '02 009 4999',                -- phone
    'https://skyon20rooftopbar.com/?trackingCode=GMB',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJQ5P0xgKf4jARa2MroronnKc/photos/Ab43m-un8aUzYiVhryzu39MLO6n4U3pLXui2YKjDwjRbLGwWbNQglR2wHHBBPJ2GLZ7i2IRIkmG6gcfo9L2DOLPSuuuWwXVIRA8g6-EIWGVThdyXa3a6hJAJhB3XGGbm6KqDlIZee6YbAbmTHNWubuIH81AUDafz3-yQC-UQYQi65Tx6zL-oy4Fi92lhgNVM5xNLsWZ3ahkQ16bdgqrWm2J-uP0P0nXUm4OlQVYaHh3vV-e85-ghoPhgxbM4nss9T6Z81ggL_ZT8phCCU8P6JIpV1nWY0g6eDqF2TWb3Qjz2Ygghk8WalmkqI6dfCHwG0oQGCi57PrZU5KlOC_BYWn7A1SMSgjqA_Dd8uUARLBaCtDlUfafS5UH054RM1AvXHdbG5m6k1bMDRF_MPvDv30LWqaxNXoWyITQaYtRug2Txtv1EsXT_/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.02,
    6.95,
    9.47,
    7.94,
    1,
    8.47,
    9,
    9.01,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'brewski-rooftop-beer-bar-at-radisson-blu-plaza-bangkok-asok',                                          -- slug
    'Brewski Rooftop Beer Bar at Radisson Blu Plaza Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Radisson Blu Plaza Bangkok 489 Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.735310799999999,                                                   -- latitude
    100.5640981,                                                   -- longitude
    'https://maps.google.com/?cid=14458126994207837993&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJZ5sHSP2e4jARKY8-F-aVpcg',                                -- google_place_id
    '02 302 3333',                -- phone
    'https://www.radissonhotels.com/en-us/hotels/radisson-blu-bangkok/restaurant-bar/brewski#',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJZ5sHSP2e4jARKY8-F-aVpcg/photos/Ab43m-uG1gBgsfCHUKFdYoOWXB5OciRZ_NdkmRjVuVpfIlBiCeReLYyf5KaAeW1SaLBMwmU_dLubbFD7FqoRCRkO7Ts6G5vJ6os_g3dZcTFmWP_kBgVQCisINR2R5NHJCHgh2Kz6E5wjkEu_7I-HuviYQAhSzQJXWqoLgDZKfrVMaZ77FyKTkmrV392_OiQGGyvZXMWxnJcb_xWGfNXbIcYP-YE375-zot5xX_irA8cl9ZgtrWCa3hcydPS6x3ejyhf29lPVVK_UuAifj0SWSMyZzWZaBBUakmHmwIUlWiKI44znHw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.78,
    7.49,
    8.27,
    5.98,
    1,
    8.04,
    9,
    7.84,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'abundance-modern-fusion-club-bangkok-asok',                                          -- slug
    'ABUNdance Modern Fusion Club Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '29/1 The prime 11 Soi Sukhumvit 11, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7438519,                                                   -- latitude
    100.55658059999999,                                                   -- longitude
    'https://maps.google.com/?cid=7293005878123001516&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ-wJzjTSf4jARrHZbxjT2NWU',                                -- google_place_id
    '081 526 6447',                -- phone
    'http://www.facebook.com/ABUNdance.modernfusions',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ-wJzjTSf4jARrHZbxjT2NWU/photos/Ab43m-shRJEG8ZwPqRYbr1kviNSUNd6Fom67ylM7au162tA2vCsJpoJ34d_H2PiJ9eG49E_P-ZG3ThHeOXWxePILA2G_Pb277CjH281lkpk2IVpe-rL0hDdtAckM2JS6eGQIIA9SXliu7LgNJdROXzdGL90EbjawBrMpTWnkpaC3dBtxheq28YPDK8fpS9J8owIQ4i8PS2ywLsrVfjCTm8F-sJ7UD77wjXixKBDWUvcKQ4Ph133V67xX6XSBWLOhi9Cm3Ld399ILwERi0o-KjYrxRHWBCRikwAF4FHwXvUhTDs2HZxUGhlHiovhpdraCco6hfjiJTryG1AgTd56hbqwMGPNdQ0QA4ifzzzgg5VZRFSwxJL2OOawpBafRnkMhORmgv9JjLQV_B8NQ1SHzgiZALA9s8EUO08wov_oD5f3Pfyf-yEk/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.06,
    6.52,
    6.36,
    7.94,
    1,
    8.23,
    9,
    8.98,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'scruffy-murphys-irish-pub-asok',                                          -- slug
    'Scruffy Murphy''s Irish Pub',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '10/1 Soi Sukhumvit 23, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.737290199999999,                                                   -- latitude
    100.5630127,                                                   -- longitude
    'https://maps.google.com/?cid=11838700163368312122&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJaaKONuOe4jAROl3tDxODS6Q',                                -- google_place_id
    '02 661 7417',                -- phone
    'http://scruffymurphysbangkok.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:30 AM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJaaKONuOe4jAROl3tDxODS6Q/photos/Ab43m-vQrwDGJlNhL4r9QRN1m5WTa2NVppnYh7dza074yu_B0bpDfI319engk0W6U-am_ijfhTupmW0SnjKulWoR5rjz4ecU_w4TOIpOdfuIkxakjQKLJqNqXQv385kz6cUJwauhI55T6mAOsrCKV7sB7ZFTBKTnoxGRuDY6JtEScPoiCSN0hLbEFHL-WlHaK6R81b2kWyJI6asDat48laAdGJTaFg5sIUxaiwy_0miCiFzWOPdT_nbck0Dmij5R84K-XUDYPOylE1m-OUtwbzpSp307bn9HnhRcZZwEEUiVDqLezA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.34,
    9.44,
    5.96,
    5.65,
    1,
    7.54,
    9,
    7.35,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-clubhouse-asok',                                          -- slug
    'The Clubhouse',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '21/1-3 Soi Sukhumvit 23, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.738394099999999,                                                   -- latitude
    100.5629079,                                                   -- longitude
    'https://maps.google.com/?cid=14061617127761438314&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJyTNTUOOe4jARaubEq0bmJMM',                                -- google_place_id
    '02 664 1376',                -- phone
    'https://www.facebook.com/clubhousebkk',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 9:30 AM – 12:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJyTNTUOOe4jARaubEq0bmJMM/photos/Ab43m-tMJywXJtCU7XyXjdLn5TNl8YAKsSQueQd4JxHLJCCXyW0nPYijPs1co2SYn-sOX6zGFOPA036ScGxQfeFVe3YnxVT4q9UD__yL9AZawu6MR2juJC6urwIzFUAo1UyJ1-WzEIKB1SmhVjvQMmwbfiskAhk7QfRLSXlWIndgQAPYB0deu-tYPekfs_1-EjDgUg51G7prHIMD1jwia5-6yEmWKOD2Uqqs9VWp_0gbzv23mkNyJYgPle5yCK1Ikp22xxu1LFj96hdsekflU8CTheQWuH5rqWDyu5in6nWYNsSRmg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.2,
    9.1,
    6.39,
    5.98,
    1,
    7.98,
    9,
    7.57,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'zest-bar-terrace-asok',                                          -- slug
    'Zest Bar & Terrace',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '259 Soi Sukhumvit 19, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7380397,                                                   -- latitude
    100.55961649999999,                                                   -- longitude
    'https://maps.google.com/?cid=15900957898363170878&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJM3dRoeOe4jARPvBgMPaMq9w',                                -- google_place_id
    '02 207 8139',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 AM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJM3dRoeOe4jARPvBgMPaMq9w/photos/Ab43m-tMlrQkGoAhtNcMq-BKd9SaJaZjq2UqJiZNtvZ2Ka971R9Rue8Scr7ELpS9PfmdCcLAuLIfH4lgeMmPmTEprt1yol3B42y300AlxQfcwOWu2SMTdQ-XWHLCfpwUcpsaP3V_oZR4V9aRJziRHXaMMFd-u3wdG7VDV2fJXJ_4nCoX9twM5FHW9IRqNwu_jdbFeqMl3VQZinPcyiJjfvg-WKnckXhe3tGFYI3il5sF4-T7u2m3-Iat3ihayWx_gdWBMm9jiT2-_A5VpFEJ_CHeHjkLnAGQLLeEffRtt493CCvWyw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.43,
    7.03,
    9.37,
    6.26,
    1,
    7.51,
    9,
    8.14,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'vanilla-sky-rooftop-bar-asok',                                          -- slug
    'Vanilla Sky Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '35th Floor SKYVIEW Hotel Bangkok 12 Soi Sukhumvit 24, Khwaeng Khlong Tan, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.729228899999999,                                                   -- latitude
    100.56908879999999,                                                   -- longitude
    'https://maps.google.com/?cid=7085842370748677481&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ3wk3YgGf4jARaf3iAhj4VWI',                                -- google_place_id
    '02 011 1156',                -- phone
    'https://skyviewhotel.com/bangkok/dining/vanilla-sky-rooftop-bar/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 1:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ3wk3YgGf4jARaf3iAhj4VWI/photos/Ab43m-vL1aQcZIT0tTEJ0YFbuWzUb37nMte8PVa9kr3SfDouNkPA-J26-3AZjSGyWHYJ8deEwkt9TkM6PyY6PVYs3JBI8hztJ9auLSluilaZyjmoAB9rOmBl8odiUiAxKxmdfTkr9fSI6vigTLBTXO6UItRgY30hAkRU-6BzDasJZRQALkZ5dbuGC3LqQjTiXqDX4wDGsG_ho55Cv0_pFDzBEc3d6Jh4rnrGNJyEOvWZroya01GLWy32Y5mEOEt0SWRzGfgwbuPEt_x-ZwJuF3u5fEfAdTfa2pmdnwx58yhoKpx2CR5bciGIDSytpWVADUcj66-la1SwOeRiyC6ONN37YhBBSmxgxLPUvK59qXLXB9Cr5LT0ruLkORpmk9oKMPtlvBThU9MbXsVJ1l9Et2sPU656SxHYZTcSaCs9jhPDmYvLOA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.78,
    6.99,
    8.97,
    6.17,
    1,
    7.52,
    9,
    7.84,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'live-lounge-bangkok-asok',                                          -- slug
    'Live Lounge Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '10/47 Trendy building, ซ. สุขุมวิท 13 North Klongton sub-district, เขตวัฒนา กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.7411807,                                                   -- latitude
    100.55779779999999,                                                   -- longitude
    'https://maps.google.com/?cid=8903884774677871360&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJpbOSn-ae4jARAPuuGwf0kHs',                                -- google_place_id
    '02 168 7335',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJpbOSn-ae4jARAPuuGwf0kHs/photos/Ab43m-vvcmVLm5qDvEoRvOelXqbG25XoN8XKJ5FyBzMktUVSzqbgdNy4eLgZIgSaEf34CdMowZAWh0ZRZ-CSSH0CGvPZKXU-IZqwCFTPY0IxIPG51NrwBdAIQ3PCUDldet5sWHvdG69N_t-toC31_nhTsWnJHTTf6jPNKK8wJy5rDwlPU6kOgz6-x0j9muk_vpMfoSH1bYA8JavjXA-HxnCgIgNWAQpzfn_Hnl5SLrb07a1BBtCX0EGN8wRCYetK7HfxB9iGpyl3dNNr0NTYR6BZbEQo3ftK0EHH16174_AtVyE/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.68,
    6.78,
    5.95,
    8.5,
    1,
    8.22,
    9,
    7.32,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'leks-last-stand-asok',                                          -- slug
    'Lek''s Last Stand',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2 Soi Sukhumvit 11, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7401249,                                                   -- latitude
    100.5563104,                                                   -- longitude
    'https://maps.google.com/?cid=14839610322895458129&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ-780h-Wf4jARUU9nDffi8M0',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 8:00 AM – 2:00 AM',                                           -- opening_hours
    '฿',                                            -- price_range
    ARRAY['local-crowd','cheap','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ-780h-Wf4jARUU9nDffi8M0/photos/Ab43m-ucrWAG5UNDWiXQf4bKQDq74rhXEZviiVSLe_hDrgtcTEn6wLojhjrklF29G9zBr5P7NDpm8ulSVbJj15zo3yPEU6tbwV0b_w6t9R9gs5sqJvUO2iEv3hYDodCYIJJr-gGmhYLu80brDrkGv-Ugq3TAuCEscemgAfbRIh90T-7P123rzXTfZfdmBZDM5Jd4kiFYz8RV0xlUioiUQflmGANP-RrjT0U5Jn1zWf8I49vAx2u6uYBpVWpK7vWArzs419mki5QxHxf4ohI-M1O4YlTPYgwYBo8YrqYQ1C6AUj0ru3OgUgcKD6_rmgpiIe3rqWUvGbwMmevHqaU9JGW6j55nMX_As-td7KNTSn8tqTnq-MtdkZ4mmY9N2oE8HtsJ4nHzsHN5F6QrSv4z9RKTS9WrwQyML8dBXCrPQeTH67F_9v2tEPH7NTktmMvneg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.04,
    9.22,
    6.37,
    5.71,
    1,
    9.06,
    9,
    7.11,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'hot-lips-soi-cowboy-asok',                                          -- slug
    'Hot Lips Soi Cowboy',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Soi Cowboy, Khlong Toei, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7367828,                                                   -- latitude
    100.5624382,                                                   -- longitude
    'https://maps.google.com/?cid=13702885726480050954&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJGbA_g9-D4jARCiudnPdtKr4',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJGbA_g9-D4jARCiudnPdtKr4/photos/Ab43m-t52WYUrLuqGrnKZT2b7ap4-jIk3_QsQnrGi0udZhj9sbxDSxNZXNttcYGTw6aX4ni5f5SkO9DGF9kRakKmjaZyflf2ci211ywPFIZRqbvO2qc1-kDvWRW12Ifhuk6mcTNoChBH-B9EZnBfaM-ACdzethWvKqLtYazjDkrys8cCQjigc3WJ62i825lpsfaZPCg1KqzoaFUrp7XKcVakRP73pA21MQQRIhLuIWpi1cIcZNAPqXtX_PtOUJWJCwSeRr2gwjbgGcjg4I_B4gDE1Ga4YbxTrCNr5uKLftEg6G1rN0jDVQDb1ESIObpD2HecUawbOm-_34xrqY6n6-LuySLh-QSxs5R7HNHPmbjhxtzBK1YSgzPTi8ag6-BX1yt6ztW-i9LxappyMrF4j2ZgYMsw4145AuEK3jf5lNpDB3l9bN32gbku0Z85LB400vxT/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.63,
    9.24,
    6.15,
    6.07,
    1,
    7.76,
    9,
    7.73,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'country-road-bar-asok',                                          -- slug
    'Country Road (Bar)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '51 4/51 Soi Cowboy, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7371599,                                                   -- latitude
    100.56162259999999,                                                   -- longitude
    'https://maps.google.com/?cid=15431902861639740311&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJtTvUEOOe4jARl-teFOQhKdY',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 1:00 – 11:30 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJtTvUEOOe4jARl-teFOQhKdY/photos/Ab43m-sOHb48nL_eY8uu-I5PZxhK-Jc24m2CY7GeIKRzNCf71P2ko7VBvo5tNKmoFUkAcjKjsmNAN3QmM4BrJa81a2mcYaDBN6JlVd80KLqTuz2yH1jNn4CUYG3psmAxcUr71WkGBkynzjTpCvp9brVh68is1u578qez_gyXAoHKl66afzh2XYjt3erULith8RmNSalh_mTOEjGDm1rkNoT8fhmjTN2HH33w9ZdgaAvaysdD07bEyHB31hgMOP0d1xoqf-l7ZwgCwxjJirRCbexE_keAVoSTn1wlOrwni3ZfqFgQJI_V9sFpf78LCD5wzwbT8nnWij-0KZ4KMJSpHHzWh7rHfpMEJ6J2KRgTtLEnwhYUPIsuxRagwF_-rBRK5xAun8YCui7vEklEkxxvQuA3P2h7LF9RKqrxf7NUi6zP5PyOhVab/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.33,
    6.5,
    5.99,
    8.41,
    1,
    7.71,
    9,
    7.76,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'breakers-live-bangkok-asok',                                          -- slug
    'Breakers Live Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '10, Trendy Building, 10 Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7405817,                                                   -- latitude
    100.5576554,                                                   -- longitude
    'https://maps.google.com/?cid=4601554407386352028&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJoW18IV-f4jARnInleloB3D8',                                -- google_place_id
    '02 000 5120',                -- phone
    'https://www.facebook.com/BRLIVEBKK',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 12:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJoW18IV-f4jARnInleloB3D8/photos/Ab43m-ttnhh2J04d-VFh3BuQBadFfbB3eI8n80Vw1Mp67KFBGmp4H07HEMOXOd6nJzTZUA3njwWiAeqAH-mhigWAFo7Fqetg5VXFGD10ZaP8Vo4LlDpQCQDjbCaKgvAJKnRkFagyLVV0yl3EL0pLiSOapfsa--wqqX9AO41CK9DFCTxQtwAbOq5n-AYNW4fifytSrfTP0Eumina1kbcJU-pHHd-dLCmrTJvvM8lnUyHtYS6H9cAzo8l_0YmB7h-2XcAEjMefD-QV0WKZdCyeYphsEGZbzdmrvI-Pj1fbfuAUNj-OcA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.36,
    6.54,
    6.18,
    8.55,
    1,
    7.54,
    9,
    7.71,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'alonetogether-bar-bangkok-asok',                                          -- slug
    'Alonetogether Bar Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '29 Sukhumvit 31, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.737661099999999,                                                   -- latitude
    100.56673269999999,                                                   -- longitude
    'https://maps.google.com/?cid=4845210776185907905&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJT5TghLif4jARwap0qIelPUM',                                -- google_place_id
    '082 569 8583',                -- phone
    'https://instagram.com/alonetogetherbangkok',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['cocktails','premium','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJT5TghLif4jARwap0qIelPUM/photos/Ab43m-tKMnpDmssvOGbyhd__TvPpaMgIeKM_v49lcKQt9s4nr44k1-I-8m5yIsAiAABVGuVUi4abF7kPElpgqzil4CLMKzyF3Xg1iEX1Nj_G6NNxmVnzk5DamJCj4EuCMVFizF2egexOw_rM26ysC5uA2WJzSSpZBi-f2cpKZPWATPsf2SxmEjuJP8Uw_nixzk6GB-qIHAPjYCRmYvaKJhePzkpv-g9wsRLbq5uaodQPn0-D7ncBjHYYkkuH64uB1sgI62-yRd1CxWjLiezH8AcGa-s-LjAoLCOFle2fpT9AkfJp-w/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.57,
    6.58,
    8.08,
    6.24,
    1,
    7.47,
    9,
    7.14,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'olearys-irish-pub-bangkok-asok',                                          -- slug
    'O''Leary''s Irish Pub Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '4 Sukhumvit 15, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.739560599999999,                                                   -- latitude
    100.55844809999999,                                                   -- longitude
    'https://maps.google.com/?cid=5877904057945853360&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ72YlBuSe4jARsI2wJZmCklE',                                -- google_place_id
    '082 279 6785',                -- phone
    'https://lp-hospitality.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 9:00 AM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ72YlBuSe4jARsI2wJZmCklE/photos/Ab43m-uybiB1QLgODbOoSIZSGWQjEDaCPBaO8IrdTxJIXnMni6axzRuwfD5Mg1AYNZGgM1NR1JLZRkBK3H1c_uamNf-6P7XoHAPNTt5wLEPvpjy37qA0AKT8hMS_Ck4YjEHbwudvZasXObfuFgxuemmA5kiap0oyubynRE-H7cDk3vbSNiYWfwlz8Bdr4HvAdwqSyAcMe4Pyw1nRhIktgNqTmwuNFisGpSb9ggl2cS4dgB8uC9devc-DWARbBpn_HgyOAfIjS8vuukJwuTd_zKuqGvAOWbrIAGSBc20odHenqRUFxg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.18,
    9.02,
    5.75,
    5.88,
    1,
    7.62,
    9,
    7.73,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'oasis-rooftop-bar-asok',                                          -- slug
    'Oasis Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Sukhumvit 15, Khwaeng Khlong Toei Nuea, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.739393699999999,                                                   -- latitude
    100.5587465,                                                   -- longitude
    'https://maps.google.com/?cid=11251451274048885733&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJaRh1COSe4jAR5dNMLVIvJZw',                                -- google_place_id
    '02 309 3288',                -- phone
    'https://www.paradoxhotels.com/bangkok',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 12:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJaRh1COSe4jAR5dNMLVIvJZw/photos/Ab43m-sIIBl_gPQpOKqSOLspS3rutizzUVkrkbJa_0BlreQ27sAqDaiFiOhKH7ksBekN_rHOVLnk9WSLDHCcHXhaGiHYCSgXBpvl4KkzEhnBP7nw21BaGrhCGmuKzVxqy6UWvkNE4R2KvBBHnyIPKst9-8A_hZSNChP0d2zNoVzPaBAewU8wWPhHDJrhehTE3cTGrkEHRDLOM_EGR2oAN4qSgLUFjHlYXyzZTi5uKzK_S9OR1NzuVykg8wCUuzcr4wyS25gY-mzRxJGcZgKmJ7hXVnPYoc4QDMXfl7qft3K-NIUvqNKhtGPpgf8G76QxN9CUZ7Xbh1G5-Xc29e7dGAk4ptGWgrRFYQHXV012cIJJkrVGjzt-MJyhnOm4ZFAnhO3VH4Qv4Uf1MiFdTVA8E9zC-HahhzdDFRihCTeX2H39hAM/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.98,
    7.28,
    9.34,
    5.74,
    1,
    7.71,
    9,
    7.97,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'modern-teen-bar-asok',                                          -- slug
    'modern teen bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '5 Soi Sukhumvit 11, คลองเตย Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.740666,                                                   -- latitude
    100.5560809,                                                   -- longitude
    'https://maps.google.com/?cid=8516708252122308929&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ5TYwW86f4jARQWFjJwhtMXY',                                -- google_place_id
    '095 990 2393',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 2:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ5TYwW86f4jARQWFjJwhtMXY/photos/Ab43m-sCn1BC61YEfaoilWtvnM5CI93hZaewGdh3YfbPWAsP9L4fwQ74FfTw1EJfOf1zcG6J56lGl62y8ZhSx1_Mo8C3-Oj8tkQ-VtKd5P70odGvnVAal64UPP0UJlszD3SMfow76Flb2RF1p7Gqh6WY62-Xu-OqwwiIz5JeEh-y6Qxf8HclPELbnmlt0U0k86xqlnZFSe2hKxMDrACU3Qj95qDY81WkeP2aYiVrdvodEtRXOys0MY3r2HlIT_p-4x-7d9yX6iMzJxyryOQvv4v754RJJlW7NJjkEzKb9O2Sel7BVg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.18,
    6.79,
    5.99,
    8.58,
    1,
    8.16,
    9,
    7.61,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'hillary-11-asok',                                          -- slug
    'Hillary 11',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '43 Soi Sukhumvit 11, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7448372,                                                   -- latitude
    100.5567549,                                                   -- longitude
    'https://maps.google.com/?cid=6240648723267175606&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJs7dKnuGf4jARtsRVDvM8m1Y',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJs7dKnuGf4jARtsRVDvM8m1Y/photos/Ab43m-uhvqEX9H9jqtKZuXtYgQ3r-EvME2GAB6twyERh8xq-bwiTegjSoPQMfd9wlV5HpxFH-DCH7FeRR6L4px2FLFiwKJL_6bGZyjMRkWSMQJVf0JxzJ_UuKKdTsbCT_bvswEGyn832mADEqjCMcoy_5DbULAu9eqmJilXuUpa6piRQ6XAyKOK21l-VTwZ2xdK0X709hKsUiI4Or5udTci2xVQGuQ8xP5nWwDeMP1GAADxYWBq3weWZ0T4IemIEz1Jbq2a3QzXra8peJsHDn1vxjhNCbg7lK9QXqWvTj5fMyt2oMGwNUl5zOKB_oVXrc3p-xrcKKmcgKiwjI8K-k0PMDbgm-plD82iiTqvgWgItqI3spWLZGv0vgDkZlkWQwi7lOlmd4GkNga4T2M1T7xmaCKdEdHlpbEXSONlAKoEfUMqa1GgWPJU5qsItsk-QOGAx/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.72,
    7.06,
    5.86,
    8.14,
    1,
    8.32,
    9,
    7.24,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'top-secret-asok',                                          -- slug
    'Top Secret',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '392, 50 Soi Sukhumvit 20, Khwaeng Khlong Toei, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7340266,                                                   -- latitude
    100.5635654,                                                   -- longitude
    'https://maps.google.com/?cid=6135859634791398954&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJO6r42fuf4jARKj5mI9TzJlU',                                -- google_place_id
    NULL,                -- phone
    'https://www.facebook.com/topsecret.bangkok/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:00 PM – 2:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJO6r42fuf4jARKj5mI9TzJlU/photos/Ab43m-tmv3VaV88hQoWW_f3iFJsdRi-V4C-1ONxjF1Bab52P-2DRrigPc-xsgPCnBuWefx7izaNYP3rKtUHpKPATiwTa-_bveqPS8IX9Qv9qCD6fsK0zLZGlYDEC3y84N3mU_MS09yeevmfB0OTda23grUCRN-r4wECVBYGPXuKrtYbQaUhhZ1bifSFPCGQRcz2Jmblj9l8BB_Ck7fGpqA85kgPQMKDysYL5BakCEUrc1tFiFOR4mQVzMIBh4asKbn-ivR2jL2S0ikivr1312WwqR3FtC6Sr-R5576tn6e9KhO1lw_vheUup9dC2khhLeuAibkWrfd8FJRwmR7z6_zp58cttGHU_xrwQy1R4qjqunt61gQVLMPBJBB5dyhGas1fsDnHXcaMuZmiPL-O0GpGmJVXIOq8cKIeYmEMa7UaX0mhbtQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.62,
    6.88,
    8.22,
    5.8,
    1,
    7.68,
    9,
    7.42,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'spankys-asok',                                          -- slug
    'Spanky''s',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '4 Sukhumvit Rd, แขวง คลองเตย Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7416146,                                                   -- latitude
    100.55322149999999,                                                   -- longitude
    'https://maps.google.com/?cid=6867461663697780222&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJNeHJbuee4jAR_r1Rbf8fTl8',                                -- google_place_id
    NULL,                -- phone
    'https://spankysbkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:30 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJNeHJbuee4jAR_r1Rbf8fTl8/photos/Ab43m-vX1BSaqYfvfaly6UqhvoE11SB9_m8-NiW4Zcjm9P9eglvY_Bjv8XcXKg6L6CZ0HnvqCGVjBxDveTjSKYq5_FWoe6nRzGrkuBe9qMt5PbcyLjApE-GHlh-B5Ra7XfLR3hVUtMtLQLqd7o-6u_b5F9EMo2G_r6_RewD0iE-a_x3NXvruHzqjk-B9obotl8tbqxDMptzuYc4ewPpFMYB-nVoWpvIjh9S3iKsn1VE0kqVt2TTTLgE4x5DszdUIszy2kPurppQNfSS32ovEqmcqzTk7gA8zVD64x2-7V9hf-lCQTQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.23,
    6.86,
    5.93,
    7.61,
    1,
    8.35,
    9,
    8.52,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'asok-bar-asok',                                          -- slug
    'Asok Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '4/5 Soi Cowboy, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.736919499999999,                                                   -- latitude
    100.5619835,                                                   -- longitude
    'https://maps.google.com/?cid=11321202694002803866&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ54wfH-Oe4jARmoQ7Lt79HJ0',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ54wfH-Oe4jARmoQ7Lt79HJ0/photos/Ab43m-tsZ5X2zuV2F5i-KVXvdDtFX8AkPn7wC3CJpWPggTRm_nS_cf5WL9JxukZxIEhhK3c_OyFm23lXwWMyEvdBQzpS4h-Zdwr-uS442RKDQCbauXzGx6XVHZOw3NRPV8c2NwdCLg8BsQhzUrJ0H7ZnSTdpObgrX6_BGzIKHldDN5SQu51ytt9kSEPav8PLecQ33CvFQiJ-JKWJprznHMjt1nxiSNmPMbNaEn4mFpOXzyBtmb1g0xr8aPHnA_8JzdLtWk-Puo0AUkcAiaTXdYt64g8xUbjuiA0Pmw9Gsn1aPeqdjTiGQbf6po9QsHaFNntnUUGxqrriDefq0w9isgvsIcXIm3F6ATpVCO4p5S7kvOCJpg6AbVF-hspkYPaGZw1IvsJ1LA7Oc2yWlDxXHJVf0mctSuGDWcKFbDFhIJNFYoMHsy8/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.51,
    8.59,
    6.2,
    6.1,
    1,
    7.95,
    9,
    7,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'nest-rooftop-lounge-asok',                                          -- slug
    'Nest Rooftop Lounge',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'asok'), -- area_id
    'asok',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '11 Sukhumvit Rd, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.744924699999999,                                                   -- latitude
    100.5560568,                                                   -- longitude
    'https://maps.google.com/?cid=11151455677768979684&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ52vxHeae4jAR5NTuIdvtwZo',                                -- google_place_id
    '063 901 1006',                -- phone
    'https://www.instagram.com/nestrooftop_official/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','asok'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ52vxHeae4jAR5NTuIdvtwZo/photos/Ab43m-uGVRCoN6UXl6Eb_SzES4yORT4mayaUqh3GcCTrEsbWv6Ybcqd2OvHYnmx9uHKI5ERFjafR6hU0-F3aIofMsvyKSBp0BC0DhQPYCdJQReVv7eIj_qV4v0IqZajn-DlDPaD0ksoBvj-kumQRsvm58KPi2RE8b2KXy7Md8Ov2CUkt8ELOAtHSjLSFNGRIqZWsuo2_Vo-V6t96KdGGct5AAEAxdTumgbHasWdxozApTRCzR77iPLD-BLA7rtgPiWCx1kpZFrg6wW88RzzLd0qVL6xk3TT7KK-6628GzSedtwVzYVH1HQsOSFh1iidU7zEkYe5wJxlZD61bYPcmCUECBJga141iR6U86oMOie62TbqiJhyQiLQjIs8OGWNZL6aZAw-t6WHIqFOmeKul_FLrErqwjRDLqNH9RqHcC_UR6ZcUXA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.64,
    6.75,
    8.89,
    6.11,
    1.1,
    7.6,
    9,
    7.77,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'coucou-social-game-bar-caf-ekkamai',                                          -- slug
    'COUCOU Social Game Bar & Café',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '19/1 Soi Ekkamai 12, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7309738,                                                   -- latitude
    100.5886689,                                                   -- longitude
    'https://maps.google.com/?cid=12335579778808637455&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJZRSTJ22f4jARD2hhvnPIMKs',                                -- google_place_id
    '095 838 1248',                -- phone
    'http://www.coucousocial.com/',                               -- website
    NULL,                                                     -- instagram_handle
    '11:00 AM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJZRSTJ22f4jARD2hhvnPIMKs/photos/Ab43m-vvVu9bHRnqh__W0Y7rMiBf3oy-OAJbwKyf18eNey0q-IpE-7gROw1ES1lDywgtCOx2X6qGcGRuRYMsI4JXI5YPiUBDp_5XVjTAUAlHKJGcModd7QgvfnVxUrR7np-L8yVUArFHVMRYBVAyV0v_PVlEh9t-WLHN57prlWKyEq8OeIVetWGHe-pPVUAF74glA0iGpnWfDpm-yDvHsdVn44P4ruVLsngAZjIeg6yVZMfAW4GH1QCeUXg-4ea4SI6PVfJdv8rOVWp6p1ztclgPG3TxtBYHk5gmuOCerp2pc69elA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.71,
    6.77,
    8.16,
    6.53,
    1,
    7.9,
    7,
    7.59,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'below-noah-ekkamai-ekkamai',                                          -- slug
    'BELOW NOAH Ekkamai',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'LG floor, Park X, 295 Soi Sukhumvit 63, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.735145999999999,                                                   -- latitude
    100.5877177,                                                   -- longitude
    'https://maps.google.com/?cid=16627932142303828175&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ6W7HLQCf4jARz9hRUy9IwuY',                                -- google_place_id
    '096 287 9287',                -- phone
    'https://linktr.ee/belownoah',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ6W7HLQCf4jARz9hRUy9IwuY/photos/Ab43m-t-G57QkvxEpO1gkj3ccyX5tNim75Eqroh-5vh7WBe6j7SlQncfhsrOGpPFubZSHbe9JbMccScGeHF1mP4vBw7GFr3q7gMzWn_MNNCW186IkI4xes6umja3yIQmHT0LngMtVsGpNiu7T8iaTpfyjik13eajA8hy4iISkvLPLU4fHIuc5y0KB7MBnjvPe6dr2AMvjpoT_PouNmKvjeflw-Qp7mrR6mZVvntOcsKTdvsDOEJKL275vXLg-rNNf-0GeKBHBECtG7zs80g3RakYwvESmkbbkX7STMgjNCiK5uw4q6-vCEseFVzaRoZ-UGuYxzMV43y5o4TJA-5s7ol2OhuChO6hayfYSJCtzrUq1xqWxoI7p5XJ-r7KpxDW-iT1CFk_DKUup5hI4WbB69w09q0apUAmsVIhA6jY5G83P9Ywb4k7b538kaCRrEMYCtBY/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.43,
    6.93,
    6.62,
    7.92,
    1,
    8.34,
    7,
    9.47,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'turn-ekkamai-ekkamai',                                          -- slug
    'Turn Ekkamai',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'เวิ้งโบราณ Soi Charoen Mit, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.72921,                                                   -- latitude
    100.58665169999999,                                                   -- longitude
    'https://maps.google.com/?cid=18085695975380716719&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJyfvBe0af4jARr4xH4KpM_fo',                                -- google_place_id
    '096 826 5969',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 8:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJyfvBe0af4jARr4xH4KpM_fo/photos/Ab43m-uXKqf95jU6oSGx5iKtXpSJeULYV5tjvgp5sBSKCFTgvbx8uHWgo8yWYAvOud3EmUshSufq2r8K8vSoH6jrleE4TFNk_LDPwyn6GdaZEXeOCsGdeaqiNc3H3q9ntWz3t-lF4BD3vYEE2vWJdHuwlb1pOr6Syb2HgQXJdtcOxb5l49pw380-PeDA8Y2OUZnVICiR-AQy7kCWbv1w9zjlUK3D01ptl2JWhCjyu_vLWltD-JgDtBQLbyu5syDvy8HanMZn1aXuARZGDaLAwsreDj4jNxs6mso88gAmXaGdcdc0AQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.79,
    9.07,
    6.71,
    6.16,
    1,
    7.91,
    7,
    8.06,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'forestars-music-dining-bar-ekkamai',                                          -- slug
    'Forestars Music & Dining Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '126, 32 Soi Sukhumvit 63, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.731353299999999,                                                   -- latitude
    100.5871829,                                                   -- longitude
    'https://maps.google.com/?cid=4554895865309254146&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJy53faqSf4jARAlKnGKg9Nj8',                                -- google_place_id
    '064 073 1714',                -- phone
    'https://www.facebook.com/profile.php?id=61559488169653',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJy53faqSf4jARAlKnGKg9Nj8/photos/Ab43m-uKh614iH5-o-DOjK2QMk5BXGt0D_6NuvAPRVePtA4Uu4sFz5LVlsY5NwPXUOzrreOn8FIjJIjcyLnoELja9Cp-dVaKl8qyj33Xc2zdzD7t7gcu7OH2mu-PgWYkPEtntgnkUxeX76bw6IJ5bjy79vEfTjKbPidCOohMacYzzznWNkoAlpP0UwebreNkPHsFSqhhTCaenrz5frESCil3EnOKl3D-ISkb1wVlQAOT72MYKl4T2T0BEtJITP1SxrMb11c9ItjA6s_1kW77C1GOasfEAt2FiX801LVkZm6UzGhyoQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.61,
    7.11,
    6.27,
    8.84,
    1,
    7.54,
    7,
    7.84,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-camp-e26-ekkamai',                                          -- slug
    'The Camp E26',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '436 436/1 Soi Sukhumvit 63, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.736618499999999,                                                   -- latitude
    100.5884731,                                                   -- longitude
    'https://maps.google.com/?cid=7739690438440194293&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ-9pr9bKf4jAR9RC3dnLnaGs',                                -- google_place_id
    '098 724 2889',                -- phone
    'https://www.facebook.com/TheCampE26/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 – 11:59 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ-9pr9bKf4jAR9RC3dnLnaGs/photos/Ab43m-uZxGnDu4PcH3iIbQ8a3jzj3UZ3IlvFsn8H_uYYTMy_8OP59sv7Ri9CbGlL4VUsKjOKFa6iLPRhvPLmEUSVvQhbeeYm7xumB-ZiLyfNRnuY87huCFVU69gw6SyvvIhmHCg4kVkzkUsTIGGwCG65Mn9Yq1RvRZOLYJcqeEPLPSmupMTrpH8DT7KKRHdJwmnLF_0-iBbetT1cOpOIObvs91UFf1mVu7HdpWVcOkra2lfr43JS_4HKJXh-0BcvHLl3cAxbo2FwWW-O0Xi3oueu2ZiiSVVc6hS8ESPh5T4Do_jwxhhg--A-zlNHLsYMaymGe_46R_D4tKg4vVg_xOxtXUJuW5kNsBhUMM3QJ6GMCjt4pSHL7M5Mdv7Bdsx1X5V9UFAJqtKUF8p6NMNxJJ47QOPXD673Aw7Jcz28ZOrsObC94IIu/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.49,
    9.27,
    6.69,
    6.36,
    1,
    8.16,
    7,
    8.13,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    '71-sky-view-bar-ekkamai',                                          -- slug
    '71 sky view bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'PHGW+3J7, Phra Khanong Nuea, Watthana, Bangkok 10110, Thailand',                     -- address
    13.725093999999999,                                                   -- latitude
    100.5965397,                                                   -- longitude
    'https://maps.google.com/?cid=4969770550221208107&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJBToCegCf4jARK_ohBfwr-EQ',                                -- google_place_id
    '082 609 6151',                -- phone
    'https://www.facebook.com/share/16KiCS8Rcq/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJBToCegCf4jARK_ohBfwr-EQ/photos/Ab43m-u-Xe52Xq8pIaqBoEepyWLR5azo8Cz8ithH1J3LQ_uq1R4yaqnvAX_RdHfKJFHqE1HaJpqJzWYMpQJW6nPcctj5TQaTcOAjZT3BB0iTlQWIyuX07oOnV__aTwKKm6wiMVX4FCDQOdiOmDEyWe1fZ5LgxDOD-30QKxv4OLYqbIXmSvC5G2wrCdQlkRnjeDp_4qBwPfLgw7pz5C44e7-iBswqMscm88pvGIzsKhVCpKa2lyjAiZw-OfcD1YUqXUCl9dsPgBgbARSmy5Fejk6VOWSfXbNO0owl-kj7P7N0dunltA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.23,
    7.02,
    9.38,
    6.58,
    1,
    7.98,
    7,
    8.64,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'zeus-ekkamai-ktv-karaoke-ekkamai',                                          -- slug
    'Zeus Ekkamai ktv karaoke',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '23/1 Soi Ekkamai 12, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.73045,                                                   -- latitude
    100.58854009999999,                                                   -- longitude
    'https://maps.google.com/?cid=7944755028262678694&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJeQePGwCf4jARpnAY55pwQW4',                                -- google_place_id
    '087 084 8282',                -- phone
    'http://www.zeusbangkok.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 8:00 PM – 5:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJeQePGwCf4jARpnAY55pwQW4/photos/Ab43m-t7RX28qW-lxjbDLS5LHC-sJGJkQ9cDzfVky78MsIugF-7mR-tOADhDgZKQmKGbyiV1Xxz-GfojVZogKZwQlm6m6PBK9ChmPXaG_aeNH7Qu8MEeTfyfTERU8x9wCbCFMDlT50MLrF6a95LPaMm99theddq66AWTEkNhTaBxWE7JLbW4LLwHL0pxq54bf8pwjE8FKkZ81wpyEscCvxJUcwXJWmzgRo6rRK--9nUfQVcKqjMC_ZOtKnsIvfxrtVuRQ_rz_hk2z_YDe8E1TbYZTMJWFWnBhmmiMbsfb2ol7KK76UXS6eQpfO7IC99FKfhIUXwfJLZKdXKnRWU_HLFB_H0qwX-rxRS-yoJnC2c1b6OMoDDpHuXqpgFZkRVJjECOoRc54mq-99Slm0PTdpLchPDvyJJQMnnH13TQN6KdGM5cmzPaDUA70zVdct3pu7dK/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.12,
    6.65,
    6.29,
    8.01,
    1,
    8.21,
    7,
    9.44,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'veyla-bangkok-ekkamai',                                          -- slug
    'Veyla bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '559 Soi Sukhumvit 63, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.739192,                                                   -- latitude
    100.58900249999999,                                                   -- longitude
    'https://maps.google.com/?cid=15409543482120794809&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJrxccLkKf4jARufK-Wiey2dU',                                -- google_place_id
    '083 682 4466',                -- phone
    'https://veylabangkok.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 8:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJrxccLkKf4jARufK-Wiey2dU/photos/Ab43m-u4jeZXCf9I6XGs1HdRd_-oJffmYBxE0hrkqjVCwdhPtJtgBewxBG1pTQfWiQWJfyKyP2HaqSt1OuIU-rIWNtpeehNjAW4j7xJLnK11PIEh7tVY14S4DUyhsXfbkWuj7NFli-aaiBsnRuHZUpkpJneZjIBRfZL1_zYeoKGufqkatPp-ylOXGJFC6atz2NhFdZruEpXVehGID679e6mh04wyMGG0z2wt2e8qwWdyTvn_3ZUEPjffJreoKepQvG72g3AH8CjzGEHMvwwh6cBPVKY5pwqyTOpLVYibv7jfkpLYXwqCy0Kz-pCAJc7FUl4RwtLGCY9UR4XW1V0kUtSsMVpfG4_camxSGKE06ki3Nhe1d9NIhbADBtsjTswZpIEBErWnJtEr7HnC7dtfn8G4GIKH80P3XCkO-QW4DjvyFLKYu8iBbFVCLSyVrrpWrg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.65,
    7.02,
    6.22,
    8.56,
    1,
    8.25,
    7,
    9.55,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'replay-ekkamai-ekkamai',                                          -- slug
    'Replay Ekkamai',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '3 ห้องเลขที่ A1-A2 Soi Charoen Mit, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7292454,                                                   -- latitude
    100.5866386,                                                   -- longitude
    'https://maps.google.com/?cid=13897638353245165685&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJPdv_UgCf4jARddgFDnNU3sA',                                -- google_place_id
    '065 996 2694',                -- phone
    'https://www.facebook.com/ReplayEkkamai/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJPdv_UgCf4jARddgFDnNU3sA/photos/Ab43m-sp397mGIfH_WbLnt7rceasWN3wznOor5y2nVvKw9Vv4XTWMgUA01c8oB3W_Kyl0uvzRdt83pMX9VkNkwPyH-rPWR6hPqeJRvOgjgo8-eTiM7R5DQgee6xEwk8tlQdoUWo4BPrW6C6H3hdUxc4VZRXeiJpD_Lru6okz4WO7pIZPu0hv26bTYgS4wl0OtQgI3fDsbTErr8E_fbTp4OGRFEy-MAg2Ro1MVq1NCTz8AqFBj5qtEXR-vb9jJq24HYY-hXPiRG6eNJ5cfiF3BFIloAJi9JNer1BIrJWWIg1QXL3IqebD8eIPz4XMMSouFYZDjBY0_rGfYz-7zmxCUqrk0BFLg-38iusHsj2bbslhzmi2tIcrpIGgJrjAl9_gSA4ec9bfYV89T4MQWXvYsxj4yTqruMtpzPEm-MDZZC0svwIDAb9yUdhfRyWlo5AevZ7g/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.63,
    6.53,
    6.16,
    8.23,
    1,
    8.28,
    7,
    9.11,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'friendly-stranger-bar-bistro-ekkamai',                                          -- slug
    'Friendly Stranger Bar & Bistro',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '418/6-7 Soi Ekkamai 26, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7364818,                                                   -- latitude
    100.5884205,                                                   -- longitude
    'https://maps.google.com/?cid=14445184178319886943&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJQ3fm9D6f4jARX4rZ73mad8g',                                -- google_place_id
    '082 524 9922',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJQ3fm9D6f4jARX4rZ73mad8g/photos/Ab43m-uuEgFZDkLyXS9i0zWrX82W3L-8f9bv6GGBNT_avlf7YUPN2vYrKPudWNsxQ_bMnMco78kxWQzapoBStlUbtjUT1REKtuQ8MESByEKcSAoIJNZPkzTC-Ml66hGLoqgVM1d5_Hqxcn8u8jUr9jo83FmybGMXZgK_qR4blaB08WQEcU0Ju9c77PMD6Trb_swZJQgyzQFRn3Zj8N7grBLot6RlJQqp8GvpNZPtaaS0U1J0HJGve8dKw2C1Ps8xkHGXqRGqNrT-9bZkm7Hq8klFhcfIRYrUWC8b9OW89idMWzTMjdbWKyjCqjTxbq6VgX6XlHeJB8tlinAGoYR9pXonZ9uAggHVLvmQdyDxKNNL2apSi3mSLjkWoehMq17cpr5MfEUvPcjEX0yEVWMDE8-04yb3PvQ1XSWoirqjhfpNjLq1Mg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.35,
    8.83,
    6.27,
    6.02,
    1,
    8.05,
    7,
    7.62,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'soho-community-ekkamai-ekkamai',                                          -- slug
    'Soho Community Ekkamai',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '358-360 ติดถนนใหญ่ Soi Sukhumvit 63, Khwaeng Khlong Tan, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7355772,                                                   -- latitude
    100.5880897,                                                   -- longitude
    'https://maps.google.com/?cid=7267555969263353078&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ9QK9-hyf4jAR9jw2HaaL22Q',                                -- google_place_id
    NULL,                -- phone
    'https://www.facebook.com/Soho.Ekkamai',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ9QK9-hyf4jAR9jw2HaaL22Q/photos/Ab43m-vMbA7Ab2kOksVgp01KWU44UIOrwy_QYV3TA9UJgXeQqAyXuhOAfjQp2eH2_ZiDqJKv_B3y-qG1vNFvhQPHpaZ5hxY8jYi0IzQ8sqwaB_9cO6a-Ds4zlcm8Pa-qbKiYQtv7ZtcVBSkaTkub_0VaCgMcf2CRIgB4u69VyLrHiDxw0pCW4Cjq04jZz9Opk_SQTJMg3PU2aoBJnaOSaHB5dyb-__5xHiE8voo46d8_uM9vhj3nd1BqaDzwJeJ2rgnZgW-zSYQahtT6IMWV445Xl65hg-mzUzEtqWfb9ndGNjl5YA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.24,
    7.47,
    6.12,
    8.69,
    1,
    7.73,
    7,
    7.5,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'natural-mystic-live-music-bar-ekkamai',                                          -- slug
    'Natural Mystic Live Music Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1687 Sukhumvit Rd, Khwaeng Phra Khanong Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.713058,                                                   -- latitude
    100.59457499999999,                                                   -- longitude
    'https://maps.google.com/?cid=71021951148530901&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJB3D0MACf4jAR1Zx2mRZS_AA',                                -- google_place_id
    '089 794 4457',                -- phone
    'https://www.facebook.com/share/1CcM6CfdkM/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 3:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJB3D0MACf4jAR1Zx2mRZS_AA/photos/Ab43m-vIMrR9D8C99ONqBmkHT1bhmwRKQCMntPPPUt9_L-UMWpqWhI34W0ZQNqIjJaLDi6221lbYGyH38rhVy-yWlE2i3QzepzcbsQQNV4Q-nRe28uahMEvfO5fqILlE14Sd7ful2ahfCQZBvksXNFkapggk9gXV4V3b-de6HoOhngjk_kgh8QfMtJUawC04-8duuffFgd8pQiPtw-7Y4sqnBZ6VJEVtT08qd0ZPPWTanfhptlL9e3RrmveUqdlMPgmL7Or52xpPPX1-U1xeeVaUpiy6vIrXNhvghQH085HcrF8fKw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.72,
    6.93,
    6.03,
    8.76,
    1,
    8.22,
    7,
    7.47,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'house-of-ninkasi-ekkamai',                                          -- slug
    'House of Ninkasi',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'House of Ninkasi Craft Beer 1059 10260 Sukhumvit Rd, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10260, Thailand',                     -- address
    13.724070099999999,                                                   -- latitude
    100.5791401,                                                   -- longitude
    'https://maps.google.com/?cid=12477563129349337358&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJz0wJWnih4jARDvFgo441Ka0',                                -- google_place_id
    '092 541 3808',                -- phone
    'https://www.facebook.com/HouseofNinkasi/',                               -- website
    NULL,                                                     -- instagram_handle
    '1:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJz0wJWnih4jARDvFgo441Ka0/photos/Ab43m-vqLH1e6j4zhpt7fiOqyjcjtEgkyIp_l-Xm5AiVFGgs4QIWa2qpvPyHkJpUsIpf_q5Ru5ERyB0hzkrheqxq6CbSLpozc4vH78jQHPihbPvXcd8Eq_blOpEbMmSO3g5SsrR0KYEyL2Ot9pIoNtfK6dSqR2g1AwNnftf3BEYOvQFhSh-Pmc7-PmD1r1IDxspxnU-fNJu38uDM_-UtTlfMl4R5J6fXYEYyAdf9asuFEcjrdKDMy483g8_5TUS6PiotKW_gvUf2AM3lKal1MR2XsYrdavaDQt7dft7rsJ_n5rReaqFrfCeJ1Xv1zVJh0vTlzcLYRn1QYLhqo3bDFtkfXBAA_1WnZC1V6ZjClQ4ifEhnFbBpPodcWN3ICE4Dg1ba8eeayPn6uzrnQHo5gRsi-vSEKYDQrPRxdifUHmPtXHv7UA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.11,
    9.16,
    6.5,
    5.84,
    1,
    7.78,
    7,
    7.57,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'hazy-hound-craft-beers-bites-ekkamai',                                          -- slug
    'Hazy Hound : Craft Beers & Bites',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Soi Thong Lo 10, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7319978,                                                   -- latitude
    100.5828835,                                                   -- longitude
    'https://maps.google.com/?cid=17141984383225225603&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJD5IJqz-f4jARg-Fuc_mP5O0',                                -- google_place_id
    '082 650 0722',                -- phone
    'https://www.facebook.com/hazyhound',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:30 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','craft-beer','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJD5IJqz-f4jARg-Fuc_mP5O0/photos/Ab43m-s7UVSPg_AU-A3HAYsQNhKvPvqrcm6YAIrJRgwvDXAtGpi7TLgKpXYpQYmVX9mw-rd44ysUcb-fR4yYUTmc-McJr5Cm5aMyFwEbexSjGJzbQN38Vwb33bPL8NUIPPDVRfOJf0Skc0HXLyJ2b8mAKpfVAHt3O_UP7HcBdIAnpIbbc-mv8LqfpZ31dcNtWk3NEFpP-q4EeuZ-TN64Fjn9iMX6SojisXqkdLABchcfyrM8yETpocRwp26v6e2FePAwry_2ifZoCQ8BdqK60_9w_A0BoxxLX4eHfNKdLpgf9IfyKg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.13,
    9.09,
    6.6,
    5.92,
    1,
    7.91,
    7,
    8,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'burbrit-craft-beer-phra-khanong-bts-bangkok-ekkamai',                                          -- slug
    'Burbrit Craft Beer @Phra Khanong BTS, Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Unit 106, Summer Hub, 1778 Sukhumvit Rd, Khwaeng Phra Khanong, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7143198,                                                   -- latitude
    100.5921583,                                                   -- longitude
    'https://maps.google.com/?cid=16613403185851986524&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ7XP2V_qf4jARXPIMCy2qjuY',                                -- google_place_id
    '095 965 2772',                -- phone
    'https://burbrit.com/phra-khanong-bts/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 3:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','craft-beer','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ7XP2V_qf4jARXPIMCy2qjuY/photos/Ab43m-tPeXf44oyxnRclHSEsgGCI5aPPjvTtvCC771ZNuklBqGcsBfcP8_1MkYJIlEQzg_z8PDYCBVF4-cPOn_4mtgIZi_EGX73o5EnROa4vkxTB7xSKVZjn6MJyTEnx0xbdqpvERBIZ3xZhzXL0XlcuddbprpdqxP9p8OyQD27iHxCTR65MureFMxvaKcGODKdwp_pDvTDXUzGHgmm8xhGOyC7vF3NNkHFnKGKSAycIbJmithyHBZP0mw7V4pjvXcIYVu9PonDYP-w4RyLZ3GoQ5ape-6MulvkWj13EFoI_jYvOnQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.38,
    9,
    6.49,
    6.42,
    1,
    7.97,
    7,
    7.84,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'modern-day-culture-record-bar-ekkamai',                                          -- slug
    'Modern-Day Culture : Record Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '70 (Floor, 4 Soi Sukhumvit 63, Khwaeng Phra Khanong Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7247232,                                                   -- latitude
    100.58480449999999,                                                   -- longitude
    'https://maps.google.com/?cid=8086624585196595373&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJqzvB38Gf4jARrWiVKDd2OXA',                                -- google_place_id
    '063 165 6895',                -- phone
    'https://lnk.bio/Moderndayculture/main',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJqzvB38Gf4jARrWiVKDd2OXA/photos/Ab43m-vO6GfbOaM8-bHMdsywulZCkwUfSWdHZhd0D76dnjCyGF-Lu-mZCnTdY4mB8QuXGZxR8J8diBMlSMg-s_ss2-KGOQu1INtgcffkHy4_Z11Y2hXt-mQRMQ8heziMFmDkuvXGQf1_eqbrU1R5Z4lPcwdd5Ia-vXTA6Qa2N6eNNsbQZllqb9veVGz093EVGew1bwNG1u6cJfjl16X7iUQDSv-ZnIgzwSssnHZ2N8hoe-cmpGosKKrPUEOirZEh185UJZLphQBcwwVJERvSwj6CS__oSPV7RshLmXtve8lYAczGUPMiMo98m5SEOfk1DNAWj86muna2czRLAvVIxeXfwqVxRuQ9QjWDh9JX5sBGK7DcPsIcU2Xd9Z2Bv8UVWKi7UiGxfF6rNNaNH5kFqiFeLy4U68hl3xOeEOAq9rR36b3aHpKr/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.5,
    6.79,
    8.4,
    6.37,
    1,
    8.05,
    7,
    7.7,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'mandalay-rooftop-bar-ekkamai',                                          -- slug
    'Mandalay Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '168 Soi Ekkamai 12, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7297731,                                                   -- latitude
    100.5950522,                                                   -- longitude
    'https://maps.google.com/?cid=11373266578467353520&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ91ZJKACf4jARsHNe6bH11Z0',                                -- google_place_id
    '061 202 3999',                -- phone
    'http://www.mandalay-rooftop.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ91ZJKACf4jARsHNe6bH11Z0/photos/Ab43m-uKBEpDkhg1s9NA0kPtLytX2Wokjc7w2Zh9Hz2OUUU5--TlYmw8Zsv24P73XJDJ24M0H8Y1yV3bX0BDiF5pPfmTO-WgGU1CDTJ1VYQGw_Er8v834fWWGLYOX6LOwb49iKGwG6QEO1lJwIuooVZHMytepRTWOfLBKq5kalBllBFXScHjjdUrkvF25OwbmMmRDdaE-LrPtZUaluZz8JO9CQa6uQngmIiZUGTBOqQSOecmCzH6GMIh8ooiFuNsP2rf_ZHSuVOUhm7JTV-wwH--0zzBLjgh4ttQUJNlXwH2gbdgLYjia2EJfGladf6H_djAner7udpzqPHZWcC8i6oRvfzlHd5dMpfXrO5Zqn_HX7-gyYJZTfRx6kpJU1182fM2PMkdjECb5-p3sF9j_zGKVaGRUnjk6OiP-WpfuTCb-JWeKW6b/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.22,
    7.61,
    8.44,
    6.49,
    1,
    7.7,
    7,
    7.42,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'tuba-bar-restaurant-ekkamai',                                          -- slug
    'TUBA Bar & Restaurant',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '34 ซ. เอกมัย 21 Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.738416599999999,                                                   -- latitude
    100.5884871,                                                   -- longitude
    'https://maps.google.com/?cid=6817736970270086708&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJJyqGlK-f4jARNBb_DKd3nV4',                                -- google_place_id
    '02 711 5500',                -- phone
    'https://linktr.ee/Tubabkk',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 9:30 AM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','popular','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJJyqGlK-f4jARNBb_DKd3nV4/photos/Ab43m-vbCvqQr9P9L9Kcp9UKQMckw3p1Ski1S0h5LJ16tPC2K4objF3kF2Dnu-e1XyNpn_FbrqN74GkeLRcJotynJGGwEE8ZS7Pqm7VjykIJlY80QR6iHxkyFslvebSJKjOEA1KGCc7Iq0PJia_Fp37Kf6XgKkHpQVD9mi5MvBuJ80b_rGUINmiPD7KcOhfn6zp8EN8DA2gZKBAQihvpLs5cpJEBIpaY1eZoSlZFySpte6bq88wbq8bXzlS181w1GtJ_eoUPQvgHJcM7ddMI4WCpvq2Aw7_NlWMq4WmIsWebVJ3P5A/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.96,
    7.58,
    6.28,
    8.94,
    1,
    7.97,
    7,
    9.38,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'brew-beers-ciders-ekkamai',                                          -- slug
    'BREW - Beers & Ciders',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '759 Soi Sukhumvit 55, (Thonglor), Klongton - Nua, แขวงคลองตันเหนือ เขตวัฒนา กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.7428263,                                                   -- latitude
    100.58535889999999,                                                   -- longitude
    'https://maps.google.com/?cid=9173919675116153983&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJYTznX2Of4jARf-xDyVZPUH8',                                -- google_place_id
    '065 928 5558',                -- phone
    'https://www.brewbkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    '12:00 – 11:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJYTznX2Of4jARf-xDyVZPUH8/photos/Ab43m-sCmw-2qJ0TufyZcYtANKCzlDtJLVXSpDoThICbLBbu9JOfuYA-9bqHtr8CeFJMweRab0NEG1j9xGSScn1BusoF8RMrpqtW7BaKOGKu-3PNtp6zORgclZEA6K7o31vCj4V-0YsgyPaesAtMIgPXAyjA9yF4EtJdgDaW3XLLse2CG2CyxTWDnGNxn26SOC5QSElU97riVV0MgwUl9Ody7BfrWKPN79UDvSEvBnWAiPXDAr3vnEL5yszMBkiJSt4NttEh2gs0N-MbRRZY34OleBKoB875oM5uWDJsbAP2u3Ocfw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.45,
    8.55,
    6.32,
    6.45,
    1,
    7.65,
    7,
    7.5,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'heal-ekkamai-ekkamai',                                          -- slug
    'Heal Ekkamai',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'PHHP+QH8, Khlong Tan Nuea, Watthana, Bangkok 10110, Thailand',                     -- address
    13.7294232,                                                   -- latitude
    100.58645299999999,                                                   -- longitude
    'https://maps.google.com/?cid=6996334030974533238&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJwSZX0q6f4jARdr42prv4F2E',                                -- google_place_id
    '098 591 4144',                -- phone
    'https://www.facebook.com/HealEkkamai10/',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJwSZX0q6f4jARdr42prv4F2E/photos/Ab43m-sC0umt861BWhRiPKx1a4ePyFvJjuZwKsb2vl-GmtisYg26Zy1mzStvDIVogotnJlZKk2eIr8OI62t43UPDM7XMcGiCdCIAk_kJnWwXKRxRCuy95GvQU88E-fCcutoQ0TuXjhykhAwDlWdUKU0p9dfbrtEtQkRcb9tDW1jVhgTJ6_NTpplAHK0OmfJWmI-Ji08QyhS1ILwkSKPqb4y6jaQ6RuvmmCwJd2jNiy2qXJswbOqnOE5H3YHQHhyfa0QslCWIvInNyZyArSiFnU3yNxiFODpzzUGAe6TxIueUEIDUH4F6FyFTt2NNq2qN0pyVsz6ISjnlwi7I0bxCCOcKqpbjcMbPPkJ3tq7C2mrt5a1OyMIYVWQoz9aRVNXriKloVXyJEuhanGChBujbylCr49CQ1r78zqPM_mjEdK1Nj_yky78/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.96,
    6.73,
    9.13,
    6.39,
    1,
    7.92,
    7,
    8.18,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    '2463-speakeasy-ekkamai',                                          -- slug
    '2463 Speakeasy',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '8, 8 Soi Sukhumvit 63, Khwaeng Phra Khanong Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7207983,                                                   -- latitude
    100.5851971,                                                   -- longitude
    'https://maps.google.com/?cid=15390464044171216638&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJC5jWTw-f4jAR_kY_iYHpldU',                                -- google_place_id
    '097 263 2463',                -- phone
    'https://www.instagram.com/2463speakeasy/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJC5jWTw-f4jAR_kY_iYHpldU/photos/Ab43m-uXTVU-uK9xIN870CaP-fZEODrzFZX5adlNZbwJvlPH-71vf10XNlqavbVLmriXIisL_zIarfWpUE3dgMWmwRTiDMQhE1aGTuQh3FQLoxMHeAnVoEGXHnqHNzcj28f0H0-zB5Xcb418DHdmEPDaJVTZupsZ083YD-jJvJ6wCYsitoobiWD9sKUIjK7rN43cpAauEU1qPWh--2bIIcCDWoRACSDVLhpVlB5rGtihXTYrsB4fkpwnRl3Xgr73camdefntVtq6Pbjb8XCu1BSEvi7nGU7Vu42Rv9vCh-2fXaXoYW58bti2Vfn3h4uokTAXlFEyHfa9-GpnOw4yf3ApHdWMYsazKYEYcqt288mVuhXIectMJwUUaq3gE_5bRF5kWmY44aFPqGTLl7pjF_M4TjUj5NPM3ONDssiYhnoxwjCu5HzRm7olwqQOKUtrkkD8/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.25,
    7.17,
    8.2,
    6.51,
    1,
    7.98,
    7,
    7.85,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-bar-vagabond-ekkamai',                                          -- slug
    'The Bar Vagabond',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '69, 1 Soi Ekkamai 1, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7293045,                                                   -- latitude
    100.58472019999999,                                                   -- longitude
    'https://maps.google.com/?cid=3887317545664074295&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJV5Nenq2f4jARN1JzPraG8jU',                                -- google_place_id
    '095 661 2733',                -- phone
    'https://www.facebook.com/The-Bar-Vagabond-1032113856872330/',                               -- website
    NULL,                                                     -- instagram_handle
    '7:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJV5Nenq2f4jARN1JzPraG8jU/photos/Ab43m-vnuGjp_2g_xuGVnlKPyaJvPxUYYaRWgQcPVzWhjn_jhPLzaC-i2fZhvSDewuCPqF_km_sk0iNKQJSR5gqfu-W1PPFfwgEmbR1dXuzDn3kHQkZRfxNOw5TcqDru1HmH9uXYIqxmIL31EtqTSejHGE5zWX72eM9HBVgjqP-KeKNce7kyEfI65W34eVGOG87aIVJwgJC1p6382NHx2zogTIxKvjP0xY841g0eAu84FfJKg5bg2mmV08maK5PvmH6A1f8_4TJLxLTuJtHUKNHlDoCpbUKbm1qSFt5-xVzHYfmDBu9RQmfnsII6L4D8-XURJ7vRHq4acYIa6PToj8u1Z_1kYvRN2s38QGHqD6368sLt7l8CK9WXuhhmhtKcfzoo6k1_1U1mFAqK5mIYeC3Uoc4HoUB2yWYAlgmaPZkkdqdjuJMrrtkBE_kqVM_sNJP1/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.34,
    6.65,
    8.23,
    6.3,
    1,
    8.37,
    7,
    7.93,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bar-scofflaws-ekkamai',                                          -- slug
    'Bar scofflaws',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '582 5 Soi Sukhumvit 63, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.737527199999999,                                                   -- latitude
    100.5889823,                                                   -- longitude
    'https://maps.google.com/?cid=1218596473902378192&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJlS-9juif4jAR0Kx-XwlT6RA',                                -- google_place_id
    NULL,                -- phone
    'https://facebook.com/barscofflaws/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJlS-9juif4jAR0Kx-XwlT6RA/photos/Ab43m-sGy_LoNDrQ_DBOltGUstXEbckUImXuBz3FVxwu6MT2m84qZAIvkYFtUMF3W6m-s8ATabxyrr8L6FjKpoiYeyRc5p8LIwDmknpDMAVquVhHzNGHvTuaTVm67UTKvsSob3WahDU0TqDIv6-BcOzcQqvCskel2Ot5pQvXbLZ_AAYmkjwfcPng0zh1mCp2IkKkO8SluzPU0EHnhCMtnrq4ZrbiYZ7pwwmg9TuRW5uOa2uYfg4eAwnYg4-CNJp3zqGc1psAPZyjAv2zDOeQJGxf-iN8syjyLubvICpVjflEC6aRjFxwaQvLVY2cTpCl61J6JaE5hGiMLpCabSYzwEWaGAl59R9nsp68jOP_1OPmqvPnwDfP_rtHe4ZYSop0YUYOynWFjrENFpcc3uMhZJRkioG8COA0GA5Rn0qzgnQxs8Q/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.95,
    7.02,
    8.02,
    6.4,
    1,
    7.83,
    7,
    7.8,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'chrome-club-ekkamai-ekkamai',                                          -- slug
    'Chrome Club Ekkamai',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '45 Soi Sukhumvit 63, Khwaeng Phra Khanong Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7264986,                                                   -- latitude
    100.58478540000002,                                                   -- longitude
    'https://maps.google.com/?cid=10996711670082087343&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJnamAAXef4jARr6miOAArnJg',                                -- google_place_id
    '091 805 4045',                -- phone
    'https://www.facebook.com/ncaclubekkamai',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 8:30 PM – 4:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJnamAAXef4jARr6miOAArnJg/photos/Ab43m-tVBbNqbxk9n6wlyR0hvGVf1A0ux7VOQQGipF67skPsqlzE1N74aR31dbrK4q58otrWPpur5p0g9iihWSBdsxdWzzF-cl7EzvyfCoY76jy0s1REYz90rTILCP3IJxkvvBmP4iBPAV8XbCdQ4kYgFYiVMU8IBQqkZeJ5uaE07xgl95CqkrDlZ3hTL2b59TasXNr4gMsKFy0G_xkxFkWuH06S5mTBioFKH7C6bX2gccjcDDIIFyAreQ5-pRuh0PXnlmuuR3O1YUrNcAGcSd6J-S7bc89tqeqDh3vzET1q9e8AFBq1NgxpyEovNIUPF7yAo_SDrVe_16ZDiGDtI651XIvxlYTs76YGhSmgT5_14JZKEvEgWgXHrSHAmAA0B3h7zhkD6ftwPb8Eqed2Uv5MP8Z2a0Z872KbsJij6DzYVbNUwg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.6,
    6.93,
    6.08,
    8.19,
    1,
    8.27,
    7,
    9.05,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'suea-ekkamai-ekkamai',                                          -- slug
    'Suea Ekkamai',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'เสือ เอกมัย เวิ้งโบราณ, 5/1 Soi Charoen Mit, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.729401,                                                   -- latitude
    100.5865613,                                                   -- longitude
    'https://maps.google.com/?cid=14560234459844525853&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ8c-DPeaf4jARHT9vCRlYEMo',                                -- google_place_id
    NULL,                -- phone
    'https://www.facebook.com/%E0%B9%80%E0%B8%AA%E0%B8%B7%E0%B8%AD-%E8%99%8E-Ekkamai-108358684111564/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ8c-DPeaf4jARHT9vCRlYEMo/photos/Ab43m-tYMUZKOdMWLNy7dT4k8XzGhsFqW9kYaBHDzm2uOQIug9Fl2i9lM64T4sCViwbbvt5BoMHrVrhA5I3iSvKWnGMmUnK04Tc8FYgyA-ywjy0xauURSlf8kEsu3VbbQohMkbtgw6QSgjRsDRdDhlmaWCe1nQ0g-EZNEABB9tc8Di5w7rh440EL3LRj6AZ-gG7AuB2RmKTWcKj8zyPJKc2vyjy-eewvnBT_o0G63tgJVX5tXPKaNKAzHQwSF6-01x6kWIl3W7LcjEdcSomyztsGcP9ktNDnAS2zvbmbpFKvYxp7039cL8E_W1vfsdwROMXuGosV4udQwfTQanhP41GiXhcKjBIAyvN5eHOyuB8_3AlzLLafwO8VNG1kGtEpI5XbyvAyI12JPzBL-h9WG7pmCXzurfnfFL2mqdp3WzP29nMzaCU3fxFXVxMi_4Pvjc99/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.23,
    7.59,
    6.03,
    7.99,
    1,
    7.73,
    7,
    9.39,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'cube-ekkamai-ekkamai',                                          -- slug
    'CUBE Ekkamai',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '126/7 อาคารปาร์ค เอวนิว Soi Sukhumvit 63, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.731515499999999,                                                   -- latitude
    100.58716199999999,                                                   -- longitude
    'https://maps.google.com/?cid=1566359352108360114&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJTf6rAuyf4jARsqEHJYjTvBU',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJTf6rAuyf4jARsqEHJYjTvBU/photos/Ab43m-vxeNHA5C7S-b8J_zxIiH0XQYm5mlvyaJ-UlDbiHORviZpIPdIL3PWAsBVp3xK7aX4MkR0fxciw_sxHVqitzzA3XQEsWFuLfvztz8LCF7Ayokn870Mvgzfvqthv4QGlMn-rfi4mEcLOMLCvi8Bo5tmNeDhVzs61ZvUi2kcQ2y1odeBhsCokfz3cvHkOsHLjoiTahddJcKakYdBU3IynF0TxgpXMQ5_Bf1QMffg0Vh47-NsId8np-GzMrB1CeqPHlHGPT4YhopyFQ0ddz9x1WUfIe-l6BcK2bD6fGHNxaJKpwj0i4eszQoqq0TUMGa3UNWMAbBlb_Y9UY4OxWcd1BJclE1LaL-stmOZq_NNvxmuLVyWOrw9WYiZMAaWsxy3RMO-MWkYpCScylDbuISo6yodJPi5WF7q2BWUEF2jN3C4/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.56,
    6.58,
    6.26,
    7.88,
    1,
    8.49,
    7,
    8.9,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'fishbone-live-music-bar-ekkamai',                                          -- slug
    'Fishbone Live Music Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '5/36 Pridi Banomyong 3 Alley, Phra Khanong Nuea, Watthana Klong Toei Prakanong Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.715098300000001,                                                   -- latitude
    100.5942503,                                                   -- longitude
    'https://maps.google.com/?cid=11866044807194713322&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJFe2Viluf4jAR6py1FeKorKQ',                                -- google_place_id
    '064 771 7260',                -- phone
    'https://fishbonelivemusicbar.godaddysites.com/#ba6e6f3c-402e-4b0e-a7b2-cda90221eafa',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 3:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJFe2Viluf4jAR6py1FeKorKQ/photos/Ab43m-uvEFdi1BHbbH2r71bZaRHw1rtaFbwbQ_a07s7xwrnN0fOPJ-kX4aZxy-wJJ2_-Y080AmFc4ObBU3_Xyqeu__lv31y1aXC2HWy2et9hUCxSHZZc6XuQDkADZ5B08rehTj127OhOIZBqrVDqA7hQkQoYLUE4nTugPI2r_ZQ5bY0nqnhKE2kLyaRt9U2RsDY37VsCiVCtzqJ5vJj-Au-AvlDySIsvTEDRqtGKwpL_J8qEmv15BKMSPbJP6wv8Sd1OonpFNgxrv8rGhCwaWpR3Qp_QYu49Q-sqqMu4Srxx-5IDIw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.9,
    6.95,
    6.34,
    8.79,
    1,
    8.36,
    7,
    7.37,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'iron-balls-distillery-bar-ekkamai',                                          -- slug
    'Iron Balls Distillery & Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'G/F, Park Lane Ekkamai, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.723187,                                                   -- latitude
    100.5844229,                                                   -- longitude
    'https://maps.google.com/?cid=14483291479509428180&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJg36Htq-f4jAR1OeZZt38_sg',                                -- google_place_id
    '061 404 4300',                -- phone
    'https://www.ironballsekkamai.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['cocktails','premium','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJg36Htq-f4jAR1OeZZt38_sg/photos/Ab43m-uYUY5EyqRYXgxvJHXBYVOZ_VMaMqfhKJNRFN7NRfCtrnsqHJhTW8XVs-XI4p7zz3XKZ1jWyrRnXlP6Aq8F9rG4t7pAQi5LSryimjjtiOO4Wm8Eo98GFIWct6u13N8WRlZRnJBAhngVX-EwlwBeN4HX-SrMATHtpZmeI9t3WtY6DiFtfIy13xefqaVqAcdgjnQvokFVSSlkGUd4DicnOtsW8k4e81TFJ5xOCxrDJ3LDZ29cp-VrEAjkNf7N0fKCtJwA5KFKPDmJrJTujjd2A87c4Gzmv0Z6g7rZvliWBr5cCQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.6,
    7.09,
    8.32,
    6.46,
    1,
    6.77,
    7,
    7.51,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'sanctuary-bangkok-ekkamai',                                          -- slug
    'Sanctuary Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '34 Floor, Intercontinental, Sukhumvit Rd, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7224183,                                                   -- latitude
    100.58140209999999,                                                   -- longitude
    'https://maps.google.com/?cid=6989381885617824637&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ7UCSGJmf4jARfePMK8tF_2A',                                -- google_place_id
    '098 279 9365',                -- phone
    'http://www.sanctuarybangkok.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ7UCSGJmf4jARfePMK8tF_2A/photos/Ab43m-vRKL_Vom_Swhc0v7MPCaS787Fv-1lrZElQQybY1a9GCbO3zZc7FetCSsBs_pYNI9O8eW_SnN3BY22cmZQZEiKEb58aOf4veUouI5_d83iolF92yBQZO7gajU6qQ8iK4I_V6vz953G7qIEFKvcv0nWNrHYXwlb7o9oKoKCCsqqmO-Dis9TpBe3SJVoxfIOyzZ71qQ8SPAuIeK62dz3cvfDHEmEJihJ2LEy4-qa_OR0K7PKKrljB7LczewiGkroX1LPUqBbxG-cVa0ranfPZ-M6fY6LmgRtJMFUYXsBnjfgMyw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.38,
    6.63,
    9.26,
    6.33,
    1,
    8.07,
    7,
    7.97,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'mikkeller-bangkok-ekkamai',                                          -- slug
    'Mikkeller Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '26 Soi Ekkamai 10, Lane 2, Khwaeng Phra Khanong Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7277717,                                                   -- latitude
    100.5884399,                                                   -- longitude
    'https://maps.google.com/?cid=5694274367024185834&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJTdaKNbKf4jAR6sEWBF4gBk8',                                -- google_place_id
    '082 283 1274',                -- phone
    'https://www.mikkeller.com/locations/mikkeller-bar-bangkok',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['local-crowd','premium','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJTdaKNbKf4jAR6sEWBF4gBk8/photos/Ab43m-uXyFPL1GblGJKQnEcA0j55aQK0balyz0m37WP0f9CmecldHb8J5H_fVzEFki_sAUipDTxTx6oKRPY08GkKMw0l6THhvU3jhWryqN42ikcGjbejCyycF_LZr_RcqAd24WhIKkoDn5HVr4bfYjeh_vuSc6iPMRJXX5M_fX6yHf-n-fO0Kro-fgmMLBPnFpP7v9OJPf2FVhHBRi0UHeq8a_xu7wu2BW-MK_xohSmjkUs7s1oUimQmNeQdcfx3jePbS6R1S_wPHz4tGtLJrIHICHUXK89hY5paKtBMZirLcGNIOQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.88,
    8.82,
    5.94,
    5.94,
    1,
    7.16,
    7,
    7.57,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'la-terrace-du-bonjour-ekkamai',                                          -- slug
    'La Terrace du Bonjour',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Sukhumvit Rd between soi 59 and 61, แขวงคลองตันเหนือ เขตวัฒนา กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.7225746,                                                   -- latitude
    100.5822637,                                                   -- longitude
    'https://maps.google.com/?cid=12942666224936924392&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJj1Efaq-f4jAR6LTPv1uWnbM',                                -- google_place_id
    '02 714 2112',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 10:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJj1Efaq-f4jAR6LTPv1uWnbM/photos/Ab43m-ue9d0HV1Yi3vP1fhsxug0Y2xVXclHMbKpTIwqmVC4OBCBCp1xzNKwCTxec0fyg3AzyyqQnF8u7HrUSX_nSoTdPd3Z6TQ1Ma0Msg7kMCU4xmAir7sT30nuNRHrQp3iiDKav-GAlex08HDWBwCYEPeesrwSjz_bEvbdL2UQEYQd8Zov1JHyY0rXTJ2uLUQHeGedy9zp-llZiSygjPGr3lRvBUwxA9rzxwOi46vCxdr2VzBLE4l_MLOQilcwmV-1l_HGMiW5E-trf8jNz-W6Tqx7OlQDPjz_1Sv-GQjaWz3jHa4Myjp4WhRKlfLZ1sOOQlVdu9HazZbnnMHhZIfiCrP9rYv4c-TjVtp-saRiSgB9O2pORqfbLw13exc6QRXL0pKAmgX1PuhaQNrKEOZRqysT8Ai5p2CtPxBbFSqFLA71tW81v/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.75,
    6.96,
    8.92,
    8.02,
    1,
    8.3,
    7,
    9.3,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'nunglenlen-ekkamai',                                          -- slug
    'Nunglenlen',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '217 Soi Ekkamai 5, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7313123,                                                   -- latitude
    100.5864507,                                                   -- longitude
    'https://maps.google.com/?cid=13319921724667637596&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJd7RwHbWf4jARXK_Skjze2bg',                                -- google_place_id
    NULL,                -- phone
    'https://www.instagram.com/nunglenlenbkk',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJd7RwHbWf4jARXK_Skjze2bg/photos/Ab43m-uT8yMInFJFr_rLCY1E-BHzDBGWgCffUCJhEWsITbfGEQP2ee6eCeDIjJXg2JEZS76VFz4cqitmPSes9suIdX2SK8y-NXOoSaceA6Asd-O1d135aL9XXEEOftlpsrTrMzqBflENatMz3iCXo6925ktJ9gMa4kJfh1pgVj9QvX2jMYiNUVWKaAU3oRmXPEgx0H8fWdBFJ0RGGucyBYETHwA2MKs4Ri3SIvEE8iGd4GgG_Uaih5oLf7AzSkhVhATxL3UzoEWmaM8oL4Isr32bzAnku76LnAEVzYdwDHkISJz5nkdvHgEVjD_C9EFVYctUkYyXNHpidmlbJmb4J_StjxSjgV9CwdT6x3JE2g4lzBGpcAnmbMv4-__2mNyoKNJu_b_3uE7EI4-4sveVmvVoxqfuPvEGQ-9oBg458EQFYvG-KjVw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.22,
    7.17,
    8.12,
    6.1,
    1,
    8.08,
    7,
    7.82,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'sherbet-club-bangkok-ekkamai',                                          -- slug
    'Sherbet Club Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '59 Soi Sukhumvit 63, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7284538,                                                   -- latitude
    100.5853892,                                                   -- longitude
    'https://maps.google.com/?cid=14075919079471379959&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJLbH48q2f4jAR9_UIS9O1V8M',                                -- google_place_id
    '02 714 0979',                -- phone
    'https://www.sherbetclubbkk.com/?gad_source=1&gad_campaignid=21677376392&gclid=Cj0KCQjwlrvBBhDnARIsAHEQgOR3G82nDThsN3Yvpb0qef7-iC8G7sZntgFmh2VmebaiPYJZUIe5B1waAirYEALw_wcB',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','premium','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJLbH48q2f4jAR9_UIS9O1V8M/photos/Ab43m-sAe8P7x1KQJ7gxklLImqvfNPstoD4Fjfv-Y4QcVDyciZJxuXnAlBhrJ3nBeHLFUP9cFkva67mB7fc8-C0fzdDBSVWzjI4uuQU9Jsw68XRqWmlQ2f2H3bfIYrzjfdezhRyL_ji90fWL_bQ3OHid1iTnK3ofcoldnQVCd6mKSzY63PaQvEJwoIFTkxg3kZK1L42ejoYTGm_S8l6bHmtAZX6TnsT_kni12LT_n3FvyW13W9R69FBAuHu9eENlrG8MqRlLyM50lrue3LN3bByszR3qF-of6VnSjF8HwC6hMVCTGw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.42,
    7.01,
    6.34,
    8.22,
    1,
    6.75,
    7,
    8.83,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'ekamai-beer-house-ekkamai',                                          -- slug
    'Ekamai Beer House',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Thanon Ekkamai, Khwaeng Phra Khanong Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7233892,                                                   -- latitude
    100.5847656,                                                   -- longitude
    'https://maps.google.com/?cid=15592516492969220614&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJQyq1y6-f4jARBprZPSO_Y9g',                                -- google_place_id
    '02 714 3924',                -- phone
    'http://www.ekamaibeerhouse.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:30 AM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJQyq1y6-f4jARBprZPSO_Y9g/photos/Ab43m-vwndrwzk7YhaaCDZisYlYO7AI-QZX2Tq8sEIK_toqxSFd9AlmkSuM2xvs8nN6KR78MiSiV1VmohtyN4lqbqaiNOL3OWqfTMCsWNTn47r7cwDsiHHQZq5g62VCA50KLrv9mUBtlV2t7ZoNc1da-WbfvGOD4wfvuBknNdPkS5YX9FISTSqvd02E6Cf77kBtHHFiswPWmO7EXmxt6cUCu3UYkyqh4I9rsu6SLs0dRqoeiX43flzX9Acbvtj3-0pYC483tvIf8W3IkmRleXkPjPCFBXAHostAJybyMl3pmZiepyw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.17,
    7.01,
    5.82,
    8.05,
    1,
    7.78,
    7,
    8.99,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'club-beyond-karaoke-and-snack-bar-ekkamai',                                          -- slug
    'Club Beyond - Karaoke and Snack Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1221/7 Sukhumvit 61, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7213622,                                                   -- latitude
    100.5828982,                                                   -- longitude
    'https://maps.google.com/?cid=7856485259798996314&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ45j1HYOf4jARWmVp5bfXB20',                                -- google_place_id
    '095 831 0008',                -- phone
    'https://beyondthairestaurant.com/club-beyond/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ45j1HYOf4jARWmVp5bfXB20/photos/Ab43m-sj3xjW3ywNdoj7ecNFGN8OWCIWqD6-VX5Hu_mUVIWFKjKDPJNw_GLGNA0cRJwXUS4IxvpPJcl-7cnxftC6Zof99pdsoAjXkjd486YGV2F_f_FqP2HJa-BViHuOcXHjhG7PZFMdDhF0WrF7JVnU6fChL3SjyZxww9OZG-uCbN9XbbEIHRw0wBPowY6UeLMm1nwJw_bSkTAAHCns7aj8W9BN4ORIApOvYFrDjNa2tVNH2sXTJPQOPw0YT6T5IfYfJn1gHLOtFNsyaZSHSOENdC_oRp8bs9rjBB24bYyTUh1NAg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.99,
    6.99,
    6.08,
    7.99,
    1,
    7.65,
    7,
    8.74,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'thay-ekkamai-ekkamai',                                          -- slug
    'Thay Ekkamai',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Soi Sukhumvit 63, Khwaeng Phra Khanong Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.731615099999999,                                                   -- latitude
    100.5868993,                                                   -- longitude
    'https://maps.google.com/?cid=1493153760632795545&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJjWXBsLKf4jARmXGOKW-_uBQ',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJjWXBsLKf4jARmXGOKW-_uBQ/photos/Ab43m-t0KjgFyuQznPxGK8aXV47KJJNsdrJwNqMPXp1nEji1aaBVV7k1eSRIRRhJhbLiXh0tHbPaLOqg8A7cHpSQ6b_Iwu4Xftii2s2HL18QhpngR1btmhi9q4f1APnt73fIZFn6rY8BhnALCWeMbsOV4_wFIyGFjD4BS6w6X8GmXZBEXNAFcw7sIDKj-qZiOXr5KEER0xjY4xYAc48ne15XS4Vq_IHE-d4rzfd2lOBAm05OHxRR0a3GjOXrwG4mc7t0-CMd_tjSs4C7GyuqwhEJEM6ZP5g4Lb7U5T5Uq5VZkmBSEy6WTGYq_swggPijtn1NtwnbeazWVyUxVIfWfz0Zb5gAxXrRy5Xare3pryDGcOhKYJ_GIZRaSy3VgFSANhip9iWSIbM9BVURzBQ8wYYet8l3pYivoMviX27sIUqehmo/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.02,
    7.43,
    5.88,
    8.28,
    1,
    7.69,
    7,
    8.98,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'tbc-the-beer-cap-ekkamai',                                          -- slug
    'TBC - The Beer Cap',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '335 ถนน สุขุมวิท Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.734831,                                                   -- latitude
    100.5821139,                                                   -- longitude
    'https://maps.google.com/?cid=4786308712125494868&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJeWEuClOe4jARVPaYK2pibEI',                                -- google_place_id
    '084 776 7666',                -- phone
    'http://www.thebeercap.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 12:00 – 11:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJeWEuClOe4jARVPaYK2pibEI/photos/Ab43m-vpG-3PcYOcxqdQ4aK1v9hUK01wbj4QDLd1XqwsQCOL3HN2_YaG0KAosEpmaQ4U-NhP2WcwT5wqGAc2Zhg16U4WUblQ6VRegCqDw8Jj0a5mMRroYcGsOth1H_WUQNnz0N-xXTyylaHDyluj7Mxr9bhwyv9myhKP1xEya4pigsPvUf1J96kBcsEknMoHv1NTuy1936cA1RNJeofnx8pYj3z7R2G5-ssDdGeYigAfGmYC5Jt4cG4i-A7HtIcFqkmqw38UwXUAsdRZD-ZJW1935dGDOfQMSao2A-IlSDMYLGiLaHchIneFeQL4P2W4g1WIJw5ViYvwowRpvvL134L_ygsapLORdYRcBM8942ioX-Dz297db3JBHra4zYousoU8jq1mDVe6HA9vJqVjFH2tJGAOMEenq7Fyk90kx6bmH6Hpa5c/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.73,
    8.8,
    6.07,
    5.79,
    1,
    8.17,
    7,
    7.24,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'urban-music-bar-ekkamai',                                          -- slug
    'Urban Music Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'ekkamai'), -- area_id
    'ekkamai',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '126, 41 Sukhumvit 63, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7314624,                                                   -- latitude
    100.5868295,                                                   -- longitude
    'https://maps.google.com/?cid=18375114871387781010&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJw1VYbpWf4jARkvcQuJ6FAf8',                                -- google_place_id
    '099 078 6464',                -- phone
    'https://www.facebook.com/urbanekkamai',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 8:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','ekkamai'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJw1VYbpWf4jARkvcQuJ6FAf8/photos/Ab43m-sj2rmIwsFDhSlIwjjHCXDjKEN4a_gv7p99nmfIa_vzVol-vmUc7mP7wBz_aWYRfAWQoaPGNMmhm2oT5hlZdev7mo9WAfcWAQdbgJ5shhGCrYQIHOJ06pI3bC-adMew41vSIvhHiVCzaUoC3aAOiykDdFZe5S6VFgjlH_LSTvvOfsV_-jK4ec1PE21AchrWvw3tpxdaewl_UnWSLSQV4QFSxh0DNKeMuA5aKHso_PBl7IvGeGEVG2DWAHw896_-AZN_Q0pcMTOg7BkTPtYDwTfqz0oIji-UMfjueQ7x7BhHBM4wo363BaruLxcAkUGvx1Rz8TSDs-WLiIrSxPcvRXAOsCf2EcsZcbC2acrMDB2T88K_uEfx8HEwMXq69zUQlDyxE6HV9YpbazgS7DRcgquKKnZzaCp-fSplQG7mWZLZMd0Pc4yEubglWtdJeA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.14,
    6.73,
    5.66,
    8.04,
    1.2,
    7.94,
    7,
    8.48,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'notoxic-rca-rca',                                          -- slug
    'NoToxic RCA',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Soi RCA, Khwaeng Bang Kapi, Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.7523431,                                                   -- latitude
    100.57352709999999,                                                   -- longitude
    'https://maps.google.com/?cid=10688331963517305330&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJx58SMMaf4jAR8gHnpkqVVJQ',                                -- google_place_id
    '061 179 2692',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 4:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJx58SMMaf4jAR8gHnpkqVVJQ/photos/Ab43m-vbewA4GqpaPAKA5D7zL1L51skMXmp_J2UyOm8DHqtaNU6wYdGRUZu58pHbbPjpLpRZ87lLqDrqmf9iUl3U2XCuqN5seDNhNbUTSpkKal8xc0zsQlvo2odMvUe41oRZqncLW5UWDspzzsKEQzWEE4fRQhHJ7xWcbdVf2TqFnYC7xEhxkpU0sqKK5orsq1NnEz4ZdVScQEp2IrPgmAl_jxOcxQBmllZA_EcRbx6YY3mxqnbB_VoMQeUIGMipPlpvYAWeSOgbpu3xWYKIoeVXzehCplLNrnsX6rGMlXPPfNmwePR9kwtUSrmxF0E64D9KgUMwjz0kLvmXiF_4AZDxg-MU-Rp-cq-bbu2FrfW3ZOd0WyZDicjnUPPLjwmb7Lnf-_3wVz1knPaGpU9Jtktddd1xrXlyaxWZI1nHWJKmlUy90mXCNS2oLopCdzIir7LZ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.66,
    7.24,
    6.4,
    8.59,
    1,
    7.55,
    7.5,
    8.08,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'yourbarrca-rca',                                          -- slug
    'YourbarRCA',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '21, บล็อค D 95 Soi Phetchaburi 47, บางกะปิ Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.750179699999999,                                                   -- latitude
    100.57705530000001,                                                   -- longitude
    'https://maps.google.com/?cid=6493949028903313347&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJk8lBtyCf4jARw19GQTwkH1o',                                -- google_place_id
    '083 554 9935',                -- phone
    'https://www.facebook.com/profile.php?id=100095610635807',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJk8lBtyCf4jARw19GQTwkH1o/photos/Ab43m-tVGxjJ2JXyT17mK10hl-nsoCYhV97lpsq2RLZn_zWvydAr4Cu_DpAdNVJ2wIPFsdgyOcv9VM2QPdeQD-lugDCO6H5n6C_nai8Tzp5bPfIkoWmFDS0pYbg53tLJ2nHCsUU6U3kF0DeHDDH2-wJrgj_XSIxEQbXxgfv-4b63IqEFPTbv7OeVteXvabCzpZccFTIvChpjItVl2lWjGr0-CSXHyKhen0JN0VdtEzpGhRRKyfyrjNYgRFfqeAh3CaNDjaxVDzUrznRNB14XB4MIha_o34jPwN40ND_mkFCUx9Mv-py5HYYaI-oezz97AhQRbA57Ri9xWhOOIwuEQkiAQEd2tF9FBBQ0Z6fCK4MGAt-u1FsLNT4-ti38dZoTDulaSk44LUi6cJavgxtd46xblU3EmvsDHWB2I5fJ2I6IaqB6F_uE/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.15,
    6.82,
    6.76,
    8.84,
    1,
    8.48,
    7.5,
    7.98,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    '81music-restaurant-rca',                                          -- slug
    '8+1Music Restaurant クラブ',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '29/9-10, Soonvijai Aly, แขวงบางกะปิ เขตห้วยขวาง กรุงเทพมหานคร 10310, Thailand',                     -- address
    13.7536328,                                                   -- latitude
    100.5740373,                                                   -- longitude
    'https://maps.google.com/?cid=1572901951050689497&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJddWDAsWf4jAR2Svlqv0R1BU',                                -- google_place_id
    '096 517 3529',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    '8:00 PM – 4:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJddWDAsWf4jAR2Svlqv0R1BU/photos/Ab43m-vwFHgS98OB7yFX_xZ709uWYXyFDU5gYYwfauTAyGElITNBtWlKuwTIn98kl8hcBiSBrkWSanWfdBPak44_gw1JPr36T-eBfC5w9QVDq4clrpdexP0jcenN0DjotxdbnwoEakSKnPwChLZwdfXfM_NN2Jyox_BqdjedpsQZSPHMYnnd6uU5ZPD-OaySlO0bBuwAB5_Ll2N_udfiZyzQW95wC-LpvG5aYH-BWGqk2Eq93yh8L0HLbbX9ks0C45KjmSJOTwPiZ2qi9iWDNIGenST8K1HY1qCbGygaaY0N1qpyOg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.72,
    6.65,
    6.49,
    8.83,
    1,
    8.07,
    7.5,
    7.76,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    't-house-dj-bar-rca',                                          -- slug
    'T House DJ Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'T-House DJ Bar 21/49 Soi RCA, บางกะปิ Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.7512008,                                                   -- latitude
    100.57613529999999,                                                   -- longitude
    'https://maps.google.com/?cid=17227203717514370826&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJQxNjOsGf4jARCp-754FSE-8',                                -- google_place_id
    '080 608 7271',                -- phone
    'https://line.me/ti/p/IEh946S1Ez',                               -- website
    NULL,                                                     -- instagram_handle
    'Open 24 hours',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJQxNjOsGf4jARCp-754FSE-8/photos/Ab43m-vdRi9U5NaJDvEjrntz0cUJ0GMCqm2B2RCORMrh_aQpkbgVf_FiqQfkwuN0Tk8OFKOKsM4pVrfv7KsRFsdQAZU8ziFdGOECMSALbHtvDMWgQMsPPkwB3aVegWT1lk_YNnWpSACSP4hU8sa2IPKEiEuYbLtKfbe8JS-nZqb3j49O8PPQJEm0jN61aedn8LzT4qaN9azHuSGBtI4q8xqes6qVoCeY2wWMLFafTVjQY09VV4M2OG0nv9NCkZPZ87ZqpzNCCueFPGd4DD2HR5AYxl6HDuIpqBvdPi9_6xC4G2FD1w/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.2,
    8.96,
    6.09,
    5.89,
    1,
    7.61,
    7.5,
    8.12,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'party-x-bangkok-rca',                                          -- slug
    'PARTY X BANGKOK',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2F, RCA PLAZA, Soi RCA, Khwaeng Bang Kapi, Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.747008899999999,                                                   -- latitude
    100.5796333,                                                   -- longitude
    'https://maps.google.com/?cid=626386619699250326&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJHbJ7KQCf4jARlkQ7109fsQg',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 10:00 PM – 4:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','rca'],                                               -- tags
    NULL,                    -- hero_image_url
    7.67,
    8.78,
    6.03,
    8.43,
    1,
    7.71,
    7.5,
    9.1,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'ccc-listening-bar-bangkok-rca',                                          -- slug
    'CCC - Listening Bar Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '4th Floor, A section, 635 Sukhumvit Soi 22, Khwaeng Khlong Tan, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7217091,                                                   -- latitude
    100.564942,                                                   -- longitude
    'https://maps.google.com/?cid=12343009982168490181&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJyXwZ0ZSf4jARxeBAxi4uS6s',                                -- google_place_id
    '064 321 6555',                -- phone
    'https://instagram.com/ccc_bkk22',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJyXwZ0ZSf4jARxeBAxi4uS6s/photos/Ab43m-s3VPtnBb7oyjFVQkq_K4NhCUluvgyHVVhI8D6eXHYnbJ13F2CmIaCvUurCxA9KOll_jUYfKcYH7VZYa3mmE5x7EHteeIIJO-iybZ18Beb74Am6gEFdeOUy9bE7xz4qoRXO_iVvP242lxPgdNP4CwgKwEG29S1Lokideip38E2uJkXQfIjIHQPjM2d81w97iR4NB6EA_wwSn8C0B6bpVYgQuqOMwxFvqPo_bPz0pvJWD7dSGgu5SmtWrXr5WNLPvbJWF-C0JQ25roGrzMNTkPlZ-z8ZRlETgDFnieWt4W6s5w/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.36,
    6.91,
    8.46,
    5.99,
    1,
    7.61,
    7.5,
    7.7,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'old-leng-bar-rca-rca',                                          -- slug
    'โอลด์เล้ง 古龍 OLD LENG BAR @RCA',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Soi RCA, Khwaeng Bang Kapi, Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.7497957,                                                   -- latitude
    100.57679379999999,                                                   -- longitude
    'https://maps.google.com/?cid=14857910338497311086&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJrXNHQl-e4jARbnG8drvmMc4',                                -- google_place_id
    '081 255 4845',                -- phone
    'https://lin.ee/4ENywWJ',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:30 PM – 2:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJrXNHQl-e4jARbnG8drvmMc4/photos/Ab43m-sT60D6LxOADSNHY6hzA_LiDrN3j0Yp1ujaR8FdAzSqVok0xhmkaYLfkFAtoUY4PcxJKXm0idHo69dPy2_5vEZvH77digm8wmo7lU0BR6zJEvWffs95PddxclaeBPP9j3fvvZtgwtthGj0Z5nUK-ugD0FGlJzHI4D0UgGm5bTrXmBcpcLi00Kw4CMXkvWNSUJ6fjxtEzIC6QTVK3RJoCjvW_6i4twdubQqL1Lljtagd4krl00aKI1P1jc2njepPsYPULgMQaKG9zqrHU_dkxtB1Ykvr4COCfYCQxF6lQTMJNg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.1,
    7.2,
    6.74,
    9.04,
    1,
    8.07,
    7.5,
    7.71,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'hazy-k-lounge-pub-rca-rca',                                          -- slug
    'HAZY K -LOUNGE PUB RCA',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'โครงการรอยัลซิตี้อเวนิว ชั้น2 Soi RCA, บางกะปิ Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.752258,                                                   -- latitude
    100.5751006,                                                   -- longitude
    'https://maps.google.com/?cid=17248534820439702660&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJEaYI2z6f4jARhLxDVAgbX-8',                                -- google_place_id
    '097 176 7206',                -- phone
    'https://lin.ee/tSXDaiH',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 10:00 PM – 7:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJEaYI2z6f4jARhLxDVAgbX-8/photos/Ab43m-sL94Lv4AMdrNbnZvRLMiX5oIQNRBUNJTtaAWM1l_svATEnZE8It8TtmWLCCQCOfj5x0Z9-7S-E_Zikbp5L0aSpyqTGiDDOexMQbwmfHVDI68ymo2eB7MnVMCvjJuHxvgXIYFKf38pV0oZYqtRYAYlW4f7JEs9Ylo1xaTmOq2Fs3BjEX-T_z3IAfVvptZlI5YB91UO6iuBLuSJERGHOZ7amsQyt4FV4o2VJZGlpx17HMtwBUufhVvcUDvc3DppHwG4-bSZGURlIa1UvVpWOTVP0omMjwmwvBAJMWET0UDBKuA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.18,
    9.05,
    6.38,
    6.1,
    1,
    8.4,
    7.5,
    8.06,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-bumble-bar-rca',                                          -- slug
    'The Bumble Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '21/85-86 บางกะปิ Khwaeng Bang Kapi, Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.7505056,                                                   -- latitude
    100.576713,                                                   -- longitude
    'https://maps.google.com/?cid=18048961137411598682&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJWZBh14uf4jARWqk_6IbKevo',                                -- google_place_id
    '082 256 9096',                -- phone
    'https://lin.ee/tn5B4k8',                               -- website
    NULL,                                                     -- instagram_handle
    '7:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJWZBh14uf4jARWqk_6IbKevo/photos/Ab43m-saRaZEBh5cNFvq0T6NA4-jnzv1Cf-WZQ3e4NGadQFbIevD6NHm0EHOacwrO5ornpr0_VIXUTKZa1n1fhNVaf6cfPQyXX-HQ5-XiM-65MMhNHIlmeERBv2u2vlVnmKzj-BDccmVlpWfuPb1Rvp-bPJ_n_ePpXbli4eyW2Cm9vuGrakaMyfEcl_yQddflcpmaeQaz_KUTSmofKMYFpDMuKdMZEt2EhyrKwKc5wGsQA59DZW5zkd46IldIHjcNIgLbf2naoMQMBFKqvRA4T61ghj1BQozxP3Dphojrh_pQxVkaw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.14,
    8.72,
    6.09,
    6.52,
    1,
    8.18,
    7.5,
    7.73,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'talk99bkk-rca',                                          -- slug
    'Talk99bkk',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '19 Zone A 26-27 Soi RCA, Khwaeng Bang Kapi, Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.75376,                                                   -- latitude
    100.57426219999999,                                                   -- longitude
    'https://maps.google.com/?cid=8663796033871098958&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJter31g-f4jARTjRTDZf8O3g',                                -- google_place_id
    NULL,                -- phone
    'https://www.facebook.com/portalk99bkk?mibextid=LQQJ4d',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 8:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJter31g-f4jARTjRTDZf8O3g/photos/Ab43m-tRlf9iPuOmyYZ0Z7xC43-pU5GvGPCJgP_vt0hMdRywBOkA8ImjC0fLOdPR6SnqK07wvI8RrDAt2AaIJNLuHhxd2HAnOquE8n-XDxcp1m2HkXDF22hPjpp7wK700O2btOnOyZBv5jp2GL-97DEsmGZM60YmOecNzRBNpUcVw8wFyCD6TWFCICTWjIAqE1bTYzA8PjDkj5ZAMJMRN6WRSiULljBgfe2yMoTP3Kfu59aOROgxXgXmksFexU3Z0XvXze-XgewLEOIgVSIQERN6isLgvqlgwkGSFLrzyui8k-sFww/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.27,
    9,
    6.56,
    6.25,
    1,
    8.23,
    7.5,
    7.94,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bar-archive-rca',                                          -- slug
    'BAR ARCHIVE',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'บาร์ อาไคร์ฟ Soi Ratchadaphisek 3, Khwaeng Din Daeng, Khet Din Daeng, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.7621918,                                                   -- latitude
    100.566289,                                                   -- longitude
    'https://maps.google.com/?cid=7432610341500044992&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ2_cIy7Gf4jARwEYB17nvJWc',                                -- google_place_id
    '064 916 5474',                -- phone
    'https://lin.ee/MSJrKsf',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ2_cIy7Gf4jARwEYB17nvJWc/photos/Ab43m-tBdOBvfm3fs35B6LffnGUnJGrrEapJDeNCOM2gp8ROL7ReeEfEnXzpxrZZQuQhfoHK_uyUG5uqiBavXeimBYqQfKTEQyI1M6FIyoRFQNlmop3xYKykvF6i03WkqQPvx4TL4VBiQVJkJn9iLhHcrmJtnF7PitTvo5LiejN2GcUo-eqlcA-ZTTpMSZkd2S4SZjNuzu2WSwbO05cxuPZ1Y4CBzFE8vFkrmZokvsTt6xQstuDzJp8FfJ_tUKwpP-c115ONIQKXYDwql-ISMeVwA20erHznym7Y69EcIYiTVmUcTg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.29,
    9,
    6.4,
    6.04,
    1,
    7.77,
    7.5,
    7.67,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-classic-ratchada-rca',                                          -- slug
    'THE CLASSIC RATCHADA',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1380 Soi Inthamara 26/2, Ratchadaphisek, Khet Din Daeng, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.788803000000001,                                                   -- latitude
    100.5683935,                                                   -- longitude
    'https://maps.google.com/?cid=18211118420743682089&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJg2f6ocOf4jARKfj_jrfjuvw',                                -- google_place_id
    '097 215 3913',                -- phone
    'https://www.facebook.com/TheClassicRatchada',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 5:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJg2f6ocOf4jARKfj_jrfjuvw/photos/Ab43m-vtrNsYfJ4tP1IeA__53c86KrRh9ey3_LMSaWBzrLwDBwaf67FwzpnMnCyHAdjQEqcyS4GnuCv8Ac703zTId9S0q3yQGN5gzw2KncGkGvjRlkUCF7SgBP2L0r-acoQ-nTLj9F5OiufbkwWOraYEsOuEyKUVzmpcOe4KU-NGCGq3xvw_ONwx0rr3_GmU2kj8x6tOzmr4L3msVXxC_DS05TteteclAZjMHvABD8ZDiPiNoZbM-H0QRB4AA3IFN4c8EymzhaKYdWhkntwYPuIS8UvB_eMDqUkXxW2XURgv_ndLsL1CEp0UAYIB4Y_iXKxtEV0bw70FM-R6X-VNynFCgegWCmAH09WZTkhHp-1qoyu3zDTBcIQRiqhPL32SBHXNkIMydr4zuVX0ccE1wkwF_ZUZVRHR961HQESodAlkHCnW0Fp_/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.28,
    8.83,
    6.45,
    6.45,
    1,
    7.91,
    7.5,
    7.66,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'amnesia-rca',                                          -- slug
    'Amnesia',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '21, 77 Soi Phetchaburi 47 Yaek 10, Khwaeng Bang Kapi, Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.7513002,                                                   -- latitude
    100.5757386,                                                   -- longitude
    'https://maps.google.com/?cid=1431075123788202682&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ79U-MWWf4jARukJLMD4z3BM',                                -- google_place_id
    '086 362 4941',                -- phone
    'https://linktr.ee/amnesiabkk',                               -- website
    NULL,                                                     -- instagram_handle
    '7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ79U-MWWf4jARukJLMD4z3BM/photos/Ab43m-uKgPUkcIMU7BhApdNQyhqL2Ij00r-pVPZ88s3nvX9vmF_rOV1sIfb9UIk8YFKD5UczFAnM7zgyWDA4h0STxyAmnbOBoLAJ88RXPGy7N2UEmxcYx15mvc92KRcu3ca-AvBOeJoJrVZbl9VuPJdA-JAPLeMdcXeLr1MWJe_wgG_j1XDSUHRfhc8CDPAcTN2SweG_NXWp6E2wRr9l4GFpByPbZm1cqkQbrAozRaH6UOX2dAQJhUmyMP5XrFjYuNM7YJXqPEstpvFUMskZdE3d8ev6NlXQQ-mD8t3wKwV-8T1yI5pILxlwsTfwNpob7UKs6SKQ1-6XTPZwCSUqJIx38l5-PKeqh2H8H9RJibpimTSKIQ0yMVo8NOKDxB9n_BWFcltRn-foxVDNmqQfIYu0lgCJJ_eelgk2KmRzBBmPefxhW-k/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.08,
    7.19,
    6.48,
    8.17,
    1,
    8.39,
    7.5,
    9.4,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'unique-bar-ratchada-rca',                                          -- slug
    'UNIQUE BAR ratchada',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '167/15 Thanon Ratchadaphisek, Khwaeng Din Daeng, Khet Din Daeng, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.778099099999999,                                                   -- latitude
    100.5732695,                                                   -- longitude
    'https://maps.google.com/?cid=14829766436823459807&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ1QiHyyGf4jAR32ffuADqzc0',                                -- google_place_id
    NULL,                -- phone
    'https://www.facebook.com/UniqueRatchada',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:30 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ1QiHyyGf4jAR32ffuADqzc0/photos/Ab43m-tZ_MOO1uMTDoJLH2pAp9jsn-vzI9Ha5LUS4IIUmaRStTWooXhB08nk7P7KhrYR0UxGbRS1ezoJ1z_bS-xrRbSTz1bMJHjGD-dZawNDg74rjz3qaLlHfSkLEjmXlYFWtcaL4eYocBDuraSjCoyiajiPa6HiCD6n5WowA-iOjSibaGCS_WQ4n0u9EpxtCXae8IzbK_-Cxo4gFFuLzoUg54lHg4CoQyYUPbGE3-l2A_P8jvs9AmGu6_SsvmsHkNEfGd0UeZ6y1Olx-ZPhmVEvYZRJ9ZYqeaAn7CHocmFNRtH3_w/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.15,
    7.09,
    6.25,
    8.8,
    1,
    8,
    7.5,
    7.79,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'medusa-rca-rca',                                          -- slug
    'MEDUSA @ RCA',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '21/90 Soi RCA, Khwaeng Bang Kapi, Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.7503414,                                                   -- latitude
    100.5768537,                                                   -- longitude
    'https://maps.google.com/?cid=11019836832560219408&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJkxYHtMuf4jAREIWErzZT7pg',                                -- google_place_id
    NULL,                -- phone
    'https://instagram.com/medusarca?igshid=NTc4MTIwNjQ2YQ==',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 12:00 – 7:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJkxYHtMuf4jAREIWErzZT7pg/photos/Ab43m-sW4IDYsExQoIc0AcGIjtE-bMJxmMgB0tMTpsWiWWcEfOXq2YUDmdj3SnDuckEEkqhTXrf2DeRqRSkpU4-btRegkVTC7VrnLGDiCUwsGMemnvzT4HsO54st0Q_28kUvfIOOj8YnBux-chaqGnenTcrTfU66eY_Llhs2aN2IZjnZ32X19FcV5Oc2sURtrfeEAnC67mjCul5m1ujNIqZyl3NcbKVL-9-VKPqN28o7K6vw-6Bc7Ooj-Jt_taI4pm1wPpy6553V7MDo41_JGjRwuxRu8Gyf6wwrDiteYEYgozNgww/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.09,
    9.2,
    6.25,
    6.52,
    1,
    7.54,
    7.5,
    7.7,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'lazy-bar-rca',                                          -- slug
    'Lazy Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '56 Soi Pracha Songkhro 14, Khwaeng Din Daeng, Khet Din Daeng, Krung Thep Maha Nakhon 10400, Thailand',                     -- address
    13.769886099999999,                                                   -- latitude
    100.5723483,                                                   -- longitude
    'https://maps.google.com/?cid=17564633645332863412&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJq6pqBIee4jARtJnwLz0dwvM',                                -- google_place_id
    '087 123 8299',                -- phone
    'https://www.instagram.com/lazybar.ratchada/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:30 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJq6pqBIee4jARtJnwLz0dwvM/photos/Ab43m-tRp6w5SOeQgBMONGF4JMeVCB7wbogdxdojmgsY3S3ughzB8c7BCq9k3JZ181HTvI6NHofsyKsxQgzi12vcCNsACAtgT4oFf2jWPj-tS5acHseRzy9Bo3s1G7TSti0S8EXpOm-YfCPpys2nkcWux0Nq54kOhNLJfZamqcgosUdNOiFA_EQ5rARIEUqZrYqHCMUCvghFRgnMDWTd0n1XSWnZLyz4HP4vWnYOH4rA40k7XIGc24ATWy4x2OrIQobPw9f07RWJ3m1N6LZE7KlNx6sWT3nQgh-fX5w03eia3jXhUA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.19,
    9.02,
    6.53,
    6.37,
    1,
    7.5,
    7.5,
    7.7,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'yellow-bar-house-of-yellow-rca',                                          -- slug
    'Yellow Bar (House of Yellow)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '49, 16 Thanon Watthana Tham, Khwaeng Huai Khwang, Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.765705599999999,                                                   -- latitude
    100.5725696,                                                   -- longitude
    'https://maps.google.com/?cid=1075992532226058771&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJhUerYXCe4jARE6pO2IGx7g4',                                -- google_place_id
    '088 952 6169',                -- phone
    'https://www.facebook.com/YellowBarAndCafeWatthanatham',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJhUerYXCe4jARE6pO2IGx7g4/photos/Ab43m-vhAdop2AloGuEzZSBf6KAtnwsYUH7kFKQuliITo1l24G51DCi7BsEp7MxUq2Q6sq9pR9L0FhdJRSOy3oVKsy-UlTLKBBMZHJZcdKUCGuUmpErig-eIPqoyQsC3a54an8Zy4z1W_E-jXUxCeRWvRIjluF3VgSYcjFjVcquF1KuQOEpm3x3H2baoG8hNQGqhHMx_aOPEudJdtKvTfPMj7hjCH_AhgZ0F12OHDLxPFAUsEflJf9mvmXU_KftXclJxSUpyx9Cv-pIDaNU54jYQ3-nnoClPVxjhYoA4tgW8r-3oqCrwWB21q30_bRMT_HVooeXsSLajEOy73FRRV8XF8XDOw-Hw58efFYMjpJR-kmeAUIfzkHlEZNPAhKnDRKiFSoaa-pvDUztMQUU8NEXJ3gx5s8fOfXTIlppKLycY7o1FMw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.31,
    7.04,
    6.39,
    8.27,
    1,
    7.76,
    7.5,
    7.4,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'whitehouse-rca-rca',                                          -- slug
    'Whitehouse RCA',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '23 5-6 Khwaeng Bang Kapi, Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.748428899999999,                                                   -- latitude
    100.57858689999999,                                                   -- longitude
    'https://maps.google.com/?cid=18217435791151856494&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJP1qI1S2d4jARbvsX-lRV0fw',                                -- google_place_id
    '065 146 4992',                -- phone
    'https://thewhitehouserca.wixsite.com/my-site-3',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 10:00 AM – 4:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJP1qI1S2d4jARbvsX-lRV0fw/photos/Ab43m-uy0-etBuBnzDihl86ci6tp1u44xwljE0YnWGy-e0Yxajfs5Ao1di2owAJX7lFZB86AXYB7cpCthvYde9BHMJz30pAl-hPnGO5VL3YtpfvDZUEyDOsI2ni1b8rpEPSWiPwKLXlVn5nAYNsHbyYKHGdPG-dYTgIFUg1QLfV4w4BWxf2Xc5Q9fb_tDtt9f4oe21uqoJph2_uk_CvFY8DeMdEFn6rqx9O7o0F_FpFYxfCEbRT_rZx7Ez5be74biviVykYxeMLbLae67DHl1tLTT7rV60NeMhv-pg6ApvUQnYG2ww/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.2,
    8.62,
    6.5,
    8.06,
    1,
    8.21,
    7.5,
    9.13,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'royal-city-avenue-rca-rca',                                          -- slug
    'ROYAL CITY AVENUE (RCA)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Soi RCA, Khwaeng Huai Khwang, Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.7524576,                                                   -- latitude
    100.5749282,                                                   -- longitude
    'https://maps.google.com/?cid=17903059092140497464&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJP4-LN_We4jAROJrcy2NxdPg',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    '10:00 AM – 4:00 PM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','premium','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJP4-LN_We4jAROJrcy2NxdPg/photos/Ab43m-sIoIYw3uR7YbJIRb5OK9t-B3rgnOu-fVhM6_BK-f5iZUUPvAUV1LAaC1Kpn934ifmUVquVEqZBqDwFVk8eWeHxsNPL9GB2rnCa0zxz44tCnI2CMdaD2-dM-JkrY8rTyV1THjOueH3Ry_bhLBzg_teFM4kbDLafAGSg6aU55U7VRD91_8pf7seqx-19-kOuiBywo4pIW040ofyZRVAAKvbSltMJW3ixoR3gARP4odVeZTihu7JUo-oAEXlQU3BizLOuIjorv0FstGyUH2X8Bcc5BK7Z6O2BJswYJWMHrRVCBDoKmIuuyBlBSLkHrQV5z5IsFo-3EwkKzWGARlACWtxaXGS9kPIufCpOKVo_GP2d0XJ7hOvwR5HBcIGDSksASyRznRXCrKpNw-IEMGoxYa3k5D2xoEYpfCnAPVLX0lSwypPaqle2bHoL6eaIaA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.2,
    7.65,
    6.44,
    7.78,
    1,
    7.5,
    7.5,
    9.15,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'k-bangkok-rca-rca',                                          -- slug
    'K Bangkok RCA',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '31/14-15 อาคารอาร์ซีเอ พลาซ่า Soi RCA, Khwaeng Bang Kapi, Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.747352,                                                   -- latitude
    100.5790612,                                                   -- longitude
    'https://maps.google.com/?cid=14902087660055150627&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJQ1ezap-f4jARI8BRrcXZzs4',                                -- google_place_id
    '02 203 0685',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJQ1ezap-f4jARI8BRrcXZzs4/photos/Ab43m-sFhbgcJkF5SWuFqhKWBz2ssaO-DGhsy6YKX-qXTwU3UMbFISagkYb2VsBq-32Fd5hpQVxkNGWH65zAL2x1jY6aW5nbTO7tQ9OOZ2N8de82QFww06f2S7y5hO5xlk5tjs8_eXcCFtoHfY7D6FlCNJ1F5N2wQ-14zrixLbRx_t49YOHefjFxyLUc5mCXBPI-uSNJ_aWhF0VRbhXiaC5YRprOl_a708Suh02UidRlZnW83P5AuBQXOyxikRcR3xFP7pfH91q_TBJyHdD3gNWY6se-y4KIkk1OQYppu28qhDsYoDp2-3GFelaMX2slO5XsnOlT30bimEQm3QMtfjjC_v42DpaIz01FzQ7VZf8FSXyexFt-71tawQ6m9dvnMpw1e-edc-ov01hALOf1waQS7VQm_JCA-kZGxQHOpwandBFbIg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.34,
    6.79,
    6.36,
    7.65,
    1,
    8.28,
    7.5,
    8.69,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bright89-bangkok-rca',                                          -- slug
    'BRIGHT89 BANGKOK',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '29, 85 ซอย เพชรบุรี 47 บางกะปิ Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.7494081,                                                   -- latitude
    100.577154,                                                   -- longitude
    'https://maps.google.com/?cid=10125119595979766138&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJcdY5-wyf4jARenm4mqCmg4w',                                -- google_place_id
    '092 242 2626',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 8:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJcdY5-wyf4jARenm4mqCmg4w/photos/Ab43m-uh18LiSPA_pX40-ItTUY0cJXZF3jbUJpCRJSxWESeMMrB7eeEpfUwh24ekAh8c6B7IyMu5epYIGm-1WWin0FM-4cpfyLxvE2BM1zoG0H6nJywvjqdmxCNLzaNkLTq5e7W2opkXBtBSWZBowgeHgZT84PCF7lgdw4nyBZZFdpum-VSc-LQNsyNF6RF6m5E1ThzTv43NcHGnXQF9SkMjjBHypWjz0fU2tPJ0pSNdUNIE0sNM36-zhJH6UyyRPz3CpVSWDXxGbZm9CIp3bGHFSNFvdy7Vs5O2saAVCiQ_CGqTPzd5nVoyKU5Kw2xdAeD1TXgMIUYbkVqAbQelcxu3H1v3MBDrLN6qoJgvlItrgIM_Kp8LJnsd4LBs_L57xtWOrBCVip2jMj3lY2fKCnJokMbTM9cj--JZRRO9LsMSdk-pKg-L/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.36,
    8.63,
    6.3,
    6.01,
    1,
    7.54,
    7.5,
    7.43,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'route66-rca',                                          -- slug
    'Route66',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '29/33-48 Soi Soonvijai-Rama9 Rama 9 Road Bangkok, Bangkapi, แขวงบางกะปิ เขตห้วยขวาง กรุงเทพมหานคร 10310, Thailand',                     -- address
    13.751484399999999,                                                   -- latitude
    100.5753316,                                                   -- longitude
    'https://maps.google.com/?cid=10696069871793886312&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJszB0Zl-e4jARaFQI0eAScJQ',                                -- google_place_id
    NULL,                -- phone
    'http://www.route66club.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 9:00 PM – 4:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','popular','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJszB0Zl-e4jARaFQI0eAScJQ/photos/Ab43m-tl6co0gdZulQvO3nHGZaZMBxwvo-02KwdAjeV1XloLCShkuHKMdrzsaahvCHvIia4C4riXj37OjyBeO9upWGro-tjuwz4lrB8Mwxl-xjzNP9ltiHebzJcB6nhJxajKy2U3r8UDYp9dU6Fj-xWUvpC2DptHzLkP5z8SDfYDdVO3nxG2tiHH3Ac17n8SjMQUoV8890fnNAWmRLysl5hNMwN5DY7vAdzkUzs_IOiwO-MKD4Z9lj1X-ZFTJzYDt9bvPEu2kArKbDt_uh8-vI-3AaZ7rzzV53vYLISvN53Erw2zQNEUtL-3Qn0EXhin2L1nNsr3DQuGPyqaWCB7tItqYJZ8V8vBN4xhrVVg9gX2e6VHrfnkIqUVkmfa6f0tp7B-_S7JCnquELIYbujpLa8qY0nQtcLEXwjtGu11R2P6qJBnpVK3GZvOJudktvW7zTKf/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.9,
    7.36,
    5.98,
    8.09,
    1,
    7.77,
    7.5,
    8.71,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'yeheekorean-restaurant-and-bar-rca',                                          -- slug
    'Yehee예희Korean Restaurant and Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'rca'), -- area_id
    'rca',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '21, 70-72 Soi Phetchaburi 47, Bangkapi Khet Huai Khwang, Krung Thep Maha Nakhon 10310, Thailand',                     -- address
    13.751107099999999,                                                   -- latitude
    100.5759295,                                                   -- longitude
    'https://maps.google.com/?cid=8363674837917022732&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJazShVyef4jARDLrq0vO9EXQ',                                -- google_place_id
    '063 016 9000',                -- phone
    'https://web.facebook.com/YEHEE-104373359018642/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 10:00 PM – 6:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','rca'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJazShVyef4jARDLrq0vO9EXQ/photos/Ab43m-u0IqgX_p-C15_sw8igmagcGPxaDKNT_5RdTqrKDCA7GiYkdPzrkcQDI2LF6cJRkFsbisR_S3xlFlkxwC6rYiX3XuZMX3OAzN7cjFCecPSaGzcCz2zjj0MEBrS2b6xVA2WaDyLgt5fAiVMSx0vi5te80TDBxBbktxtI-QXSEY_wlRu0A5GvWXAAsrPhGo_CqruAWmPIcTty8-Ou5Niu5PrpA3SMHPUeJpxKHznQKuWxJo01-dyeXW3p7CLtOjhsU5bd5SyU01VyLoPLxDuU6dH_bqd1XJHarJP61EImL7yHFF_L3zHJW1k3eWPuihJHw9zstTDrwwmZGCyOzNJ48xqVBXcqzXUXsOY18yahJL8J2QxnXR6742U4S_p0t4e3sV02GFiHWlThNkIhpYEcaQPNdETfGa7fBJ6fFoPQ-A4hLQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.03,
    8.52,
    6.1,
    5.48,
    1.1,
    8.08,
    7.5,
    7,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'vol-de-nuit-the-hidden-bar-sathorn',                                          -- slug
    'Vol de Nuit, The Hidden Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '178, 1 Suanplu Road, Khwaeng Thung Maha Mek, Khet Sathon, Krung Thep Maha Nakhon 10240, Thailand',                     -- address
    13.7206175,                                                   -- latitude
    100.5376201,                                                   -- longitude
    'https://maps.google.com/?cid=15972352420414644551&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJxwxeU5Cf4jARR2EqtuYxqd0',                                -- google_place_id
    '084 950 3705',                -- phone
    'https://www.lenvolbkk.com/vol-de-nuit-bar',                               -- website
    NULL,                                                     -- instagram_handle
    '11:00 AM – 1:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJxwxeU5Cf4jARR2EqtuYxqd0/photos/Ab43m-s8ChFIpL3r6q_3-JrMtkMWqV9Wc9AacoYd77AQIjCxtYDgvtuUS1pBrRo6zw6zdzsa2Y2Il7_zw7gor6mhhz3eEmdvLoPDtJU53EQrxcXBE-QZNb_nTNz3C-zqAedXsjO7vCxJESfB3Rfw9B5JVPDmNNxZ8HeFpU5RiGMGu2chSt2RJQB-K8YpAGJ8ysiCiGDEFvu88iHYVS1YNXpqKpC0sRps3LaG_aqCCUTegO75cyarekzBF0qCTJQQriREjAmZHAW0EsW-WhiOdws1ATf8HGYM6iQ7_ZglB8gp097V-g/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.54,
    7.28,
    8.03,
    7.93,
    1,
    7.81,
    7.5,
    9.42,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'good-trouble-bar-sathorn',                                          -- slug
    'Good Trouble Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '50/3 Thanon Chuea Phloeng, Khwaeng Thung Maha Mek, Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.717281499999999,                                                   -- latitude
    100.5532262,                                                   -- longitude
    'https://maps.google.com/?cid=4184055439822636037&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ0V5WsK6f4jARBUQrI0HAEDo',                                -- google_place_id
    '061 414 4890',                -- phone
    'https://www.instagram.com/goodtrouble.bar',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ0V5WsK6f4jARBUQrI0HAEDo/photos/Ab43m-sWo_dsNboD3mKqIQWJ-4y3GuNC3YJviPSw24ih16NGdV10DefBG0-U2Hm9Xu2IkGPypEFtnEkO7jH3NxqeCu5wRUEjAYS2VcaeGwf0PmSPJzhO0_cRlsV2qhkUqXptuPhvahmkWlLNlWAt0pchaiLy3DwBUayPp2JIJmB9_br30h6PizBeXZS-8LudNLzAY5R8SQkvFYg8z5Iqpsqb3COk13UnqxB-6wqI3pX5fS3raxqYy_o3LQJqtVsRU5TPlT7x7HWEhMCt_HsM_XYrvPPYg3U0Y4DyvSIWv-bKTDF1sQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.36,
    7.12,
    8.4,
    5.96,
    1,
    8.3,
    7.5,
    7.74,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'novel-social-club-sathorn',                                          -- slug
    'Novel Social Club',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '3rd fl, Novel Supper Club, 105 Sathon Soi 12, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.723070100000001,                                                   -- latitude
    100.5259672,                                                   -- longitude
    'https://maps.google.com/?cid=13348241179373138094&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJBchSfwCZ4jARrvDGcKF6Prk',                                -- google_place_id
    NULL,                -- phone
    'https://www.instagram.com/novel.socialclub/',                               -- website
    NULL,                                                     -- instagram_handle
    NULL,                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJBchSfwCZ4jARrvDGcKF6Prk/photos/Ab43m-vmCdxKL8xSjBjIbcVTPwNr3lBE2OZ2MCkE2-Z8wzVdG7hkfvDOIjJsncHu_d2X0jIgPio1ULTwJpkLaelFzsV9FQrYpCEhnxHAaJjlQybCPwGHOya1NDOj0hiv0pEVxP7z1ct0iXO9cVBXQSvMAodktShITTIbrhI_vLkIG4cieGJE9SdcnfT-kSy26lJtSMiUy8AQqLmFQMUpY07RRX08fPhvlnshiiGSvMnsjfKHFKqlGBCpXftsWK9Ze10BzwGaoVam4ABITjIlqWi70TbA6uqYRJELeN0zjGRsbxA3t0IFTt_gKE24gFhJE1jHFpVh0fbNL4fQUpQ2vswigbYeiwGOFaDYJJ86XEVW1FBitSJvdP_sx_58zkyoibnxSVkFbZZJp0EK5V_RuBpPKX5DpMiDyDjfFOud5dAtSKQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.76,
    6.64,
    6.63,
    8.33,
    1,
    8.2,
    7.5,
    9.2,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'cork-sathorn',                                          -- slug
    'Cork',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Thanon Yen Akat, Khwaeng Chong Nonsi, Khet Yan Nawa, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.718928499999999,                                                   -- latitude
    100.5489274,                                                   -- longitude
    'https://maps.google.com/?cid=4115506875292465974&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ9Vzloz-f4jARNjt8vLI3HTk',                                -- google_place_id
    '094 360 6570',                -- phone
    'https://www.facebook.com/Corkandme',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:00 – 11:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ9Vzloz-f4jARNjt8vLI3HTk/photos/Ab43m-tkOG9vn4Pt0-7RApIWCQr-ANIpvTdRLuj9YUNfGyF3Ux6zkOTcSqvqprs2uL5Uz7fe6Dc5EkEtMpsLWQPXjtc4PISBMQFJbK3YaiZlxfCJH2S-t3P75WxOYEf28anNg_GclzCx6--QR-A7JSvsKaLVUeCogidaMVkfbJ1WZTDdkoQAqbjZCh2MCkjr50k8mbdQoYRiOM0hRKBxBcnPo48ikoe97maq8fMl3o1V2a9gH4riBrRSseLspipm0fapqmrLy9ViOyOOMniLyrtfSEeZq7Wio_5eSz46qP99e1jwHQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.71,
    6.69,
    8.55,
    5.84,
    1,
    8.35,
    7.5,
    7.84,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'ml-bkk-sathorn',                                          -- slug
    'mL BKK',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '63/737, Retail 09, LG Floor, Supalai Icon Sathorn, แขวงทุ่งมหาเมฆ เขตสาทร กรุงเทพมหานคร 10120, Thailand',                     -- address
    13.7236494,                                                   -- latitude
    100.5377493,                                                   -- longitude
    'https://maps.google.com/?cid=13558243284898240027&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJefNpREWf4jARG1av1m6OKLw',                                -- google_place_id
    '090 965 6566',                -- phone
    'https://www.mlbkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:30 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJefNpREWf4jARG1av1m6OKLw/photos/Ab43m-uXz2uzOW7rg58ULH3YEcihvWmzsif-iGt5OqLA912NHM11yPXQV8Xnt9j82yLYKpoobx4Xji5BzoxKxpomCQ_yz9wZmyw9pdD-VtOAbsoQOcg9juG9YCfM2imTF7Ikze5Ms5HQOU-LEfq_UIqWNpv7W9YsMR60t1e5KXWkH8nTDxtmM_fn2ONoubr7KJBW_YCiLZo3Xo5W94pQZ0fSbF97MKUWvk5QZw05jWe_32-SVU7M-cyLpBlldB_L2XO6DwurFSil07utebB4gJnn2Yg7MJ_UUSE2C4c-hV3p-PyMRg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.01,
    6.69,
    8.34,
    6.57,
    1,
    8.21,
    7.5,
    7.55,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'favbangkok-sathorn',                                          -- slug
    'Fav.Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2F, YJA Building, 23/13-14 Soi Sala Daeng 1 (Godche), Si Lom Subdistrict, ชั้น 2, 23/13-14 ซ. ศาลาแดง 1 แขวงสีลม เขตบางรัก กรุงเทพมหานคร 10500, Thailand',                     -- address
    13.725816799999999,                                                   -- latitude
    100.5391767,                                                   -- longitude
    'https://maps.google.com/?cid=17630796766803239394&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJee-JexSf4jAR4qFpWD8srfQ',                                -- google_place_id
    '093 760 3269',                -- phone
    'https://favbkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJee-JexSf4jAR4qFpWD8srfQ/photos/Ab43m-sReV4kAHKGhP1UWHlT7_vg4T6nlT0rmBYsIe3zFkoc0wI43Seho3qTrWw1cPQPTgRxEf4s7frieRsTg_PuVEYV3dPTjlI3q535D50pGfilMGMXHA1be0S6NgjlRWea9FVUGVWuIwBC-NtFq1zEMja8HWrW-VOxAMtap0nE05js_dvlYtv3vc8VwT7jMqW32oZGfYsMgu1cJv2oZ2HjKcOQ7NDqvPXHkkryNDW8HlYmsLia4wR_eIrZaaznfQ0wlG5BnjXSxvw3nNsoXlvqMUSxh1RJz5Dk9zFFAPxZO_wYwg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.28,
    6.52,
    8.29,
    6.19,
    1,
    7.52,
    7.5,
    7.52,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'blue-district-rooftop-bar-sathorn',                                          -- slug
    'Blue District Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '38th Floor JC Kevin Sathorn Bangkok Hotel Yannawa Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.7162806,                                                   -- latitude
    100.5315648,                                                   -- longitude
    'https://maps.google.com/?cid=4659710376260551644&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJL4m9-TOf4jAR3EM2JeadqkA',                                -- google_place_id
    '099 289 5987',                -- phone
    'https://www.facebook.com/bluedistrictbar',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJL4m9-TOf4jAR3EM2JeadqkA/photos/Ab43m-vkWgrUaAzUCkg9UObgnmOOQ4ewtx3oRmlOTddVgwv456CKWUzZ2bFYQceBF1bfjNf8lUa-7s2MANG-LYGfkVrBoVR_egiL0deLr4hMfGavVj6bEQy5wzMYhTyWLxhZi-azh9y51xc2lAJyCPhbeKGVA_CGAAjZhAXV-hMhAvgcdBEwFA8Nn1inRaNlIIclq5Hk2_d7BYcmTTCxr04Ht5pX26bZ1SZYjJNPx5Bm-wmwcXhPbK0P5cJm3VuSXIrUObnNuaXpdZ-1vEshJ-cA9NlhBYCG88AvV_KIh_TKdhXw_Q/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.68,
    6.55,
    8.98,
    6.19,
    1,
    7.89,
    7.5,
    8.36,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'on-top-rooftop-bar-sathorn',                                          -- slug
    'On Top Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '5th floor, 53 Charoen Krung 50 Alley, Bangrak, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.719508,                                                   -- latitude
    100.5140461,                                                   -- longitude
    'https://maps.google.com/?cid=10530934573658957349&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJifmbDACZ4jARJWbSDzNlJZI',                                -- google_place_id
    '081 770 0779',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJifmbDACZ4jARJWbSDzNlJZI/photos/Ab43m-slTSf4Yc1M1GTay7S2Wq0iVkmUJcuwBmSiCOklou8LK5VmCu3CwuG7XcYsXRkGBGSbfv1C6k2hOZvkckFCmn2Ugj4UgUxUU5Q_0NkVmF4ghCy4iwiyqeOy4So6-5VoKCH1tyZsnnXYRVywskZkjtPMPuSbOVrbF9pNn5sR84hiKc7CTUUa9KIHVRqCbPha99E8xemstXVN0jfME_4jzSH86WT5ecT4e5rG7oEcgjN4UUUJIZxahGQtOAk_PRSUqJ4LggKZX1GAtyI7tNv-emLKyTQ2V1fgnqQ4gemsKCL5z3fTfX2XseoBAoH9hm99s9HYIoetIMFtJrgOiTXbq87-RBazTNGSOYqfRPkcNBGOK2jqtOTO0Owi5ght7UwYq5-N6Oaj2XbCZYQjtodkReRic2EnFyTVyBoajKs9y4R6W1aUESkotpsw7AYSXOMz/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.27,
    7.27,
    9.03,
    8.34,
    1,
    7.55,
    7.5,
    9.04,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    '360-walk-in-cafe-rooftop-bar-sathorn',                                          -- slug
    '360 Walk In Cafe Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'PG8C+F7G, Yan Nawa, Sathon, Bangkok 10120, Thailand',                     -- address
    13.7161963,                                                   -- latitude
    100.5206936,                                                   -- longitude
    'https://maps.google.com/?cid=17073182528074239247&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJocr4EiKZ4jARD01FOw0h8Ow',                                -- google_place_id
    '086 309 9578',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJocr4EiKZ4jARD01FOw0h8Ow/photos/Ab43m-ud3oR_vhsI0Hk2MI_9cjpR6twkgBWeTZvI1naviJeVHE5Wxte-Q3qRH9ClqcR208q2HalL0LotCWjhklhgUacXyVXwcY0VlkuF_Z7urR6CHCIH6IxJclmZx17OvN7Lxb44sdLi2uDoGS3pZ0JgdqAkAqqCQJk1JTOfoByiZwLrD56l6Ts03RQ2XkODo38z2hr1ewryZg4sNl4KDy8iuVLAGRBFyqWFQseRKnehmSLao2kbTwQ-dD39U_B_jk17ly831pKOvS8Xsw3w-4Gbblq0ugY98weamoUttgK60LTbSzF2RvToEnknxhTs0bylfWVxOZ6jO6ycP6bPXFkLx_PUbg5m4OHzKVbBHJ2_2T5GJxe0KhxSJmnrLhlFgTStJuznTU2makjPR5igYXrw0Q-Mw1yyw_LO5wj8HPbiaX-ipz0qrK0hxtMagbWZjQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.47,
    7.22,
    9.4,
    5.82,
    1,
    8.48,
    7.5,
    8.03,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bkk-social-club-sathorn',                                          -- slug
    'BKK Social Club',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '300/1 ถ. เจริญกรุง Khwaeng Yan Nawa, Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.712043699999999,                                                   -- latitude
    100.51034039999999,                                                   -- longitude
    'https://maps.google.com/?cid=5671275126741176445&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJLwlh74qZ4jARfZDqGK5qtE4',                                -- google_place_id
    '02 032 0888',                -- phone
    'https://www.fourseasons.com/bangkok/dining/lounges/bkk-social-club/?utm_source=google&utm_medium=organicsearch&utm_campaign=tor-ban-fab-mid-seo-na&utm_content=na-na&utm_term=na',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJLwlh74qZ4jARfZDqGK5qtE4/photos/Ab43m-vn-FxextQoCmDpvAIPFI4bLYX3zJdKBeZ5_ITh7929FKAe1k9B3Qill9qablGVDB41lt5ASkTvyR79M41uS9dtyj7k6dSnnXn5psOYaE2zc82DjuyWXk2yIZRLdhkd5p6COHggsIxjyN3yPvnAHzfpaXcQIjgwT5LXWnVYYS3Wf-HcIlxyq1N3rc6hC6r8g8xT7HjBsgvs6ifSUQzBatHZEbt4nR4uFxM156NKAFQOaRQMgD5NRIDIpWftRt0T1e4cdrEOxFbIrQHB3jpYxX_72ozynMJo-rhnuMtznypoeQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.55,
    7.23,
    8.43,
    8.25,
    1,
    8.29,
    7.5,
    9.42,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'secret-barsathorn-sathorn',                                          -- slug
    'Secret Bar@Sathorn',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '27, HAP@Sathorn Hotel 23 Soi Si Bamphen, Khwaeng Thung Maha Mek, Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.7201957,                                                   -- latitude
    100.5481509,                                                   -- longitude
    'https://maps.google.com/?cid=2119003978672591731&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJgVVv3byf4jARc1NrQuQ2aB0',                                -- google_place_id
    '092 698 9745',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJgVVv3byf4jARc1NrQuQ2aB0/photos/Ab43m-ucpEUI2Bt6FFfezEw5oK61gzMKFnzgkbmlg8B2fE-hNj4vxLvRsKzOFChmJGZe3cBS_1tHD_E1bg4C_MzZB9C6E-Ohz9c5BBfJ8NUKndSaT39KTZkSab1lRBZLwPVzN38HIe8ilTOm2yZUtTxk3nW8KPWQUXCVD-m-JkGzxERMk25g7x6_l0w-EB2fBeokvGzfDJhZZfgWTaqhE0lKe28PEURqEFB1IIn-bZ28hEBkdNM8BBvQKRExVx7H6CJz1BY0FUGTf5PyHLupyAe6GVXWUdHLrtT8MqPRbVHPZnKOKw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.99,
    7.09,
    8.45,
    6.47,
    1,
    8.33,
    7.5,
    7.55,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'mayraya-sathorn',                                          -- slug
    'Mayraya',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '88 Soi Sathon 1, Khwaeng Thung Maha Mek, Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.723162199999999,                                                   -- latitude
    100.5445603,                                                   -- longitude
    'https://maps.google.com/?cid=17325308573586803958&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJMegoYpqf4jAR9syrsFrcb_A',                                -- google_place_id
    '02 821 3888',                -- phone
    'http://www.villadeva.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 10:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJMegoYpqf4jAR9syrsFrcb_A/photos/Ab43m-vITULgXoz3jR-Xf_kqTiMK96wZ0W-HW37gl43zKfZcIGCO1FwuQj6QdhZQknWNJvLof9Wl1vv92mXTPXZghqsZcdc9acO_sJ9m7KKBJeBr22wUfbeZ425de1qaOnWwHjVi8DJ1Z6B-FDahh7vItlTutz81h635vW3u3MEx-mhBu86T6hr8v2CMZeSeI7DaciLiHZ75ahHToouMOUoKywNW6u_Gv2ruckgalSV_8oHfrTNqy54utSFg-QKI1uKmYeTdT_uxukO5w9hg306qpiNGX4vFC8QJzMwG_Hq-j5KwXA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.11,
    6.79,
    8.39,
    5.77,
    1,
    8.35,
    7.5,
    7.67,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'q-bar-sathon-sathorn',                                          -- slug
    'Q Bar Sathon',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '186 Soi Suanplu, Khwaeng Thung Maha Mek, Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.7205578,                                                   -- latitude
    100.53765279999999,                                                   -- longitude
    'https://maps.google.com/?cid=16774541285364461427&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJYy4yGQCf4jARc-9FeGwky-g',                                -- google_place_id
    '062 958 5981',                -- phone
    'https://www.facebook.com/Qbarsathon',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJYy4yGQCf4jARc-9FeGwky-g/photos/Ab43m-uTck6PnBTvk23nmk2eA6kA64UvjwoO9ZUSVsPaeoG270qp7ZiZYzhKhpI7Mef77KYq3GKLxrZ7uOwj5pVI-xfocPAtOf4sYfAb0BzVbhKo3PQYqmRunkszgE9OJ09OhvXitJBBF_wQ0VPZUj59uHvReL6z2yljKrbZzM27DJMLPxnmms27Y8y1uS5lSw-nHarBFIpxmyEoSlwDmK0hUSg6MVx3u7c4ieNoIwtT8zEV4DMJgO5hSUNrMQ1Z-5D2dnoZq0su2KAJxgavMO3EHh0C3kXH0DqGKe-GzN_QVMmlcw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.15,
    6.98,
    8.52,
    5.99,
    1,
    8.27,
    7.5,
    8.07,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'utopia-bangkok-tarotwine-sathorn',                                          -- slug
    'UTOPIA Bangkok Tarot&Wine',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '23, 10 Soi Si Bamphen, Khwaeng Thung Maha Mek, Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.7205408,                                                   -- latitude
    100.5477233,                                                   -- longitude
    'https://maps.google.com/?cid=1955066296830742588&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ-0ALlxef4jARPFDvRnDKIRs',                                -- google_place_id
    '080 924 6399',                -- phone
    'https://www.facebook.com/profile.php?id=61566907675371&mibextid=kFxxJD',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ-0ALlxef4jARPFDvRnDKIRs/photos/Ab43m-uylNsCgmBZ8IYzMplYY2Y04NK0t_gB89kGkObaVK1JkFIOD3p6aZaHC5_lQ-nvWxY049Z559sA8B4th9K-9okZ0MclOtB-tSC0eBpyF4FskmtefspVn7cYWJTmArxuOLV0E2QzX5KKDLxtTuKM3MGGkEIBt8d3O8qmKKmOWYaMKK4rqQn_YvvBBfB1Sa9haH0N6LVn6GrbHHt42PF4eiKGlf-4bpF8os9fQE0N7LZRIsk-OO6cHc08cEsRq-SpUdJ5Wtc7XGfMpbATXC5vRnSAfZmJgttANY_VqoZ9Ggioi5ECAvz5TFKkIxkd5rTXYhGVqh9yAQGpISMAJk4ilSksiVPPXWJWHUA93TXhW-zjXMCDl5bBsh6WP4Bo7XvLP_yX2xxv3ebua2VO_ljSRqCyiW_hfAd9i9fsFnhKEzFjM5I/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.34,
    7.26,
    8.18,
    6.4,
    1,
    8.03,
    7.5,
    7.46,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'raylist-rooftop-bar-sathorn',                                          -- slug
    'Raylist Rooftop & Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'โครงการ Vanilla Moon, 265 ถนน จันทร์ Khwaeng Wat Phraya Krai, Khet Bang Kho Laem, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.7065309,                                                   -- latitude
    100.52170609999999,                                                   -- longitude
    'https://maps.google.com/?cid=12675761226767456663&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJCdgmEnCZ4jARl9kkO61Z6a8',                                -- google_place_id
    '093 510 9091',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:30 PM – 1:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJCdgmEnCZ4jARl9kkO61Z6a8/photos/Ab43m-srP0mO85wj65wuYJJk0QuX8mf-skpC-EtcG5GeBy_5diONSq5q3kJtvGYJv0jHlFdJLKtK0Lv9rNO1dk3UX0KzXdWGPj1OC8-ayphVuClqfX6TJLZsD6hawYRGkDoGNQjwNxyjvBjQj-qOconlCze96ipcTM_2ECla4XDREIM9GnxlmJz93DjVhcdvquJg-3jYTQPXL-bKIp06jP-cQu9bF0oNxpmlpZV-XuFX31qxnwKMEILwG7TLBDT2A6AMXmG0qKpXvi_e7pcmPkKl_dpuWSorbRROs2EFk7eG4bislA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.98,
    7.14,
    9.65,
    6.11,
    1,
    7.9,
    7.5,
    8.14,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bar-sathon-11-art-space-sathorn',                                          -- slug
    'BAR @ sathon 11 Art Space',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '288 3 ซอย สาธร 11 Khwaeng Thung Wat Don, Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.7134214,                                                   -- latitude
    100.527536,                                                   -- longitude
    'https://maps.google.com/?cid=6907077451104392259&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJqZyz9n6Z4jARQxQwtVje2l8',                                -- google_place_id
    '02 004 1199',                -- phone
    'https://www.facebook.com/sathorn11artspace/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJqZyz9n6Z4jARQxQwtVje2l8/photos/Ab43m-uVk2aHkSlk_rPGUR7a2mfW3Saml4aH6DsQ3bHOWCSJcltfO6-zEnZ5q-uIz74d_EcB6419KFdSBxocO5GeWL9n4nF05NKFboi14cYf7WjM1N9bX7A7FSaz0JBpRY0xxPOTc5c5WPhUTXDl8SXYDdl685gZLLq5mcZVgq1vGNnjnXBjCcWGi8zGPX3NMt-PegKL8p1hB9N2ustqBgRoSAENBdTUwXGeifBViOwL_LQFKqnNjBYKI4MGmmU4XXoaoV_J64w3AwfcanEdmX_-CTXBncZWEM-78zcDk-CLDQmDfJ1Wj8Ok3Z_sSxA92jwnJeloPVSn_C4YmYt6VKbm1MVt9V7bZ5qrx5sQw4FuRGRI3LSRwjyaj7UT7lJ2uzCBLl1t1Ao8aWZ8GDtzJ-Zefm7H2mEjU5NG19VpFwq8IEYm4uZLb5eTDYGd9t4i3BLT/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.04,
    6.59,
    8.56,
    6.39,
    1,
    8.16,
    7.5,
    7.8,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-house-on-sathorn-sathorn',                                          -- slug
    'The House on Sathorn',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '106, 108 N Sathon Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.722108299999999,                                                   -- latitude
    100.5289705,                                                   -- longitude
    'https://maps.google.com/?cid=5658457144605883516&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJDye2Rc2Y4jARfDwBEcvghk4',                                -- google_place_id
    '02 344 4025',                -- phone
    'http://www.thehouseonsathorn.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 12:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','premium','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJDye2Rc2Y4jARfDwBEcvghk4/photos/Ab43m-twHo8o0wuUQpzYHH2LrhUADcrhwYyZOh9iKYtndzFN2RLQKmI-9kz5BtDMci3nRh9zH8E5btS496SapsS9K3Dpx9NNcVKSdva7R_4p6VOUZY9Q8CDgWed9pyY-KFSSlEvG8SJ8aphXu9XyokSVWFkp2BA1YdHTz5d_HLvnEMsENSd3nQKm9QH8Q_s5h30j0w0MPtF1BqFGEKvUy7KdFtXJlx2q9VbT7SfKEQKotxnDFyv3OhiWKJxd_hacY1aupiIHajTalGUH-HoDPpBb0otinWwagihtkbwblA4p7Es4rmUHXbvneyGK_4fNofXlZ-gjqsMTWeUH-Z6ISOx8iubYzldAoWxLZEpOdsy0-Mx2WU_C4AhZ6IAW2Icp6NFsUyo1V5EcCCULfpSgAZDkteAnUIQSiUvzR4KyRz1fQXhLRWagG4QSJC9YGE0-GxGd/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.37,
    6.87,
    6.42,
    8.42,
    1,
    6.8,
    7.5,
    9.32,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'r-b-karaoke-sathorn',                                          -- slug
    'R & B Karaoke',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1124 2 ซอย นราธิวาสฯ 9 Khwaeng Thung Maha Mek, Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.718313799999999,                                                   -- latitude
    100.53243210000001,                                                   -- longitude
    'https://maps.google.com/?cid=12697029023756685551&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJXf43R66f4jAR75DXF6DoNLA',                                -- google_place_id
    '02 675 4224',                -- phone
    'http://www.karaoke.co.th/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','premium','popular','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJXf43R66f4jAR75DXF6DoNLA/photos/Ab43m-sCpif-IWjbtO5A4N8qqmwoG9cRWheLMuKfZ1H3dndlXVX2WbMxsUX1FF1D36a-KioO7RUabI30NX08l7gpqvzpGBN49hYQXngI10igCC3zLxq5zLur_HPcbHlTRnP4pGy3b7_H2sfkoiIXUJfZXTMhTNBPl-vuEdueqELL1eaaebPBXZWZzk4KreYWjeVEfDXMGMixEF0Drp670oYcOUiIjwp3dagthUibVTFRvNs_9reI5Vdghx2abua68f4N8exu4blz8gAiKnk7MnN7DcoW2s0ErdWOTfaqfCorH-j9vyLJ6pKmivcnFF7A8mv2KB44g6ALT1_6vKvF4pNWoXGf7PJ4owaK6QK3FStVzyxL3Pasmsb70Fpd9V9FvUOyiUjqHuNNo_kVI-WyyZM-1Zr1EzWstkTNArbjz-d89rBqvO86T66-377D3nIwu8xC/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.55,
    7.44,
    6.27,
    7.82,
    1,
    6.54,
    7.5,
    8.87,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'ea-rooftop-at-the-empire-sathorn',                                          -- slug
    'EA Rooftop at The Empire',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '55th - 58th Floor, The Empire, S Sathon Rd, Yannawa, Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.7205344,                                                   -- latitude
    100.5302284,                                                   -- longitude
    'https://maps.google.com/?cid=10372454611716301891&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJO2o-hfaZ4jARQ2Q2hINc8o8',                                -- google_place_id
    '02 407 1654',                -- phone
    'https://www.empirebuilding.co/en/ea',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:30 AM – 2:30 PM, 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJO2o-hfaZ4jARQ2Q2hINc8o8/photos/Ab43m-uQIZ6ZxoBR2eHmZHBZFisIXEb9NMTdtsLnN18IjXQvlEBxrqaxXh_ohp3Cnd4r_5BH65pTnZIA_cBC57wxg6B8297ZAdf9jzK46l3HhZXPhFHElh376fMpdRAzUEUfjn6ZCMnXxpIdvHDsIErYvt2WBkdaHhFNF64GI92Tmgeibk7a-dJMac-RjisiAqfOVw8Su3JRg243fCvnLAyCdHnnEraEmLkgqzJF7DPAq1JABGLaLCX5PMWEPWxUgNWgFAJWHfOHrHpEL3Q7muIFdeaPTof35r7N0KSlH9Enww7AEZS9MjoAK9t7QRuRwb699mDaaCa3GWg_gps_-h9ao8fyZp0RMTwPhVBkxp0fi25M7yvtUQteuDKhaoZNqX5kK6o4RFUD_FDvdK3ec5S-tsujYCS4PQiYY71DCgsPkS8/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.11,
    7.07,
    8.97,
    5.69,
    1,
    7.85,
    7.5,
    8.32,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'moon-bar-sathorn',                                          -- slug
    'Moon Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '61st floor 21/100 100 S Sathon Rd, Khwaeng Thung Maha Mek, Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.723595099999999,                                                   -- latitude
    100.53990329999999,                                                   -- longitude
    'https://maps.google.com/?cid=13934069859019558035&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ-SW36y-f4jARk4xW_rXCX8E',                                -- google_place_id
    '02 679 1200',                -- phone
    'https://www.banyantree.com/thailand/bangkok/dining/moon-bar',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ-SW36y-f4jARk4xW_rXCX8E/photos/Ab43m-sG4MLtDEA2Skw86T35VpAkjJqzyWv8B1kYvrIFER4hHSFRV6fk_dI8CJptbBNlOywXv7J2s8AKAGJWf4x5xJGDzsQsm0CMSt7bNN8Q7wSF4JDOnsyDIyXTBFyAAshtdBHLfCXHE6E-23gxyJZkFn6afLCqi7o4uGuc338CAmMahH89D-e7jrGb8X42IqrtWm_9ZnjcNWToLzKOR2nS7G7RQ-U6EmFO31Inds7xVepHuNclobvGZebf08cDNLDb8Lg5rHGdHZCSOuDtpaXoTHFEuKw9JJaQoZa9qIs4aGitCFgO8loM5Y6j5ndJtM3HlKSZshoIoQCpGMiJK5I-hcSZCjzQx9xzJYwwXggxWZYPHEM50qWjpDPe8jFddbp8lh40y2avIjN7jaR-WPs5L-J0a8rnZT0oQjUFC4ysjsaiX7WDABX5BJOt5OSckFvj/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.33,
    6.52,
    9.21,
    5.96,
    1,
    7.62,
    7.5,
    7.73,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'vogue-lounge-sathorn',                                          -- slug
    'Vogue Lounge',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'MahaNakhon CUBE 96 Thanon Naradhiwat Rajanagarindra, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7239053,                                                   -- latitude
    100.5286479,                                                   -- longitude
    'https://maps.google.com/?cid=13526349790504332273&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJn1UG5c6Y4jAR8auwAng_t7s',                                -- google_place_id
    '02 001 0697',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJn1UG5c6Y4jAR8auwAng_t7s/photos/Ab43m-sWEEe6T_KJ7y47pRrESiMxtR_-6VIbK1JlPk0h8S6UolB6BDaAhIjy8iBwALxM305KSjYdiWZgWHVfLI3w-fJW4rxBPXilUigHSfT_3K2wQi_rsLiCh6Uoq6C4K3PNE48Ay5LvGu1dAeBf_hwtXv5QpI35AHpjbkX3sYNyvwjcuYmKDC2R_UksOb5oau_ZsACnuk5zVEBs2On0WOwjT3UErGTLyePVxlkh5oQxV9MP9hqyZYmmOyaW03cmXpQxebpkqjinKkBv5SaD12_hEtOc28qsalpt15Mp0oU-niCOELFO9JuUEF3QaD45sDE5CEQwk3ESKNlZ5m2A_SrssHg62Wv3tQm9HFc_H3DKuKD89piCbOfk4iDgbGAM5drGVWL9alUqNdfeBpgeh6k4OzlsVszlXc6DQ9-jVNZEhKf9MdTC/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.83,
    7.01,
    5.71,
    7.76,
    1,
    7.96,
    7.5,
    8.71,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'junker-and-bar-sathorn',                                          -- slug
    'Junker and Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Thanon Suan Phlu, Khwaeng Thung Maha Mek, Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.720282699999998,                                                   -- latitude
    100.5378028,                                                   -- longitude
    'https://maps.google.com/?cid=8624711539768590473&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJFY-mqzGf4jARiYAeInMhsXc',                                -- google_place_id
    '085 100 3608',                -- phone
    'https://m.facebook.com/JUNKER-AND-BAR-438784702897580/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 3:30 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJFY-mqzGf4jARiYAeInMhsXc/photos/Ab43m-tNd3IQY6PvvEvC5Fj44FzEjlN5wfZ_Smgu_WsCqYvxB_0Ev8myXo6TjKPamlZYbAYf3HQetHHT7Oqp8J5frGUb6Y6qkYM5e2TfSxDwtEiNKmn7lyQmTOsMQ_RPuDB8OSERFsXbylnQgBaTHJofZCPVVN5x0K4CwpwraZv8C91QCc45HXOIzhQ_x0iGX9A9kWgrx6NisgcZzpA9gMrHFP9mxKQF2SCB7MjsuyM_HT3qxn3Xem0Vcz6OPOVDdwrkbKKlTxgRMh3bD9auNcfjfFFU8lnO3_Fo0a4Km-p3_-l6COir-ZVF23JwyHO4sN17LGA8IbXTRpClk0n26f0KxUDjZcjFGnk1JpwHyO7ikEomqptYZNnGFWlSPfm31RrsvIUMcgV6zXPLnvYMHlnc8JyNaAWl3U1JiZBZVDNf873bwA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.18,
    6.57,
    6.24,
    7.96,
    1,
    8.17,
    7.5,
    8.88,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-roof-38th-bar-sathorn',                                          -- slug
    'The Roof @ 38th Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'sathorn'), -- area_id
    'sathorn',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'BM 144 N Sathon Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.719758599999999,                                                   -- latitude
    100.5216746,                                                   -- longitude
    'https://maps.google.com/?cid=4147466485468539114&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJTwpu786Y4jAR6qgwWMvCjjk',                                -- google_place_id
    NULL,                -- phone
    'http://www.modesathorn.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','premium','sathorn'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJTwpu786Y4jAR6qgwWMvCjjk/photos/Ab43m-sEf4-eVUqBlz4E1VgDRZsk6JGWlZSEe4KMR2kasxJVNFMukgR1i1c6kmSzApI43CIggqxPio9T_a2cxKSW5ZH0aDeVwwvRsqE6LczsEzbPeIYLnyca0kGkHZfW1jsQ0c_hXb34X5DBHhsDAMOlF_LR6V-uMGhZw6TdvhxPbjz9u4YVgw3i8tDu468uT1W_eaiVxXFjOIgl1FI2md9InM1dJFnsGeEB2Ujaz_Jxzkw6IaczN6QieClh__64o4YrNI1RH-BbYgXMlfQKNs5Lls5G6LH8vHFowgGSfKlSnm0KnvXmnoGu9tnSu6OK0beJ3DI2MkfkErYNcxhE39exCHTFo0ytHJ_tkvakukhxob3SPQBwjfM3jzTybs6jv9ZvJFFmfOQmrlS6RJAbuSetaK87c6DfXsT_9QhAk_fcV3VRcg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.59,
    7.14,
    8.68,
    6.2,
    1.1,
    6.6,
    7.5,
    7.49,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'heka-bangkok-silom',                                          -- slug
    'HEKA Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '320 Hilton Garden Inn Bangkok Silom Building Silom Road, Suriya Wong Subdistrict, แขวงสุริยวงศ์ เขตบางรัก กรุงเทพมหานคร 10500, Thailand',                     -- address
    13.723082499999999,                                                   -- latitude
    100.51848269999999,                                                   -- longitude
    'https://maps.google.com/?cid=12337715776853068926&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ6fTp2buf4jARfkwPiyFfOKs',                                -- google_place_id
    '088 627 7346',                -- phone
    'https://www.instagram.com/hekabangkok/',                               -- website
    NULL,                                                     -- instagram_handle
    '8:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ6fTp2buf4jARfkwPiyFfOKs/photos/Ab43m-uDzz2tv-uAt__jXAZtnZGrc_ZPx2q2amNRnFjgmGoKjFlG0s1xUiIsG3Vln4FqRvCQmjXWQCpcmNbA8IAWHfGsWpuvxcZ3ffWrbgq9V3HwVl_gXSdH3giTdna7UBB_PG6_mbMmZo2GJSzLKhE-ji8foMqbGBhbQ-S2shxE2Npr1oepdli6zWBpGm94muiKInObgLnubgatz1jEw8yPbi84GJTDvj8A5gltSsqv0Nqsl-lnmP6xd5DYQ_mCLPX-0luVRQDhr84KgmlkgNbfwA0bGz2XkOiwfA9t5uaO3EzFp4UZEj3Ics_q6sUdRBYXLV_Zn99DDKUxwpenTpfTHLm-wVVtgJ8EyChHzsfVwQIxEBOgLu3qmgo8HtlLuol7nQ4wpLruJOsoWuXKWzKRUaAFI9hXMvIaiMVScmxdkPMbBBg8vwME0oW82NmmP7Gs/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.42,
    6.64,
    8.08,
    5.88,
    1,
    7.92,
    8.5,
    7.71,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'omg-bar-bangkok-silom',                                          -- slug
    'OMG Bar Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '116 Thanon Sala Daeng, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.727017499999999,                                                   -- latitude
    100.5361719,                                                   -- longitude
    'https://maps.google.com/?cid=16018870906608295921&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJV0jqWQCf4jAR8R86yzd2Tt4',                                -- google_place_id
    '064 878 9293',                -- phone
    'https://www.instagram.com/omgbarbangkok/',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJV0jqWQCf4jAR8R86yzd2Tt4/photos/Ab43m-tbakb6fOFo6KTdJ0VtUk5zUFSALLKoH5SkvD0bDU-LGnuGrmReL3SHhCvcwxOmCJv4OL4Ne6H0O7mopLpej9_RjVxqAfmIWqlP93P7rlAbQV_ATA3tfWti4FXSyMmgeouHUk8utsljNsl7_AUM3VkIph8ugL-U7_mQscGAVcHB7tQ8w_-4ZwMLofW36hppm_jGLZs3y9OIeaQL5fEk2c7_pXDgki_tRA84WDcV2jilXtnCZPxxlnPBuxRbeOsfdQ64iCUkaCqWraxhqRpK2ptXW8ghAUpFEA-RVCUJpAjRyvyQ9be_mYXj3bD0EoXkgC8XvDGdmiW3z2fee4aQcRE_fW27tK34PSQJse1AcMnGye09MvK10P6khok8IcsYxrYviNiRELbbqxyY5lMazz4Nq5_wKMOAV9Fp1vgfEVc/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.48,
    7.22,
    8.11,
    6.52,
    1,
    8.33,
    8.5,
    7.89,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'amorous-bar-caf-silom',                                          -- slug
    'Amorous Bar & Café',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2, 3 Si Lom Rd, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.725853100000002,                                                   -- latitude
    100.5264519,                                                   -- longitude
    'https://maps.google.com/?cid=1554753250865035775&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJxXI7SYyZ4jAR_7kxH9iXkxU',                                -- google_place_id
    '096 169 1609',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 8:00 AM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJxXI7SYyZ4jAR_7kxH9iXkxU/photos/Ab43m-veuUAJCArB41CoeJUocnXK474iWPfI6TfihPGDSDqDP8QPsN3_4qgfdnOV9wX1DIUJVBc1sZ0p2fgO5LwscXGpqljwyZSxsu_2vNpnwhKuYVj5WJinTI9NXqOU6JfArwA55Vi-bRYZlipzzgniIevTPoeSlAemo1RRlds1kPrBM1YSTkcf0MAEgXfo-YKL9GvTmjKHvOfleB4WkyZUtxQZ2lVifwHp9KD7RpvXkNhYtQsMn_N9ceW-u3byjYlNPOeBQzFNmy4f79dV5b_R2AYpybwZxtYaWgEeahLoZHdO_A/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.26,
    7.27,
    8.36,
    6.01,
    1,
    7.6,
    8.5,
    7.66,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    '4-hi-music-bar-silom',                                          -- slug
    '4 Hi Music Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '16 Soi Charoen Krung 46, Bangrak, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7202988,                                                   -- latitude
    100.5153435,                                                   -- longitude
    'https://maps.google.com/?cid=10504584504014424650&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ_4p0VsyZ4jARSkraYvPHx5E',                                -- google_place_id
    '086 902 1264',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    '8:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ_4p0VsyZ4jARSkraYvPHx5E/photos/Ab43m-v02acebzKx9DexiKNSLfLvkqxmynzPfibAg8TCuU9r23bTI2FDTGeZgyD4GYSZ0lpHLBp0Zxq-mTZyFGnAyFJIAp-ciEA4hophQQk4z5mK19a1SQBfJpYrhDxYJI-Dz85MsxGCrLoa6qgBJktvjp-Cy8B3dvTjQOEJvOAmw_LIz7sldCRHcGy6Fwr9_cH_RqwIrWUFptu1z83VSu1Mt0D81aU-0M4-Ti_wbPSdjb9Ot9KPEtExbIzHHyWVZvU4J5BIbNQWkIudYz8YrQMiiEOlZRIqlFk7QmyJyRAtYBxzOk4wiQxgg6phw5QYtONNjo8cclz7JZwKb3vRSQWHs0W2ROsH2O0VSOlzRwd8m5O4UUGw5Y8bqrNUFwnV8bCNg76dIGdAZ9YayzwGiHFYzHEDYW2YZlba8ZU9rRYQdytntEiQoZBFNSesxc7LcA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.12,
    6.88,
    6.46,
    8.94,
    1,
    8.32,
    8.5,
    8.19,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'wine-climats-silom',                                          -- slug
    'Wine Climats',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2nd Floor, 281/16 Si Lom Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.728019900000001,                                                   -- latitude
    100.53396839999999,                                                   -- longitude
    'https://maps.google.com/?cid=6523480062115493114&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJbz-r6_ef4jAR-rS8uY0OiFo',                                -- google_place_id
    '093 914 9144',                -- phone
    'http://www.wineclimats.com/',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 – 11:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJbz-r6_ef4jAR-rS8uY0OiFo/photos/Ab43m-uHzQmF1nVgCXTChdWiF6SEFDWJj7VeDnFrKBmhTZRIuL1jwGSGVygiVWDhqmN4T1d6O5mMRqsUBTOjRzhBHUPgDvlHDWepTArnGcVRnw0Q3l2EpqL4qhE6RzcTfULc1SRV6cD6NEb-4-GZmejPHMUGSclVUyViTlTqTBU88kp9Ij92xf1CKHdfIfMnJfrwmbnVDzyP9WFPtOUsihZY76Aco6iRKZQgTy9DHrXgWQwejqB74lKmOhPMPKTkwlTrMWfektGeGAjemNAHA9y9R2U4EGUGr7HIWKvnT8tNoye3qw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.44,
    7.23,
    8.02,
    6.36,
    1,
    7.96,
    8.5,
    7.8,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'novel-supper-club-silom',                                          -- slug
    'Novel Supper Club',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '105 Sathon Soi 12, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.723070100000001,                                                   -- latitude
    100.5259672,                                                   -- longitude
    'https://maps.google.com/?cid=8145672339079395640&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJUQ_P3j-Z4jAROHmNs9U9C3E',                                -- google_place_id
    '062 642 6269',                -- phone
    'https://linktr.ee/novel.supperclub',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJUQ_P3j-Z4jAROHmNs9U9C3E/photos/Ab43m-tjBOTLcBldcL01bGbZeBhE9Gd6mC7EqHqrM0Vvzhne1SS7hAHpiw50lOujUbo6tTpf0DIEfCGncBDOIwuwpdAfSk-PrJE7ugK63V8xahF3sOW_hpaUZCU7FfzVwjwvU9kv0BdEUWS4DoCLO9H91A4xsmonPBCx8fZkSc5XmgX-7IYlAAY9ly9g4ETQA8TLBFDYCCrAUP2vFCmcKe_XVVGKSU64_oS7YAxnOTv_X68XHg6c_RGLnFD0gGoq7cBssQTkWDAnJj5doACueM8LYzYtdeKisW_XknDCrDvZWNDQKQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.75,
    6.88,
    8.39,
    6.35,
    1,
    7.96,
    8.5,
    7.58,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'rogue-affair-cocktail-bar-silom',                                          -- slug
    'ROGUE AFFAIR Cocktail Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '63 Soi Convent 2, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7267871,                                                   -- latitude
    100.5356421,                                                   -- longitude
    'https://maps.google.com/?cid=3711536186998263758&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJD8M9Ltif4jARzg8KXX8GgjM',                                -- google_place_id
    '082 852 7999',                -- phone
    'https://linktr.ee/rogueaffair',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJD8M9Ltif4jARzg8KXX8GgjM/photos/Ab43m-uiaYNHMzB8p79neHyc2UdyOKIne9CYBabiXgpQx0OrMEKpB-K7N4Du9Vxa4G4a_lQ8Y74OHEmdI17p5bhj6TsDAuT15a53KFgdLzdrYNoVx8DvAXbYy4HRLUgN4l9dfp09tNjRV81Hqc4A84OLeFz5JBfJAqQ4HbhngKviv3ssUfXRwX3k-ZI2QeVFOao2nYIB3aaMTggAEo5gEhBcu8GcwP12V7YNQJwX_69jLu-8mOyHFkHkDUumdM6ZvKfNHnIZwP19dMiP6HsO_kyVqqXcg_9ue5jj36S-9ZxVIzV5ErBZwHdQ8gMaUgYf1aW42Je70rXouS6Elgo5WrYo5v9901a8ZfpIC58iLtsgdKOSu9QmsIs95nYcj7LkIVikO-JSWyK-qzLqSlYxCRn3Orl8Rgwe0A0Eq5AwTmgEk6Q/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.68,
    7.15,
    8.57,
    6.39,
    1,
    7.53,
    8.5,
    7.95,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-drunken-room-cocktail-bar-silom',                                          -- slug
    'The Drunken room - Cocktail Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Si Lom Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.726795099999999,                                                   -- latitude
    100.53088609999999,                                                   -- longitude
    'https://maps.google.com/?cid=9244300857692517044&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJfekTsYKf4jARtPKZ06ZaSoA',                                -- google_place_id
    '061 962 4932',                -- phone
    'https://www.facebook.com/pilipala.bkk/',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJfekTsYKf4jARtPKZ06ZaSoA/photos/Ab43m-v7uHVK0NBkYAEVLXlOqSwBF2ieAtbuikwbfAU-1IM3yGRsclWnryGNCS_G8a-qibkvKi_syO9qkaB76W_L_LvSO5MlQAQd9hm5oCOgiGUobjS79bNxzAu7MdZfLia1YNom7qkznQit9Fl4P-V8qO2NUObkK46jCVRKj_uSZOI9jKAnTBQSNiTCV9qMhPwiRwP5J5Qb7tpyTZTLUdatbz1IH_AlHdfNecqZ2LPgBRfQUZ6yk4lFZcMjjKLx-h3A0gox-aB6jNmJYBtg9-kMZCQqUM4Ff2A_br4Z5YlfapdEaRr-wTFXXUO57PQGIVoFrDn3zhyya-1Q0X296WCPBO-b8r3HaWxb1XhmEs0ZoXwrGjF_teOoHo-EMRiv6I17Z-otCq7oF70-dafwXZKdaEw8oNl6bDf20rZvffSOnuUCFA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.58,
    7.18,
    8.55,
    6.24,
    1,
    8.37,
    8.5,
    7.97,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'rainbow-dragon-silom-silom',                                          -- slug
    'Rainbow Dragon Silom',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '5 Soi Phatpong 2, Soi Surawong, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7285502,                                                   -- latitude
    100.53221699999999,                                                   -- longitude
    'https://maps.google.com/?cid=2227670261901258182&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ8cmBNgCf4jARxm1T7UxG6h4',                                -- google_place_id
    NULL,                -- phone
    'https://rainbowdragonsilom.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ8cmBNgCf4jARxm1T7UxG6h4/photos/Ab43m-tKfGBckkI2ixuLiGnF-o6fX2DJBmHwO9Ao_3RnMvmNnGKtSPxbaS_2N5b6K2l8HeLksbMhr2RXTASns1W72cIu2293deyH7s2yoTRWY4v9JSLGqKqVifOmkq53SREumTfA54FmkxW6Wer6P2eAznbsaUaV1ELv2VKqfyZdQM3Rtj1KNOsIjC3UgSZfmHrB_fI7WyR7K06n5s2CemE9J2JQuKnamnWHUJ_znmUrFlAZVzVqaTp6b1WF2sD2oBxQ1s3huyBY_sw0e75kGb-55L5VJDzHZt6DW2u0oQ9V6nnFxQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.14,
    6.91,
    6.25,
    8.17,
    1,
    7.9,
    8.5,
    9.06,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bangkok-mojo-music-lovers-club-silom',                                          -- slug
    'Bangkok Mojo * Music Lovers'' Club',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1103 ถ. เจริญกรุง Khwaeng Si Phraya, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.728227599999999,                                                   -- latitude
    100.51618950000001,                                                   -- longitude
    'https://maps.google.com/?cid=15282055945715024651&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ7eBzN9WZ4jARC4P9MerEFNQ',                                -- google_place_id
    '089 909 3529',                -- phone
    'https://bangkokmojo.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ7eBzN9WZ4jARC4P9MerEFNQ/photos/Ab43m-t1wDWYAMQvjb2aAzwCfuun6BVZGoFbZVXlE7K7Ix33xGu-1wx3zVTX4n7djbHFGpTGSWBLsUNblBLVL4L6Lvc8lfne8woUOBkxgDaG-sgp8CoKmnlGzo0O3M9R7ydIj7BW0HuVp0XdtrfLoVYUZlfxiAtPIME783UnMBAUIrQfgtjsbLPQ_qrdRwzyfI4GZoDnDEgEow7mUZfy-rzGZBZxrFtea0ygXngIFsSYygAm7X1IyQuAusvuZutNxCGGJ_-2I6-SFKZ7VgdsdX1MCgZ7DTnCUQpWdwu4jZK10DJCP3ifUNuQF3vYgvHdWivwMWNU91CLYnLzKOT_wXS1WwV1VGzR6zTG48J-LBo7LU2YBpxm1uRR6WUPiYgZmQC0Suw-FqyIsaRa--AxWHC6N0fQeJvSA-kPGiAqzjFOFmgoPg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.03,
    6.91,
    6.63,
    8.38,
    1,
    7.89,
    8.5,
    7.66,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'snobbish-restaurant-bar-silom',                                          -- slug
    'Snobbish Restaurant & Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'บ้านเลขที่ 78 Mukda Building, ชั้นที่ 1 N Sathon Rd, สีลม Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7228224,                                                   -- latitude
    100.5328926,                                                   -- longitude
    'https://maps.google.com/?cid=254643418981097000&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJSaWJVwCf4jARKF7CJNesiAM',                                -- google_place_id
    '081 814 5185',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJSaWJVwCf4jARKF7CJNesiAM/photos/Ab43m-tm7rAeFrnZ4V6vf9I8CBND90dp-FcwiIsY-GUSaDkf56u6k8jdgIBwVrvNJDCuCwEnBNCgtNtkFZWqkx-nwHXQntIVS5P3On_CMUJNw-Cdxdt8qUFVO8NU9gkYy2CpoGd20yT7ebZw-mhSVp_r3f-HjsUerDfCMano89di5wUhkuooXnKaONDSkjmcEPJGVT5jEFVxrWZoAHlNYokD2eOSUC_QyD5aoFnnQumkDZ7ooojH9xlNcvoZHk9n23nBgvt8gHhQDNM0_ifJnsdAi6q9HUaeBG8uNTndwx8WJeqa9Q/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.36,
    6.64,
    6.63,
    8.44,
    1,
    7.75,
    8.5,
    7.61,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'rowor-cafe-wine-bar-sathorn-silom',                                          -- slug
    'ROWOR Cafe & Wine Bar - Sathorn',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'อาคารเอสแอนด์บีทาวเวอร์, ชั้นที่ 2 68/3 ห้องเลขที่ 202 Thanon Pan, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.721407,                                                   -- latitude
    100.5238962,                                                   -- longitude
    'https://maps.google.com/?cid=15371744723041962002&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJI6So-BWZ4jAREsjm8mFoU9U',                                -- google_place_id
    '063 192 4123',                -- phone
    'https://www.instagram.com/rowor.bkk/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 10:00 AM – 9:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJI6So-BWZ4jAREsjm8mFoU9U/photos/Ab43m-urDi_LxPot2vbCbiYv4OeWBilk2EXypM5D2wtcv_T6h5wsxSGshrDj9wcqq5cHKrF_ea8W7N3H3cI9-sQhm2y5E-Wwn4Xz5kgZgcSo4pp8nHqcxjkZsINg2mJL0VWChqQ0k5y8AmUNPdes1CNDmAMk6NH5QfE5QBXwqLMff6FKUJCbdIs5t-SEHIIyLWeb5EFyCk29EfGCQxYwqtusApQdPYmmw6H1y6J2aScHRunJ5M-GjHUEnUf_xZkWm7vI4WBjmwNzZNvhOR9sfNkOh3aQjiINV5T_NmquAylx_jhnjw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.46,
    6.51,
    8.62,
    5.81,
    1,
    8.06,
    8.5,
    7.95,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'w-lounge-silom',                                          -- slug
    'W Lounge',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '106 W Lounge 108 N Sathon Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7218535,                                                   -- latitude
    100.52866449999999,                                                   -- longitude
    'https://maps.google.com/?cid=14376365920753488364&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJOZC9QM2Y4jAR7BGLu6Icg8c',                                -- google_place_id
    '02 344 4131',                -- phone
    'https://www.marriott.com/en-us/hotels/bkkwb-w-bangkok/dining/?scid=feed67b0-9a2f-4de1-8df6-114544116108',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 10:00 AM – 12:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['cocktails','premium','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJOZC9QM2Y4jAR7BGLu6Icg8c/photos/Ab43m-tkz5_MZL0Z1X0cFbON3F59m1aAsnYiG_mvoEZD71k4FoT3d_A59tJgc67A8JmmsdcpZCm6h_koJ3grdBfxt0TAItcapoJd78y99CDg0iAt6eYzqB5p5sTyLV87I4ddk_mAGBbONwoC5tGd7lOF_TPi18i5qDZDxGDkRcsL1_leBnvOpfYdnOmKfOAfRPawnEZG2YD4j80adOpb04OXOB8Uhq6b8Y5sl3kISuYI69tmwelchlLBvus8_ejsljbvYx6J-JZAzWwngjZlJbFndlWUA39VZAb-Ql72yBTzEvTceQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.15,
    7.06,
    8.6,
    5.86,
    1,
    6.86,
    8.5,
    7.76,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-cellar-at-mahanakhon-silom',                                          -- slug
    'The Cellar at Mahanakhon',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Mezzanine fl, Mahanakhon Eatery 96, ถนน นราธิวาสราชนครินทร์ แขวงสีลม เขตบางรัก กรุงเทพมหานคร 10500, Thailand',                     -- address
    13.7241538,                                                   -- latitude
    100.52829260000001,                                                   -- longitude
    'https://maps.google.com/?cid=17375161331711686935&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJS3dZcquZ4jARFznHcyz5IPE',                                -- google_place_id
    '092 469 6695',                -- phone
    'https://mahanakhoncube.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 12:00 – 10:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJS3dZcquZ4jARFznHcyz5IPE/photos/Ab43m-v63ggnMImCaR-pP-M0bUfixFnN4mSkwNOUt-RRSY3EbUcF7vOopk_PTQdSVHYt-4_fvz6qdsVgM1IyY774s13n2EFIlowh90UDKj7bQnOmcJvmQ5eWOc3djD7MmymLJaMwl_Kk_GGQ7g2XxnmIzpTLhh_kyNEuFItgDptkqDf-klsjhuLZ2saznmiUNQbnisYQ4711rXpo6vv8YKqNaM-MZhU-qDnWFpzkaq_ewiRGbUFz6wmtxdogNDYqoYuymzgAo7AmS65ZlISYtwDObH2gLH4aVTHXPTUk5_owRmAPNP2C3L1WYVavBZ4yGI2gqGl1Agp9b4qpDMkVL51G92D90jBFglYU-6IZfDoUqyReAWfEDpK7dKuwgfP3khJ3irpwD8VQE8WTKwDEqkyEO-JWYDDVAxMfAiCh48Md3bsrmp6gYuKJqVdnsJfyww/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.73,
    7.22,
    7.98,
    6.25,
    1,
    8.08,
    8.5,
    7.6,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'you-know-where-silom',                                          -- slug
    'YOU KNOW WHERE',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '185 Si Lom Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7286787,                                                   -- latitude
    100.53508169999999,                                                   -- longitude
    'https://maps.google.com/?cid=12457168291993759229&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJrSnWOHqf4jAR_S2Mh4_A4Kw',                                -- google_place_id
    '063 845 3656',                -- phone
    'https://www.facebook.com/YouKnowWhereBkk',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJrSnWOHqf4jAR_S2Mh4_A4Kw/photos/Ab43m-sOoMnGQQR6IQw0BVq2Gbo-i5jTjLJO4krhWr3f_Y1m-OhMPrFnDkblNZ3B3f_4PKmD36vFkIgj-d5K2fIXVzJ6fTWM2nhgxfo4oaB-UqAmKPiKoCwtiG0Obg9dhVNBpGJlsZdZc-ih4GeTeOKl1SnvHaCpuGwEI3MWgFPIif0R1WELayo8WFsbddTiAZsLVb0LhyJ-2IvnVlE5wVZGBrWnMsRAPn7ZLsCDsL4k6y2t4n0IHB02EG-GIZZL-HeqzNJGbaojZop7gepAPIvL-4qGJmD8QhmkLF6Cvtg-ZHg2yYGCfWMwg3cH6LbErIwOEHX8_Qk4f4sZxqlf0Loxz_1ZNhrQroUKXUJVg-9LM7MhwMwU0w8Q9OE3lMvz5-Nh7HqiXd4wrmKxndwlLAej5dhI1cBes4VVIRN_7wqzhXV3t3HlODf_kuusOyKQuIFY/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.65,
    6.85,
    8.44,
    5.92,
    1,
    7.53,
    8.5,
    7.43,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'atmos-on-top-silom-silom',                                          -- slug
    'Atmos on Top Silom',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '9th Floor, 2 Si Lom Rd, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7291721,                                                   -- latitude
    100.5357006,                                                   -- longitude
    'https://maps.google.com/?cid=16955357624128205088&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJBTZKNPSf4jARIHHfAe2HTes',                                -- google_place_id
    '082 539 7897',                -- phone
    'https://www.facebook.com/atmosontop',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJBTZKNPSf4jARIHHfAe2HTes/photos/Ab43m-uxU8kRNiZjjympqV93Mg173cjCnNEOA2doI62HCfTrxxiV8ExQFoa--ZtbJQ-OcMLC4YdLutkXbRW9gONirKjvvxxsfLBAJRd1jYRQWpZhr-eY-7tu50-1EnU5k-YYV-SfM79UEry3OwEF1dwA-MScSgFSLTsL98xy2AgklnXtThNryoK8xpJ8zLsn4VUkfOnQ63e4ZkZsDzhISaQoxqYDHThNafndbPXn4lLceyq4JYAMGBoDavzajko4gHMwKc40UxVVixFH4eNk9_CBlmI6Qb4xVApEHYiqD6_iN4kDcA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.35,
    6.79,
    8.36,
    6.48,
    1,
    8.15,
    8.5,
    7.9,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-parlor-silom',                                          -- slug
    'The Parlor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '4th Floor, The Standard, Bangkok Mahanakhon, 114 Thanon Naradhiwat Rajanagarindra, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7240706,                                                   -- latitude
    100.52791959999999,                                                   -- longitude
    'https://maps.google.com/?cid=5805131671739797316&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJGTREE_CZ4jARRI9roH_4j1A',                                -- google_place_id
    '02 085 8888',                -- phone
    'https://www.standardhotels.com/bangkok/features/theparlor-bkk',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 AM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJGTREE_CZ4jARRI9roH_4j1A/photos/Ab43m-s9l_VCT3R-pHkGTYqQSoVKABWsFjIGN0-pbtqUgdsMPDsGcdREsbtevc57sUKDnAGkx7ULVHzqBjKp-uUcxTi9IE5YJo1Twp09fR-JTo6jfeSzsjztUzXmBlKW8MX_HBCSWWUg1dPmYioEmSwsXgoBj9xZgxgIjN3hCUbOsb5gReK6nWJ87u-pJxGDud3HR4i1CJBLCj2tirJzZ0v9KHZOF7x-tO04lGK2s6r4Hg4O9tSNnvtyZRTywi2y3X9uQVcFgeIOF935lVHzVGZ7mhh5KUlIvfsS0MjfKmnR0vXP3Q/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.14,
    6.52,
    8.09,
    5.75,
    1,
    7.7,
    8.5,
    7.76,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bar-sathorn-silom',                                          -- slug
    'Bar Sathorn',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '106, The House on Sathorn, 108 N Sathon Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.722108299999999,                                                   -- latitude
    100.5289705,                                                   -- longitude
    'https://maps.google.com/?cid=13782297896671639111&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJXyOvz1OZ4jARR_a5T-qORL8',                                -- google_place_id
    '02 344 4025',                -- phone
    'https://www.barsathorn.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 2:30 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJXyOvz1OZ4jARR_a5T-qORL8/photos/Ab43m-v8ubjT9GUOgFYE-Gn8_PeBnQXcy7Oaiau2E3qbf9Xbx7vA8ONcNUh1oC5jNN2Odp4ih9wxFVMUt78o1FOltHvTtkKWssUkdbpOyp36fBkVryxMF-rmxFyX0aKtBWLbUZeUNjabrPi7-DC-GHYt7uBUU33zoKeste9VBPsVU-Fv-bLZmvS7u1JWRDz9H63oO9ak05QO7rC5ZxZ9x9FInNvNiP9W3n0FjsGHvc_pO4-IqaE4nbyGeBqaWMFrDO-nY4LGrpFUYxWR_TTg3LXx8C0TU6kW8HFeq2EFhWDt-r1XWh59Y4hWBx9og-byI0yaZfidN9EfEiJQwujrTznGznFLMGOccVOuV6kRcTrt3wHZLgxSbvFXwU7-nw9IaAR_YOSLpAu6QQnjS_8VinIke98JFVmv7TRNQpcqk9Z_1dmBojtr8Ubbt6W-F1fD4cEm/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.34,
    6.56,
    8.26,
    5.8,
    1,
    8.11,
    8.5,
    7.78,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'homie-bar-restaurant-silom',                                          -- slug
    'Homie Bar & Restaurant',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '981 ชั้นที่ 1 Si Lom Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7226099,                                                   -- latitude
    100.5194575,                                                   -- longitude
    'https://maps.google.com/?cid=4156008349629268658&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJj80N5z-Z4jARssI1E5MbrTk',                                -- google_place_id
    '090 212 7310',                -- phone
    'https://www.instagram.com/homiebar.bkk/?next=/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 3:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJj80N5z-Z4jARssI1E5MbrTk/photos/Ab43m-t5MG9Z5FlNQS8Ef_6xqx0gS4WSayxS759yJdIm2kjvC3ObuVFIAnzaWmjwsofluqE1Rkykci5zHr-F_YqYnJD901BMyvNoyfemBVba3lJq6mNJs35XJhaeH9c5Q18UlhS-5j5ljjfT6ldyE2pjFo_nI-7AZuRCDeceGXHfRutDigwr7iJXclR0VAyHzyM6hKxswXZuvdXOmZPjfwYIyE78V0QMAjOYoOtRJqRBN2uLDj71kdtPZ3YMs3JjLxWsjOI-Qz67MIQSChI_Yv42cwdYLD-EyfcIMjy4w_NLxnxWlg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.69,
    7.21,
    8.03,
    5.76,
    1,
    8.31,
    8.5,
    7.45,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'heightsbkk-silom',                                          -- slug
    'Heightsbkk',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '439/6 Thanon Naradhiwat Rajanagarindra, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7258604,                                                   -- latitude
    100.52885839999999,                                                   -- longitude
    'https://maps.google.com/?cid=7725598823557946242&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJr0fJUDWf4jARgttYszLXNms',                                -- google_place_id
    '083 837 5500',                -- phone
    'https://facebook.com/heightsbkk',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJr0fJUDWf4jARgttYszLXNms/photos/Ab43m-tND0PMDvPgFXxKa7JDAjtkDhy8MTCg5G57ats6pRgvqjIVBfUDR-PwrP25_mvxX5H6ThR1CUj-HredQ5vgP294JiRlmUtR_LoLFET01KsCvZEgWT6z6DcJsCeEI9rSPUoBn9rpbKMEhw_aHIKO0cTVIoqEu8A1jPX39rC6JHx16bAz2R9EiK3ww2C5AXK3RZY0WwawbP_wLB683pfR0THc1RVZ4hFiP3M19qWTWCi2E9WWfEvc4D0PaIelHpYeDlI2HYhP_pvd_-0W0FrpUalkZ6ARJ8ajyRUk71suKnUzgaA1QCl3EI4JvzRfZE92tFYo7BVKLM2aOJe8oqW0aOlEkSF50Gdh5EOLi3gVXw7LRnsag0MWC__pDzlY00EIb4nGRl0gfmSFEXyPRwk5m379Ce57O1M71c7QeaRhOB0-0lbggTyM42BkuaSFjVup/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.5,
    6.64,
    8.22,
    5.81,
    1,
    7.62,
    8.5,
    7.65,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'horn-silom',                                          -- slug
    'HORN',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '4th floor, 71 -73 Soi Silom 4, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7284285,                                                   -- latitude
    100.53296139999999,                                                   -- longitude
    'https://maps.google.com/?cid=9223893237877769622&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJg_jDzzef4jARlgXVkQfaAYA',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJg_jDzzef4jARlgXVkQfaAYA/photos/Ab43m-v7utDaQRTZFvOgVrLkl8mu55w7hD4FCXsrIqxjpLO5yTpsWvobcV4tVNYjd62LWunKsGHzU40E8xrFOmRpK_E1bkKHUJk-CZ9g1h6n6g2G2GpcUWKwp4shKZkR8cZCmV3UGbIXSqBMRMV86qZ4m9zmlTPQkJLwzJgHGrIgNvycRJBiQJzIwU66bCVt7k0nCeezIqAyw_twH9xRHhbonzQXf9OtXiZukM-BCVDeOs6dsKiRTePSeDB1U1hhl-aydonbY2-IzCgAeGsAIbapksr3adL8_TGQtWwnzlnL6ScTOQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.63,
    6.77,
    5.96,
    7.76,
    1,
    7.93,
    8.5,
    9.28,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'white-rabbit-bar-silom',                                          -- slug
    'White Rabbit Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '12, 3 Si Lom Rd, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.729051,                                                   -- latitude
    100.53517149999999,                                                   -- longitude
    'https://maps.google.com/?cid=1635536200640299721&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJJ9DvASyf4jARyQJ1UIKXshY',                                -- google_place_id
    '089 956 6248',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 4:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJJ9DvASyf4jARyQJ1UIKXshY/photos/Ab43m-t9kIyHwrOvrn64_MklMcPgm2SDR9PQYPEEpGQsLVcnI_95nVIVVgcQu1ylya21SWQMJwKf64Jg3K4tHg8YDo8vc0ZyhNpmIBtn12xbBI2kAC8OBbWiEOVXaXIsLlS_2OYIXtxK_34WeNksYBjS3K3RAQ_FEjAH4fAtKjMhAeFT3SBglDizoTpeSbhDtFPMRpi0hcO7k9uiLRrM4Kvgxq7QcBUuEREzWSv3C6iRbnsS77VjgHSfIbp8qnG8EEAEDk3zOLQE-TSBSWxu7pp1SXnYZdjKh4PK5vJJ12FMSmE/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.39,
    6.77,
    6.02,
    7.94,
    1,
    8.07,
    8.5,
    9.39,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'portal-silom',                                          -- slug
    'Portal',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '98 Room no. 3901-3903, 39th Floor, สาทรสแควร์ แขวงสีลม เขตบางรัก กรุงเทพมหานคร 10500, Thailand',                     -- address
    13.7222904,                                                   -- latitude
    100.5293478,                                                   -- longitude
    'https://maps.google.com/?cid=2446563350893712836&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ83qaNrCZ4jARxFWCumfw8yE',                                -- google_place_id
    '065 142 6000',                -- phone
    'https://linktr.ee/portalbkk',                               -- website
    NULL,                                                     -- instagram_handle
    NULL,                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ83qaNrCZ4jARxFWCumfw8yE/photos/Ab43m-ssZ9O-1Dz2TYKgtkVf6QpiqvE3G_ZLbFiHFZVq_8vyjxVh1WaiQPr7wN4zfCFvGqwrUJsjaX9ZHuj5AmtrIxhc8lmaM2BtKXfTGEpNfTN0hbFVmDfBxH9we0xN10eNe9aOdABREeXwd2Da1PSkL0Rft7y2v9MPuzUnGfGTXjSYQWudTFjghRB_NBxTlyXqrDWZctvZkPd5ZnfcJ_GfTM1COj1YdKKRVWxeE-lADPsdjIpV3iDT1Hs4tDbvLYzsVuf8Dra5torOUO-v1BIRWHIC_KO1u4nSk2zwpoYB3KoG6g/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.33,
    6.88,
    6.29,
    8.29,
    1,
    8.32,
    8.5,
    9.12,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    '5flslm7-cozy-gastropub-third-place-silom',                                          -- slug
    '5FL./SLM7 - Cozy Gastropub / Third Place',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '55 Thanon Naradhiwat Rajanagarindra, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7258575,                                                   -- latitude
    100.52886509999999,                                                   -- longitude
    'https://maps.google.com/?cid=18154686196027436102&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJb0-5PceZ4jARRiznWuhm8vs',                                -- google_place_id
    '099 678 6651',                -- phone
    'https://www.instagram.com/5fl.slm7',                               -- website
    NULL,                                                     -- instagram_handle
    NULL,                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJb0-5PceZ4jARRiznWuhm8vs/photos/Ab43m-ttQKohZQgW8aE9Fgyw_gGwVmtLY6tEtFdqvWoKePE5vyMvg--s78ouGDnkUTF6V_MgPMSf1Mmjs8pjvas2ufR2YKXLMCUJMk2RXTgMe5pVHfNVZNChQjMEAKW7wJt7DGznzQl7bi0B5kYrP5KK_fqVGJ46-yFdL1UoGM2R759xvWs9iScFUXGZC35muYgAG6Vj1h5cUGmpLY0Y85KnbHO_ezPy2SiOOkQwCkfCEGCrrWRGdFeJuNjgdOr15d9Qpysm0fb8_eQoE5MTEcZ3nGAilKtIfqH4xyQkLKtbfBM/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.08,
    6.76,
    6.07,
    8.52,
    1,
    8.07,
    8.5,
    9.14,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'attitude-fusion-restaurant-rooftop-bar-silom',                                          -- slug
    'Attitude Fusion Restaurant & Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1204 ถ. เจริญกรุง Khwaeng Bang Rak, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.725803899999999,                                                   -- latitude
    100.5161133,                                                   -- longitude
    'https://maps.google.com/?cid=5962532586378068781&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJx2Gyjo6Z4jARLYPB5Msrv1I',                                -- google_place_id
    '065 708 7313',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    '3:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJx2Gyjo6Z4jARLYPB5Msrv1I/photos/Ab43m-spDIlVus3zKByX3t7YluhmYIYs1n0WKRcK0qVRz-IECp99YP3jeSLoWdjU_4ZUouiM0hIoAI54ISr8N0_aggr4t1I_YGvQcJ9uQJ1JpjPp6zrPvVQCIm9gkFM1U8UqVTpday4sXDE-AKsDJwohC96s98CmrgN0BeeDZriWoxo5ifD9s1m-wQh_wGuEJ8MVYZJ4nVO61TS67RlU0OkjE1ylB5wkGI0Fdp58IKMwxsv4Ao61UhHzshaS0f9VVB4XNmTHUAToTqrH56arnlmNA8MmW1CO2q4RyvVq8u9_XbDlIbiXpuG5E4urKKwFGJhaNHdOYUduqkm4STeAd_6bJiTdStaHcD4NFE6okksOBp1LWqnYYDCn1J2HrTZ_2hGjdHepELPPFvzTd799KYVBmj75jMDA40xvfZIGdgWopcSxpvISWiTcpJmaiuH4Pn_f/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.52,
    6.87,
    8.92,
    8.45,
    1,
    7.89,
    8.5,
    8.93,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'suriyasai-bar-mekhong-museum-bar-silom',                                          -- slug
    'Suriyasai Bar (Mekhong Museum Bar)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2nd Floor 174 Surawong Rd, Khwaeng Si Phraya, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.729142,                                                   -- latitude
    100.52781840000002,                                                   -- longitude
    'https://maps.google.com/?cid=4369509510125521512&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJmSDbb_Cf4jARaAq5sb-dozw',                                -- google_place_id
    '02 237 8889',                -- phone
    'http://baansuriyasai.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJmSDbb_Cf4jARaAq5sb-dozw/photos/Ab43m-sSXh98j5r96fQp8e_pW4hGJX4jdfD3GlaelvHJ5TRuUsLBRXj4uBlDTpxTdMxQoBbVjTl1yOVh_1OMNFEqknayFQPfYyg-u6Fo-1klB6AqK2NBaECcyXQfEfzVf1z7__tL8TK8-1FwC8wKFV7aUT1BryPr0Ix2T4wdRRIWb0Qdp3TkxxcBhzTY91ynaIT8HHlwQKgb286QKyw2JU_y4FLwIO5Yg18Qn978etKCpnwdyQgV4v2Za8iwp9mo_eTcIdAWRuE30m5jLMBz5SPCH_suoo6KJRgS7OALbM8mZdTA3HuIkCuUAq8uRILAIco_ttcsiM-AsrA1zl5_Wr7EAELKUA8nb976zMpnMNYS7ZG91gbCzVxTgHoqPgU8l5AI-SsfjyTXvJFLNt_LD2c34HmVa9JNfIfLqn_jxtgJWvqODA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.01,
    6.98,
    6.6,
    8.46,
    1,
    7.69,
    8.5,
    7.61,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'sip-the-sound-wine-bar-silom',                                          -- slug
    'SIP the SOUND wine bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Thanon Naradhiwat Rajanagarindra, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7242914,                                                   -- latitude
    100.5296857,                                                   -- longitude
    'https://maps.google.com/?cid=1103145647956348393&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJw8Rviemf4jAR6c30QR8pTw8',                                -- google_place_id
    '064 123 6517',                -- phone
    'https://nightify.co/book/sip-the-sound/google',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJw8Rviemf4jAR6c30QR8pTw8/photos/Ab43m-v0uiSNAlkjkAqFRR6Pb2fX3mochFItm3KZROW4xhSwVrYaYwJjV8mecHaXI0_ESOcTNGIREh-GSVlKCeu3Z2F02QRku3T61hoQnOjHzQppNB56OpV3x2kx_NYWfKv55F1IX6_26vINd08lUsGmQxmsYEQTrpfAIvCnaLDLHpmBZ6jpeFhlgI8CllWkSd2pYAYT3xYQznrvLLvfplYDy9sTExj6X2bQChNtmS74MqeOcZJGG1Q5cIvuHyv5UyHlm1YvXfHU4i6akFJbor2Bu8Ib0jcwi4w4iVyr4A2Wx6xV_Q/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.66,
    7.05,
    8.65,
    6.22,
    1,
    7.78,
    8.5,
    7.52,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'starlight-rooftop-bar-silom',                                          -- slug
    'Starlight Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'R Floor, 222 Surawong Rd, Khwaeng Si Phraya, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7277235,                                                   -- latitude
    100.5236465,                                                   -- longitude
    'https://maps.google.com/?cid=8192227492673086786&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJL9CeFuGZ4jARQuX3E4CjsHE',                                -- google_place_id
    '02 352 4999',                -- phone
    'https://starlightrooftopbarbangkok.com/?trackingCode=GBP#book',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJL9CeFuGZ4jARQuX3E4CjsHE/photos/Ab43m-vTvceSUHiHobmpTRsTl4_UY-G1Cqkp4wqx15GPFl0xCt9pxs11M2jT2QEUm8JQQyEz4en5fWRxRoh5YLxKp5Xq0EEkl8D6qcEsVBa5yM_ReEnj_2-ybELw6a_Z3M8y0zgbj3F8Y4DwWHjxhs0JP9RHI8WnxqjSfWPAsXX8WbRgYg30ljNf7cVm3j7IcwRpPqmv0UssImapqsNXXBOK_4Xjjqp67cnwsgHfZo4SY80fe06PgRnqPXfWdvJgidVTc1A48exj_X32wXDpFvoEc_DBeuHO0JXnvKgkOAZJ-ouhLg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.52,
    6.94,
    8.14,
    6.46,
    1,
    7.78,
    8.5,
    7.95,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'throwbackbkk-rooftop-bar-silom',                                          -- slug
    'Throwback.bkk Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '9th floor edge building Si Lom Rd, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7294607,                                                   -- latitude
    100.53567749999999,                                                   -- longitude
    'https://maps.google.com/?cid=10049097869826934869&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJJ-OYh8qf4jARVUgrLEWRdYs',                                -- google_place_id
    '061 493 6266',                -- phone
    'https://www.facebook.com/throwback.bkk',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJJ-OYh8qf4jARVUgrLEWRdYs/photos/Ab43m-uNFETvsgsGRqP7iUcF4c7kEnKH1lYSD56bWf-eUclwa6UwvD95cSwexLKP26OLYJe1_lTU3LRGFtBlbNNej5MJJOgsrmrm2dcieACgTKU5RTZYKyPdtS-CwZHlTipmRnlLFd3U5ZZd2-8AA65d2ajiHENXp2pfiEmUAuAzGDk_2lRCa_dbAchsYMFFhOF4NlstVLFx5rCshLo7EBj-KjKtvqNL1lsVhxsquHsRqUzU8a8t882ya2N_fkidXdugHjK2TY79SgxmxLL2Hn8yYmCxq0f_rv1gKRsyzxztQsRfIA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.97,
    7.06,
    7.91,
    6.05,
    1,
    8.21,
    8.5,
    7.49,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'mahaniyom-cocktail-bar-silom',                                          -- slug
    'Mahaniyom Cocktail Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2nd floor, 104 ถนน มหาเศรษฐ์ แขวงสี่พระยา เขตบางรัก กรุงเทพมหานคร 10500, Thailand',                     -- address
    13.7290995,                                                   -- latitude
    100.5183098,                                                   -- longitude
    'https://maps.google.com/?cid=6471750078865566280&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJafEshvuZ4jARSGrjbWhG0Fk',                                -- google_place_id
    '061 664 6588',                -- phone
    'https://www.facebook.com/Mahaniyom-Cocktail-Bar-%E0%B8%A1%E0%B8%AB%E0%B8%B2%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%A1%E0%B8%84%E0%B9%87%E0%B8%AD%E0%B8%81%E0%B9%80%E0%B8%97%E0%B8%A5%E0%B8%9A%E0%B8%B2%E0%B8%A3%E0%B9%8C-111733094625872/',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJafEshvuZ4jARSGrjbWhG0Fk/photos/Ab43m-vMWLvBQlQy_I3F8NZtpffcV8KYHDX3LCY9_ItkAj6Zmv4W2uZw04GBDkVbJ_NZWdvSeXfna40rnpARBL594uYiXdS1SoFipWuPNvOsLhYZ5WNU1fXwYFxAQ72N5z3UiCwYv35WzaeOtNKJFmo8CKE5AS4oe9pCgMyU8EDXRK8Q5GdMvjFun7ycJf0Zl4XWBGNBz6pXxbskTMN_Ny2nyfqO3RsKJSduEvBjvg96vAJgXHqYM2_8SpN7FwDhK4hQMT4Nxspv4_Nem-OYXmzb8C5xBQDkAly6Z2oXZ3xtYT9u3m5tC_RLH-uWWj8ohGPBfczb5bY2ERdIiM61-xFKvMFRZFRwjVgtQ0pcSxcuBPwpBIYBv2bcLo0rBO78wluj6G5mFsH6dnBWwY1N6s5q46mZaHuzgfijmbu8_bM-ibQ99n9mt3fPNkrGEuTbPA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.88,
    6.53,
    8.36,
    6.43,
    1,
    7.64,
    8.5,
    7.93,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'silver-sand-silom-silom',                                          -- slug
    'SILVER SAND SILOM',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '70-72 ซอยสีลม 2/1 อาคารสีลมซอย 4 ชั้น 1 สุริยวงศ์ Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.728261499999999,                                                   -- latitude
    100.5330391,                                                   -- longitude
    'https://maps.google.com/?cid=12131582578949173346&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJuxCToFqZ4jARYjCVZRQKXKg',                                -- google_place_id
    '061 924 4298',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJuxCToFqZ4jARYjCVZRQKXKg/photos/Ab43m-usvLh4-JVT7onaBBsCFsT1-909C0U9u9w0l2UeOdHuhQovMG5wOUHa2EvAlItw0fPL3gD7Y4rZmr3Ttm-be-T8O_Jqn-Keoyy2ZMIQYaYhOVIqhUNmEhFbyS34hOMSL747bp1tBOn4N5WzyQt-P7JrDsMxT-hEpx3LbO9Ae8X6CwsQCUBwdGKCxhs69wZWVQPAL6dsOWup3vIqGx9fALcQSDbR8INzmwaNLCTVVfV7WXm8_ft1c_YPI24HEXY17qY9KbPqmvHK2La75owjBVC6q4jm2te0EY6uTH6vx2amOA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.32,
    7.06,
    8.48,
    5.87,
    1,
    7.56,
    8.5,
    8.04,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'groovin-high-jazz-bar-silom',                                          -- slug
    'Groovin High Jazz Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'บริษัท กรู๊ฟวิน ไฮ จำกัด เลขที่ 118 Si Lom Rd, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.728322499999999,                                                   -- latitude
    100.5326817,                                                   -- longitude
    'https://maps.google.com/?cid=7316107772995948498&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJmSf-pp6Z4jAR0s_l00EJiGU',                                -- google_place_id
    '095 191 9554',                -- phone
    'https://linktr.ee/groovinhigh.bkk',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','jazz','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJmSf-pp6Z4jAR0s_l00EJiGU/photos/Ab43m-uXyTSbfrclIKN1qRm8iYpl-dqriFYTrVpXldRyiZJsYX92WnkJQauqGL1Y_BLJzJ5zITrcEIHEg6vJdi-hPGbcc7s41WYxKwR2NWZWBdwLBfZJw0SxUjV7E1CJoyZMOCdhdTTTeQqvZW4dTEtSEF-boSCCUM949m01-cUHq4C2DERsZDeK9fQp-di2TXtQpHIEjx15WWLLb3J33I5AL8FYDVV4z9Q_RIygYv14tr-g0_hxuDC-B-IKvmug6ISvc2_dEzip1vrEFSBpHSC1_3cbhdpLvcHXDpMebUaUFHp5LHmSUq9vkDYU5u0RlXlzlCVEquVrSAoekviG40KXCBfK4ahNkaI1TpRomY2lrxLIBn_ucrlfaPLhdOsYR6GrS8GcEvDKZHHGx4DUNSCC3GcRRSEAmxT1sfivFm03e6AVdkrgSX8gtqs3CyT2fIEI/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.93,
    6.89,
    6.35,
    8.11,
    1,
    7.94,
    8.5,
    8.95,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'hyde-seek-silom-edge-silom',                                          -- slug
    'Hyde & Seek Silom Edge',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'สีลมเอจ ชั้น 9 2 Si Lom Rd, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7294223,                                                   -- latitude
    100.53615669999999,                                                   -- longitude
    'https://maps.google.com/?cid=8250306028326810407&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJx2811iif4jARJ_Ou6p75fnI',                                -- google_place_id
    '081 104 1511',                -- phone
    'http://www.hydeandseek.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 11:59 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJx2811iif4jARJ_Ou6p75fnI/photos/Ab43m-vDXhQkKBWTDcMB3yRErsshp16Kr-o_RI1_moIBVaLkuOdHiQpavsaAiGNSRQnqiZ9ynR7TSjEVnQqIUGRyUSQu5yqqMJtGgNb72OxrRMSkUARLKmi8xQNL83e8dHWCYsCMTtz_2NE_dK2WClU0UojKAO2S-7XRVtMJFqDuXPlJx5D-fZSUF4R23UzYufd94bNg3NNtNefYI-vH8bqVqL1crppYwqaIbC7oOumzyKpyRV_V98pz66TeY1a2b6ZA1b70jWU055gm96WE9wX6RNVerVMbxXw0WZuASzeKXxl8UzYZKF8k-slIhV1GrL8IGgQo4EBLN0gWUin53AW36-t-S359WW79d0oEtg2nLhe1iImcA3rOj5_hSLaRZB9WHWl0AI0Joff38vUiaYMhUQBlY5tXQsvRdgGiUL6ESFZqIw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.22,
    7.17,
    9,
    6.31,
    1,
    8.23,
    8.5,
    8.38,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-zuk-bar-silom',                                          -- slug
    'The Zuk Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'The Sukhothai A Beaufort Hotel, 13/3 S Sathon Rd, Khwaeng Thung Maha Mek, Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.723307300000002,                                                   -- latitude
    100.5407594,                                                   -- longitude
    'https://maps.google.com/?cid=17985432096279526800&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJyeZZiS-f4jARkH2mXjMXmfk',                                -- google_place_id
    '02 344 8888',                -- phone
    'https://www.sukhothai.com/bangkok/en/dining/zuk-bar',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJyeZZiS-f4jARkH2mXjMXmfk/photos/Ab43m-tfdQv9gfKLd-v7FsqG_RiYVP1WJeKqbs1kAM40uDyXi5ONAhf9GXDuxi-YkBh7hltzKU3Vrk5SCH6wwubtW-VmY9cCXIl0iUjvKgz2XEPuBO3EjF1BWhlJcXdvK4Wr7mx_oHzAtxYXhoNP41uNrwYw3IbSSDLVvC2amn6T6qaTATz2q7p46zLrnN50OdWn0qY93QkiE11IMdHrMwYMGdIeNZzKT6ESFqFIiFV3uFhAuaO73XtYmCg5KBeEiuFTyewh1VrydObwqMPZhk1hNLl7j5_GsTxBRnV_oh3xTv5nFrSkYQtiabS7rQmCcd8NpDSPGEIxmUZl8iwILs2_0WI-EdY8kkOuSrCTxzhybqOPdznTIKp--wbfr5_kYkFWIcDGl4Gq8RiZmAoXyD5nWJpPVitHO-Ibeg7o3DQgFSRDNPn99eNzIllm9pakpXwy/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.16,
    7.05,
    5.89,
    8.23,
    1,
    8.23,
    8.5,
    7.76,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-wine-merchant-silom-silom',                                          -- slug
    'The Wine Merchant Silom',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'G-FLOOR, PARK SILOM BUILDING, 1 Convent Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.728062099999999,                                                   -- latitude
    100.53360110000001,                                                   -- longitude
    'https://maps.google.com/?cid=12751455374727072810&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJYQWozDyf4jARKkzaaxpF9rA',                                -- google_place_id
    '095 749 9699',                -- phone
    'http://www.thewinemerchant-thailand.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 11:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJYQWozDyf4jARKkzaaxpF9rA/photos/Ab43m-udmLUVtwG_qoMDwoHMefrs89zUrq1iFI5NblfDxmLe53h9SaxMvhjrGJ0L_R4gc7RfgQCD1S4P6CJzcUfgMMVOuC8DrXtdkcnErNu8Vw19Zt0-cTU-JHIanDbMb472XOJUhSmgqRTsLj6vPdydH1APy9rhLYfdcFMbE2xhqSN_d6xC8jkC84nFCk0JpziDSbOsg8_v5CElhMr0of2ZfdRrhKxKxHT1l4VUwr7EgFHHK9Uj_DTGJKuNWM9p3PdK9byNju6Cv0zdsq-hi1oyN3zF73Nstfa7bsdmlNFek051Gg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.14,
    7.1,
    7.88,
    6.3,
    1,
    8.28,
    8.5,
    7.63,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'sinnerman-silom',                                          -- slug
    'Sinnerman',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '64 Thanon Pan, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.721889500000001,                                                   -- latitude
    100.52343549999999,                                                   -- longitude
    'https://maps.google.com/?cid=14263606003186872044&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJs3Noh7aZ4jAR7C4VjBaC8sU',                                -- google_place_id
    '099 910 2798',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJs3Noh7aZ4jAR7C4VjBaC8sU/photos/Ab43m-vR51tp87dkdlrhlQ56DijGrcNfChjUFP0Yg06Jby2PlWQbvYakGOIMGTyEmUccgXqBo8kdhmJcRhRRzDUtg5uCOfaQjY_2MsIzHsli2XmokzoRALLMt-4uBB66wNNKT-2MQ1DUThU1e83-C7FULHOUYDzk-4b9g4t0T3VUCPFohQniTV94tGHEMfizNKZYhekhFVs_BYBW-Vqb9hUu-Fh7-I7XQblTS4I93LYjNkdzKqCICJHM2eG0hEO-PVOPTBBJc_k1l4nuuTGG79OFQFF-j_xAETnngfNQx41qaUeXsqyg0arUrvj8uKyXU_d_1kNb6b4K4lQvlW17oryMEMjSKiuBuPDi0j1wHHPoXFnqpntk9SyCAurny9owzXmgIWgd-Z6BfVZ5R5gfK7SER3IZp-JuTVpke8EZ-QC3l6-7j7Sm/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.99,
    7.29,
    8.38,
    6.29,
    1,
    7.59,
    8.5,
    7.85,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'spire-rooftop-bar-bangkok-silom',                                          -- slug
    'Spire Rooftop Bar Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '98 Thanon Rama IV, Silom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.728015899999999,                                                   -- latitude
    100.53770809999999,                                                   -- longitude
    'https://maps.google.com/?cid=13433149537657999338&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ-85JINSZ4jAR6s_OJlUibLo',                                -- google_place_id
    '02 200 9000',                -- phone
    'https://www.dusit.com/dusitthani-bangkok/dining/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ-85JINSZ4jAR6s_OJlUibLo/photos/Ab43m-t9jzlg6ecHsFxus-RD05-Cdfz8bddKt0MBt5etEtwWWWGQ5-l_5z0qxwCmPPx6vn3WQeQRIAlSskbPFKI1QrxLxz6lf_z6kFmLYSsga4sA8iU7l0zltpdYc-tbqpQ_j7uNUiAv4h10vhBCeQbe4XyGes-Re5wQ3c94NDxBfKa9rZUolxR2kW3i1KbC_og1Qk6ntlSuE5GI7PWsrW3IbscOB7GxuXpsSUee6gynE8l8GRo_9UAnC2hZMkkor5gy1VsjoF_aXPLd0kW-KOhOfTyKzQsOB04UaURFI_yickcR8A/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.94,
    6.88,
    7.9,
    6.05,
    1,
    7.81,
    8.5,
    7.56,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-stranger-bar-house-of-drag-queens-silom',                                          -- slug
    'The Stranger Bar (House of Drag Queens)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '98,100, 102, 104 Soi Silom 4, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7290689,                                                   -- latitude
    100.5327531,                                                   -- longitude
    'https://maps.google.com/?cid=11190828437463751230&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ-4D3eyyf4jARPtpdHSzPTZs',                                -- google_place_id
    '02 632 9425',                -- phone
    'https://thestrangerbar.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿',                                            -- price_range
    ARRAY['clubbing','late-night','cheap','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ-4D3eyyf4jARPtpdHSzPTZs/photos/Ab43m-voOwcIsRUhgjxNau78bLLdw5WcnaYq7S77exqPmGz8c0Vr53rNgzP_yBdPjlyzLZpjML4PA1mT5DDA0tnNoRq1B1sWOhAGLdybco44ttBAMnO5voodjSH-qi1-5KhOwKPbO4K0TgZA8SxkUImPLDHB0Ij6bgGsJejTXuNpNZfXeFjkYMjdi7NrkrWP402HnYVOOq-LR610sptZ7fx2wbFae2uJK6ihzqBsgQ7tLNJnEVx028iWzLITDJ6VxOzx8cYO32RmQn_DFchdkFdWByZUgPeWCrVVDhaV7Fa8ogbWKQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.92,
    7.17,
    6.48,
    8.17,
    1,
    9.03,
    8.5,
    9.2,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'sky-beach-bangkok-silom',                                          -- slug
    'Sky Beach Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '78th Floor, The Standard, Bangkok Mahanakhon, 114 Thanon Naradhiwat Rajanagarindra, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.723462699999999,                                                   -- latitude
    100.5284147,                                                   -- longitude
    'https://maps.google.com/?cid=10002827694989886317&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJF4OXv_WZ4jARbcNPlcou0Yo',                                -- google_place_id
    '02 085 8888',                -- phone
    'https://www.standardhotels.com/bangkok/features/skybeach-rooftopbar-bkk',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 10:00 AM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJF4OXv_WZ4jARbcNPlcou0Yo/photos/Ab43m-tOrumO1PxDi6oforkxlG4CYMVKgkoTXax6GoU17r6OwyTDPDnVvHWewHAcLx-dCGfGOn5mf_f4KcHqFzD9PKk_4vu3w-Mq4dxTzANVkCgk20ok8ZcriSjqsJ31wurAF-8eH53fGisqH1QfgDK1y6s91_C_4-RSJ5m_KQ4oyJdsNU4WNODkgKrxWvV-B2A06qSNBaGU_9z_2u9i4WYwBkTgMtc1X_k3V6tk7jOeQenFzR0jeL9ICz8cwvJswAOR8YOcTz2BJwFEEhE7-J1mscXiUba60-U-2RYt3qpOFaibVMgp9fstjanEuS8EywRul9X6gq1T3_u3jUGQ0QxFstWFfACSwqG8la0TKQXiFndnFwlTgIslrWmoKva7q41Jnz3escom2_LigjgUlrhmheI7AXRyf5FbK7thldmPP2I7pArNfNbpCeGcKdKfbGU3/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.25,
    7.17,
    9.49,
    6.34,
    1,
    7.82,
    8.5,
    7.94,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'yo-rooftop-bar-silom',                                          -- slug
    'Yào Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Rooftop of Bangkok Marriott Hotel The Surawongse 262 Surawong Rd, 262 ถ. สุรวงศ์ แขวงสี่พระยา เขตบางรัก กรุงเทพมหานคร 10500, Thailand',                     -- address
    13.7274113,                                                   -- latitude
    100.5222169,                                                   -- longitude
    'https://maps.google.com/?cid=838912105079820999&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJdZuv9YGZ4jARx9IOZR1qpAs',                                -- google_place_id
    '02 088 5666',                -- phone
    'https://www.yaobangkok.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJdZuv9YGZ4jARx9IOZR1qpAs/photos/Ab43m-thMiEK0KPnJ6Roe-doBlQV8HgKZLaZFXJADq0Ba37kZZxs4VIq5pXVXpOYWCpSIUk5yzw8Ks8gXDiwHg-rLbu4JhfQPt8a_1N60pMqg-vPWs8sCRYH77p1RvOoQrFtKIpswT0M9FM1a_ySRaMtXKtAPmnk3iVM5ceT6AWA6dwc4GSjTuTmgFnWfJ_R_DP3kykaEEFsowUS307hyNFm0IeGZJRKRmt4TIDG_OkCuu7Ah7vtV3JDHiwzGXIRrT6W2dhpYBtw37ZYwJq9sCLlATdb6HjK9i7rZP384Pu-j3jVHBhqv6gFS0j37wtlvfF-r_E8B2igLoUKRbNBOsk_3GBtSOGFydFcEgLNm7HB-HSHiR9-ysbE5f6pscs-1cNungk2HqwMrp3DhVxcj2xP064VLTdLWLMWFCG7Ms7CBbBrpoDu/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.34,
    6.99,
    9.22,
    6.03,
    1,
    7.73,
    8.5,
    7.8,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'saxsi-rooftop-restaurant-bar-silom',                                          -- slug
    'Saxsi Rooftop Restaurant & Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '188/1 Thanon Naradhiwat Rajanagarindra, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.724207999999999,                                                   -- latitude
    100.5295088,                                                   -- longitude
    'https://maps.google.com/?cid=94232337609310932&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJswxGlsqZ4jAR1MKO0c_HTgE',                                -- google_place_id
    '02 233 4442',                -- phone
    'https://nightify.co/book/saxsi-rooftop/google',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:30 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJswxGlsqZ4jAR1MKO0c_HTgE/photos/Ab43m-uDQkpliZnnLu6dD_WTNUsI2xkXV-K6KHIx7VHH6WHW41Oa1ItPV4Zgg8-HdLFOEefRFu7GDJLVdqr8cx3LZ35fWHgoF6ghl9BPzMtGgKGBu3obNle9C6_wTG1z1tDDZw1s-aOmm5CjV593-dY1bT0Uym0226gy-ErThg8Sk2AIT7SFY2diUyRdCElQRkZqgQcFhuKJT_NzNzb1L2retpDxBQ_RiUNHqt-XzLcIU72VZGzF6j6BByPBve5yeE8O1yxYlSTSwP-mxxz0DKah7bYzfRgie4_w5LsB7bZLVNFeHg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.88,
    6.82,
    9.32,
    6.25,
    1,
    8.44,
    8.5,
    7.98,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'scarlett-wine-bar-restaurant-silom',                                          -- slug
    'Scarlett Wine Bar & Restaurant',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '188 Si Lom Rd, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.726056,                                                   -- latitude
    100.525876,                                                   -- longitude
    'https://maps.google.com/?cid=15857030445915911398&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJwb3uUy2f4jAR5jRfKS19D9w',                                -- google_place_id
    '096 860 7990',                -- phone
    'https://www.pullmanbangkokhotelg.com/restaurants-bars/scarlett-wine-bar-bangkok/?utm_source=google+Maps&utm_medium=seo+maps&utm_campaign=seo+maps',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 – 11:30 PM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','wine','premium','popular','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJwb3uUy2f4jAR5jRfKS19D9w/photos/Ab43m-vNu57sgJOK8WsnhMt-gHsUJ6Ut0PYLJp0Rs0dMI8X-nEBGeOf00CIpJS5vY28rKMswJwSW4GC8me26Qq6sYTRRIGcYodHtrRdSU5pCCl9x3MCPSAhWIEYRg7XYcsQ8R7-eTAA19DVG6uURLmy1t_DAtXDv7VUTX4o2gia4qWlNoDYE9WijKu1cectPq4sMpFwS0EbD6KLpgt5GSloF8f0zIFmXYw7l0wUVLVQfYL_YyNgFkgRTUNJOMUBM9DeSbvTmc9-Y0AxnswK0Q0Hss7YTzOfmsVw0xVXDgYAB88wTTA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.45,
    7.15,
    9,
    6.45,
    1,
    6.59,
    8.5,
    8.16,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    '365-days-jazz-bar-silom',                                          -- slug
    '365 Days Jazz Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '173/8-9 Surawong Rd, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7280602,                                                   -- latitude
    100.5258217,                                                   -- longitude
    'https://maps.google.com/?cid=4627619344013678543&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJB5WOReiZ4jARz1epc0abOEA',                                -- google_place_id
    '098 746 4458',                -- phone
    'https://www.instagram.com/365daysjazzbar',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 AM – 4:00 PM, 7:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','jazz','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJB5WOReiZ4jARz1epc0abOEA/photos/Ab43m-vJ1JhF6AqxJAoIKH3SeqjxkfvWm4tPOR3FJrRYNKWh5mvGFXKe1pMbiABYTrUCcEQaleUu5vFb4KqxukbwhCf5VWtr3QlZpwEDQ6kK4rGlA6xms80G4rBHBMBVnZ3vR9WJB9lJnde8dJry09hgRAZwZ9cgnDNMQRfEnraKlsXWitPazCbyrAMBFiIMtE7EippCUNbSqFu-_Z2_BPuXWXRYtrKlIMXuhmhWaIhEh-WCGpGAc4a5bFTAOd-cBOuCiMkFzYgMdOjtbKza_XmmKIyikcXTtPffvel1d_kHwuCm1y-SZTsS4LqDjeblXYVy7psE0WCSlz8JJcrEdXREswtRtnPlDVyCwW1p0L28eLXeVI0sQ-0Uv9SICHjB3yRqPjxSRFgwYZyCtAL2vk3XwvvwixraqDZvoRIk5SKkPbIowWFJwN8x5MUY1rcLdZ9Y/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.18,
    6.73,
    6.34,
    8.4,
    1,
    7.9,
    8.5,
    9.31,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'three-bottles-silom-silom',                                          -- slug
    'Three bottles Silom',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '286 Si Lom Rd, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.724315500000001,                                                   -- latitude
    100.52194329999999,                                                   -- longitude
    'https://maps.google.com/?cid=4200252370159888484&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJM3Hd9fqZ4jARZGhf2kZLSjo',                                -- google_place_id
    '095 589 2723',                -- phone
    'https://www.facebook.com/profile.php?id=61588090962605',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJM3Hd9fqZ4jARZGhf2kZLSjo/photos/Ab43m-u13rN6eazDx_9Ta-PqX9_LRgJLNloTbQbaJAUqmdg4lIHv9TKWN-qjrojSaQTZdxPMdwIdJiHMtoi73kGEv64wcagZqIlX_gMbzMEHFmznBwYqPWEnsmmqV6FuwUWgDaARF11hK_d0Xs2T_98QtxHS4y3S3GEyvRMku3Nq5vtDPziMut1X4JyfUIfzq0wGHuGQQoIFiXX3n5yXgusbvUAchcOzLp1TZkQybZFXf1_8W4U790sL9TnJ0O9vZ_Rqqbjq0cqaIT0V1--yBH8PbxaLOudZarljljoKDxHgBq8WPA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.24,
    6.65,
    6.2,
    8.66,
    1,
    7.66,
    8.5,
    7.61,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'smalls-jazz-bar-bangkok-silom',                                          -- slug
    'Smalls Jazz Bar Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '186/3 Soi Suan Phlu 1, Khwaeng Thung Maha Mek, Khet Sathon, Krung Thep Maha Nakhon 10120, Thailand',                     -- address
    13.720457699999999,                                                   -- latitude
    100.53762549999999,                                                   -- longitude
    'https://maps.google.com/?cid=11647273440193034590&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJy7WVrzGf4jARXjmM5Htto6E',                                -- google_place_id
    '089 666 5429',                -- phone
    'http://www.facebook.com/smallsbkk',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','jazz','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJy7WVrzGf4jARXjmM5Htto6E/photos/Ab43m-ujwT7tNRYdKCMcCHToM7SlKnVMgfVn4OMtPhUNfE-XLeRae0YUf5SPkvkIJcXn17vn3ppLf9IoU2LSTdNkrrfoZtAR6Hq8rTFMDJ3WlAIERIwRlOLXFvGdNa3DZa2tJe0uQcql1mzLOw3UrCCwcMZA_zOXEYQyAbBnHy4J7iuWpByymHJmVat2EhgfmYquqiJuXntxL1oTDpR9wNkecOzGGlM4w-OyTYeWa99vxaNTCBt20ScTNcjzI9lXLU8d7vVkSliMCQ0A5XE-4DBYaiB6UzJh_7SOQUv0tjc9l-bcMQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.54,
    7.3,
    6.38,
    8.49,
    1,
    8.44,
    8.5,
    8.91,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-bamboo-bar-silom',                                          -- slug
    'The Bamboo Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '48 Oriental Ave, Khwaeng Bang Rak, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7241436,                                                   -- latitude
    100.5139267,                                                   -- longitude
    'https://maps.google.com/?cid=13884515225383238591&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJF0QAycSY4jARv3t4vwi1r8A',                                -- google_place_id
    '02 659 9000',                -- phone
    'https://www.mandarinoriental.com/en/bangkok/chao-phraya-river/dine/the-bamboo-bar?src=loc.yext.mobkk.ggl',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿฿฿',                                            -- price_range
    ARRAY['live-music','premium','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJF0QAycSY4jARv3t4vwi1r8A/photos/Ab43m-tvljAOGSPdnsz2Od4F0xJ2X_Qm4Vyu4oATt4Vxn3O7ocuz6KcQhWTQNCgdpvYcT6g3hZYP3E0iJlLWwIh8_I0sx_E7dKn80bpNWcrCDxqo1-8C9jr99fntUvsk7Wn3ujhBNn5FiSHXW6yQt5GhztJZ4VKqptYYkpmzaV0rfnFDVWxRxpNc3E9vYxl4xYerdy1hOYyCGPOhPi3SRM5u9DbrGVdrNmnSdZyuLcScMJhxlPrNYIIDu2pEopch2uKz1b-zd1g6fQd0Ye4ooX7rnZsXZ84STK6zQgB2jsjJnoHdYw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.91,
    7.23,
    6.09,
    8.54,
    1,
    6.2,
    8.5,
    9.21,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'foojohn-jazz-club-silom',                                          -- slug
    'Foojohn Jazz Club',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'ชั้นที่ 2, 831 Soi Charoen Krung 31, Khwaeng Talat Noi, Khet Samphanthawong, Krung Thep Maha Nakhon 10100, Thailand',                     -- address
    13.7346562,                                                   -- latitude
    100.51415,                                                   -- longitude
    'https://maps.google.com/?cid=7181331530423689308&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ61pVvdiY4jARXGA3hfo2qWM',                                -- google_place_id
    '098 664 9826',                -- phone
    'https://www.facebook.com/Foojohnjazzclub',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','jazz','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ61pVvdiY4jARXGA3hfo2qWM/photos/Ab43m-sdBs-UM5cH75_J9gFWuFTPaSAg0RJyR33cGRpbOPtuBKaJVXOiwMfLPzuDgy9Rz-fDtdfWfv1xe9lVdDEKcnVtvRLrD6n_mPX7L2pkXWm6Sdi5OQD6eVJuBsK2FsnxhR5cWDPOL7l5KiOouf1qm4wQ87p72GVIYkKb7Kfa81ljG99HF6X86IU7W-ha1hleTtQu7sC5SQikikgu_1MUnXc7xxNi3I2p7vObjCRBY9-WvF74BG7Cw_kRA2VGyH3KDLpStWriIohCxtGFtYuemigMZK-4na0XkVU2ExnU-OfgKA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.03,
    7.19,
    6.46,
    8.41,
    1,
    8.18,
    8.5,
    9.32,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'opus-the-italian-wine-bar-restaurant-silom',                                          -- slug
    'Opus The Italian Wine Bar & Restaurant',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '64 Thanon Pan, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7218894,                                                   -- latitude
    100.5234354,                                                   -- longitude
    'https://maps.google.com/?cid=6737591497625382895&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJY9qOds6Y4jAR7y-nEcW7gF0',                                -- google_place_id
    '095 873 3690',                -- phone
    'https://www.facebook.com/OPUSWINEBAR/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['cocktails','wine','premium','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJY9qOds6Y4jAR7y-nEcW7gF0/photos/Ab43m-u4w_lJQLqRUD9AChL4F3GrK6ZdrYDquYUKbZqznHASFov4zIZRJ3mUMESDXJHImfWXaLmKYLbdXkObKQT3acW_Tn2p5E0T_Hi4oi5fnkhDiuEfTqaJH2MzZq9fbdnZ5LVe-N7AOsRCacP8VRlT7WY2q1wBKh85Ro6SGnYgLWXpYXzIWo_Yb1dwdTmkZF06GUR4DnZL3r-YCX-GCpgA1PY-mopD15s72Ln_6bXq216m1OGVcDB2wUQDSwNc4UAeXuELUL5oxQd_xEMDwmRVLWimWMLLMiDYsoRvOwfLPr89mwrFE5FaoRCwyTYaOL1BlNYO_kwBuQTGPr9bN97JanXhOfJNPrKdmhdJvms3AYBR9vwe_rrWpki4kTYaNo1S6PyDD_cIjA0JPEwHUgujcoWxIKp9TcsH5VXIqoTp67-IDYMCEhTGpQQ2WGaJhUkd/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.82,
    6.82,
    8.16,
    6,
    1,
    6.99,
    8.5,
    7.48,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'flte-a-champagne-bollinger-bar-silom',                                          -- slug
    'Flûte a Champagne Bollinger Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '64th Floor, State Tower Bangkok, 1055 Si Lom Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7215201,                                                   -- latitude
    100.5171149,                                                   -- longitude
    'https://maps.google.com/?cid=3076781398381260778&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJAXfqM9uZ4jAR6m8LXmHssio',                                -- google_place_id
    '02 624 9555',                -- phone
    'https://lebua.com/restaurants/flute/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJAXfqM9uZ4jAR6m8LXmHssio/photos/Ab43m-sSX9m6Ma2VKFl0-lCLHsszfnF6g01uo69zA1CRZa2ZidTwAG9nHiv0pIOkAlxHgHfSav3u1y-6UTrQlR8V_37plHx7blzK4z4WoD1T-ulDJAK1k6-01QNUfgV2Vq_62eJ_-UfXWnag_eaNf5f-sy_Y-NJHoihgQH4Vai5VQD_4FaUEefTP6ixtJ_jAN8s7Ra_FQlfKDOxojAuFUi1dHR91ehjykoHk_ILIoyigEHCfwI0v9jfCKhC6qEBeZi8VrMQ5cMrCjonQPpBlwucNtvkrqNfTOlcURW80XRD1HnxXmtf2vcXl_X6hgOO5zea_pZCjnigC1f8tu7msTrfWvxBaG3dEVvUygPmz7tSvXc-w8e-pLvws1AiSQ4mMc9JEUwLttWMXi2H87HLIaIi7FW740gsaj65DgGuUXhmCr51Phw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.59,
    6.68,
    8.38,
    6.28,
    1,
    7.96,
    8.5,
    7.9,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'revolucion-cocktail-silom',                                          -- slug
    'Revolucion Cocktail',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'No. 981 Holiday Inn Silom Hotel, Room 6, 11 Silom Rd, แขวงสีลม เขตบางรัก กรุงเทพมหานคร 10500, Thailand',                     -- address
    13.7230031,                                                   -- latitude
    100.51938969999999,                                                   -- longitude
    'https://maps.google.com/?cid=1861899764713671345&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJtfy1Es2Y4jARsUoko_jL1hk',                                -- google_place_id
    '063 785 2703',                -- phone
    'http://www.facebook.com/RevolucionCocktailBangkok',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJtfy1Es2Y4jARsUoko_jL1hk/photos/Ab43m-sdZg4Q5nxJffekBmOufTi8YXw8KtempKpPDxt-iksrfDPtcCrdWPN0MdUiQ1Y_Y45dGmbUCQFBfsVLPV7LLh-t9DJ60mVnUeggKkp74x5XaYuJ9B-5dKJKJwdEvAlSLoxnjzXzykCcWI_5w2iBtsR0h7z93ma_bXIcY9jrhYE1N3gI0llty3ClQem41ZACJmvFLTC4CY01m-pxZZcSapPCtbixBygtWnghTo_-FZVOTqqLF_NC-5AS2CHM1V3o3P2NY4Zt1HRZMFn0lJv_RTxMHIbVxLeggRVpo6G6yPS6MuNGOPfq5xJ3kabA_CdgGSH5MXbkUxp3JSlq7Vr6S3DGxxx6rqJgE4LC5mV8lrKbP_w42iNoDtUi72VgP9IDgtaGJ2kPI1HnEn09wtBxblZqXkWoWD54Qn1Pz1z7MMMwwBa1HLnRpBftMcCrK3tO/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.41,
    7.31,
    8.28,
    8.31,
    1,
    7.82,
    8.5,
    9.39,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'vesper-silom',                                          -- slug
    'Vesper',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '10/15 Soi Convent 2, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7270527,                                                   -- latitude
    100.5334589,                                                   -- longitude
    'https://maps.google.com/?cid=2850375628550401308&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJN4leQSyf4jARHG0tQIiRjic',                                -- google_place_id
    NULL,                -- phone
    'http://www.vesperbar.co/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:30 PM – 2:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['cocktails','premium','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJN4leQSyf4jARHG0tQIiRjic/photos/Ab43m-svi64Vz80_VQ6JhvZBPEkwN4zg72Xo9NicWs8_hjjcijHEnrb-4imTH7EEkjgU1y5yccfM2T5SR7iK7X6YAr9jdszUBjBUhNisJ3y5fVbHoGYWyhiL5KoHLWgbELm9nvFmXO5SIVuasaWdO1mzFKZa8PWxx3PE971NZi2sj92K3ukvwk8rTuDFNTjWVGownNLXlowF-QuMqy0maovqjJLro1s7RIYd6m_bdBSl9fc5OtrdlyQnmRLaIHC67toMmzc2FcQo2nOHrvwJCa1f-jXA9PM0jfit-ILMnVarFjfBpQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.99,
    7.39,
    8.3,
    6.44,
    1,
    6.87,
    8.5,
    7.43,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'fuchsia-bkk-silom',                                          -- slug
    'Fuchsia Bkk',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2, 1 และ 2/2 Decho Rd, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.727161599999999,                                                   -- latitude
    100.525008,                                                   -- longitude
    'https://maps.google.com/?cid=10500897450955909279&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJBT9pW_aZ4jARnygIc5iuupE',                                -- google_place_id
    '065 057 8977',                -- phone
    'http://www.fuchsiabkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJBT9pW_aZ4jARnygIc5iuupE/photos/Ab43m-s5xU-Nh7SrlgT39U7yxoVIib5Du9q6vaDfrNCRwGnORnU8cxN2mV0Bm9MlMSNydC-h9Cxd6nWaZZjzitLHFI1lUO7w55AB3ayus4__xLAai29zgipTJFLQU-ljjCNfJPU9A9qB-pxDBMb5iO6ez96oBdFZoZSVBa4lqAPc65x2WloOnkZPvzq_iEJq7iVEgEBE7Zo-JNYqhVFyRvexe4oW9rG9YQ_b9ikMwoDD04KEJ0dC85V49mSg3wf-pAQsFhpAblDUpCbUoDblQEaWqhVqAkDnzszEfqxu9nDVMIuORg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.75,
    7.18,
    6.54,
    7.97,
    1,
    8.08,
    8.5,
    9.05,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'aether-bkk-silom',                                          -- slug
    'AETHER BKK',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '92 Central Park Offices Building, Unit No.HH4401 44th Floor, ถ. พระรามที่ 4 แขวงสีลม เขตบางรัก กรุงเทพมหานคร 10500, Thailand',                     -- address
    13.7284823,                                                   -- latitude
    100.53694349999999,                                                   -- longitude
    'https://maps.google.com/?cid=14095145195823952963&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJQXprckif4jARQ_SjVuADnMM',                                -- google_place_id
    '061 174 5125',                -- phone
    'https://www.aetherbkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJQXprckif4jARQ_SjVuADnMM/photos/Ab43m-tUu-uklheAbqdimf0mKvKjtKgYrCR8uyHSLhz0s8yOAxtXUWuPGH-taXNmptfBMXN2Snt50gntjw1etTq-BAuAA9f1dIYOZOmY211CcBRMRcc7RWim3gVVubiE_gk6BVIkKua0wcco4gughjE51ZMLISkYVwbDI5shsTo25gcGGeUQuyAixDF6IZa_CeJzD1jYpq3FIjDpw-Z5GMsy8IHWAxlmVtM0sc-EAgx-9YcatX58SjL4CoczKE4MuHJ_38LeMu6x-Oo60bAARUUWf2EG5bmdM0yPbW_6ECo8MviNmA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.48,
    7.21,
    9.28,
    6.06,
    1,
    8.42,
    8.5,
    8.18,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'siwilai-sound-club-silom',                                          -- slug
    'SIWILAI Sound Club',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1262 1264 1266 ถ. เจริญกรุง Khwaeng Bang Rak, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7245328,                                                   -- latitude
    100.5159786,                                                   -- longitude
    'https://maps.google.com/?cid=2458813023505472747&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ_QkczhmZ4jAR69wl42p1HyI',                                -- google_place_id
    '02 267 0415',                -- phone
    'https://www.instagram.com/siwilaisoundclub/',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ_QkczhmZ4jAR69wl42p1HyI/photos/Ab43m-sxVf6EL6dzCn2ORLX4QsTNunyhM9TThLOHMhJsQOsjaRV8GTfIM-G6yVHSQ2-ItvS7Ju1R5iE7EyBNDqQzM-DqXbBwEIXcrTKQHRO5onNC7EMt8uwkrAIh8jo-xUMPQOU13s1J4bufzIsR67NwRpr0tOcJ223xh5zgcRyMZJGvmJLRJG9gZM-ou1l0fh21mRi-n7Flp7PG17zw-oESZeR23xyoKfhbhpxMjdFIEUcU2UGJ-SxiCDA7hf_HXJSpE57Fzzz7V5r4CfTbTgrO7cOKU-0urm4wDLknBpeJAPP-ZA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.43,
    6.87,
    6.51,
    8.26,
    1,
    7.72,
    8.5,
    7.38,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'hidden-agenda-silom',                                          -- slug
    'Hidden Agenda',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '651 653 655 657 659 661 663 Si Lom Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7234948,                                                   -- latitude
    100.52099129999999,                                                   -- longitude
    'https://maps.google.com/?cid=3941339868896289061&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJq2jAJgCZ4jARJeGliLpzsjY',                                -- google_place_id
    '099 641 9935',                -- phone
    'http://facebook.com/Hiddenagenda.Baansilom',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 9:00 AM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJq2jAJgCZ4jARJeGliLpzsjY/photos/Ab43m-sm7F7jPfWCZDAFuFdht4ovL9o1bLFjASVbDOJzZAcvN9w6bOxajKAXy_l4RMyLO5a5DatxVjC-muXMPiYUF8dqVtBLIFmJQ8EUdAOasihNEN8g_LUkuSnmx7f1dLiVHzadwHazV9X7QHdpw3KWvhsAy4taFF3GJ_TCciJ1K_qwZKBxPADR7UROsuSJrq3x1wb6eV0HX8K_Bw5UxUR22TNHZS7Qw4xNWCO7zPgPekwNlR1O7YU6lySVQ1PAUSSyTlv_sy1c4-z1jmJgigT9ygNIVJOdJJwudcvdHQsXuT0nN9wAtAYcGidoOWlqL1cvSTrE5W97DzvzRh-VrBoUz4BZ2dAj4iKhmDKEQBR4D_q59jRxnugvmSOk1jvC3P-HGlGo-JI3RaBCfJ3WRw-u9P2tTSV-cehZFx_1JXKXKm47Kw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.42,
    6.61,
    6.53,
    8.81,
    1,
    8.27,
    8.5,
    7.85,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'paddy-reillys-irish-pub-silom',                                          -- slug
    'Paddy Reilly’s Irish Pub',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '111 Sathon Soi 12, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.722909999999999,                                                   -- latitude
    100.52587439999999,                                                   -- longitude
    'https://maps.google.com/?cid=16945295787910250694&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJyYRCWtCZ4jARxkBQNL3IKes',                                -- google_place_id
    '02 125 2115',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 8:00 AM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJyYRCWtCZ4jARxkBQNL3IKes/photos/Ab43m-uAvaAByJOJ0Be1bdvh3W_D_CYq2eZtr4JohiZ1c5Gc8tFz_ZeNLV4LU2sc7hgJYplRMgFk8OPpldNqWL21Qg7OrHKPkR3CvvMX263-uSfLzoMHKSX50ZUm18DZRCfySMydJ7rtWyPVIZ7s_ucsy8ZGxV8ycefmavp1hA6F811cHzxW65W8J4E3a93WOt5T1c15GWoyhbDoKk4TeVsoOd6F8idVDmaxonL81BsOwG03MLZbG6e_idrYLU0obiQJC8vrBZuTP83Zwp-tuhFqSZgOPlfVTfXaKksW9NZtoJ0hUc1ZDWCQLkvQNKXqnmWyaBUWjQhNHPuiWBZ1-XqReqKI43B8GUN2mIXQCS4hXRqF057IO_Vebd634IGY4MjfLKSHYim1YXc0IuUbA4r_9MGBzWFedG_M205vYl0Wl0kZp66b/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.55,
    8.91,
    5.79,
    5.88,
    1,
    8.17,
    8.5,
    7.44,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'three-sixty-lounge-silom',                                          -- slug
    'Three Sixty Lounge',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '123 Charoen Nakhon Rd, Khwaeng Khlong Ton Sai, Khet Khlong San, Krung Thep Maha Nakhon 10600, Thailand',                     -- address
    13.7288002,                                                   -- latitude
    100.5113133,                                                   -- longitude
    'https://maps.google.com/?cid=16085786411417525299&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJbSLDx92Y4jARM9xY2YMxPN8',                                -- google_place_id
    '02 442 2062',                -- phone
    'http://www3.hilton.com/en/hotels/thailand/millennium-hilton-bangkok-BKKHITW/dining/index.html',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJbSLDx92Y4jARM9xY2YMxPN8/photos/Ab43m-vPlp0tyCC906S8nc_lxV-7vQakdY6q346bGH2Xt1lyhX69FupJNp9QndDg4kfLOSdtenQ69QvqCm-CsgAh49do4Q8Uns0dOdZBCQJ763Ai6RIrUAE6XxKO5D7Dc6Pmod5WXv1P2mWSsntZgPcQaEFE3mmF6DZwToAn9MiozCGSQ1CZ8rqTp5RlAjfIqCCFRexbJKdGTZ47czeKKts74ZauYYitLBhre_d9LvgQd5V8S73z88xlbfIth3vxsWvYqFbdyKKZ-1Bor9ord489Xoi8ws6kVhJH1ETgy3jnOiSlhQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.25,
    7.28,
    5.76,
    8.46,
    1,
    8.47,
    8.5,
    8.88,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'heaven-rooftop-bar-lounge-silom',                                          -- slug
    'Heaven Rooftop Bar & Lounge',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '491, สีลมพลาซ่า 43-44 Si Lom Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.725833999999999,                                                   -- latitude
    100.5277861,                                                   -- longitude
    'https://maps.google.com/?cid=2516825767102325235&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJVcwGJdOY4jAR8yGvUbOP7SI',                                -- google_place_id
    '02 233 6666',                -- phone
    'http://www.heavenbkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJVcwGJdOY4jAR8yGvUbOP7SI/photos/Ab43m-uQgmw8HtIDDbk8YyK9GY67-NTP7JZWvjrhDR-hkbIUyrcW4iJNEEsTQP-UIfsmy1qNxkfQbQeW78-h8L7wU_lESUN7Fb4_3ZfCRNym3WojNeKU2lZMWRCkgx7iz0PdEIC8Nj87AWI7xfwuSrPhj9P0qQ-sj-3Hl31goCbz5nYxktugCZlzwubaKKk-CEUO_Hzpjf3tt6JEgDX5HPH4M5juNMfTDIR4nxXMzJcUuh8oCmbCHLLBTSD7gW6UOYQJ-rsf6JYq4JW862DKtF3OkWBc14p3KT2O6HTiO4syId1QngM3ERKB5ms7VK-9wJ97KD6RcA13f9q0EMpe26ihjeOua3YjkzsP9jtmdlNdByuFed-0vmddXvjfjJRJG5ZQ5ksYP2rzHAUkcRiZeqoVLwBBeEyMqJStnKd2JpcOVDqksvkQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.27,
    7.79,
    8.32,
    5.85,
    1,
    7.66,
    8.5,
    7.69,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'unculture-silom-rooftop-bar-silom',                                          -- slug
    'Unculture Silom Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '36 38 Thanon Naradhiwat Rajanagarindra, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7256334,                                                   -- latitude
    100.5280185,                                                   -- longitude
    'https://maps.google.com/?cid=976731027096858450&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJEc_x3gWZ4jARUu81t7ELjg0',                                -- google_place_id
    '082 366 1666',                -- phone
    'https://linktr.ee/unculture.bangkok',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJEc_x3gWZ4jARUu81t7ELjg0/photos/Ab43m-v5Nmz0dxtFy-MvG4cVgrSLRlC4DBhixejF954xMo0Mn1GoT8p-33n3HnR1vTFtb0hSmjeq_VSilqu8qKCTr9x9lV10vYgCRYDuyOdnNrzDt958VI9WZZJMQtealiWh8uU4VEJSjlUuBIZcvl6tt2y20XpFonZTMrrHVo-O8yoVJt_Iio90IMSBCH730t2s8-Y5KqA935Xx1iLlMFZRWGN7V8Qjeke47ww8FNoHxo3iDSO4nsG6Dh2l3fAfuRsbY4Bk4rV-SlerfADJhNADEU6WgHZ4bLbL888qWervCdIZtw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.86,
    6.9,
    7.86,
    5.96,
    1,
    7.98,
    8.5,
    7.82,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'joes-whisper-silom',                                          -- slug
    'Joe’s Whisper',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '485, 15,16 Thanon Naradhiwat Rajanagarindra, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.725515,                                                   -- latitude
    100.52812469999999,                                                   -- longitude
    'https://maps.google.com/?cid=13311616949906639142&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJSaDGytmZ4jARJglBhRZdvLg',                                -- google_place_id
    '092 874 4445',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJSaDGytmZ4jARJglBhRZdvLg/photos/Ab43m-v3pYgV98AnC2-pC81zLSNya5CXoLqNUcglyQ67ka4_pu3PcHZpt35Rme_P_5pgGbTKJByTJHDTi-JxMmVan-zpwt2XDdAVH-ODO-hvK4OFd6V2WIPBsueDOr0NBLZFgOb7SF8CJI8vpH7xI-dTORXN_4ClSvkyOfZXUsbeYOScgVPFnUWH00DPYXtzbNxPXzUB2ZI95NAKyY-rYxuBwf9vswkRGIT_jmib7NLSr8j6A6wHyavSjrTXgDCzJpXZTnU6opBXNLIDITYgbTRdxSI6QJl_cNWN6Th0wEXumFYlcg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.47,
    6.57,
    6.07,
    8.24,
    1,
    7.88,
    8.5,
    7.73,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'buddys-bar-and-grill-silom-silom',                                          -- slug
    'Buddy’s Bar and Grill (Silom)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '174 Si Lom Rd, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.725610399999999,                                                   -- latitude
    100.5255869,                                                   -- longitude
    'https://maps.google.com/?cid=14398977887762707856&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJI1IsRtKY4jARkPXMkBly08c',                                -- google_place_id
    '02 235 4677',                -- phone
    'https://buddybarbangkok.com/locations/silom/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJI1IsRtKY4jARkPXMkBly08c/photos/Ab43m-sDu6ljBPBEnihK8xTcUmufP4FTx194XVzhxL1NWKcB5fG0I3PB1ljS0wk6hmEQ6KvHx5D4FmX4UtHW5oyin_LCNCD0rJ_hK1it2OaSt_WyE4ekATWpJcHlsMbHBlgMrEleXFAciflQKxqAC-b8vDHczx8PkDYmEbxh0_oy1GfE3QX36rjRgpwHBHDY8JOogJz4zdeoRTI2t6euddpWYo-x-pJ2xisKsjv3kvEAAkvp76ySQHwdECFRKyi90bT5w7sGCSALhonY5HiyzUIgXYerXZv3vXsFVPW9jWvsCEtKbQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.46,
    8.63,
    6.41,
    5.63,
    1,
    8.01,
    8.5,
    7.62,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'crimson-room-silom',                                          -- slug
    'Crimson Room',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '87 Lang Suan Rd, Khwaeng Lumphini, Pathum Wan, Krung Thep Maha Nakhon 10330, Thailand',                     -- address
    13.736739,                                                   -- latitude
    100.5429571,                                                   -- longitude
    'https://maps.google.com/?cid=17679597433532187366&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJT3OENgKf4jAR5gKY_TGMWvU',                                -- google_place_id
    '062 259 2525',                -- phone
    'https://www.crimsonroombkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿฿฿',                                            -- price_range
    ARRAY['live-music','premium','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJT3OENgKf4jAR5gKY_TGMWvU/photos/Ab43m-tXarqWrCnFpffBfk1hdAk_WPl1hbP9eZa23cxK3USHSxin4g5BAlbQ6TJjjIAKhnn1fGXIVwx9N-Gv7sq3Sr1CbyYpEgRHkH8-8Idlp8lUKDGFVcgJGDEFTV2i2hCu_Z_zcgq-CqmiH7fUz9ZoH6ZuVsZQHydx7wj-NMHWyw6eaDmFo3nlke1qovXwzrEfhlhom2zlaXMzbmwQcwGxrbipMXYnSTrPJoZXS770DRMhlaxIS2bMGBgvzfRcqGFg-w2c_RgG_icbmJ5j5uK4NH-QCXdEMtYpX3gZ4aDYT8gDvA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.24,
    6.66,
    6.39,
    8.8,
    1,
    6.47,
    8.5,
    7.21,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'brown-sugar-silom',                                          -- slug
    'BROWN SUGAR',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '18 ซ. นานา Khwaeng Pom Prap, Khet Pom Prap Sattru Phai, Krung Thep Maha Nakhon 10100, Thailand',                     -- address
    13.7400381,                                                   -- latitude
    100.51403119999999,                                                   -- longitude
    'https://maps.google.com/?cid=7822061572392788769&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJvVYzLGuZ4jARIaO0mY6LjWw',                                -- google_place_id
    '063 794 9895',                -- phone
    'https://www.facebook.com/brownsugarbangkok/',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJvVYzLGuZ4jARIaO0mY6LjWw/photos/Ab43m-tYtLzXA_gnw47wBLrClWzcCfe8xFQU3bQpb9MoQHN4Zdb8Yh4Geuv5_JKJ3yblp-hgAR6df883QyI_m80zxsXcneP3f8DR3k4Y54zs9vnxpOs6aN-qB_Dlgc0BdqWFqEsO2jrw8-3Suy5Ij5UjJHy8f1fxukib85XAKXAjeBNebRAA5A97jstTClkAV-7HfsHcmodaTOJU--G2w9-DAHwIwRlDrmHHs4wKvxPbWwkuGyR1tbDtWZPCcSUcMV50Ppq6ChdBCM5n5BJ7-m2_oR6_wr7H4dQYomVf80q5McJPuAtmnUsMIcVJg1RJNW691bl7ZfjtW9QcHvdpsn22J1actaRuvXgv_y93G-e4GcQ5t9RZK4ZHosL4YCyzUgfhSBupYAZz0q7xoc0MJaglCYpcjkmPQe8G7pqJuTASfV0RBORYuiKzT7MMu_2MmM60/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.81,
    7.67,
    6.05,
    8.39,
    1,
    7.89,
    8.5,
    8.93,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'club-koi-soi-thaniya-silom',                                          -- slug
    'Club Koi (Soi Thaniya)',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '9/2-3 Soi, ถ. ธนิยะ Suriyawongse, เขตบางรัก กรุงเทพมหานคร 10500, Thailand',                     -- address
    13.7296955,                                                   -- latitude
    100.5334726,                                                   -- longitude
    'https://maps.google.com/?cid=9140888360630840674&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJkd9DYSmf4jARYm3nkoj12n4',                                -- google_place_id
    '083 067 1851',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJkd9DYSmf4jARYm3nkoj12n4/photos/Ab43m-tpHFXDkY1EjRvlc5IAzf56BUOI6Dzi_5M2hw4tHmynFkp8OuysoOK1HqDg9pfosv8iINd3xBFNkEDEDqC67uu6GKue3uNLSD8HUJpabCRFkoOF5KFjAQ41O_espEo6XUV2y_vkf2s7ETPQXLRoxsHItlNG6d59fOqUbu1IOVFU_Kr7US8U9XxjA-iLj25wvcTyQVSuiAmMsH86YDiuS7zHCVubO9e9FCzX6AQGN1EVAGyLOuRE0OEJZvFrzcv9CFD2s0gacftYkRFMDbv-G98z2zixRscGdEdeTFuRAkr_AA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.88,
    7.1,
    6.11,
    8.27,
    1,
    7.92,
    8.5,
    9.07,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'distil-bar-silom',                                          -- slug
    'Distil Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '64th Floor, State Tower Bangkok, 1055 Si Lom Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7212052,                                                   -- latitude
    100.5172142,                                                   -- longitude
    'https://maps.google.com/?cid=16259115058028465182&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJl3RwbMWY4jARHsz9MwD7o-E',                                -- google_place_id
    '02 624 9555',                -- phone
    'https://lebua.com/restaurants/distil/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJl3RwbMWY4jARHsz9MwD7o-E/photos/Ab43m-szJ6riRdn-xuBhEd_Xq-C1S4Zexw94_27gnIxP2cTdFflXn9ISaYMInfjfVRCyv4bybsXoQJmY7dRFFAQBK-VlRlRsR66HWDLZh1rdAwo6QLmqcY6xt9uxofPG32GoXVcGm5gMNUAnoUSSNDohdIzzPAfsUiP73tILGkkn9HjayrmwpTr0ajSB5O641HT98LGfLTX9GDipE0o_fvasKZMuRw21ZmiL4EjxPZ6Lt3eVczY-rALE4skdqK3pY2y4PuybmmEIwPJafs1QkYWjNlUopg8tdBj_HXsQ8Xs4lazSow/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.8,
    7.09,
    9.25,
    6.22,
    1,
    7.68,
    8.5,
    8.09,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'omalleys-irish-pub-silom',                                          -- slug
    'O''Malley''s Irish Pub',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Basement, United Center Building, 323 ถ.สีลม แขวงสีลม เขตบางรัก กรุงเทพมหานคร 10500, Thailand',                     -- address
    13.7270469,                                                   -- latitude
    100.531311,                                                   -- longitude
    'https://maps.google.com/?cid=1221077953959792231&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJlbzDn96f4jARZ47V-O0j8hA',                                -- google_place_id
    '02 234 2875',                -- phone
    'https://www.facebook.com/omalleysbkk',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJlbzDn96f4jARZ47V-O0j8hA/photos/Ab43m-sRdGYw2WMyjaaigL5aWpoQfWodsoThApi2WB_80XXW7a2asUDlEZgTGyFOmsewSHUXYMZI1nNszsbT1nMxX7ANU6jBnnBHsc4bo04yxxNdfsGBDHCiZHQ18N6SavsFZ-hmknjBuBP3Ld8BVuYLDWm2s5BOf2RcStqOThuKCopbQGCyIpgi2frY98q8LEZ1mMxWt3wQt-RnlceXej7HmO4h9UooXa0Wl4zXK0MIbPb0mfdNjRZ_tD-lXOoaa9UZUKnkPD6L8yzSEDJGyTZAt-aBaHEdLmQOxo48PpLSpv4yig/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.79,
    6.61,
    5.76,
    8.43,
    1,
    8,
    8.5,
    7.64,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'shenanigans-silom',                                          -- slug
    'Shenanigans',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '840 Surawong Rd, Khwaeng Si Phraya, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.729698400000002,                                                   -- latitude
    100.5315322,                                                   -- longitude
    'https://maps.google.com/?cid=4235049826517275374&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJddTLz0af4jAR7lKkA2HrxTo',                                -- google_place_id
    '096 950 6584',                -- phone
    'https://web.facebook.com/ShenanigansBangkok/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 9:00 AM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJddTLz0af4jAR7lKkA2HrxTo/photos/Ab43m-sXY5L1kaMGO64sgYf8VHgV4-n1KN2mpmH3jsuVOqOI4A62ygvk9VmTwqMO3DWGC_XcNhxy0_c7SMcpLqqwRXt0NhpNZMZBXeRIN4Sr3chNY6upoU2hbH9D9Ja3kgsjAmlnGLyr_DgE8fTG9PdmZgGl3aOv9tGGnSAsNtMAEj_UVDfag4W7iJ6UjH4xz1hAQ7Wj3_OOObUe1ZJBdzcw5bWq3wZ6Zrw5ucQl-hJ-2Ec84_krkP4i-xAW6HyzH9YOADWYvx4lxHRMyPfuR0tg9X4L9GViqNBU4hm8Z0lVz5WYJA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.81,
    7.18,
    6.03,
    8.48,
    1,
    7.86,
    8.5,
    7.37,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'wine-connection-silom-complex-silom',                                          -- slug
    'Wine Connection Silom Complex',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '191 Si Lom Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.728509299999999,                                                   -- latitude
    100.5349782,                                                   -- longitude
    'https://maps.google.com/?cid=4654720681686066034&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ91M1Aiyf4jARcuOPWMzjmEA',                                -- google_place_id
    '02 231 3149',                -- phone
    'https://wineconnection.co.th/?utm_source=gbp&utm_medium=WC-SilomComplex&utm_campaign=gbp&utm_id=GBP',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 10:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ91M1Aiyf4jARcuOPWMzjmEA/photos/Ab43m-se23SmkQ0B34JZMTmkU8SrMgGEw-FNUu2yD4_TbUP7o6on9N5CxN5edViWsu-t37IEUSgGkTFA5qlem54ltbJQ6-0r1TZSvqM3B5hrsCUcT9-U-MeENHM8ozOyMbKjXtJp1Q2pIviepmp4ETJ-nlzqR0xKSuNKVBJvzbWBWBDHDlw0xRAcCJgKaAiV2kwVbrSzwCZxuz4_vG-aWd19Xb4vlULBcshQaCp6ACBFuaghlFex3mmhsTitlIaqS0kFjeXXGr06efETw9KToPNlZP6krkUK6sZLXDOVDcJ19LYcdA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.13,
    6.72,
    8.32,
    5.84,
    1,
    8.31,
    8.5,
    7.78,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'muzzik-cafe-silom',                                          -- slug
    'Muzzik Cafe',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '22 Thanon Phat Phong, Khwaeng Suriya Wong, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.728786,                                                   -- latitude
    100.53191299999999,                                                   -- longitude
    'https://maps.google.com/?cid=17011395632530122580&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJi4d_giyf4jARVOeWkjKeFOw',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJi4d_giyf4jARVOeWkjKeFOw/photos/Ab43m-vDfExSui5_CvXlYJYmu00OblM3spaftJ8tPyIVeUVm18Jxl2GaCoABmMgHNiN1U9r4fPJAdlKVNpgefdWnfg1NFeIZcHA3VM_-tOsj-SLccn5dOiUHApnrQvpJF4VGjCK0TqQbwmKDYxbeTj3uTtYakWOe-Yn44D_QMjUtzuU1gZtG3bqnUtbWvLodYbmtFvj1y6_hnMRehz-Ef4LJ-2D4UJjLHrYzg48lIauauCw0eGr93qIkvG76vepyk7KXEIOCTJYi60rmxun_S7uB7-7cLbjWp_Cy6IypuWNIAVtO7tCCZFiysnDUm5x6xPOa0N-5TgBvTI88lfLiw4af0LBVc7T6L7LUjNfg82XJH1vXrTG1XaytnJyFeEST4Gpq0HoQJywzlcqchwu-tIPrAW3WKivBaQCKMDOHkKN4TqI/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.74,
    7.01,
    6.11,
    8.1,
    1,
    7.95,
    8.5,
    7.61,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'local-wine-bar-silom',                                          -- slug
    'Local wine bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '389 Si Lom Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.7266108,                                                   -- latitude
    100.52939169999999,                                                   -- longitude
    'https://maps.google.com/?cid=5651031466530980331&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJEa9Ie2yZ4jAR60EiqS1_bE4',                                -- google_place_id
    '061 496 1932',                -- phone
    'https://www.facebook.com/lcwb.bkk/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJEa9Ie2yZ4jAR60EiqS1_bE4/photos/Ab43m-sMmmJrmHpgOT4WRGcKrfsaCxcypi3Zf62xK76Mc2FHojZ4iFiaMV_amlk2qzLuJ83A_INmql6MUGqI1DVjlIA92i4Z-Nqa5Z0Cqjk6qyPIBu1OOo3uFWqF3ItM5WtArCWYhLyAa4eeKVyVxg6xXxLxZp05-6n2L0Vtj_wiMhQf8eL7ZxFLYxfC_7VYNluCldfEFkmYcEEkw2oolPrbpQQMw8iABiJ9X9sS9bw0fVIKhlWxw9lDMYzXIYwc-1i3u6pt7imTAdH0k6uGN0Ih_ikeJNnKPQ6aAOa7dAXR4BNHSaa0m_aUvFX-gtE8p7RbVeuLkpO38yzYV6Wqmfhmiii4vKxVZXBHalhTwCDBRHT0Af4uccJ2Pyvhs0IQ2vxAkETeT67kzow_BLl5E3nMTdTZPNyMd1qRT8z_ceuIDVr7BZNeqv89h6Mdr04vEX_X/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.74,
    6.55,
    8,
    6.27,
    1,
    7.95,
    8.5,
    7.53,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'sky-bar-silom',                                          -- slug
    'Sky Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '64th Floor, State Tower Bangkok, 1055 Si Lom Rd, Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.721423099999999,                                                   -- latitude
    100.5168806,                                                   -- longitude
    'https://maps.google.com/?cid=6421553283667762893&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJVTBnbMWY4jARzZ5CS7DwHVk',                                -- google_place_id
    '02 624 9555',                -- phone
    'http://www.lebua.com/sky-bar',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:30 AM',                                           -- opening_hours
    '฿฿฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','city-views','premium','popular','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJVTBnbMWY4jARzZ5CS7DwHVk/photos/Ab43m-s37S9kyq9rnLV4HUrI6j1tvCu_I8u4xOL31kfWZwT7kEhTufN_5Xe8-EQg_JwUZN3ACrjhLZIlrl820JpHjztn3dsLEcrWCNRYiYFptzD884wBh73URA6z95_cq4dZ4fkVRmbs18LRJV7rlN7kfAIdtlKH6du32E3z8HAuWdiSJ3el-1IMmRqlqxNKQRxtWssVvYFflbaark5xpEdRnfUnhLRsc8f4r6RCOz7DwT9R4LsLJQOGmICwu29g__zRPpzUcrSACqGcuNH0jYW6jrt-kWU9Pqs3N9Ed87Ds94DQWw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.24,
    7.72,
    6.1,
    7.66,
    5.35,
    6.55,
    8.5,
    9.11,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'triple-xxx-lounge-silom',                                          -- slug
    'Triple XXX Lounge',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '9, 8 Thanon Patpong 2 Si Lom, Khet Bang Rak, Krung Thep Maha Nakhon 10500, Thailand',                     -- address
    13.728502599999999,                                                   -- latitude
    100.532356,                                                   -- longitude
    'https://maps.google.com/?cid=510397840179573015&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJkYGOoIaf4jARF7EHpiFMFQc',                                -- google_place_id
    '088 999 3191',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:30 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJkYGOoIaf4jARF7EHpiFMFQc/photos/Ab43m-sHQKsaLOAHLtTj22dd2n63NUbcEIbxJgggcMlhdiUhHYaB9AItkvpe_2JRkhBFqDpbwVaM74OETHO46klX54OKIFqbjRe7TyEiO4ep3W4d-jxbjpLqyXWCdIeL-cQMZfKMNJz9Lz8VDaJPD-5ajbk0yFmn01b3kUhWTxxtk1axoy-x2Wll28EBa_M0QM04jBfaA9ViLaMG_Q1_M8LbZ_L9aKZSUOZOQ8JGNSX3PsjVzu53f6X1deIlJdIa4UY5-w4HVClU2o6-mU-XaBpbkUVJIRdidXdJ0sN6m19PMkpH6A/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.16,
    7.28,
    6.05,
    7.58,
    1.2,
    7.51,
    8.5,
    8.74,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'banana-room-club-silom',                                          -- slug
    'Banana room club',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'silom'), -- area_id
    'silom',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '114/17 Silom Road., Soi 4, Suriyawong, Bangrak, Bangkok 10500, Thailand',                     -- address
    13.7282976,                                                   -- latitude
    100.5328813,                                                   -- longitude
    'https://maps.google.com/?cid=14444537585138405567&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ-8x6ydGY4jARvxD0OmdOdcg',                                -- google_place_id
    '083 000 0000',                -- phone
    'https://bananaroomclub.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','silom'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ-8x6ydGY4jARvxD0OmdOdcg/photos/Ab43m-s1QVyKQh80YlC0TjvSopq3ETEYMtJL9Sij_eaUqfWMV9fwTJtpL3bEOlm9O_o1OzntmPsFcxAUa1qoGJ1TK3PxXLP5tgfo-AFNOZlUUN8FcEKTec6pXNMqZnhn8XuS0pJX4fr4c0zh_dJfCNMrDTyepYeWrWfiRc5alpD26hRKEJwVKQbyOtnWHo64xSS2Zd8vLfIig3BcvXGUIDmJNqCAr94zojbSNBTLFDkP_8tQgu50Ai40A0ahVMrk6ujY_Mp_lg7Wu4MuIOv06GINLeofUsx6Bb23SZUyMOpJ1wf2D046mHq5FSHDNwvF1NCakHN8sU53jy1AIPGmm2NU9C6FfY_GX0pgfGtPL8t5Kmo3LDNHuOgbag5XFFtEHxt19YNYcSDle10i5WnHnlyr3seGdt9qMQ_KUjXEfh1W284/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.33,
    7,
    5.94,
    7.9,
    1.7,
    7.64,
    8.5,
    8.63,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'destination-rooftop-bar-thonglor',                                          -- slug
    'Destination RoofTop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '6F, 44/3-4 Soi Thong Lo 13, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.733925999999999,                                                   -- latitude
    100.58000530000001,                                                   -- longitude
    'https://maps.google.com/?cid=8073884048587568473&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJdbozjYqf4jARWTXB0cMyDHA',                                -- google_place_id
    '066 060 6015',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJdbozjYqf4jARWTXB0cMyDHA/photos/Ab43m-unC1iKN5KhlGGW4cPZjQBG_yCRPHwEfIND3itMyR1w0OC4y2EQ6f74Fg5JfMKDrXp7xWMrCFyCBI6I1BjL0_oZ6AslXeEs4Hzfxbv3MDmFSffOssT-XPAyQiGkN8Z-hyDDJIw-UeKH4gWzOvb7YTgjbrOpHUBST_6SWJcN0glf1sKZcbJ2i9SvFjdnhpWuJvrI08LYxiNewmr-hRBM7s8XA2LnkZc20-ikLy0SGj_JwDRI5YpsJoPYnWhkIx6kQ1ZmayvIPIGc6qaQidM3oL2Gh01BoimnTApyBhJ8L5yg2w/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.64,
    7.05,
    8.18,
    6.03,
    1,
    8.31,
    6.5,
    8.14,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'becka-bar-thonglor',                                          -- slug
    'BECKA BAR',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'The Resident on Thong Lo 9 Floor, 73 Sukhumvit 55 (Thonglor Khwaeng Khlong Tan Nuea, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7394319,                                                   -- latitude
    100.58427069999999,                                                   -- longitude
    'https://maps.google.com/?cid=1267822233811631532&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJp7eIDhyf4jARrD2vvJo1mBE',                                -- google_place_id
    NULL,                -- phone
    'https://www.instagram.com/becka.bar?utm_source=ig_web_button_share_sheet&igsh=OGQ5ZDc2ODk2ZA==',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJp7eIDhyf4jARrD2vvJo1mBE/photos/Ab43m-uyC3zGKhBPywE05CbZeU7s7mEq7I38qht40eq4KodzM8N49qN_2OwBtfofMKsd2gisjaj5PvXm1jdL_hTshvHMaXBAvgc1KQyqMgrQ-9siKFPAzCfBobYtm0D627SDZ7QbIIewkqI6UqQSwo98xBV4vgkVv6ao2ehLRU_YYAdSSbWt60v92dsIHRL78xX_H2YH5JpPKtGKUX2a3BEOHBxPYiHIFxK3doDFsYbgFOs5KtqjqLUAB69qkc6DZHUdEmZ7JRSbbETtJQcgZS2Wn4sATyKPgj5sGep7DvWUCKtIAw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.47,
    7.19,
    8.23,
    5.84,
    1,
    7.95,
    6.5,
    8.14,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'sotthonglor-thonglor',                                          -- slug
    'SOT.Thonglor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '413/10 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.738026,                                                   -- latitude
    100.5837849,                                                   -- longitude
    'https://maps.google.com/?cid=436339542335082454&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ70JxDACf4jAR1s9WfoAwDgY',                                -- google_place_id
    '082 149 9987',                -- phone
    'https://www.openlink.co/sot.thonglor',                               -- website
    NULL,                                                     -- instagram_handle
    NULL,                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ70JxDACf4jAR1s9WfoAwDgY/photos/Ab43m-tCIy-WZrgpyjlh3lWn3CAgm2oOuKwqRxl2SciCtYjCkIDrW8hAH8_W-nXiaCBEyU9XFz9rhP-9iO6ahLxRl8xZ0tIHc42MWCO7ZCwS_oQrI6WZNo7Yy9c1tVZ9-GqC-Z5IBhBph1mw7I_Ge5-RKXQVm7NwOU3zASn61sXOcgvAJEv9E8ZwU1Hqjklft5LO2IR9RnDuFGiYCfLlDdTwhh80FgKm2Rw-sa0wVBraqL3f1NHXsMQStrOZWwhpPMRVIVc_YaGyPppRbYOwu0MX0q5VeJB1NpCrJpcVjQdMxusYrMILuuyWll3NqRkUoOFPkZYlBjXMs0odJwmFxOfa3KsUjfigofBLCbUs7Js9SUEvSeUDR2zV7Pxkz4rjaxrSKG5KLD7Neb7zY_U54ruJg8EY29m-VXHHmDrIZjSMujNjMPSikz4OWIo4Z8JHB2cL/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.61,
    7.26,
    6.35,
    8.51,
    1,
    7.73,
    6.5,
    9.17,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'dirty-rabbit-hidden-rooftop-bar-thonglor',                                          -- slug
    'Dirty Rabbit hidden rooftop bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '143/5 Soi Sing Waet Lom, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.73064,                                                   -- latitude
    100.5802521,                                                   -- longitude
    'https://maps.google.com/?cid=10123856476719627575&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJB6Gt-B-f4jARNz3pu9Mpf4w',                                -- google_place_id
    '091 553 5462',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    '8:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJB6Gt-B-f4jARNz3pu9Mpf4w/photos/Ab43m-tXENrSlA5wM841Hl5iHHS9MqF1B-bts3tQZQwBFHpzybm9On8BJb8W-Ffx5JHxR2Y7mVi5x6WJHuS4eQONh7U8H-hlEVxEjaheIDnusv28HA6ETXxNmuuXsFxvwG5MxGQMcylvYvau0ewIZ-Hw_MT5tQrcMJCEQqJ5AU0Pc9V2dD1OhO1bYPdunrWtz3YGH02a0hCX4jMLc1jjQ2x4IizKXs_okfHoIWfXwJkquZSEQgPqd-liFK3it67sH87hW0onrmAva81nC7Frlla6E-6r_aVhOPwterMTa93QgLDgBprvmStmoFQELkAOQpHs6SJic4BWbLVvBnq6kqh2Nwc_ItxO_2PCNpqmoa44DloHnnY241p7pW0G573tQB_a06iOW-L8Q--X8x1y4w13QIgf70cB9Lqajq7nbvgaso0m0Q/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.66,
    6.71,
    9.74,
    6.51,
    1,
    7.76,
    6.5,
    8.09,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'frankies-rooftop-thong-lor-thonglor',                                          -- slug
    'Frankie''s Rooftop Thong Lor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'เลขที่44/5, 44/6 ซอยอรรคพัฒน์, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7338294,                                                   -- latitude
    100.58000530000001,                                                   -- longitude
    'https://maps.google.com/?cid=13525236772900781116&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJacljoz-f4jARPDzNZy9Ls7s',                                -- google_place_id
    '099 796 2630',                -- phone
    'https://linktr.ee/frankies_rooftop_bangkok',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJacljoz-f4jARPDzNZy9Ls7s/photos/Ab43m-uMKdC5JbQ4-aX3lZ1ETOKBN4aJaFv7KCBQs2NhAJm5AlKNvJV8VZZUU-nK3mQLo5tDWvqux2GjPKIbFOuttirhxcd4e7czZiiHCw1fmp-LbTR2oujUk-Q0qDA6tnYie-599MrXrtn7AYhIx0hflf48dJ_Ari_sO2lGN48fYxWBH50OQNhFM3Dg43kru7jZFSeMNqkNfW2CluRWwNHXbSgWDh__2HXsV6aXTUgn2phjwTPeBDb7l7AX5aiuaufzwL7ui_Ndo0upZEERwSFG-WU3oHgAq3koyULK35NW4Lsi8A/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.01,
    6.8,
    9.71,
    6.32,
    1,
    8.04,
    6.5,
    8,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'haus-bangkok-thonglor',                                          -- slug
    'HAUS BANGKOK',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '121 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.729735199999999,                                                   -- latitude
    100.5809645,                                                   -- longitude
    'https://maps.google.com/?cid=2550409642278124142&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ00lNawCf4jARbvq3lw7gZCM',                                -- google_place_id
    '092 269 9959',                -- phone
    'https://hausbkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    NULL,                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ00lNawCf4jARbvq3lw7gZCM/photos/Ab43m-uGGQA7HMTh24D3G8AUFdQLX_2DAmkLLVdeNmIyBTuOhw7IKo_kUlgBz9nFpbtbxXGlWRj9PbbA0dZaP7JtH1AA5QjqU_7sJzYoM5tIJtDZ703wg_H7I6v_aMuo297TH5GtGUXdkNAPhgnJdVkJWrRiLbLLj1julxtkqnL8YIs5UYBmMhwhes8Mx946SjU7_1TRomprwHOmQs0uoGmrmwYApdwMj8fDZN9pwNKPvomPtc2FqbWN3UVGMShusMIR3vHLu_XRevF6XrRShIR3jny-9T_DwWhyyRCUS7vBHg1voi7gSau8VhFkL2g-7P1UOLOItlp6_3tg7LcXsIlBEDdrZ-pJ7OuRdBjOpyW4DT3XN2ZfsA_d4USG4bR6kmPsTcWCOwZk9z-0pO35p6V6hsmBI04-xmSW5FDurZWrfE7X74bM8btkCGtC-YPDZppm/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.09,
    7.74,
    6.41,
    8.64,
    1,
    7.65,
    6.5,
    9.17,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'first-class-thonglor-thonglor',                                          -- slug
    'First Class Thonglor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '261/2 13 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.733692999999999,                                                   -- latitude
    100.5809443,                                                   -- longitude
    'https://maps.google.com/?cid=9861563207297605444&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJbVq_MwCf4jARRB8J_XxP24g',                                -- google_place_id
    '086 062 4245',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJbVq_MwCf4jARRB8J_XxP24g/photos/Ab43m-uNH-WFby3wn_M6v6AsoVMjUzFfAG68C9zqcKkYxHsm_9VcrhWdsfp_wPQErvB3ShRIcZtpIWE_niSPcLfAe7Ggr3dzIE2_hLm9UaAR7vF8Nk3q5rvVKD_t7aXCyAQUI2KCmyvorskcCbHYLAh-pPPmbGK8zkiMlOtQJu5Ugsbpj4EQGyT2tmrw_5HSIG64dPHoRUkrjPc101r7Om67bjxrH6OfBM9kkwvJv8GP6zITxqFEtpBDjQQs9VAPysa7ADtj3s8mQrT2Zv8sWAJehl_L6pQfVaoV0nY7vPj8UUkl_IRyzgswgWcskszujCRbVzST2w8IH2CqmpMOJEqB2h8go1XQDLS38XMCMJsPy1SBkaLfTZO-LiUP3muM_CN1WonLWxWOr8QdtJtIlNpM6GbB-XFw1z5bQH0fwDquiScUF_GDnfrnCdRYLoxog7Mw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.72,
    8.56,
    6.48,
    6.09,
    1,
    8.06,
    6.5,
    7.85,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'shin-bar-thonglor',                                          -- slug
    'SHIN bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'SHIN Bar, 139 Thonglor soi 10 Khlong Ton, แขวงคลองตันเหนือ เขตวัฒนา กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.732379799999999,                                                   -- latitude
    100.5826037,                                                   -- longitude
    'https://maps.google.com/?cid=15138707241685945394&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJK9bW0_mf4jARMgxTKwd-F9I',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJK9bW0_mf4jARMgxTKwd-F9I/photos/Ab43m-tCxWJE_lSeOf-Uikt-pSJPvakdRcVQx_5Nm3t6qBUsRa8tq5mHNgPgEPEN96A43ogqvdBpq1xGpPAaZqCqpWvPZjKwDxSQMcy5vgETCAd7SFrjPH1F2cWA_7WEQXRYhwbY1o-AGLYSWgW0kce5Y0pfZ_yGoufI6X1A5liXLj7wHSuAbYhtvieisq_z3xEqADV0JQyciRs3wKlX4ydy6nWhV4U4iZlEdEY5i6lyXobkJ9VOFOnrsJ-1QzQpk3AffuKxwXm5BYJ2lKWKe5vQ8YAas0WL-1ivKHhyY4uO5dYj0LicOiTNmWBFwji-vKwr3zc1SM9rP-NOgi9AHKcgpjAizFJDPO5M1r_9JXdAHK1c_q3WJL3h50GK6e657grL-n5Wo335kpuT1iuYGJW3UYW-9QfSbJFTQrr3aDCVVskt7Q/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.23,
    6.68,
    8.02,
    6.09,
    1,
    7.65,
    6.5,
    7.65,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'wine-aspect-thonglor',                                          -- slug
    'Wine Aspect',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '113/6 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.728809799999999,                                                   -- latitude
    100.5806813,                                                   -- longitude
    'https://maps.google.com/?cid=8836781869486330918&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJTczr-u-f4jARJlRYgEqOono',                                -- google_place_id
    '081 914 9423',                -- phone
    'http://www.wineaspectbkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 11:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJTczr-u-f4jARJlRYgEqOono/photos/Ab43m-uxsQmlNf8I-1Fo7YgQze-4_WbW9odtKZ_tdowS3LzrOy7y0uW3o0xq1Rch_zpkd0B40SsUHbr1bXAcWSxqehKC4o54jJY-3UtWrFYeLTNDFh8mBYLiBiuBvapi5VwgPfDrOo5TCLASLcjr4UWqjOQppbZtZtobyEMReE3mnOToo2YECPOn5A-VW245eOrYaVbloP7RopCyrkGoLuXM7Jb-FpNhLrpf5InKUBMVfZA_shEozdyaor9pkBy0_94TGOi59ljj0fRaIgXOcPR3XAPXqUCVcTeTvjpjVHG_JBFbgg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.21,
    6.63,
    8.29,
    6.58,
    1,
    7.73,
    6.5,
    7.64,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'stoke-bangkok-thonglor',                                          -- slug
    'Stoke Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '160/20-21 Thonglor Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.730093,                                                   -- latitude
    100.5815496,                                                   -- longitude
    'https://maps.google.com/?cid=8919959001162784967&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJK_UAaAOf4jARxyBbm3MPyns',                                -- google_place_id
    '096 821 6480',                -- phone
    'https://stokebangkok.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJK_UAaAOf4jARxyBbm3MPyns/photos/Ab43m-vAdPqvOVLDmD0WdDKwoMNFn9Tcl6hQ7jCdSSUQS-8FRlYQxGac4T5DUftxMORkN7wASISVfbhku8lpb0GGy_RC53xnJZ5aQznobbJYW4xF5H_t26K6fhkjGZJTr7hdAVbMKAKp_EkPB4FAR4WRRAYaMUNDktwfUDKu9cdNDDLqll5dai5b9A23qlDzkvfqG6CEh1OGxMP2nbkLQ4puBOTaCvgCYLOtFRCLYMoAbUbLqnOhdJCgk66uGUtSNlHrzeir1e_WZHYoJCklab2phV_hbKHV9d4e0H9M4iZo3Q40IA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.09,
    6.61,
    8,
    5.85,
    1,
    8.15,
    6.5,
    7.56,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'gaze-cocktail-bar-thonglor',                                          -- slug
    'Gaze Cocktail Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '10 Thong Lo Road, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.732185099999999,                                                   -- latitude
    100.58305329999999,                                                   -- longitude
    'https://maps.google.com/?cid=13975288029600983261&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJYxLM6GCf4jAR3agiLmsy8sE',                                -- google_place_id
    '091 069 7119',                -- phone
    'https://www.facebook.com/profile.php?id=100092900079970&mibextid=LQQJ4d',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJYxLM6GCf4jAR3agiLmsy8sE/photos/Ab43m-uJv8-xj26u7snjQdfpIBFx_32H9EgdvHKvBv4Q-Q0v85okC98djiYwu3dmRiTaLz_kdm8mGqIrFjv5cme7ha8Mlnml4fr9vlLiBG1glvETgMbIpJhzOB-Cr1WvfYpexjdH7XnsIN2a4lOn0Y86-Xzlalq02IJreP06qk8QkpOBwHI_mav0xXgJEyNvEI17uSJJ-MxickPlSpKS-5ZijvrFzkrQT67CYViZ3dgPdpLyTU9gwBjCyR--ZneyRMJfDQ0PGRcS4eBjEPeVv3u5MPlUhcTBaZZEGOaFzsqT0kZGrATWuXHPcmL1KLTQZAmwxdVNQwU4sU03TvSOB9tFXiTOlRcNkYgbDXWt-GwBvgVMEv3IzH1tLflqafWaIbQ9XMbRuorvLMOxkMUiP-7OsdT5posmCbeP7zpuMUFJzIaewA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.26,
    6.88,
    8.2,
    6.14,
    1,
    8.13,
    6.5,
    7.64,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bar-iris-thonglor',                                          -- slug
    'Bar Iris',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'ชั้น 1 251/1 Soi Thong Lo 13, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7334365,                                                   -- latitude
    100.581341,                                                   -- longitude
    'https://maps.google.com/?cid=9473457271185374233&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJURRv8VCf4jARGXzYEzJ7eIM',                                -- google_place_id
    '084 092 8881',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJURRv8VCf4jARGXzYEzJ7eIM/photos/Ab43m-vD0uaaIt1JVu6lfdhGQv3Sa2VPWgwWJyg9-jy4_4vKhpMcmHTEqfcb0tThGS_2BDZgoDiisd3scl4LRWtLTEBxSA7gDWB3LzIq7zJ_yNE9T_K7e6WbqZxIrAH6GKJCjSEC1sy9VdjZuLE9Gb2USXdxQELa8zpUpLX2T9q7KZJvSkoMXeLun0zX5k0JW6LWRpl0uBQP6b5tGuvxBfMPUsO7a7yu_3dwwZGkroz0N27GtAcuqyqYH_fHNuXzWrPalT1aUdfNpBjBMVO6sgwst_5khk6v4W1cPSTFoG5Na_sX8Q/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.49,
    7.1,
    8.71,
    6,
    1,
    7.64,
    6.5,
    7.75,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-japanese-highball-bar-1923-krung-thep-thonglor-thonglor',                                          -- slug
    'The Japanese Highball Bar 1923 Krung Thep Thonglor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '335 Soi Thong Lo 17, Khwaeng Khlong Toei Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.735091599999999,                                                   -- latitude
    100.5823479,                                                   -- longitude
    'https://maps.google.com/?cid=2803143348715706164&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJuyRvuIef4jARNNeyIgbE5iY',                                -- google_place_id
    '02 002 5748',                -- phone
    'https://linktr.ee/1923_highballbar_krungthep',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJuyRvuIef4jARNNeyIgbE5iY/photos/Ab43m-ujYp94vIV24fOyLepSwoiCtkwhM1C_z_Sq94Yyt-n7CdsMwUK9W8jRd4CXEJ7VgsPLFi6BZlkn-UUN6YLNDm3AIoYPbFLSqwLk_JcufG-k3NtZjdkOAQi62zF0-bOUuH8Ddz2c0JDkSmRO_TF233BZVm7hHk8wnGo8oiZf6y2pM9j9IGLSfaZA8zKdWoREFh78khhmDJPD4MCUFIqyuBleiTYtyWfqy0u5C9IRkcrycL-uOIjPrmkZvWVs_d6sohocdeIibabFtyy5JIyrgw-K0wVeZCAE-qhaAt7IApJbvw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.2,
    6.79,
    8.34,
    5.96,
    1,
    7.53,
    6.5,
    7.71,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'rooftop-bar-by-bang-flora-thonglor',                                          -- slug
    'Rooftop Bar by Bang Flora',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '113, 3 Soi Thong Lo 10, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.731229299999999,                                                   -- latitude
    100.58513780000001,                                                   -- longitude
    'https://maps.google.com/?cid=790606547648556653&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJP3hxjkGf4jARba6wXXfM-Ao',                                -- google_place_id
    '063 196 8161',                -- phone
    'https://bangflora.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJP3hxjkGf4jARba6wXXfM-Ao/photos/Ab43m-vOCZijYwTaLnRX7KehCMl_EiDZKtk2g8gUmQBQkfkj2nr7GWXUhVFYvrRtFjK2pzfDQP82tnLN6ssZUv77-JuHkbmVvWPWNDfOuQRvT_fLWRY03yYpPBns2iCf3dC5FP2qWYgwPGKUNCdRmOHx8PRm2hC3paNWrUM8sWE7FfvYkwYIVW3mmZ6JydDaTDTT6DZFzhN0YPvV7j3fCBIFPF3ijEDzXjOEXzO7lT-7P9_08Ps647ZMZNm3-j9QFXGzToOJg6pUw6d7tzMQLPiCit1hgsS5pt56QxfOl9fXodqqVw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.67,
    7.08,
    8.38,
    6.4,
    1,
    7.9,
    6.5,
    8.06,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'cul-de-sac-thonglor-rooftop-bar-thonglor',                                          -- slug
    'Cul de Sac - Thonglor Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Quartier by Montraj Sukhumvit, 10th Floor, 413 ซ. สุขุมวิท 39 แขวงคลองตันเหนือ เขตวัฒนา กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.737022099999999,                                                   -- latitude
    100.5758671,                                                   -- longitude
    'https://maps.google.com/?cid=7788846001670401834&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJa9RCZwif4jARKi_J4yuKF2w',                                -- google_place_id
    '02 392 7007',                -- phone
    'https://montraj.com/quartier-hotel/cul-de-sac-rooftop-thonglor/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:30 PM – 12:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','rooftop','popular','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJa9RCZwif4jARKi_J4yuKF2w/photos/Ab43m-swIN_0H52bKLDUsRuAYNWSastreSQUER-WNJjeJc3gNTvcYkdMGun5D_X1ynePaR5VIDFKnvBIu4V8Nqmy3wHYnxl-r5u91fdswQ7-f4Kz5LE6iaSV6C36C6_RkW2lM9STZzKiHVYpy7CmbwjtvAZuDpIZhfDgmZDFXqD798AZKEpLtjUHs3qs1jqyIIUDt8SXsXDZpHEy9jawLpSrkptOfatUzemj3r__wVhCMXmq1fZnjOqPoH5hpB4PfSR6Fo7SUnHN8OWLPNcX0CRs84_iZw7a-G8d-PFHl0259-87jA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.58,
    7.23,
    8.35,
    6.53,
    1,
    8.24,
    6.5,
    8.02,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'last-call-bar-bkk-thonglor',                                          -- slug
    'Last Call Bar Bkk',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '413 10-12 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.738083999999999,                                                   -- latitude
    100.5838404,                                                   -- longitude
    'https://maps.google.com/?cid=9169188728310096369&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJQ632OwCf4jAR8WFwZZGAP38',                                -- google_place_id
    '096 612 0532',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    '6:30 PM – 1:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJQ632OwCf4jAR8WFwZZGAP38/photos/Ab43m-tyZY8QPgj3cwQyHHEnbxG4xSp5wx9DO3QExEHo6AJytLcLgubcZ-YGgOLbEDS2ufc5d068_vQz0-PJGAN16HRr-YGQevhBjRpbU5ZaBiCQYSvj5y1ug68ErQq6hT5BaOtYlNJcC1LVpc0P1lJ9Mijwd7XeQCbYKDLgsIn7XYz8Wx8lmyBQlgJ7iPGzJ8Q4VD2cM4lm_NOeHov3LIalemQfuslcGsGYA2-CVMThxGjkPF9JZmdk0hKkYMNHNQZvXwPUY0G8YKTWgR2GCxMwvYVk_N4dPeoNSm7jaKL4bmzokW_bjp6cHSGUJ8Yffmky6U3G3B95x19xG-V3xvcAWJzv-Vl_pGgXbUSPhHtgAz8mLJJAHosyrRybr37rab0iK1uNNdxbsFeKbe-CiT_A1x7tUDH4U9ButeT4mCGWP1gNF6SF4ok5q1AsWi5vK-1S/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.33,
    6.7,
    8.74,
    6.35,
    1,
    8.32,
    6.5,
    7.57,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'rogues-bar-thonglor',                                          -- slug
    'ROGUES Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '10 Sukhumvit 59, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7228262,                                                   -- latitude
    100.5814602,                                                   -- longitude
    'https://maps.google.com/?cid=11161462068632192095&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJP0MbaCOf4jARX4TRjp165Zo',                                -- google_place_id
    '02 760 5999',                -- phone
    'https://rogues-bar.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJP0MbaCOf4jARX4TRjp165Zo/photos/Ab43m-sJa1MvdlRoAU89OLhyj4YmB1pJVNJjdGbfWAuUyaaUnpnI_kt1IcxDcwSPJB8MsjZVkfsSgDRzI0W6DS8_svXDBDPAlXkv-A0dY4spAxLq7bnwcJ8nFjGVZJS0q4ZcSoZKheJYYobB0xk7aK_oNP7xwF5uhYx1augb1UNTuC-hHKLtGDGkodyWGa6Q_yALfOoyYJtx2AJqC-7oOSJksfHL6fMWhdzZlr9yxauuHhe20Py6xq0FN59HyvwsgpYiLdtA3HVoI5zh6AjOE1zFotdcnpKGkaI9Xd3ewZFh6mfQCQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.54,
    7.07,
    8.11,
    5.86,
    1,
    7.9,
    6.5,
    7.47,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'wave-thonglor-thonglor',                                          -- slug
    'Wave Thonglor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '3 Floor, Donki Mall Thonglor, 107 Soi Sukhumvit 63, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7310178,                                                   -- latitude
    100.5854193,                                                   -- longitude
    'https://maps.google.com/?cid=13648529515640431531&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ72z-ZgCf4jARq6MuDkhRab0',                                -- google_place_id
    NULL,                -- phone
    'https://www.instagram.com/wave_thonglor',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ72z-ZgCf4jARq6MuDkhRab0/photos/Ab43m-uAvSWjQ8sVsjiD6BxIl6RNhPL_FHUu7AJc95K_cISehmJ8g12JISiDHB1blXqNWTX3JywVrosYx7PfnTINq29jqS1lkT6UKl35NSJsXGmaVeefCx-yS1JQzQXp_YVySrR3H9GK4r9-g2g_3epoL0tbYpK-t0ZZUUZH13_VzbCNMIvcB_QsZtLRf7cSn03NJ5Zdb33mQGo_971quru9ZB-koaCv-GVvaewfvnZXMUc0tVyVcnJ1omIaTUPMxpwGUqJEFAQGBe4PX3VY7T8Zk8PXLKjqWnisLemNVZDs8lIA-A/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.13,
    7.22,
    8.1,
    6.37,
    1,
    7.99,
    6.5,
    8.1,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'ombra-modern-tavern-seenspace-thonglor',                                          -- slug
    'Ombra Modern Tavern @Seenspace',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '251/1 Soi Thong Lo 13, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.733429399999999,                                                   -- latitude
    100.5812768,                                                   -- longitude
    'https://maps.google.com/?cid=8346539936850406920&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJBesWKrCf4jARCG6Ux9nd1HM',                                -- google_place_id
    '064 790 7343',                -- phone
    'https://www.veneziaseenspace.com/italian-restaurant',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJBesWKrCf4jARCG6Ux9nd1HM/photos/Ab43m-u3zU4Wr4Fvbgj1A4THY5onh2wfQ85xdwvedYVDOfOD1cuk0mAt4qTx6WmYTumDBEj4ujbwwvIfqFf1w1vCOeyRjphtUgsPKOd7jVwmK7c03zQXbolCUkaU-NImBA7pAGedtcBFDUwt_l930eJTjwp1WzjRaK_o6v_3Z9Lk6s_4hdGhI9HyUFzMv8Mzyd2Dzo1ZD-SlnjnFWYAuDrA7lqGCw3QM_BSid6CUOn06hcqXoT66B5E-UBHeQ4XDAc23tXduVWh7tv83dtBqSssbFaWiRTHWrEZ0FzVtyEe0wpo/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.23,
    6.52,
    8.53,
    6.36,
    1,
    8.24,
    6.5,
    7.62,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'lounge-twenty-four-billiards-darts-nightclub-thonglor',                                          -- slug
    'Lounge TWENTY FOUR (Billiards, Darts) / Nightclub',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '160 14 Soi Thong Lo 6, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7301267,                                                   -- latitude
    100.581689,                                                   -- longitude
    'https://maps.google.com/?cid=12733139921251245711&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJY7dIo02f4jARj56GmUsztbA',                                -- google_place_id
    NULL,                -- phone
    'https://x.com/twenty___four24?s=21',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJY7dIo02f4jARj56GmUsztbA/photos/Ab43m-t_XG_j4FpEc2pmyc8TH0yF142qn84NoCXjCF0BJ0jx8T2hWfA2QGexyWackAEeqQa9mK8-ZyHQn3_6m-8ajsJKhOvxQhMZrId5QDHaun_vgPdqrETU1jARc8TJSMlpl3kJf8bmcD0YYjMPxJTvGPZE5I7JXhz4dVn2hToJr4MFrXklYgR3fOlqFhRXkTTSi8gU4cfXcqLnAF3AFVcQ3cuELJpP-qpdiB3wi86oMM1M269blPWLoSFS6rMkKtlrMqeynT5gQzbo-jzRuil2K799kPgKQzsqcUFCp2q-G6n56g/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.75,
    6.74,
    6.3,
    8.2,
    1,
    8.05,
    6.5,
    9.25,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'tiger-club-ekkamai-thonglor',                                          -- slug
    'Tiger Club Ekkamai',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'เวิ้งโบราณ เอกมัย 10 แขวงคลองตันเหนือ เขตวัฒนา Thanon Ekkamai, Khwaeng Khlong Tan Nuea, คลองตัน Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7292212,                                                   -- latitude
    100.5865846,                                                   -- longitude
    'https://maps.google.com/?cid=13717061801109063254&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJY9XwEx6f4jARVoYvMQjLXL4',                                -- google_place_id
    '082 101 8999',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJY9XwEx6f4jARVoYvMQjLXL4/photos/Ab43m-tFO1Gvl6cQMooFSG3icXzV8KzHb8j8ambHh_90TqzsMbFthp2l5bakj3myXCaFwKrqXFIvch0o3xWdFekzYSXaDKwWcirwfG37NNj4zj76RhgOZqlT2a1yS0LUqm7ftqdH5FUklx78YVk-tJRf7lzA4ugVAyDgidVfglegGEn_D_r8YiiPc9fIkH0MrltZ8CuGkov5-6bcccpaJSBVpTlsE790DVWUYAaDpUWUVgSZZlDqzyuJPfX6qHL_2X2bjJ3mpgbbOqIZAg_RoOa4EpU7I7_n6YDVlJVoIsG957AWjUa9qp2VoTuBKZJPooIxHSfwtayQGHW3OHFesNYQv3vyzMkWvsiNS4OQTMFZqCdDn9fAmU74MOhLkKUA3__soGC7RBp-C2i3TR14bfHxoI9rQioxNhOvhCDfeGApNDYeiptE/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.96,
    7.01,
    6.4,
    7.95,
    1,
    8.3,
    6.5,
    9.65,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'off-the-map-thonglor',                                          -- slug
    'Off The Map',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '317, 8 Soi Ekkamai 19, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.737686499999999,                                                   -- latitude
    100.5852158,                                                   -- longitude
    'https://maps.google.com/?cid=13037899259760720973&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJGR0LLi-f4jARTbxdi0zs77Q',                                -- google_place_id
    '062 626 5245',                -- phone
    'https://www.facebook.com/profile.php?id=61588369622796',                               -- website
    NULL,                                                     -- instagram_handle
    '7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJGR0LLi-f4jARTbxdi0zs77Q/photos/Ab43m-uJQxs9o2Lgca2nfDr31z_a19A12d-vHj9IZD3zVdhzm-NyVB4VHByzZ0WfSMDWnGLKYavOaKtUtIV7hW0SH9rKvQndis9XLRGyab_ueopH5FDDkxXVGff9YvwvcHqXSGNIslsYbYHoEOsNbF0v5m9Kj5dumQtTpzbeoA39kg2BYmNclTWca2cZy1Qx5d20bkqeLJIUbeVLEeQErzyeFzzxpgqciPSGcQNLnf5lKEL8XkKlHfrw-65vwClSa0yMTdkAlfG2Swgf9eMEUCGGaeuhZzrG4JqP1bsrhEVIaq4b0vakbuwzwXUt00cn1XIGvqCOdLEAvyHuEnzqfD_bN9Zshxt9e_Lc7E-SD2ZrXAb3mN4he_ozzVnK2wtTIuMz14etUZY9Ap9m8jMiLU1eErTQ3Ab8E99gpx_fxgOEd_3lxEmM5xgGKfC8ZvnB8XUV/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.07,
    6.85,
    6.15,
    8.87,
    1,
    8.16,
    6.5,
    7.71,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'younger-bar-caf-thonglor',                                          -- slug
    'Younger Bar & Café',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '58 8 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7239044,                                                   -- latitude
    100.5795723,                                                   -- longitude
    'https://maps.google.com/?cid=12751428128026510627&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJHUho6cWf4jARI8XxjVIs9rA',                                -- google_place_id
    '095 187 3111',                -- phone
    'http://instagram.com/youngerbkk',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJHUho6cWf4jARI8XxjVIs9rA/photos/Ab43m-sSCaPXPTlFfaCubWN7YWVd703Ol9qyiC31QotIfasI6Ek1eVam3dz-YfLb3esJHYJbOvG-0_aenIXK5yBElayVUMA0JDzmqjp7_-TuIoBTbGgAJaie5b2SyldK9snqMx10s6yG9GaFmPtZHIXLkoJ4Wc_wuvQtuMDim7bZkRFEMbI3lOPXTOZREBC_LkczGO-YD1uefUSO48ME68QbOcslaSlpJgJ7Pp-_OWIsA3jvdYfcwRBDTDUzqiI3xzDQR2-gmC2DU0uX3_lQl4YHkm_SEewqBwJtVHq5vlJNPPYvCw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.59,
    9.27,
    6.2,
    6.2,
    1,
    8.08,
    6.5,
    7.62,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'ravenshade-thonglor',                                          -- slug
    'Ravenshade',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '141 โครงการ UR ชั้น2 Soi Thong Lo 13, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7334511,                                                   -- latitude
    100.57991249999999,                                                   -- longitude
    'https://maps.google.com/?cid=6729507334798655616&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJb8wigzif4jARgEAPPEQDZF0',                                -- google_place_id
    '082 695 4956',                -- phone
    'https://www.facebook.com/ravenshade.thonglor',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJb8wigzif4jARgEAPPEQDZF0/photos/Ab43m-sfMwNBUmUGXgHySyxd0jEorTwCkKB1WS0xjKBuZL8GakOU6tpjKwwTLpA-ouKTw0kWrXx0gAbxoguecnNdB2r6TSuniHmaZbYkdbgPUFRH3rX0eaw1B9WpjdZIID7x2qsygQx5NN7FaEinu3vPn3b--EgnChBFaKNaGLRfO2eOAL0E1giZuLhuLb9M_EFOVqIgWyLn6oJLxjRnC_KPSuYxarUUc7oLHYRjnt6573o_y4EqW0UfxRh7ytmuXNfOnGGFnjiuQ5o8NDAx6jzZQM63gocSTQ8c9DD5EZ0Q7XEuJA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.38,
    9.05,
    6.4,
    6.54,
    1,
    8.14,
    6.5,
    7.77,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'nomonomo-wine-bar-thonglor',                                          -- slug
    'nomonomo wine bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1059 Sukhumvit Rd, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.724070099999999,                                                   -- latitude
    100.5791401,                                                   -- longitude
    'https://maps.google.com/?cid=8257297274029541371&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJn1ync-qf4jAR-wdVJx_Ql3I',                                -- google_place_id
    '083 231 2230',                -- phone
    'https://bangkoknomonomo.com/',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJn1ync-qf4jAR-wdVJx_Ql3I/photos/Ab43m-vt1PG6OH5DpSkt02G_m8rFxkPZ1al0bZvZF5cGjSh7w8Hf7_N39hJSbl17SLWbHqR6LdbD85Yowdo5FdZzvHALJa-ZivQOAGAfn1Wv1f0CzWbq505zj8c_ade7Su4a0fD9tCjtx0tCwTI9Z-SsBtgiMINZeoBz914dMgmKaFYC9YqpwJkJo3xNlKudeOzltZysQjp4PNLiX76OuF1VhDQUdLhE61aBJNHDWYAyNr5j2hNZudgc6jdG6q-ekbWEuqvVbPW3wQY1npobcVs4_3Wr6BySKJW-uvJXj71evWMTEfRrjeTzYbDGc12XApF0zWoagAaCSKUNNO1VdDHk0TpYYal_GiDlzrxRQX4SVr2HGhwZBtQcWzU9H209AA0pCHmecIvJ4JWAkJ1ZKujI-eM70WKK_kjTPk0OR-Esoew/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.28,
    6.91,
    8.28,
    6,
    1,
    8.4,
    6.5,
    7.98,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'dry-wave-cocktail-studio-thonglor',                                          -- slug
    'Dry Wave Cocktail Studio',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'SODALITY 2nd Floor, 263 Soi Thong Lo 13, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.733720499999999,                                                   -- latitude
    100.5806374,                                                   -- longitude
    'https://maps.google.com/?cid=5611417796862774501&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJYRzUEACf4jAR5YxPdMHC300',                                -- google_place_id
    '098 909 3962',                -- phone
    'https://www.instagram.com/drywavecocktailstudio',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJYRzUEACf4jAR5YxPdMHC300/photos/Ab43m-sBsXNXZtTq4BBn4vZUpoNjdTqd1nvpkTAc37IKDiiIzv2Zlqedo9eo0pwdo41GwkfWA7VjZifih8hyvOqx-J1F0HzoeU5a1w_AppRbaWYHA0NcZ9704h8XVUYieJJZw6YWHaSRS7olXxnWisxH_pBo0tnc7JaV_StgHiR2LNyrC8uA4OFBFQy1SZnkfzPHr8SXOjhZypUbO1xFFXGj_cb1SYed1Y67iHnBvf5VKK-C7V1HJ_touVs1ZGYDtdpoGQF7gQ4VsYGUNVl8sBru_NLD4xbL6Fj8JTNf9kqcKgmlaQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.12,
    7.12,
    7.92,
    5.81,
    1,
    7.69,
    6.5,
    7.52,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'lost-in-thaislation-thonglor',                                          -- slug
    'Lost in Thaislation',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1045, 1 Sukhumvit Rd, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.724173799999999,                                                   -- latitude
    100.5789779,                                                   -- longitude
    'https://maps.google.com/?cid=16995656001070296363&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJpR34dD-f4jARK-2HDBaz3Os',                                -- google_place_id
    '063 424 4923',                -- phone
    'https://www.instagram.com/lostinthaislation/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:30 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJpR34dD-f4jARK-2HDBaz3Os/photos/Ab43m-slWZ63AQBpFmBDAdMHTtFr15Wvgjtca32wVarlvB9tiiZ6_qxxIZV-dOVcRvSpv8aoAkFpX2CztQIPvHcdNcQ_4ccY1QMT4te_wn0J0dP7IbYSVcF2VMqt8uXQVHgeta9hqqL-OH5kwq3r6co25WhXk-cLhH1_CqMWG3IVIQFYoFAlGtrUA_u0_JewTFQrHvoMGBwbyC_Jg2qbC8hrUAto7NdRbsuLlYhhaQsGSmvoa2X9l7N9GfSwzK12PRFQiG0aJTmh2Y89DS68jflID3edHnw-jUDcbDtQ_3CAQJQ6rw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.25,
    7,
    8.13,
    6.3,
    1,
    7.51,
    6.5,
    7.87,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'another-round-thonglor',                                          -- slug
    'Another Round',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7338509,                                                   -- latitude
    100.5799625,                                                   -- longitude
    'https://maps.google.com/?cid=5037804015084439740&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJD75XDlKf4jARvAglbw_g6UU',                                -- google_place_id
    '082 441 5366',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJD75XDlKf4jARvAglbw_g6UU/photos/Ab43m-tACDD9dNWHnijbExg9WiOIA3BCwls5mPh3sqgh-oDXAIkQ2vBzp3Hq-CEXYH5SRt8Y0ZQFTXKFZH4yTcHp4UzqzpvOakY0FuU4ihM_s1VO9vOKT8DBfgoXHEoZKyINsyAqYot8Qj0cBymfgcmp3g8vIuUHwZsi3xqqTuN0cV4DIuERvePC0V-DBFj-Ysu060oK8JE7ajFIWdsu8A9qy2W4FKgYgade-9Cqan9jl-EDkHNQrXqixN13jG7u_186BV4Qw6GVooNe61aYxPQOsJdhvUbv1lWp4e5vee0A-FfnstUsxLHpgv-wtpxlXlMpiXWm5wKeC2rJHYCYsj1682GlynEB9iU4Cy4VvqN0xhzuPskjJ-hOnGnlSlCJOCaUcx4Dyn2qEiR6qdbcGurXWVD4-hwsuYm9iE129FnE5zs/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.91,
    7.09,
    8.69,
    6.5,
    1,
    7.57,
    6.5,
    7.44,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'terra-thonglor-10-thonglor',                                          -- slug
    'TERRA Thonglor 10',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'ชั้น 2 , 308 A5 ห้อง ุ 6 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7320982,                                                   -- latitude
    100.5825551,                                                   -- longitude
    'https://maps.google.com/?cid=10337255717464219803&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJhUTRyW-f4jARm6DUT05PdY8',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    NULL,                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','popular','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJhUTRyW-f4jARm6DUT05PdY8/photos/Ab43m-sh2nW8-9sm5zxXlnGR99g1JuOMVnZN7ySIr2S74DjI-8kMoHWB7Nb942jOVohz71SfT71Dl5YYMeSJkxZZtMOR94Oz2tbuWKXF_LbSByX4QEt_XCetPJcy3jBW2Nyh1t13kfbocN1gRAmlkB5IfVjONyn36nq7G0-GqXY3Zj5t83AdL57LFfdLlbwA06NY57RGXlWo69PcjVhoEn7cjpHjy0cN5UlyQWycJhvWfGIIUXyMVxEFJO9bTjzP3szjqAA3shoPBab0YfMPb3RnTD8L7R2zqhQZ4aCsti8rOIjUPWU_Whpsb9Iws_y3lnfa40kJgCUOCaY1-U0_9JIPouDbvUVmKv1v7xTTjQHdX_Oy9qCe4PKlEuot9nKBMA-qEii2ArqSJSxoNDWxXFVnSdDWaoN4Gvc3ey8WOiBoBJGhU4t5/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.01,
    7.22,
    8.61,
    6.11,
    1,
    7.8,
    6.5,
    7.86,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'alzuri-restaurant-lounge-thonglor',                                          -- slug
    'ALZURI RESTAURANT & LOUNGE',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Unit 126/12, 1st Floor, ซ. สุขุมวิท 63 แขวงคลองตันเหนือ sub-district, กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.731446799999999,                                                   -- latitude
    100.5874047,                                                   -- longitude
    'https://maps.google.com/?cid=12845534927334905283&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJqQOoFzGf4jARw5WrNfWBRLI',                                -- google_place_id
    '093 575 0510',                -- phone
    'http://alzuribkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    '5:30 – 11:30 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJqQOoFzGf4jARw5WrNfWBRLI/photos/Ab43m-suVht4AiBBNd5vBIgrESCcThodSLu3S9I6n22o4-jm2bSO7SQavAZVQIPq7Ee2UgwG0RWxmYbcHM9wD53irFCNF6jfehIpeLxoW-g8vOjKMIMItU7fQ_cRtHXBLtXdW8FNgDS_Ej15QGoZwe_ZUan7BFQvFQUnAbCSYuen8X9CouyDjOcTn1YbOQTN-9v1jlfiI2NbF23UwpSvXClLEUtlgcoAeec3_yQNnq7Wpdhc1eAZu51tYbRMWMPpNPmLKgISZWJFMfpUVyJ9UWPcABquYe6IBzZri3il4wqvK1bw5x3gsBWNyl5x0KrekJ0B9mmBKeO4Mkfs2K4_p13sySUPbgE6oqlgCmvKofwFfxxPm-5uvaJXmS4TPnAPtZytK74OKzjGCCOjLkeqaJFLLbjcshcfizGN_sbK5N3FifQU6lemmV9Gvq05r12X6404/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.09,
    7,
    8.35,
    7.77,
    1,
    7.92,
    6.5,
    9.48,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'salone-thonglor',                                          -- slug
    'SALONE',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '217, 8 Soi Sukhumvit 63, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7318778,                                                   -- latitude
    100.5861569,                                                   -- longitude
    'https://maps.google.com/?cid=13676669827796450072&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJuylzLF6f4jARGDscDL9Kzb0',                                -- google_place_id
    '083 982 6262',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    NULL,                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJuylzLF6f4jARGDscDL9Kzb0/photos/Ab43m-t4M3awUb0IBc65YhCg4h9eKaxeVr1k7d26ZvLau4JBlIC9akh917-6bUXnCr7wZP9Pg7BTxV7flmIubHB2JEvL_dvDmfnnN_krxr_b0r7Y5bsRpWrXNCiKjQqWcllhjxFBykfnK_R-5fmB7paG1wu20cfgES3HkAR1CD-Mt8dTDr4BOsK7Ei0Ana5GHX_J6E1xgj85m6eT5GRzJHTjmhnAgwssy4-USvGQs3J6SZ5aBA-3Q40hruMINf_ii5TJ_X-hipYLDLz63xVYkRaC9Sq7C1wSRO64-LkG-pI0LARYBFzbbG2-WpSIqgpOxwzU7meB54RZGofYvpH-KYSk-Vk0A1edWVFvlab-W-L2wXUVBXZ2XdhiWNzrTrZQ_z1tvFRVbzuG8QvSZ2T1o5J_n7z3GbUdah3dhT0tGC6lQ190nA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.64,
    7.57,
    6.54,
    7.88,
    1,
    7.8,
    6.5,
    9.1,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-wine-merchant-thonglor-thonglor',                                          -- slug
    'The Wine Merchant Thonglor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '8, Town Hall Park, 88 Sukhumvit 49, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7327038,                                                   -- latitude
    100.57669080000001,                                                   -- longitude
    'https://maps.google.com/?cid=15162575885009558528&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJfVR9Qv-f4jARABzmwW5KbNI',                                -- google_place_id
    '096 923 5865',                -- phone
    'http://www.thewinemerchant-thailand.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 11:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJfVR9Qv-f4jARABzmwW5KbNI/photos/Ab43m-u1bdX1qCrY-ZWL4vd4uCnGe_gN6czqZqaBoalh2zx_Rno8AF9nFCDWWgWkHF_65KLitvoVi4BrV3_Sa56CgD9mZ989IpCUWszMURH28vZ9d4SITvXRXQMA-GWgbKUbMn8CgJoij_aOTveMARuSN2ZT44neMHTu9Np_cKyuMRBTnZW_uhK54LxJvIF59iH6rBAxp2TMKxGdosBFGmDUxImCyHu3HAQJSdIdIS97deAD9WsLf2uuq3xT6oimubVrTo5FclDzFhvf1jMrd4xxG0kURvv85cm3HHRB1qsMwXMcWQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.59,
    7.01,
    8.5,
    6.24,
    1,
    8.18,
    6.5,
    7.67,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'mamao-bkk-thonglor',                                          -- slug
    'Mamao BKK',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '126/35 , Park Avenue, Ekkamai Road, Khlong Tan Nuea Subdistrict, แขวงคลองตันเหนือ เขตวัฒนา กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.731383899999999,                                                   -- latitude
    100.5871614,                                                   -- longitude
    'https://maps.google.com/?cid=12640915647739000173&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJf1MvVwCf4jARbfUoo86Nba8',                                -- google_place_id
    '082 416 2381',                -- phone
    'https://book.bistrochat.com/mamao-bkk',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJf1MvVwCf4jARbfUoo86Nba8/photos/Ab43m-uQopd9oaAZZmPOeFb7asYJm2eQtzTExq5D6rbY5OQ6hmVBuEDzH2GwVn1xEe5qM2xd-gz1D_gOmCe5cJu_VrbDU895l_mlqvhPZlqbALdn-1qKjMr-kGNBRu3mYQbBY13zaCaWp378h7a2xkTny0Mylz7YaJsHt5TucSbgMe-52VSarVu8SMebaAAF237LIUDz2G16tj_8WOCJMvXc3oDCdq1cMgL9X8v3LOnVtyNJzhE-0QbvgGWX1z1dZHOvJdHDgk__qsuDWYERZK4uAEdY9J1cuqPxaIVpV--G30Bj9w/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.01,
    6.69,
    8.09,
    6.29,
    1,
    7.76,
    6.5,
    7.61,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'tt-rooftop-bar-thonglor',                                          -- slug
    'Tt Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1059 (4th floor, ถ. สุขุมวิท Klongton Nua, เขตวัฒนา กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.724046399999999,                                                   -- latitude
    100.5791332,                                                   -- longitude
    'https://maps.google.com/?cid=5663383398845380221&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ123TZvKf4jARffYFAzJhmE4',                                -- google_place_id
    '083 231 2230',                -- phone
    'https://www.facebook.com/TTrooftopbar/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 4:00 PM – 12:00 AM',                                           -- opening_hours
    '฿',                                            -- price_range
    ARRAY['rooftop','city-views','cheap','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ123TZvKf4jARffYFAzJhmE4/photos/Ab43m-u8fbMBBIj53b-uv23gaF4_MVc7C-2mSzWweJYAp08xkSNAWmo42FTfsjwez_06NW_iFj35sAUa4URrrXvV0ZEBQO_0l1TTNeKpG4xFcA0BIrMMpiNblOCdZaGtBjp08nuZH8DKs4beRs0j2C352yQl8h87ydJga5aAbeBaQ1xwtAoQy-zSXCTcye2LLg1i2HTxHu8VY3SCxcqdr2usoJOE1jKr5echKNtck69MroYBIbGwKOi3RhZ8uhQC3JPg3YYmcluyYxRzWOSJxChrqe4YQQaXIIaM72yADDqn8m_xEQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.16,
    7.04,
    9.37,
    6.42,
    1,
    9.17,
    6.5,
    8.08,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'assembly-point-thonglor-thonglor',                                          -- slug
    'Assembly Point Thonglor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '289 1 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7338595,                                                   -- latitude
    100.5824119,                                                   -- longitude
    'https://maps.google.com/?cid=13108640930038442061&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJyU3R-Sef4jARTWgWK3k_67U',                                -- google_place_id
    '02 712 7227',                -- phone
    'https://www.facebook.com/AssemblypointTH/',                               -- website
    NULL,                                                     -- instagram_handle
    '6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJyU3R-Sef4jARTWgWK3k_67U/photos/Ab43m-tqh765I29pLLTiu_nz_xdP8ndMTM70hrRiTq6R_Dw8K8HRIN7-0pFkO6JIOO3vgKwJ0uWoQPuK34VQSpKwwjCPNoMcaPU_GCyZftzae7qLUkvknQCAI3Is03HdWsASddWNqpCJ8di_0tsVCYbJSW_JzBZej7dyPnwayp7m144vPWULIENE7CKXGwU4GoxZuZgJ5-iOMlP6usAD_AHcsgDjHcqIpK1vpr-gkjdnF6YR2SXQgwDHXuzlxlkwJspbU4gZZOx7QA6TekYE9hEQcDtJZRzN6-Q7msQKjGZw7Ziafw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.35,
    6.61,
    9.3,
    5.92,
    1,
    7.69,
    6.5,
    7.92,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'gir-thonglor',                                          -- slug
    'Gir',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'T-One Building 8, 40th Floor Sukhumvit 40, ซอย แขวงพระโขนง เขตคลองเตย กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.722229599999999,                                                   -- latitude
    100.5805488,                                                   -- longitude
    'https://maps.google.com/?cid=683662308645009552&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJc_dixE-f4jARkPgbXT_bfAk',                                -- google_place_id
    '082 010 0063',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJc_dixE-f4jARkPgbXT_bfAk/photos/Ab43m-uDdra9m9TUpmW9bh0Ro__rynEA2UKYFOHFYlMx37q7SrY0UJX3ILdnxybcJvqA6DMmj1xSjSot6PbLN5IlmHDBntGib6yq9CzFMgWr0VeBemALwObXgq4dQQLTxRMc7E3ayXOJMQTL4Sm1XldAWGw-QqxPujDeI2w00IhWcRsemqL6tc2O8qOSONLs1cpESYX8YdDXIjh2NsmFRbDWIHhxEsh0drLSgq-tdqVGxje59Pm6G-3VB5rEAvG7eSuzlJNmeDNW4OpeOC18RnM2g-VM5V75ly9VZd30ydfMUxkZdA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.55,
    6.52,
    9.05,
    5.93,
    1,
    8.25,
    6.5,
    7.95,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bluebird-jazz-bar-thonglor',                                          -- slug
    'Bluebird Jazz Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '355/3 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7354503,                                                   -- latitude
    100.5829777,                                                   -- longitude
    'https://maps.google.com/?cid=17862254039810328327&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJw4F3Mdmf4jARB0euMml54_c',                                -- google_place_id
    '089 777 9248',                -- phone
    'https://m.facebook.com/100046872047909',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','jazz','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJw4F3Mdmf4jARB0euMml54_c/photos/Ab43m-uZJz3wU-SjM91PzxbAYKz_l9EWvNEHRwMPU3-CRl-FDMe8QpiScbkCApO-yoejVY1M_LJygLly29Huwk4vX2A-Nwv3AhRG2MljyhMUyUr8pXtQcWHLgJBKVOpqcmMCV0GA_ClgpFwnrSzL1_imS5v8JW0cug1DyRP5A1D7OI-sHPVtYzIxuEE_JSdAztoJ8ng5ZCNbybsftTqFT0kV_CHWYE_1K6-MZDlA0BPDW9dyMb25qCNO9EQNyjSuKWRQc45M0BM6yMdj5J1aUn4iEBvFOoAJbErLCgxAXsO13lr5XQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.29,
    7.08,
    6.47,
    8.68,
    1,
    8.48,
    6.5,
    9.53,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'neighbor-thonglor-thonglor',                                          -- slug
    'Neighbor Thonglor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'ชั้น 3 เลขที่ 88 ซอยสุขุมวิท 53 Soi Padi Madi, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7299756,                                                   -- latitude
    100.5791802,                                                   -- longitude
    'https://maps.google.com/?cid=12165691760777340568&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJY-wRRACf4jARmKYHKDM41ag',                                -- google_place_id
    '063 863 8949',                -- phone
    'https://m.facebook.com/neighbor.thonglor/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJY-wRRACf4jARmKYHKDM41ag/photos/Ab43m-vFIaDxQ51l6a_QSQKD2veOGs3iqVt7HmYEdRSMsjxE80vTg3sKynAQ0z0URUIb76kOMyWv4e2YQPnIwwXq9RpKuzuQ5Q_12Nx1zjturyaW8_R1nMGharx0z5V8F31fvKlMVA_R90izKEh7f7Eljxeth8zVKoByRqNIzCyXuFqy2FfxhYSUzzytvuk-T8tuFbeRcyBHwdu1-5jtJPHTxo-bpOkdnOZEHZoTn9kNypb46Mgldr_R0_SA9z7v2GGD8X4mKXZm2nbrPflaBxwRpvk0h2JIKgZ6SgtzpEWux4braA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.1,
    7.04,
    5.93,
    8.5,
    1,
    8.47,
    6.5,
    7.91,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'speakerbox-livehouse-thonglor',                                          -- slug
    'Speakerbox Livehouse',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1000/39 Soi Sukhumvit 55 Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7419838,                                                   -- latitude
    100.5856022,                                                   -- longitude
    'https://maps.google.com/?cid=6321347689734784287&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ0Rzsosaf4jARH8VgXDvwuVc',                                -- google_place_id
    NULL,                -- phone
    'https://speakerboxlive.com/?utm_source=google&utm_medium=organic&utm_campaign=gmb',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:30 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ0Rzsosaf4jARH8VgXDvwuVc/photos/Ab43m-uNgyX_yh-22xy0ZoXmG-WSL_pcaEgeFpajqR7JLElBRYcvpC4bDKqVyr7phQy8b74u8h2P9VZSxI30en6IGPKFwuILsli9K_a2fW7-eDebxz7gGUDrV-QXNLO0ijSTNyJGIypN9xkjjcIS-EB32NgPiBEhEkewLF7HA8iS2oU2YgjKUfNvp5pErdKn-fWeM64DIUBg-h-yjAFtj1O-n6MLzpadNHr8V4ERQY8y77zWxydEqjQri0diXNq_Xkq3xALQ24IPjNwNHsrpeQiO_76UYIQQOA0aLdTDmzK9AUtAu5S37M_JL7T96h-OQC83pUSEW0Q4p4IzjX5EUVmL-TMDhYZ9gAwWob3-sWkPa1CfEaxjoHiOTfjnwIhezkSFy0Z11o5RD7MiPc7uY2KbHqxCUwVu3YhLdPuFZ97Wa4zj9g/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.09,
    7.11,
    6.29,
    8.82,
    1,
    7.93,
    6.5,
    7.87,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bar-grace-thonglor',                                          -- slug
    'Bar Grace',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'dive-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '251/1 Soi Thong Lo 13, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7334365,                                                   -- latitude
    100.581341,                                                   -- longitude
    'https://maps.google.com/?cid=1741195739217780660&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJM4VhwoSf4jARtN9_sEz4KRg',                                -- google_place_id
    '082 543 8881',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 11:00 AM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['local-crowd','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJM4VhwoSf4jARtN9_sEz4KRg/photos/Ab43m-vqkUQeaVnd9drM6_ajyZCLlq4hpbsBcqMug6sQt0XkNjvKNuT2uOVUT19gwJjmTbArtpCjMJM9x4YnGudijjvigDh4_664U9HGNoMH2GksoZJ_bFAMy1bETkXisG-4x1WV9syeCgXNUcudDQ8XbUV7Xw_c1yiNA2aSKMSNjSw0vurSdkBfhAINmL2e90y-1wc-nRgpFZMmWA4KAV9wTmHiHxxX0t5kA5yKVWkyOC-n6B_PjvqSQyltm7mf0Myvd7tDOfLexwJVIFUVZrGIMPczThE0LErwxyK1ayZ_uChMQw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.12,
    8.69,
    6.13,
    6.48,
    1,
    7.97,
    6.5,
    7.38,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'swirl-thonglor-thonglor',                                          -- slug
    'Swirl Thonglor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'ชั้น G, 63, Civic Park - Deluxe King Room, Soi Thong Lo 13, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.734221,                                                   -- latitude
    100.57943739999999,                                                   -- longitude
    'https://maps.google.com/?cid=12929698346785449627&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJoz4MEsOf4jARmyYaVSSEb7M',                                -- google_place_id
    '062 051 4848',                -- phone
    'https://swirlbangkok.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 2:30 – 11:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJoz4MEsOf4jARmyYaVSSEb7M/photos/Ab43m-vVJu3ggFeEs_ZYaSxc_eobJ5cpAdygdp5ShExXDkb6nPp6cHKVjHuwGxezUwRfVlfAil45N9xSEi81NRpkFywkdAAgJrP2y4O_hu546c9WWaHLIV9sXxyfko1ba4adch_Fr725-Nu-KTId9_DVN_AB01hBE9487Epjf9BSzOgTTEtETSOE5ySveqe_G8jBvBEaOXknyBSyVFXSisgOGxfeGp-mbACvYbSOJnafUSNeWUkfQjNVKbO2I_e3rJemphsM3kNZL5WWp7HH0-QfAEodGtOQWXLbbtOxOvQ5nNHmBw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.95,
    6.92,
    7.94,
    5.91,
    1,
    8.33,
    6.5,
    7.37,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bo-sushi-and-wine-bar-thonglor',                                          -- slug
    'Bo Sushi and Wine Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '308 Soi Thong Lo 10, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.732311,                                                   -- latitude
    100.5822793,                                                   -- longitude
    'https://maps.google.com/?cid=1925060121037884014&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJD-tszayf4jARbsq7Dfsvtxo',                                -- google_place_id
    '092 629 5528',                -- phone
    'https://www.facebook.com/winegurubangkok/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJD-tszayf4jARbsq7Dfsvtxo/photos/Ab43m-vS7W-IHMbGKhVakANfmYBKDaI1M3YdKsCOsTL2k5-sKQPLcb4NVS1a7aLlweC6Xr1hFvSjGvH92TTH-OlBdze-j7m63_XX6p6DE4JXCo4zohCeBG63yZRHLQEdgcLRPHQWhdW8C19898VUSKb9ehDwlvBqE_NiQWXoT3jcuU2AaIpc93WJYL5-m3ZeTPTmdefGXvSlipWFIVuia1P_LLHmvHxj7NJ13P6hDaxPqtDUpaAMh2nPF4F9lbYjjLgkui6-9L0pqp-lqdHJbP7Wr7YqIWVKSkvkTaPlzCBnM3uzIJZsVJO5xD1sIzyIXlNft0lMLBfAe562DafeRMy_Iq5X3cwd95X1yaanymthBJy0ug80-6F5HeLEzhU2otlU-YQqUuwFGZoQ1TFlgJzpDHidhWYBtL9w-sx9A9eO4R-7PQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.89,
    7.23,
    8,
    6.18,
    1,
    7.73,
    6.5,
    7.57,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'di-vino-bangkok-italian-restaurant-thonglor-thonglor',                                          -- slug
    'Di Vino Bangkok | Italian Restaurant Thonglor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Penny’s Balcony, Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7343485,                                                   -- latitude
    100.582982,                                                   -- longitude
    'https://maps.google.com/?cid=5627875490685788291&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJi7QNHVOe4jARgyB05vA6Gk4',                                -- google_place_id
    '02 714 8723',                -- phone
    'https://www.divinobangkok.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 12:00 – 2:00 PM, 5:00 – 10:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJi7QNHVOe4jARgyB05vA6Gk4/photos/Ab43m-sBB4PwaZe3sSwF_MVF7km17D0Amwedb1XuMEfotFXp8Ul_VOR5zl-R2gJ7gh37D13hehdvCybjMoHIkdlVnZAYK963I11fcux71ZrYwB18XsnpOAlKZovsyJgXFlZ8Kqj7FiQYiW8vZEJTCkPOYgCf6UqbkOdLBuHqmcUd6h_sphuPokO1sryKKsZpHOc6H9KGq64rQDiuQ1-sxDFCUJh4d2We45DTqNne13aal5IWB0XeA7uERyLT62ddb9ACJAgFRYIOBcQpssuilbQ8aT-Yr7tdFvlb-1p9V47ohkPV0w/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.64,
    7.01,
    8.62,
    5.87,
    1,
    8.26,
    6.5,
    7.6,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'residents-only-thonglor',                                          -- slug
    'Residents Only',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '160, 17 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7300176,                                                   -- latitude
    100.58170880000002,                                                   -- longitude
    'https://maps.google.com/?cid=6736376201013350765&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJoaKArXmf4jARbdHLxnZqfF0',                                -- google_place_id
    '099 998 1559',                -- phone
    'https://www.instagram.com/residentsonlybkk/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJoaKArXmf4jARbdHLxnZqfF0/photos/Ab43m-ukjbEa-8yli_hRKdGHoSRkwMlzznulvolwqpqPK8J7UgsEczQiXmcJgUW4TE5AMmD6vM-P3XynQPQANxRsou77_tYhFvfOlLnVz50qvzYQmF720NkXqwkj37ZsRJpO0RQ-UsGMPBStjmRMjk152J1D3lkunezUTcpLpQZcH1jPBigZkfO-56YqUvz1SzTvBEutA218cO3FbuFSkCh5JK5gLlMhtiO4_FAaBQYrNYoIdcERLfbcSx8amVdlIFxKQ87JSB_bR0bWUNR2R5Y5n73e9NvN_-wbBFsqBxImsrVTKg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.06,
    6.91,
    6.06,
    8.26,
    1,
    7.9,
    6.5,
    7.57,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'findthelockerroom-thonglor',                                          -- slug
    '#FindTheLockerRoom',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '406 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7333573,                                                   -- latitude
    100.58253909999999,                                                   -- longitude
    'https://maps.google.com/?cid=5662130738522121065&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJOTgMUa2f4jARaWNuTejtk04',                                -- google_place_id
    '098 287 1898',                -- phone
    'https://nightify.co/book/find-the-locker-room/google',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 1:45 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJOTgMUa2f4jARaWNuTejtk04/photos/Ab43m-umDY95meym6f2HjnNbiQwLiNZou6RIZhH5RYH3VyBuX_QOpVE_LKM4Ir5Ea3XHTDZlSS3IBbNbIeygoUi9w6-o75ZrV7_BbAyI8-oia8_0sRu0g48p6g0sjbsDaEz0V-y5-s-ijSwqi27oMaZx3VJjg51y2s1NTB4E-8Mhg83P-D09SgksOYbXWefJcvi0TKO3P5kDpKsBeVwidZyIU_L6mxAJwisO6FcZT8_stIqdFcgxVay9yuLQSt-30WwPwtivvwir6BQf3A0vH68XuBcGtxPldAoBnutkdI9gE5QUfg/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.02,
    7,
    7.88,
    5.79,
    1,
    7.85,
    6.5,
    7.31,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'maya-club-thonglor-thonglor',                                          -- slug
    'MaYa Club Thonglor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '139, 10 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.732346,                                                   -- latitude
    100.58268849999999,                                                   -- longitude
    'https://maps.google.com/?cid=1216909338696081032&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJy0s4BuSf4jARiN7VmJhU4xA',                                -- google_place_id
    '083 229 7880',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    NULL,                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJy0s4BuSf4jARiN7VmJhU4xA/photos/Ab43m-uejb66PRy1LDK9kvvKhpOvHmPBKT0KQJfDZHpym45qiKus8xJQKu6okkWGqg5091rIiWCOZEfcqEnu_9ELMdDSWUMZwQOPKILsHvN81cNFytaVaJLi72Qi6NinyqC5VxRMzxlSFEt1l1Tng32pHTUOQpyjHVBX0d28ExyRuMd_KM965DIovBnk2w0FcaD_G9-VqvGDOoY7cs5RAHnquVuWTZMjEwddgcpq9PN5otZIXMO6UGx0H3q5A6ucK93CPxXewdbkh-i03HlIqPZeZ2vczhLVgPAZXVPi3Gn86L5Www/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.47,
    7.1,
    6.34,
    7.86,
    1,
    8.19,
    6.5,
    9.05,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'thonglor-house-thonglor',                                          -- slug
    'Thonglor House',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'Thonglor House, 205/2-3 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7315021,                                                   -- latitude
    100.58160590000001,                                                   -- longitude
    'https://maps.google.com/?cid=3653815203947391350&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ70Bzbumf4jARdqk0upH1tDI',                                -- google_place_id
    '092 759 6283',                -- phone
    'https://www.facebook.com/profile.php?id=61561859949102',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ70Bzbumf4jARdqk0upH1tDI/photos/Ab43m-u4IWSEuBjWbVwHMaxn3S53aRyj9x-XfJOf6ZwZunlNcD_SS0hSeBdawhxTZjMhX0ENwWFaaXGnGsSQrll4RxIb9rm7FHWvOllZA_J3Pz3Uy-XFLuwde-d9on7mN6oapha_lcRF9s7-tUkAHGrUtgVA_fSILQ_hcsBauXIlt1PRDAcfjtVDqDkBVEX-X6wtb9KlsfAtkyILsv9rLaaWMsmmOCFU8c0s-zG9nHHo1y0ISjGAW1ec4rnNfNbANg4to11Is5jaJpjBTM3zyP8oWz5AJbKbN-w9aoeeYlWsij_bUQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.13,
    6.99,
    6.08,
    7.96,
    1,
    7.96,
    6.5,
    9.14,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'barisa-3f-rooftop-bar-the-commons-thonglor',                                          -- slug
    'Barisa 3/F Rooftop Bar @The Commons',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'PHPJ+3V4, Soi Thong Lo 17, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7351307,                                                   -- latitude
    100.5821957,                                                   -- longitude
    'https://maps.google.com/?cid=9673253193339975683&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ4YdUCFOe4jARAzhxO4dMPoY',                                -- google_place_id
    NULL,                -- phone
    'http://www.facebook.com/thecommonsbkk',                               -- website
    NULL,                                                     -- instagram_handle
    'Closed',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ4YdUCFOe4jARAzhxO4dMPoY/photos/Ab43m-uz8dzHTxvpgPJXd97flshZDlph4kDG7Y2xQiHJpi_PV2jKihmr0IoYcYEgYlfrqwIK_Mx4pK1l2aJXxl8UEJ-stqEZx00HyybhjHK-ERAvBQDuhXbnapLEeCoYgdKRQyvgZVCf--oA3vgST4ZPw0Cp1OCgQdiLzkCYkTXy4SDtOBtXNgcNhPLlgjCXsCcusu71r1Cwgqp-F9OK9hj6Nk6rcnQm0s0LLMhBTn_R4iQm4ROdrepwQZoOq-0kxYqBGzD5WSLJXZsu55QFdXKgHHF7imdKeC2bVmoimszdmDSFzX8B5cYmRJ6Lkh_9A3f2z4AygeS8lnDMhjByG2hi7muo-2yxii9lzAQTXw8_VN3NMR-nltda1d4yboSbqP1pFskgZU51HxlozzyJAgpqZzYDlHVPabP_MXbn5Q2Gny31AcYB/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.15,
    6.82,
    9.48,
    6.16,
    1,
    7.73,
    6.5,
    8.29,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-bar-at-9-thonglor-thonglor',                                          -- slug
    'The bar at 9 Thonglor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '205/3 4th fl Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.731563099999999,                                                   -- latitude
    100.5815607,                                                   -- longitude
    'https://maps.google.com/?cid=5927427190987498212&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJayUiUQWf4jAR5CLNFqBzQlI',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 8:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJayUiUQWf4jAR5CLNFqBzQlI/photos/Ab43m-tg9CUfw8DRBpz31S65zzyBUqpF4ZaQJG6t6CNjGVtuEZxoVLIbxxBnFTxyJ8CFN5wRI6cOs7ZJAaBBIQ7dkysawEK73uogrdfUEQU1KrinOsL8ugvHdPDrBMDfXiYq8j4Sw1UYFWw-GZnDzgdyMFg02avQL5oddr6T6jFaKqVpMRz4YQPPB4BfLmlWlXcLNVdsEwBjNSOSQGietOLy8bZ70-iIpkJp6B8-V_uhGIq3JCcilHSl_53iks6yDcS2D4gWmQ2OWQVaqgpmVzJp8kSL7fz_0CEwwVDnVbJUVRDJdw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.83,
    6.67,
    9.58,
    6.31,
    1,
    7.82,
    6.5,
    7.84,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'black-cabin-bar-bangkok-thonglor',                                          -- slug
    'Black Cabin Bar Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '466, 16 ถ. ทองหล่อ แขวงคลองตันเหนือ เขตวัฒนา กรุงเทพมหานคร 10110, Thailand',                     -- address
    13.734005,                                                   -- latitude
    100.58319739999999,                                                   -- longitude
    'https://maps.google.com/?cid=11975577670519880749&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJnQbbMb2f4jARLfxvJ3HMMaY',                                -- google_place_id
    '081 599 9365',                -- phone
    'https://www.facebook.com/blackcabinbar/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJnQbbMb2f4jARLfxvJ3HMMaY/photos/Ab43m-tvHxFFYeL7cWKgvp5_0GVozlAyF-heNxBOzJ90SY3Nzubxm0UEQZn1IqjNhFJ39yEk9t4xhuu2WFhlT8znRWZY_8K55B8g--Me44TyTNGEiZv7qCUEVuoPJ44RsSyUuXrDdyNZdh6TVTMjzEdMTraSrhVppgmbSViKC8jj5W_PmobtwxADLGkDPUqRZxgo6QtYOoB6oORY0dSi9CX27R8OnImGbM8a5p2zLYHEqnZ9M9y29SsT-YhuTTz5u3o8cX-RYXJLDCh-8dkuXtFu5eZzTBEf3w6j2qn3F98oEQ0fUIhSdbCnLZP0LLVQatUeT2xv5vIXISz5SLsiL-cM6y2_nYqCGd4rSOihQ762AvKY4hK3ngDMJV1MeoASCVwuMVIoF4LgAN-EVh8cQthS9CEFz4AXH50QDnoKjVh4OVNccA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.22,
    7.25,
    6.24,
    8.45,
    1,
    7.86,
    6.5,
    7.34,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'must-wine-bar-thonglor',                                          -- slug
    'Must Wine Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2nd floor SODALITY 263 Thong Lo 13, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.733705599999999,                                                   -- latitude
    100.5805989,                                                   -- longitude
    'https://maps.google.com/?cid=697184500920378968&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJGbOSVFqf4jARWGZEGJzlrAk',                                -- google_place_id
    '092 599 8919',                -- phone
    'https://www.instagram.com/must.winebar/',                               -- website
    NULL,                                                     -- instagram_handle
    '2:00 – 11:00 PM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','wine','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJGbOSVFqf4jARWGZEGJzlrAk/photos/Ab43m-uvUKl3D8NXOvviHXIrd2okKCViF_d60o-FunEK6l7rzHTrAgj9B5DOg3hi_DONn49YtP9PygVKFIqCT9hT2gJUxIkODYsHfbmxXca4tA9uGiOq2mFdTtpkpTOrz-rC7vUP8I50hpqRALQeaO3B5oAFu9022pZJwxdH6V0SXzHwWFQ_pb69ZOCAL4xbzUZH76XdPnxIy-qkGUASv1tR-KLXCWy_M7sl0ouaNUFV9NBg8bZKxhzmBGR3WwFBEpIFffguag9BpC_cJILnNy2Z0mReAvxjqr598Q2bF7wTRa2XXE0Nc3tGMqKpXNeCvkVdwHl1-8-kPlWRO3ym-2E9xreOSqvjfK5sI5ZrMTbOt6TFCNhTtx8L2_OOM9svl3oDpXg_XZjLU3sxJVKrFW6FTBRNX9WA6Bs_UrHZ-bN08gyntJE/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.99,
    7.21,
    8.04,
    6.44,
    1,
    8.23,
    6.5,
    7.84,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'urban55-thonglor-thonglor',                                          -- slug
    'Urban55 Thonglor',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '205, 18 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7317825,                                                   -- latitude
    100.58132180000001,                                                   -- longitude
    'https://maps.google.com/?cid=15844440485569286947&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJkwPaaqmf4jARI9Msl6zC4ts',                                -- google_place_id
    '089 950 5320',                -- phone
    'https://urban55thonglor.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJkwPaaqmf4jARI9Msl6zC4ts/photos/Ab43m-vahFwOY2b67pEACcFPQdTl29ks7iWz8NyfGBktbOIrgXTJhvvAXyp99kuVDidiQdHiOlsO6iINeVunEu7YfVQ6Ud-f4J9d72ecTnb1eOXEXhOfw6ex0e28NFl0FHphjrmcRZP43tSihcmM8sFMkU6zEyE2sW94oG-nmH6aFp7J0_ywKTPizM-McOVRtldpPeOhOw435p5GtLNK-oxkAR_3482DXOiVhxreCbtNE10yOw8K2D74y_XQot7SVwr9sPYWJaRzzzpg3OqmOy_k2yr6VSmy2wX7Lg8L3NK4AJPt8f-kKbrJFggOZhHMrBZta4PBa1KLFrxDI9sOOrwmxJTvz3J31wSO9e-OUeDLQU3DYcILeRikjDtWqprNnt5Sa6ffVFlcFPrO95yoSsG_iuWwnoCYFYJbsNjtdvs/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.9,
    6.99,
    8.39,
    5.97,
    1,
    8.37,
    6.5,
    7.74,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'rabbit-hole-thonglor',                                          -- slug
    'Rabbit Hole',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '125 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7298215,                                                   -- latitude
    100.58104399999999,                                                   -- longitude
    'https://maps.google.com/?cid=18351749191682727627&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJv47qiKyf4jARy55PeaiCrv4',                                -- google_place_id
    '098 532 3500',                -- phone
    'http://rabbitholebkk.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['cocktails','premium','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJv47qiKyf4jARy55PeaiCrv4/photos/Ab43m-tJ8DxSaz5q04SUt5hBxvgPL2HKKf8_JizBRwCeNWjD0u_bTcXWdkGwTeKFfHRm4jIJj39XMwssDGTukiTBaWWNZGUXLonYtOMeWIp5UeV4BiI3CUXN5C_BKjxrC0XIJoBuVcFUhKRhRgmqkFrQ-mV63j1TocowLRhW8CGkc_XYTCrVYaFOHlvwTG3MgB5eT1YClrvfSCUJsbqh4lrdQ7vjfaac7USJJZdnlObA4G-4McRaMwEn3yfXGY_hODDkwQdNqoKgl98xz14wht-hWzsdgVgxi2-GhShxdYl5oGY5Lw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.31,
    7.16,
    8.41,
    5.9,
    1,
    7.36,
    6.5,
    7.26,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    '008-bar-thonglor',                                          -- slug
    '008 Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '88 Muu Bangkok hotel 322 ชั้น 11 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.730413299999999,                                                   -- latitude
    100.58186289999999,                                                   -- longitude
    'https://maps.google.com/?cid=8860321859551178290&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJMx7sYeyf4jARMi4tiskv9no',                                -- google_place_id
    '02 392 8959',                -- phone
    'https://www.facebook.com/008Bar/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJMx7sYeyf4jARMi4tiskv9no/photos/Ab43m-swwGuHlbPB95kjyOjFbXmy96n4qXayReYrFN8PkrZWb-sUaApnrFB7uxfCMIlRUHFG8PUE1bZbOHlzCYSuMJ5xQ9gxfT1mIvMq8biyVJzgyANCFEx_-qurZnCgIOd2iuvU45bHYlgfNKVQ4dUCK4xXtP48NfO5UgB7YPg_3oVblY9sMZFa3XyRZ5iftcaVSdSJdaZji2BDDYl8QNuP54C4dFl1_9NzkAmyiqk9jxsg7mIvGkCOFguezda0et2oOTWjZOI3uMAuS0vWEPfFowN05deQPT4ktjO3GhmbGoDfcQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.97,
    6.58,
    8.42,
    6.42,
    1,
    7.6,
    6.5,
    7.35,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'bangkok-night-club-peach-thonglor',                                          -- slug
    'BANGKOK NIGHT CLUB PEACH',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '8/4 ถนน ทองหล่อ 2F.3F Khlong Toei Nuea Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7256226,                                                   -- latitude
    100.5797907,                                                   -- longitude
    'https://maps.google.com/?cid=15150728667888034414&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJI_65EWCf4jARbiLLkXMzQtI',                                -- google_place_id
    '080 565 6101',                -- phone
    'https://bangkok-peach-group.com/night-club-peach',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:30 PM – 1:30 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJI_65EWCf4jARbiLLkXMzQtI/photos/Ab43m-tWaYUu-x07brz7-PgQH1jEbbFR8eTVCq7FTOGC4hycFap8N6earctwgP5_OArACru7aoz6XlskKHHLRubqgN7JsseKp4SI51wavrH5tZJ2v_6_uyemBxhV36eEqpfj0fgp0bXPMveCgjWZz54BrG4wg84rjYBaaPS2PIiNCGvSs0TROGzPEFi8_50qDaXiDdICrGAjIa_ZnKnqH83wp0sX-7mP6TVxIG6uRDPLMx3UNWUigQlICaSx6WNr1RCp6iFfapJwvw9lLPrchYL5RU1VDU-69POktmxfrl6vgrBg9nAsilpXKiIs_khbVLogU_MiG7V00gA_MChZ9QKcVSxfaGzYX7kosYc3VlYX1p4VElgnIBJgqySiTy0f2hDC59UB3Q6H2jub_ad_nU3FFUs3zjNMNaYFDO2saYyRQmw_msesHK826zrdMI059Mcp/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.78,
    7.25,
    6.32,
    8.1,
    1,
    8.25,
    6.5,
    8.98,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'mil-social-club-thonglor',                                          -- slug
    'mil social club',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '3rd Floor, Market Place, 15 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7345556,                                                   -- latitude
    100.5818285,                                                   -- longitude
    'https://maps.google.com/?cid=4047029164681492827&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJZaWeV6ef4jARW3l8TJXvKTg',                                -- google_place_id
    '091 549 4426',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    NULL,                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJZaWeV6ef4jARW3l8TJXvKTg/photos/Ab43m-v7Av1AoG_BIaw1DaFLkmWLaHhzoz6XyDSLCWKYjqNEAA_BOGL5psZwSgAWD0YaDeBr4YnYEHFO7-AroNy3PqJH9itRo2DFIAZ7vnZl4MuOs37JJZ42DRpbkKY0OEqaifLWCuwlNYIe_4qhzfnn4QMbk1VBl_XBh24w-ScrW2FiBis8e1ylWkve8Z2Hg3awehRi2caGCBg-riN_K0495WnrnMobagxYh0hkXVq9I2_g7AYAqNzWVJ10HXnH5wp9LhrenfHu_DSVv-dTyT1tFhFS4ne9gDoa5xMTxhmGLP-CbUN3cVUNnyHDZtUsRL22wCkCZ7-XCEFgltf0HfB3HKcwZvHd73ifbc9jzpCoqAnIy7xujZnpE71OkYIJUHGLAzxeQ2yfbcD20NGj62QKxjC1QfBMkQzbaye1beBT9TzlaA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.55,
    6.68,
    5.92,
    7.82,
    1,
    8.16,
    6.5,
    9.36,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'nowhere-thonglor',                                          -- slug
    'Nowhere',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '3 Sukhumvit Rd, Khwaeng Phra Khanong Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7261483,                                                   -- latitude
    100.5853255,                                                   -- longitude
    'https://maps.google.com/?cid=14726000522843941320&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJAXfJBa6f4jARyGlULnRDXcw',                                -- google_place_id
    '099 394 4417',                -- phone
    'https://www.facebook.com/nowherebkk/',                               -- website
    NULL,                                                     -- instagram_handle
    '5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJAXfJBa6f4jARyGlULnRDXcw/photos/Ab43m-sEozdFVRYcXfWjraTCKTyV49wqzwQHCOw3lNOo11uvpfVMfcCa7rf8pxC5zS2jcxyDbLoaP5A5CQyI-u7jHg49GcThR0NANIC1e9V_RoASCds4g_s2RRwkG0qUdYakmgXb0jIcLRwW8nPAebELTF_T-h_QaeflvHrmCS74I8MXTQxC0o52pb6g8l4MOltLi6Kt_utaY0VHF-Bu66PwSM2DdpSxyd74waY9LywBQJTfeBxIffu8upV4D658x0pkdI9Uwi2kGNuxvdVSXZVhpfhucNATZuPJd3UNiFYD4T43X2CywmMO7vA1MsNPdFl3jkd4H6IaCQS4JJVi2jBOTfCqBE9n30scX32rNMnMrjN5RgGMNtiFuDP1w2TGkOhwFW3l2wkoIsz9ZQTn2z9YTpPKeh9XucTIYcO9xDSsqUTmew/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.91,
    7.19,
    9.12,
    6.1,
    1,
    8.41,
    6.5,
    7.83,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'jboroski-thonglor',                                          -- slug
    'J.Boroski',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '16, 125/13 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7301916,                                                   -- latitude
    100.5807766,                                                   -- longitude
    'https://maps.google.com/?cid=15227175719163614739&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJlS2Whayf4jARE1YzuaPLUdM',                                -- google_place_id
    NULL,                -- phone
    'http://www.sipslowly.com/jboroski-1/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:30 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJlS2Whayf4jARE1YzuaPLUdM/photos/Ab43m-slQcwwUJfC0buHjEhdCiIGyt1PCDGCcorO8ATofq9twmwFdDBBRvR1RwbxZ44l1AW_5tPQ2wiqfplc5lAHc3a7aIQGIcvAcJ6KYyaQExbqMtAsk8JrXGi7ZzaELVnVcej9Lrf4MUbAT5wLxYpfR_uzSJSZiS7yh7QO5EYoGlecZGSyUNkC6DjV8I7KNZWZ8Hgb-B4J_F2smLhZT8dF8N20knOIApZERe9IkN7LTR88UbkK64jWQpsP35-T83K6_6DGF0X3IdBznQ_Fd9if7t88M7IOM5ueYzYzi8rQxo7yoEisMh3eYyZMngD_o0G_mJvNh6ybCNJjA4-SEBRCVgWNL9UJXyb2L94cG8mXApcx9tSAxODZ4x3StO2uKoKKW9BTnG7szCT0IAY_8KRkLnG4JB10RoTX2sW90iLzr7hg4D6yVZRqZmeuMFBYRmVw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.19,
    6.88,
    8.13,
    5.81,
    1,
    8.36,
    6.5,
    7.32,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'dope-dirty-thonglor',                                          -- slug
    'Dope & Dirty',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '229 Soi Sukhumvit 63, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7323059,                                                   -- latitude
    100.58618849999999,                                                   -- longitude
    'https://maps.google.com/?cid=14834911535325541753&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ9fRzY52f4jAReXVsUXEx4M0',                                -- google_place_id
    '084 142 6555',                -- phone
    'https://www.facebook.com/dopeanddirty',                               -- website
    NULL,                                                     -- instagram_handle
    'Open 24 hours',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ9fRzY52f4jAReXVsUXEx4M0/photos/Ab43m-uKj7Rcll7gFK3PEd1m_P4tdDO3pSejqKW3BJtMx737nZk967Rzg694lYaCejvbr4B1xQnHtlTECvrk20Ji5yvrxytHy3MPXwCS_B8yur9k20amPgTg9DLwz0i7BHLJaykgk0u0L0ulDcD0AU_2wYqH0Y09wHAv-3SkI8HrxjHw8OUc4nVVnLRBs-dIZuDHl9ll3BNCUq0Nf3eOSopMV0U5oNFC_LivhJVEa3aF4wc8KR4-akW6a4ykdLotWCLOVJNtWWfvAxDSO-IcOD5rg0kyGVpvlXZDzqcJMB_Nb2kDmdZkavjouIAYp4a76tx78QO0QxxS9DPyVYDEEdhwCe3-A_5Io0E_sBHyC_3uKfvTjStZ6douGrCWaXGbK2lMky5VHbLDmdObVmMqhVcrdwbsC3tCFtAwP4Aa_iYtSvcMl0dHohBtQ9YCWmN7S6zW/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.73,
    7.57,
    6.49,
    7.73,
    1,
    7.96,
    6.5,
    9.19,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '3 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'czech-club-thonglor',                                          -- slug
    'CZECH Club',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '41 Thanon Ekkamai, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.72622,                                                   -- latitude
    100.5849526,                                                   -- longitude
    'https://maps.google.com/?cid=18333655614495706296&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJCfutDq6f4jARuMxcQKU6bv4',                                -- google_place_id
    '082 282 8445',                -- phone
    'https://m.facebook.com/CzechClubBkk/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 8:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJCfutDq6f4jARuMxcQKU6bv4/photos/Ab43m-unDRv2r-ixRtCfewYDqWVaO2MC_fh_eIt3ZTcbcbkDn-bHCdj3z_nfOVsTbrkDPQlh6l4iouXMUsLJrXyiMXsiNQ3A4nccVCEoFLVER767uub3vJjcC4NQmVxEpwST9zCne4FWOO8OMJ81L1LYinSQT0Q5TB0WAXep72iXTyflotJGh2SC7LT4MipdJWJVcRYU6OCwFAA6Km984oMI0Gp5FLvY5yQoE7pG-AgBagPuzNAl7syjpzxMzzpyFfERmJ9bGQSfw8Q3D_-C605MPEVtujjm8geEiod8G04rSc4bUA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.11,
    7.29,
    5.74,
    7.92,
    1,
    8.07,
    6.5,
    9.32,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'octave-rooftop-lounge-bar-thonglor',                                          -- slug
    'Octave Rooftop Lounge & Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '2 ซอย, Sukhumvit Rd, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.723502300000002,                                                   -- latitude
    100.58054260000002,                                                   -- longitude
    'https://maps.google.com/?cid=13914224852518341761&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJhxshNqWf4jARgYxEW8hBGcE',                                -- google_place_id
    '02 797 0000',                -- phone
    'https://www.sevenrooms.com/reservations/octaverooftoploungebarbkkms/goog',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','premium','popular','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJhxshNqWf4jARgYxEW8hBGcE/photos/Ab43m-vO9C0MhkX71KhGrjLLfFGFOYYtXsL-RnM3bxIIDosiIA_yd-xFMqEk2CpHqS515HpnNDoHHzs5elwk10CPO6y32oc9mFNV7ERQ5VOIhgRlfOAhrfkVxUQZ_75NOyOv3bEkLCZqZwP4Sok9q9JxQpZLTXioIbVGVroZ2c2uIDaxwFsaRl00jmsoP360P-Nc_JzZf8-lfoXzj3djsONWpbM5nh7uD6eh6rawHqtileJP5AXj3EN73AAx3E24sovCrP6D4sTPxGYWvqLLEf0-h8XWs4Kt5hH_Ut3xs9t0zAlRxw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.14,
    7.06,
    8.9,
    6.14,
    6.45,
    6.88,
    6.5,
    7.96,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'tulum-skybar-thonglor',                                          -- slug
    'Tulum Skybar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '559 Soi Sukhumvit 63, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7392497,                                                   -- latitude
    100.58891799999999,                                                   -- longitude
    'https://maps.google.com/?cid=8085012818448650500&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJ4Vuscmuf4jARBJEceFK8M3A',                                -- google_place_id
    '082 973 0275',                -- phone
    'https://tulum.asia/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 3:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJ4Vuscmuf4jARBJEceFK8M3A/photos/Ab43m-ty4HGWthMis65aVz0IFNgNIR6-PG4tMbqGOG_HeydoIH86Bn1A7_28KfuglgoRfaHnhPYK7WT7KQET8TkSjqShQ1xFavnNwjQXozCK_Ck7nBwq1T8gl5GK_6XdyKtCqxHTaalLi60Ked7Z9phqEbgkRdjXx-Uij79fz8sL7045iFMg8DMtvB0u6V2IOM0y2Ocfjs6Lgbf_96fPe6NoTKC1gjIxnlu39adqC5xwklM-4l_ue6J5PQsWyRm4thzr9a8fRl3ry-37bQZme-4LtDwuvvC65NRkWBslXdJXBCwH2A/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.24,
    7.16,
    8.91,
    6.13,
    1,
    8.5,
    6.5,
    8.33,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'cielo-sky-bar-restaurant-thonglor',                                          -- slug
    'Cielo Sky Bar & Restaurant',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1595/ 500 Sukhumvit Rd, พระโขนงเหนือ วัฒนา Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7144788,                                                   -- latitude
    100.5935391,                                                   -- longitude
    'https://maps.google.com/?cid=15002943212494161261&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJIxuKzr6f4jARbYUS3lwpNdA',                                -- google_place_id
    '081 916 4270',                -- phone
    'https://www.cieloskybar.com/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:30 PM – 1:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','premium','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJIxuKzr6f4jARbYUS3lwpNdA/photos/Ab43m-tzrewd9T3iha1qSSIpTUuuqSwOE087-2brD6s70vVwvr35bRPZWOQttNY-o3Dmtf1fkd9e17LyMvBoI50URSX5HWtTzZ_Ia0-Gq8rUicJ7OaQOnfdB0BSywVSBilYN8DHnZX8YcXUxynUODmcqIcB_5c-8zvDe2gBnNFHxv2UAF5ef7MrzqYJ5VnrLxnYqWhM8uSyct3NH3U-mTmzhYMIJFdk5bu916x3oRjp9L1cO1QAGlvEM3_gtQE62CWAlmKoNLeT033LNGxfrbIDTHPOs303WCrqSiY3CZ0dV4YrGPQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.29,
    7.23,
    9.04,
    5.82,
    6.02,
    6.97,
    6.5,
    7.79,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'tderm-x-455-thonglor',                                          -- slug
    'TDERM x 455',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '455 Soi Sukhumvit 63, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.731853500000001,                                                   -- latitude
    100.5863792,                                                   -- longitude
    'https://maps.google.com/?cid=14973137300779623083&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJyb6BrrKf4jARq-IeQgtFy88',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 6:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJyb6BrrKf4jARq-IeQgtFy88/photos/Ab43m-tW3W1GUJT19xRQ3xUX2odtagI_r4rspsgGr4AwCxEvUdV73gDCLgAzuUyIx6i-NChWa6HYDM3jeLHLaEVLGO52Rnhpcrv8JtppDHTOsAV9skOJd0aJqbtFSEq4EnXVzZ2A7lWKR4WW8biz4aZcXH_WuWzCCfkVe7pEP25UbSeFRX-OEi4f_3jwcqV7rMgjmgQX4Z2u2mOeff_kTrjFtNFMxGHqRHZ-VQ9HZtyjqzqq8Ae6d1D73mPl_3HREu2leKx9I-bV-yTmeikES_-Hnw6acNjF4-OkWB_ZRu3GD-sMI62ttXuMHgL51sPDEOK1ib6x1yHmYojNuAd8G_95OwoHyZ5EpgtSxs2WmhUajP215e-biiYVS08OZ0OPcxrZ0A3sngWrgof4sFtbQsHDQhDuF_8zQHExaLRXnwSsjzN4iw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.84,
    6.97,
    6.32,
    7.68,
    1,
    8.03,
    6.5,
    8.69,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'kirara-japaness-club-karaoke-thonglor',                                          -- slug
    'Kirara Japaness Club Karaoke',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '161/14 ซอย ทองหล่อ 9 แขวงคลองเตยเหนือ Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7310787,                                                   -- latitude
    100.5810537,                                                   -- longitude
    'https://maps.google.com/?cid=8660437621177930395&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJc-3Fvayf4jARm1K9qSEOMHg',                                -- google_place_id
    '095 056 6322',                -- phone
    'https://www.facebook.com/share/rUAaKHcQiH3rBmAH/?mibextid=LQQJ4d',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJc-3Fvayf4jARm1K9qSEOMHg/photos/Ab43m-vi6ETqCcCxfY8ZyGI08uyjQPmjE6HngRANXpykwNZ6m39IuO24CL2ixFlc4kzENXlw_8ww5QaFMxog5pkT48S8oT2_ycTsy8Y7Y5Ia9tOjH5yrkv4hD4C6g5lxbVB25DKlPOU4CycIVRYBxqequrqo7po-1sYwEIxDO5iNmjuy1QwJCK0PcFAgVLr9vEgGXobc6yd587AfgT9fDUpUK4KWpmgrP5osAgybz92dN0GnJBTnGwdpgufQ6k3eTi7cs6rsWlrgX11OUXnU_0yc6uGI5wLWjkcBtrZV2UR2JWwmMw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.21,
    6.58,
    6.42,
    8.36,
    1,
    7.87,
    6.5,
    9.13,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'club-miyabi-thonglor',                                          -- slug
    'Club Miyabi',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '11 Soi Thonglor 25, Sukhumvit 55 Rd., Klongton-nua, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7383501,                                                   -- latitude
    100.5825407,                                                   -- longitude
    'https://maps.google.com/?cid=9386909343869031019&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJG6x2e1Ge4jARa9IbdFAARYI',                                -- google_place_id
    '02 185 0644',                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    '7:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','premium','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJG6x2e1Ge4jARa9IbdFAARYI/photos/Ab43m-ta8bq7XPbutbYRVRdrVAyEJhXnC6CGNCDF25zOdENzImLVTBOg1jZhcyXSMHJIcQzenmYIOozl27ZhPhHs4gWfWczgbRsRUyA53NhvVJF0_YeQVPpzKlDHNzo4cs9h2E8Nl4FOYXuVNq8lCT9U0jVEix21W5x-0Q627rtH-0v-vFnNNtyrUsDccV-iPaZ8sKnYtlpIOhiirwfjt6Gc2UZKYUYFkql6r8ULJLTsd9qv9z9RIGzHQyghoXS0SzaFPmEKcaEo4oUnR2dsqNYlLbOlZtoVN6qD81I-lhJUNtUG9avgQSEeXlzf79WfL3PHmHlz0X2GBDEPfeoB0-6b-UIBAH89nYKkSfkU84cvtYOM-TBeJ6WiLQrocDYAeZnlcWeP-MJMZeKZSwal3dH6yP2eAFGI_nzpOjFFRnYYfnwCIA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.41,
    6.71,
    5.7,
    8.2,
    1,
    7.49,
    6.5,
    8.71,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '1 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'the-iron-fairies-music-bar-bangkok-thonglor',                                          -- slug
    'The Iron Fairies Music Bar Bangkok',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'jazz-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '1-2 Soi Sukhumvit 39, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7368808,                                                   -- latitude
    100.57154519999999,                                                   -- longitude
    'https://maps.google.com/?cid=18031876100997070814&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJGbCedYud4jAR3j_J4cYXPvo',                                -- google_place_id
    '063 901 1115',                -- phone
    'https://www.facebook.com/ironfairiesbkk/',                               -- website
    NULL,                                                     -- instagram_handle
    '7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['live-music','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJGbCedYud4jAR3j_J4cYXPvo/photos/Ab43m-vwZQYwXBVWzo18hrzhYw9xsX1WhZ5y5ewZRA1Zhwt4nsVWyPoClVgKqcKasC_HQ8_WVf2Vg0xoes2UnRvdQxfohxWyRe-bHBqYoPMZW5TW14kmhthM_1hs_JFT7CJFx-92VQYXANGPagSI_GwgvyrJRk36dwiOOJ8IvlsFAUozNpqeFyqPPwCe_p_AdaDWzTX0xi0RBrSsDvjxW4ahNjc8omWBe0-GE2ecHa9GVGo4kgw_zpw8Kr3mdPzw-HZbOriUbZC78MvwAc1eYJjB9zbAHbCaahqQygfyqSgyugexkQ/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.29,
    7.41,
    5.88,
    8.13,
    1,
    7.51,
    6.5,
    8.97,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '4 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'sing-sing-theater-thonglor',                                          -- slug
    'Sing Sing Theater',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '45 Soi Sukhumvit 45, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.728252,                                                   -- latitude
    100.57350129999999,                                                   -- longitude
    'https://maps.google.com/?cid=6303623399191260627&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJQyjXvgCf4jAR062iYhX4elc',                                -- google_place_id
    '063 225 1331',                -- phone
    'https://linktr.ee/singsingtheater',                               -- website
    NULL,                                                     -- instagram_handle
    NULL,                                           -- opening_hours
    '฿฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','premium','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJQyjXvgCf4jAR062iYhX4elc/photos/Ab43m-unzFtcNAdabDzgOaQKfph_q4F_WED5RRhy1TTjwmVARjPquceeTjdpGduYOvs2_fHlbcYWkYTanXraQ1OXgAisDotvqP5N0UpaM1r8EGMaAHWCp1rsWQejMcYme0TwR_-3xxSLKn9rgtw5ssmaoXBjzzpOUDC5SA28BvXqDFsr-QLxtF41QzaO0uZrwQJo4adTutRzDVgrg4bhexuAMmS2-0i2eniy1TwFFt7We_n-WSRx7dg7GStjMJKQmTmMeXcGwsN44APbkKWqHHHpBfqUJHsTYbanxzqZ7XmfdDI7qw/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    8.1,
    7.76,
    6.01,
    8.31,
    1,
    6.98,
    6.5,
    8.75,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'tichuca-rooftop-bar-thonglor',                                          -- slug
    'Tichuca Rooftop Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'rooftop-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'ตึก ที วัน ชั้น 46, Soi Sukhumvit 40, Khwaeng Phra Khanong, Khet Khlong Toei, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7222399,                                                   -- latitude
    100.5807134,                                                   -- longitude
    'https://maps.google.com/?cid=3170203217852474558&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJPXYszxSf4jARvqTluQfT_is',                                -- google_place_id
    '065 878 5562',                -- phone
    'http://tichuca.co/',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 5:00 PM – 12:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['rooftop','city-views','popular','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJPXYszxSf4jARvqTluQfT_is/photos/Ab43m-vlcyFO97L8HWA4DvpXzpvR8TgAnH344n4XOGd4qQnIrmvuhbU76HkjcKnhzvr7l0Gjkf7L0Re88VAEvob_6_BDmfSyKKnDBnov2BiDJx4TJblmdORSUamftwvy_64rOdlEIJEOSgz6AQlMdwFh9gLSa1NRqFaQbZEd1T_PRQ1eTq4CoRPBQJ9BXkAvLpj1oesWJVp6rhdbHXOmn6t9Cry907GCbbgygtwD-4e_4IqRyEuObHl_Goxx99M9Wp_yKsyNhlsV49IauqKAx_IcZoXuY25Y_z2f-Xj1QXWfZDWHU7QmXalVUt6HPk7ERF27W9E_ZKaDn2JK9quQA3adwjtpYFd7zTTjzdBg-eDE115WwJROPdFwB_BXcp4wVFvH6kyF-2e-x3aqZ__H6gmcc9NsPGuQoY5ZTGBKjr0Bgp3bRA/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    6.67,
    7.21,
    9.1,
    5.96,
    5.37,
    8.1,
    6.5,
    8.25,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '6 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'truth-or-dare-thong-lor-thonglor',                                          -- slug
    'Truth or Dare [Thong Lor]',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'nightclub',                                   -- category
    NULL,                                                     -- tagline (fill later)
    'PHJM+GRG 117/1 ซ. พร้อมมิตร Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.7313162,                                                   -- latitude
    100.58455939999999,                                                   -- longitude
    'https://maps.google.com/?cid=1881904120032968434&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJmSEmRgCf4jAR8r7oj9PdHRo',                                -- google_place_id
    NULL,                -- phone
    NULL,                               -- website
    NULL,                                                     -- instagram_handle
    '11:00 AM – 1:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['clubbing','late-night','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJmSEmRgCf4jAR8r7oj9PdHRo/photos/Ab43m-tJOmicP9z5CiqM_fU8wQECblu_CqIWYag-rtC8TY6DaoDGRlzUA1wo35Il_vbIXX1XEPYM3EtcHwns2BmFX659vKr-ARJ3gw_Ct3A7sIILVW4ZnWPkP-FnXfmpjYGnIvCfcrnRbPcfenFwo-G8wC-SH4sySyMdmYZjCl-4y9fxqGL0oeC8ppY_CCPpTtphjHL3LD199_NKx0EKoVS7Fol8sGjGddVI3tf2OI7WgUu2hyQzhI03l65FqGOTHHCXyvvUNlqdkLIs1LjOBWc9zmQdJQiwhzFobobh-hZjZ57XTKL4yoU15DU3IUp2srO57BMMwD2Qx7V0PMLdK-d40tzcjR_NoLMkHaVGgOxMLq7LasHVz8fY-yP-ip3BwuWILDVYK6im8I-KQXWersFAk0lDivJmGnJzVQNTrTo_0q8/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.29,
    6.72,
    5.86,
    7.65,
    1,
    8.38,
    6.5,
    8.8,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '5 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  ),

  (
    'lux-bar-thonglor',                                          -- slug
    'Lux Bar',                   -- name
    'bangkok',                                                -- city
    (SELECT id FROM areas WHERE slug = 'thonglor'), -- area_id
    'thonglor',                                   -- area_slug
    'cocktail-bar',                                   -- category
    NULL,                                                     -- tagline (fill later)
    '18 Soi Thong Lo, Khwaeng Khlong Tan Nuea, Watthana, Krung Thep Maha Nakhon 10110, Thailand',                     -- address
    13.731780899999999,                                                   -- latitude
    100.58132359999999,                                                   -- longitude
    'https://maps.google.com/?cid=1038886904022440097&g_mp=CiVnb29nbGUubWFwcy5wbGFjZXMudjEuUGxhY2VzLkdldFBsYWNlEAIYASAA',                                   -- google_maps_url
    'ChIJe0off_Sf4jARoRgQjCLeag4',                                -- google_place_id
    '081 340 4570',                -- phone
    'https://www.facebook.com/LuxBarByZeta',                               -- website
    NULL,                                                     -- instagram_handle
    'Daily: 7:00 PM – 2:00 AM',                                           -- opening_hours
    '฿฿',                                            -- price_range
    ARRAY['cocktails','thonglor'],                                               -- tags
    'https://places.googleapis.com/v1/places/ChIJe0off_Sf4jARoRgQjCLeag4/photos/Ab43m-tNcDtB7hYLNstq5Ik8y0Vgvh8WpwRboqjQ_az4fHzWPgrDuRAyvU9_FC3QxBDJaBF0j7lstkaNyPuaQAnu0ABx2ERHmkKXVZrv7WqmVjBXhYUJoDKWyc3q_djBeqP0debEfWu7s-eSkR1PfAwPM0k1Y0wnkd-5YVWb6E-YN2h-P_K4HMGXa_LOIRzST12AfeWWakyCycBN46Y7bV_dSELBJ_mCN8Rr99r9xI4Z8snZqdTeQyLt1QI_Ga8nR-o6YVUHgNm9tIS7iIMXn7GkWdTBWMX_sDXWdd0BZbojRqK__x5SSdA2HSPlRH_d_4Ce2vt4OF1NbsDTruRR4WqPy3sCj4o3SnJAifVlpWOMBDZDU42kr0vaNP0WPT_960gpBd6QQyUH48RIVujre-23kMTx4QVfk7R7hH7UY0oFhTMDww/media?maxHeightPx=800&maxWidthPx=800&key=GOOGLE_MAPS_API_KEY',                    -- hero_image_url
    7.15,
    7.22,
    8.21,
    6.01,
    1.1,
    7.73,
    6.5,
    7.36,
    TRUE,                                                     -- is_published
    NOW() - INTERVAL '2 days',                                            -- last_verified_at
    'scraper'                                                 -- verified_by
  )
ON CONFLICT (slug) DO UPDATE SET
  google_place_id         = EXCLUDED.google_place_id,
  address                 = COALESCE(EXCLUDED.address, venues.address),
  phone                   = COALESCE(EXCLUDED.phone, venues.phone),
  website                 = COALESCE(EXCLUDED.website, venues.website),
  opening_hours           = COALESCE(EXCLUDED.opening_hours, venues.opening_hours),
  hero_image_url          = COALESCE(EXCLUDED.hero_image_url, venues.hero_image_url),
  updated_at              = NOW();

-- Backfill category_score for all new venues
PERFORM compute_category_score(id)
FROM venues
WHERE city = 'bangkok'
  AND verified_by = 'scraper'
  AND is_published = TRUE;

END $$;

-- Verification
SELECT
  area_slug,
  category,
  COUNT(*)                         AS venues,
  ROUND(AVG(overall_score), 2)    AS avg_score,
  MIN(overall_score)               AS min_score,
  MAX(overall_score)               AS max_score
FROM venues
WHERE city = 'bangkok' AND is_published = TRUE
GROUP BY area_slug, category
ORDER BY area_slug, venues DESC;
