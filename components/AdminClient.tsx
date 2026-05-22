"use client";

// components/AdminClient.tsx
// Admin dashboard UI — approve/reject venue_updates in one click
// Also shows ThaiNight intelligence feed and site stats

import { useState, useTransition } from "react";
import {
  CheckCircle2, XCircle, Clock, TrendingUp, AlertTriangle,
  ExternalLink, RefreshCw, MessageSquare, Newspaper, ShieldAlert, Archive, Copy,
  Search, Pin, Languages, Users, Globe2,
} from "lucide-react";
import type { ThaiNightSignal } from "@/lib/thainight-signals";

// ─── Types ────────────────────────────────────────────────────────────────────

interface VenueUpdate {
  id: string; venue_slug: string; update_type: string;
  content_text?: string | null; status: string; created_at: string;
  submitter_name?: string | null; submitter_email?: string | null;
  suggested_foreigner_friendly?: number | null;
  suggested_late_night_reliability?: number | null;
  suggested_price_transparency?: number | null;
}

interface IntelItem {
  id: string; title: string; city?: string | null; subreddit?: string | null;
  thainight_value?: number | null; is_raid_alert?: boolean | null;
  is_displayed?: boolean | null; venue_type?: string | null;
  received_at: string; url: string; matched_venue_slug?: string | null;
}

interface IntelQueueItem {
  id: string;
  city: string;
  title: string;
  description?: string | null;
  flyer_image_url?: string | null;
  image_url?: string | null;
  offer_label?: string | null;
  source_url?: string | null;
  source_type: string;
  status: string;
  created_at: string;
}

interface VerificationRequestItem {
  id: string;
  user_id: string;
  submitted_handle: string;
  proof_url?: string | null;
  note?: string | null;
  status: string;
  created_at: string;
}

interface Stats { pending: number; approved: number; rejected: number; }

interface Props {
  updates:      VenueUpdate[];
  stats:        Stats;
  intelligence: IntelItem[];
  flyers:       IntelQueueItem[];
  offers:       IntelQueueItem[];
  topSignals:   ThaiNightSignal[];
  verifications: VerificationRequestItem[];
  adminKey:     string;
}

// ─── Update type colors ───────────────────────────────────────────────────────

const TYPE_COLORS: Record<string, string> = {
  raid_alert:       "bg-red-500/15 text-red-400 border-red-500/25",
  closure_report:   "bg-red-500/15 text-red-400 border-red-500/25",
  score_correction: "bg-amber-500/15 text-amber-400 border-amber-500/25",
  hours_change:     "bg-blue-500/15 text-blue-400 border-blue-500/25",
  new_info:         "bg-zinc-700/60 text-zinc-300 border-zinc-600/40",
  price_change:     "bg-emerald-500/15 text-emerald-400 border-emerald-500/25",
  reopened:         "bg-emerald-500/15 text-emerald-400 border-emerald-500/25",
  temporary_closure:"bg-orange-500/15 text-orange-400 border-orange-500/25",
};

type SignalAction = "reply" | "article" | "warning" | "ignore";
type ReviewBucket = "event" | "offer" | "warning" | "solo" | "opening" | "ignore";
type MarketingPlatform = "quora" | "x" | "google" | "pinterest" | "xiaohongshu" | "facebook";

type MarketingQueueItem = {
  id: string;
  platform: MarketingPlatform;
  title: string;
  intent: string;
  searchUrl: string;
  targetUrl: string;
  suggestedAction: string;
  draft: string;
};

const MARKETING_PLATFORM_META: Record<MarketingPlatform, {
  label: string;
  icon: typeof Search;
  accent: string;
}> = {
  quora: {
    label: "Quora",
    icon: MessageSquare,
    accent: "border-red-500/20 bg-red-500/10 text-red-200",
  },
  x: {
    label: "X / Twitter",
    icon: Search,
    accent: "border-sky-500/20 bg-sky-500/10 text-sky-200",
  },
  google: {
    label: "Google SEO",
    icon: Globe2,
    accent: "border-emerald-500/20 bg-emerald-500/10 text-emerald-200",
  },
  pinterest: {
    label: "Pinterest",
    icon: Pin,
    accent: "border-pink-500/20 bg-pink-500/10 text-pink-200",
  },
  xiaohongshu: {
    label: "小红书",
    icon: Languages,
    accent: "border-rose-500/20 bg-rose-500/10 text-rose-200",
  },
  facebook: {
    label: "Facebook Groups",
    icon: Users,
    accent: "border-blue-500/20 bg-blue-500/10 text-blue-200",
  },
};

