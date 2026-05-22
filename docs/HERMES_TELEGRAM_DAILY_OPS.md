# Hermes Telegram Daily Ops

Use `@ouyowu_bot` as the remote control for the ThaiNight project. Hermes is configured to work from:

`/Users/ouyowu/Documents/bangkok-nightlife-guide`

## Good Daily Command

Send this to Telegram:

```text
Daily ThaiNight check:
1. Pull the latest local project context.
2. Check build health.
3. Check homepage, city pages, venue detail pages, social hub, events, offers, sitemap, and SEO metadata.
4. If there are safe code fixes, make them.
5. Do not delete unrelated files.
6. Report what changed, what failed, and what I need to do manually.
```

## SEO Command

```text
ThaiNight SEO task:
Audit titles, descriptions, canonical URLs, sitemap, robots, JSON-LD, city/category/venue metadata, and English/Korean language routing. Fix safe issues and report remaining manual actions.
```

## Events And Offers Command

```text
ThaiNight events task:
Collect public Thailand nightlife events and happy-hour/special-offer leads from approved sources. Save only source-attributed items. Do not invent details. Add pending items for admin review, then report source URLs.
```

## Deployment Check Command

```text
ThaiNight deployment check:
Run a production build locally, inspect any errors, fix safe issues, and tell me whether it is ready to deploy to Vercel.
```

## Important Rule

Hermes can run tasks through Telegram as a remote agent. Codex Desktop is still the best place for large visual/UI refactors, screenshots, and final review.
