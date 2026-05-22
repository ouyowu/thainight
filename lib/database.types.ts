// lib/database.types.ts
// Context: Bangkok Nightlife SEO Hub | Current Date: May 2026 | Priority: Freshness & scorable venue data
// Auto-kept in sync with 001_schema.sql
// In production, regenerate via: npx supabase gen types typescript --project-id YOUR_ID > lib/database.types.ts

export type Json = string | number | boolean | null | { [key: string]: Json } | Json[];

export type VenueCategory =
  | "cocktail-bar"
  | "rooftop-bar"
  | "nightclub"
  | "dive-bar"
  | "wine-bar"
  | "sports-bar"
  | "karaoke"
  | "jazz-bar"
  | "hotel-bar"
  | "beach-club";

export type PriceRange = "฿" | "฿฿" | "฿฿฿" | "฿฿฿฿";

export type UpdateType =
  | "score_correction"
  | "hours_change"
  | "closure_report"
  | "temporary_closure"
  | "price_change"
  | "new_info"
  | "raid_alert"
  | "reopened"
  | "photo_submission";

export type UpdateStatus = "pending" | "approved" | "rejected" | "auto_applied";
export type VenueImportSourceType =
  | "google_places"
  | "official_site"
  | "instagram"
  | "tourism_directory"
  | "manual_research";
export type VenueImportStatus =
  | "new"
  | "needs_review"
  | "approved"
  | "rejected"
  | "imported";

// ─── Database Row Types ───────────────────────────────────────────────────────

export interface AreaRow extends Record<string, unknown> {
  id: string;
  slug: string;
  name: string;
  city: string;
  description: string | null;
  latitude: number | null;
  longitude: number | null;
  created_at: string;
}

export interface VenueRow extends Record<string, unknown> {
  // Define venue interface with nightlife scores, SEO freshness fields, and generated DB score.
  id: string;
  slug: string;
  name: string;
  city: string;
  area_id: string | null;
  area_slug: string;
  category: VenueCategory;
  tagline: string | null;

  // Location
  address: string | null;
  latitude: number | null;
  longitude: number | null;
  google_maps_url: string | null;
  google_place_id: string | null;

  // Contact
  phone: string | null;
  website: string | null;
  instagram_handle: string | null;
  line_id: string | null;

  // Operations
  opening_hours: string | null;
  opening_hours_json: Json | null;
  price_range: PriceRange | null;
  cover_charge: number | null;
  dress_code: string | null;
  reservation_required: boolean;
  accepts_walk_in: boolean;

  // Media
  hero_image_url: string | null;
  image_urls: Json;

  // Scores (all nullable — not every venue has been fully scored yet)
  score_foreigner_friendly: number | null;
  score_solo_traveler: number | null;
  score_date_night: number | null;
  score_music_quality: number | null;
  score_tourist_trap_risk: number | null;
  score_price_transparency: number | null;
  score_walkability: number | null;
  score_late_night_reliability: number | null;
  overall_score: number | null; // GENERATED ALWAYS — read only

  // SEO
  insider_tip: string | null;
  tags: string[];
  seo_title_override: string | null;
  seo_description: string | null;

  // Status
  is_published: boolean;
  is_permanently_closed: boolean;
  temporarily_closed: boolean;
  social_enabled: boolean;
  is_trending: boolean;
  page_views: number;

  // Freshness
  last_verified_at: string | null;
  verified_by: string | null;

  // Audit
  created_at: string;
  updated_at: string;
}

export interface VenueUpdateRow extends Record<string, unknown> {
  id: string;
  venue_id: string;
  venue_slug: string;
  update_type: UpdateType;
  content_text: string | null;
  content_json: Json;
  suggested_foreigner_friendly: number | null;
  suggested_late_night_reliability: number | null;
  suggested_price_transparency: number | null;
  submitter_name: string | null;
  submitter_email: string | null;
  submitter_ip: string | null;
  submitter_user_agent: string | null;
  status: UpdateStatus;
  reviewed_by: string | null;
  reviewed_at: string | null;
  admin_notes: string | null;
  created_at: string;
}