const MARKETING_QUEUE_ITEMS: MarketingQueueItem[] = [
  {
    id: "quora-bangkok-nightlife-safe",
    platform: "quora",
    title: "Answer: Is Bangkok nightlife safe for solo travelers?",
    intent: "Quora question answer; helpful first, light link at the end.",
    searchUrl: "https://www.quora.com/search?q=Is%20Bangkok%20nightlife%20safe%20for%20solo%20travelers",
    targetUrl: "https://thainight.co/solo-traveler-bangkok-nightlife",
    suggestedAction: "Find one active/relevant Quora question and answer manually. Do not paste the link in the first paragraph.",
    draft:
      "Bangkok nightlife is very doable solo if you keep the night simple. I would start in one busy area, keep your hotel reasonably close, confirm prices before ordering, and use Grab or official taxis late at night. Soi 11 is easy for a first night, Thonglor is more polished, and RCA is more club-focused. I’m collecting practical solo nightlife notes here too: https://thainight.co/solo-traveler-bangkok-nightlife",
  },
  {
    id: "quora-pattaya-nightlife-guide",
    platform: "quora",
    title: "Answer: What is the best Pattaya nightlife area?",
    intent: "Quora answer for high-intent travel planning.",
    searchUrl: "https://www.quora.com/search?q=Pattaya%20nightlife%20guide%20Walking%20Street%20Soi%20Buakhao",
    targetUrl: "https://thainight.co/pattaya-nightlife-guide",
    suggestedAction: "Answer one question comparing Walking Street, Soi Buakhao, Jomtien, and Central Pattaya.",
    draft:
      "It depends on the kind of night you want. Walking Street is the obvious first-timer area, Soi Buakhao is usually better for a more casual bar night, and Jomtien can feel calmer. I’d check prices and transport before settling in because Pattaya varies a lot by street and venue type. I’m organizing notes here: https://thainight.co/pattaya-nightlife-guide",
  },
  {
    id: "x-f5-search-nightlife",
    platform: "x",
    title: "Search X for Thailand nightlife questions",
    intent: "Find people asking in real time; reply only when the question is direct.",
    searchUrl: "https://x.com/search?q=%22Bangkok%20nightlife%22%20OR%20%22Pattaya%20nightlife%22%20OR%20%22Bangla%20Road%22&src=typed_query&f=live",
    targetUrl: "https://thainight.co/tonight",
    suggestedAction: "Reply to 1-2 live questions without sounding like an ad.",
    draft:
      "If you’re going out tonight, I’d pick one area first rather than jumping around. Check event times, cover charges, and recent comments before you go. I’m collecting current Thailand nightlife notes here: https://thainight.co/tonight",
  },
  {
    id: "google-index-six-pages",
    platform: "google",
    title: "Request indexing for the 6 new SEO pages",
    intent: "Search Console task; fastest way to help Google discover the new pages.",
    searchUrl: "https://search.google.com/search-console",
    targetUrl: "https://thainight.co/bangkok-nightlife-tonight",
    suggestedAction: "Open Search Console URL Inspection and request indexing for the 6 new SEO URLs.",
    draft:
      "Submit these URLs: /bangkok-nightlife-tonight, /pattaya-nightlife-guide, /phuket-bangla-road-safety, /bangkok-rooftop-bars-2026, /thailand-nightlife-price-tips, /solo-traveler-bangkok-nightlife",
  },
  {
    id: "pinterest-bangkok-nightlife-map",
    platform: "pinterest",
    title: "Pin idea: Bangkok nightlife tonight map",
    intent: "Pinterest travel discovery; visual pin linking to SEO page.",
    searchUrl: "https://www.pinterest.com/search/pins/?q=bangkok%20nightlife%20guide",
    targetUrl: "https://thainight.co/bangkok-nightlife-tonight",
    suggestedAction: "Create a simple vertical pin: title + 4 area names + ThaiNight URL.",
    draft:
      "Pin title: Bangkok Nightlife Tonight: Best Areas to Start. Pin text: Soi 11, Thonglor, RCA, Silom. Check events, price tips, and safety notes before going out. Link: https://thainight.co/bangkok-nightlife-tonight",
  },
  {
    id: "pinterest-phuket-safety",
    platform: "pinterest",
    title: "Pin idea: Phuket Bangla Road safety checklist",
    intent: "Pinterest checklist pin for tourist safety search intent.",
    searchUrl: "https://www.pinterest.com/search/pins/?q=phuket%20bangla%20road%20tips",
    targetUrl: "https://thainight.co/phuket-bangla-road-safety",
    suggestedAction: "Create a checklist-style pin with 5 safety checks.",
    draft:
      "Pin title: Bangla Road Safety Checklist. Pin text: confirm prices, keep transport simple, watch belongings, check recent comments, avoid vague street offers. Link: https://thainight.co/phuket-bangla-road-safety",
  },
  {
    id: "xhs-bangkok-nightlife-cn",
    platform: "xiaohongshu",
    title: "小红书选题：第一次去曼谷夜生活怎么选区域",
    intent: "中文游客攻略；不要像广告，做收藏型笔记。",
    searchUrl: "https://www.xiaohongshu.com/search_result?keyword=%E6%9B%BC%E8%B0%B7%E5%A4%9C%E7%94%9F%E6%B4%BB",
    targetUrl: "https://thainight.co/bangkok-nightlife-tonight",
    suggestedAction: "发一篇中文收藏笔记，最后一句轻带网站。",
    draft:
      "标题：第一次去曼谷夜生活，应该住/玩哪个区域？正文：Soi 11 适合第一次去，交通和吃饭方便；Thonglor 更精致，适合约会和酒吧；RCA 更偏夜店；Silom 选择更多。出门前记得看入场费、final entry、交通和最新评论。我把持续更新的信息整理在 thainight.co/bangkok-nightlife-tonight",
  },
  {
    id: "xhs-pattaya-cn",
    platform: "xiaohongshu",
    title: "小红书选题：芭提雅夜生活防坑和预算",
    intent: "中文游客高需求；适合引到 Pattaya guide。",
    searchUrl: "https://www.xiaohongshu.com/search_result?keyword=%E8%8A%AD%E6%8F%90%E9%9B%85%E5%A4%9C%E7%94%9F%E6%B4%BB",
    targetUrl: "https://thainight.co/pattaya-nightlife-guide",
    suggestedAction: "发预算/区域对比笔记，不要夸张承诺。",
    draft:
      "标题：芭提雅夜生活区域怎么选？Walking Street 适合第一次感受氛围，Soi Buakhao 更日常，Jomtien 更轻松。注意先确认价格、交通和是否有额外费用，不要跟着模糊的街头推销走。我整理了英文版持续更新指南：thainight.co/pattaya-nightlife-guide",
  },
  {
    id: "facebook-group-soft-post",
    platform: "facebook",
    title: "Facebook 群发帖草稿：ask for additions",
    intent: "Community-safe post; ask for feedback instead of dropping an ad.",
    searchUrl: "https://www.facebook.com/search/groups/?q=Thailand%20travel%20tips",
    targetUrl: "https://thainight.co/intel",
    suggestedAction: "Join relevant Thailand travel/expat groups; post only where self-promo rules allow.",
    draft:
      "I’m putting together a practical Thailand nightlife checklist for travelers: final-entry times, cover charges, safety notes, and areas that are easier for first-timers. What would you add for Bangkok, Pattaya, or Phuket? I’m organizing the notes here as I update it: https://thainight.co/intel",
  },
  {
    id: "facebook-bangkok-solo",
    platform: "facebook",
    title: "Facebook 群互动：solo traveler Bangkok",
    intent: "Ask a useful discussion question; collect comments for future content.",
    searchUrl: "https://www.facebook.com/search/groups/?q=Bangkok%20solo%20travelers",
    targetUrl: "https://thainight.co/solo-traveler-bangkok-nightlife",
    suggestedAction: "Post as a question, then reply naturally to comments.",
    draft:
      "For people who went out solo in Bangkok recently: which area felt easiest for a first night, Soi 11, Thonglor, Silom, or RCA? I’m collecting practical solo traveler notes and will keep updating this page: https://thainight.co/solo-traveler-bangkok-nightlife",
  },
];

const SIGNAL_ACTION_META: Record<SignalAction, {
  title: string;
  description: string;
  icon: typeof MessageSquare;
  accent: string;
}> = {
  reply: {
    title: "Worth replying",
    description: "Most useful for 3-5 careful manual replies today.",
    icon: MessageSquare,
    accent: "text-emerald-300 border-emerald-500/20 bg-emerald-500/10",
  },
  article: {
    title: "Worth turning into article",
    description: "Good source for city guides, FAQs, and SEO pages.",
    icon: Newspaper,
    accent: "text-sky-300 border-sky-500/20 bg-sky-500/10",
  },
  warning: {
    title: "Worth adding as warning",
    description: "Potential fee, safety, scam, or venue-risk signal.",
    icon: ShieldAlert,
    accent: "text-red-300 border-red-500/20 bg-red-500/10",
  },
  ignore: {
    title: "Ignore / low priority",
    description: "Too vague, too noisy, or not useful for ThaiNight.",
    icon: Archive,
    accent: "text-zinc-400 border-zinc-700/60 bg-zinc-900/60",
  },
};

function signalText(signal: ThaiNightSignal): string {
  return [
    signal.title,
    signal.snippet,
    signal.summary ?? "",
    signal.category ?? "",
    signal.opportunityType ?? "",
    signal.keyword ?? "",
  ].join(" ").toLowerCase();
}

