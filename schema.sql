-- Supabase SQL Editor에서 실행. Authentication > Users에서 본인 계정을 먼저 생성하세요.
create table if not exists public.user_snapshots (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.user_snapshots enable row level security;
create policy "owner read" on public.user_snapshots for select to authenticated using ((select auth.uid()) = user_id);
create policy "owner insert" on public.user_snapshots for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "owner update" on public.user_snapshots for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
