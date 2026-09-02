import { useEffect, useMemo, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { ArrowLeft, Eye, CheckCircle2, XCircle, RotateCcw } from "lucide-react";
import { useQuestions } from "@/hooks/useQuestions";
import { selectStudyQuestions, accuracyRate } from "@/utils/questions";
import { DIFFICULTY_LABELS, DIFFICULTY_COLORS } from "@/utils/reviews";
import { LoadingState, EmptyState, ErrorState } from "@/components/ui/StateMessage";
import { useToast } from "@/components/ui/Toast";

export default function QuestionsStudy() {
  const navigate = useNavigate();
  const { showToast } = useToast();
  const { questions, loading, error, registerCorrect, registerWrong, reload } = useQuestions();

  const [sessionIds, setSessionIds] = useState<string[] | null>(null);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [revealed, setRevealed] = useState(false);
  const [sessionResults, setSessionResults] = useState<{ correct: number; wrong: number }>({ correct: 0, wrong: 0 });
  const [finished, setFinished] = useState(false);
  const [submitting, setSubmitting] = useState(false);

  const orderedQuestions = useMemo(() => selectStudyQuestions(questions), [questions]);

  const sessionQuestions = useMemo(() => {
    if (!sessionIds) return [];
    return sessionIds
      .map((id) => questions.find((q) => q.id === id))
      .filter((q): q is NonNullable<typeof q> => !!q);
  }, [sessionIds, questions]);

  const current = sessionQuestions[currentIndex];

  function startSession() {
    setSessionIds(orderedQuestions.map((q) => q.id));
    setCurrentIndex(0);
    setRevealed(false);
    setSessionResults({ correct: 0, wrong: 0 });
    setFinished(false);
  }

  function goToNext() {
    if (currentIndex + 1 >= sessionQuestions.length) {
      setFinished(true);
    } else {
      setCurrentIndex((i) => i + 1);
      setRevealed(false);
    }
  }

  async function handleCorrect() {
    if (!current || submitting) return;
    setSubmitting(true);
    const { error } = await registerCorrect(current.id, current.correct_count);
    setSubmitting(false);
    if (error) {
      showToast(error, "error");
      return;
    }
    setSessionResults((r) => ({ ...r, correct: r.correct + 1 }));
    showToast("Boa! Você acertou.");
    goToNext();
  }

  async function handleWrong() {
    if (!current || submitting) return;
    setSubmitting(true);
    const { error } = await registerWrong(current.id, current.wrong_count);
    setSubmitting(false);
    if (error) {
      showToast(error, "error");
      return;
    }
    setSessionResults((r) => ({ ...r, wrong: r.wrong + 1 }));
    showToast("Sem problema. Essa pergunta merece mais uma revisão.");
    goToNext();
  }

  useEffect(() => {
    if (finished) reload();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [finished]);

  // Atalhos de teclado no cartão ativo: Espaço mostra a resposta, 1 = Não sabia, 2 = Acertei.
  // Só ativos durante a sessão em andamento (não na tela inicial nem no resumo final).
  useEffect(() => {
    if (!sessionIds || finished) return;
    function handleKeyDown(e: KeyboardEvent) {
      if (e.code === "Space") {
        e.preventDefault();
        if (!revealed) setRevealed(true);
      } else if (e.key === "1" && revealed) {
        handleWrong();
      } else if (e.key === "2" && revealed) {
        handleCorrect();
      }
    }
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [sessionIds, finished, revealed, current]);

  if (loading) return <LoadingState label="Carregando perguntas..." />;
  if (error) return <ErrorState title="Não foi possível carregar as perguntas" description={error} />;

  if (questions.length === 0) {
    return (
      <div className="space-y-6">
        <Link to="/questions" className="flex items-center gap-1 text-sm text-brand-600 hover:underline dark:text-brand-400">
          <ArrowLeft className="h-4 w-4" /> Voltar para perguntas
        </Link>
        <EmptyState title="Você ainda não possui perguntas." description="Crie perguntas para poder estudar em modo flashcard." />
      </div>
    );
  }

  // Tela inicial: ainda não começou a sessão
  if (!sessionIds) {
    return (
      <div className="mx-auto max-w-md space-y-6 text-center">
        <Link to="/questions" className="flex items-center gap-1 text-sm text-brand-600 hover:underline dark:text-brand-400">
          <ArrowLeft className="h-4 w-4" /> Voltar para perguntas
        </Link>
        <div className="card">
          <h1 className="text-xl font-bold tracking-tight">Modo estudo</h1>
          <p className="mt-2 text-slate-600 dark:text-slate-300">
            Você tem {questions.length} {questions.length === 1 ? "pergunta" : "perguntas"} para estudar.
          </p>
          <p className="mt-1 text-sm text-slate-400">
            Priorizamos perguntas nunca revisadas, com mais erros, mais difíceis e revisadas há mais tempo.
          </p>
          <button onClick={startSession} className="btn-primary mt-6 w-full justify-center py-3">
            Começar
          </button>
        </div>
      </div>
    );
  }

  // Tela final: resumo da sessão
  if (finished) {
    const total = sessionResults.correct + sessionResults.wrong;
    const rate = accuracyRate(sessionResults.correct, sessionResults.wrong);
    return (
      <div className="mx-auto max-w-md space-y-6 text-center">
        <div className="card">
          <h1 className="text-xl font-bold tracking-tight">Estudo concluído! 🎉</h1>
          <div className="mt-6 grid grid-cols-3 gap-4">
            <div>
              <p className="text-2xl font-bold">{total}</p>
              <p className="text-xs text-slate-500 dark:text-slate-400">perguntas</p>
            </div>
            <div>
              <p className="text-2xl font-bold text-green-600">{sessionResults.correct}</p>
              <p className="text-xs text-slate-500 dark:text-slate-400">acertos</p>
            </div>
            <div>
              <p className="text-2xl font-bold text-red-600">{sessionResults.wrong}</p>
              <p className="text-xs text-slate-500 dark:text-slate-400">erros</p>
            </div>
          </div>
          <p className="mt-4 text-sm text-slate-500 dark:text-slate-400">
            {rate === null ? "Sem dados" : `${rate}% de aproveitamento`}
          </p>
          <div className="mt-6 flex gap-3">
            <button onClick={startSession} className="btn-secondary flex-1 justify-center">
              <RotateCcw className="h-4 w-4" /> Estudar novamente
            </button>
            <button onClick={() => navigate("/questions")} className="btn-primary flex-1 justify-center">
              Voltar para perguntas
            </button>
          </div>
        </div>
      </div>
    );
  }

  if (!current) return <LoadingState label="Carregando pergunta..." />;

  const progressPercent = Math.round((currentIndex / sessionQuestions.length) * 100);

  return (
    <div className="mx-auto max-w-md space-y-6">
      <div>
        <div className="flex items-center justify-between text-sm text-slate-500 dark:text-slate-400">
          <span>
            Pergunta {currentIndex + 1} de {sessionQuestions.length}
          </span>
          <span className={`rounded-full px-2 py-0.5 text-xs font-medium ${DIFFICULTY_COLORS[current.difficulty]}`}>
            {DIFFICULTY_LABELS[current.difficulty]}
          </span>
        </div>
        <div className="mt-2 h-2 w-full overflow-hidden rounded-full bg-slate-100 dark:bg-slate-800">
          <div className="h-full rounded-full bg-brand-600 transition-all" style={{ width: `${progressPercent}%` }} />
        </div>
      </div>

      <div className="card min-h-[220px]">
        <p className="text-lg font-semibold">{current.question}</p>

        {revealed && (
          <p className="mt-4 rounded-xl bg-slate-50 p-4 text-slate-700 dark:bg-slate-800 dark:text-slate-200">
            {current.answer}
          </p>
        )}
      </div>

      {revealed ? (
        <div className="flex gap-3">
          <button onClick={handleWrong} disabled={submitting} className="btn-secondary flex-1 justify-center py-3 text-red-600 hover:bg-red-50 dark:hover:bg-red-950/30">
            <XCircle className="h-4 w-4" /> Não sabia
          </button>
          <button onClick={handleCorrect} disabled={submitting} className="btn-primary flex-1 justify-center py-3">
            <CheckCircle2 className="h-4 w-4" /> Acertei
          </button>
        </div>
      ) : (
        <button onClick={() => setRevealed(true)} className="btn-primary w-full justify-center py-3">
          <Eye className="h-4 w-4" /> Mostrar resposta
        </button>
      )}
      <p className="hidden text-center text-xs text-slate-400 sm:block">
        Atalhos: Espaço para mostrar a resposta · 1 = Não sabia · 2 = Acertei
      </p>
    </div>
  );
}
