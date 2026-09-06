import { useEffect, useState } from "react";
import { useParams, useNavigate, Link } from "react-router-dom";
import { ArrowLeft, BookOpen, CheckCircle2, XCircle, Eye, Pencil, Trash2 } from "lucide-react";
import { getQuestionById } from "@/repositories/questionRepository";
import { useQuestions } from "@/hooks/useQuestions";
import type { QuestionWithContent } from "@/types/database";
import { LoadingState, ErrorState } from "@/components/ui/StateMessage";
import { Modal } from "@/components/ui/Modal";
import { ConfirmDialog } from "@/components/ui/ConfirmDialog";
import { QuestionForm, type QuestionFormValues } from "@/components/questions/QuestionForm";
import { useToast } from "@/components/ui/Toast";
import { DIFFICULTY_LABELS, DIFFICULTY_COLORS } from "@/utils/reviews";
import { formatLastReviewed } from "@/utils/questions";

export default function QuestionDetail() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { showToast } = useToast();
  const { update, remove, registerCorrect, registerWrong } = useQuestions();

  const [q, setQ] = useState<QuestionWithContent | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [revealed, setRevealed] = useState(false);
  const [showEdit, setShowEdit] = useState(false);
  const [showDelete, setShowDelete] = useState(false);

  async function load() {
    if (!id) return;
    setLoading(true);
    const { data, error } = await getQuestionById(id);
    setQ(data);
    setError(error);
    setLoading(false);
  }

  useEffect(() => {
    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [id]);

  async function handleCorrect() {
    if (!q) return;
    const { error } = await registerCorrect(q.id, q.correct_count);
    if (error) showToast(error, "error");
    else {
      showToast("Boa! Continue assim.");
      setRevealed(false);
      load();
    }
  }

  async function handleWrong() {
    if (!q) return;
    const { error } = await registerWrong(q.id, q.wrong_count);
    if (error) showToast(error, "error");
    else {
      showToast("Essa pergunta merece uma nova revisão.");
      setRevealed(false);
      load();
    }
  }

  async function handleEdit(values: QuestionFormValues) {
    if (!q) return { error: "Pergunta inválida." };
    const { error } = await update(q.id, values);
    if (!error) {
      showToast("Pergunta atualizada.");
      setShowEdit(false);
      load();
    }
    return { error };
  }

  async function handleDelete() {
    if (!q) return;
    const { error } = await remove(q.id);
    setShowDelete(false);
    if (error) showToast(error, "error");
    else {
      showToast("Pergunta excluída.");
      navigate("/questions");
    }
  }

  if (loading) return <LoadingState label="Carregando pergunta..." />;
  if (error || !q) return <ErrorState title="Pergunta não encontrada" description={error ?? undefined} />;

  return (
    <div className="space-y-6">
      <Link to="/questions" className="flex items-center gap-1 text-sm text-brand-600 hover:underline dark:text-brand-400">
        <ArrowLeft className="h-4 w-4" /> Voltar para perguntas
      </Link>

      <div className="card">
        <div className="flex flex-wrap items-start justify-between gap-4">
          <div>
            <span className={`inline-block rounded-full px-2.5 py-1 text-xs font-medium ${DIFFICULTY_COLORS[q.difficulty]}`}>
              {DIFFICULTY_LABELS[q.difficulty]}
            </span>
            <h1 className="mt-2 text-xl font-bold tracking-tight">{q.question}</h1>
          </div>
          <div className="flex flex-shrink-0 gap-2">
            <button onClick={() => setShowEdit(true)} className="btn-secondary px-3 py-1.5 text-xs">
              <Pencil className="h-3.5 w-3.5" /> Editar
            </button>
            <button onClick={() => setShowDelete(true)} className="btn-secondary px-3 py-1.5 text-xs text-red-600 hover:bg-red-50 dark:hover:bg-red-950/30">
              <Trash2 className="h-3.5 w-3.5" /> Excluir
            </button>
          </div>
        </div>

        {q.content ? (
          <Link to={`/contents/${q.content.slug}`} className="mt-3 flex items-center gap-1.5 text-sm text-brand-600 hover:underline dark:text-brand-400">
            <BookOpen className="h-4 w-4" /> Ver aula: {q.content.title}
          </Link>
        ) : (
          <p className="mt-3 text-sm text-slate-400">Sem aula relacionada.</p>
        )}

        <div className="mt-4 flex flex-wrap items-center gap-x-6 gap-y-2 text-sm text-slate-500 dark:text-slate-400">
          <span className="flex items-center gap-1 text-green-600 dark:text-green-400">
            <CheckCircle2 className="h-4 w-4" /> {q.correct_count} acertos
          </span>
          <span className="flex items-center gap-1 text-red-600 dark:text-red-400">
            <XCircle className="h-4 w-4" /> {q.wrong_count} erros
          </span>
          <span>{formatLastReviewed(q.last_reviewed_at)}</span>
        </div>
      </div>

      <div className="card">
        <h2 className="mb-3 text-lg font-semibold">Estudar esta pergunta</h2>
        {revealed ? (
          <>
            <p className="rounded-xl bg-slate-50 p-4 text-slate-700 dark:bg-slate-800 dark:text-slate-200">{q.answer}</p>
            <div className="mt-4 flex gap-3">
              <button onClick={handleWrong} className="btn-secondary flex-1 justify-center py-3 text-red-600 hover:bg-red-50 dark:hover:bg-red-950/30">
                <XCircle className="h-4 w-4" /> Não sabia
              </button>
              <button onClick={handleCorrect} className="btn-primary flex-1 justify-center py-3">
                <CheckCircle2 className="h-4 w-4" /> Acertei
              </button>
            </div>
          </>
        ) : (
          <button onClick={() => setRevealed(true)} className="btn-primary w-full justify-center py-3">
            <Eye className="h-4 w-4" /> Mostrar resposta
          </button>
        )}
      </div>

      {showEdit && (
        <Modal title="Editar pergunta" onClose={() => setShowEdit(false)}>
          <QuestionForm initial={q} onSubmit={handleEdit} onCancel={() => setShowEdit(false)} />
        </Modal>
      )}

      {showDelete && (
        <ConfirmDialog
          title="Excluir pergunta?"
          description="Essa ação não poderá ser desfeita."
          confirmLabel="Excluir"
          destructive
          onConfirm={handleDelete}
          onCancel={() => setShowDelete(false)}
        />
      )}
    </div>
  );
}
