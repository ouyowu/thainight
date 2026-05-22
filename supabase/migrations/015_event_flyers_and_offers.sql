-- Context: ThaiNight nightlife intelligence pipeline | Current Date: May 2026
-- Create moderated event flyer and venue offer tables for homepage intelligence shelves.

create table if not exists public.event_flyers (
  id uuid primary key default gen_random_uuid(),
  venue_id uuid references public.venues(id) on delete set null,
  venue_slug text,
  city text not null,
  title text not null,
  description text,
  event_date timestamptz,
  flyer_image_url text,
  source_url text,
  source_type text not null default 'manual'
    check (source_type in ('manual', 'radarscout', 'owner_upload', 'community_upload')),
  status text not null default 'pending'
    check (status in ('pending', 'approved', 'rejected')),
  is_featured boolean not null default false,
  submitter_name text,
  submitter_email text,
  admin_notes text,
  reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists event_flyers_status_created_idx
  on public.event_flyers(status, created_at desc);

create index if not exists event_flyers_city_date_idx
  on public.event_flyers(city, event_date desc);

create table if not exists public.venue_offers (
  id uuid primary key default gen_random_uuid(),
  venue_id uuid references public.venues(id) on delete set null,
  venue_slug text,
  city text not null,
  title text not null,
  description text,
  offer_label text,
  valid_from timestamptz,
  valid_until timestamptz,
  image_url text,
  source_url text,
  source_type text not null default 'manual'
    check (source_type in ('manual', 'radarscout', 'owner_upload', 'community_upload')),
  status text not null default 'pending'
    check (status in ('pending', 'approved', 'rejected')),
  is_featured boolean not null default false,
  submitter_name text,
  submitter_email text,
  admin_notes text,
  reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists venue_offers_status_created_idx
  on public.venue_offers(status, created_at desc);

create index if not exists venue_offers_city_window_idx
  on public.venue_offers(city, valid_until desc);

alter table public.event_flyers enable row level security;
alter table public.venue_offers enable row level security;

drop policy if exists "Approved event flyers are public" on public.event_flyers;
create policy "Approved event flyers are public"
  on public.event_flyers
  for select
  using (status = 'approved');

drop policy if exists "Approved venue offers are public" on public.venue_offers;
create policy "Approved venue offers are public"
  on public.venue_offers
  for select
  using (status = 'approved');
