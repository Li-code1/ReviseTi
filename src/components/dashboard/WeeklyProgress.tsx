import { Link } from "react-router-dom";
import type { WeekProgress } from "@/services/progressService";

const WEEK_TITLES: Record<number, string> = {
  1: "Backend Sólido",
  2: "Base Web",
  3: "React + TypeScript",
  4: "DevOps",
  5: "Entrevista + Portfólio",
};

export function WeeklyProgress({ weeks }: { weeks: WeekProgress[] }) {
  if (weeks.length === 0) {
    return <p className="text-sm text-slate-400">Nenhum conteúdo cadastrado ainda.</p>;
  }

  return (
    <div className="space-y-3">
      {weeks.map((w) => (
        <Link
          key={w.weekNumber}
          to={`/contents/week/${w.weekNumber}`}
          className="block rounded-xl border border-slate-100 p-3 transition hover:border-brand-300 dark:border-slate-800"
        >
          <div className="flex items-center justify-between text-sm">
            <span className="font-medium">
              Semana {w.weekNumber} — {WEEK_TITLES[w.weekNumber] ?? ""}
            </span>
            <span className="text-slate-500 dark:text-slate-400">{w.percent}%</span>
          </div>
          <div className="mt-2 h-2 w-full overflow-hidden rounded-full bg-slate-100 dark:bg-slate-800">
            <div className="h-full rounded-full bg-brand-600 transition-all" style={{ width: `${w.percent}%` }} />
          </div>
          <p className="mt-1 text-xs text-slate-400">
            {w.completed}/{w.total} concluídas
          </p>
        </Link>
      ))}
    </div>
  );
}
