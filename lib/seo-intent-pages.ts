import type { CitySlug } from "@/lib/cities";

export type SeoIntentPageSlug =
  | "bangkok-nightlife-tonight"
  | "pattaya-nightlife-guide"
  | "phuket-bangla-road-safety"
  | "bangkok-rooftop-bars-2026"
  | "thailand-nightlife-price-tips"
  | "solo-traveler-bangkok-nightlife";

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
];

export function getSeoIntentPage(slug: string): SeoIntentPageConfig | null {
  return SEO_INTENT_PAGES.find((page) => page.slug === slug) ?? null;
}
