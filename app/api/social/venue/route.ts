import { NextRequest, NextResponse } from "next/server";
import { createAnonClient, createServerClient } from "@/lib/supabase/server";

// Context: ThaiNight venue social MVP | Current Date: May 2026 | Count me in + 24h meetup board.

type CreateMeetupPayload = {
  venue_id?: unknown;
  meetup_id?: unknown;
  request_id?: unknown;
  title?: unknown;
  note?: unknown;
  message?: unknown;
  meetup_time?: unknown;
  seats_total?: unknown;
  budget_label?: unknown;
  audience_note?: unknown;
};

const FREE_DAILY_LIMIT = Number(process.env.SOCIAL_FREE_DAILY_LIMIT ?? 25);
const BUDGETS = ["฿", "฿฿", "฿฿฿", "฿฿฿฿"] as const;
const VERIFIED_STATUSES = new Set(["instagram_verified", "manual_verified"]);

async function membershipTier(userId: string): Promise<"free" | "vip"> {
  const supabase = createServerClient();
  if (!supabase) return "free";
  const { data } = await supabase
    .from("profiles")
    .select("membership_tier")
    .eq("id", userId)
    .maybeSingle();
  return data?.membership_tier === "vip" ? "vip" : "free";
}

async function socialEligibility(userId: string): Promise<{
  tier: "free" | "vip";
  verificationStatus: string;
  canUseVerifiedSocial: boolean;
}> {
  const supabase = createServerClient();
  if (!supabase) {
    return { tier: "free", verificationStatus: "unverified", canUseVerifiedSocial: false };
  }

  const { data } = await supabase
    .from("profiles")
    .select("membership_tier, verification_status")
    .eq("id", userId)
    .maybeSingle();

  const tier = data?.membership_tier === "vip" ? "vip" : "free";
  const verificationStatus = data?.verification_status ?? "unverified";
  return {
    tier,
    verificationStatus,
    canUseVerifiedSocial: tier === "vip" || VERIFIED_STATUSES.has(verificationStatus),
  };
}

async function dailyActionAllowed(userId: string): Promise<boolean> {
  const supabase = createServerClient();
  if (!supabase) return false;
  const today = new Date().toISOString().slice(0, 10);
  const { count } = await supabase
    .from("social_daily_actions")
    .select("id", { count: "exact", head: true })
    .eq("user_id", userId)
    .eq("action_date", today);
  return (count ?? 0) < FREE_DAILY_LIMIT;
}

async function logAction(userId: string, actionType: "count_me_in" | "create_meetup" | "request_join" | "approve_join"): Promise<void> {
  const supabase = createServerClient();
  if (!supabase) return;
  await supabase.from("social_daily_actions").insert({
    user_id: userId,
    action_type: actionType,
  });
}

