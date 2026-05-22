import { NextRequest, NextResponse } from "next/server";
import { createAnonClient, createServiceClient } from "@/lib/supabase/server";
import type { UpdateType, VenueRow } from "@/lib/database.types";
import { siteBaseUrl } from "@/lib/config";

// Context: Bangkok Nightlife SEO Hub | Current Date: May 2026 | Priority: freshness updates and Telegram growth.
// POST handler for user-submitted venue updates; validate input, insert into venue_updates, and notify Telegram.

const RATE_LIMIT_WINDOW_MS = 60 * 60 * 1000;
const RATE_LIMIT_MAX_SUBMISSIONS = 5;

const VALID_UPDATE_TYPES: UpdateType[] = [
  "score_correction",
  "hours_change",
  "closure_report",
  "temporary_closure",
  "price_change",
  "new_info",
  "raid_alert",
  "reopened",
  "photo_submission",
];

interface SubmitUpdatePayload {
  venue_slug: string;
  update_type: UpdateType;
  content_text?: string;
  submitter_name?: string;
  submitter_email?: string;
  suggested_foreigner_friendly?: number;
  suggested_late_night_reliability?: number;
  suggested_price_transparency?: number;
}

type VenueLookup = Pick<
  VenueRow,
  "id" | "name" | "slug" | "city" | "area_slug" | "is_permanently_closed"
>;

function escapeTelegramHtml(value: string): string {
  return value
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;");
}

function validatePayload(
  body: unknown
): { valid: true; data: SubmitUpdatePayload } | { valid: false; error: string } {
  if (typeof body !== "object" || body === null) {
    return { valid: false, error: "Request body must be a JSON object." };
  }

  const b = body as Record<string, unknown>;

  if (typeof b.venue_slug !== "string" || b.venue_slug.trim().length === 0) {
    return { valid: false, error: "venue_slug is required." };
  }

  if (!VALID_UPDATE_TYPES.includes(b.update_type as UpdateType)) {
    return { valid: false, error: `update_type must be one of: ${VALID_UPDATE_TYPES.join(", ")}.` };
  }

  if (b.content_text !== undefined && typeof b.content_text !== "string") {
    return { valid: false, error: "content_text must be a string." };
  }

  if (b.update_type === "raid_alert") {
    if (typeof b.content_text !== "string" || b.content_text.trim().length < 10) {
      return {
        valid: false,
        error: "raid_alert requires content_text (min 10 chars) describing the situation.",
      };
    }
  }

  for (const field of [
    "suggested_foreigner_friendly",
    "suggested_late_night_reliability",
    "suggested_price_transparency",
  ] as const) {
    if (b[field] !== undefined) {
      const val = Number(b[field]);
      if (isNaN(val) || val < 0 || val > 10) {
        return { valid: false, error: `${field} must be a number between 0 and 10.` };
      }
    }
  }

  if (b.submitter_email !== undefined) {
    if (typeof b.submitter_email !== "string" || !b.submitter_email.includes("@")) {
      return { valid: false, error: "submitter_email format is invalid." };
    }
  }

  return { valid: true, data: b as unknown as SubmitUpdatePayload };
}

const rateLimitStore = new Map<string, { count: number; windowStart: number }>();

function checkRateLimit(ip: string): { allowed: boolean; remaining: number } {
  const now = Date.now();
  const existing = rateLimitStore.get(ip);

  if (!existing || now - existing.windowStart > RATE_LIMIT_WINDOW_MS) {
    rateLimitStore.set(ip, { count: 1, windowStart: now });
    return { allowed: true, remaining: RATE_LIMIT_MAX_SUBMISSIONS - 1 };
  }

  if (existing.count >= RATE_LIMIT_MAX_SUBMISSIONS) {
    return { allowed: false, remaining: 0 };
  }

  existing.count += 1;
  return { allowed: true, remaining: RATE_LIMIT_MAX_SUBMISSIONS - existing.count };
}

