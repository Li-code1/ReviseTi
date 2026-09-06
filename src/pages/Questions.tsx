import { useMemo, useState } from "react";
import { Link } from "react-router-dom";
import { Plus, Search, PlayCircle, HelpCircle, CheckCircle2, XCircle, Percent } from "lucide-react";
import { useQuestions } from "@/hooks/useQuestions";
import { Modal } from "@/components/ui/Modal";
import { ConfirmDialog } from "@/components/ui/ConfirmDialog";
import { QuestionForm, type QuestionFormValues } from "@/components/questions/QuestionForm";
import { QuestionCard } from "@/components/questions/QuestionCard";
import { EmptyState, ErrorState } from "@/components/ui/StateMessage";
import { PageSkeleton } from "@/components/ui/Skeleton";
import { useToast } from "@/components/ui/Toast";
import { getQuestionStats, neverReviewed, needsReview } from "@/utils/questions";
import { actionToastMessage } from "@/utils/offlineToast";
import { useOnlineStatus } from "@/hooks/useOnlineStatus";
import type { Difficulty, QuestionWithContent } from "@/types/database";

type FilterKey = "all" | "easy" | "medium" | "hard" | "most_correct" | "most_wrong" | "never_reviewed" | "needs_review";

// Limite de perguntas pessoais por usuário — protege o uso do banco de dados
// para todo mundo, sem impedir o uso normal do recurso (a maioria das pessoas
// nunca chega perto disso).
const MAX_PERSONAL_QUESTIONS = 500;

const FILTERS: { key: FilterKey; label: string }[] = [
  { key: "all", label: "Todas" },
  { key: "easy", label: "Fácil" },
  { key: "medium", label: "Média" },
  { key: "hard", label: "Difícil" },
  { key: "most_correct", label: "Mais acertadas" },
  { key: "most_wrong", label: "Mais erradas" },
  { key: "never_reviewed", label: "Nunca revisadas" },
  { key: "needs_review", label: "Preciso revisar" },
];

