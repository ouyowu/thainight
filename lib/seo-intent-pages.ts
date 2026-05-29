import type { CitySlug } from "@/lib/cities";

export type SeoIntentPageSlug =
  | "bangkok-nightlife-tonight"
  | "pattaya-nightlife-guide"
  | "phuket-bangla-road-safety"
  | "bangkok-rooftop-bars-2026"
  | "thailand-nightlife-price-tips"
  | "solo-traveler-bangkok-nightlife"
  | "phuket-nightlife-tonight"
  | "pattaya-nightlife-tonight"
  | "chiang-mai-nightlife-tonight"
  | "walking-street-pattaya-safety"
  | "bangkok-nightlife-safety"
  | "pattaya-nightlife-prices"
  | "phuket-nightlife-prices"
  | "bangkok-nightlife-first-time";

export type SeoIntentPageConfig = {
  slug: SeoIntentPageSlug;
  keyword: string;
  title: string;
  metaTitle: string;
  metaDescription: string;
  city?: CitySlug;
  category?: "new_opening" | "safety" | "price";
  heroLabel: string;
  intro: string;
  primaryCta: { label: string; href: string };
  secondaryCta: { label: string; href: string };
  sections: Array<{
    title: string;
    body: string;
  }>;
  internalLinks: Array<{ label: string; href: string }>;
};

