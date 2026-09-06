-- ============================================================
-- ReviseTI — Fundação do banco de dados
-- Rode este arquivo no SQL Editor do Supabase (ou via CLI/migrations)
-- ============================================================

-- ------------------------------------------------------------
-- 1. TABELA profiles
-- ------------------------------------------------------------
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

drop policy if exists "profiles_select_own" on public.profiles;
create policy "profiles_select_own" on public.profiles
  for select using (auth.uid() = id);

drop policy if exists "profiles_update_own" on public.profiles;
create policy "profiles_update_own" on public.profiles
  for update using (auth.uid() = id);

drop policy if exists "profiles_insert_own" on public.profiles;
create policy "profiles_insert_own" on public.profiles
  for insert with check (auth.uid() = id);

-- ------------------------------------------------------------
-- 2. TABELA study_contents (conteúdo oficial, compartilhado)
-- ------------------------------------------------------------
create table if not exists public.study_contents (
  id uuid primary key default gen_random_uuid(),
  week_number integer not null,
  day_of_week integer not null,
  title text not null,
  slug text unique not null,
  description text,
  content text,
  estimated_minutes integer not null default 60,
  order_index integer not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.study_contents enable row level security;

drop policy if exists "study_contents_select_authenticated" on public.study_contents;
create policy "study_contents_select_authenticated" on public.study_contents
  for select using (auth.role() = 'authenticated');

-- Sem policy de insert/update/delete para usuários comuns:
-- o conteúdo oficial é administrado por seed/migration ou service_role.

-- ------------------------------------------------------------
-- 3. TABELA reviews (dados pessoais)
-- ------------------------------------------------------------
create table if not exists public.reviews (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  content_id uuid references public.study_contents(id) on delete set null,
  title text not null,
  notes text,
  review_date date not null default current_date,
  minutes integer not null default 0,
  difficulty text not null default 'medium' check (difficulty in ('easy', 'medium', 'hard')),
  completed boolean not null default false,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.reviews enable row level security;

drop policy if exists "reviews_select_own" on public.reviews;
create policy "reviews_select_own" on public.reviews for select using (auth.uid() = user_id);
drop policy if exists "reviews_insert_own" on public.reviews;
create policy "reviews_insert_own" on public.reviews for insert with check (auth.uid() = user_id);
drop policy if exists "reviews_update_own" on public.reviews;
create policy "reviews_update_own" on public.reviews for update using (auth.uid() = user_id);
drop policy if exists "reviews_delete_own" on public.reviews;
create policy "reviews_delete_own" on public.reviews for delete using (auth.uid() = user_id);

-- ------------------------------------------------------------
-- 4. TABELA questions (dados pessoais)
-- ------------------------------------------------------------
create table if not exists public.questions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  content_id uuid references public.study_contents(id) on delete set null,
  question text not null,
  answer text not null,
  difficulty text not null default 'medium' check (difficulty in ('easy', 'medium', 'hard')),
  correct_count integer not null default 0,
  wrong_count integer not null default 0,
  last_reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.questions enable row level security;

drop policy if exists "questions_select_own" on public.questions;
create policy "questions_select_own" on public.questions for select using (auth.uid() = user_id);
drop policy if exists "questions_insert_own" on public.questions;
create policy "questions_insert_own" on public.questions for insert with check (auth.uid() = user_id);
drop policy if exists "questions_update_own" on public.questions;
create policy "questions_update_own" on public.questions for update using (auth.uid() = user_id);
drop policy if exists "questions_delete_own" on public.questions;
create policy "questions_delete_own" on public.questions for delete using (auth.uid() = user_id);

-- ------------------------------------------------------------
-- 5. TABELA study_progress (dados pessoais)
-- ------------------------------------------------------------
create table if not exists public.study_progress (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  content_id uuid not null references public.study_contents(id) on delete cascade,
  completed boolean not null default false,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, content_id)
);

alter table public.study_progress enable row level security;

drop policy if exists "study_progress_select_own" on public.study_progress;
create policy "study_progress_select_own" on public.study_progress for select using (auth.uid() = user_id);
drop policy if exists "study_progress_insert_own" on public.study_progress;
create policy "study_progress_insert_own" on public.study_progress for insert with check (auth.uid() = user_id);
drop policy if exists "study_progress_update_own" on public.study_progress;
create policy "study_progress_update_own" on public.study_progress for update using (auth.uid() = user_id);
drop policy if exists "study_progress_delete_own" on public.study_progress;
create policy "study_progress_delete_own" on public.study_progress for delete using (auth.uid() = user_id);

-- ------------------------------------------------------------
-- 6. TABELA study_sessions (dados pessoais)
-- ------------------------------------------------------------
create table if not exists public.study_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  content_id uuid references public.study_contents(id) on delete set null,
  study_date date not null default current_date,
  minutes integer not null default 0,
  notes text,
  created_at timestamptz not null default now()
);

