"use client";

// components/VenueDetailClient.tsx
// Full venue detail page UI
// Recharts RadarChart + score bars + intelligence feed + Telegram CTA

import { importLibrary, setOptions } from "@googlemaps/js-api-loader";
import { useEffect, useMemo, useRef, useState } from "react";
import Link from "next/link";
import Image from "next/image";
import {
  RadarChart, PolarGrid, PolarAngleAxis,
  Radar, ResponsiveContainer, Tooltip,
} from "recharts";
import {
  MapPin, Clock, DollarSign, ChevronRight, Star,
  Users, Moon, Music2, Shield, Navigation, Zap,
  ExternalLink, Send, PlusCircle, CheckCircle2,
  AlertTriangle, TrendingUp, MessageCircle,
  Images, X, ChevronLeft, Phone, Globe, ThumbsUp,
} from "lucide-react";
import { VenueSocialPanel } from "@/components/VenueSocialPanel";
import { AttendanceTracker } from "@/components/AttendanceTracker";
import { OverlapTonightCard } from "@/components/OverlapTonightCard";
import { canRenderPublicImage } from "@/lib/media";

// ─── Types ────────────────────────────────────────────────────────────────────

interface Venue {
  id: string; slug: string; name: string; city: string;
  area_slug: string; category: string; tagline?: string | null;
  address?: string | null; latitude?: number | null; longitude?: number | null;
  google_maps_url?: string | null; google_place_id?: string | null;
  phone?: string | null; website?: string | null;
  instagram_handle?: string | null; opening_hours?: string | null;
  price_range?: string | null; cover_charge?: number | null; dress_code?: string | null;
  hero_image_url?: string | null; image_urls?: unknown; tags?: string[] | null; insider_tip?: string | null;
  score_foreigner_friendly?: number | null; score_solo_traveler?: number | null;
  score_date_night?: number | null; score_music_quality?: number | null;
  score_tourist_trap_risk?: number | null; score_price_transparency?: number | null;
  score_walkability?: number | null; score_late_night_reliability?: number | null;
  overall_score?: number | null; last_verified_at?: string | null;
  verified_by?: string | null; updated_at?: string | null;
  is_permanently_closed?: boolean; temporarily_closed?: boolean;
  social_enabled?: boolean;
  is_trending?: boolean;
}

interface IntelItem {
  id: string; title: string; url: string; subreddit?: string | null;
  thainight_value?: number | null; sentiment?: string | null;
  received_at: string; body_snippet?: string | null;
}

interface SimilarVenue {
  id: string; slug: string; name: string; area_slug: string;
  area_name?: string | null; category: string; overall_score?: number | null;
  price_range?: string | null; last_verified_at?: string | null; is_verified_this_week?: boolean;
}

interface Props {
  venue:         Venue;
  intelligence:  IntelItem[];
  similarVenues: SimilarVenue[];
  city:          string;
  area:          string;
}

interface GoogleReviewExcerpt {
  id: string;
  rating: number;
  text: string;
  relative_time?: string | null;
  author?: string | null;
}

