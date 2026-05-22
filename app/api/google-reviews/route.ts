import { NextRequest, NextResponse } from "next/server";

// Context: ThaiNight venue detail pages | Current Date: May 2026 | Priority: balanced, attributed review excerpts.

type GoogleReview = {
  name?: string;
  rating?: number;
  text?: { text?: string };
  originalText?: { text?: string };
  relativePublishTimeDescription?: string;
  authorAttribution?: { displayName?: string };
};

type ReviewExcerpt = {
  id: string;
  rating: number;
  text: string;
  relative_time: string | null;
  author: string | null;
};

function normalizeReviews(reviews: GoogleReview[]): ReviewExcerpt[] {
  const normalized = reviews
    .map((review, index) => {
      const text = review.text?.text ?? review.originalText?.text ?? "";
      const rating = Number(review.rating ?? 0);
      if (!text || rating < 1 || rating > 5) return null;
      return {
        id: review.name ?? `review-${index}`,
        rating,
        text,
        relative_time: review.relativePublishTimeDescription ?? null,
        author: review.authorAttribution?.displayName ?? null,
      };
    })
    .filter((review): review is ReviewExcerpt => review !== null);

  const positive = normalized.filter((review) => review.rating >= 4);
  const critical = normalized.filter((review) => review.rating <= 2);
  const mixed = normalized.filter((review) => review.rating === 3);
  const balanced = [
    ...positive.slice(0, 2),
    ...critical.slice(0, 2),
    ...mixed.slice(0, 1),
    ...normalized,
  ];

  return Array.from(new Map(balanced.map((review) => [review.id, review])).values()).slice(0, 5);
}

export const revalidate = 86400;

export async function GET(request: NextRequest): Promise<NextResponse> {
  const placeId = new URL(request.url).searchParams.get("placeId")?.trim();
  const apiKey = process.env.GOOGLE_MAPS_API_KEY ?? process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY;

  if (!placeId) {
    return NextResponse.json({ error: "placeId is required." }, { status: 422 });
  }
  if (!apiKey) {
    return NextResponse.json({ error: "Google Maps API key is not configured." }, { status: 503 });
  }

  const url = new URL(`https://places.googleapis.com/v1/places/${placeId}`);
  url.searchParams.set("languageCode", "en");

  const response = await fetch(url, {
    headers: {
      "X-Goog-Api-Key": apiKey,
      "X-Goog-FieldMask": [
        "reviews.name",
        "reviews.rating",
        "reviews.text",
        "reviews.originalText",
        "reviews.relativePublishTimeDescription",
        "reviews.authorAttribution.displayName",
      ].join(","),
      Referer: "https://thainight.co/",
    },
    next: { revalidate: 86400 },
  });

  if (!response.ok) {
    return NextResponse.json({ error: "Google reviews unavailable." }, { status: 502 });
  }

  const payload = await response.json() as { reviews?: GoogleReview[] };
  return NextResponse.json(
    { reviews: normalizeReviews(payload.reviews ?? []) },
    { headers: { "Cache-Control": "public, s-maxage=86400, stale-while-revalidate=604800" } }
  );
}