export interface NewsletterSubscriberRow extends Record<string, unknown> {
  id: string;
  email: string;
  source: string;
  subscribed_at: string;
  created_at: string;
}

export interface IntelligenceFeedRow extends Record<string, unknown> {
  id: string;
  radarscout_id: string;
  source: string;
  subreddit: string | null;
  title: string;
  url: string;
  body_snippet: string | null;
  author: string | null;
  posted_at: string | null;
  reddit_score: number | null;
  comment_count: number | null;
  city: string | null;
  area: string | null;
  venue_type: string | null;
  travel_intent: number | null;
  credibility: number | null;
  thainight_value: number | null;
  sentiment: string | null;
  extracted_venues: string[];
  matched_venue_slug: string | null;
  matched_confidence: number | null;
  is_raid_alert: boolean;
  is_displayed: boolean;
  received_at: string;
  telegram_sent_at: string | null;
}

export type ModerationStatus = "pending" | "approved" | "rejected";
export type IntelligenceSourceType =
  | "manual"
  | "radarscout"
  | "owner_upload"
  | "community_upload";

export interface EventFlyerRow extends Record<string, unknown> {
  id: string;
  venue_id: string | null;
  venue_slug: string | null;
  city: string;
  title: string;
  description: string | null;
  event_date: string | null;
  flyer_image_url: string | null;
  source_url: string | null;
  source_type: IntelligenceSourceType;
  status: ModerationStatus;
  is_featured: boolean;
  submitter_name: string | null;
  submitter_email: string | null;
  admin_notes: string | null;
  reviewed_at: string | null;
  created_at: string;
  updated_at: string;
}

export interface VenueOfferRow extends Record<string, unknown> {
  id: string;
  venue_id: string | null;
  venue_slug: string | null;
  city: string;
  title: string;
  description: string | null;
  offer_label: string | null;
  valid_from: string | null;
  valid_until: string | null;
  image_url: string | null;
  source_url: string | null;
  source_type: IntelligenceSourceType;
  status: ModerationStatus;
  is_featured: boolean;
  submitter_name: string | null;
  submitter_email: string | null;
  admin_notes: string | null;
  reviewed_at: string | null;
  created_at: string;
  updated_at: string;
}

export type VenueMemberReviewRecommendation = "thumbs_up" | "tomato";

export interface VenueMemberReviewRow extends Record<string, unknown> {
  id: string;
  venue_id: string;
  user_id: string;
  display_name: string | null;
  rating: number;
  body: string;
  recommendation: VenueMemberReviewRecommendation;
  created_at: string;
  updated_at: string;
}

export interface VenueImportCandidateRow extends Record<string, unknown> {
  id: string;
  city: string;
  area_slug: string | null;
  source_type: VenueImportSourceType;
  source_name: string;
  source_url: string | null;
  source_place_id: string | null;
  name: string;
  slug: string | null;
  category: string | null;
  address: string | null;
  latitude: number | null;
  longitude: number | null;
  phone: string | null;
  website: string | null;
  instagram_handle: string | null;
  opening_hours: string | null;
  price_range: string | null;
  tags: string[];
  raw_payload: Json;
  confidence_score: number | null;
  dedupe_key: string | null;
  status: VenueImportStatus;
  reviewed_by: string | null;
  reviewed_at: string | null;
  created_at: string;
  updated_at: string;
}

export interface ProfileRow extends Record<string, unknown> {
  id: string;
  display_name: string | null;
  bio: string | null;
  ig_handle: string | null;
  interests: string[];
  current_city: string | null;
  traveler_type: string | null;
  avatar_seed: string | null;
  home_country: string | null;
  languages_spoken: string[];
  visit_window_start: string | null;
  visit_window_end: string | null;
  verification_status: "unverified" | "email_verified" | "instagram_verified" | "manual_verified";
  verification_note: string | null;
  persona_tags: string[];
  membership_tier: "free" | "vip";
  created_at: string;
  updated_at: string;
}

export interface VenueSocialInterestRow extends Record<string, unknown> {
  id: string;
  venue_id: string;
  user_id: string;
  interest_date: string;
  created_at: string;
}

