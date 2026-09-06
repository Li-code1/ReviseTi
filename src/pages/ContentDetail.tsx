import { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import ReactMarkdown from "react-markdown";
import remarkGfm from "remark-gfm";
import { ArrowLeft, Clock, CheckCircle2, ChevronRight, Loader2, HelpCircle } from "lucide-react";
import { useAuth } from "@/hooks/useAuth";
import { getContentBySlug, getTopicsForContent } from "@/repositories/contentRepository";
import { listProgress, markContentCompleted } from "@/repositories/progressRepository";
import type { StudyContent, ContentTopic } from "@/types/database";
import { LoadingState, ErrorState } from "@/components/ui/StateMessage";
import { useToast } from "@/components/ui/Toast";
import { actionToastMessage } from "@/utils/offlineToast";
import { useOnlineStatus } from "@/hooks/useOnlineStatus";

const WEEK_TITLES: Record<number, string> = {
  1: "Backend Sólido",
  2: "Base Web",
  3: "React + TypeScript",
  4: "DevOps",
  5: "Entrevista + Portfólio",
};

export default function ContentDetail() {
  const { id } = useParams<{ id: string }>();
  const { user } = useAuth();
  const { isOnline } = useOnlineStatus();
  const { showToast } = useToast();

  const [content, setContent] = useState<StudyContent | null>(null);
  const [topics, setTopics] = useState<ContentTopic[]>([]);
  const [completed, setCompleted] = useState(false);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [togglingCompletion, setTogglingCompletion] = useState(false);

  useEffect(() => {
    if (!id) return;
    (async () => {
      setLoading(true);
      const contentRes = await getContentBySlug(id);
      if (contentRes.error || !contentRes.data) {
        setError(contentRes.error ?? "Conteúdo não encontrado.");
        setLoading(false);
        return;
      }
      setContent(contentRes.data);

      const [topicsRes, progressRes] = await Promise.all([
        getTopicsForContent(contentRes.data.id),
        user ? listProgress(user.id) : Promise.resolve({ data: [], error: null }),
      ]);
      setTopics(topicsRes.data);
      setCompleted(progressRes.data.some((p) => p.content_id === contentRes.data!.id && p.completed));
      setLoading(false);
    })();
  }, [id, user]);

  async function handleToggleCompleted() {
    if (!user || !content) return;
    setTogglingCompletion(true);
    const nextState = !completed;
    const { error } = await markContentCompleted(user.id, content.id, nextState);
    setTogglingCompletion(false);
    if (error) {
      showToast(error, "error");
      return;
    }
    setCompleted(nextState);
    showToast(actionToastMessage(nextState ? "Conteúdo concluído! 🎉" : "Conclusão desfeita.", isOnline));
  }

  if (loading) return <LoadingState label="Carregando conteúdo..." />;
  if (error || !content) return <ErrorState title="Conteúdo não encontrado" description={error ?? undefined} />;

  return (
    <div className="space-y-6">
      <nav aria-label="Breadcrumb" className="flex flex-wrap items-center gap-1 text-sm text-slate-500 dark:text-slate-400">
        <Link to="/contents" className="hover:text-brand-600 dark:hover:text-brand-400">Conteúdos</Link>
        <ChevronRight className="h-3.5 w-3.5" />
        <Link to={`/contents/week/${content.week_number}`} className="hover:text-brand-600 dark:hover:text-brand-400">
          Semana {content.week_number} — {WEEK_TITLES[content.week_number] ?? ""}
        </Link>
        <ChevronRight className="h-3.5 w-3.5" />
        <span className="text-slate-700 dark:text-slate-300">{content.title}</span>
      </nav>

      <Link to={`/contents/week/${content.week_number}`} className="flex items-center gap-1 text-sm text-brand-600 hover:underline dark:text-brand-400 lg:hidden">
        <ArrowLeft className="h-4 w-4" /> Voltar para a semana
      </Link>

      <div className="card">
        <div className="flex flex-wrap items-start justify-between gap-4">
          <div>
            <p className="text-xs font-medium uppercase tracking-wide text-brand-600 dark:text-brand-400">
              Semana {content.week_number} · {content.day_name}
            </p>
            <h1 className="mt-1 text-2xl font-bold tracking-tight">{content.title}</h1>
          </div>
          <button
            onClick={handleToggleCompleted}
            disabled={togglingCompletion}
            className={completed ? "btn-secondary border-green-200 text-green-700 dark:border-green-900 dark:text-green-400" : "btn-primary"}
          >
            {togglingCompletion ? (
              <Loader2 className="h-4 w-4 animate-spin" />
            ) : completed ? (
              <CheckCircle2 className="h-4 w-4" />
            ) : null}
            {completed ? "Aula concluída" : "Marcar como concluída"}
          </button>
        </div>

        <p className="mt-2 flex items-center gap-1.5 text-sm text-slate-500 dark:text-slate-400">
          <Clock className="h-4 w-4" /> {content.estimated_minutes} min estimados
        </p>
        <Link
          to={`/study/lesson/${content.slug}`}
          className="mt-3 inline-flex items-center gap-1.5 text-sm font-medium text-brand-600 hover:underline dark:text-brand-400"
        >
          <HelpCircle className="h-4 w-4" /> Revisar esta aula
        </Link>
        {content.description && <p className="mt-4 text-slate-600 dark:text-slate-300">{content.description}</p>}
      </div>

      {topics.length > 0 && (
        <div className="card">
          <h2 className="mb-3 text-lg font-semibold">Tópicos desta aula</h2>
          <div className="flex flex-wrap gap-2">
            {topics.map((t) => (
              <span
                key={t.id}
                className="rounded-full bg-brand-50 px-3 py-1 text-xs font-medium text-brand-700 dark:bg-brand-900/30 dark:text-brand-300"
              >
                {t.title}
              </span>
            ))}
          </div>
        </div>
      )}

      <div className="card">
        {content.content ? (
          <article className="prose prose-slate max-w-none prose-headings:font-bold prose-h1:text-xl prose-h2:text-lg prose-h2:mt-6 prose-pre:overflow-x-auto prose-pre:rounded-xl prose-pre:bg-slate-900 prose-code:text-brand-700 dark:prose-invert dark:prose-code:text-brand-400">
            <ReactMarkdown remarkPlugins={[remarkGfm]}>{content.content}</ReactMarkdown>
          </article>
        ) : (
          <p className="text-sm text-slate-400">O conteúdo completo desta aula será adicionado em breve.</p>
        )}
      </div>
    </div>
  );
}
