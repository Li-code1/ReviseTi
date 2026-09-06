import { useEffect, useMemo, useState } from "react";
import { Link } from "react-router-dom";
import { ArrowRight, Search } from "lucide-react";
import { useAuth } from "@/hooks/useAuth";
import { listContents } from "@/repositories/contentRepository";
import { getProgressMap } from "@/repositories/progressRepository";
import type { StudyContent } from "@/types/database";
import { EmptyState, ErrorState } from "@/components/ui/StateMessage";
import { PageSkeleton } from "@/components/ui/Skeleton";

const WEEK_TITLES: Record<number, string> = {
  1: "Backend Sólido",
  2: "Base Web",
  3: "React + TypeScript",
  4: "DevOps",
  5: "Entrevista + Portfólio",
};

export default function Contents() {
  const { user } = useAuth();
  const [contents, setContents] = useState<StudyContent[]>([]);
  const [progress, setProgress] = useState<Record<string, boolean>>({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [search, setSearch] = useState("");
  const [weekFilter, setWeekFilter] = useState<number | "all">("all");

  useEffect(() => {
    (async () => {
      setLoading(true);
      const [contentsRes, progressMap] = await Promise.all([
        listContents(),
        user ? getProgressMap(user.id) : Promise.resolve({}),
      ]);
      setContents(contentsRes.data);
      setError(contentsRes.error);
      setProgress(progressMap);
      setLoading(false);
    })();
  }, [user]);

  const weeks = useMemo(() => {
    const grouped = new Map<number, StudyContent[]>();
    for (const c of contents) {
      grouped.set(c.week_number, [...(grouped.get(c.week_number) ?? []), c]);
    }
    return Array.from(grouped.entries()).sort(([a], [b]) => a - b);
  }, [contents]);

  const searchResults = useMemo(() => {
    if (!search.trim()) return null;
    const term = search.trim().toLowerCase();
    return contents.filter(
      (c) =>
        c.title.toLowerCase().includes(term) ||
        (c.description ?? "").toLowerCase().includes(term)
    );
  }, [contents, search]);

  const visibleWeeks = useMemo(() => {
    if (weekFilter === "all") return weeks;
    return weeks.filter(([week]) => week === weekFilter);
  }, [weeks, weekFilter]);

  if (loading) return <PageSkeleton />;
  if (error) return <ErrorState title="Não foi possível carregar os conteúdos" description={error} />;

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Conteúdos</h1>
        <p className="mt-1 text-slate-500 dark:text-slate-400">Estude os conteúdos do seu cronograma.</p>
      </div>

      <div className="flex flex-col gap-3 sm:flex-row">
        <div className="relative flex-1">
          <Search className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400" />
          <input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Buscar por título ou descrição..."
            className="input-field pl-9"
            aria-label="Buscar conteúdos"
          />
        </div>
        <select
          value={weekFilter}
          onChange={(e) => setWeekFilter(e.target.value === "all" ? "all" : Number(e.target.value))}
          className="input-field sm:w-48"
          aria-label="Filtrar por semana"
        >
          <option value="all">Todas as semanas</option>
          {weeks.map(([week]) => (
            <option key={week} value={week}>
              Semana {week}
            </option>
          ))}
        </select>
      </div>

      {contents.length === 0 ? (
        <EmptyState title="Nenhum conteúdo cadastrado ainda" description="Volte em breve para ver o cronograma completo." />
      ) : searchResults ? (
        searchResults.length === 0 ? (
          <EmptyState title="Nenhum conteúdo encontrado." description="Tente buscar por outro termo." />
        ) : (
          <div className="space-y-3">
            {searchResults.map((c) => (
              <Link key={c.id} to={`/contents/${c.slug}`} className="card flex items-center justify-between gap-4 transition hover:border-brand-300">
                <div>
                  <p className="text-xs font-medium uppercase tracking-wide text-brand-600 dark:text-brand-400">
                    Semana {c.week_number} · {c.day_name}
                  </p>
                  <p className="mt-1 font-semibold">{c.title}</p>
                  {c.description && <p className="mt-1 text-sm text-slate-500 dark:text-slate-400">{c.description}</p>}
                </div>
                {progress[c.id] && <span className="flex-shrink-0 text-xs font-medium text-green-600">✓ Concluída</span>}
              </Link>
            ))}
          </div>
        )
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {visibleWeeks.map(([weekNumber, items]) => {
            const completed = items.filter((c) => progress[c.id]).length;
            const percent = items.length > 0 ? Math.round((completed / items.length) * 100) : 0;
            return (
              <div key={weekNumber} className="card flex flex-col">
                <p className="text-xs font-medium uppercase tracking-wide text-brand-600 dark:text-brand-400">
                  Semana {weekNumber}
                </p>
                <p className="mt-1 font-semibold">{WEEK_TITLES[weekNumber] ?? `Semana ${weekNumber}`}</p>
                <p className="mt-1 text-sm text-slate-500 dark:text-slate-400">
                  {items.length} {items.length === 1 ? "aula" : "aulas"} · {percent}% concluído
                </p>
                <div className="mt-3 h-2 w-full overflow-hidden rounded-full bg-slate-100 dark:bg-slate-800">
                  <div className="h-full rounded-full bg-brand-600 transition-all" style={{ width: `${percent}%` }} />
                </div>
                <Link
                  to={`/contents/week/${weekNumber}`}
                  className="mt-4 flex items-center gap-1 text-sm font-medium text-brand-600 hover:underline dark:text-brand-400"
                >
                  Ver semana <ArrowRight className="h-3.5 w-3.5" />
                </Link>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
