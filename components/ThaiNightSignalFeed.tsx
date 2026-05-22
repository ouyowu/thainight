import { Radio, ShieldCheck } from "lucide-react";
import type { ThaiNightSignal } from "@/lib/thainight-signals";
import { signalScore } from "@/lib/thainight-signals";

function formatLabel(value: string | null): string {
  if (!value) return "nightlife";
  return value.replace(/_/g, " ");
}

function formatTime(value: string): string {
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return "recent";
  return date.toLocaleDateString("en-US", {
    month: "short",
    day: "numeric",
  });
}

export function ThaiNightSignalFeed({
  signals,
  title = "Fresh traveler intelligence",
  emptyText = "ThaiNight has not found fresh signals for this view yet.",
}: {
  signals: ThaiNightSignal[];
  title?: string;
  emptyText?: string;
}) {
  return (
    <section className="rounded-xl border border-zinc-800 bg-zinc-950/70 p-5">
      <div className="mb-4 flex items-center justify-between gap-3">
        <div>
          <p className="flex items-center gap-2 text-xs font-semibold uppercase tracking-widest text-amber-300">
            <Radio className="size-3.5" aria-hidden />
            ThaiNight Signals
          </p>
          <h2 className="mt-1 text-2xl font-black tracking-tight text-white">
            {title}
          </h2>
        </div>
      </div>

      {signals.length === 0 ? (
        <p className="rounded-lg border border-dashed border-zinc-800 bg-zinc-900/50 p-4 text-sm text-zinc-500">
          {emptyText}
        </p>
      ) : (
        <div className="grid gap-3 lg:grid-cols-3">
          {signals.map((signal) => {
            const score = signalScore(signal);
            return (
              <a
                key={signal.id}
                href={signal.url}
                target="_blank"
                rel="noreferrer"
                className="group flex min-h-52 flex-col justify-between rounded-lg border border-zinc-800 bg-zinc-900/70 p-4 transition hover:border-amber-400/60 hover:bg-zinc-900"
              >
                <div>
                  <div className="mb-3 flex flex-wrap items-center gap-2">
                    <span className="rounded-full bg-amber-400/10 px-2 py-0.5 text-xs font-bold text-amber-200">
                      {signal.location ?? "Thailand"}
                    </span>
                    <span className="rounded-full bg-cyan-400/10 px-2 py-0.5 text-xs font-bold text-cyan-200">
                      {formatLabel(signal.category)}
                    </span>
                    {score !== null && (
                      <span className="ml-auto rounded-full bg-emerald-400/10 px-2 py-0.5 text-xs font-bold text-emerald-200">
                        {score}/10
                      </span>
                    )}
                  </div>
                  <h3 className="line-clamp-2 text-sm font-bold leading-6 text-white group-hover:text-amber-100">
                    {signal.title}
                  </h3>
                  <p className="mt-2 line-clamp-3 text-sm leading-6 text-zinc-400">
                    {signal.summary || signal.snippet}
                  </p>
                </div>

                <div className="mt-4 flex items-center justify-between border-t border-zinc-800 pt-3 text-xs text-zinc-500">
                  <span className="inline-flex items-center gap-1.5">
                    <ShieldCheck className="size-3.5 text-emerald-300" aria-hidden />
                    credibility {signal.credibilityScore ?? "n/a"}
                  </span>
                  <span>{signal.platform} · {formatTime(signal.matchedAt)}</span>
                </div>
              </a>
            );
          })}
        </div>
      )}
    </section>
  );
}
