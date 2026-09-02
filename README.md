# ReviseTI

Plataforma pessoal de estudos e revisão de conteúdos de TI, baseada no cronograma
de Full Stack Python + React (5 semanas). Esta é a **fundação** do projeto:
autenticação, Supabase, banco de dados com RLS, navegação e layout responsivo.
O conteúdo completo das aulas, gráficos avançados e repetição espaçada entram
em etapas futuras.

## Stack

React + TypeScript + Vite + Tailwind CSS + React Router + Supabase (Auth + Postgres).

## Como configurar

### 1. Instalar dependências

```bash
npm install
```

### 2. Criar o projeto no Supabase

1. Crie um projeto em https://supabase.com (se ainda não tiver um).
2. Em **Settings → API**, copie a **Project URL** e a **anon public key**.
3. Copie `.env.example` para `.env` e preencha os dois valores:

```bash
cp .env.example .env
```

```env
VITE_SUPABASE_URL=https://SEU-PROJETO.supabase.co
VITE_SUPABASE_ANON_KEY=SUA_CHAVE_ANON_PUBLICA_AQUI
```

**Nunca** coloque a `service_role key` aqui — ela nunca deve existir no frontend.

### 3. Rodar as migrations do banco

No painel do Supabase, abra **SQL Editor**, cole e execute, **nesta ordem**:

1. `supabase/migrations/0001_init.sql` — cria as 6 tabelas, RLS, triggers, índices e um seed inicial simples.
2. `supabase/migrations/0002_content_full.sql` — estende `study_contents` (`day_name`, `topic_count`, `metadata`), cria a tabela `content_topics` (com RLS), e substitui o seed pelo conteúdo didático completo das 5 semanas (25 aulas, em Markdown, com seus tópicos). **Idempotente**: pode rodar mais de uma vez sem duplicar nada.
3. `supabase/migrations/0003_goals_and_indices.sql` — cria a tabela `study_goals` (meta semanal de estudo, com RLS) e adiciona índices compostos de performance (`study_sessions(user_id, study_date)`, `reviews(user_id, review_date)`). Idempotente.
4. `supabase/migrations/0004_question_bank.sql` — cria `official_questions` (banco de questões oficiais, compartilhado, com RLS de leitura para autenticados) e `question_attempts` (tentativas isoladas por usuário, RLS completo, insert-only — cada resposta é um novo registro histórico).
5. `supabase/migrations/0005_question_bank_seed.sql` — popula `official_questions` com **310 perguntas reais** (pergunta, resposta e explicação obrigatórias em todas), cobrindo as 25 aulas + um módulo de entrevista (Python, React, APIs, banco de dados, Git, segurança, comportamental, e perguntas sobre os projetos-exemplo PokeFast API e SmartFinance). Idempotente por `question_key` — pode rodar mais de uma vez sem duplicar.

### 4. Configuração manual no Supabase (fora do SQL)

Isso não dá para automatizar por SQL — configure manualmente no painel:

- **Authentication → URL Configuration**: defina a Site URL (ex: `http://localhost:5173`
  em dev, seu domínio em produção) e adicione `http://localhost:5173/reset-password`
  (e o equivalente em produção) em **Redirect URLs**, para o link de recuperação de senha funcionar.
- **Authentication → Providers → Email**: decida se quer exigir confirmação de email
  antes do primeiro login (recomendado em produção).

### 5. Rodar o projeto

```bash
npm run dev
```

Acesse `http://localhost:5173`.

## Estrutura

```
src/
  components/layout/   AppLayout, Sidebar, Header, ProtectedRoute, AuthShell
  components/ui/        Estados de loading/vazio/erro, Toasts
  pages/                 Login, Register, ForgotPassword, ResetPassword,
                         Dashboard, Contents, ContentDetail, Reviews,
                         Questions, Progress, Settings
  contexts/AuthContext.tsx
  hooks/useAuth.ts
  lib/supabase.ts
  services/              Um arquivo por tabela: profileService, contentService,
                         reviewService, questionService, progressService,
                         studySessionService
  types/database.ts
supabase/migrations/0001_init.sql
```

