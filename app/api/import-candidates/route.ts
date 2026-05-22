import { NextRequest, NextResponse } from "next/server";
import {
  normalizeVenueCandidates,
  type RawVenueCandidate,
} from "@/lib/import-candidates";
import { createServiceClient } from "@/lib/supabase/server";
import type { VenueImportStatus } from "@/lib/database.types";

// Context: ThaiNight Thailand nightlife hub | Current Date: May 2026 | Priority: admin-only candidate ingestion.

type ImportRequestBody = {
  candidates?: RawVenueCandidate[];
};

const VALID_STATUSES: VenueImportStatus[] = [
  "new",
  "needs_review",
  "approved",
  "rejected",
  "imported",
];

function isAuthorized(request: NextRequest): boolean {
  const secret = process.env.ADMIN_SECRET_KEY;
  if (!secret) return false;
  return request.headers.get("Authorization") === `Bearer ${secret}`;
}

function parseStatus(value: string | null): VenueImportStatus | null {
  if (!value) return null;
  return VALID_STATUSES.includes(value as VenueImportStatus)
    ? (value as VenueImportStatus)
    : null;
}

export async function GET(request: NextRequest): Promise<NextResponse> {
  if (!isAuthorized(request)) {
    return NextResponse.json({ error: "Unauthorized." }, { status: 401 });
  }

  const supabase = createServiceClient();
  if (!supabase) {
    return NextResponse.json(
      { error: "SUPABASE_SERVICE_ROLE_KEY is not configured." },
      { status: 503 }
    );
  }

  const { searchParams } = new URL(request.url);
  const city = searchParams.get("city");
  const rawStatus = searchParams.get("status");
  const status = parseStatus(rawStatus);
  const limit = Math.min(Number(searchParams.get("limit") ?? 100), 500);

  if (rawStatus && !status) {
    return NextResponse.json({ error: "Invalid status filter." }, { status: 422 });
  }
  const statusFilter = status as VenueImportStatus | null;

  let query = supabase
    .from("venue_import_candidates")
    .select("*")
    .order("created_at", { ascending: false })
    .limit(limit);

  if (city) query = query.eq("city", city);
  if (statusFilter) query = query.eq("status", statusFilter);

  const { data, error } = await query;
  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json({
    count: data?.length ?? 0,
    candidates: data ?? [],
  });
}

export async function POST(request: NextRequest): Promise<NextResponse> {
  if (!isAuthorized(request)) {
    return NextResponse.json({ error: "Unauthorized." }, { status: 401 });
  }

  const supabase = createServiceClient();
  if (!supabase) {
    return NextResponse.json(
      { error: "SUPABASE_SERVICE_ROLE_KEY is not configured." },
      { status: 503 }
    );
  }

  let body: ImportRequestBody;
  try {
    body = (await request.json()) as ImportRequestBody;
  } catch {
    return NextResponse.json({ error: "Invalid JSON body." }, { status: 400 });
  }

  if (!Array.isArray(body.candidates) || body.candidates.length === 0) {
    return NextResponse.json(
      { error: "Provide candidates as a non-empty array." },
      { status: 422 }
    );
  }

  const { candidates, errors } = normalizeVenueCandidates(body.candidates);
  if (candidates.length === 0) {
    return NextResponse.json({ error: "No valid candidates.", errors }, { status: 422 });
  }

  const { data, error } = await supabase
    .from("venue_import_candidates")
    .insert(candidates)
    .select("id, city, name, dedupe_key");

  if (error) {
    return NextResponse.json({ error: error.message, errors }, { status: 500 });
  }

  return NextResponse.json(
    {
      inserted: data?.length ?? 0,
      skipped: errors.length,
      errors,
      candidates: data ?? [],
    },
    { status: 201 }
  );
}
