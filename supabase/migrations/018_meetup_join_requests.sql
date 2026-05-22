-- ThaiNight meetup join approvals
-- Context: May 2026 | Instagram-verified users can request to join Flash Meetups.

alter table public.social_daily_actions
  drop constraint if exists social_daily_actions_action_type_check;

alter table public.social_daily_actions
  add constraint social_daily_actions_action_type_check
  check (action_type in ('count_me_in', 'create_meetup', 'request_join', 'approve_join'));

create table if not exists public.venue_meetup_join_requests (
  id uuid primary key default gen_random_uuid(),
  meetup_id uuid not null references public.venue_flash_meetups(id) on delete cascade,
  venue_id uuid not null references public.venues(id) on delete cascade,
  requester_id uuid not null references auth.users(id) on delete cascade,
  message text not null check (char_length(message) between 8 and 240),
  status text not null default 'pending'
    check (status in ('pending', 'approved', 'rejected')),
  created_at timestamptz not null default now(),
  reviewed_at timestamptz,
  unique (meetup_id, requester_id)
);

create index if not exists venue_meetup_join_requests_meetup_idx
  on public.venue_meetup_join_requests(meetup_id, status, created_at desc);

create index if not exists venue_meetup_join_requests_requester_idx
  on public.venue_meetup_join_requests(requester_id, created_at desc);

alter table public.venue_meetup_join_requests enable row level security;

drop policy if exists "join_requests_requester_read" on public.venue_meetup_join_requests;
create policy "join_requests_requester_read"
  on public.venue_meetup_join_requests
  for select
  to authenticated
  using (auth.uid() = requester_id);

drop policy if exists "join_requests_creator_read" on public.venue_meetup_join_requests;
create policy "join_requests_creator_read"
  on public.venue_meetup_join_requests
  for select
  to authenticated
  using (
    exists (
      select 1
      from public.venue_flash_meetups m
      where m.id = meetup_id
        and m.creator_id = auth.uid()
    )
  );

drop policy if exists "join_requests_requester_insert" on public.venue_meetup_join_requests;
create policy "join_requests_requester_insert"
  on public.venue_meetup_join_requests
  for insert
  to authenticated
  with check (auth.uid() = requester_id);

drop policy if exists "join_requests_creator_update" on public.venue_meetup_join_requests;
create policy "join_requests_creator_update"
  on public.venue_meetup_join_requests
  for update
  to authenticated
  using (
    exists (
      select 1
      from public.venue_flash_meetups m
      where m.id = meetup_id
        and m.creator_id = auth.uid()
    )
  )
  with check (
    exists (
      select 1
      from public.venue_flash_meetups m
      where m.id = meetup_id
        and m.creator_id = auth.uid()
    )
  );