export interface VenueFlashMeetupRow extends Record<string, unknown> {
  id: string;
  venue_id: string;
  creator_id: string;
  title: string;
  note: string;
  meetup_time: string;
  seats_total: number;
  seats_open: number;
  budget_label: PriceRange;
  audience_note: string | null;
  expires_at: string;
  status: "open" | "closed" | "expired";
  is_featured: boolean;
  created_at: string;
}

export interface VenueMeetupJoinRequestRow extends Record<string, unknown> {
  id: string;
  meetup_id: string;
  venue_id: string;
  requester_id: string;
  message: string;
  status: "pending" | "approved" | "rejected";
  created_at: string;
  reviewed_at: string | null;
}

export interface SocialDailyActionRow extends Record<string, unknown> {
  id: string;
  user_id: string;
  action_date: string;
  action_type: "count_me_in" | "create_meetup" | "request_join" | "approve_join";
  created_at: string;
}

export interface ProfileVerificationRequestRow extends Record<string, unknown> {
  id: string;
  user_id: string;
  request_type: "instagram";
  submitted_handle: string;
  proof_url: string | null;
  note: string | null;
  status: "pending" | "approved" | "rejected";
  created_at: string;
  reviewed_at: string | null;
}

export type AreaInsert = Omit<AreaRow, "id" | "created_at"> & {
  id?: string;
  created_at?: string;
};

export type AreaUpdate = Partial<Omit<AreaRow, "id" | "created_at">>;

export type VenueInsert = Omit<
  VenueRow,
  "id" | "created_at" | "updated_at" | "overall_score"
> & {
  id?: string;
  created_at?: string;
  updated_at?: string;
};

export type VenueUpdate = Partial<
  Omit<VenueRow, "id" | "created_at" | "overall_score">
>;

export type VenueUpdateInsert = Record<string, unknown> & {
  id?: string;
  venue_id: string;
  venue_slug: string;
  update_type: UpdateType;
  content_text?: string | null;
  content_json?: Json;
  suggested_foreigner_friendly?: number | null;
  suggested_late_night_reliability?: number | null;
  suggested_price_transparency?: number | null;
  submitter_name?: string | null;
  submitter_email?: string | null;
  submitter_ip?: string | null;
  submitter_user_agent?: string | null;
  status?: UpdateStatus;
  reviewed_by?: string | null;
  reviewed_at?: string | null;
  admin_notes?: string | null;
  created_at?: string;
};

export type VenueUpdatePatch = Partial<Omit<VenueUpdateRow, "id" | "created_at">>;

export type NewsletterSubscriberInsert = Record<string, unknown> & {
  id?: string;
  email: string;
  source?: string;
  subscribed_at?: string;
  created_at?: string;
};

export type NewsletterSubscriberUpdate = Partial<
  Omit<NewsletterSubscriberRow, "id" | "created_at">
>;

export type IntelligenceFeedInsert = Record<string, unknown> & {
  id?: string;
  radarscout_id: string;
  source?: string;
  subreddit?: string | null;
  title: string;
  url: string;
  body_snippet?: string | null;
  author?: string | null;
  posted_at?: string | null;
  reddit_score?: number | null;
  comment_count?: number | null;
  city?: string | null;
  area?: string | null;
  venue_type?: string | null;
  travel_intent?: number | null;
  credibility?: number | null;
  thainight_value?: number | null;
  sentiment?: string | null;
  extracted_venues?: string[];
  matched_venue_slug?: string | null;
  matched_confidence?: number | null;
  is_raid_alert?: boolean;
  is_displayed?: boolean;
  received_at?: string;
  telegram_sent_at?: string | null;
};

export type IntelligenceFeedUpdate = Partial<
  Omit<IntelligenceFeedRow, "id" | "radarscout_id">
>;

export type EventFlyerInsert = Record<string, unknown> & {
  id?: string;
  venue_id?: string | null;
  venue_slug?: string | null;
  city: string;
  title: string;
  description?: string | null;
  event_date?: string | null;
  flyer_image_url?: string | null;
  source_url?: string | null;
  source_type?: IntelligenceSourceType;
  status?: ModerationStatus;
  is_featured?: boolean;
  submitter_name?: string | null;
  submitter_email?: string | null;
  admin_notes?: string | null;
  reviewed_at?: string | null;
  created_at?: string;
  updated_at?: string;
};

