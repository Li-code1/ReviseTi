import { useState } from "react";
import { Calendar, Clock, CheckCircle2, RotateCcw, Pencil, Trash2, BookOpen } from "lucide-react";
import type { ReviewWithContent } from "@/types/database";
import {
  getReviewStatus,
  isToday,
  formatMinutes,
  formatReviewDate,
  DIFFICULTY_LABELS,
  DIFFICULTY_COLORS,
  STATUS_LABELS,
  STATUS_COLORS,
} from "@/utils/reviews";

interface Props {
  review: ReviewWithContent;
  onComplete: () => void;
  onUncomplete: () => void;
  onEdit: () => void;
  onDelete: () => void;
}

export function ReviewCard({ review, onComplete, onUncomplete, onEdit, onDelete }: Props) {
  const [menuOpen, setMenuOpen] = useState(false);
  const status = getReviewStatus(review);
  const today = isToday(review.review_date);

  return (
    <div className={`card ${today && status !== "completed" ? "border-brand-300 ring-1 ring-brand-100 dark:ring-brand-900" : ""}`}>
      <div className="flex items-start justify-between gap-4">
        <div className="min-w-0 flex-1">
          <div className="flex flex-wrap items-center gap-2">
            <p className={`font-semibold ${status === "completed" ? "text-slate-400 line-through" : ""}`}>{review.title}</p>
            {today && status !== "completed" && (
              <span className="rounded-full bg-brand-50 px-2 py-0.5 text-xs font-medium text-brand-700 dark:bg-brand-900/30 dark:text-brand-300">
                Hoje
              </span>
            )}
          </div>
          {review.content && (
            <p className="mt-0.5 flex items-center gap-1 text-sm text-slate-500 dark:text-slate-400">
              <BookOpen className="h-3.5 w-3.5 flex-shrink-0" /> {review.content.title}
            </p>
          )}

          <div className="mt-2 flex flex-wrap items-center gap-x-4 gap-y-1 text-sm text-slate-500 dark:text-slate-400">
            <span className="flex items-center gap-1">
              <Calendar className="h-3.5 w-3.5" /> {formatReviewDate(review.review_date)}
            </span>
            <span className="flex items-center gap-1">
              <Clock className="h-3.5 w-3.5" /> {formatMinutes(review.minutes)}
            </span>
            <span className={`rounded-full px-2 py-0.5 text-xs font-medium ${DIFFICULTY_COLORS[review.difficulty]}`}>
              {DIFFICULTY_LABELS[review.difficulty]}
            </span>
          </div>

          {review.notes && <p className="mt-2 text-sm text-slate-600 dark:text-slate-300">{review.notes}</p>}

          <span className={`mt-3 inline-block rounded-full px-2.5 py-1 text-xs font-medium ${STATUS_COLORS[status]}`}>
            {STATUS_LABELS[status]}
          </span>
        </div>

        {/* Ações - desktop: botões visíveis. Mobile: menu "..." */}
        <div className="hidden flex-shrink-0 items-center gap-2 sm:flex">
          {status === "completed" ? (
            <button onClick={onUncomplete} className="btn-secondary px-3 py-1.5 text-xs">
              <RotateCcw className="h-3.5 w-3.5" /> Desfazer
            </button>
          ) : (
            <button onClick={onComplete} className="btn-primary px-3 py-1.5 text-xs">
              <CheckCircle2 className="h-3.5 w-3.5" /> Concluir
            </button>
          )}
          <button onClick={onEdit} aria-label="Editar revisão" className="rounded-lg p-2 text-slate-400 hover:bg-slate-100 hover:text-slate-600 dark:hover:bg-slate-800">
            <Pencil className="h-4 w-4" />
          </button>
          <button onClick={onDelete} aria-label="Excluir revisão" className="rounded-lg p-2 text-slate-400 hover:bg-red-50 hover:text-red-600 dark:hover:bg-red-950/30">
            <Trash2 className="h-4 w-4" />
          </button>
        </div>

        <div className="relative flex-shrink-0 sm:hidden">
          <button
            onClick={() => setMenuOpen((v) => !v)}
            aria-label="Mais ações"
            aria-expanded={menuOpen}
            className="rounded-lg p-2 text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800"
          >
            ⋯
          </button>
          {menuOpen && (
            <div className="absolute right-0 z-10 mt-1 w-40 rounded-xl border border-slate-200 bg-white py-1 shadow-lg dark:border-slate-700 dark:bg-slate-900">
              <button
                onClick={() => { setMenuOpen(false); status === "completed" ? onUncomplete() : onComplete(); }}
                className="flex w-full items-center gap-2 px-3 py-2 text-left text-sm hover:bg-slate-50 dark:hover:bg-slate-800"
              >
                {status === "completed" ? <RotateCcw className="h-3.5 w-3.5" /> : <CheckCircle2 className="h-3.5 w-3.5" />}
                {status === "completed" ? "Desfazer" : "Concluir"}
              </button>
              <button
                onClick={() => { setMenuOpen(false); onEdit(); }}
                className="flex w-full items-center gap-2 px-3 py-2 text-left text-sm hover:bg-slate-50 dark:hover:bg-slate-800"
              >
                <Pencil className="h-3.5 w-3.5" /> Editar
              </button>
              <button
                onClick={() => { setMenuOpen(false); onDelete(); }}
                className="flex w-full items-center gap-2 px-3 py-2 text-left text-sm text-red-600 hover:bg-red-50 dark:hover:bg-red-950/30"
              >
                <Trash2 className="h-3.5 w-3.5" /> Excluir
              </button>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
