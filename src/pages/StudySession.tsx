import { useEffect, useMemo, useState } from "react";
import { useParams, useNavigate, Link } from "react-router-dom";
import { ArrowLeft, CheckCircle2, XCircle, RotateCcw, Shuffle } from "lucide-react";
import { useAuth } from "@/hooks/useAuth";
import {
  listQuestionsByContent,
  listQuestionsByWeek,
  listQuestionsByCategory,
  listInterviewQuestions,
  listAllCached,
  recordAttempt,
} from "@/repositories/officialQuestionRepository";
import { getContentBySlug } from "@/repositories/contentRepository";
import { DIFFICULTY_LABELS, DIFFICULTY_COLORS } from "@/utils/reviews";
import { accuracyRate } from "@/utils/questions";
import { LoadingState, EmptyState, ErrorState } from "@/components/ui/StateMessage";
import type { OfficialQuestion } from "@/types/database";

type Mode = "lesson" | "week" | "general" | "category";

interface Props {
  mode: Mode;
}

function shuffle<T>(arr: T[]): T[] {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

export default function StudySession({ mode }: Props) {
  const params = useParams();
  const navigate = useNavigate();
  const { user } = useAuth();

  const [title, setTitle] = useState("Revisão");
  const [questions, setQuestions] = useState<OfficialQuestion[]>([]);
  const [loading, setLoading] = useState(true);
  const [started, setStarted] = useState(false);
  const [index, setIndex] = useState(0);
  const [revealed, setRevealed] = useState(false);
  const [selected, setSelected] = useState<string | null>(null);
  const [results, setResults] = useState({ correct: 0, wrong: 0 });
  const [finished, setFinished] = useState(false);
  const [answering, setAnswering] = useState(false);

  const [loadError, setLoadError] = useState<string | null>(null);

  useEffect(() => {
    (async () => {
      setLoading(true);
      setLoadError(null);
      let list: OfficialQuestion[] = [];
      try {
        if (mode === "lesson" && params.slug) {
          const { data: content } = await getContentBySlug(params.slug);
          if (content) {
            setTitle(`Revisão — ${content.title}`);
            list = await listQuestionsByContent(content.id);
          }
        } else if (mode === "week" && params.weekNumber) {
          setTitle(`Revisão — Semana ${params.weekNumber}`);
          list = await listQuestionsByWeek(Number(params.weekNumber));
        } else if (mode === "category" && params.category) {
          if (params.category === "interview") {
            setTitle("Simulado de entrevista");
            list = await listInterviewQuestions();
          } else {
            setTitle(`Perguntas — ${params.category}`);
            list = await listQuestionsByCategory(params.category);
          }
        } else {
          setTitle("Revisão geral");
          list = await listAllCached();
        }
        setQuestions(shuffle(list));
      } catch {
        setLoadError("Não foi possível carregar as perguntas. Tente novamente.");
      } finally {
        setLoading(false);
      }
    })();
  }, [mode, params.slug, params.weekNumber, params.category]);

  const current = questions[index];

  function start() {
    setStarted(true);
    setIndex(0);
    setRevealed(false);
    setSelected(null);
    setResults({ correct: 0, wrong: 0 });
    setFinished(false);
  }

  function goNext() {
    if (index + 1 >= questions.length) setFinished(true);
    else {
      setIndex((i) => i + 1);
      setRevealed(false);
      setSelected(null);
    }
  }

  async function handleAnswer(isCorrect: boolean, answerGiven: string | null) {
    if (answering) return;
    setAnswering(true);
    if (user && current) {
      recordAttempt({
        user_id: user.id,
        official_question_id: current.id,
        selected_answer: answerGiven,
        is_correct: isCorrect,
      });
    }
    setResults((r) => (isCorrect ? { ...r, correct: r.correct + 1 } : { ...r, wrong: r.wrong + 1 }));
    goNext();
    setAnswering(false);
  }

  function selectOption(optionId: string) {
    if (revealed || !current) return;
    setSelected(optionId);
    setRevealed(true);
  }

  if (loading) return <LoadingState label="Carregando perguntas..." />;
  if (loadError) return <ErrorState title="Algo deu errado" description={loadError} />;

  if (questions.length === 0) {
    return (
      <div className="space-y-6">
        <Link to="/questions" className="flex items-center gap-1 text-sm text-brand-600 hover:underline dark:text-brand-400">
          <ArrowLeft className="h-4 w-4" /> Voltar
        </Link>
        <EmptyState title="Nenhuma pergunta encontrada para esta revisão." />
      </div>
    );
  }

  if (!started) {
    return (
      <div className="mx-auto max-w-md space-y-6 text-center">
        <Link to="/questions" className="flex items-center gap-1 text-sm text-brand-600 hover:underline dark:text-brand-400">
          <ArrowLeft className="h-4 w-4" /> Voltar
        </Link>
        <div className="card">
          <h1 className="text-xl font-bold tracking-tight">{title}</h1>
          <p className="mt-2 flex items-center justify-center gap-1.5 text-slate-600 dark:text-slate-300">
            <Shuffle className="h-4 w-4" /> {questions.length} {questions.length === 1 ? "pergunta" : "perguntas"}, em ordem aleatória
          </p>
          <button onClick={start} className="btn-primary mt-6 w-full justify-center py-3">
            Começar
          </button>
        </div>
      </div>
    );
  }

  if (finished) {
    const total = results.correct + results.wrong;
    const rate = accuracyRate(results.correct, results.wrong);
    return (
      <div className="mx-auto max-w-md space-y-6 text-center">
        <div className="card">
          <h1 className="text-xl font-bold tracking-tight">Revisão concluída! 🎉</h1>
          <div className="mt-6 grid grid-cols-3 gap-4">
            <div>
              <p className="text-2xl font-bold">{total}</p>
              <p className="text-xs text-slate-500 dark:text-slate-400">perguntas</p>
            </div>
            <div>
              <p className="text-2xl font-bold text-green-600">{results.correct}</p>
              <p className="text-xs text-slate-500 dark:text-slate-400">acertos</p>
            </div>
            <div>
              <p className="text-2xl font-bold text-red-600">{results.wrong}</p>
              <p className="text-xs text-slate-500 dark:text-slate-400">erros</p>
            </div>
          </div>
          <p className="mt-4 text-sm text-slate-500 dark:text-slate-400">
            {rate === null ? "Sem dados" : `${rate}% de aproveitamento`}
          </p>
          <div className="mt-6 flex gap-3">
            <button onClick={start} className="btn-secondary flex-1 justify-center">
              <RotateCcw className="h-4 w-4" /> Revisar novamente
            </button>
            <button onClick={() => navigate(-1)} className="btn-primary flex-1 justify-center">
              Voltar
            </button>
          </div>
        </div>
      </div>
    );
  }

  if (!current) return <LoadingState label="Carregando..." />;
  const progressPercent = Math.round((index / questions.length) * 100);
  const isChoice = current.question_type === "multiple_choice" || current.question_type === "true_false";

  return (
    <div className="mx-auto max-w-2xl space-y-6">
      <div>
        <div className="flex items-center justify-between text-sm text-slate-500 dark:text-slate-400">
          <span>Pergunta {index + 1} de {questions.length}</span>
          <span className={`rounded-full px-2 py-0.5 text-xs font-medium ${DIFFICULTY_COLORS[current.difficulty]}`}>
            {DIFFICULTY_LABELS[current.difficulty]}
          </span>
        </div>
        <div className="mt-2 h-2 w-full overflow-hidden rounded-full bg-slate-100 dark:bg-slate-800">
          <div className="h-full rounded-full bg-brand-600 transition-all" style={{ width: `${progressPercent}%` }} />
        </div>
      </div>

      <div className="card space-y-4">
        <p className="whitespace-pre-wrap text-lg font-semibold">{current.question}</p>

        {isChoice && current.options && (
          <div className="space-y-2">
            {current.options.map((opt) => {
              const isCorrectOpt = opt.id === current.correct_option;
              const isSelected = opt.id === selected;
              let style = "border-slate-200 dark:border-slate-700 hover:bg-slate-50 dark:hover:bg-slate-800";
              if (revealed && isCorrectOpt) style = "border-green-500 bg-green-50 dark:bg-green-900/20";
              else if (revealed && isSelected && !isCorrectOpt) style = "border-red-500 bg-red-50 dark:bg-red-900/20";
              return (
                <button
                  key={opt.id}
                  onClick={() => selectOption(opt.id)}
                  disabled={revealed}
                  className={`block w-full rounded-xl border px-4 py-3 text-left text-sm transition ${style}`}
                >
                  {opt.text}
                </button>
              );
            })}
          </div>
        )}

        {!isChoice && !revealed && (
          <button onClick={() => setRevealed(true)} className="btn-primary w-full justify-center py-3">
            Mostrar resposta
          </button>
        )}

        {revealed && (
          <div className="space-y-3 border-t border-slate-100 pt-4 dark:border-slate-800">
            <div>
              <p className="text-xs font-medium uppercase tracking-wide text-slate-400">Resposta</p>
              <p className="mt-1 whitespace-pre-wrap text-slate-700 dark:text-slate-300">{current.answer}</p>
            </div>
            <div>
              <p className="text-xs font-medium uppercase tracking-wide text-slate-400">Explicação</p>
              <p className="mt-1 whitespace-pre-wrap text-sm text-slate-600 dark:text-slate-400">{current.explanation}</p>
            </div>

            {isChoice ? (
              <button onClick={() => handleAnswer(selected === current.correct_option, selected)} disabled={answering} className="btn-primary w-full justify-center py-3">
                Próxima
              </button>
            ) : (
              <div className="flex gap-3">
                <button
                  onClick={() => handleAnswer(false, null)}
                  disabled={answering}
                  className="btn-secondary flex-1 justify-center py-3 text-red-600 hover:bg-red-50 dark:hover:bg-red-950/30"
                >
                  <XCircle className="h-4 w-4" /> Não sabia
                </button>
                <button onClick={() => handleAnswer(true, null)} disabled={answering} className="btn-primary flex-1 justify-center py-3">
                  <CheckCircle2 className="h-4 w-4" /> Acertei
                </button>
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
