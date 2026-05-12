# Copy everything below the line into Cursor (Chat or Composer)

---

Please follow this directory structure to initialize a Next.js 14+ App Router project.

Key Logic Requirements:

- **Dynamic Routing:** Ensure `[city]`, `[category]`, and `[venue-slug]` are handled as dynamic segments.
- **SEO Priority:** Every `page.tsx` under `[venue-slug]` must include a custom `<SchemaOrg />` component that generates LocalBusiness structured data.
- **Freshness Signal:** The `VerificationBadge` component should display "Verified This Week" if the `updated_at` date in the database is within the current week of May 2026.
- **Data Fetching:** Use Server Components by default for better SEO performance.

**App Router constraint (must satisfy):** Under `bars/`, do not place two sibling dynamic folders that both consume a single URL segment (e.g. `[area]` and `[venue-slug]` at the same level). Use **four-level** venue URLs for regional SEO, e.g. `/bangkok/bars/sukhumvit/tropic-city`, implemented as `bars/[area]/[venue-slug]/page.tsx`, with the area hub at `bars/[area]/page.tsx`.

Target directory tree:

```text
bangkok-nightlife-guide/
├── app/
│   ├── layout.tsx                 # Global: SEO meta, fonts, analytics
│   ├── page.tsx                   # Home: hero, search, top collections
│   │
│   ├── [city]/
│   │   ├── layout.tsx             # City: breadcrumbs, city-wide alerts
│   │   ├── page.tsx               # City hub: list of categories
│   │   │
│   │   ├── [category]/
│   │   │   └── page.tsx           # e.g. /bangkok/cocktail-bars — filters, scores
│   │   │
│   │   ├── bars/
│   │   │   ├── [area]/
│   │   │   │   ├── page.tsx       # e.g. /bangkok/bars/thonglor — area listing
│   │   │   │   └── [venue-slug]/
│   │   │   │       └── page.tsx   # venue detail: radar, scores, JSON-LD
│   │   │   └── page.tsx           # optional: /bangkok/bars — all bars index
│   │   │
│   │   └── gentlemen-clubs/
│   │       ├── [area]/
│   │       │   ├── page.tsx
│   │       │   └── [venue-slug]/
│   │       │       └── page.tsx
│   │       └── page.tsx           # optional: category index
│   │
│   └── api/
│       ├── submit-update/
│       │   └── route.ts
│       └── venues/
│           └── route.ts
│
├── components/
│   ├── ui/
│   ├── VenueScoreCard.tsx
│   ├── VerificationBadge.tsx
│   ├── NeighborhoodFilter.tsx
│   └── SchemaOrg.tsx
│
├── lib/
│   ├── supabase.ts
│   └── utils.ts                   # weighted score helpers, date helpers
│
└── public/
```

---

## 为什么这个结构对你有利？（给产品 / 团队看的上下文，可选）

- **无限扩展性：** 现在是 `/bangkok`，以后做 `/pattaya` 或 `/chiang-mai` 主要靠数据库与城市 slug，同一套路由与组件复用。
- **区域 SEO：** `/bangkok/bars/sukhumvit` 这类三级路径对「区域 + 垂类」意图很强；详情再用四级路径挂上具体店名，结构清晰、内链也好做。
- **开发者友好：** Cursor 看到稳定的 `app/[city]/...` 分层后，`import` 与职责边界更一致，减少乱跳路径与重复布局。

---

_End of paste_
