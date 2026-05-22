import { redirect } from "next/navigation";
import { createServerClient } from "@/lib/supabase/server";
import { ProfileEditor } from "@/components/ProfileEditor";
import type { ProfileRow } from "@/lib/database.types";

export const dynamic = "force-dynamic";

export default async function ProfilePage() {
  const supabase = createServerClient();
  if (!supabase) redirect("/");

  const { data: authData } = await supabase.auth.getUser();
  if (!authData.user) redirect("/");

  const { data } = await supabase.from("profiles").select("*").eq("id", authData.user.id).maybeSingle();

  return (
    <main className="mx-auto min-h-screen max-w-6xl px-4 py-8 sm:px-6">
      <ProfileEditor initialProfile={(data as ProfileRow | null) ?? null} />
    </main>
  );
}