## O que já funciona

- Cadastro, login, logout, recuperação de senha, proteção de rotas.
- **Conteúdo completo das 5 semanas** (25 aulas): busca, filtro por semana, página de semana com progresso, página de aula com breadcrumb, Markdown renderizado e lista de tópicos.
- Marcar/desmarcar aula como concluída (`study_progress`), com progresso calculado por semana e geral, sempre individual por usuário.
- **Sistema completo de revisões**: criar, editar, excluir (com confirmação), concluir/desfazer, vincular a uma aula, filtros (Todas/Hoje/Pendentes/Concluídas/Atrasadas/Futuras), busca por título/observações, resumo no topo (Hoje/Pendentes/Concluídas/Atrasadas), status calculado automaticamente (pendente/concluída/atrasada — nunca uma concluída aparece como atrasada), ações adaptadas para mobile (menu "...") e desktop (botões).
- **Sistema completo de perguntas e flashcards**: criar, editar, excluir, vincular a uma aula, filtros (dificuldade, mais acertadas/erradas, nunca revisadas, "preciso revisar"), filtro por aula, busca por pergunta/resposta, resumo (total/acertos/erros/taxa de acerto), estatísticas que sempre incrementam (nunca sobrescrevem), **Modo estudo** em flashcards com progressão, priorização (nunca revisadas → mais erros → mais difíceis → revisadas há mais tempo) e resumo final da sessão.
- Dashboard e Progresso com números reais de revisões e perguntas (pendentes/concluídas/atrasadas, taxa de acerto, perguntas para revisar) e horas estudadas.
- **Dashboard completo**: 6 cards principais (progresso geral, horas, conteúdos, revisões, perguntas, taxa de acerto), progresso por semana clicável, **meta semanal** configurável (presets de 1h–20h ou personalizada, com "Meta atingida! 🎉"), botão "Registrar estudo" (cria `study_sessions`), gráficos (horas por dia, evolução, status das revisões, desempenho das perguntas — todos com estado vazio próprio, sem quebrar o resto do Dashboard se um falhar), atividade recente (montada a partir de aulas/revisões/perguntas/sessões existentes, sem tabela extra) e "Continue estudando".
- **Página de Progresso completa**: resumo, progresso por semana, horas estudadas com filtro de período (7 dias/30 dias/mês/3 meses/tudo), gráficos de evolução, status de revisões e desempenho de perguntas, detalhamento de perguntas (difíceis, precisam de revisão).
- **PWA + funcionamento offline**: app instalável (manifest + ícones), banco local com IndexedDB (Dexie) espelhando conteúdos/revisões/perguntas/sessões/progresso/meta, fila de sincronização com retry e backoff exponencial, resolução de conflito por `updated_at` (last-write-wins), indicador de status (Sincronizado/Sincronizando/Offline/Pendente/Erro) no cabeçalho, faixa "Você está offline", página `/sync` com detalhe da fila e botão "Sincronizar agora", aviso de alterações não sincronizadas antes do logout, e isolamento de dados locais por usuário (dados privados são limpos ao trocar de conta no mesmo aparelho).
- **Polimento de UX/UI**: navegação inferior no mobile (5 itens principais) + menu do usuário com dropdown (Perfil/Configurações/Sincronização/Sair) no header, skeletons de carregamento (em vez de spinner de tela cheia) no Dashboard/Conteúdos/Revisões/Perguntas/Progresso, página 404 de verdade, Error Boundary (um erro numa página não derruba o app), atalhos de teclado no modo estudo (Espaço/1/2), botão de instalar o PWA em Configurações, toasts que avisam quando uma ação foi feita offline ("será sincronizada quando a conexão voltar"), e um único componente de logout com confirmação reaproveitado em Sidebar/menu do usuário/Configurações.
- **Banco de questões oficiais (310 perguntas)**: compartilhado entre usuários (como `study_contents`), cobrindo as 25 aulas + módulo de entrevista, com resposta e explicação obrigatórias em todas, distribuição ~30% fácil/50% média/20% difícil. "Revisar esta aula" (na página da aula), "Revisar Semana X" (na página da semana), "Revisão geral" e "Simulado de entrevista" (perguntas por tema: Python, React, APIs, banco de dados, Git, segurança, comportamental, e sobre os projetos-exemplo PokeFast API e SmartFinance). Tentativas (`question_attempts`) isoladas por usuário via RLS, funcionam offline e sincronizam depois.
- **Módulo de entrevista** (`/interview`): posicionamento da trilha (Full Stack Python + React), modelo de apresentação pessoal personalizável (campos preenchíveis, sem fingir ser a história real do usuário), perguntas por tema, checklist pré-entrevista, e simulado misturando todas as categorias de entrevista.
- Layout responsivo (mobile-first, sidebar no desktop, menu gaveta no mobile).
- Base de PWA (manifest + cache de `study_contents` via `vite-plugin-pwa`) para
  a sincronização offline completa ser construída em cima disso depois.

