// Context: Bangkok Nightlife SEO Hub | Current Date: May 2026 | Priority: own "Nightlife" despite ThaiNight.co.

export type MetaTitleType = "venue" | "area" | "category" | "home";

type MetaTitleInput = {
  type: MetaTitleType;
  name?: string;
  location?: string;
  category?: string;
};

const BRAND = "ThaiNight";
const CURRENT_MONTH_YEAR = "May 2026";

function titleCase(value: string): string {
  return value
    .replace(/-/g, " ")
    .split(" ")
    .filter(Boolean)
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(" ");
}

export function formatLocationName(value: string): string {
  return titleCase(value);
}

export function formatCategoryName(value: string): string {
  const normalized = value.replace(/-/g, " ");
  const overrides: Record<string, string> = {
    bars: "Bars",
    "cocktail bars": "Cocktail Bars",
    "rooftop bars": "Rooftop Bars",
    nightclubs: "Nightclubs",
    "gentlemen clubs": "Gentlemen's Clubs",
    "gentlemen's clubs": "Gentlemen's Clubs",
  };

  return overrides[normalized.toLowerCase()] ?? titleCase(normalized);
}

export function generateMetaTitle({
  type,
  name,
  location,
  category,
}: MetaTitleInput): string {
  switch (type) {
    case "venue":
      return `${name ?? "Venue"} Review: ${
        category ?? "Nightlife Venue"
      } in ${location ?? "Thailand"} | Updated ${CURRENT_MONTH_YEAR} | ${BRAND}`;

    case "area":
      return `${
        location ?? "Thailand"
      } Nightlife Guide: Best Bars & Clubs | Verified ${CURRENT_MONTH_YEAR} | ${BRAND}`;

    case "category":
      return `${category ?? "Best Nightlife"} in ${
        location ?? "Thailand"
      } (${CURRENT_MONTH_YEAR} Rankings) | ${BRAND}`;

    case "home":
    default:
      return `Thailand Nightlife Guide 2026: Bangkok, Phuket, Pattaya Bars & Clubs | ${BRAND}`;
  }
}

export function absoluteTitle(title: string): { absolute: string } {
  return { absolute: title };
}
