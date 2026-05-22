# ThaiNight Venue Import Plan

Context: ThaiNight.co is moving from Bangkok-only to a Thailand nightlife hub.
Current target: Bangkok 300 venues; Pattaya, Phuket, Chiang Mai 40 venues each.

## Architecture

1. Collect venue leads into `venue_import_candidates`.
2. Normalize fields: name, slug, city, area, category, address, coordinates, hours, website, socials.
3. Deduplicate by `source_place_id`, normalized name, city, and area.
4. Review candidates and assign confidence.
5. Promote approved candidates into `venues`.
6. Keep `overall_score` generated in PostgreSQL only.

## Import Entry Points

Local JSON import:

```bash
npm run import:candidates -- ./data/import-candidates.example.json
```

Admin API import:

```bash
curl -X POST https://thainight.co/api/import-candidates \
  -H "Authorization: Bearer $ADMIN_SECRET_KEY" \
  -H "Content-Type: application/json" \
  -d '{"candidates":[{"city":"bangkok","name":"Venue Name","area_slug":"thonglor"}]}'
```

Admin API review list:

```bash
curl "https://thainight.co/api/import-candidates?city=bangkok&status=new&limit=100" \
  -H "Authorization: Bearer $ADMIN_SECRET_KEY"
```

## Source Priority

1. Google Places API or exported place IDs for base identity, coordinates, address, phone, opening hours.
2. Official venue websites and social profiles for current positioning and contact details.
3. Tourism or editorial directories only as discovery leads, not as copied content.
4. Manual review for categories and ThaiNight-specific scores.

## City Targets

- Bangkok: 300 venues across Thonglor, Silom, Ekkamai, Asok, Nana, Ari, RCA, Sathorn, Sukhumvit, Khao San.
- Pattaya: 40 venues across Walking Street, Soi Buakhao, Beach Road, Jomtien.
- Phuket: 40 venues across Patong, Bangla Road, Kata, Rawai, Kamala.
- Chiang Mai: 40 venues across Nimman, Old City, Night Bazaar, Riverside.

## Collection Order

1. Bangkok core 100: Thonglor, Silom, Ekkamai, Asok/Nana.
2. Bangkok expansion 200: Ari, RCA, Sathorn, Sukhumvit, Khao San, hotel rooftops.
3. Pattaya first 40: Walking Street, Soi Buakhao, Beach Road, Jomtien.
4. Phuket first 40: Patong, Bangla Road, Kata, Rawai, Kamala.
5. Chiang Mai first 40: Nimman, Old City, Night Bazaar, Riverside.

## Candidate JSON Fields

Minimum:

```json
{
  "city": "bangkok",
  "name": "Venue Name",
  "area_slug": "thonglor"
}
```

Recommended:

```json
{
  "city": "bangkok",
  "area_slug": "thonglor",
  "source_type": "google_places",
  "source_name": "Google Places",
  "source_place_id": "place-id",
  "source_url": "https://maps.google.com/...",
  "name": "Venue Name",
  "category": "cocktail-bar",
  "address": "Street address",
  "latitude": 13.7289,
  "longitude": 100.5844,
  "phone": "+66...",
  "website": "https://venue.example",
  "instagram_handle": "venuehandle",
  "opening_hours": "Daily: 6pm-2am",
  "price_range": "฿฿฿",
  "tags": ["cocktails", "date-night"],
  "confidence_score": 8
}
```

## Rules

- Do not scrape private/authenticated pages.
- Do not copy third-party editorial descriptions.
- Store source URL and raw payload for audit.
- Never publish directly into `venues` without review.
- Every imported venue needs `last_verified_at` before it becomes SEO-facing.
