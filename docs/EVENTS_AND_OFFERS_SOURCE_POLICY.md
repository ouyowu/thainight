# ThaiNight Events & Offers Source Policy

ThaiNight can collect nightlife events, special offers, and travel-intent signals, but the pipeline must avoid copying protected event directories or auto-posting ads.

## Allowed ingestion

- Partner submissions from venues, promoters, bars, clubs, and community users.
- Official feeds, RSS/JSON/ICS calendars, or public APIs where reuse is allowed.
- Public pages from sources explicitly added to `EVENT_AUTO_IMPORT_HOSTS`, with source attribution preserved and status set to `pending` for review.
- ThaiNight intelligence signals that link back to the original public discussion and are summarized, not copied wholesale.

## Manual-review sources

- Resident Advisor (`ra.co`) should be treated as a human research source only unless ThaiNight has written permission or an official partner/API path.
- Eventpop links should be manually reviewed unless the organizer or platform provides an official reusable feed.

## Not allowed

- Automated commercial scraping of websites that prohibit automated extraction.
- Copying event artwork, descriptions, or ticket data without permission.
- Automated replies on Reddit, X, Quora, forums, or dating/travel communities.

## Outreach workflow

ThaiNight can monitor posts like “who wants to go out in Bangkok tonight” or “solo traveler looking for bars in Phuket”, then generate a reply draft. A human should review the context and post manually.

Safe reply style:

```text
That sounds like the exact kind of night ThaiNight tracks: events, venue tips, and people going out tonight. Might be useful while planning: https://thainight.co
```

Use the link sparingly. Helpful replies should come first; repeated copy-paste promotion will get accounts filtered.

## Scheduled import

Vercel Cron runs `/api/cron/import-events` at:

- 10:00 Thailand time
- 16:00 Thailand time
- 21:00 Thailand time

The cron route imports only allowed sources and writes records as `pending`, so an admin must approve or reject them before they appear publicly.