function signalStrength(signal: ThaiNightSignal): number {
  return Math.max(
    signal.travelIntentScore ?? 0,
    signal.commercialScore ?? 0,
    signal.credibilityScore ?? 0
  );
}

function isRedditSignal(signal: ThaiNightSignal): boolean {
  const text = [signal.platform, signal.url].join(" ").toLowerCase();
  return text.includes("reddit");
}

function classifySignal(signal: ThaiNightSignal): SignalAction {
  const text = signalText(signal);
  const strength = signalStrength(signal);

  const isWarning = /\b(scam|overcharge|ripoff|fee|late[- ]?entry|police|raid|unsafe|danger|drug|fight|robbed|stolen|warning|avoid)\b/.test(text);
  if (isWarning && strength >= 5) return "warning";

  const isQuestion = /\b(anyone|where|recommend|tonight|solo|first time|join|meet|going out|bar crawl|which bar|what club|how much)\b/.test(text);
  if (isQuestion && strength >= 5) return "reply";

  const isGuideTopic = /\b(price|cost|area|best|guide|itinerary|hidden gem|event|club|bar|massage|transport|bts|taxi|dating)\b/.test(text);
  if (isGuideTopic && strength >= 6) return "article";

  return "ignore";
}

function suggestedReply(signal: ThaiNightSignal): string {
  const text = signalText(signal);
  if (/\b(fee|late[- ]?entry|ticket|price|overcharge)\b/.test(text)) {
    return "That can happen at some Thailand nightlife events when ticket windows or final-entry rules are unclear. I would check the ticket terms, event page, and recent comments before going. I am collecting this kind of Thailand nightlife fee and safety info on ThaiNight too: https://thainight.co/intel";
  }

  if (/\b(solo|join|meet|going out|tonight)\b/.test(text)) {
    return "For solo nights, I would pick a busy area, check recent venue comments, and keep plans flexible because event details change fast. I am collecting practical Thailand nightlife updates and going-out info on ThaiNight too: https://thainight.co/tonight";
  }

  return "Useful context. Thailand nightlife changes quickly, so I would check recent comments, venue pages, and traveler reports before deciding. I am collecting practical nightlife intel on ThaiNight too: https://thainight.co/intel";
}

function sourceName(item: Pick<IntelItem, "subreddit" | "url">): string {
  if (item.subreddit && item.subreddit !== "search") return `r/${item.subreddit}`;

  try {
    return new URL(item.url).host.replace(/^www\./, "");
  } catch {
    return "source";
  }
}

function suggestedIntelReply(item: Pick<IntelItem, "title" | "venue_type">): string {
  const text = `${item.title} ${item.venue_type ?? ""}`.toLowerCase();

  if (/\b(fee|price|cost|cover|ticket|late[- ]?entry|overcharge)\b/.test(text)) {
    return "I would confirm the cover charge, final-entry time, and ticket terms before going. Some Thailand nightlife events change entry windows or add fees at the door. I’m collecting these fee/safety notes here too: https://thainight.co/intel";
  }

  if (/\b(solo|join|meet|friend|friends|going out|tonight|anyone)\b/.test(text)) {
    return "For a solo night, I’d start with one busy area, keep transport simple, and check recent comments before choosing the venue. I’m collecting current Thailand nightlife and going-out notes here too: https://thainight.co/tonight";
  }

  if (/\b(scam|unsafe|avoid|warning|police|raid|stolen|robbed)\b/.test(text)) {
    return "Thanks for the heads up. For Thailand nightlife I’d always verify recent comments, prices, and transport before going, especially if several travelers mention the same issue. I’m collecting warning notes here too: https://thainight.co/intel";
  }

  return "Useful note. Thailand nightlife changes quickly, so I’d check recent comments, source pages, and the exact area before making plans. I’m collecting current nightlife intel here too: https://thainight.co/intel";
}

function groupSignals(signals: ThaiNightSignal[]): Record<SignalAction, ThaiNightSignal[]> {
  const grouped: Record<SignalAction, ThaiNightSignal[]> = {
    reply: [],
    article: [],
    warning: [],
    ignore: [],
  };

  for (const signal of signals) {
    grouped[classifySignal(signal)].push(signal);
  }

  return grouped;
}

const REVIEW_BUCKET_META: Record<ReviewBucket, {
  label: string;
  helper: string;
  className: string;
}> = {
  event: {
    label: "Event",
    helper: "Put on Events after checking date, venue, and source.",
    className: "border-rose-400/25 bg-rose-500/10 text-rose-200",
  },
  offer: {
    label: "Offer",
    helper: "Put on Offers when there is a clear deal, guestlist, or happy hour.",
    className: "border-pink-400/25 bg-pink-500/10 text-pink-200",
  },
  warning: {
    label: "Warning",
    helper: "Use for fee, safety, scam, police, or avoid-area notes.",
    className: "border-red-400/25 bg-red-500/10 text-red-200",
  },
  solo: {
    label: "Solo traveler",
    helper: "Use for people asking who is going out or where to meet.",
    className: "border-fuchsia-400/25 bg-fuchsia-500/10 text-fuchsia-200",
  },
  opening: {
    label: "Opening",
    helper: "Use for new bars, launch nights, renovations, and reopenings.",
    className: "border-cyan-400/25 bg-cyan-500/10 text-cyan-200",
  },
  ignore: {
    label: "Ignore",
    helper: "Too vague, duplicate, expired, or not useful for travelers.",
    className: "border-zinc-700 bg-zinc-900/70 text-zinc-400",
  },
};

function queueText(item: IntelQueueItem): string {
  return [
    item.title,
    item.description ?? "",
    item.offer_label ?? "",
    item.source_type,
    item.city,
  ].join(" ").toLowerCase();
}

function sourceTypeLabel(value: string): string {
  if (value === "radarscout") return "ThaiNight Signals";
  if (value === "owner_upload") return "Owner upload";
  if (value === "community_upload") return "Community upload";
  return value;
}

const THAILAND_RELEVANCE_TERMS = [
  "thailand",
  "thai",
  "bangkok",
  "pattaya",
  "phuket",
  "chiang mai",
  "chiangmai",
  "patong",
  "bangla",
  "natai",
  "sukhumvit",
  "thonglor",
  "ekkamai",
  "silom",
  "rca",
  "nimman",
];

function isLikelyThailandItem(item: Pick<IntelItem, "title" | "city" | "url">): boolean {
  const text = [item.title, item.city ?? "", item.url].join(" ").toLowerCase();
  return THAILAND_RELEVANCE_TERMS.some((term) => text.includes(term));
}

function titleCase(value: string): string {
  return value
    .split(/\s+/)
    .map((word) => (word.length > 3 ? word[0]?.toUpperCase() + word.slice(1) : word))
    .join(" ");
}

function suggestedCardTitle(item: Pick<IntelItem, "title" | "city">): string {
  const sourceTrimmed = item.title.replace(/\s+-\s+[^-]+$/, "").replace(/^["“]|["”]$/g, "").trim();
  const city = item.city ? titleCase(item.city.replace(/-/g, " ")) : "";

  if (!city || sourceTrimmed.toLowerCase().includes(city.toLowerCase())) {
    return sourceTrimmed;
  }

  return `${city}: ${sourceTrimmed}`;
}

