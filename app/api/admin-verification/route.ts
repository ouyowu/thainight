import { NextRequest, NextResponse } from "next/server";
import { createServiceClient } from "@/lib/supabase/server";

export async function PATCH(request: NextRequest): Promise<NextResponse> {
  const adminKey = process.env.ADMIN_SECRET_KEY;
  if (!adminKey || request.headers.get("authorization") !== `Bearer ${adminKey}`) {
    return NextResponse.json({ error: "Unauthorized." }, { status: 401 });
  }

  const id = request.nextUrl.searchParams.get("id");
  const action = request.nextUrl.searchParams.get("action");
  if (!id || !["approve", "reject"].includes(action ?? "")) {
    return NextResponse.json({ error: "Invalid verification action." }, { status: 422 });
  }

  const supabase = createServiceClient();
  if (!supabase) return NextResponse.json({ error: "Database unavailable." }, { status: 503 });

  const { data: requestRow, error: lookupError } = await supabase
    .from("profile_verification_requests")
    .select("id, user_id, submitted_handle")
    .eq("id", id)
    .single();

  if (lookupError || !requestRow) {
    return NextResponse.json({ error: "Verification request not found." }, { status: 404 });
  }

  const approved = action === "approve";
  const [{ error: requestError }, { error: profileError }] = await Promise.all([
    supabase
      .from("profile_verification_requests")
      .update({
        status: approved ? "approved" : "rejected",
        reviewed_at: new Date().toISOString(),
      })
      .eq("id", id),
    approved
      ? supabase
          .from("profiles")
          .update({
            verification_status: "instagram_verified",
            ig_handle: requestRow.submitted_handle,
          })
          .eq("id", requestRow.user_id)
      : Promise.resolve({ error: null }),
  ]);

  if (requestError || profileError) {
    return NextResponse.json({ error: "Could not update verification request." }, { status: 500 });
  }

  return NextResponse.json({ ok: true });
}
