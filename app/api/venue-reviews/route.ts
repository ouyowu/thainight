import { NextRequest, NextResponse } from "next/server";
import { createAnonClient, createServerClient } from "@/lib/supabase/server";
import type { VenueMemberReviewInsert } from "@/lib/database.types";

// Context: ThaiNight first-party review layer | Current Date: May 2026 | Priority: authenticated field reports.

type ReviewPayload = {
  venue_id?: unknown;
  display_name?: unknown;
  rating?: unknown;
  body?: unknown;
  recommendation?: unknown;
};

function parsePayload(payload: ReviewPayload):
  | { valid: true; data: VenueMemberReviewInsert }
  | { valid: false; error: string } {
  if (typeof payload.venue_id !== "string" || payload.venue_id.trim().length === 0) {
    return { valid: false, error: "venue_id is required." };
  }
  const rating = Number(payload.rating);
  if (!Number.isInteger(rating) || rating < 1 || rating > 5) {
    return { valid: false, error: "rating must be an integer between 1 and 5." };
  }
  if (typeof payload.body !== "string" || payload.body.trim().length < 12 || payload.body.trim().length > 1200) {
    return { valid: false, error: "body must be 12-1200 characters." };
  }
  if (payload.recommendation !== "thumbs_up" && payload.recommendation !== "tomato") {
    return { valid: false, error: "recommendation must be thumbs_up or tomato." };
  }
  if (payload.display_name !== undefined && typeof payload.display_name !== "string") {
    return { valid: false, error: "display_name must be a string." };
  }

  return {
    valid: true,
    data: {
      venue_id: payload.venue_id.trim(),
      display_name: typeof payload.display_name === "string" ? payload.display_name.trim().slice(0, 60) || null : null,
      rating,
      body: payload.body.trim(),
      recommendation: payload.recommendation,
    },
  };
}

export async function GET(request: NextRequest): Promise<NextResponse> {
  const venueId = new URL(request.url).searchParams.get("venueId")?.trim();
  if (!venueId) {
    return NextResponse.json({ error: "venueId is required." }, { status: 422 });
  }

  const supabase = createAnonClient();
  if (!supabase) {
    return NextResponse.json({ reviews: [] });
  }

  const { data, error } = await supabase
    .from("venue_member_reviews")
    .select("id, display_name, rating, body, recommendation, created_at")
    .eq("venue_id", venueId)
    .order("created_at", { ascending: false })
    .limit(30);

  if (error) {
    return NextResponse.json({ reviews: [] });
  }

  return NextResponse.json(
    { reviews: data ?? [] },
    { headers: { "Cache-Control": "public, s-maxage=120, stale-while-revalidate=600" } }
  );
}

export async function POST(request: NextRequest): Promise<NextResponse> {
  let payload: ReviewPayload;
  try {
    payload = await request.json() as ReviewPayload;
  } catch {
    return NextResponse.json({ error: "Invalid JSON body." }, { status: 400 });
  }

  const parsed = parsePayload(payload);
  if (!parsed.valid) {
    return NextResponse.json({ error: parsed.error }, { status: 422 });
  }

  const supabase = createServerClient();
  if (!supabase) {
    return NextResponse.json({ error: "Review service is not configured." }, { status: 503 });
  }

  const { data: authData, error: authError } = await supabase.auth.getUser();
  if (authError || !authData.user) {
    return NextResponse.json({ error: "Sign in required." }, { status: 401 });
  }

  const { data, error } = await supabase
    .from("venue_member_reviews")
    .upsert(
      {
        ...parsed.data,
        user_id: authData.user.id,
      },
      { onConflict: "venue_id,user_id" }
    )
    .select("id, display_name, rating, body, recommendation, created_at")
    .single();

  if (error) {
    return NextResponse.json({ error: "Could not save review." }, { status: 500 });
  }

  return NextResponse.json({ review: data }, { status: 201 });
}
