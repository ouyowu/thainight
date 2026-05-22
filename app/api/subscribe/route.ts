// app/api/subscribe/route.ts
import { NextRequest, NextResponse } from "next/server";
import { createAnonClient } from "@/lib/supabase/server";

const rateStore = new Map<string, { count: number; windowStart: number }>();

function checkRate(ip: string): boolean {
  const now = Date.now();
  const entry = rateStore.get(ip);
  if (!entry || now - entry.windowStart > 3_600_000) {
    rateStore.set(ip, { count: 1, windowStart: now });
    return true;
  }
  if (entry.count >= 5) return false;
  entry.count++;
  return true;
}

export async function POST(req: NextRequest): Promise<NextResponse> {
  const ip = req.headers.get("x-forwarded-for")?.split(",")[0]?.trim() ?? "unknown";
  if (!checkRate(ip)) {
    return NextResponse.json({ error: "Too many requests." }, { status: 429 });
  }

  let body: { email?: string; city?: string };
  try { body = await req.json(); }
  catch { return NextResponse.json({ error: "Invalid JSON." }, { status: 400 }); }

  const email = body.email?.trim().toLowerCase();
  if (!email || !email.includes("@")) {
    return NextResponse.json({ error: "Valid email required." }, { status: 422 });
  }

  try {
    const supabase = createAnonClient();
    if (!supabase) {
      return NextResponse.json({ success: true }, { status: 201 });
    }

    const { error } = await supabase
      .from("newsletter_subscribers")
      .insert({
        email,
        source: body.city ? `${body.city}_hero` : "city_hero",
        subscribed_at: new Date().toISOString(),
      });

    if (error && error.code !== "23505") {
      // Table might not exist yet — still return success to not block UX
      console.error("[subscribe] DB error:", error.message);
    }
  } catch (err) {
    console.error("[subscribe] unexpected error:", err);
  }

  // Always return success — even if DB fails, don't block the user
  return NextResponse.json({ success: true }, { status: 201 });
}