export const SEO_INTENT_PAGES: SeoIntentPageConfig[] = [
  {
    slug: "bangkok-nightlife-tonight",
    keyword: "Bangkok nightlife tonight",
    title: "Bangkok nightlife tonight: where to go, what to check, and how to plan",
    metaTitle: "Bangkok Nightlife Tonight | Events, Areas, Warnings & Plans",
    metaDescription:
      "Plan Bangkok nightlife tonight with best areas, events, solo traveler tips, price checks, safety notes, and fresh ThaiNight intel.",
    city: "bangkok",
    heroLabel: "Tonight planner",
    intro:
      "Use this page when you need a fast Bangkok nightlife plan tonight: pick one area, check current events, watch for price or entry issues, and keep a simple backup route.",
    primaryCta: { label: "See tonight page", href: "/tonight" },
    secondaryCta: { label: "Open Bangkok guide", href: "/bangkok" },
    sections: [
      {
        title: "Best areas to start tonight",
        body: "First-timers usually do better by choosing one nightlife area instead of crossing the city late. Sukhumvit Soi 11 is easy, Thonglor is more polished, RCA is club-focused, and Silom has a wider mix of bars and late-night options.",
      },
      {
        title: "What to check before leaving",
        body: "Check event time, cover charge, final-entry rules, dress code, and recent comments. Bangkok events can change quickly, especially around ticket windows and last-entry times.",
      },
      {
        title: "Solo traveler angle",
        body: "If you are going out alone, choose a walkable area, keep your hotel reasonably close, and avoid committing to a long cross-city plan after midnight.",
      },
    ],
    internalLinks: [
      { label: "Bangkok nightlife guide", href: "/bangkok" },
      { label: "Bangkok rooftop bars", href: "/bangkok/rooftop-bars" },
      { label: "Sukhumvit Soi 11", href: "/bangkok?search=sukhumvit%20soi%2011" },
      { label: "ThaiNight intel", href: "/intel" },
    ],
  },
  {
    slug: "pattaya-nightlife-guide",
    keyword: "Pattaya nightlife guide",
    title: "Pattaya nightlife guide: Walking Street, prices, safety, and solo plans",
    metaTitle: "Pattaya Nightlife Guide | Walking Street, Prices & Safety",
    metaDescription:
      "A practical Pattaya nightlife guide for Walking Street, Soi Buakhao, beach bars, solo travelers, prices, warnings, and current ThaiNight intel.",
    city: "pattaya",
    heroLabel: "City guide",
    intro:
      "Pattaya nightlife is easy to access but can feel noisy for first-timers. This guide helps travelers compare areas, understand price signals, and avoid obvious tourist traps.",
    primaryCta: { label: "Open Pattaya guide", href: "/pattaya" },
    secondaryCta: { label: "Check price tips", href: "/intel#price-tips" },
    sections: [
      {
        title: "Where to start in Pattaya",
        body: "Walking Street is the most obvious nightlife area, but Soi Buakhao, Central Pattaya, and Jomtien can be better depending on budget, music taste, and how intense you want the night to feel.",
      },
      {
        title: "Price and tourist-trap checks",
        body: "Confirm drink prices, bar fine rules where relevant, cover charges, and transport before you settle in. The easiest mistake is assuming every venue has the same pricing style.",
      },
      {
        title: "Solo traveler planning",
        body: "Pattaya is solo-friendly, but it rewards a slower pace. Start early, keep a clear budget, and avoid following street offers that feel rushed or vague.",
      },
    ],
    internalLinks: [
      { label: "Pattaya city page", href: "/pattaya" },
      { label: "Walking Street search", href: "/pattaya?search=walking%20street" },
      { label: "Thailand price tips", href: "/thailand-nightlife-price-tips" },
      { label: "Warnings library", href: "/intel#warnings" },
    ],
  },
  {
    slug: "phuket-bangla-road-safety",
    keyword: "Phuket Bangla Road safety",
    title: "Phuket Bangla Road safety: what to check before a night out",
    metaTitle: "Phuket Bangla Road Safety | Nightlife Tips & Warnings",
    metaDescription:
      "Practical Phuket Bangla Road safety tips for tourists: prices, transport, solo traveler basics, scams, late-night planning, and reviewed warnings.",
    city: "phuket",
    category: "safety",
    heroLabel: "Safety guide",
    intro:
      "Bangla Road can be fun, loud, and easy to navigate, but tourists should still check prices, transport, venue rules, and late-night risk before going out.",
    primaryCta: { label: "Open Phuket guide", href: "/phuket" },
    secondaryCta: { label: "View warnings", href: "/intel#warnings" },
    sections: [
      {
        title: "Basic Bangla Road safety",
        body: "Stay in the main busy zone, keep your phone and wallet close, confirm prices before ordering, and use clear transport options when leaving late.",
      },
      {
        title: "Price and entry checks",
        body: "Look for minimum spend, special event pricing, drink menus, and unclear promotions. If a deal sounds vague, ask before ordering.",
      },
      {
        title: "Solo and group planning",
        body: "Solo travelers should keep the night simple: one main area, one fallback venue, and an easy route back. Groups should agree on a meeting point before splitting up.",
      },
    ],
    internalLinks: [
      { label: "Phuket nightlife", href: "/phuket" },
      { label: "Bangla Road search", href: "/phuket?search=bangla%20road" },
      { label: "Safety warnings", href: "/intel#warnings" },
      { label: "Tonight in Thailand", href: "/tonight" },
    ],
  },
  {
    slug: "bangkok-rooftop-bars-2026",
    keyword: "Bangkok rooftop bars 2026",
    title: "Bangkok rooftop bars 2026: skyline drinks, dress codes, and price checks",
    metaTitle: "Bangkok Rooftop Bars 2026 | Views, Dress Codes & Prices",
    metaDescription:
      "Find Bangkok rooftop bars in 2026 with skyline planning tips, dress code notes, price checks, areas, and updated ThaiNight venue pages.",
    city: "bangkok",
    heroLabel: "Rooftop guide",
    intro:
      "Bangkok rooftop bars are best planned around view, dress code, weather, price, and location. Use this page to avoid picking a rooftop that looks good online but does not fit your night.",
    primaryCta: { label: "Open rooftop bars", href: "/bangkok/rooftop-bars" },
    secondaryCta: { label: "Open Bangkok guide", href: "/bangkok" },
    sections: [
      {
        title: "How to choose a rooftop",
        body: "Choose by area first. Sukhumvit and Sathorn are convenient for many hotels, while riverside rooftops can feel more scenic but require more transport planning.",
      },
      {
        title: "Dress code and timing",
        body: "Many rooftops are stricter than normal bars. Check shoes, shorts, reservation rules, and sunset timing before you go.",
      },
      {
        title: "Price expectations",
        body: "Rooftops are rarely the cheapest night out. Compare cover charge, minimum spend, drink prices, and whether the view is worth the premium.",
      },
    ],
    internalLinks: [
      { label: "Bangkok rooftop bars", href: "/bangkok/rooftop-bars" },
      { label: "Bangkok nightlife tonight", href: "/bangkok-nightlife-tonight" },
      { label: "Price tips", href: "/intel#price-tips" },
      { label: "Bangkok cocktail bars", href: "/bangkok/cocktail-bars" },
    ],
  },
  {
    slug: "thailand-nightlife-price-tips",
    keyword: "Thailand nightlife price tips",
    title: "Thailand nightlife price tips: cover charges, drinks, tickets, and fees",
    metaTitle: "Thailand Nightlife Price Tips | Fees, Drinks & Tickets",
    metaDescription:
      "Thailand nightlife price tips for travelers: cover charges, drink prices, event tickets, late-entry fees, guest lists, and reviewed ThaiNight price intel.",
    category: "price",
    heroLabel: "Price guide",
    intro:
      "Thailand nightlife prices vary by city, area, venue type, and event. This page collects practical checks so travelers can avoid surprise fees before going out.",
    primaryCta: { label: "View price tips", href: "/intel#price-tips" },
    secondaryCta: { label: "Plan tonight", href: "/tonight" },
    sections: [
      {
        title: "Common costs to check",
        body: "Look for cover charge, drink minimums, event ticket windows, final-entry rules, service charges, and transport costs after midnight.",
      },
      {
        title: "City differences",
        body: "Bangkok can be higher for rooftops and premium clubs, Pattaya varies heavily by street and venue type, Phuket tourist zones can shift prices around events, and Chiang Mai is usually calmer but still worth checking.",
      },
      {
        title: "How to avoid surprises",
        body: "Read recent comments, confirm event rules, and avoid vague street promotions. If pricing is unclear before you enter, it is usually worth asking directly.",
      },
    ],
    internalLinks: [
      { label: "ThaiNight intel", href: "/intel" },
      { label: "Bangkok nightlife tonight", href: "/bangkok-nightlife-tonight" },
      { label: "Pattaya nightlife guide", href: "/pattaya-nightlife-guide" },
      { label: "Offers", href: "/offers" },
    ],
  },
  {
    slug: "solo-traveler-bangkok-nightlife",
    keyword: "Solo traveler Bangkok nightlife",
    title: "Solo traveler Bangkok nightlife: where to go and how to keep it simple",
    metaTitle: "Solo Traveler Bangkok Nightlife | Areas, Safety & Plans",
    metaDescription:
      "Bangkok nightlife tips for solo travelers: best areas, safe planning, where to meet people, price checks, transport, and current ThaiNight updates.",
    city: "bangkok",
    heroLabel: "Solo traveler guide",
    intro:
      "Bangkok is one of the easier cities in Asia for solo nightlife, but the best night usually comes from choosing a clear area, keeping transport simple, and not over-planning.",
    primaryCta: { label: "See who is going out", href: "/tonight#people" },
    secondaryCta: { label: "Open Bangkok guide", href: "/bangkok" },
    sections: [
      {
        title: "Best solo-friendly areas",
        body: "Soi 11 is easy for a first night, Thonglor works well for a polished night, Silom has a broad mix, and RCA is better when you specifically want clubs.",
      },
      {
        title: "Meeting people without forcing it",
        body: "Start in social areas with multiple venues nearby. Bars, rooftops, and event nights are usually easier than arriving cold at a packed club.",
      },
      {
        title: "Safety basics",
        body: "Keep a simple exit plan, use Grab or official taxis late, confirm prices before ordering, and avoid following vague street offers.",
      },
    ],
    internalLinks: [
      { label: "Tonight page", href: "/tonight" },
      { label: "Bangkok nightlife tonight", href: "/bangkok-nightlife-tonight" },
      { label: "Bangkok bars", href: "/bangkok/bars" },
      { label: "Warnings", href: "/intel#warnings" },
    ],
  },
  {
    slug: "phuket-nightlife-tonight",
    keyword: "Phuket nightlife tonight",
    title: "Phuket nightlife tonight: best areas, event checks, and how to keep the night simple",
    metaTitle: "Phuket Nightlife Tonight | Patong, Events, Prices & Safety",
    metaDescription:
      "Plan Phuket nightlife tonight with Patong and beach-club options, current events, price checks, transport basics, and reviewed ThaiNight safety notes.",
    city: "phuket",
    heroLabel: "Tonight planner",
    intro:
      "Use this page when you want a same-night Phuket plan without overcomplicating it. Start with one nightlife zone, confirm event and transport details, and keep a simple route back.",
    primaryCta: { label: "See tonight page", href: "/tonight" },
    secondaryCta: { label: "Open Phuket guide", href: "/phuket" },
    sections: [
      {
        title: "Where to start in Phuket tonight",
        body: "Patong is still the obvious nightlife base for first-timers because venues, transport, and foot traffic are easier to understand. Beach clubs and quieter bars make more sense when you already know the area you want.",
      },
      {
        title: "What to check before going out",
        body: "Look at event timing, minimum spend, final-entry rules, and your ride back before you leave. Phuket nights get harder once you are moving between areas without a plan.",
      },
      {
        title: "Best approach for a simple night",
        body: "Pick one zone, one backup venue, and one clear way home. That keeps the night easy whether you are solo, on a couple's trip, or just trying to avoid tourist confusion.",
      },
    ],
    internalLinks: [
      { label: "Phuket city guide", href: "/phuket" },
      { label: "Bangla Road safety", href: "/phuket-bangla-road-safety" },
      { label: "Thailand events", href: "/events" },
      { label: "ThaiNight intel", href: "/intel" },
    ],
  },
  {
    slug: "pattaya-nightlife-tonight",
    keyword: "Pattaya nightlife tonight",
    title: "Pattaya nightlife tonight: where to go, what to spend, and what to double-check first",
    metaTitle: "Pattaya Nightlife Tonight | Areas, Prices, Events & Tips",
    metaDescription:
      "Plan Pattaya nightlife tonight with Walking Street, Soi Buakhao, current events, price checks, solo-traveler basics, and reviewed ThaiNight warnings.",
    city: "pattaya",
    heroLabel: "Tonight planner",
    intro:
      "This page is for travelers who want a practical Pattaya plan tonight. Compare the main nightlife zones, check likely costs, and avoid making the night harder than it needs to be.",
    primaryCta: { label: "See tonight page", href: "/tonight" },
    secondaryCta: { label: "Open Pattaya guide", href: "/pattaya" },
    sections: [
      {
        title: "Best Pattaya areas tonight",
        body: "Walking Street suits first-timers who want the obvious main strip, Soi Buakhao feels more everyday and bar-heavy, and Jomtien is calmer if you want less intensity.",
      },
      {
        title: "Price and transport checks",
        body: "Before you settle anywhere, confirm drink prices, cover charges where relevant, and how you are getting back. Pattaya is easier when you decide your transport early instead of late at night.",
      },
      {
        title: "How to keep the night simple",
        body: "Choose one main zone, set a budget, and ignore vague last-minute offers. The strongest Pattaya nights usually come from clarity, not hopping too much.",
      },
    ],
    internalLinks: [
      { label: "Pattaya nightlife guide", href: "/pattaya-nightlife-guide" },
      { label: "Pattaya city page", href: "/pattaya" },
      { label: "Thailand price tips", href: "/thailand-nightlife-price-tips" },
      { label: "Warnings library", href: "/intel#warnings" },
    ],
  },
  {
    slug: "chiang-mai-nightlife-tonight",
    keyword: "Chiang Mai nightlife tonight",
    title: "Chiang Mai nightlife tonight: nimman bars, live music, and a low-stress night plan",
    metaTitle: "Chiang Mai Nightlife Tonight | Bars, Live Music & Tips",
    metaDescription:
      "Plan Chiang Mai nightlife tonight with Nimman, Old City, live music spots, simple transport planning, and reviewed ThaiNight warnings and offers.",
    city: "chiang-mai",
    heroLabel: "Tonight planner",
    intro:
      "Chiang Mai nightlife works best when you keep expectations realistic and the route simple. This page helps you choose the right zone and avoid wasting the night on scattered plans.",
    primaryCta: { label: "See tonight page", href: "/tonight" },
    secondaryCta: { label: "Open Chiang Mai guide", href: "/chiang-mai" },
    sections: [
      {
        title: "Best areas to start tonight",
        body: "Nimman is the easiest nightlife base for polished bars and easy movement, while Old City and riverside spots work better for slower nights, live music, and lower-pressure plans.",
      },
      {
        title: "What to check before you go",
        body: "Look at venue hours, live-music schedules, and how far your next stop really is. Chiang Mai nightlife is not about covering the whole city in one night.",
      },
      {
        title: "A better Chiang Mai night plan",
        body: "Pick one area, one live venue or bar you actually want, and one backup. That is usually enough for a fun night without turning it into a transport problem.",
      },
    ],
    internalLinks: [
      { label: "Chiang Mai city page", href: "/chiang-mai" },
      { label: "Nimman bars", href: "/chiang-mai/bars/nimman" },
      { label: "Live music venues", href: "/chiang-mai/live-music" },
      { label: "Tonight in Thailand", href: "/tonight" },
    ],
  },
  {
    slug: "walking-street-pattaya-safety",
    keyword: "Walking Street Pattaya safety",
    title: "Walking Street Pattaya safety: how to enjoy the area without making avoidable mistakes",
    metaTitle: "Walking Street Pattaya Safety | Prices, Transport & Warnings",
    metaDescription:
      "Walking Street Pattaya safety tips for tourists: prices, transport, solo traveler basics, late-night planning, and reviewed ThaiNight warning signals.",
    city: "pattaya",
    category: "safety",
    heroLabel: "Safety guide",
    intro:
      "Walking Street is the easiest Pattaya nightlife landmark to understand, but it still rewards simple planning. This page focuses on prices, transport, crowds, and basic tourist judgment.",
    primaryCta: { label: "Open Pattaya guide", href: "/pattaya" },
    secondaryCta: { label: "View warnings", href: "/intel#warnings" },
    sections: [
      {
        title: "Basic Walking Street safety",
        body: "Stay in the busiest visible areas, keep transport simple, and avoid handing control of the night to anyone whose pricing or pitch is unclear from the start.",
      },
      {
        title: "Price and venue checks",
        body: "Confirm drink costs, entry expectations, and any venue-specific rules before you settle in. Walking Street is easier when you ask first instead of guessing.",
      },
      {
        title: "Solo traveler and late-night planning",
        body: "If you are alone, keep the route short, set a rough budget, and know your way back before it gets late. Safety improves a lot when the exit plan is already decided.",
      },
    ],
    internalLinks: [
      { label: "Pattaya nightlife guide", href: "/pattaya-nightlife-guide" },
      { label: "Pattaya city page", href: "/pattaya" },
      { label: "Thailand price tips", href: "/thailand-nightlife-price-tips" },
      { label: "Tonight page", href: "/tonight" },
    ],
  },
  {
    slug: "bangkok-nightlife-safety",
    keyword: "Bangkok nightlife safety",
    title: "Bangkok nightlife safety: what travelers should check before a late night out",
    metaTitle: "Bangkok Nightlife Safety | Prices, Transport & Warnings",
    metaDescription:
      "Bangkok nightlife safety tips for travelers: taxis, prices, overcharge signals, area choice, late-night planning, and reviewed ThaiNight warnings.",
    city: "bangkok",
    category: "safety",
    heroLabel: "Safety guide",
    intro:
      "Bangkok is one of the easier big cities in Asia for nightlife, but the best nights still come from simple planning. This page focuses on area choice, prices, transport, and the avoidable mistakes travelers make late at night.",
    primaryCta: { label: "Open Bangkok guide", href: "/bangkok" },
    secondaryCta: { label: "View warnings", href: "/intel#warnings" },
    sections: [
      {
        title: "Start with the right area",
        body: "First-timers usually do better in one clear nightlife zone like Soi 11, Thonglor, Silom, or RCA instead of trying to cross Bangkok after midnight without a reason.",
      },
      {
        title: "Price and overcharge checks",
        body: "Confirm cover charge, final-entry rules, menu pricing, and any minimum spend before you commit. A quick question before ordering is usually enough to avoid the most common mistakes.",
      },
      {
        title: "Transport matters more late",
        body: "Use Grab or obvious official transport late at night, keep your route back simple, and avoid turning a good night into a long, confused city transfer.",
      },
    ],
    internalLinks: [
      { label: "Bangkok nightlife tonight", href: "/bangkok-nightlife-tonight" },
      { label: "Solo traveler Bangkok nightlife", href: "/solo-traveler-bangkok-nightlife" },
      { label: "Warnings library", href: "/intel#warnings" },
      { label: "Bangkok city page", href: "/bangkok" },
    ],
  },
  {
    slug: "pattaya-nightlife-prices",
    keyword: "Pattaya nightlife prices",
    title: "Pattaya nightlife prices: what to expect before you go out",
    metaTitle: "Pattaya Nightlife Prices | Fees, Drinks, Transport & Tips",
    metaDescription:
      "Pattaya nightlife price guide for travelers: drinks, entry fees, transport, Walking Street costs, and reviewed ThaiNight price signals.",
    city: "pattaya",
    category: "price",
    heroLabel: "Price guide",
    intro:
      "Pattaya can feel affordable until a night gets vague. This page helps travelers understand the price differences between Walking Street, Soi Buakhao, beach clubs, and casual bar nights before they spend too much.",
    primaryCta: { label: "Open Pattaya guide", href: "/pattaya" },
    secondaryCta: { label: "View price tips", href: "/intel#price-tips" },
    sections: [
      {
        title: "What changes the price in Pattaya",
        body: "Street, venue type, music format, and how tourist-focused the area is all change the bill. Walking Street and event-driven nights usually behave differently from casual beer-bar or neighborhood routes.",
      },
      {
        title: "What to confirm first",
        body: "Check drink prices, cover charge, happy hour timing, and transport before you settle in. Clarity matters more than finding the cheapest number on paper.",
      },
      {
        title: "How to avoid surprise costs",
        body: "Pick one zone, set a budget early, and treat vague pricing as a warning sign. Pattaya is easiest when you slow the night down and ask before committing.",
      },
    ],
    internalLinks: [
      { label: "Pattaya nightlife guide", href: "/pattaya-nightlife-guide" },
      { label: "Pattaya nightlife tonight", href: "/pattaya-nightlife-tonight" },
      { label: "Walking Street Pattaya safety", href: "/walking-street-pattaya-safety" },
      { label: "Thailand price tips", href: "/thailand-nightlife-price-tips" },
    ],
  },
  {
    slug: "phuket-nightlife-prices",
    keyword: "Phuket nightlife prices",
    title: "Phuket nightlife prices: beach clubs, Patong, drinks, and what to check first",
    metaTitle: "Phuket Nightlife Prices | Patong, Beach Clubs & Fees",
    metaDescription:
      "Phuket nightlife price guide for travelers: Patong costs, beach club spend, drink prices, event fees, and reviewed ThaiNight price notes.",
    city: "phuket",
    category: "price",
    heroLabel: "Price guide",
    intro:
      "Phuket nightlife is not just about drinks. Area distance, beach clubs, event nights, and transport all change the cost. This page helps travelers understand what they are really paying for before going out.",
    primaryCta: { label: "Open Phuket guide", href: "/phuket" },
    secondaryCta: { label: "View price tips", href: "/intel#price-tips" },
    sections: [
      {
        title: "Why Phuket prices feel uneven",
        body: "Patong nightlife, Bangla Road nights, beach clubs, and sunset venues all price differently. Sometimes transport and distance matter as much as the venue bill itself.",
      },
      {
        title: "What to check before you commit",
        body: "Look at minimum spend, event pricing, entry timing, drink menus, and how expensive the trip back will be once the night ends.",
      },
      {
        title: "How to keep the bill manageable",
        body: "Stay in one zone, match the venue type to your actual budget, and avoid stacking transport, event fees, and premium drinks into one unplanned night.",
      },
    ],
    internalLinks: [
      { label: "Phuket nightlife tonight", href: "/phuket-nightlife-tonight" },
      { label: "Phuket Bangla Road safety", href: "/phuket-bangla-road-safety" },
      { label: "Phuket city guide", href: "/phuket" },
      { label: "Thailand price tips", href: "/thailand-nightlife-price-tips" },
    ],
  },
  {
    slug: "bangkok-nightlife-first-time",
    keyword: "Bangkok nightlife for first timers",
    title: "Bangkok nightlife for first timers: best areas, easiest plans, and what not to overthink",
    metaTitle: "Bangkok Nightlife for First Timers | Areas, Prices & Tips",
    metaDescription:
      "Bangkok nightlife guide for first timers: best areas to start, how to plan the night, what to spend, and what to check before going out.",
    city: "bangkok",
    heroLabel: "First-timer guide",
    intro:
      "The best first Bangkok nightlife plan is usually the simplest one. This page is for travelers who want to know where to start, what each area feels like, and what to double-check before they go out.",
    primaryCta: { label: "Open Bangkok guide", href: "/bangkok" },
    secondaryCta: { label: "Plan tonight", href: "/bangkok-nightlife-tonight" },
    sections: [
      {
        title: "Best Bangkok areas for a first night",
        body: "Soi 11 is easy and convenient, Thonglor feels more polished, Silom gives you a wider mix, and RCA makes more sense when you specifically want clubs. Pick one, not all four.",
      },
      {
        title: "What first-timers should check",
        body: "Look at dress code, cover charge, transport back, and whether you actually want bars, rooftops, or clubs. Most bad first nights come from trying to do too much at once.",
      },
      {
        title: "What not to overthink",
        body: "You do not need a perfect route across the whole city. One strong area, one backup venue, and one clear plan home is enough for a much better first night.",
      },
    ],
    internalLinks: [
      { label: "Bangkok nightlife tonight", href: "/bangkok-nightlife-tonight" },
      { label: "Bangkok nightlife safety", href: "/bangkok-nightlife-safety" },
      { label: "Bangkok rooftop bars", href: "/bangkok/rooftop-bars" },
      { label: "Bangkok city page", href: "/bangkok" },
    ],
  },
];

export function getSeoIntentPage(slug: string): SeoIntentPageConfig | null {
  return SEO_INTENT_PAGES.find((page) => page.slug === slug) ?? null;
}
