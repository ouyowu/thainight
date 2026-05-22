import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase/server";

export async function POST(request: NextRequest): Promise<NextResponse> {
  const supabase = createServerClient();
  if (!supabase) return NextResponse.json({ error: "Verification service unavailable." }, { status: 503 });

  const { data: authData } = await supabase.auth.getUser();
  if (!authData.user) return NextResponse.json({ error: "Sign in required." }, { status: 401 });

  const body = (await request.json().catch(() => ({}))) as Record<string, unknown>;
  const handle = typeof body.instagram_handle === "string" ? body.instagram_handle.trim().replace(/^@/, "") : "";
  const proofUrl = typeof body.proof_url === "string" ? body.proof_url.trim() || null : null;
  const note = typeof body.note === "string" ? body.note.trim() || null : null;

  if (!handle) {
    return NextResponse.json({ error: "Instagram handle is required." }, { status: 422 });
  }

  const { error } = await supabase.from("profile_verification_requests").insert({
    user_id: authData.user.id,
    request_type: "instagram",
    submitted_handle: handle,
    proof_url: proofUrl,
    note,
  });

  if (error) {
    return NextResponse.json({ error: "Could not submit verification request." }, { status: 500 });
  }

  return NextResponse.json({ ok: true });
}
