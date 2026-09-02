-- ============================================================
-- ReviseTI — PROMPT 08 (parte 1/2): banco de questões oficiais
-- Rode DEPOIS de 0001, 0002 e 0003. Idempotente.
--
-- Isto é uma estrutura NOVA e separada da tabela "questions" já existente
-- (que continua sendo os flashcards pessoais que cada usuário cria).
-- "official_questions" é conteúdo OFICIAL/compartilhado (como study_contents):
-- 300+ perguntas com resposta e explicação, cobrindo as 5 semanas + módulo
-- de entrevista. "question_attempts" registra as tentativas de cada usuário
-- nessas perguntas oficiais, isolado por RLS.
-- ============================================================

create table if not exists public.official_questions (
  id uuid primary key default gen_random_uuid(),
  content_id uuid references public.study_contents(id) on delete set null,
  question_key text unique not null,
  category text not null,
  question_type text not null default 'open' check (question_type in ('open','multiple_choice','true_false','code')),
  difficulty text not null check (difficulty in ('easy','medium','hard')),
  question text not null,
  options jsonb,
  correct_option text,
  answer text not null,
  explanation text not null,
  is_interview_question boolean not null default false,
  order_index integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.official_questions enable row level security;

drop policy if exists "official_questions_select_authenticated" on public.official_questions;
create policy "official_questions_select_authenticated" on public.official_questions
  for select using (auth.role() = 'authenticated');
-- Sem policy de escrita para usuários comuns — é conteúdo oficial, administrado por seed/migration.

create index if not exists idx_official_questions_content_id on public.official_questions(content_id);
create index if not exists idx_official_questions_category on public.official_questions(category);
create index if not exists idx_official_questions_difficulty on public.official_questions(difficulty);

drop trigger if exists set_updated_at_official_questions on public.official_questions;
create trigger set_updated_at_official_questions before update on public.official_questions
  for each row execute function public.set_updated_at();

-- ------------------------------------------------------------
-- question_attempts — tentativas individuais (isoladas por usuário)
-- ------------------------------------------------------------
create table if not exists public.question_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  official_question_id uuid not null references public.official_questions(id) on delete cascade,
  selected_answer text,
  is_correct boolean not null,
  answered_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

alter table public.question_attempts enable row level security;

drop policy if exists "question_attempts_select_own" on public.question_attempts;
create policy "question_attempts_select_own" on public.question_attempts for select using (auth.uid() = user_id);
drop policy if exists "question_attempts_insert_own" on public.question_attempts;
create policy "question_attempts_insert_own" on public.question_attempts for insert with check (auth.uid() = user_id);
drop policy if exists "question_attempts_delete_own" on public.question_attempts;
create policy "question_attempts_delete_own" on public.question_attempts for delete using (auth.uid() = user_id);
-- Sem UPDATE: uma tentativa é um registro histórico imutável (cada resposta gera uma nova linha).

create index if not exists idx_question_attempts_user_id on public.question_attempts(user_id);
create index if not exists idx_question_attempts_question_id on public.question_attempts(official_question_id);

