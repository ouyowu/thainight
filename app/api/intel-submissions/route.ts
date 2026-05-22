import { NextRequest, NextResponse } from "next/server";
import { createAnonClient } from "@/lib/supabase/server";
import type {
  EventFlyerInsert,
  IntelligenceSourceType,
  VenueOfferInsert,
} from "@/lib/database.types";

type SubmissionKind = "event" | "offer";

type Payload = {
  kind: SubmissionKind;
  city: string;
  title: string;
  description?: string;
  venue_slug?: string;
  image_url?: string;
  source_url?: string;
  event_date?: string;
  offer_label?: string;
  valid_from?: string;
  valid_until?: string;
  submitter_name?: string;
  submitter_email?: string;
};

function safeText(value: unknown): string | undefined {
  return typeof value === "string" ? value.trim() : undefined;
}

function validate(body: unknown): { ok: true; data: Payload } | { ok: false; error: string } {
  if (!body || typeof body !== "object") {
    return { ok: false, error: "Request body must be an object." };
  }

  const raw = body as Record<string, unknown>;
  const kind = raw.kind === "event" || raw.kind === "offer" ? raw.kind : null;
  const city = safeText(raw.city);
  const title = safeText(raw.title);

  if (!kind) return { ok: false, error: "kind must be event or offer." };
  if (!city) return { ok: false, error: "city is required." };
  if (!title || title.length < 4) return { ok: false, error: "title is too short." };

  const submitterEmail = safeText(raw.submitter_email);
  if (submitterEmail && !submitterEmail.includes("@")) {
    return { ok: false, error: "submitter_email is invalid." };
  }

  return {
    ok: true,
    data: {
      kind,
      city,
      title,
      description: safeText(raw.description),
      venue_slug: safeText(raw.venue_slug),
      image_url: safeText(raw.image_url),
      source_url: safeText(raw.source_url),
      event_date: safeText(raw.event_date),
      offer_label: safeText(raw.offer_label),
      valid_from: safeText(raw.valid_from),
      valid_until: safeText(raw.valid_until),
      submitter_name: safeText(raw.submitter_name),
      submitter_email: submitterEmail,
    },
  };
}

export async function POST(request: NextRequest): Promise<NextResponse> {
  let raw: unknown;
  try {
    raw = await request.json();
  } catch {
    return NextResponse.json({ error: "Invalid JSON body." }, { status: 400 });
  }

  const validation = validate(raw);
  if (!validation.ok) {
    return NextResponse.json({ error: validation.error }, { status: 422 });
  }

  const supabase = createAnonClient();
  if (!supabase) {
    return NextResponse.json({ error: "Database unavailable." }, { status: 503 });
  }

  const data = validation.data;
  const sourceType: IntelligenceSourceType = "community_upload";

  if (data.kind === "event") {
    const payload: EventFlyerInsert = {
      city: data.city,
      title: data.title,
      description: data.description ?? null,
      venue_slug: data.venue_slug ?? null,
      flyer_image_url: data.image_url ?? null,
      source_url: data.source_url ?? null,
      event_date: data.event_date ?? null,
      submitter_name: data.submitter_name ?? null,
      submitter_email: data.submitter_email ?? null,
      source_type: sourceType,
      status: "pending",
    };

    const { error } = await supabase.from("event_flyers").insert(payload);
    if (error) {
      return NextResponse.json({ error: "Unable to submit event." }, { status: 500 });
    }
  } else {
    const payload: VenueOfferInsert = {
      city: data.city,
      title: data.title,
      description: data.description ?? null,
      venue_slug: data.venue_slug ?? null,
      image_url: data.image_url ?? null,
      source_url: data.source_url ?? null,
      offer_label: data.offer_label ?? null,
      valid_from: data.valid_from ?? null,
      valid_until: data.valid_until ?? null,
      submitter_name: data.submitter_name ?? null,
      submitter_email: data.submitter_email ?? null,
      source_type: sourceType,
      status: "pending",
    };

    const { error } = await supabase.from("venue_offers").insert(payload);
    if (error) {
      return NextResponse.json({ error: "Unable to submit offer." }, { status: 500 });
    }
  }

  return NextResponse.json({
    ok: true,
    status: "pending_review",
  });
}
