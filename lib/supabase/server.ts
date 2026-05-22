import {
  createClient as createSbClient,
  type SupabaseClient,
} from "@supabase/supabase-js";
import { createServerClient as createSsrServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import type { Database } from "../database.types";

function requireEnv(name: string): string | undefined {
  const v = process.env[name];
  return v && v.length > 0 ? v : undefined;
}

export function getSupabasePublicConfig():
  | { url: string; anonKey: string }
  | null {
  const url = requireEnv("NEXT_PUBLIC_SUPABASE_URL");
  const anonKey = requireEnv("NEXT_PUBLIC_SUPABASE_ANON_KEY");
  if (!url || !anonKey) return null;
  return { url, anonKey };
}

/** Anon key client for Server Components / Route Handlers (respects RLS). */
export function createAnonClient(): SupabaseClient<Database> | null {
  const config = getSupabasePublicConfig();
  if (!config) return null;
  return createSbClient<Database>(config.url, config.anonKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
}

/** Cookie-aware Supabase client for Server Components, Server Actions, and Route Handlers. */
export function createServerClient(): SupabaseClient<Database> | null {
  const config = getSupabasePublicConfig();
  if (!config) return null;

  const cookieStore = cookies();

  return createSsrServerClient<Database>(config.url, config.anonKey, {
    cookies: {
      getAll() {
        return cookieStore.getAll();
      },
      setAll(cookiesToSet) {
        try {
          cookiesToSet.forEach(({ name, value, options }) => {
            cookieStore.set(name, value, options);
          });
        } catch {
          // Server Components cannot always write cookies; middleware refreshes them.
        }
      },
    },
  });
}

/** Service role — bypasses RLS. Use only in trusted server code (e.g. PATCH admin). */
export function createServiceClient(): SupabaseClient<Database> | null {
  const url = requireEnv("NEXT_PUBLIC_SUPABASE_URL");
  const key = requireEnv("SUPABASE_SERVICE_ROLE_KEY");
  if (!url || !key) return null;
  return createSbClient<Database>(url, key, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
}

/** @deprecated Prefer createServerClient or createAnonClient based on auth needs. */
export function createClient(): SupabaseClient<Database> {
  const c = createServerClient() ?? createAnonClient();
  if (!c) {
    throw new Error(
      "Missing NEXT_PUBLIC_SUPABASE_URL or NEXT_PUBLIC_SUPABASE_ANON_KEY"
    );
  }
  return c;
}
