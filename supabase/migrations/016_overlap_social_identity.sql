-- ThaiNight overlap social upgrade
-- Context: May 2026 | Add richer traveler identity and overlap-ready social signals.

alter table public.profiles
  add column if not exists home_country text,
  add column if not exists languages_spoken text[] not null default '{}',
  add column if not exists visit_window_start date,
  add column if not exists visit_window_end date,
  add column if not exists verification_status text not null default 'unverified'
    check (verification_status in ('unverified', 'email_verified', 'instagram_verified', 'manual_verified')),
  add column if not exists verification_note text,
  add column if not exists persona_tags text[] not null default '{}';

create index if not exists profiles_visit_window_idx
  on public.profiles (current_city, visit_window_start, visit_window_end);

create index if not exists profiles_verification_status_idx
  on public.profiles (verification_status);
