import Link from "next/link";

type FaqItem = {
  question: string;
  answer: string;
};

type NextStep = {
  href: string;
  label: string;
  description: string;
};

type Props = {
  pageUrl: string;
  title: string;
  intro: string;
  items: FaqItem[];
  nextSteps?: NextStep[];
};

export function PriorityFaq({ pageUrl, title, intro, items, nextSteps = [] }: Props) {
  const faqJsonLd = {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: items.map((item) => ({
      "@type": "Question",
      name: item.question,
      acceptedAnswer: {
        "@type": "Answer",
        text: item.answer,
      },
    })),
  };

  return (
    <section className="rounded-3xl border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(faqJsonLd) }}
      />
      <div className="max-w-3xl">
        <p className="text-xs font-black uppercase tracking-widest text-amber-300">
          FAQ and next steps
        </p>
        <h2 className="mt-3 text-3xl font-black tracking-tight text-white">{title}</h2>
        <p className="mt-3 text-sm leading-7 text-zinc-400">{intro}</p>
      </div>

      <div className="mt-6 grid gap-4 lg:grid-cols-[1.05fr_0.95fr]">
        <div className="space-y-3">
          {items.map((item) => (
            <div
              key={item.question}
              className="rounded-2xl border border-zinc-800 bg-zinc-900/45 p-4"
            >
              <h3 className="text-base font-black text-white">{item.question}</h3>
              <p className="mt-2 text-sm leading-7 text-zinc-400">{item.answer}</p>
            </div>
          ))}
        </div>

        <div className="rounded-2xl border border-zinc-800 bg-zinc-900/45 p-4">
          <p className="text-xs font-black uppercase tracking-widest text-zinc-300">
            Best next clicks
          </p>
          <p className="mt-3 text-sm leading-7 text-zinc-400">
            These are the strongest follow-up pages after{" "}
            <span className="font-semibold text-zinc-200">{pageUrl}</span>. They help travelers
            move from browsing into city plans, event checking, and practical nightlife decisions.
          </p>
          <div className="mt-4 space-y-3">
            {nextSteps.map((step) => (
              <Link
                key={step.href}
                href={step.href}
                className="block rounded-2xl border border-zinc-800 bg-black/20 p-4 transition hover:border-amber-300/35 hover:bg-black/35"
              >
                <p className="text-base font-black text-white">{step.label}</p>
                <p className="mt-2 text-xs leading-6 text-zinc-500">{step.description}</p>
              </Link>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}
