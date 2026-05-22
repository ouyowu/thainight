export type EventSourceMode =
  | "auto_import_allowed"
  | "manual_review_only"
  | "partner_submission"
  | "blocked";

export type EventSourcePolicy = {
  host: string;
  label: string;
  mode: EventSourceMode;
  note: string;
};

export const EVENT_SOURCE_POLICIES: EventSourcePolicy[] = [
  {
    host: "ra.co",
    label: "Resident Advisor",
    mode: "manual_review_only",
    note:
      "Use RA links as human-reviewed tips only. RA terms prohibit automated commercial extraction without written agreement.",
  },
  {
    host: "www.ra.co",
    label: "Resident Advisor",
    mode: "manual_review_only",
    note:
      "Use RA links as human-reviewed tips only. RA terms prohibit automated commercial extraction without written agreement.",
  },
  {
    host: "phangan.events",
    label: "Phangan Events",
    mode: "auto_import_allowed",
    note:
      "Public nightlife event pages can be imported conservatively when source attribution is preserved.",
  },
  {
    host: "eventpop.me",
    label: "Eventpop",
    mode: "manual_review_only",
    note:
      "Use selected event links as manual seeds unless the organizer or platform provides an official feed or written permission.",
  },
  {
    host: "www.eventpop.me",
    label: "Eventpop",
    mode: "manual_review_only",
    note:
      "Use selected event links as manual seeds unless the organizer or platform provides an official feed or written permission.",
  },
];

export function eventSourcePolicyForUrl(value: string): EventSourcePolicy | null {
  try {
    const host = new URL(value).host.toLowerCase();
    return EVENT_SOURCE_POLICIES.find((source) => source.host === host) ?? null;
  } catch {
    return null;
  }
}

export function canAutoImportEventUrl(value: string): boolean {
  const policy = eventSourcePolicyForUrl(value);
  return policy?.mode === "auto_import_allowed" || policy?.mode === "partner_submission";
}