## Como funciona o offline

- **Supabase continua sendo a fonte oficial.** O IndexedDB (via [Dexie](https://dexie.org)) é só cache + fila de sincronização — nunca substitui o banco na nuvem.
- **Repository pattern**: os componentes chamam hooks (`useReviews`, `useQuestions`, `useProgress`, `useStudySessions`, `useStudyGoal`) que por sua vez chamam `src/repositories/*.ts`. É o repository que decide se lê/escreve no Supabase ou no IndexedDB — a UI nunca precisa perguntar "estou offline?".
- **Escritas são sempre otimistas**: toda alteração (criar revisão, responder pergunta, marcar aula concluída, registrar sessão) grava primeiro no IndexedDB com um UUID gerado localmente (`crypto.randomUUID()`) e entra na fila `syncQueue`; a tela atualiza na hora. Se estiver online, a sincronização com o Supabase é disparada em segundo plano automaticamente.
- **Fila de sincronização** (`src/services/syncService.ts`): processa os itens pendentes, tenta enviar ao Supabase, e em caso de falha incrementa `retryCount`/`lastError` e agenda nova tentativa com backoff (30s → 1min → 5min). Nada é apagado da fila até sincronizar com sucesso.
- **Contadores de perguntas nunca são sobrescritos**: acertos/erros offline são enfileirados como incremento (+1), não como valor absoluto — evitando perder respostas registradas em outro dispositivo.
- **Conflitos**: ao sincronizar uma edição, o `updated_at` remoto é comparado com o momento da alteração local; a versão mais recente vence (last-write-wins), sem sobrescrever silenciosamente uma mudança mais nova.
- **Isolamento entre usuários**: todo dado privado local carrega `user_id`; ao logar com uma conta diferente da que já tinha dados no aparelho, o IndexedDB privado é limpo antes de baixar os dados da nova conta. No logout, os dados privados também são limpos (conteúdos, que são públicos, continuam em cache).
- **Autenticação**: a sessão é gerenciada inteiramente pelo SDK do Supabase Auth (que já persiste com segurança) — nada de senha, access token ou refresh token é guardado manualmente. Sem sessão prévia e offline, a tela de login avisa que é preciso conectar-se à internet no primeiro acesso.

## O que fica para as próximas etapas

- Sincronização em background avançada (Background Sync API) — hoje a fila roda enquanto o app está aberto (ao voltar a conexão, ao montar, ou no botão "Sincronizar agora").
- Repetição espaçada de verdade para o modo estudo (hoje é só uma heurística de priorização).
- Visualização de revisões em calendário (hoje só um placeholder "em breve").
- Checklist detalhado por aula (estudei / entendi / fiz exercícios / consigo explicar / revisei).
- Exportação/importação de dados (a interface já está preparada em Configurações).
- Gamificação, XP, níveis, badges, ranking, notificações push — fora de escopo por enquanto.
