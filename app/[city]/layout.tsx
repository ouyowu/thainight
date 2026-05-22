import Link from "next/link";
import { ChevronRight } from "lucide-react";

export default function CityLayout({
  children,
  params,
}: {
  children: React.ReactNode;
  params: { city: string };
}) {
  const { city } = params;
  const label = city.replace(/-/g, " ");
  return (
    <div className="min-h-screen">
      <header className="border-b border-slate-800 bg-slate-950/80 backdrop-blur">
        <div className="mx-auto flex max-w-4xl flex-wrap items-center gap-2 px-4 py-3 text-sm text-slate-400">
          <Link href="/" className="hover:text-rose-400">
            Home
          </Link>
          <ChevronRight className="size-4 opacity-50" aria-hidden />
          <Link href={`/${city}`} className="capitalize hover:text-rose-400">
            {label}
          </Link>
        </div>
      </header>
      {children}
    </div>
  );
}