export async function GET(request: NextRequest): Promise<NextResponse> {
  const venueId = new URL(request.url).searchParams.get("venueId")?.trim();
  if (!venueId) return NextResponse.json({ error: "venueId is required." }, { status: 422 });

  const supabase = createAnonClient();
  if (!supabase) return NextResponse.json({ tonight_count: 0, avatars: [], meetups: [] });
  const authClient = createServerClient();
  const { data: authData } = authClient
    ? await authClient.auth.getUser()
    : { data: { user: null } };
  const viewerTier = authData.user ? await membershipTier(authData.user.id) : "free";
  const passUnlocked = viewerTier === "vip";

  const today = new Date().toISOString().slice(0, 10);
  const [{ data: interests }, { data: meetups }] = await Promise.all([
    supabase
      .from("venue_social_interests")
      .select("user_id, created_at")
      .eq("venue_id", venueId)
      .eq("interest_date", today)
      .order("created_at", { ascending: false })
      .limit(12),
    supabase
      .from("venue_flash_meetups")
      .select("id, creator_id, title, note, meetup_time, seats_total, seats_open, budget_label, audience_note, expires_at, is_featured, created_at")
      .eq("venue_id", venueId)
      .eq("status", "open")
      .gt("expires_at", new Date().toISOString())
      .order("is_featured", { ascending: false })
      .order("created_at", { ascending: false })
      .limit(6),
  ]);

  const userIds = (interests ?? []).map((interest) => interest.user_id);
  const { data: profiles } = userIds.length
    ? await supabase
        .from("profiles")
        .select("id, display_name, current_city, traveler_type, interests, avatar_seed, home_country, languages_spoken, visit_window_start, visit_window_end, verification_status, persona_tags")
        .in("id", userIds)
    : { data: [] as Array<Record<string, unknown>> };
  const profileMap = new Map((profiles ?? []).map((profile) => [profile.id, profile]));
  const meetupIds = (meetups ?? []).map((meetup) => meetup.id);
  const { data: joinRequests } = authData.user && meetupIds.length
    ? await authClient!
        .from("venue_meetup_join_requests")
        .select("id, meetup_id, requester_id, message, status, created_at")
        .in("meetup_id", meetupIds)
        .order("created_at", { ascending: false })
    : { data: [] };
  const requestMap = new Map<string, typeof joinRequests>();
  for (const request of joinRequests ?? []) {
    requestMap.set(request.meetup_id, [...(requestMap.get(request.meetup_id) ?? []), request]);
  }

  return NextResponse.json({
    tonight_count: interests?.length ?? 0,
    viewer: {
      signed_in: Boolean(authData.user),
      tier: viewerTier,
      pass_unlocked: passUnlocked,
    },
    avatars: (interests ?? []).map((interest, index) => {
      const profile = profileMap.get(interest.user_id) as {
        display_name?: string | null;
        current_city?: string | null;
        traveler_type?: string | null;
        interests?: string[];
        avatar_seed?: string | null;
        home_country?: string | null;
        languages_spoken?: string[];
        visit_window_start?: string | null;
        visit_window_end?: string | null;
        verification_status?: "unverified" | "email_verified" | "instagram_verified" | "manual_verified";
        persona_tags?: string[];
      } | undefined;
      const today = new Date().toISOString().slice(0, 10);
      const overlapping =
        (!profile?.visit_window_start || profile.visit_window_start <= today) &&
        (!profile?.visit_window_end || profile.visit_window_end >= today);
      return {
        id: `${interest.user_id}-${index}`,
        initials: (profile?.display_name ?? "TN").slice(0, 2).toUpperCase(),
        city: profile?.current_city ?? "Thailand",
        vibe: profile?.traveler_type ?? profile?.interests?.[0] ?? "Night Explorer",
        seed: profile?.avatar_seed ?? interest.user_id.slice(0, 8),
        home_country: passUnlocked ? profile?.home_country ?? null : null,
        languages: passUnlocked ? profile?.languages_spoken ?? [] : [],
        verification_status: profile?.verification_status ?? "unverified",
        persona_tags: passUnlocked ? profile?.persona_tags ?? [] : [],
        overlapping_tonight: passUnlocked ? overlapping : undefined,
      };
    }),
    meetups: (meetups ?? []).map((meetup) => ({
      ...meetup,
      viewer_is_creator: authData.user?.id === meetup.creator_id,
      join_requests: requestMap.get(meetup.id) ?? [],
    })),
  });
}