interface MemberReview {
  id: string;
  display_name: string | null;
  rating: number;
  body: string;
  recommendation: "thumbs_up" | "tomato";
  created_at: string;
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

function isVerifiedThisWeek(date?: string | null): boolean {
  if (!date) return false;
  return Date.now() - new Date(date).getTime() < 7 * 24 * 60 * 60 * 1000;
}

function formatDate(iso?: string | null): string {
  if (!iso) return "Unknown";
  return new Date(iso).toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" });
}

function scoreColor(s?: number | null): string {
  if (!s) return "bg-zinc-700";
  return s >= 8 ? "bg-emerald-500" : s >= 6 ? "bg-amber-500" : "bg-red-500";
}

function scoreTextColor(s?: number | null): string {
  if (!s) return "text-zinc-500";
  return s >= 8 ? "text-emerald-400" : s >= 6 ? "text-amber-400" : "text-red-400";
}

function canRenderVenueImage(url?: string | null): boolean {
  return canRenderPublicImage(url);
}

function normalizeGalleryImages(venue: Venue): string[] {
  const rawImages = Array.isArray(venue.image_urls)
    ? venue.image_urls.filter((url): url is string => typeof url === "string")
    : [];
  const allImages = [venue.hero_image_url, ...rawImages]
    .filter((url): url is string => Boolean(url))
    .filter((url) => canRenderVenueImage(url));
  return Array.from(new Set(allImages)).slice(0, 5);
}

function classifyWebsite(url?: string | null): "instagram" | "facebook" | "website" | null {
  if (!url) return null;
  const lower = url.toLowerCase();
  if (lower.includes("instagram.com")) return "instagram";
  if (lower.includes("facebook.com") || lower.includes("fb.com")) return "facebook";
  return "website";
}

function extractInstagramHandle(url?: string | null): string | null {
  if (!url) return null;
  const match = url.match(/instagram\.com\/([^/?#]+)/i);
  const handle = match?.[1]?.replace(/^@/, "");
  return handle && handle !== "p" ? handle : null;
}

function galleryAlt(venue: Venue, index: number): string {
  return `${venue.name} ${venue.category.replace(/-/g, " ")} environment ${index + 1} - ThaiNight`;
}

function stars(rating: number): string {
  return "★".repeat(Math.max(0, Math.min(5, rating))) + "☆".repeat(Math.max(0, 5 - rating));
}

const TRUST_SIGNAL_STYLE: Record<
  string,
  { card: string; icon: string }
> = {
  emerald: {
    card: "bg-emerald-500/5 border-emerald-500/15",
    icon: "text-emerald-400",
  },
  blue: {
    card: "bg-blue-500/5 border-blue-500/15",
    icon: "text-blue-400",
  },
  amber: {
    card: "bg-amber-500/5 border-amber-500/15",
    icon: "text-amber-400",
  },
  purple: {
    card: "bg-purple-500/5 border-purple-500/15",
    icon: "text-purple-400",
  },
};

// ─── Verified badge ───────────────────────────────────────────────────────────

function VerifiedBadge({ updatedAt }: { updatedAt?: string | null }) {
  const verified = isVerifiedThisWeek(updatedAt);
  if (verified) return (
    <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-500/12 border border-emerald-500/25 text-emerald-400 text-xs font-bold">
      <span className="relative flex h-2 w-2">
        <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75" />
        <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500" />
      </span>
      Verified This Week
    </span>
  );
  return (
    <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-zinc-800 border border-zinc-700 text-zinc-400 text-xs font-semibold">
      <Clock className="w-3 h-3" />
      Updated {formatDate(updatedAt)}
    </span>
  );
}

// ─── Score bar ────────────────────────────────────────────────────────────────

function ScoreBar({ label, value, icon: Icon, inverse = false }: {
  label: string; value?: number | null; icon: React.ElementType; inverse?: boolean;
}) {
  const display = inverse && value != null ? 10 - value : value;
  return (
    <div className="flex items-center gap-3">
      <Icon className="w-4 h-4 text-zinc-500 shrink-0" />
      <div className="flex-1 min-w-0">
        <div className="flex justify-between mb-1">
          <span className="text-xs text-zinc-400">{label}</span>
          <span className="text-xs font-bold font-mono text-white">{display?.toFixed(1) ?? "—"}</span>
        </div>
        <div className="h-1.5 bg-zinc-800 rounded-full overflow-hidden">
          <div
            className={`h-full rounded-full transition-all duration-700 ${scoreColor(display)}`}
            style={{ width: `${((display ?? 0) / 10) * 100}%` }}
          />
        </div>
      </div>
    </div>
  );
}

// ─── Radar chart data ─────────────────────────────────────────────────────────

function buildRadarData(venue: Venue) {
  return [
    { metric: "Foreigner\nFriendly", value: venue.score_foreigner_friendly ?? 5,  fullMark: 10 },
    { metric: "Solo\nTraveler",      value: venue.score_solo_traveler      ?? 5,  fullMark: 10 },
    { metric: "Date\nNight",         value: venue.score_date_night         ?? 5,  fullMark: 10 },
    { metric: "Music",               value: venue.score_music_quality      ?? 5,  fullMark: 10 },
    { metric: "Safe\n(no trap)",     value: 10 - (venue.score_tourist_trap_risk ?? 5), fullMark: 10 },
    { metric: "Price\nTransp.",      value: venue.score_price_transparency  ?? 5,  fullMark: 10 },
    { metric: "Walkable",            value: venue.score_walkability         ?? 5,  fullMark: 10 },
    { metric: "Late Night",          value: venue.score_late_night_reliability ?? 5, fullMark: 10 },
  ];
}

function RadarTooltip({ active, payload }: { active?: boolean; payload?: Array<{ payload: { metric: string; value: number } }> }) {
  if (!active || !payload?.length) return null;
  const d = payload[0].payload;
  return (
    <div className="bg-zinc-900 border border-zinc-700 rounded-lg px-3 py-2 text-xs shadow-xl">
      <p className="text-zinc-400">{d.metric.replace("\n", " ")}</p>
      <p className="text-white font-bold text-sm">{d.value.toFixed(1)}/10</p>
    </div>
  );
}

// ─── Google Maps embed ───────────────────────────────────────────────────────

const MIDNIGHT_MAP_STYLE: google.maps.MapTypeStyle[] = [
  { elementType: "geometry", stylers: [{ color: "#111113" }] },
  { elementType: "labels.text.fill", stylers: [{ color: "#a1a1aa" }] },
  { elementType: "labels.text.stroke", stylers: [{ color: "#18181b" }] },
  { featureType: "administrative", elementType: "geometry.stroke", stylers: [{ color: "#3f3f46" }] },
  { featureType: "landscape", elementType: "geometry", stylers: [{ color: "#18181b" }] },
  { featureType: "poi", elementType: "geometry", stylers: [{ color: "#27272a" }] },
  { featureType: "poi.business", elementType: "labels.text.fill", stylers: [{ color: "#f59e0b" }] },
  { featureType: "road", elementType: "geometry", stylers: [{ color: "#27272a" }] },
  { featureType: "road", elementType: "geometry.stroke", stylers: [{ color: "#09090b" }] },
  { featureType: "road", elementType: "labels.text.fill", stylers: [{ color: "#d4d4d8" }] },
  { featureType: "transit", elementType: "geometry", stylers: [{ color: "#27272a" }] },
  { featureType: "water", elementType: "geometry", stylers: [{ color: "#0f172a" }] },
  { featureType: "water", elementType: "labels.text.fill", stylers: [{ color: "#71717a" }] },
];

let googleMapsOptionsConfigured = false;

function VenueMap({ venue }: { venue: Venue }) {
  const mapRef = useRef<HTMLDivElement | null>(null);
  const [loadState, setLoadState] = useState<"idle" | "ready" | "missing" | "error">("idle");

  useEffect(() => {
    const apiKey = process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY;
    if (!apiKey || venue.latitude == null || venue.longitude == null || !mapRef.current) {
      setLoadState("missing");
      return;
    }

    let cancelled = false;
    const position = { lat: venue.latitude, lng: venue.longitude };

    if (!googleMapsOptionsConfigured) {
      setOptions({
        key: apiKey,
        v: "weekly",
        authReferrerPolicy: "origin",
      });
      googleMapsOptionsConfigured = true;
    }

    Promise.all([importLibrary("maps"), importLibrary("marker")])
      .then(([mapsLibrary, markerLibrary]) => {
        if (cancelled || !mapRef.current) return;

        const { Map } = mapsLibrary;
        const { Marker } = markerLibrary;
        const map = new Map(mapRef.current, {
          center: position,
          zoom: 16,
          disableDefaultUI: true,
          zoomControl: true,
          fullscreenControl: true,
          gestureHandling: "cooperative",
          backgroundColor: "#09090b",
          styles: MIDNIGHT_MAP_STYLE,
        });

        new Marker({
          map,
          position,
          title: venue.name,
        });
        setLoadState("ready");
      })
      .catch(() => {
        if (!cancelled) setLoadState("error");
      });

    return () => {
      cancelled = true;
    };
  }, [venue.latitude, venue.longitude, venue.name]);

  if (venue.latitude == null || venue.longitude == null) return null;

  return (
    <div className="overflow-hidden rounded-2xl border border-zinc-800/70 bg-zinc-950">
      <div className="flex items-center justify-between border-b border-zinc-800/70 px-4 py-3">
        <div>
          <h3 className="text-xs font-bold uppercase tracking-widest text-zinc-500">Location Map</h3>
          <p className="mt-1 text-xs text-zinc-600">Dark Google Maps view for {venue.name}</p>
        </div>
        {venue.google_maps_url && (
          <a
            href={venue.google_maps_url}
            target="_blank"
            rel="noopener noreferrer"
            className="inline-flex items-center gap-1.5 rounded-full border border-zinc-700 px-3 py-1.5 text-xs font-semibold text-zinc-300 transition-colors hover:border-amber-500/60 hover:text-amber-300"
          >
            Open Maps <ExternalLink className="h-3 w-3" />
          </a>
        )}
      </div>
      <div className="relative h-72 w-full md:h-80">
        <div ref={mapRef} className="h-full w-full" aria-label={`${venue.name} map`} />
        {loadState !== "ready" && (
          <div className="absolute inset-0 flex items-center justify-center bg-zinc-950/80 px-6 text-center">
            <p className="text-xs text-zinc-500">
              {loadState === "error"
                ? "Map could not be loaded. Use the Google Maps link instead."
                : "Loading ThaiNight map..."}
            </p>
          </div>
        )}
      </div>
    </div>
  );
}

// ─── Airbnb-style gallery ────────────────────────────────────────────────────

function VenueGallery({ venue }: { venue: Venue }) {
  const images = useMemo(() => normalizeGalleryImages(venue), [venue]);
  const [activeIndex, setActiveIndex] = useState<number | null>(null);

  if (images.length === 0) return null;

  const open = (index: number) => setActiveIndex(index);
  const close = () => setActiveIndex(null);
  const previous = () => setActiveIndex((index) => index == null ? 0 : (index - 1 + images.length) % images.length);
  const next = () => setActiveIndex((index) => index == null ? 0 : (index + 1) % images.length);
  const desktopImages = Array.from({ length: 5 }, (_, index) => images[index] ?? null);

  return (
    <>
      <section className="space-y-4">
        <div className="flex items-center justify-between">
          <h2 className="text-xs font-bold uppercase tracking-widest text-zinc-500">Gallery</h2>
          {images.length > 1 && (
            <button
              type="button"
              onClick={() => open(0)}
              className="inline-flex items-center gap-2 rounded-lg border border-zinc-700 bg-zinc-900/80 px-3 py-2 text-xs font-semibold text-zinc-200 transition-colors hover:border-zinc-500 hover:text-white"
            >
              <Images className="h-3.5 w-3.5" />
              Show all photos
            </button>
          )}
        </div>

        <div className="md:hidden">
          <div className="flex snap-x snap-mandatory gap-3 overflow-x-auto pb-2">
            {images.map((image, index) => (
              <button
                key={image}
                type="button"
                onClick={() => open(index)}
                className="relative aspect-[4/3] min-w-full snap-center overflow-hidden rounded-xl border border-zinc-800 bg-zinc-900"
              >
                <Image
                  src={image}
                  alt={galleryAlt(venue, index)}
                  fill
                  sizes="100vw"
                  className="object-cover transition duration-300 hover:brightness-90"
                />
                <span className="absolute bottom-3 right-3 rounded-full bg-black/70 px-2.5 py-1 text-[11px] font-semibold text-white">
                  {index + 1}/{images.length}
                </span>
              </button>
            ))}
          </div>
        </div>

        <div className="relative hidden h-[420px] grid-cols-[2fr_1fr_1fr] grid-rows-2 gap-2 overflow-hidden rounded-xl md:grid">
          {desktopImages.map((image, index) => image ? (
            <button
              key={`${image}-${index}`}
              type="button"
              onClick={() => open(Math.min(index, images.length - 1))}
              className={`relative overflow-hidden bg-zinc-900 ${index === 0 ? "row-span-2" : ""}`}
            >
              <Image
                src={image}
                alt={galleryAlt(venue, Math.min(index, images.length - 1))}
                fill
                sizes="(min-width: 768px) 66vw, 100vw"
                className="object-cover transition duration-300 hover:brightness-90"
              />
            </button>
          ) : (
            <div
              key={`placeholder-${index}`}
              className={`bg-zinc-900 ${index === 0 ? "row-span-2" : ""}`}
              aria-hidden="true"
            />
          ))}
          {images.length > 1 && (
            <button
              type="button"
              onClick={() => open(0)}
              className="absolute bottom-5 right-5 inline-flex items-center gap-2 rounded-lg border border-zinc-300 bg-white px-4 py-2 text-sm font-semibold text-zinc-950 shadow-2xl transition hover:bg-zinc-100"
            >
              <Images className="h-4 w-4" />
              Show all photos
            </button>
          )}
        </div>
      </section>

      {activeIndex != null && (
        <div className="fixed inset-0 z-[70] flex items-center justify-center bg-black/95 p-4">
          <button
            type="button"
            onClick={close}
            className="absolute right-5 top-5 rounded-full border border-white/15 bg-white/10 p-3 text-white transition hover:bg-white/20"
            aria-label="Close gallery"
          >
            <X className="h-5 w-5" />
          </button>
          {images.length > 1 && (
            <>
              <button
                type="button"
                onClick={previous}
                className="absolute left-4 rounded-full border border-white/15 bg-white/10 p-3 text-white transition hover:bg-white/20 md:left-8"
                aria-label="Previous image"
              >
                <ChevronLeft className="h-5 w-5" />
              </button>
              <button
                type="button"
                onClick={next}
                className="absolute right-4 rounded-full border border-white/15 bg-white/10 p-3 text-white transition hover:bg-white/20 md:right-8"
                aria-label="Next image"
              >
                <ChevronRight className="h-5 w-5" />
              </button>
            </>
          )}
          <figure className="max-h-[88vh] max-w-6xl">
            <Image
              src={images[activeIndex]}
              alt={galleryAlt(venue, activeIndex)}
              width={1600}
              height={1200}
              sizes="100vw"
              className="max-h-[82vh] w-auto max-w-full rounded-xl object-contain shadow-2xl"
            />
            <figcaption className="mt-3 text-center text-xs font-semibold text-zinc-400">
              {activeIndex + 1} / {images.length}
            </figcaption>
          </figure>
        </div>
      )}
    </>
  );
}

// ─── Intelligence item ────────────────────────────────────────────────────────

function IntelCard({ item }: { item: IntelItem }) {
  const isRecent = Date.now() - new Date(item.received_at).getTime() < 6 * 60 * 60 * 1000;
  const sentimentColor = item.sentiment === "positive" ? "text-emerald-400"
    : item.sentiment === "negative" ? "text-red-400" : "text-zinc-400";

  return (
    <a href={item.url} target="_blank" rel="noopener noreferrer"
      className="group flex gap-3 p-3 rounded-xl bg-zinc-800/60 border border-zinc-700/40 hover:border-zinc-600 transition-all">
      <div className="shrink-0 mt-0.5">
        <div className="w-7 h-7 rounded-full bg-[#FF4500]/10 border border-[#FF4500]/20 flex items-center justify-center text-[10px] font-bold text-[#FF4500]">r/</div>
      </div>
      <div className="flex-1 min-w-0">
        <p className="text-xs font-semibold text-white line-clamp-2 group-hover:text-amber-300 transition-colors">
          {item.title}
        </p>
        <div className="flex items-center gap-2 mt-1">
          <span className="text-[10px] text-zinc-500">r/{item.subreddit}</span>
          {isRecent && <span className="text-[10px] text-amber-400 font-semibold">🔥 Hot</span>}
          <span className={`text-[10px] font-semibold ${sentimentColor}`}>
            {item.sentiment === "positive" ? "👍" : item.sentiment === "negative" ? "⚠️" : "·"}
          </span>
          <span className="text-[10px] text-zinc-600">{formatDate(item.received_at)}</span>
        </div>
      </div>
      <ExternalLink className="w-3.5 h-3.5 text-zinc-600 group-hover:text-zinc-400 shrink-0 mt-1 transition-colors" />
    </a>
  );
}

// ─── Google Maps review excerpts ─────────────────────────────────────────────

function GoogleReviewHighlights({ venue }: { venue: Venue }) {
  const [reviews, setReviews] = useState<GoogleReviewExcerpt[]>([]);
  const [state, setState] = useState<"idle" | "loading" | "ready" | "empty" | "error">("idle");

  useEffect(() => {
    if (!venue.google_place_id) {
      setState("empty");
      return;
    }

    let cancelled = false;
    setState("loading");

    fetch(`/api/google-reviews?placeId=${encodeURIComponent(venue.google_place_id)}`)
      .then(async (response) => {
        const payload = await response.json() as { reviews?: GoogleReviewExcerpt[] };
        if (!response.ok) throw new Error("Google reviews unavailable");
        return payload.reviews ?? [];
      })
      .then((items) => {
        if (cancelled) return;
        setReviews(items);
        setState(items.length > 0 ? "ready" : "empty");
      })
      .catch(() => {
        if (!cancelled) setState("error");
      });

    return () => {
      cancelled = true;
    };
  }, [venue.google_place_id]);

  return (
    <section className="rounded-2xl border border-zinc-800/60 bg-zinc-900/40 p-6">
      <div className="flex flex-wrap items-end justify-between gap-3">
        <div>
          <h2 className="text-xs font-bold uppercase tracking-widest text-zinc-500">Google Maps Review Highlights</h2>
          <p className="mt-2 max-w-2xl text-sm leading-relaxed text-zinc-400">
            A balanced excerpt set where available, keeping praise and complaints visible side by side.
          </p>
        </div>
        <span className="rounded-full border border-zinc-700 bg-zinc-950 px-3 py-1 text-[11px] font-semibold text-zinc-500">
          Google returns up to 5 review excerpts
        </span>
      </div>

      {state === "loading" && <p className="mt-5 text-sm text-zinc-500">Loading review excerpts...</p>}
      {state === "empty" && <p className="mt-5 text-sm text-zinc-500">No Google review excerpts are available for this venue yet.</p>}
      {state === "error" && <p className="mt-5 text-sm text-zinc-500">Review excerpts could not be loaded right now.</p>}

      {state === "ready" && (
        <div className="mt-5 grid gap-3 md:grid-cols-2">
          {reviews.map((review) => (
            <article key={review.id} className="rounded-xl border border-zinc-800 bg-zinc-950/80 p-4">
              <div className="flex items-center justify-between gap-3">
                <span className={`text-sm font-black tracking-[0] ${review.rating <= 2 ? "text-rose-400" : "text-amber-400"}`}>
                  {stars(review.rating)}
                </span>
                {review.relative_time && <span className="text-[11px] text-zinc-600">{review.relative_time}</span>}
              </div>
              <p className="mt-3 line-clamp-5 text-sm leading-relaxed text-zinc-300">{review.text}</p>
              {review.author && <p className="mt-3 text-xs font-semibold text-zinc-500">{review.author}</p>}
            </article>
          ))}
        </div>
      )}
    </section>
  );
}

// ─── ThaiNight member reviews ────────────────────────────────────────────────

function MemberReviewBoard({ venue }: { venue: Venue }) {
  const [reviews, setReviews] = useState<MemberReview[]>([]);
  const [status, setStatus] = useState<"loading" | "ready" | "error">("loading");
  const [rating, setRating] = useState(5);
  const [displayName, setDisplayName] = useState("");
  const [body, setBody] = useState("");
  const [recommendation, setRecommendation] = useState<"thumbs_up" | "tomato">("thumbs_up");
  const [submitState, setSubmitState] = useState<"idle" | "sending" | "sent" | "auth" | "error">("idle");

  useEffect(() => {
    let cancelled = false;
    fetch(`/api/venue-reviews?venueId=${encodeURIComponent(venue.id)}`)
      .then(async (response) => {
        const payload = await response.json() as { reviews?: MemberReview[] };
        if (!response.ok) throw new Error("reviews unavailable");
        return payload.reviews ?? [];
      })
      .then((items) => {
        if (cancelled) return;
        setReviews(items);
        setStatus("ready");
      })
      .catch(() => {
        if (!cancelled) setStatus("error");
      });

    return () => {
      cancelled = true;
    };
  }, [venue.id]);

  async function submitReview(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setSubmitState("sending");

    try {
      const response = await fetch("/api/venue-reviews", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          venue_id: venue.id,
          display_name: displayName.trim() || undefined,
          rating,
          body: body.trim(),
          recommendation,
        }),
      });
      const payload = await response.json() as { review?: MemberReview };
      if (response.status === 401) {
        setSubmitState("auth");
        return;
      }
      if (!response.ok || !payload.review) throw new Error("submit failed");

      setReviews((current) => [payload.review!, ...current.filter((review) => review.id !== payload.review!.id)]);
      setBody("");
      setSubmitState("sent");
    } catch {
      setSubmitState("error");
    }
  }

  return (
    <section className="rounded-2xl border border-zinc-800/60 bg-zinc-900/40 p-6">
      <div>
        <h2 className="text-xs font-bold uppercase tracking-widest text-zinc-500">ThaiNight Member Reviews</h2>
        <p className="mt-2 max-w-2xl text-sm leading-relaxed text-zinc-400">
          Registered visitors can leave a first-hand note, a 1-5 rating, and a quick thumbs-up or tomato verdict.
        </p>
      </div>

      <form onSubmit={submitReview} className="mt-5 rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4">
        <div className="grid gap-4 md:grid-cols-[160px_1fr]">
          <label className="space-y-2 text-xs font-semibold text-zinc-400">
            Your rating
            <select
              value={rating}
              onChange={(event) => setRating(Number(event.target.value))}
              className="h-11 w-full rounded-xl border border-zinc-700 bg-zinc-900 px-3 text-sm text-white outline-none transition focus:border-amber-400"
            >
              {[5, 4, 3, 2, 1].map((value) => <option key={value} value={value}>{value} stars</option>)}
            </select>
          </label>
          <label className="space-y-2 text-xs font-semibold text-zinc-400">
            Display name
            <input
              value={displayName}
              onChange={(event) => setDisplayName(event.target.value)}
              placeholder="Optional"
              maxLength={60}
              className="h-11 w-full rounded-xl border border-zinc-700 bg-zinc-900 px-3 text-sm text-white outline-none transition placeholder:text-zinc-600 focus:border-amber-400"
            />
          </label>
        </div>

        <label className="mt-4 block space-y-2 text-xs font-semibold text-zinc-400">
          Your comment
          <textarea
            value={body}
            onChange={(event) => setBody(event.target.value)}
            placeholder="What felt accurate, surprising, overpriced, welcoming, or worth returning for?"
            minLength={12}
            maxLength={1200}
            required
            className="min-h-28 w-full resize-y rounded-xl border border-zinc-700 bg-zinc-900 px-3 py-3 text-sm leading-relaxed text-white outline-none transition placeholder:text-zinc-600 focus:border-amber-400"
          />
        </label>

        <div className="mt-4 flex flex-wrap items-center justify-between gap-3">
          <div className="inline-flex rounded-xl border border-zinc-700 bg-zinc-900 p-1">
            <button
              type="button"
              onClick={() => setRecommendation("thumbs_up")}
              className={`inline-flex h-10 items-center gap-2 rounded-lg px-3 text-sm font-semibold transition ${recommendation === "thumbs_up" ? "bg-emerald-500/15 text-emerald-300" : "text-zinc-400 hover:text-white"}`}
            >
              <ThumbsUp className="h-4 w-4" />
              Like
            </button>
            <button
              type="button"
              onClick={() => setRecommendation("tomato")}
              className={`inline-flex h-10 items-center gap-2 rounded-lg px-3 text-sm font-semibold transition ${recommendation === "tomato" ? "bg-rose-500/15 text-rose-300" : "text-zinc-400 hover:text-white"}`}
            >
              <span aria-hidden="true">🍅</span>
              Tomato
            </button>
          </div>
          <button
            type="submit"
            disabled={submitState === "sending"}
            className="inline-flex h-11 items-center justify-center rounded-xl bg-amber-400 px-5 text-sm font-black text-zinc-950 transition hover:bg-amber-300 disabled:cursor-not-allowed disabled:opacity-60"
          >
            {submitState === "sending" ? "Posting..." : "Post review"}
          </button>
        </div>

        {submitState === "auth" && <p className="mt-3 text-sm text-amber-300">Please sign in first, then post your review.</p>}
        {submitState === "sent" && <p className="mt-3 text-sm text-emerald-300">Your ThaiNight review is live.</p>}
        {submitState === "error" && <p className="mt-3 text-sm text-rose-300">That review could not be posted right now.</p>}
      </form>

      <div className="mt-5 space-y-3">
        {status === "loading" && <p className="text-sm text-zinc-500">Loading ThaiNight member reviews...</p>}
        {status === "error" && <p className="text-sm text-zinc-500">Member reviews are not available yet.</p>}
        {status === "ready" && reviews.length === 0 && <p className="text-sm text-zinc-500">No member reviews yet. This venue is waiting for its first field report.</p>}
        {reviews.map((review) => (
          <article key={review.id} className="rounded-xl border border-zinc-800 bg-zinc-950/80 p-4">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div className="flex items-center gap-3">
                <span className="text-sm font-black text-amber-400">{stars(review.rating)}</span>
                <span className="text-sm font-semibold text-white">{review.display_name || "ThaiNight member"}</span>
              </div>
              <div className="flex items-center gap-2 text-xs text-zinc-500">
                <span>{review.recommendation === "thumbs_up" ? "👍" : "🍅"}</span>
                <span>{formatDate(review.created_at)}</span>
              </div>
            </div>
            <p className="mt-3 whitespace-pre-wrap text-sm leading-relaxed text-zinc-300">{review.body}</p>
          </article>
        ))}
      </div>
    </section>
  );
}

// ─── Main component ───────────────────────────────────────────────────────────

export default function VenueDetailClient({ venue, intelligence, similarVenues, city, area }: Props) {
  const [mounted, setMounted] = useState(false);
  const radarData  = useMemo(() => buildRadarData(venue), [venue]);
  const hasRaidAlert = intelligence.some(i =>
    ["raid","police","closed","shutdown"].some(kw => i.title.toLowerCase().includes(kw))
  );

  const CITY_ACCENT: Record<string, string> = {
    bangkok:      "text-amber-400",
    pattaya:      "text-cyan-400",
    phuket:       "text-violet-400",
    "chiang-mai": "text-rose-400",
  };
  const accentText = CITY_ACCENT[city] ?? "text-amber-400";
  const showHeroImage = canRenderVenueImage(venue.hero_image_url);
  const websiteKind = classifyWebsite(venue.website);
  const inferredInstagram = venue.instagram_handle ?? (websiteKind === "instagram" ? extractInstagramHandle(venue.website) : null);

  useEffect(() => {
    setMounted(true);
  }, []);

  return (
    <main className="min-h-screen bg-zinc-950 text-white pb-32">

      {/* ── Hero ── */}
      <section className="relative">
        <div
          className="h-56 md:h-72 bg-cover bg-center"
          style={showHeroImage
            ? { backgroundImage: `url(${venue.hero_image_url})` }
            : { background: "linear-gradient(135deg,#1c0a00,#09090b)" }
          }
        >
          <div className="absolute inset-0 bg-gradient-to-t from-zinc-950 via-zinc-950/50 to-zinc-950/10" />
        </div>

        <div className="max-w-4xl mx-auto px-4 -mt-28 relative z-10">
          {/* Breadcrumb */}
          <nav className="flex items-center gap-1.5 text-xs text-zinc-600 mb-5">
            <Link href="/" className="hover:text-zinc-400 transition-colors">Thailand</Link>
            <ChevronRight className="w-3 h-3" />
            <Link href={`/${city}`} className={`hover:text-zinc-300 transition-colors capitalize ${accentText}`}>
              {city.replace(/-/g, " ")}
            </Link>
            <ChevronRight className="w-3 h-3" />
            <Link href={`/${city}/bars/${area}`} className="hover:text-zinc-400 transition-colors capitalize">
              {area.replace(/-/g, " ")}
            </Link>
          </nav>

          {/* Raid alert */}
          {hasRaidAlert && (
            <div className="flex items-center gap-3 p-3 rounded-xl bg-red-500/10 border border-red-500/30 mb-4">
              <AlertTriangle className="w-4 h-4 text-red-400 shrink-0" />
              <p className="text-red-300 text-xs font-semibold">
                Community alert reported for this venue. Check intelligence feed below before visiting.
              </p>
            </div>
          )}

          {/* Venue header */}
          <div className="flex items-start justify-between gap-4">
            <div className="flex-1 min-w-0">
              <VerifiedBadge updatedAt={venue.last_verified_at} />
              <h1 className="text-3xl md:text-4xl font-black tracking-tight mt-3 leading-tight">
                {venue.name}
              </h1>
              {venue.tagline && (
                <p className="text-zinc-400 text-sm mt-2 leading-relaxed max-w-xl">{venue.tagline}</p>
              )}
              <div className="flex items-center flex-wrap gap-4 mt-4 text-sm text-zinc-400">
                {venue.google_maps_url ? (
                  <a href={venue.google_maps_url} target="_blank" rel="noopener noreferrer"
                    className="flex items-center gap-1.5 hover:text-white transition-colors">
                    <MapPin className="w-4 h-4 text-rose-400" />
                    <span className="capitalize">{area.replace(/-/g, " ")}</span>
                  </a>
                ) : (
                  <span className="flex items-center gap-1.5">
                    <MapPin className="w-4 h-4 text-rose-400" />
                    <span className="capitalize">{area.replace(/-/g, " ")}</span>
                  </span>
                )}
                {venue.opening_hours && (
                  <span className="flex items-center gap-1.5">
                    <Clock className="w-4 h-4 text-amber-400" />{venue.opening_hours}
                  </span>
                )}
                {venue.price_range && (
                  <span className="flex items-center gap-1.5">
                    <DollarSign className="w-4 h-4 text-emerald-400" />
                    <span className="font-mono font-bold text-emerald-400">{venue.price_range}</span>
                  </span>
                )}
              </div>

              {/* Tags */}
              {(venue.tags ?? []).length > 0 && (
                <div className="flex flex-wrap gap-2 mt-3">
                  {(venue.tags ?? []).map(tag => (
                    <span key={tag} className="px-2.5 py-1 bg-zinc-800/80 border border-zinc-700/50 rounded-full text-xs text-zinc-400 capitalize">
                      {tag.replace(/-/g, " ")}
                    </span>
                  ))}
                </div>
              )}
            </div>

            {/* Overall score */}
            {venue.overall_score && (
              <div className="shrink-0 flex flex-col items-center justify-center w-20 h-20 rounded-2xl bg-gradient-to-br from-amber-500/15 to-orange-500/8 border border-amber-500/25">
                <span className={`text-3xl font-black font-mono leading-none ${scoreTextColor(venue.overall_score)}`}>
                  {venue.overall_score.toFixed(1)}
                </span>
                <span className="text-[9px] text-zinc-500 mt-1">Overall</span>
              </div>
            )}
          </div>
        </div>
      </section>

      <div className="max-w-4xl mx-auto px-4 mt-8 space-y-6">
        <VenueGallery venue={venue} />
        <AttendanceTracker
          venueId={venue.id}
          venueName={venue.name}
          venueCity={city}
          venueArea={area}
          posterUrl={normalizeGalleryImages(venue)[0] ?? venue.hero_image_url}
          headline={venue.tagline}
        />
        <OverlapTonightCard
          venueId={venue.id}
          venueName={venue.name}
          enabled={Boolean(venue.is_trending)}
        />
        <VenueSocialPanel
          venueId={venue.id}
          venueName={venue.name}
          socialEnabled={Boolean(venue.social_enabled)}
          trending={Boolean(venue.is_trending)}
        />

        {/* ── Score Card ── */}
        <section className="grid md:grid-cols-2 gap-6 bg-zinc-900/60 border border-zinc-800/60 rounded-2xl p-6">
          {/* Radar */}
          <div>
            <h2 className="text-xs font-bold uppercase tracking-widest text-zinc-500 mb-4 flex items-center gap-2">
              <TrendingUp className="w-4 h-4 text-amber-400" /> Nightlife Score Breakdown
            </h2>
            <div className="h-60">
              {mounted ? (
                <ResponsiveContainer width="100%" height="100%">
                  <RadarChart data={radarData} cx="50%" cy="50%">
                    <PolarGrid stroke="#3f3f46" strokeDasharray="3 3" gridType="polygon" />
                    <PolarAngleAxis dataKey="metric" tick={{ fill: "#a1a1aa", fontSize: 9, fontWeight: 500 }} tickLine={false} />
                    <Radar name={venue.name} dataKey="value" stroke="#f59e0b" fill="#f59e0b" fillOpacity={0.15} strokeWidth={2} />
                    <Tooltip content={<RadarTooltip />} />
                  </RadarChart>
                </ResponsiveContainer>
              ) : (
                <div className="h-full rounded-xl bg-zinc-950/40" />
              )}
            </div>
            <p className="text-[10px] text-zinc-700 text-center mt-1">
              Formula: Foreigner(30%) + Reliability(40%) + Transparency(30%)
            </p>
          </div>

          {/* Score bars */}
          <div className="space-y-3">
            <h2 className="text-xs font-bold uppercase tracking-widest text-zinc-500 mb-4 flex items-center gap-2">
              <Star className="w-4 h-4 text-amber-400" /> Individual Metrics
            </h2>
            <ScoreBar label="Foreigner Friendly"    value={venue.score_foreigner_friendly}     icon={Users} />
            <ScoreBar label="Solo Traveler"          value={venue.score_solo_traveler}          icon={Navigation} />
            <ScoreBar label="Date Night"             value={venue.score_date_night}             icon={Star} />
            <ScoreBar label="Music Quality"          value={venue.score_music_quality}          icon={Music2} />
            <ScoreBar label="Tourist Trap Risk ↓"   value={venue.score_tourist_trap_risk}      icon={AlertTriangle} inverse />
            <ScoreBar label="Price Transparency"     value={venue.score_price_transparency}     icon={DollarSign} />
            <ScoreBar label="Walkability"            value={venue.score_walkability}            icon={Navigation} />
            <ScoreBar label="Late-Night Reliability" value={venue.score_late_night_reliability} icon={Moon} />
          </div>
        </section>

        {/* ── Trust signals ── */}
        <section className="grid grid-cols-2 md:grid-cols-4 gap-3">
          {[
            { icon: Shield,    label: "No Hidden Charges", ok: (venue.score_price_transparency ?? 0) >= 7, color: "emerald" },
            { icon: Users,     label: "English Menu",       ok: (venue.score_foreigner_friendly ?? 0) >= 7, color: "blue" },
            { icon: AlertTriangle, label: "Low Trap Risk",  ok: (venue.score_tourist_trap_risk ?? 10) <= 4, color: "amber" },
            { icon: Moon,      label: "Stays Open Late",    ok: (venue.score_late_night_reliability ?? 0) >= 7, color: "purple" },
          ].map(({ icon: Icon, label, ok, color }) => {
            const style = TRUST_SIGNAL_STYLE[color] ?? TRUST_SIGNAL_STYLE.amber;
            return (
            <div key={label} className={`p-4 rounded-xl border text-center ${style.card}`}>
              <Icon className={`w-4 h-4 ${style.icon} mx-auto mb-2`} />
              <p className="text-[10px] text-zinc-500 mb-1">{label}</p>
              <p className={`text-xs font-bold ${ok ? "text-emerald-400" : "text-zinc-600"}`}>
                {ok ? "✓ Yes" : "✗ No"}
              </p>
            </div>
          );})}
        </section>

        {/* ── Insider tip ── */}
        {venue.insider_tip && (
          <section className="flex gap-4 p-5 rounded-2xl bg-amber-500/5 border border-amber-500/15">
            <div className="shrink-0 w-10 h-10 rounded-xl bg-amber-500/10 border border-amber-500/20 flex items-center justify-center">
              <Zap className="w-5 h-5 text-amber-400" />
            </div>
            <div>
              <p className="text-xs font-bold uppercase tracking-widest text-amber-400 mb-2">Insider Tip</p>
              <p className="text-zinc-300 text-sm leading-relaxed">{venue.insider_tip}</p>
            </div>
          </section>
        )}

        {/* ── ThaiNight Intelligence ── */}
        {intelligence.length > 0 && (
          <section className="rounded-2xl border border-zinc-800/60 bg-zinc-900/40 p-5">
            <h2 className="text-xs font-bold uppercase tracking-widest text-zinc-500 mb-4 flex items-center gap-2">
              <TrendingUp className="w-4 h-4 text-emerald-400" />
              Community Intelligence
              <span className="text-[10px] text-zinc-600 font-normal">via ThaiNight · last 30 days</span>
            </h2>
            <div className="space-y-2">
              {intelligence.map(item => <IntelCard key={item.id} item={item} />)}
            </div>
          </section>
        )}

        {/* ── Telegram CTA ── */}
        <section className="relative overflow-hidden rounded-2xl border border-[#2AABEE]/20 bg-zinc-900/60 p-6">
          <div className="absolute -top-12 -right-12 w-48 h-48 bg-[#2AABEE]/4 rounded-full blur-3xl pointer-events-none" />
          <div className="flex items-start gap-4 relative">
            <div className="shrink-0 w-12 h-12 rounded-xl bg-[#2AABEE]/10 border border-[#2AABEE]/20 flex items-center justify-center">
              <Send className="w-5 h-5 text-[#2AABEE]" />
            </div>
            <div className="flex-1">
              <h3 className="font-bold text-white mb-1">Real-time Thailand Nightlife Alerts</h3>
              <p className="text-zinc-400 text-sm mb-4">
                Raid warnings · Surprise closings · Popup events. 4,200+ members. Free.
              </p>
              <div className="flex flex-wrap gap-2 mb-4">
                {["🚨 Raid Alerts", "🎪 Pop-up Events", "🍹 Drink Promos", "🔒 Private Events"].map(t => (
                  <span key={t} className="text-xs px-2.5 py-1 rounded-full bg-zinc-800 border border-zinc-700 text-zinc-300">{t}</span>
                ))}
              </div>
              <a href="https://t.me/ThainightTelegram" target="_blank" rel="noopener noreferrer"
                className="inline-flex items-center gap-2 px-5 py-2.5 bg-[#2AABEE] hover:bg-[#2AABEE]/90 text-white text-sm font-bold rounded-xl transition-colors">
                <MessageCircle className="w-4 h-4" /> Join Free on Telegram →
              </a>
            </div>
          </div>
        </section>

        {/* ── Venue Details ── */}
        <section className="rounded-2xl border border-zinc-800/60 bg-zinc-900/40 p-6 space-y-4">
          <h2 className="text-xs font-bold uppercase tracking-widest text-zinc-500 flex items-center gap-2">
            <MapPin className="w-4 h-4 text-rose-400" /> Venue Contact
          </h2>
          <VenueMap venue={venue} />
          <div className="grid md:grid-cols-2 gap-4 text-sm">
            <div className="space-y-2.5">
              {venue.address && (
                <div className="flex items-start gap-2 text-zinc-400">
                  <MapPin className="w-4 h-4 shrink-0 mt-0.5 text-zinc-600" />
                  {venue.google_maps_url
                    ? <a href={venue.google_maps_url} target="_blank" rel="noopener noreferrer" className="hover:text-white transition-colors underline underline-offset-2">{venue.address}</a>
                    : <span>{venue.address}</span>
                  }
                </div>
              )}
              {venue.opening_hours && (
                <div className="flex items-center gap-2 text-zinc-400">
                  <Clock className="w-4 h-4 shrink-0 text-zinc-600" />{venue.opening_hours}
                </div>
              )}
              {venue.cover_charge != null && (
                <div className="flex items-center gap-2 text-zinc-400">
                  <DollarSign className="w-4 h-4 shrink-0 text-zinc-600" />
                  Cover: ฿{venue.cover_charge} THB
                </div>
              )}
              {venue.dress_code && (
                <div className="flex items-center gap-2 text-zinc-400">
                  <Shield className="w-4 h-4 shrink-0 text-zinc-600" />
                  Dress code: {venue.dress_code}
                </div>
              )}
            </div>
            <div className="space-y-2.5">
              {venue.phone && (
                <div className="flex items-center gap-2">
                  <Phone className="w-4 h-4 text-zinc-600 shrink-0" />
                  <a href={`tel:${venue.phone}`} className="text-zinc-400 hover:text-white transition-colors">{venue.phone}</a>
                </div>
              )}
              {venue.website && websiteKind === "website" && (
                <div className="flex items-center gap-2">
                  <Globe className="w-4 h-4 text-zinc-600 shrink-0" />
                  <a href={venue.website} target="_blank" rel="noopener noreferrer" className="text-amber-400 hover:text-amber-300 transition-colors">Official Website</a>
                </div>
              )}
              {inferredInstagram && (
                <div className="flex items-center gap-2">
                  <ExternalLink className="w-4 h-4 text-zinc-600 shrink-0" />
                  <a href={`https://instagram.com/${inferredInstagram}`} target="_blank" rel="noopener noreferrer" className="text-pink-400 hover:text-pink-300 transition-colors">@{inferredInstagram}</a>
                </div>
              )}
              {venue.website && websiteKind === "facebook" && (
                <div className="flex items-center gap-2">
                  <ExternalLink className="w-4 h-4 text-zinc-600 shrink-0" />
                  <a href={venue.website} target="_blank" rel="noopener noreferrer" className="text-blue-400 hover:text-blue-300 transition-colors">Facebook</a>
                </div>
              )}
            </div>
          </div>
        </section>

        <GoogleReviewHighlights venue={venue} />
        <MemberReviewBoard venue={venue} />

        {/* ── Similar venues ── */}
        {similarVenues.length > 0 && (
          <section>
            <h2 className="text-xs font-bold uppercase tracking-widest text-zinc-500 mb-4">
              More in {area.replace(/-/g, " ").replace(/\b\w/g, c => c.toUpperCase())}
            </h2>
            <div className="grid sm:grid-cols-2 gap-3">
              {similarVenues.map(v => (
                <Link key={v.id} href={`/${city}/bars/${v.area_slug}/${v.slug}`}
                  className="group flex items-center gap-3 p-3 rounded-xl bg-zinc-900/60 border border-zinc-800/60 hover:border-zinc-700 transition-all">
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-bold text-white group-hover:text-amber-300 transition-colors truncate">{v.name}</p>
                    <p className="text-xs text-zinc-500 capitalize">{v.category.replace(/-/g, " ")} · {v.price_range}</p>
                  </div>
                  {v.is_verified_this_week && (
                    <span className="relative flex h-2 w-2 shrink-0">
                      <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75" />
                      <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500" />
                    </span>
                  )}
                  {v.overall_score && (
                    <span className={`text-sm font-black font-mono shrink-0 ${scoreTextColor(v.overall_score)}`}>
                      {v.overall_score.toFixed(1)}
                    </span>
                  )}
                </Link>
              ))}
            </div>
          </section>
        )}

        {/* ── Freshness + data source ── */}
        <div className="flex items-center justify-between text-xs text-zinc-700 border-t border-zinc-800/60 pt-4">
          <span className="flex items-center gap-1.5">
            <CheckCircle2 className="w-3.5 h-3.5 text-zinc-600" />
            Last verified: {formatDate(venue.last_verified_at)}
            {venue.verified_by && <span className="text-zinc-800">· by {venue.verified_by}</span>}
          </span>
          <span>ThaiNight Intelligence — May 2026</span>
        </div>
      </div>

      {/* ── Float: Submit Update ── */}
      <div className="fixed bottom-6 right-4 z-50">
        <Link href={`/submit-update?venue=${venue.slug}`}
          className="flex items-center gap-2 px-4 py-3 bg-zinc-900 hover:bg-zinc-800 border border-zinc-700 hover:border-zinc-500 text-white text-sm font-semibold rounded-2xl shadow-2xl shadow-black/40 transition-all group">
          <PlusCircle className="w-4 h-4 text-amber-400 group-hover:rotate-90 transition-transform duration-200" />
          Submit an Update
        </Link>
      </div>
    </main>
  );
}
