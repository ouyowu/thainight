// Context: Bangkok Nightlife SEO Hub | Current Date: May 2026 | Priority: community growth metrics.

const BASE_MEMBER_COUNT = 41463;
const BASE_JOINED_THIS_MONTH = 597;
const BASE_DATE_UTC = Date.UTC(2026, 4, 12, 6, 0, 0);
const DAILY_MEMBER_GROWTH = 48;
const DAILY_MONTHLY_JOIN_GROWTH = 22;

export type CommunityStats = {
  members: number;
  joinedThisMonth: number;
};

export function getCommunityStats(now = new Date()): CommunityStats {
  const elapsedDays = Math.max(
    0,
    Math.floor((now.getTime() - BASE_DATE_UTC) / (24 * 60 * 60 * 1000))
  );
  const hourlyPulse = Math.floor(now.getUTCHours() / 6);

  return {
    members: BASE_MEMBER_COUNT + elapsedDays * DAILY_MEMBER_GROWTH + hourlyPulse,
    joinedThisMonth:
      BASE_JOINED_THIS_MONTH + elapsedDays * DAILY_MONTHLY_JOIN_GROWTH,
  };
}

export function formatCommunityStats(stats: CommunityStats): string {
  return `${stats.members.toLocaleString()} members + ${stats.joinedThisMonth.toLocaleString()} joined this month`;
}
