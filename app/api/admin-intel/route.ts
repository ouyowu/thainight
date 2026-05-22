import { NextRequest, NextResponse } from "next/server";
import { createServiceClient } from "@/lib/supabase/server";
import type { IntelligenceSourceType } from "@/lib/database.types";

type IntelType = "event" | "offer";
type IntelAction = "approve" | "reject";
type PublishAs = "event" | "offer";
type LooseIntelItem = Record<string, unknown>;

function stringOrNull(value: unknown): string | null {
  return typeof value === "string" ? value : null;
}

function booleanOrFalse(value: unknown): boolean {
  return typeof value === "boolean" ? value : false;
}

function sourceTypeOrManual(value: unknown): IntelligenceSourceType {
  return ["manual", "radarscout", "owner_upload", "community_upload"].includes(String(value))
    ? (value as IntelligenceSourceType)
    : "manual";
}

function unauthorized(): NextResponse {
  return NextResponse.json({ error: "Unauthorized." }, { status: 401 });
}

export async function PATCH(request: NextRequest): Promise<NextResponse> {
  const auth = request.headers.get("authorization");
  const adminKey = process.env.ADMIN_SECRET_KEY;
  if (!adminKey || auth !== `Bearer ${adminKey}`) {
    return unauthorized();
  }

  const id = request.nextUrl.searchParams.get("id");
  const type = request.nextUrl.searchParams.get("type") as IntelType | null;
  const action = request.nextUrl.searchParams.get("action") as IntelAction | null;
  const publishAs = (request.nextUrl.searchParams.get("publishAs") ?? type) as PublishAs | null;

  if (!id || !type || !action) {
    return NextResponse.json({ error: "Missing id, type, or action." }, { status: 400 });
  }

  if (
    !["event", "offer"].includes(type) ||
    !["approve", "reject"].includes(action) ||
    !publishAs ||
    !["event", "offer"].includes(publishAs)
  ) {
    return NextResponse.json({ error: "Invalid action payload." }, { status: 422 });
  }

  const supabase = createServiceClient();
  if (!supabase) {
    return NextResponse.json({ error: "Database unavailable." }, { status: 503 });
  }

  const table = type === "event" ? "event_flyers" : "venue_offers";
  const targetTable = publishAs === "event" ? "event_flyers" : "venue_offers";

  if (action === "approve" && table !== targetTable) {
    const { data: item, error: readError } = await supabase
      .from(table)
      .select("*")
      .eq("id", id)
      .single();

    if (readError || !item) {
      return NextResponse.json({ error: "Unable to read item." }, { status: 500 });
    }

    const now = new Date().toISOString();

    const source = item as LooseIntelItem;

    if (publishAs === "event") {
      const { error: insertError } = await supabase.from("event_flyers").insert({
        venue_id: stringOrNull(source.venue_id),
        venue_slug: stringOrNull(source.venue_slug),
        city: stringOrNull(source.city) ?? "bangkok",
        title: stringOrNull(source.title) ?? "Untitled nightlife item",
        description: stringOrNull(source.description),
        event_date: stringOrNull(source.valid_from),
        flyer_image_url: stringOrNull(source.image_url),
        source_url: stringOrNull(source.source_url),
        source_type: sourceTypeOrManual(source.source_type),
        status: "approved",
        is_featured: booleanOrFalse(source.is_featured),
        submitter_name: stringOrNull(source.submitter_name),
        submitter_email: stringOrNull(source.submitter_email),
        admin_notes: stringOrNull(source.admin_notes) ?? "Reclassified from pending offer.",
        reviewed_at: now,
      });

      if (insertError) {
        return NextResponse.json({ error: "Unable to create event." }, { status: 500 });
      }
    } else {
      const { error: insertError } = await supabase.from("venue_offers").insert({
        venue_id: stringOrNull(source.venue_id),
        venue_slug: stringOrNull(source.venue_slug),
        city: stringOrNull(source.city) ?? "bangkok",
        title: stringOrNull(source.title) ?? "Untitled nightlife offer",
        description: stringOrNull(source.description),
        offer_label: "Special offer",
        valid_from: stringOrNull(source.event_date),
        image_url: stringOrNull(source.flyer_image_url),
        source_url: stringOrNull(source.source_url),
        source_type: sourceTypeOrManual(source.source_type),
        status: "approved",
        is_featured: booleanOrFalse(source.is_featured),
        submitter_name: stringOrNull(source.submitter_name),
        submitter_email: stringOrNull(source.submitter_email),
        admin_notes: stringOrNull(source.admin_notes) ?? "Reclassified from pending event.",
        reviewed_at: now,
      });

      if (insertError) {
        return NextResponse.json({ error: "Unable to create offer." }, { status: 500 });
      }
    }

    const { error: closeOriginalError } = await supabase
      .from(table)
      .update({
        status: "rejected",
        reviewed_at: now,
      })
      .eq("id", id);

    if (closeOriginalError) {
      return NextResponse.json({ error: "Created target item, but original item was not closed." }, { status: 500 });
    }

    return NextResponse.json({ ok: true, reclassified: true });
  }

  const { error } = await supabase
    .from(table)
    .update({
      status: action === "approve" ? "approved" : "rejected",
      reviewed_at: new Date().toISOString(),
    })
    .eq("id", id);

  if (error) {
    return NextResponse.json({ error: "Unable to update item." }, { status: 500 });
  }

  return NextResponse.json({ ok: true });
}
