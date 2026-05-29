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
  | "walking-street-pattaya-safety";

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
];

export function getSeoIntentPage(slug: string): SeoIntentPageConfig | null {
  return SEO_INTENT_PAGES.find((page) => page.slug === slug) ?? null;
}
