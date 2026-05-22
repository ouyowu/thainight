import { redirect } from "next/navigation";
import { createServerClient } from "@/lib/supabase/server";
import { VerificationClient } from "@/components/VerificationClient";

export const dynamic = "force-dynamic";

export default async function VerifyPage() {
  const supabase = createServerClient();
  if (!supabase) redirect("/");

  const { data: authData } = await supabase.auth.getUser();
  if (!authData.user) redirect("/");

  const { data: profile } = await supabase
    .from("profiles")
    .select("verification_status, ig_handle")
    .eq("id", authData.user.id)
    .maybeSingle();

  return (
    <VerificationClient
      emailVerified={Boolean(authData.user.email_confirmed_at)}
      instagramStatus={profile?.verification_status ?? "unverified"}
      instagramHandle={profile?.ig_handle ?? null}
    />
  );
}