alter table public.study_sessions enable row level security;

drop policy if exists "study_sessions_select_own" on public.study_sessions;
create policy "study_sessions_select_own" on public.study_sessions for select using (auth.uid() = user_id);
drop policy if exists "study_sessions_insert_own" on public.study_sessions;
create policy "study_sessions_insert_own" on public.study_sessions for insert with check (auth.uid() = user_id);
drop policy if exists "study_sessions_update_own" on public.study_sessions;
create policy "study_sessions_update_own" on public.study_sessions for update using (auth.uid() = user_id);
drop policy if exists "study_sessions_delete_own" on public.study_sessions;
create policy "study_sessions_delete_own" on public.study_sessions for delete using (auth.uid() = user_id);

-- ------------------------------------------------------------
-- 7. ÍNDICES
-- ------------------------------------------------------------
create index if not exists idx_reviews_user_id on public.reviews(user_id);
create index if not exists idx_reviews_review_date on public.reviews(review_date);
create index if not exists idx_reviews_completed on public.reviews(completed);
create index if not exists idx_questions_user_id on public.questions(user_id);
create index if not exists idx_study_progress_user_id on public.study_progress(user_id);
create index if not exists idx_study_sessions_user_id on public.study_sessions(user_id);
create index if not exists idx_study_sessions_study_date on public.study_sessions(study_date);
create index if not exists idx_study_contents_week_number on public.study_contents(week_number);

-- ------------------------------------------------------------
-- 8. TRIGGERS — updated_at automático
-- ------------------------------------------------------------
create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists set_updated_at_profiles on public.profiles;
create trigger set_updated_at_profiles before update on public.profiles
  for each row execute function public.set_updated_at();
drop trigger if exists set_updated_at_reviews on public.reviews;
create trigger set_updated_at_reviews before update on public.reviews
  for each row execute function public.set_updated_at();
drop trigger if exists set_updated_at_questions on public.questions;
create trigger set_updated_at_questions before update on public.questions
  for each row execute function public.set_updated_at();
drop trigger if exists set_updated_at_study_progress on public.study_progress;
create trigger set_updated_at_study_progress before update on public.study_progress
  for each row execute function public.set_updated_at();
drop trigger if exists set_updated_at_study_contents on public.study_contents;
create trigger set_updated_at_study_contents before update on public.study_contents
  for each row execute function public.set_updated_at();

-- ------------------------------------------------------------
-- 9. TRIGGER — criar profile automaticamente ao registrar usuário
-- ------------------------------------------------------------
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, coalesce(new.raw_user_meta_data ->> 'full_name', new.email));
  return new;
