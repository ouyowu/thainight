import { Suspense } from "react";
import type { VenueScores } from "@/lib/types";
import { overallScore } from "@/lib/utils";

function RadarSkeleton() {
  return (
    <div
      className="flex aspect-square w-full max-w-xs animate-pulse flex-col items-center justify-center rounded-xl bg-slate-800/80"
      aria-hidden
    >
      <div className="h-32 w-32 rounded-full bg-slate-700/80" />
      <p className="mt-3 text-xs text-slate-500">Loading scores…</p>
    </div>
  );
}

async function RadarChart({ scores }: { scores: VenueScores }) {
  await new Promise((r) => setTimeout(r, 120));
  const axes = [
    { label: "Foreigner-friendly", value: scores.foreignerFriendly },
    { label: "Reliability", value: scores.reliability },
    { label: "Price clarity", value: scores.priceTransparency },
  ];
  const max = 100;
  const cx = 80;
  const cy = 80;
  const r = 55;
  const points = axes.map((a, i) => {
    const angle = (-Math.PI / 2 + (i * 2 * Math.PI) / 3) % (2 * Math.PI);
    const len = (a.value / max) * r;
    return `${cx + len * Math.cos(angle)},${cy + len * Math.sin(angle)}`;
  });
  const poly = points.join(" ");

  return (
    <div className="w-full max-w-xs">
      <svg viewBox="0 0 160 160" className="w-full text-rose-500/30">
        {[0.33, 0.66, 1].map((t) => (
          <polygon
            key={t}
            fill="none"
            stroke="currentColor"
            strokeWidth="1"
            points={`${cx},${cy - r * t} ${cx + r * t * 0.866},${cy + r * t * 0.5} ${cx - r * t * 0.866},${cy + r * t * 0.5}`}
          />
        ))}
        <polygon
          fill="rgba(244,63,94,0.25)"
          stroke="rgb(244,63,94)"
          strokeWidth="1.5"
          points={poly}
        />
      </svg>
      <ul className="mt-2 space-y-1 text-xs text-slate-400">
        {axes.map((a) => (
          <li key={a.label} className="flex justify-between gap-4">
            <span>{a.label}</span>
            <span className="text-slate-200">{a.value}</span>
          </li>
        ))}
      </ul>
    </div>
  );
}

export function VenueScoreCard({ scores }: { scores: VenueScores }) {
  const total = overallScore(scores);
  return (
    <section className="rounded-2xl border border-slate-800 bg-slate-900/50 p-4">
      <div className="mb-3 flex items-baseline justify-between gap-2">
        <h2 className="text-lg font-semibold text-slate-100">Scores</h2>
        <p className="text-sm text-rose-400">
          Overall <span className="font-mono font-bold">{total.toFixed(1)}</span>
        </p>
      </div>
      <Suspense fallback={<RadarSkeleton />}>
        <RadarChart scores={scores} />
      </Suspense>
    </section>
  );
}
