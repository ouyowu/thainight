import { NextRequest, NextResponse } from "next/server";
import { getThaiNightSignals } from "@/lib/thainight-signals";
import type { CitySlug } from "@/lib/cities";

export const dynamic = "force-dynamic";

const CITY_SLUGS = new Set(["bangkok", "pattaya", "phuket", "chiang-mai"]);

export async function GET(request: NextRequest): Promise<NextResponse> {
  const search = request.nextUrl.searchParams;
  const city = search.get("city") ?? search.get("location");
  const limit = Number(search.get("limit") ?? 20);
  const minValue = Number(search.get("min_value") ?? 0.5);

  const citySlug = city?.toLowerCase().replace(/\s+/g, "-");
  const items = await getThaiNightSignals({
    city: citySlug && CITY_SLUGS.has(citySlug) ? (citySlug as CitySlug) : undefined,
    limit: Number.isFinite(limit) ? limit : 20,
    minValue: Number.isFinite(minValue) ? minValue : 0.5,
  });

  return NextResponse.json({
    source: "ThaiNight",
    items,
  });
}
