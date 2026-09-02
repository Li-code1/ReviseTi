import { useMemo, useState } from "react";
import { ChevronLeft, ChevronRight } from "lucide-react";
import type { ReviewWithContent } from "@/types/database";
import { getReviewStatus, todayISODate } from "@/utils/reviews";
import { dateToISODate } from "@/utils/time";

const WEEKDAY_LABELS = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sáb", "Dom"];
const MONTH_LABELS = [
  "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
  "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro",
];

// Mesma paleta de status já usada no resto do app (utils/reviews STATUS_COLORS),
// só que como cor de "ponto" sólida em vez de fundo de badge.
const DOT_COLOR: Record<string, string> = {
  overdue: "bg-red-500",
  pending: "bg-brand-500",
  completed: "bg-green-500",
};

interface Props {
  reviews: ReviewWithContent[];
  selectedDate: string | null;
  onSelectDate: (date: string) => void;
}

function buildMonthGrid(year: number, month: number): Date[] {
  const firstOfMonth = new Date(year, month, 1);
  const startWeekday = (firstOfMonth.getDay() + 6) % 7; // 0 = segunda
  const gridStart = new Date(year, month, 1 - startWeekday);
  return Array.from({ length: 42 }, (_, i) => {
    const d = new Date(gridStart);
    d.setDate(gridStart.getDate() + i);
    return d;
  });
}

export function ReviewCalendar({ reviews, selectedDate, onSelectDate }: Props) {
  const today = new Date();
  const [cursor, setCursor] = useState(new Date(today.getFullYear(), today.getMonth(), 1));

  const reviewsByDate = useMemo(() => {
    const map = new Map<string, ReviewWithContent[]>();
    for (const r of reviews) {
      map.set(r.review_date, [...(map.get(r.review_date) ?? []), r]);
    }
    return map;
  }, [reviews]);

  const days = useMemo(() => buildMonthGrid(cursor.getFullYear(), cursor.getMonth()), [cursor]);
  const todayISO = todayISODate();

  function goToMonth(delta: number) {
    setCursor((c) => new Date(c.getFullYear(), c.getMonth() + delta, 1));
  }

  function goToToday() {
    setCursor(new Date(today.getFullYear(), today.getMonth(), 1));
    onSelectDate(todayISO);
  }

  return (
    <div className="card">
      <div className="mb-4 flex items-center justify-between">
        <h2 className="text-base font-semibold">
          {MONTH_LABELS[cursor.getMonth()]} {cursor.getFullYear()}
        </h2>
        <div className="flex items-center gap-1">
          <button
            onClick={() => goToMonth(-1)}
            aria-label="Mês anterior"
            className="rounded-lg p-1.5 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800"
          >
            <ChevronLeft className="h-4 w-4" />
          </button>
          <button onClick={goToToday} className="rounded-lg px-2.5 py-1 text-xs font-medium text-brand-600 hover:bg-brand-50 dark:text-brand-400 dark:hover:bg-brand-900/30">
            Hoje
          </button>
          <button
            onClick={() => goToMonth(1)}
            aria-label="Próximo mês"
            className="rounded-lg p-1.5 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800"
          >
            <ChevronRight className="h-4 w-4" />
          </button>
        </div>
      </div>

      <div className="grid grid-cols-7 gap-1 text-center text-xs font-medium text-slate-400">
        {WEEKDAY_LABELS.map((d) => (
          <div key={d} className="py-1">{d}</div>
        ))}
      </div>

      <div className="grid grid-cols-7 gap-1">
        {days.map((day) => {
          const iso = dateToISODate(day);
          const isCurrentMonth = day.getMonth() === cursor.getMonth();
          const isToday = iso === todayISO;
          const isSelected = iso === selectedDate;
          const dayReviews = reviewsByDate.get(iso) ?? [];

          // Prioriza o status mais "urgente" presente naquele dia para o ponto indicador.
          const statuses = dayReviews.map((r) => getReviewStatus(r));
          const dominant = statuses.includes("overdue")
            ? "overdue"
            : statuses.includes("pending")
            ? "pending"
            : statuses.length > 0
            ? "completed"
            : null;

          return (
            <button
              key={iso}
              onClick={() => onSelectDate(iso)}
              aria-label={`${day.getDate()} de ${MONTH_LABELS[day.getMonth()]}${dayReviews.length > 0 ? `, ${dayReviews.length} revisão(ões)` : ""}`}
              aria-current={isToday ? "date" : undefined}
              className={`flex aspect-square flex-col items-center justify-center gap-0.5 rounded-lg text-sm transition ${
                !isCurrentMonth ? "text-slate-300 dark:text-slate-700" : "text-slate-700 dark:text-slate-300"
              } ${isSelected ? "bg-brand-600 text-white hover:bg-brand-700" : isToday ? "bg-brand-50 font-semibold text-brand-700 dark:bg-brand-900/30 dark:text-brand-300" : "hover:bg-slate-100 dark:hover:bg-slate-800"}`}
            >
              <span>{day.getDate()}</span>
              {dominant && (
                <span className={`h-1.5 w-1.5 rounded-full ${isSelected ? "bg-white" : DOT_COLOR[dominant]}`} />
              )}
            </button>
          );
        })}
      </div>
    </div>
  );
}
