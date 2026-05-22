import { NextRequest, NextResponse } from "next/server";
import { importAllowedEvents } from "@/lib/event-importer";

export const dynamic = "force-dynamic";
export const maxDuration = 60;

function unauthorized(): NextResponse {
  return NextResponse.json({ error: "Unauthorized." }, { status: 401 });
}

export async function GET(request: NextRequest): Promise<NextResponse> {
  const cronSecret = process.env.CRON_SECRET;
  const adminSecret = process.env.ADMIN_SECRET_KEY;
  const auth = request.headers.get("authorization");
  const key = request.nextUrl.searchParams.get("key");

  if (cronSecret) {
    if (auth !== `Bearer ${cronSecret}` && key !== cronSecret && key !== adminSecret) {
      return unauthorized();
    }
  } else if (process.env.NODE_ENV === "production") {
    return NextResponse.json({ error: "CRON_SECRET is not configured." }, { status: 503 });
  }

  const limit = Number(process.env.EVENT_CRON_IMPORT_LIMIT ?? 18);
  const result = await importAllowedEvents(Number.isFinite(limit) ? limit : 18);
  return NextResponse.json({
    ok: true,
    importedAt: new Date().toISOString(),
    status: "pending_review",
    result,
  });
}
