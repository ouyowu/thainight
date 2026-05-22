-- ThaiNight verification workflow
-- Context: May 2026 | Manual Instagram verification intake.

create table if not exists public.profile_verification_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  request_type text not null check (request_type in ('instagram')),
  submitted_handle text not null,
  proof_url text,
  note text,
  status text not null default 'pending'
    check (status in ('pending', 'approved', 'rejected')),
  created_at timestamptz not null default now(),
  reviewed_at timestamptz
);

create index if not exists profile_verification_requests_user_idx
  on public.profile_verification_requests(user_id, created_at desc);

alter table public.profile_verification_requests enable row level security;

drop policy if exists "verification_requests_owner_read" on public.profile_verification_requests;
create policy "verification_requests_owner_read"
  on public.profile_verification_requests
  for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists "verification_requests_owner_insert" on public.profile_verification_requests;
create policy "verification_requests_owner_insert"
  on public.profile_verification_requests
  for insert
  to authenticated
  with check (auth.uid() = user_id);
