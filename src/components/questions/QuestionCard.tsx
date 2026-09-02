import { useState } from "react";
import { Link } from "react-router-dom";
import { CheckCircle2, XCircle, BookOpen, Pencil, Trash2, Play } from "lucide-react";
import type { QuestionWithContent } from "@/types/database";
import { DIFFICULTY_LABELS, DIFFICULTY_COLORS } from "@/utils/reviews";
import { formatLastReviewed, needsReview } from "@/utils/questions";

interface Props {
  question: QuestionWithContent;
  onEdit: () => void;
  onDelete: () => void;
}

export function QuestionCard({ question: q, onEdit, onDelete }: Props) {
  const [menuOpen, setMenuOpen] = useState(false);

  return (
    <div className="card">
      <div className="flex items-start justify-between gap-4">
        <div className="min-w-0 flex-1">
          <p className="font-semibold">{q.question}</p>

          {q.content ? (
            <Link
              to={`/contents/${q.content.slug}`}
              className="mt-1 flex items-center gap-1 text-sm text-brand-600 hover:underline dark:text-brand-400"
            >
              <BookOpen className="h-3.5 w-3.5 flex-shrink-0" /> {q.content.title}
            </Link>
          ) : (
            <p className="mt-1 text-sm text-slate-400">Sem aula relacionada.</p>
          )}

          <div className="mt-2 flex flex-wrap items-center gap-x-4 gap-y-1 text-sm text-slate-500 dark:text-slate-400">
            <span className={`rounded-full px-2 py-0.5 text-xs font-medium ${DIFFICULTY_COLORS[q.difficulty]}`}>
              {DIFFICULTY_LABELS[q.difficulty]}
            </span>
            <span className="flex items-center gap-1 text-green-600 dark:text-green-400">
              <CheckCircle2 className="h-3.5 w-3.5" /> {q.correct_count} acertos
            </span>
            <span className="flex items-center gap-1 text-red-600 dark:text-red-400">
              <XCircle className="h-3.5 w-3.5" /> {q.wrong_count} erros
            </span>
            {needsReview(q) && (
              <span className="rounded-full bg-yellow-50 px-2 py-0.5 text-xs font-medium text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-300">
                Preciso revisar
              </span>
            )}
          </div>
          <p className="mt-1 text-xs text-slate-400">{formatLastReviewed(q.last_reviewed_at)}</p>
        </div>

        <div className="hidden flex-shrink-0 items-center gap-2 sm:flex">
          <Link to={`/questions/${q.id}`} className="btn-secondary px-3 py-1.5 text-xs">
            <Play className="h-3.5 w-3.5" /> Estudar
          </Link>
          <button onClick={onEdit} aria-label="Editar pergunta" className="rounded-lg p-2 text-slate-400 hover:bg-slate-100 hover:text-slate-600 dark:hover:bg-slate-800">
            <Pencil className="h-4 w-4" />
          </button>
          <button onClick={onDelete} aria-label="Excluir pergunta" className="rounded-lg p-2 text-slate-400 hover:bg-red-50 hover:text-red-600 dark:hover:bg-red-950/30">
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
              <Link
                to={`/questions/${q.id}`}
                className="flex items-center gap-2 px-3 py-2 text-sm hover:bg-slate-50 dark:hover:bg-slate-800"
              >
                <Play className="h-3.5 w-3.5" /> Estudar
              </Link>
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