export type EventFlyerUpdate = Partial<
  Omit<EventFlyerRow, "id" | "created_at">
>;

export type VenueOfferInsert = Record<string, unknown> & {
  id?: string;
  venue_id?: string | null;
  venue_slug?: string | null;
  city: string;
  title: string;
  description?: string | null;
  offer_label?: string | null;
  valid_from?: string | null;
  valid_until?: string | null;
  image_url?: string | null;
  source_url?: string | null;
  source_type?: IntelligenceSourceType;
  status?: ModerationStatus;
  is_featured?: boolean;
  submitter_name?: string | null;
  submitter_email?: string | null;
  admin_notes?: string | null;
  reviewed_at?: string | null;
  created_at?: string;
  updated_at?: string;
};

export type VenueOfferUpdate = Partial<
  Omit<VenueOfferRow, "id" | "created_at">
>;

export type VenueImportCandidateInsert = Record<string, unknown> & {
  id?: string;
  city: string;
  area_slug?: string | null;
  source_type: VenueImportSourceType;
  source_name: string;
  source_url?: string | null;
  source_place_id?: string | null;
  name: string;
  slug?: string | null;
  category?: string | null;
  address?: string | null;
  latitude?: number | null;
  longitude?: number | null;
  phone?: string | null;
  website?: string | null;
  instagram_handle?: string | null;
  opening_hours?: string | null;
  price_range?: string | null;
  tags?: string[];
  raw_payload?: Json;
  confidence_score?: number | null;
  dedupe_key?: string | null;
  status?: VenueImportStatus;
  reviewed_by?: string | null;
  reviewed_at?: string | null;
  created_at?: string;
  updated_at?: string;
};

export type VenueImportCandidateUpdate = Partial<
  Omit<VenueImportCandidateRow, "id" | "created_at">
>;

export type ProfileInsert = Partial<Omit<ProfileRow, "id" | "created_at" | "updated_at">> & {
  id: string;
};
export type ProfileUpdate = Partial<Omit<ProfileRow, "id" | "created_at">>;

export type VenueSocialInterestInsert = Record<string, unknown> & {
  id?: string;
  venue_id: string;
  user_id: string;
  interest_date?: string;
  created_at?: string;
};

export type VenueFlashMeetupInsert = Record<string, unknown> & {
  id?: string;
  venue_id: string;
  creator_id: string;
  title: string;
  note: string;
  meetup_time: string;
  seats_total: number;
  seats_open: number;
  budget_label: PriceRange;
  audience_note?: string | null;
  expires_at?: string;
  status?: "open" | "closed" | "expired";
  is_featured?: boolean;
  created_at?: string;
};

export type VenueMeetupJoinRequestInsert = Record<string, unknown> & {
  id?: string;
  meetup_id: string;
  venue_id: string;
  requester_id: string;
  message: string;
  status?: "pending" | "approved" | "rejected";
  created_at?: string;
  reviewed_at?: string | null;
};

export type SocialDailyActionInsert = Record<string, unknown> & {
  id?: string;
  user_id: string;
  action_date?: string;
  action_type: "count_me_in" | "create_meetup" | "request_join" | "approve_join";
  created_at?: string;
};

export type ProfileVerificationRequestInsert = Record<string, unknown> & {
  id?: string;
  user_id: string;
  request_type: "instagram";
  submitted_handle: string;
  proof_url?: string | null;
  note?: string | null;
  status?: "pending" | "approved" | "rejected";
  created_at?: string;
  reviewed_at?: string | null;
};

export type VenueMemberReviewInsert = Record<string, unknown> & {
  id?: string;
  venue_id: string;
  user_id?: string;
  display_name?: string | null;
  rating: number;
  body: string;
  recommendation: VenueMemberReviewRecommendation;
  created_at?: string;
  updated_at?: string;
};

export type VenueMemberReviewUpdate = Partial<
  Omit<VenueMemberReviewRow, "id" | "venue_id" | "user_id" | "created_at">
>;