async function sendTelegramMessage(chatId: string, text: string): Promise<void> {
  const token = process.env.TELEGRAM_BOT_TOKEN;
  if (!token || !chatId) return;

  try {
    await fetch(`https://api.telegram.org/bot${token}/sendMessage`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        chat_id: chatId,
        text,
        parse_mode: "HTML",
        disable_web_page_preview: true,
      }),
    });
  } catch {
    console.error("[Telegram] Failed to send notification");
  }
}

async function notifyAdminOfSubmission(
  venueSlug: string,
  updateType: UpdateType,
  contentText: string | undefined,
  updateId: string
): Promise<void> {
  const chatId = process.env.TELEGRAM_ADMIN_CHAT_ID ?? "";
  const emoji: Record<UpdateType, string> = {
    score_correction: "📊",
    hours_change: "🕐",
    closure_report: "🔒",
    temporary_closure: "⏸️",
    price_change: "💰",
    new_info: "ℹ️",
    raid_alert: "🚨",
    reopened: "🔓",
    photo_submission: "📷",
  };

  const icon = emoji[updateType] ?? "📝";
  const text = [
    `${icon} <b>New ${updateType.replace(/_/g, " ").toUpperCase()}</b>`,
    ``,
    `<b>Venue:</b> ${escapeTelegramHtml(venueSlug)}`,
    contentText ? `<b>Note:</b> ${escapeTelegramHtml(contentText)}` : null,
    ``,
    `<b>Update ID:</b> <code>${updateId}</code>`,
    `Approve via admin dashboard or SQL:`,
    `<code>UPDATE venue_updates SET status = 'approved', reviewed_by = 'admin' WHERE id = '${updateId}';</code>`,
  ]
    .filter(Boolean)
    .join("\n");

  await sendTelegramMessage(chatId, text);
}

async function publishRaidAlertToChannel(
  venueName: string,
  city: string,
  areaSlug: string,
  venueSlug: string,
  contentText: string
): Promise<void> {
  const channelId = process.env.TELEGRAM_PUBLIC_CHANNEL_ID ?? "";
  const url = `${siteBaseUrl()}/${city}/bars/${areaSlug}/${venueSlug}`;
  const text = [
    `🚨 <b>RAID ALERT — Bangkok Nightlife</b>`,
    ``,
    `<b>Venue:</b> ${escapeTelegramHtml(venueName)}`,
    `<b>Report:</b> ${escapeTelegramHtml(contentText)}`,
    ``,
    `<a href="${url}">View Venue →</a>`,
    ``,
    `<i>Community report. Verify before heading out.</i>`,
  ].join("\n");

  await sendTelegramMessage(channelId, text);
}

