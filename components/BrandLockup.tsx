import Image from "next/image";
import Link from "next/link";

type BrandLockupProps = {
  href?: string;
  size?: "sm" | "md" | "lg";
  showTagline?: boolean;
  className?: string;
};

const SIZE = {
  sm: {
    mark: "h-10 w-10",
    title: "text-lg",
    tagline: "text-[10px]",
    gap: "gap-2.5",
    padding: "px-2.5 py-2",
  },
  md: {
    mark: "h-12 w-12",
    title: "text-2xl",
    tagline: "text-[11px]",
    gap: "gap-3",
    padding: "px-3 py-2.5",
  },
  lg: {
    mark: "h-14 w-14 sm:h-16 sm:w-16",
    title: "text-3xl sm:text-4xl",
    tagline: "text-[11px] sm:text-xs",
    gap: "gap-3.5",
    padding: "px-3.5 py-3",
  },
} as const;

export function BrandLockup({
  href,
  size = "md",
  showTagline = true,
  className = "",
}: BrandLockupProps) {
  const styles = SIZE[size];
  const content = (
    <div
      className={`inline-flex items-center ${styles.gap} rounded-full border border-rose-200/20 bg-zinc-950/82 ${styles.padding} shadow-[0_0_38px_rgba(244,63,94,0.18)] backdrop-blur ${className}`}
    >
      <span className={`relative shrink-0 ${styles.mark}`}>
        <span className="absolute inset-[-5px] rounded-full bg-rose-500/18 blur-md" />
        <Image
          src="/brand/thainight-mark.png"
          alt="ThaiNight logo"
          fill
          priority={size === "lg"}
          sizes={size === "lg" ? "64px" : "48px"}
          className="relative rounded-full object-cover ring-2 ring-rose-100/30"
        />
      </span>
      <span className="leading-none">
        <span className={`block font-black tracking-tight text-white ${styles.title}`}>
          Thai<span className="text-rose-300">Night</span>
        </span>
        {showTagline ? (
          <span className={`mt-1 block font-bold uppercase tracking-[0.22em] text-zinc-500 ${styles.tagline}`}>
            Thailand nightlife
          </span>
        ) : null}
      </span>
    </div>
  );

  if (!href) return content;

  return (
    <Link href={href} aria-label="ThaiNight home" className="inline-flex">
      {content}
    </Link>
  );
}
