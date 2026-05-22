import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase/server";

export async function POST(request: NextRequest): Promise<NextResponse> {
  const supabase = createServerClient();
  if (!supabase) return NextResponse.json({ error: "Profile service unavailable." }, { status: 503 });

  const { data: authData } = await supabase.auth.getUser();
  if (!authData.user) return NextResponse.json({ error: "Sign in required." }, { status: 401 });

  const body = (await request.json().catch(() => ({}))) as Record<string, unknown>;
  const payload = {
    id: authData.user.id,
    display_name: typeof body.display_name === "string" ? body.display_name.trim() || null : null,
    bio: typeof body.bio === "string" ? body.bio.trim() || null : null,
    ig_handle: typeof body.ig_handle === "string" ? body.ig_handle.trim().replace(/^@/, "") || null : null,
    current_city: typeof body.current_city === "string" ? body.current_city.trim() || null : null,
    traveler_type: typeof body.traveler_type === "string" ? body.traveler_type.trim() || null : null,
    home_country: typeof body.home_country === "string" ? body.home_country.trim() || null : null,
    visit_window_start: typeof body.visit_window_start === "string" ? body.visit_window_start || null : null,
    visit_window_end: typeof body.visit_window_end === "string" ? body.visit_window_end || null : null,
    languages_spoken: Array.isArray(body.languages_spoken)
      ? body.languages_spoken.filter((item): item is string => typeof item === "string").slice(0, 6)
      : [],
    interests: Array.isArray(body.interests)
      ? body.interests.filter((item): item is string => typeof item === "string").slice(0, 8)
      : [],
    persona_tags: Array.isArray(body.persona_tags)
      ? body.persona_tags.filter((item): item is string => typeof item === "string").slice(0, 8)
      : [],
  };

  const { data, error } = await supabase
    .from("profiles")
    .upsert(payload, { onConflict: "id" })
    .select("*")
    .single();

  if (error) {
    return NextResponse.json({ error: "Could not save profile." }, { status: 500 });
  }

  return NextResponse.json({ profile: data });
}
