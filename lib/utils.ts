import type { VenueScores } from "./types";

/** (ForeignerFriendly * 0.3) + (Reliability * 0.4) + (PriceTransparency * 0.3) */
export function overallScore(s: VenueScores): number {
  return (
    s.foreignerFriendly * 0.3 +
    s.reliability * 0.4 +
    s.priceTransparency * 0.3
  );
}

/** Monday 00:00 UTC → Sunday 23:59:59.999 UTC for the week containing `d`. */
export function startOfWeekMondayUTC(d: Date): Date {
  const x = new Date(d);
  const dow = x.getUTCDay();
  const delta = dow === 0 ? -6 : 1 - dow;
  x.setUTCDate(x.getUTCDate() + delta);
  x.setUTCHours(0, 0, 0, 0);
  return x;
}

export function endOfWeekSundayUTC(d: Date): Date {
  const s = startOfWeekMondayUTC(d);
  const e = new Date(s);
  e.setUTCDate(e.getUTCDate() + 7);
  e.setUTCMilliseconds(-1);
  return e;
}

/**
 * "Verified This Week" if `updated_at` falls in the ISO-style calendar week
 * (Mon–Sun, UTC) that contains `referenceNow` (default: May 2026 demo anchor).
 */
export function isVerifiedThisWeek(
  updatedAt: string | Date,
  referenceNow: Date = new Date("2026-05-12T12:00:00.000Z")
): boolean {
  const u = typeof updatedAt === "string" ? new Date(updatedAt) : updatedAt;
  const start = startOfWeekMondayUTC(referenceNow);
  const end = endOfWeekSundayUTC(referenceNow);
  return u >= start && u <= end;
}
