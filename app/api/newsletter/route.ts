import { NextRequest, NextResponse } from "next/server";
import { createAnonClient } from "@/lib/supabase/server";

// Context: Bangkok Nightlife SEO Hub | Current Date: May 2026 | Priority: email capture for community growth.
// POST handler for newsletter signup; validates email and stores it for Resend/Mailchimp export.

type NewsletterPayload = {
  email?: unknown;
};

function normalizeEmail(email: unknown): string | null {
  if (typeof email !== "string") return null;
  const normalized = email.trim().toLowerCase();
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(normalized)) return null;
  return normalized;
}

export async function POST(request: NextRequest): Promise<NextResponse> {
  let payload: NewsletterPayload;

  try {
    payload = (await request.json()) as NewsletterPayload;
  } catch {
    return NextResponse.json({ error: "Invalid JSON body." }, { status: 400 });
  }

  const email = normalizeEmail(payload.email);
  if (!email) {
    return NextResponse.json(
      { error: "Enter a valid email address." },
      { status: 422 }
    );
  }

  const supabase = createAnonClient();
  if (!supabase) {
    return NextResponse.json(
      { error: "Newsletter storage is not configured yet." },
      { status: 503 }
    );
  }

  const { error } = await supabase
    .from("newsletter_subscribers")
    .insert({
      email,
      source: "homepage_join_card",
      subscribed_at: new Date().toISOString(),
    });

  if (error?.code === "23505") {
    return NextResponse.json({
      success: true,
      message: "You're already on the Bangkok nightlife list.",
    });
  }

  if (error) {
    return NextResponse.json(
      { error: "Could not subscribe this email right now." },
      { status: 500 }
    );
  }

  return NextResponse.json({
    success: true,
    message: "You're on the Bangkok nightlife list.",
  });
}