function classifyQueueItem(item: IntelQueueItem, defaultBucket: "event" | "offer"): ReviewBucket {
  const text = queueText(item);

  if (/\b(scam|overcharge|ripoff|late[- ]?entry|police|raid|unsafe|danger|warning|avoid|stolen|robbed)\b/.test(text)) {
    return "warning";
  }

  if (/\b(solo|meet|join|going out|anyone going|buddy|friend|together|date|dating)\b/.test(text)) {
    return "solo";
  }

  if (/\b(opening|grand opening|soft opening|new bar|new club|launch|reopen|reopening)\b/.test(text)) {
    return "opening";
  }

  if (/\b(happy hour|free entry|guestlist|guest list|discount|deal|offer|promo|buy 1|get 1|ladies night)\b/.test(text)) {
    return "offer";
  }

  if (/\b(event|tonight|ticket|lineup|dj|club night|party|festival|show|live music)\b/.test(text)) {
    return "event";
  }

  return defaultBucket;
}

function ReviewBucketBadge({ bucket }: { bucket: ReviewBucket }) {
  const meta = REVIEW_BUCKET_META[bucket];

  return (
    <div className={`rounded-xl border px-3 py-2 ${meta.className}`}>
      <p className="text-[11px] font-black uppercase tracking-widest">Suggested: {meta.label}</p>
      <p className="mt-1 text-xs leading-5 opacity-80">{meta.helper}</p>
    </div>
  );
}

// ─── Single update card ───────────────────────────────────────────────────────

function UpdateCard({
  update, onAction, loading,
}: {
  update: VenueUpdate;
  onAction: (id: string, action: "approve" | "reject") => void;
  loading: boolean;
}) {
  const typeClass = TYPE_COLORS[update.update_type] ?? TYPE_COLORS.new_info;

  return (
    <div className="p-4 rounded-xl bg-zinc-900/60 border border-zinc-800/60 space-y-3">
      <div className="flex items-start justify-between gap-3">
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 mb-1 flex-wrap">
            <span className={`px-2 py-0.5 rounded-full text-[10px] font-bold border ${typeClass}`}>
              {update.update_type.replace(/_/g, " ").toUpperCase()}
            </span>
            <a href={`/bangkok/bars/${update.venue_slug.split("-").slice(0,1)}/${update.venue_slug}`}
              className="text-xs text-amber-400 hover:text-amber-300 font-mono">
              {update.venue_slug}
            </a>
            <span className="text-[10px] text-zinc-600">
              {new Date(update.created_at).toLocaleString()}
            </span>
          </div>
          {update.content_text && (
            <p className="text-sm text-zinc-300 leading-relaxed">{update.content_text}</p>
          )}
          {update.submitter_name && (
            <p className="text-xs text-zinc-600 mt-1">
              From: {update.submitter_name}
              {update.submitter_email && ` <${update.submitter_email}>`}
            </p>
          )}
          {/* Score suggestions */}
          {(update.suggested_foreigner_friendly || update.suggested_late_night_reliability || update.suggested_price_transparency) && (
            <div className="flex gap-3 mt-2 text-[10px] text-zinc-500">
              {update.suggested_foreigner_friendly != null && <span>Foreigner: <strong className="text-white">{update.suggested_foreigner_friendly}</strong></span>}
              {update.suggested_late_night_reliability != null && <span>Reliability: <strong className="text-white">{update.suggested_late_night_reliability}</strong></span>}
              {update.suggested_price_transparency != null && <span>Transparency: <strong className="text-white">{update.suggested_price_transparency}</strong></span>}
            </div>
          )}
        </div>

        {/* Action buttons */}
        <div className="flex gap-2 shrink-0">
          <button
            onClick={() => onAction(update.id, "approve")}
            disabled={loading}
            className="flex items-center gap-1 px-3 py-1.5 rounded-lg bg-emerald-500/15 border border-emerald-500/25 text-emerald-400 hover:bg-emerald-500/25 text-xs font-bold transition-colors disabled:opacity-50"
          >
            <CheckCircle2 className="w-3.5 h-3.5" /> Approve
          </button>
          <button
            onClick={() => onAction(update.id, "reject")}
            disabled={loading}
            className="flex items-center gap-1 px-3 py-1.5 rounded-lg bg-red-500/10 border border-red-500/20 text-red-400 hover:bg-red-500/20 text-xs font-bold transition-colors disabled:opacity-50"
          >
            <XCircle className="w-3.5 h-3.5" /> Reject
          </button>
        </div>
      </div>
    </div>
  );
}

function MarketingQueueCard({ item }: { item: MarketingQueueItem }) {
  const meta = MARKETING_PLATFORM_META[item.platform];
  const Icon = meta.icon;

  return (
    <article className="rounded-xl border border-zinc-800 bg-zinc-950/70 p-4">
      <div className="flex items-start justify-between gap-3">
        <div>
          <span className={`inline-flex items-center gap-2 rounded-full border px-2.5 py-1 text-[10px] font-black uppercase tracking-wider ${meta.accent}`}>
            <Icon className="h-3.5 w-3.5" />
            {meta.label}
          </span>
          <h3 className="mt-3 text-sm font-black leading-5 text-white">{item.title}</h3>
        </div>
        <a
          href={item.searchUrl}
          target="_blank"
          rel="noreferrer"
          className="shrink-0 rounded-full border border-zinc-700 bg-zinc-900 p-2 text-zinc-400 transition hover:border-amber-300/50 hover:text-amber-200"
          title="Open search"
        >
          <ExternalLink className="h-3.5 w-3.5" />
        </a>
      </div>

      <p className="mt-3 text-xs leading-5 text-zinc-500">{item.intent}</p>
      <p className="mt-2 rounded-lg border border-zinc-800 bg-zinc-900/70 p-2 text-xs leading-5 text-zinc-400">
        {item.suggestedAction}
      </p>

      <details className="mt-3 rounded-lg border border-zinc-800 bg-black/25 p-2">
        <summary className="cursor-pointer text-[11px] font-black uppercase tracking-wider text-amber-300">
          Draft / checklist
        </summary>
        <p className="mt-2 whitespace-pre-wrap text-xs leading-5 text-zinc-400">{item.draft}</p>
        <button
          type="button"
          onClick={() => navigator.clipboard?.writeText(item.draft)}
          className="mt-2 inline-flex items-center gap-1 rounded-md border border-amber-500/20 bg-amber-500/10 px-2 py-1 text-[10px] font-black uppercase tracking-wider text-amber-300"
        >
          <Copy className="h-3 w-3" />
          Copy
        </button>
      </details>

      <a
        href={item.targetUrl}
        target="_blank"
        rel="noreferrer"
        className="mt-3 inline-flex items-center gap-1 text-xs font-bold text-zinc-500 hover:text-zinc-300"
      >
        Target page <ExternalLink className="h-3 w-3" />
      </a>
    </article>
  );
}