end;
$$ language plpgsql security definer set search_path = public;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ------------------------------------------------------------
-- 10. SEED — conteúdos de exemplo (5 semanas, sem conteúdo detalhado ainda)
-- ------------------------------------------------------------
insert into public.study_contents (week_number, day_of_week, title, slug, description, estimated_minutes, order_index) values
  (1, 1, 'Core do Python & POO', 'semana-1-core-python-poo', 'Fundamentos de Python e Programação Orientada a Objetos.', 90, 1),
  (1, 2, 'Assincronismo & FastAPI', 'semana-1-assincronismo-fastapi', 'Programação assíncrona e construção de APIs com FastAPI.', 90, 2),
  (1, 3, 'Persistência de Dados & SQLAlchemy', 'semana-1-persistencia-sqlalchemy', 'Modelagem e persistência de dados com SQLAlchemy.', 90, 3),
  (1, 4, 'Mensageria, Caching & Performance', 'semana-1-mensageria-cache', 'Filas, cache e otimização de performance.', 90, 4),
  (1, 5, 'Testes Automatizados com Pytest', 'semana-1-testes-pytest', 'Testes unitários e automatizados com Pytest.', 90, 5),

  (2, 1, 'HTML5 Semântico & Acessibilidade', 'semana-2-html5-acessibilidade', 'HTML semântico e boas práticas de acessibilidade.', 90, 6),
  (2, 2, 'CSS3 Avançado & Layouts', 'semana-2-css3-layouts', 'Layouts modernos com CSS3 (Grid, Flexbox).', 90, 7),
  (2, 3, 'Tailwind CSS & Responsividade', 'semana-2-tailwind-responsividade', 'Estilização utilitária e design responsivo com Tailwind.', 90, 8),
  (2, 4, 'Core do JavaScript', 'semana-2-core-javascript', 'Fundamentos da linguagem JavaScript.', 90, 9),
  (2, 5, 'JavaScript Assíncrono', 'semana-2-javascript-assincrono', 'Promises, async/await e event loop.', 90, 10),

  (3, 1, 'Fundamentos do React', 'semana-3-fundamentos-react', 'Componentes, props e estado no React.', 90, 11),
  (3, 2, 'Hooks Avançados', 'semana-3-hooks-avancados', 'useEffect, useMemo, useCallback e hooks customizados.', 90, 12),
  (3, 3, 'Estado Global & Next.js', 'semana-3-estado-global-nextjs', 'Gerenciamento de estado global e introdução ao Next.js.', 90, 13),
  (3, 4, 'TypeScript', 'semana-3-typescript', 'Tipagem estática aplicada a projetos React.', 90, 14),
  (3, 5, 'Integração Full Stack', 'semana-3-integracao-full-stack', 'Conectando frontend e backend em um projeto completo.', 90, 15),

  (4, 1, 'Docker', 'semana-4-docker', 'Containerização de aplicações com Docker.', 90, 16),
  (4, 2, 'Kubernetes & Observabilidade', 'semana-4-kubernetes-observabilidade', 'Orquestração de containers e monitoramento.', 90, 17),
  (4, 3, 'CI/CD', 'semana-4-ci-cd', 'Integração e entrega contínua.', 90, 18),
  (4, 4, 'Arquitetura de APIs', 'semana-4-arquitetura-apis', 'Boas práticas de design de APIs.', 90, 19),
  (4, 5, 'Git & Metodologias Ágeis', 'semana-4-git-metodologias-ageis', 'Controle de versão e metodologias ágeis.', 90, 20),

  (5, 1, 'Projetos do Portfólio', 'semana-5-projetos-portfolio', 'Construção de projetos para portfólio.', 90, 21),
  (5, 2, 'Soft Skills & Método STAR', 'semana-5-soft-skills-star', 'Habilidades comportamentais e método STAR para entrevistas.', 90, 22),
  (5, 3, 'System Design', 'semana-5-system-design', 'Fundamentos de design de sistemas.', 90, 23),
  (5, 4, 'Code Review', 'semana-5-code-review', 'Boas práticas de revisão de código.', 90, 24),
  (5, 5, 'Preparação para Entrevista', 'semana-5-preparacao-entrevista', 'Preparação técnica e comportamental para entrevistas.', 90, 25)
on conflict (slug) do nothing;
