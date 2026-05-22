// app/admin/page.tsx
// Admin dashboard — approve/reject venue_updates queue
// Protected by ADMIN_SECRET_KEY check (simple, no auth needed for MVP)
// Access: /admin?key=YOUR_ADMIN_SECRET_KEY

import { createServiceClient } from "@/lib/supabase/server";
import AdminClient from "@/components/AdminClient";
import { getThaiNightSignals } from "@/lib/thainight-signals";
import { redirect } from "next/navigation";

export const dynamic = "force-dynamic";

interface PageProps {
  searchParams: { key?: string };
}

async function getQueueData() {
  const supabase = createServiceClient();
  if (!supabase) {
    return {
      updates: [],
      stats: { pending: 0, approved: 0, rejected: 0 },
      intelligence: [],
      flyers: [],
      offers: [],
      topSignals: [],
      verifications: [],
    };
  }

  const [updatesRes, statsRes, intelRes, flyersRes, offersRes, topSignals, verificationRes] = await Promise.all([
    supabase
      .from("venue_updates")
      .select(`
        id, venue_slug, update_type, content_text,
        suggested_foreigner_friendly, suggested_late_night_reliability,
        suggested_price_transparency, status, created_at,
        submitter_name, submitter_email, content_json
      `)
      .eq("status", "pending")
      .order("created_at", { ascending: false })
      .limit(50),

    supabase
      .from("venue_updates")
      .select("status")
      .then(({ data }) => ({
        pending:  data?.filter(r => r.status === "pending").length  ?? 0,
        approved: data?.filter(r => r.status === "approved").length ?? 0,
        rejected: data?.filter(r => r.status === "rejected").length ?? 0,
      })),

    supabase
      .from("intelligence_feed")
      .select("id, title, city, subreddit, thainight_value, is_raid_alert, is_displayed, venue_type, received_at, url, matched_venue_slug")
      .order("received_at", { ascending: false })
      .limit(80),

    supabase
      .from("event_flyers")
      .select("id, city, title, description, flyer_image_url, source_url, source_type, status, created_at, updated_at")
      .eq("status", "pending")
      .order("updated_at", { ascending: false, nullsFirst: false })
      .order("created_at", { ascending: false })
      .limit(20),

    supabase
      .from("venue_offers")
      .select("id, city, title, description, offer_label, image_url, source_url, source_type, status, created_at, updated_at")
      .eq("status", "pending")
      .order("updated_at", { ascending: false, nullsFirst: false })
      .order("created_at", { ascending: false })
      .limit(20),

    getThaiNightSignals({ limit: 80, minValue: 0.5 }),

    supabase
      .from("profile_verification_requests")
      .select("id, user_id, submitted_handle, proof_url, note, status, created_at")
      .eq("status", "pending")
      .order("created_at", { ascending: false })
      .limit(20),
  ]);

  return {
    updates:      updatesRes.data ?? [],
    stats:        statsRes,
    intelligence: intelRes.data ?? [],
    flyers:       flyersRes.data ?? [],
    offers:       offersRes.data ?? [],
    topSignals,
    verifications: verificationRes.data ?? [],
  };
}

export default async function AdminPage({ searchParams }: PageProps) {
  // Simple key-based protection — MVP only
  const adminKey = process.env.ADMIN_SECRET_KEY;
  if (!adminKey || searchParams.key !== adminKey) {
    redirect("/");
  }

  const { updates, stats, intelligence, flyers, offers, topSignals, verifications } = await getQueueData();

  return (
    <AdminClient
      updates={updates}
      stats={stats}
      intelligence={intelligence}
      flyers={flyers}
      offers={offers}
      topSignals={topSignals}
      verifications={verifications}
      adminKey={searchParams.key!}
    />
  );
}
