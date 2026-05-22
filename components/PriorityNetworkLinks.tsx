import Link from "next/link";
import { ArrowRight, Compass, MapPin } from "lucide-react";
import { CITY_CONFIGS, type CitySlug } from "@/lib/cities";

type LinkItem = {
  href: string;
  label: string;
  description?: string;
};

type Props = {
  title: string;
  description: string;
  currentCity?: CitySlug;
  cityLinks?: LinkItem[];
  hubLinks?: LinkItem[];
};

const DEFAULT_HUB_LINKS: LinkItem[] = [
  {
    href: "/tonight",
    label: "Tonight",
    description: "Quick plans, warnings, price tips, and people going out now.",
  },
  {
    href: "/events",
    label: "Events",
    description: "Approved nightlife flyers, parties, and guest-list signals.",
  },
  {
    href: "/offers",
    label: "Offers",
    description: "Happy hours, free-entry windows, guest lists, and venue deals.",
  },
  {
    href: "/intel",
    label: "Intel",
    description: "Reviewed openings, warnings, price tips, and nightlife news.",
  },
  {
    href: "/news",
    label: "News",
    description: "Fresh nightlife updates for travelers planning this week.",
  },
];

function buildDefaultCityLinks(currentCity?: CitySlug): LinkItem[] {
  return CITY_CONFIGS.filter((city) => city.slug !== currentCity).map((city) => ({
    href: city.href,
    label: city.name,
    description: city.region,
  }));
}

export function PriorityNetworkLinks({
  title,
  description,
  currentCity,
  cityLinks,
  hubLinks = DEFAULT_HUB_LINKS,
}: Props) {
  const resolvedCityLinks = cityLinks ?? buildDefaultCityLinks(currentCity);

  return (
    <section className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
      <div className="max-w-3xl">
        <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-amber-300">
          <Compass className="h-4 w-4" />
          Priority entry network
        </p>
        <h2 className="mt-3 text-3xl font-black tracking-tight text-white">{title}</h2>
        <p className="mt-3 text-sm leading-7 text-zinc-400">{description}</p>
      </div>

      <div className="mt-6 grid gap-4 lg:grid-cols-[0.95fr_1.05fr]">
        <div className="rounded-3xl border border-zinc-800 bg-zinc-900/45 p-4">
          <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-zinc-300">
            <MapPin className="h-4 w-4 text-cyan-200" />
            Core cities
          </p>
          <div className="mt-4 grid gap-3 sm:grid-cols-2">
            {resolvedCityLinks.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                className="rounded-2xl border border-zinc-800 bg-black/20 p-4 transition hover:border-cyan-300/35 hover:bg-black/35"
              >
                <div className="flex items-start justify-between gap-3">
                  <div>
                    <p className="text-base font-black text-white">{link.label}</p>
                    {link.description ? (
                      <p className="mt-1 text-xs leading-5 text-zinc-500">{link.description}</p>
                    ) : null}
                  </div>
                  <ArrowRight className="h-4 w-4 text-zinc-500" />
                </div>
              </Link>
            ))}
          </div>
        </div>

        <div className="rounded-3xl border border-zinc-800 bg-zinc-900/45 p-4">
          <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-zinc-300">
            <ArrowRight className="h-4 w-4 text-rose-200" />
            High-intent sections
          </p>
          <div className="mt-4 grid gap-3 sm:grid-cols-2">
            {hubLinks.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                className="rounded-2xl border border-zinc-800 bg-black/20 p-4 transition hover:border-rose-300/35 hover:bg-black/35"
              >
                <p className="text-base font-black text-white">{link.label}</p>
                {link.description ? (
                  <p className="mt-2 text-xs leading-5 text-zinc-500">{link.description}</p>
                ) : null}
              </Link>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}
