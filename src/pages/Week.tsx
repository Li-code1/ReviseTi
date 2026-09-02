import { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { ArrowLeft, CheckCircle2, Circle, Clock } from "lucide-react";
import { useAuth } from "@/hooks/useAuth";
import { listContentsByWeek } from "@/repositories/contentRepository";
import { getProgressMap } from "@/repositories/progressRepository";
import type { StudyContent } from "@/types/database";
import { LoadingState, EmptyState, ErrorState } from "@/components/ui/StateMessage";

const WEEK_TITLES: Record<number, string> = {
  1: "Backend Sólido",
  2: "Base Web",
  3: "React + TypeScript",
  4: "DevOps",
  5: "Entrevista + Portfólio",
};

export default function Week() {
  const { weekNumber } = useParams<{ weekNumber: string }>();
  const { user } = useAuth();
  const week = Number(weekNumber);

  const [lessons, setLessons] = useState<StudyContent[]>([]);
  const [progress, setProgress] = useState<Record<string, boolean>>({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!week) return;
    (async () => {
      setLoading(true);
      const [contentsRes, progressMap] = await Promise.all([
        listContentsByWeek(week),
        user ? getProgressMap(user.id) : Promise.resolve({}),
      ]);
      setLessons(contentsRes.data);
      setError(contentsRes.error);
      setProgress(progressMap);
      setLoading(false);
    })();
  }, [week, user]);

  if (loading) return <LoadingState label="Carregando a semana..." />;
  if (error) return <ErrorState title="Não foi possível carregar a semana" description={error} />;

  const completed = lessons.filter((l) => progress[l.id]).length;
  const percent = lessons.length > 0 ? Math.round((completed / lessons.length) * 100) : 0;

  return (
    <div className="space-y-6">
      <Link to="/contents" className="flex items-center gap-1 text-sm text-brand-600 hover:underline dark:text-brand-400">
        <ArrowLeft className="h-4 w-4" /> Voltar para conteúdos
      </Link>

      <div className="flex flex-wrap items-start justify-between gap-3">
        <div>
          <p className="text-xs font-medium uppercase tracking-wide text-brand-600 dark:text-brand-400">Semana {week}</p>
          <h1 className="mt-1 text-2xl font-bold tracking-tight">{WEEK_TITLES[week] ?? `Semana ${week}`}</h1>
          <div className="mt-3 flex items-center gap-3">
            <div className="h-2 w-40 overflow-hidden rounded-full bg-slate-100 dark:bg-slate-800">
              <div className="h-full rounded-full bg-brand-600 transition-all" style={{ width: `${percent}%` }} />
            </div>
            <span className="text-sm text-slate-500 dark:text-slate-400">
              {completed}/{lessons.length} concluídas · {percent}%
            </span>
          </div>
        </div>
        <Link to={`/study/week/${week}`} className="btn-secondary flex-shrink-0">
          Revisar Semana {week}
        </Link>
      </div>

      {lessons.length === 0 ? (
        <EmptyState title="Nenhuma aula encontrada para esta semana." />
      ) : (
        <div className="space-y-3">
          {lessons.map((l) => {
            const isDone = !!progress[l.id];
            return (
              <Link
                key={l.id}
                to={`/contents/${l.slug}`}
                className="card flex items-center justify-between gap-4 transition hover:border-brand-300"
              >
                <div className="flex items-start gap-3">
                  {isDone ? (
                    <CheckCircle2 className="mt-0.5 h-5 w-5 flex-shrink-0 text-green-600" />
                  ) : (
                    <Circle className="mt-0.5 h-5 w-5 flex-shrink-0 text-slate-300 dark:text-slate-600" />
                  )}
                  <div>
                    <p className="text-xs font-medium text-slate-500 dark:text-slate-400">{l.day_name}</p>
                    <p className="font-semibold">{l.title}</p>
                    {l.description && <p className="mt-0.5 text-sm text-slate-500 dark:text-slate-400">{l.description}</p>}
                    <p className="mt-1 flex items-center gap-1 text-xs text-slate-400">
                      <Clock className="h-3.5 w-3.5" /> {l.estimated_minutes} min
                    </p>
                  </div>
                </div>
                <span className="flex-shrink-0 text-sm font-medium text-brand-600 dark:text-brand-400">Estudar</span>
              </Link>
            );
          })}
        </div>
      )}
    </div>
  );
}
