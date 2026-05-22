import { NextRequest, NextResponse } from "next/server";
import { createServiceClient } from "@/lib/supabase/server";

type SignalCategory = "new_opening" | "safety" | "price" | "hide";

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
  const category = request.nextUrl.searchParams.get("category") as SignalCategory | null;
  const body = (await request.json().catch(() => ({}))) as { title?: unknown };
  const title = typeof body.title === "string" ? body.title.trim() : "";

  if (!id || !category || !["new_opening", "safety", "price", "hide"].includes(category)) {
    return NextResponse.json({ error: "Missing or invalid signal category." }, { status: 400 });
  }

  const supabase = createServiceClient();
  if (!supabase) {
    return NextResponse.json({ error: "Database unavailable." }, { status: 503 });
  }

  const { error } = await supabase
    .from("intelligence_feed")
    .update({
      venue_type: category === "hide" ? null : category,
      is_displayed: category !== "hide",
      ...(title && category !== "hide" ? { title } : {}),
    })
    .eq("id", id);

  if (error) {
    return NextResponse.json({ error: "Unable to update signal." }, { status: 500 });
  }

  return NextResponse.json({ ok: true });
}