// ─── Main ─────────────────────────────────────────────────────────────────────

export default function AdminClient({
  updates: initialUpdates,
  stats,
  intelligence,
  flyers: initialFlyers,
  offers: initialOffers,
  topSignals,
  verifications: initialVerifications,
  adminKey,
}: Props) {
  const [updates, setUpdates] = useState(initialUpdates);
  const [flyers, setFlyers] = useState<IntelQueueItem[]>(initialFlyers);
  const [offers, setOffers] = useState<IntelQueueItem[]>(initialOffers);
  const [intelItems, setIntelItems] = useState<IntelItem[]>(intelligence);
  const [signalTitles, setSignalTitles] = useState<Record<string, string>>({});
  const [verifications, setVerifications] = useState<VerificationRequestItem[]>(initialVerifications);
  const [feedback, setFeedback] = useState<Record<string, "approved" | "rejected" | "error">>({});
  const [isPending, startTransition] = useTransition();

  async function handleAction(id: string, action: "approve" | "reject") {
    startTransition(async () => {
      try {
        const res = await fetch(`/api/submit-update?id=${id}&action=${action}`, {
          method: "PATCH",
          headers: { Authorization: `Bearer ${adminKey}` },
        });
        if (res.ok) {
          setFeedback(p => ({ ...p, [id]: action === "approve" ? "approved" : "rejected" }));
          // Remove from queue after 1.5s
          setTimeout(() => setUpdates(p => p.filter(u => u.id !== id)), 1500);
        } else {
          setFeedback(p => ({ ...p, [id]: "error" }));
        }
      } catch {
        setFeedback(p => ({ ...p, [id]: "error" }));
      }
    });
  }

  async function handleVerificationAction(id: string, action: "approve" | "reject") {
    startTransition(async () => {
      try {
        const res = await fetch(`/api/admin-verification?id=${id}&action=${action}`, {
          method: "PATCH",
          headers: { Authorization: `Bearer ${adminKey}` },
        });
        if (res.ok) {
          setVerifications((items) => items.filter((item) => item.id !== id));
        }
      } catch {
        // Keep request visible for retry.
      }
    });
  }

  async function handleIntelAction(
    id: string,
    type: "event" | "offer",
    action: "approve" | "reject",
    publishAs?: "event" | "offer"
  ) {
    startTransition(async () => {
      try {
        const query = new URLSearchParams({ id, type, action });
        if (publishAs) query.set("publishAs", publishAs);
        const res = await fetch(`/api/admin-intel?${query.toString()}`, {
          method: "PATCH",
          headers: { Authorization: `Bearer ${adminKey}` },
        });

        if (res.ok) {
          if (type === "event") {
            setFlyers((items) => items.filter((item) => item.id !== id));
          } else {
            setOffers((items) => items.filter((item) => item.id !== id));
          }
        }
      } catch {
        // Leave item in the queue so the admin can retry.
      }
    });
  }

  async function handleSignalCategory(id: string, category: "new_opening" | "safety" | "price" | "hide") {
    startTransition(async () => {
      try {
        const item = intelItems.find((signal) => signal.id === id);
        const title = signalTitles[id]?.trim() || (item ? suggestedCardTitle(item) : "");
        const res = await fetch(`/api/admin-signal?id=${id}&category=${category}`, {
          method: "PATCH",
          headers: {
            Authorization: `Bearer ${adminKey}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ title }),
        });

        if (res.ok) {
          setIntelItems((items) =>
            items.map((item) =>
              item.id === id
                ? {
                    ...item,
                    venue_type: category === "hide" ? null : category,
                    is_displayed: category !== "hide",
                  }
                : item
            )
          );
        }
      } catch {
        // Keep the item visible for retry.
      }
    });
  }

  const raidAlerts = intelItems.filter(i => i.is_raid_alert);
  const highValue  = intelItems.filter(i => !i.is_raid_alert && (i.thainight_value ?? 0) >= 0.72);
  const redditReplyQueue = topSignals.filter(isRedditSignal).slice(0, 20);
  const replyQueueSignals = redditReplyQueue.length ? redditReplyQueue : topSignals.slice(0, 20);
  const signalGroups = groupSignals(replyQueueSignals);

  return (
    <div className="min-h-screen bg-zinc-950 text-white">
      {/* Header */}
      <header className="border-b border-zinc-800/60 bg-zinc-950/90 backdrop-blur-md sticky top-0 z-40">
        <div className="max-w-6xl mx-auto px-4 h-14 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-7 h-7 rounded-lg bg-amber-500 flex items-center justify-center text-sm">🌙</div>
            <span className="font-black text-sm">THAI<span className="text-amber-400">NIGHT</span></span>
            <span className="px-2 py-0.5 rounded-md bg-zinc-800 border border-zinc-700 text-xs text-zinc-400 font-mono">Admin</span>
          </div>
          <button onClick={() => window.location.reload()} className="flex items-center gap-1.5 text-xs text-zinc-500 hover:text-white transition-colors">
            <RefreshCw className="w-3.5 h-3.5" /> Refresh
          </button>
        </div>
      </header>

      <div className="max-w-6xl mx-auto px-4 py-8 space-y-8">

        {/* Stats */}
        <div className="grid grid-cols-3 gap-4">
          {[
            { icon: Clock,        label: "Pending",  value: stats.pending,  color: "text-amber-400" },
            { icon: CheckCircle2, label: "Approved", value: stats.approved, color: "text-emerald-400" },
            { icon: XCircle,      label: "Rejected", value: stats.rejected, color: "text-red-400" },
          ].map(({ icon: Icon, label, value, color }) => (
            <div key={label} className="p-4 rounded-xl bg-zinc-900/60 border border-zinc-800/60 flex items-center gap-3">
              <Icon className={`w-5 h-5 ${color}`} />
              <div>
                <div className={`text-2xl font-black font-mono ${color}`}>{value}</div>
                <div className="text-xs text-zinc-500">{label}</div>
              </div>
            </div>
          ))}
        </div>

        <section className="rounded-2xl border border-zinc-800 bg-zinc-900/45 p-5">
          <div className="mb-5 flex flex-col gap-2 sm:flex-row sm:items-end sm:justify-between">
            <div>
              <p className="text-xs font-bold uppercase tracking-[0.25em] text-emerald-400">Marketing Queue</p>
              <h2 className="mt-1 text-xl font-black text-white">Daily manual publishing queue</h2>
              <p className="mt-1 max-w-3xl text-sm leading-6 text-zinc-500">
                Use this instead of forcing Reddit. Open the platform/search, pick 5-10 items, then manually post or answer with the draft adjusted to context.
              </p>
            </div>
            <span className="rounded-full border border-zinc-700 bg-zinc-950 px-3 py-1 text-xs font-bold text-zinc-400">
              {MARKETING_QUEUE_ITEMS.length} tasks
            </span>
          </div>

          <div className="grid gap-4 lg:grid-cols-2 xl:grid-cols-3">
            {MARKETING_QUEUE_ITEMS.map((item) => (
              <MarketingQueueCard key={item.id} item={item} />
            ))}
          </div>
        </section>

        <section className="rounded-2xl border border-zinc-800 bg-zinc-900/45 p-5">
          <div className="mb-5 flex flex-col gap-2 sm:flex-row sm:items-end sm:justify-between">
            <div>
              <p className="text-xs font-bold uppercase tracking-[0.25em] text-amber-400">ThaiNight Signals / Reddit backup</p>
              <h2 className="mt-1 text-xl font-black text-white">Listening queue, not primary promotion</h2>
              <p className="mt-1 text-sm text-zinc-500">
                Reddit is strict now, so use this mostly for listening, article ideas, warnings, and only very careful manual replies.
              </p>
            </div>
            <span className="rounded-full border border-zinc-700 bg-zinc-950 px-3 py-1 text-xs font-bold text-zinc-400">
              {replyQueueSignals.length} queued
            </span>
          </div>

          <div className="grid gap-4 xl:grid-cols-4">
            {(Object.keys(SIGNAL_ACTION_META) as SignalAction[]).map((action) => {
              const meta = SIGNAL_ACTION_META[action];
              const Icon = meta.icon;
              const items = signalGroups[action].slice(0, action === "ignore" ? 4 : 6);

              return (
                <div key={action} className="rounded-xl border border-zinc-800 bg-zinc-950/70">
                  <div className={`border-b px-4 py-3 ${meta.accent}`}>
                    <div className="flex items-center justify-between gap-2">
                      <h3 className="flex items-center gap-2 text-sm font-black">
                        <Icon className="h-4 w-4" />
                        {meta.title}
                      </h3>
                      <span className="rounded-full bg-black/25 px-2 py-0.5 text-xs font-mono">
                        {signalGroups[action].length}
                      </span>
                    </div>
                    <p className="mt-1 text-xs opacity-80">{meta.description}</p>
                  </div>

                  <div className="space-y-3 p-3">
                    {items.length === 0 && (
                      <p className="py-6 text-center text-xs text-zinc-700">Nothing in this bucket.</p>
                    )}
                    {items.map((signal) => (
                      <article key={signal.id} className="rounded-lg border border-zinc-800 bg-zinc-900/80 p-3">
                        <div className="flex items-start justify-between gap-2">
                          <h4 className="line-clamp-2 text-sm font-bold leading-5 text-white">
                            {signal.title}
                          </h4>
                          <span className="rounded-md bg-zinc-950 px-1.5 py-0.5 text-[10px] font-bold text-amber-300">
                            {signalStrength(signal)}
                          </span>
                        </div>
                        <p className="mt-2 line-clamp-3 text-xs leading-5 text-zinc-500">
                          {signal.summary || signal.snippet}
                        </p>
                        <div className="mt-3 flex flex-wrap gap-1.5 text-[10px] font-bold uppercase tracking-wider text-zinc-500">
                          {signal.location && <span className="rounded bg-zinc-800 px-1.5 py-0.5">{signal.location}</span>}
                          {signal.category && <span className="rounded bg-zinc-800 px-1.5 py-0.5">{signal.category}</span>}
                          {signal.opportunityType && <span className="rounded bg-zinc-800 px-1.5 py-0.5">{signal.opportunityType}</span>}
                        </div>
                        {action === "reply" && (
                          <details className="mt-3 rounded-lg border border-zinc-800 bg-zinc-950 p-2">
                            <summary className="cursor-pointer text-[11px] font-bold text-emerald-300">
                              Reply draft
                            </summary>
                            <p className="mt-2 text-xs leading-5 text-zinc-400">{suggestedReply(signal)}</p>
                            <button
                              type="button"
                              onClick={() => navigator.clipboard?.writeText(suggestedReply(signal))}
                              className="mt-2 inline-flex items-center gap-1 rounded-md border border-emerald-500/20 bg-emerald-500/10 px-2 py-1 text-[10px] font-black uppercase tracking-wider text-emerald-300"
                            >
                              <Copy className="h-3 w-3" />
                              Copy draft
                            </button>
                          </details>
                        )}
                        <a
                          href={signal.url}
                          target="_blank"
                          rel="noreferrer"
                          className="mt-3 inline-flex items-center gap-1 text-xs font-bold text-amber-300 hover:text-amber-200"
                        >
                          Open source <ExternalLink className="h-3 w-3" />
                        </a>
                      </article>
                    ))}
                  </div>
                </div>
              );
            })}
          </div>
        </section>

        <div className="grid lg:grid-cols-[1fr_380px] gap-8">

          {/* Approval queue */}
          <div>
            <h2 className="text-sm font-bold text-zinc-300 mb-4 flex items-center gap-2">
              <Clock className="w-4 h-4 text-amber-400" />
              Pending Updates ({updates.filter(u => !feedback[u.id]).length})
            </h2>

            {updates.length === 0 ? (
              <div className="flex flex-col items-center py-16 text-zinc-700">
                <CheckCircle2 className="w-10 h-10 mb-3 opacity-50" />
                <p>Queue is empty. All caught up.</p>
              </div>
            ) : (
              <div className="space-y-3">
                {updates.map(update => {
                  const status = feedback[update.id];
                  if (status) {
                    return (
                      <div key={update.id} className={`p-3 rounded-xl border text-xs font-semibold flex items-center gap-2
                        ${status === "approved" ? "bg-emerald-500/10 border-emerald-500/20 text-emerald-400" :
                          status === "rejected" ? "bg-red-500/10 border-red-500/20 text-red-400" :
                          "bg-zinc-800 border-zinc-700 text-zinc-400"}`}
                      >
                        {status === "approved" ? <CheckCircle2 className="w-3.5 h-3.5" /> : <XCircle className="w-3.5 h-3.5" />}
                        {update.venue_slug} — {status}
                      </div>
                    );
                  }
                  return (
                    <UpdateCard
                      key={update.id}
                      update={update}
                      onAction={handleAction}
                      loading={isPending}
                    />
                  );
                })}
              </div>
            )}
          </div>

          {/* Right panel: ThaiNight intel */}
          <div className="space-y-6">
            {/* Raid alerts */}
            {raidAlerts.length > 0 && (
              <div>
                <h2 className="text-sm font-bold text-red-400 mb-3 flex items-center gap-2">
                  <AlertTriangle className="w-4 h-4" /> Raid Alerts ({raidAlerts.length})
                </h2>
                <div className="space-y-2">
                  {raidAlerts.map(item => (
                    <a key={item.id} href={item.url} target="_blank" rel="noopener noreferrer"
                      className="flex gap-3 p-3 rounded-xl bg-red-500/8 border border-red-500/20 hover:border-red-500/40 transition-all group">
                      <AlertTriangle className="w-4 h-4 text-red-400 shrink-0 mt-0.5" />
                      <div className="flex-1 min-w-0">
                        <p className="text-xs text-white line-clamp-2 group-hover:text-red-300 transition-colors">{item.title}</p>
                        <p className="text-[10px] text-zinc-600 mt-1">r/{item.subreddit} · {item.city}</p>
                      </div>
                    </a>
                  ))}
                </div>
              </div>
            )}

            {/* High-value intel */}
            <div>
              <h2 className="text-sm font-bold text-zinc-300 mb-3 flex items-center gap-2">
                <TrendingUp className="w-4 h-4 text-emerald-400" /> Manual Reply / Intel Candidates
              </h2>
              <div className="space-y-2">
                {highValue.length === 0 && (
                  <p className="text-xs text-zinc-700 py-4 text-center">No high-value items in last 24h</p>
                )}
                {highValue.map(item => (
                  <div key={item.id}
                    className="rounded-xl border border-zinc-800/60 bg-zinc-900/60 p-3 transition-all">
                    {(() => {
                  const isRelevant = isLikelyThailandItem(item);
                      const draftTitle = signalTitles[item.id] ?? suggestedCardTitle(item);

                      return (
                        <>
                    <a href={item.url} target="_blank" rel="noopener noreferrer" className="flex gap-3 group">
                    <div className="shrink-0 mt-0.5">
                      <span className={`text-xs font-bold font-mono ${(item.thainight_value ?? 0) >= 0.9 ? "text-emerald-400" : "text-amber-400"}`}>
                        {((item.thainight_value ?? 0) * 10).toFixed(0)}
                      </span>
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-xs text-white line-clamp-2 group-hover:text-amber-300 transition-colors">{item.title}</p>
                      <div className="flex items-center gap-2 mt-1">
                        <span className="text-[10px] text-zinc-600">{sourceName(item)}</span>
                        {item.matched_venue_slug && (
                          <span className="text-[10px] text-emerald-500">→ {item.matched_venue_slug}</span>
                        )}
                      </div>
                      {!isRelevant && (
                        <p className="mt-2 rounded-lg border border-red-500/20 bg-red-500/10 px-2 py-1 text-[10px] font-bold uppercase tracking-wider text-red-300">
                          Check carefully: this may be outside Thailand.
                        </p>
                      )}
                    </div>
                    <ExternalLink className="w-3 h-3 text-zinc-700 group-hover:text-zinc-500 shrink-0 transition-colors" />
                    </a>
                    <div className="mt-3">
                      <label className="text-[10px] font-black uppercase tracking-widest text-zinc-500">
                        Website card title
                      </label>
                      <input
                        value={draftTitle}
                        onChange={(event) =>
                          setSignalTitles((titles) => ({ ...titles, [item.id]: event.target.value }))
                        }
                        className="mt-1 w-full rounded-lg border border-zinc-800 bg-zinc-950 px-2 py-2 text-xs font-semibold text-zinc-100 outline-none transition focus:border-amber-400/50"
                        placeholder="Short public title..."
                      />
                    </div>
                    <details className="mt-3 rounded-lg border border-zinc-800 bg-zinc-950 p-2">
                      <summary className="cursor-pointer text-[11px] font-bold text-emerald-300">
                        Manual reply draft
                      </summary>
                      <p className="mt-2 text-xs leading-5 text-zinc-400">{suggestedIntelReply(item)}</p>
                      <button
                        type="button"
                        onClick={() => navigator.clipboard?.writeText(suggestedIntelReply(item))}
                        className="mt-2 inline-flex items-center gap-1 rounded-md border border-emerald-500/20 bg-emerald-500/10 px-2 py-1 text-[10px] font-black uppercase tracking-wider text-emerald-300"
                      >
                        <Copy className="h-3 w-3" />
                        Copy draft
                      </button>
                    </details>
                    <div className="mt-3 flex flex-wrap gap-1.5">
                      {item.is_displayed && item.venue_type ? (
                        <span className="rounded-full border border-emerald-500/20 bg-emerald-500/10 px-2 py-1 text-[10px] font-black uppercase tracking-wider text-emerald-300">
                          Live: {item.venue_type.replace(/_/g, " ")}
                        </span>
                      ) : null}
                      {isRelevant && (
                        <>
                          <button
                            onClick={() => handleSignalCategory(item.id, "new_opening")}
                            disabled={isPending}
                            className="rounded-full border border-cyan-500/20 bg-cyan-500/10 px-2 py-1 text-[10px] font-black uppercase tracking-wider text-cyan-200 disabled:opacity-50"
                          >
                            Put in Openings
                          </button>
                          <button
                            onClick={() => handleSignalCategory(item.id, "safety")}
                            disabled={isPending}
                            className="rounded-full border border-red-500/20 bg-red-500/10 px-2 py-1 text-[10px] font-black uppercase tracking-wider text-red-200 disabled:opacity-50"
                          >
                            Put in Warnings
                          </button>
                          <button
                            onClick={() => handleSignalCategory(item.id, "price")}
                            disabled={isPending}
                            className="rounded-full border border-amber-500/20 bg-amber-500/10 px-2 py-1 text-[10px] font-black uppercase tracking-wider text-amber-200 disabled:opacity-50"
                          >
                            Put in Price Tips
                          </button>
                        </>
                      )}
                      <button
                        onClick={() => handleSignalCategory(item.id, "hide")}
                        disabled={isPending}
                        className="rounded-full border border-zinc-700 bg-zinc-950 px-2 py-1 text-[10px] font-black uppercase tracking-wider text-zinc-500 disabled:opacity-50"
                      >
                        Hide
                      </button>
                    </div>
                    </>
                      );
                    })()}
                  </div>
                ))}
              </div>
            </div>

            {/* Quick links */}
            <div className="p-4 rounded-xl bg-zinc-900/40 border border-zinc-800/60">
              <h3 className="text-xs font-bold text-zinc-500 uppercase tracking-widest mb-3">Quick Links</h3>
              <div className="space-y-2 text-xs">
                <a href="/api/venues" target="_blank" className="flex items-center gap-2 text-amber-400 hover:text-amber-300">
                  <ExternalLink className="w-3 h-3" /> /api/venues
                </a>
                <a href="/sitemap.xml" target="_blank" className="flex items-center gap-2 text-amber-400 hover:text-amber-300">
                  <ExternalLink className="w-3 h-3" /> /sitemap.xml
                </a>
                <a href="https://app.supabase.com" target="_blank" rel="noopener noreferrer" className="flex items-center gap-2 text-amber-400 hover:text-amber-300">
                  <ExternalLink className="w-3 h-3" /> Supabase Dashboard
                </a>
              </div>
            </div>
          </div>
        </div>

        <section className="grid gap-6 lg:grid-cols-2">
          <div>
            <h2 className="mb-4 flex items-center gap-2 text-sm font-bold text-zinc-300">
              <Clock className="h-4 w-4 text-rose-300" />
              Pending Event Flyers ({flyers.length})
            </h2>
            <div className="space-y-3">
              {flyers.length === 0 && (
                <p className="rounded-xl border border-zinc-800 bg-zinc-900/50 p-4 text-sm text-zinc-500">
                  No event flyers waiting for review.
                </p>
              )}
              {flyers.map((item) => (
                <div key={item.id} className="rounded-xl border border-zinc-800 bg-zinc-900/60 p-4">
                  <div className="grid gap-4 sm:grid-cols-[112px_1fr_auto]">
                    <div className="relative overflow-hidden rounded-2xl border border-zinc-800 bg-zinc-950">
                      {item.flyer_image_url ? (
                        <img
                          src={item.flyer_image_url}
                          alt={item.title}
                          className="h-32 w-full object-cover sm:h-full"
                        />
                      ) : (
                        <div className="flex h-32 items-center justify-center bg-zinc-950 text-xs font-bold uppercase tracking-widest text-zinc-600 sm:h-full">
                          No image
                        </div>
                      )}
                    </div>
                    <div className="min-w-0">
                      <p className="text-xs font-semibold uppercase tracking-widest text-rose-300">
                        {item.city} · {sourceTypeLabel(item.source_type)}
                      </p>
                      <h3 className="mt-2 text-base font-black text-white">{item.title}</h3>
                      {item.description && <p className="mt-2 text-sm leading-6 text-zinc-400">{item.description}</p>}
                      <div className="mt-3">
                        <ReviewBucketBadge bucket={classifyQueueItem(item, "event")} />
                      </div>
                    </div>
                    {(item.flyer_image_url || item.source_url) && (
                      <a
                        href={item.source_url ?? item.flyer_image_url ?? "#"}
                        target="_blank"
                        rel="noreferrer"
                        className="text-xs font-bold text-rose-200 hover:text-rose-100"
                      >
                        View
                      </a>
                    )}
                  </div>
                  <div className="mt-4 flex flex-wrap gap-2">
                    <button
                      onClick={() => handleIntelAction(item.id, "event", "approve", "event")}
                      className="rounded-lg border border-emerald-500/25 bg-emerald-500/15 px-3 py-1.5 text-xs font-bold text-emerald-300"
                    >
                      Approve as Event
                    </button>
                    <button
                      onClick={() => handleIntelAction(item.id, "event", "approve", "offer")}
                      className="rounded-lg border border-pink-500/25 bg-pink-500/15 px-3 py-1.5 text-xs font-bold text-pink-200"
                    >
                      Approve as Offer
                    </button>
                    <button
                      onClick={() => handleIntelAction(item.id, "event", "reject")}
                      className="rounded-lg border border-red-500/25 bg-red-500/10 px-3 py-1.5 text-xs font-bold text-red-300"
                    >
                      Ignore
                    </button>
                  </div>
                </div>
              ))}
            </div>
          </div>

          <div>
            <h2 className="mb-4 flex items-center gap-2 text-sm font-bold text-zinc-300">
              <Clock className="h-4 w-4 text-pink-300" />
              Pending Offers ({offers.length})
            </h2>
            <div className="space-y-3">
              {offers.length === 0 && (
                <p className="rounded-xl border border-zinc-800 bg-zinc-900/50 p-4 text-sm text-zinc-500">
                  No offers waiting for review.
                </p>
              )}
              {offers.map((item) => (
                <div key={item.id} className="rounded-xl border border-zinc-800 bg-zinc-900/60 p-4">
                  <div className="grid gap-4 sm:grid-cols-[112px_1fr_auto]">
                    <div className="relative overflow-hidden rounded-2xl border border-zinc-800 bg-zinc-950">
                      {item.image_url ? (
                        <img
                          src={item.image_url}
                          alt={item.title}
                          className="h-32 w-full object-cover sm:h-full"
                        />
                      ) : (
                        <div className="flex h-32 items-center justify-center bg-zinc-950 text-xs font-bold uppercase tracking-widest text-zinc-600 sm:h-full">
                          No image
                        </div>
                      )}
                    </div>
                    <div className="min-w-0">
                      <p className="text-xs font-semibold uppercase tracking-widest text-pink-300">
                        {item.city} · {item.offer_label ?? sourceTypeLabel(item.source_type)}
                      </p>
                      <h3 className="mt-2 text-base font-black text-white">{item.title}</h3>
                      {item.description && <p className="mt-2 text-sm leading-6 text-zinc-400">{item.description}</p>}
                      <div className="mt-3">
                        <ReviewBucketBadge bucket={classifyQueueItem(item, "offer")} />
                      </div>
                    </div>
                    {(item.image_url || item.source_url) && (
                      <a
                        href={item.source_url ?? item.image_url ?? "#"}
                        target="_blank"
                        rel="noreferrer"
                        className="text-xs font-bold text-pink-200 hover:text-pink-100"
                      >
                        View
                      </a>
                    )}
                  </div>
                  <div className="mt-4 flex flex-wrap gap-2">
                    <button
                      onClick={() => handleIntelAction(item.id, "offer", "approve", "event")}
                      className="rounded-lg border border-rose-500/25 bg-rose-500/15 px-3 py-1.5 text-xs font-bold text-rose-200"
                    >
                      Approve as Event
                    </button>
                    <button
                      onClick={() => handleIntelAction(item.id, "offer", "approve", "offer")}
                      className="rounded-lg border border-emerald-500/25 bg-emerald-500/15 px-3 py-1.5 text-xs font-bold text-emerald-300"
                    >
                      Approve as Offer
                    </button>
                    <button
                      onClick={() => handleIntelAction(item.id, "offer", "reject")}
                      className="rounded-lg border border-red-500/25 bg-red-500/10 px-3 py-1.5 text-xs font-bold text-red-300"
                    >
                      Ignore
                    </button>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section>
          <h2 className="mb-4 flex items-center gap-2 text-sm font-bold text-zinc-300">
            <Clock className="h-4 w-4 text-sky-300" />
            Pending Instagram Verification ({verifications.length})
          </h2>
          <div className="grid gap-3 lg:grid-cols-2">
            {verifications.length === 0 && (
              <p className="rounded-xl border border-zinc-800 bg-zinc-900/50 p-4 text-sm text-zinc-500">
                No verification requests waiting for review.
              </p>
            )}
            {verifications.map((item) => (
              <div key={item.id} className="rounded-xl border border-zinc-800 bg-zinc-900/60 p-4">
                <p className="text-xs font-semibold uppercase tracking-widest text-sky-300">Instagram request</p>
                <h3 className="mt-2 text-base font-black text-white">@{item.submitted_handle}</h3>
                {item.note && <p className="mt-2 text-sm leading-6 text-zinc-400">{item.note}</p>}
                {item.proof_url && (
                  <a href={item.proof_url} target="_blank" rel="noreferrer" className="mt-3 inline-flex text-xs font-bold text-sky-200 hover:text-sky-100">
                    View proof
                  </a>
                )}
                <div className="mt-4 flex gap-2">
                  <button
                    onClick={() => handleVerificationAction(item.id, "approve")}
                    className="rounded-lg border border-emerald-500/25 bg-emerald-500/15 px-3 py-1.5 text-xs font-bold text-emerald-300"
                  >
                    Approve
                  </button>
                  <button
                    onClick={() => handleVerificationAction(item.id, "reject")}
                    className="rounded-lg border border-red-500/25 bg-red-500/10 px-3 py-1.5 text-xs font-bold text-red-300"
                  >
                    Reject
                  </button>
                </div>
              </div>
            ))}
          </div>
        </section>
      </div>
    </div>
  );
}