export async function POST(request: NextRequest): Promise<NextResponse> {
  const ip =
    request.headers.get("x-forwarded-for")?.split(",")[0]?.trim() ??
    request.headers.get("x-real-ip") ??
    "unknown";

  const rateCheck = checkRateLimit(ip);
  if (!rateCheck.allowed) {
    return NextResponse.json(
      { error: "Too many submissions. Please wait before submitting again." },
      {
        status: 429,
        headers: { "X-RateLimit-Remaining": "0" },
      }
    );
  }

  let rawBody: unknown;
  try {
    rawBody = await request.json();
  } catch {
    return NextResponse.json({ error: "Invalid JSON body." }, { status: 400 });
  }

  const validation = validatePayload(rawBody);
  if (!validation.valid) {
    return NextResponse.json({ error: validation.error }, { status: 422 });
  }

  const payload = validation.data;

  const supabase = createAnonClient();
  if (!supabase) {
    return NextResponse.json(
      {
        error:
          "Database not configured. Set NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY.",
      },
      { status: 503 }
    );
  }

  const venueLookupClient = createServiceClient() ?? supabase;
  const venueResult = await venueLookupClient
    .from("venues")
    .select("id, name, slug, city, area_slug, is_permanently_closed")
    .eq("slug", payload.venue_slug)
    .single();
  const venue = venueResult.data as VenueLookup | null;
  const venueError = venueResult.error;

  if (venueError || !venue) {
    return NextResponse.json(
      { error: `Venue '${payload.venue_slug}' not found.` },
      { status: 404 }
    );
  }

  if (venue.is_permanently_closed && payload.update_type !== "reopened") {
    return NextResponse.json(
      {
        error:
          "This venue is marked as permanently closed. Only 'reopened' updates are accepted.",
      },
      { status: 409 }
    );
  }

  const { data: update, error: insertError } = await supabase
    .from("venue_updates")
    .insert({
      venue_id: venue.id,
      venue_slug: payload.venue_slug,
      update_type: payload.update_type,
      content_text: payload.content_text?.trim() || null,
      submitter_name: payload.submitter_name?.trim() || null,
      submitter_email: payload.submitter_email?.trim().toLowerCase() || null,
      submitter_ip: ip,
      submitter_user_agent: request.headers.get("user-agent") || null,
      suggested_foreigner_friendly: payload.suggested_foreigner_friendly ?? null,
      suggested_late_night_reliability: payload.suggested_late_night_reliability ?? null,
      suggested_price_transparency: payload.suggested_price_transparency ?? null,
      status: "pending",
      ...(payload.update_type === "raid_alert" && { status: "auto_applied" }),
    })
    .select("id")
    .single();

  if (insertError || !update) {
    console.error("[SubmitUpdate] Insert failed:", insertError);
    return NextResponse.json(
      { error: "Failed to save your update. Please try again." },
      { status: 500 }
    );
  }

  const notifyTasks: Promise<void>[] = [];

  notifyTasks.push(
    notifyAdminOfSubmission(
      venue.slug,
      payload.update_type,
      payload.content_text,
      update.id
    )
  );

  if (payload.update_type === "raid_alert" && payload.content_text) {
    notifyTasks.push(
      publishRaidAlertToChannel(
        venue.name,
        venue.city,
        venue.area_slug,
        venue.slug,
        payload.content_text
      )
    );
  }

  Promise.all(notifyTasks).catch((err) =>
    console.error("[SubmitUpdate] Telegram notification failed:", err)
  );

  return NextResponse.json(
    {
      success: true,
      message:
        payload.update_type === "raid_alert"
          ? "Raid alert published to community. Stay safe out there."
          : "Update received. Our team will review it shortly. Thank you!",
      update_id: update.id,
    },
    {
      status: 201,
      headers: { "X-RateLimit-Remaining": rateCheck.remaining.toString() },
    }
  );
}

export async function PATCH(request: NextRequest): Promise<NextResponse> {
  const authHeader = request.headers.get("Authorization");
  if (authHeader !== `Bearer ${process.env.ADMIN_SECRET_KEY}`) {
    return NextResponse.json({ error: "Unauthorized." }, { status: 401 });
  }

  const { searchParams } = new URL(request.url);
  const updateId = searchParams.get("id");
  const action = searchParams.get("action");

  if (!updateId || !["approve", "reject"].includes(action ?? "")) {
    return NextResponse.json(
      { error: "Provide ?id={uuid}&action=approve|reject" },
      { status: 400 }
    );
  }

  const supabase = createServiceClient();
  if (!supabase) {
    return NextResponse.json(
      { error: "SUPABASE_SERVICE_ROLE_KEY not configured." },
      { status: 500 }
    );
  }

  const { error } = await supabase
    .from("venue_updates")
    .update({
      status: action === "approve" ? "approved" : "rejected",
      reviewed_by: "admin",
      reviewed_at: new Date().toISOString(),
    })
    .eq("id", updateId);

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json({
    success: true,
    message: `Update ${updateId} ${action === "approve" ? "approved" : "rejected"}. DB trigger ran automatically.`,
  });
}