// ─── View Type (venue_cards) ──────────────────────────────────────────────────
// Matches the `venue_cards` SQL VIEW — use this for list pages.

export interface VenueCard extends Record<string, unknown> {
  id: string;
  slug: string;
  name: string;
  city: string;
  area_slug: string;
  area_name: string | null;
  category: VenueCategory;
  tagline: string | null;
  hero_image_url: string | null;
  price_range: PriceRange | null;
  opening_hours: string | null;
  tags: string[];
  overall_score: number | null;
  score_foreigner_friendly: number | null;
  score_late_night_reliability: number | null;
  score_price_transparency: number | null;
  score_tourist_trap_risk: number | null;
  last_verified_at: string | null;
  temporarily_closed: boolean;
  is_verified_this_week: boolean; // computed in SQL VIEW
  days_since_verified: number | null;
}

// ─── Supabase Database Shape (for createClient<Database>()) ──────────────────

export interface Database {
  public: {
    Tables: {
      areas: {
        Row: AreaRow;
        Insert: AreaInsert;
        Update: AreaUpdate;
        Relationships: [];
      };
      venues: {
        Row: VenueRow;
        Insert: VenueInsert;
        Update: VenueUpdate;
        Relationships: [];
      };
      venue_updates: {
        Row: VenueUpdateRow;
        Insert: VenueUpdateInsert;
        Update: VenueUpdatePatch;
        Relationships: [];
      };
      newsletter_subscribers: {
        Row: NewsletterSubscriberRow;
        Insert: NewsletterSubscriberInsert;
        Update: NewsletterSubscriberUpdate;
        Relationships: [];
      };
      intelligence_feed: {
        Row: IntelligenceFeedRow;
        Insert: IntelligenceFeedInsert;
        Update: IntelligenceFeedUpdate;
        Relationships: [];
      };
      event_flyers: {
        Row: EventFlyerRow;
        Insert: EventFlyerInsert;
        Update: EventFlyerUpdate;
        Relationships: [];
      };
      venue_offers: {
        Row: VenueOfferRow;
        Insert: VenueOfferInsert;
        Update: VenueOfferUpdate;
        Relationships: [];
      };
      venue_import_candidates: {
        Row: VenueImportCandidateRow;
        Insert: VenueImportCandidateInsert;
        Update: VenueImportCandidateUpdate;
        Relationships: [];
      };
      venue_member_reviews: {
        Row: VenueMemberReviewRow;
        Insert: VenueMemberReviewInsert;
        Update: VenueMemberReviewUpdate;
        Relationships: [];
      };
      profiles: {
        Row: ProfileRow;
        Insert: ProfileInsert;
        Update: ProfileUpdate;
        Relationships: [];
      };
      venue_social_interests: {
        Row: VenueSocialInterestRow;
        Insert: VenueSocialInterestInsert;
        Update: Partial<VenueSocialInterestRow>;
        Relationships: [];
      };
      venue_flash_meetups: {
        Row: VenueFlashMeetupRow;
        Insert: VenueFlashMeetupInsert;
        Update: Partial<Omit<VenueFlashMeetupRow, "id" | "venue_id" | "creator_id" | "created_at">>;
        Relationships: [];
      };
      venue_meetup_join_requests: {
        Row: VenueMeetupJoinRequestRow;
        Insert: VenueMeetupJoinRequestInsert;
        Update: Partial<Omit<VenueMeetupJoinRequestRow, "id" | "meetup_id" | "venue_id" | "requester_id" | "created_at">>;
        Relationships: [];
      };
      social_daily_actions: {
        Row: SocialDailyActionRow;
        Insert: SocialDailyActionInsert;
        Update: Partial<SocialDailyActionRow>;
        Relationships: [];
      };
      profile_verification_requests: {
        Row: ProfileVerificationRequestRow;
        Insert: ProfileVerificationRequestInsert;
        Update: Partial<Omit<ProfileVerificationRequestRow, "id" | "created_at">>;
        Relationships: [];
      };
    };
    Views: {
      venue_cards: {
        Row: VenueCard;
        Relationships: [];
      };
    };
    Functions: Record<string, never>;
    Enums: Record<string, never>;
    CompositeTypes: Record<string, never>;
  };
}