export default function Questions() {
  const { questions, loading, error, create, update, remove } = useQuestions();
  const { isOnline } = useOnlineStatus();
  const { showToast } = useToast();

  const [showForm, setShowForm] = useState(false);
  const [editingQuestion, setEditingQuestion] = useState<QuestionWithContent | null>(null);
  const [deletingQuestion, setDeletingQuestion] = useState<QuestionWithContent | null>(null);
  const [filter, setFilter] = useState<FilterKey>("all");
  const [contentFilter, setContentFilter] = useState<string>("all");
  const [search, setSearch] = useState("");

  const stats = useMemo(() => getQuestionStats(questions), [questions]);

  const contentOptions = useMemo(() => {
    const map = new Map<string, string>();
    for (const q of questions) {
      if (q.content) map.set(q.content.id, `Semana ${q.content.week_number} • ${q.content.title}`);
    }
    return Array.from(map.entries());
  }, [questions]);

  const filtered = useMemo(() => {
    let list = questions;

    if (contentFilter !== "all") {
      list = list.filter((q) => q.content_id === contentFilter);
    }

    if (filter === "easy" || filter === "medium" || filter === "hard") {
      list = list.filter((q) => q.difficulty === (filter as Difficulty));
    } else if (filter === "most_correct") {
      list = [...list].sort((a, b) => b.correct_count - a.correct_count);
    } else if (filter === "most_wrong") {
      list = [...list].sort((a, b) => b.wrong_count - a.wrong_count);
    } else if (filter === "never_reviewed") {
      list = list.filter(neverReviewed);
    } else if (filter === "needs_review") {
      list = list.filter(needsReview);
    }

    if (search.trim()) {
      const term = search.trim().toLowerCase();
      list = list.filter(
        (q) => q.question.toLowerCase().includes(term) || q.answer.toLowerCase().includes(term)
      );
    }

    return list;
  }, [questions, filter, contentFilter, search]);

  async function handleCreate(values: QuestionFormValues) {
    if (questions.length >= MAX_PERSONAL_QUESTIONS) {
      return { error: `Você atingiu o limite de ${MAX_PERSONAL_QUESTIONS} perguntas pessoais. Exclua alguma para criar novas.` };
    }
    const { error } = await create(values);
    if (!error) {
      showToast(actionToastMessage("Pergunta criada com sucesso.", isOnline));
      setShowForm(false);
    }
    return { error };
  }

  async function handleUpdate(values: QuestionFormValues) {
    if (!editingQuestion) return { error: "Pergunta inválida." };
    const { error } = await update(editingQuestion.id, values);
    if (!error) {
      showToast(actionToastMessage("Pergunta atualizada.", isOnline));
      setEditingQuestion(null);
    }
    return { error };
  }

  async function handleDelete() {
    if (!deletingQuestion) return;
    const { error } = await remove(deletingQuestion.id);
    setDeletingQuestion(null);
    if (error) showToast(error, "error");
    else showToast(actionToastMessage("Pergunta excluída.", isOnline));
  }

  if (loading) return <PageSkeleton />;
  if (error) return <ErrorState title="Não foi possível carregar suas perguntas" description={error} />;

  const summaryCards = [
    { label: "Perguntas", value: stats.total, icon: HelpCircle },
    { label: "Acertos", value: stats.correct, icon: CheckCircle2 },
    { label: "Erros", value: stats.wrong, icon: XCircle },
    { label: "Taxa de acerto", value: stats.accuracyRate === null ? "Sem dados" : `${stats.accuracyRate}%`, icon: Percent },
  ];

  return (
    <div className="space-y-6">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Minhas perguntas</h1>
          <p className="mt-1 text-slate-500 dark:text-slate-400">Teste seus conhecimentos e descubra o que precisa revisar.</p>
          <p className="mt-1 text-xs text-slate-400">
            Estas são suas perguntas pessoais. Para o banco oficial com 300+ questões das 5 semanas, use "Revisão geral" ou "Entrevista" ao lado.
          </p>
          {questions.length >= MAX_PERSONAL_QUESTIONS * 0.9 && (
            <p className="mt-1 text-xs font-medium text-yellow-600 dark:text-yellow-400">
              {questions.length >= MAX_PERSONAL_QUESTIONS
                ? `Você atingiu o limite de ${MAX_PERSONAL_QUESTIONS} perguntas pessoais. Exclua alguma para criar novas.`
                : `Você pode cadastrar até ${MAX_PERSONAL_QUESTIONS} perguntas pessoais (${questions.length}/${MAX_PERSONAL_QUESTIONS} usadas).`}
            </p>
          )}
        </div>
        <div className="flex gap-2">
          <Link to="/questions/study" className="btn-secondary">
            <PlayCircle className="h-4 w-4" /> Modo estudo
          </Link>
          <Link to="/study/general" className="btn-secondary">
            Revisão geral (banco oficial)
          </Link>
          <Link to="/interview" className="btn-secondary">
            Entrevista
          </Link>
          <button onClick={() => setShowForm(true)} disabled={questions.length >= MAX_PERSONAL_QUESTIONS} className="btn-primary">
            <Plus className="h-4 w-4" /> Nova pergunta
          </button>
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4 lg:grid-cols-4">
        {summaryCards.map(({ label, value, icon: Icon }) => (
          <div key={label} className="card">
            <div className="mb-3 flex h-9 w-9 items-center justify-center rounded-lg bg-brand-50 text-brand-600 dark:bg-brand-900/30 dark:text-brand-300">
              <Icon className="h-4.5 w-4.5" />
            </div>
            <p className="text-xl font-bold">{value}</p>
            <p className="text-sm text-slate-500 dark:text-slate-400">{label}</p>
          </div>
        ))}
      </div>

      <div className="flex flex-col gap-3">
        <div className="flex flex-col gap-3 sm:flex-row">
          <div className="relative flex-1">
            <Search className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400" />
            <input
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="Buscar pergunta..."
              className="input-field pl-9"
              aria-label="Buscar pergunta"
            />
          </div>
          {contentOptions.length > 0 && (
            <select
              value={contentFilter}
              onChange={(e) => setContentFilter(e.target.value)}
              className="input-field sm:w-64"
              aria-label="Filtrar por aula"
            >
              <option value="all">Todas as aulas</option>
              {contentOptions.map(([id, label]) => (
                <option key={id} value={id}>
                  {label}
                </option>
              ))}
            </select>
          )}
        </div>

        <div className="flex items-center gap-2 overflow-x-auto pb-1">
          {FILTERS.map(({ key, label }) => (
            <button
              key={key}
              onClick={() => setFilter(key)}
              className={`flex-shrink-0 rounded-full px-3.5 py-1.5 text-sm font-medium transition ${
                filter === key
                  ? "bg-brand-600 text-white"
                  : "bg-slate-100 text-slate-600 hover:bg-slate-200 dark:bg-slate-800 dark:text-slate-300 dark:hover:bg-slate-700"
              }`}
            >
              {label}
            </button>
          ))}
        </div>
      </div>

      {filtered.length === 0 ? (
        questions.length === 0 ? (
          <div className="flex flex-col items-center justify-center gap-3 rounded-2xl border border-dashed border-slate-200 py-16 text-center dark:border-slate-800">
            <p className="font-medium text-slate-700 dark:text-slate-200">Você ainda não possui perguntas.</p>
            <p className="max-w-xs text-sm text-slate-500 dark:text-slate-400">
              Crie perguntas para transformar seus estudos em revisões ativas.
            </p>
            <button onClick={() => setShowForm(true)} className="btn-primary mt-2">
              <Plus className="h-4 w-4" /> Criar primeira pergunta
            </button>
          </div>
        ) : (
          <EmptyState title="Nenhuma pergunta encontrada." description="Tente outro filtro ou termo de busca." />
        )
      ) : (
        <div className="space-y-3">
          {filtered.map((q) => (
            <QuestionCard key={q.id} question={q} onEdit={() => setEditingQuestion(q)} onDelete={() => setDeletingQuestion(q)} />
          ))}
        </div>
      )}

      {showForm && (
        <Modal title="Nova pergunta" onClose={() => setShowForm(false)}>
          <QuestionForm onSubmit={handleCreate} onCancel={() => setShowForm(false)} />
        </Modal>
      )}

      {editingQuestion && (
        <Modal title="Editar pergunta" onClose={() => setEditingQuestion(null)}>
          <QuestionForm initial={editingQuestion} onSubmit={handleUpdate} onCancel={() => setEditingQuestion(null)} />
        </Modal>
      )}

      {deletingQuestion && (
        <ConfirmDialog
          title="Excluir pergunta?"
          description="Essa ação não poderá ser desfeita."
          confirmLabel="Excluir"
          destructive
          onConfirm={handleDelete}
          onCancel={() => setDeletingQuestion(null)}
        />
      )}
    </div>
  );
}
