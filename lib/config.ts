/** Anchor for “Verified This Week” (May 2026 brief). Override in production via env. */
export function verificationReferenceDate(): Date {
  const raw = process.env.NEXT_PUBLIC_VERIFICATION_REFERENCE;
  if (raw) return new Date(raw);
  return new Date("2026-05-12T12:00:00.000Z");
}

export function siteBaseUrl(): string {
  const app = process.env.NEXT_PUBLIC_APP_URL?.replace(/\/$/, "");
  if (app) return app;
  const explicit = process.env.NEXT_PUBLIC_SITE_URL?.replace(/\/$/, "");
  if (explicit) return explicit;
  if (process.env.VERCEL_ENV === "production") return "https://thainight.co";
  if (process.env.VERCEL_URL) return `https://${process.env.VERCEL_URL}`;
  if (process.env.NODE_ENV === "production") return "https://thainight.co";
  return "http://localhost:3000";
}