export async function POST(request: NextRequest): Promise<NextResponse> {
  const supabase = createServerClient();
  if (!supabase) return NextResponse.json({ error: "Social features are not configured." }, { status: 503 });
  const { data: authData } = await supabase.auth.getUser();
  if (!authData.user) return NextResponse.json({ error: "Sign in required." }, { status: 401 });

  const body = await request.json().catch(() => ({})) as Record<string, unknown>;
  const action = body.action;
  const venueId = typeof body.venue_id === "string" ? body.venue_id.trim() : "";
  if (!venueId) return NextResponse.json({ error: "venue_id is required." }, { status: 422 });

  const eligibility = await socialEligibility(authData.user.id);
  if (eligibility.tier !== "vip" && !(await dailyActionAllowed(authData.user.id))) {
    return NextResponse.json({ error: "Daily free social action used.", paywall: true }, { status: 402 });
  }

  if (action === "count_me_in") {
    const today = new Date().toISOString().slice(0, 10);
    const { error } = await supabase
      .from("venue_social_interests")
      .upsert({
        venue_id: venueId,
        user_id: authData.user.id,
        interest_date: today,
      }, { onConflict: "venue_id,user_id,interest_date" });
    if (error) return NextResponse.json({ error: "Could not save tonight interest." }, { status: 500 });
    if (eligibility.tier !== "vip") await logAction(authData.user.id, "count_me_in");
    return NextResponse.json({ success: true });
  }

  if (action === "create_meetup") {
    if (!eligibility.canUseVerifiedSocial) {
      return NextResponse.json(
        { error: "Instagram verification is required to create a meetup.", verification_required: true },
        { status: 403 }
      );
    }

    const payload = body as CreateMeetupPayload & { action?: unknown };
    const title = typeof payload.title === "string" ? payload.title.trim() : "";
    const note = typeof payload.note === "string" ? payload.note.trim() : "";
    const meetupTime = typeof payload.meetup_time === "string" ? payload.meetup_time : "";
    const seatsTotal = Number(payload.seats_total ?? 0);
    const budget = typeof payload.budget_label === "string" ? payload.budget_label : "";
    const audienceNote = typeof payload.audience_note === "string" ? payload.audience_note.trim().slice(0, 120) : null;
    if (title.length < 8 || note.length < 12 || !meetupTime || !BUDGETS.includes(budget as typeof BUDGETS[number]) || !Number.isInteger(seatsTotal) || seatsTotal < 2 || seatsTotal > 12) {
      return NextResponse.json({ error: "Meetup details are incomplete." }, { status: 422 });
    }

    const { data, error } = await supabase
      .from("venue_flash_meetups")
      .insert({
        venue_id: venueId,
        creator_id: authData.user.id,
        title,
        note,
        meetup_time: meetupTime,
        seats_total: seatsTotal,
        seats_open: Math.max(1, seatsTotal - 1),
        budget_label: budget as typeof BUDGETS[number],
        audience_note: audienceNote,
      })
      .select("id, title, note, meetup_time, seats_total, seats_open, budget_label, audience_note, expires_at, is_featured, created_at")
      .single();
    if (error) return NextResponse.json({ error: "Could not create meetup." }, { status: 500 });
    if (eligibility.tier !== "vip") await logAction(authData.user.id, "create_meetup");
    return NextResponse.json({ meetup: data }, { status: 201 });
  }

  if (action === "request_join") {
    if (!eligibility.canUseVerifiedSocial) {
      return NextResponse.json(
        { error: "Instagram verification is required to request a seat.", verification_required: true },
        { status: 403 }
      );
    }

    const meetupId = typeof body.meetup_id === "string" ? body.meetup_id.trim() : "";
    const message = typeof body.message === "string" ? body.message.trim().slice(0, 240) : "";
    if (!meetupId || message.length < 8) {
      return NextResponse.json({ error: "Join request message is too short." }, { status: 422 });
    }

    const { error } = await supabase
      .from("venue_meetup_join_requests")
      .upsert({
        meetup_id: meetupId,
        venue_id: venueId,
        requester_id: authData.user.id,
        message,
        status: "pending",
      }, { onConflict: "meetup_id,requester_id" });

    if (error) return NextResponse.json({ error: "Could not submit join request." }, { status: 500 });
    if (eligibility.tier !== "vip") await logAction(authData.user.id, "request_join");
    return NextResponse.json({ success: true, status: "pending" }, { status: 201 });
  }

  if (action === "approve_join") {
    const requestId = typeof body.request_id === "string" ? body.request_id.trim() : "";
    if (!requestId) return NextResponse.json({ error: "request_id is required." }, { status: 422 });

    const { data: requestRow, error: requestError } = await supabase
      .from("venue_meetup_join_requests")
      .select("id, meetup_id, status")
      .eq("id", requestId)
      .eq("venue_id", venueId)
      .maybeSingle();
    if (requestError || !requestRow) {
      return NextResponse.json({ error: "Join request not found." }, { status: 404 });
    }

    const { data: meetup } = await supabase
      .from("venue_flash_meetups")
      .select("id, creator_id, seats_open")
      .eq("id", requestRow.meetup_id)
      .maybeSingle();
    if (!meetup || meetup.creator_id !== authData.user.id) {
      return NextResponse.json({ error: "Only the meetup creator can approve requests." }, { status: 403 });
    }
    if (meetup.seats_open <= 0) {
      return NextResponse.json({ error: "No open seats remain." }, { status: 409 });
    }

    const { error: updateError } = await supabase
      .from("venue_meetup_join_requests")
      .update({ status: "approved", reviewed_at: new Date().toISOString() })
      .eq("id", requestId);
    if (updateError) return NextResponse.json({ error: "Could not approve request." }, { status: 500 });

    await supabase
      .from("venue_flash_meetups")
      .update({ seats_open: Math.max(0, meetup.seats_open - 1) })
      .eq("id", meetup.id);

    await logAction(authData.user.id, "approve_join");
    return NextResponse.json({ success: true });
  }

  return NextResponse.json({ error: "Unsupported social action." }, { status: 422 });
}
