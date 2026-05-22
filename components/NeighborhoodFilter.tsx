import Link from "next/link";
import type { VenueCategory } from "@/lib/types";

type Props = {
  city: string;
  category: VenueCategory;
  areas: string[];
  activeArea?: string;
};

export function NeighborhoodFilter({
  city,
  category,
  areas,
  activeArea,
}: Props) {
  const base = `/${city}/${category}`;
  return (
    <nav aria-label="Neighborhoods" className="flex flex-wrap gap-2">
      {areas.map((area) => {
        const href = `${base}/${area}`;
        const active = area === activeArea;
        return (
          <Link
            key={area}
            href={href}
            className={`min-h-11 min-w-11 rounded-full border px-4 py-2 text-sm capitalize transition-colors ${
              active
                ? "border-rose-500 bg-rose-500 text-white"
                : "border-slate-700 bg-slate-900 text-slate-300 hover:border-rose-500/50"
            }`}
          >
            {area.replace(/-/g, " ")}
          </Link>
        );
      })}
    </nav>
  );
}
