import { BadgeCheck } from "lucide-react";
import { isVerifiedThisWeek } from "@/lib/utils";

type Props = { updatedAt: string; referenceNow?: Date };

export function VerificationBadge({ updatedAt, referenceNow }: Props) {
  const ok = isVerifiedThisWeek(updatedAt, referenceNow);
  if (!ok) return null;
  return (
    <span
      className="inline-flex min-h-11 min-w-11 items-center gap-1.5 rounded-full border border-amber-400/60 bg-amber-400/10 px-3 py-2 text-sm font-medium text-amber-400"
      data-testid="verified-badge"
    >
      <BadgeCheck className="size-4 shrink-0" aria-hidden />
      Verified This Week
    </span>
  );
}
