-- ============================================================
-- ReviseTI — PROMPT 05: meta semanal + índices de performance
-- Rode este arquivo no SQL Editor do Supabase DEPOIS de 0001 e 0002.
-- Idempotente.
-- ============================================================

-- ------------------------------------------------------------
-- 1. TABELA study_goals
-- ------------------------------------------------------------
create table if not exists public.study_goals (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  weekly_minutes integer not null default 600,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id)
);

alter table public.study_goals enable row level security;

drop policy if exists "study_goals_select_own" on public.study_goals;
create policy "study_goals_select_own" on public.study_goals for select using (auth.uid() = user_id);

drop policy if exists "study_goals_insert_own" on public.study_goals;
create policy "study_goals_insert_own" on public.study_goals for insert with check (auth.uid() = user_id);

drop policy if exists "study_goals_update_own" on public.study_goals;
create policy "study_goals_update_own" on public.study_goals for update using (auth.uid() = user_id);

drop policy if exists "study_goals_delete_own" on public.study_goals;
create policy "study_goals_delete_own" on public.study_goals for delete using (auth.uid() = user_id);

drop trigger if exists set_updated_at_study_goals on public.study_goals;
create trigger set_updated_at_study_goals before update on public.study_goals
  for each row execute function public.set_updated_at();

-- ------------------------------------------------------------
-- 2. ÍNDICES COMPOSTOS (performance do Dashboard/Progresso)
-- ------------------------------------------------------------
create index if not exists idx_study_sessions_user_date on public.study_sessions(user_id, study_date);
create index if not exists idx_reviews_user_date on public.reviews(user_id, review_date);
create index if not exists idx_study_goals_user_id on public.study_goals(user_id);
