import { useEffect, useState, FormEvent } from "react";
import { Loader2 } from "lucide-react";
import { listContents } from "@/repositories/contentRepository";
import type { Difficulty, Review, StudyContent } from "@/types/database";
import { todayISODate } from "@/utils/reviews";

export interface ReviewFormValues {
  title: string;
  content_id: string | null;
  review_date: string;
  minutes: number;
  difficulty: Difficulty;
  notes: string;
}

interface Props {
  initial?: Review | null;
  onSubmit: (values: ReviewFormValues) => Promise<{ error: string | null }>;
  onCancel: () => void;
}

export function ReviewForm({ initial, onSubmit, onCancel }: Props) {
  const [contents, setContents] = useState<StudyContent[]>([]);
  const [title, setTitle] = useState(initial?.title ?? "");
  const [contentId, setContentId] = useState<string>(initial?.content_id ?? "");
  const [reviewDate, setReviewDate] = useState(initial?.review_date ?? todayISODate());
  const [minutes, setMinutes] = useState(initial?.minutes ?? 30);
  const [difficulty, setDifficulty] = useState<Difficulty>(initial?.difficulty ?? "medium");
  const [notes, setNotes] = useState(initial?.notes ?? "");
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    listContents().then(({ data }) => setContents(data));
  }, []);

  function validate(): boolean {
    const next: Record<string, string> = {};
    if (!title.trim()) next.title = "O título é obrigatório.";
    if (!reviewDate) next.review_date = "Informe uma data válida.";
    if (minutes < 0) next.minutes = "O tempo não pode ser negativo.";
    setErrors(next);
    return Object.keys(next).length === 0;
  }

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    if (!validate()) return;
    setSubmitting(true);
    const { error } = await onSubmit({
      title: title.trim(),
      content_id: contentId || null,
      review_date: reviewDate,
      minutes,
      difficulty,
      notes: notes.trim(),
    });
    setSubmitting(false);
    if (error) setErrors({ form: error });
  }

  return (
    <form onSubmit={handleSubmit} noValidate className="space-y-4">
      <div>
        <label htmlFor="title" className="label-field">Título</label>
        <input
          id="title"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          placeholder="Revisar async/await"
          className="input-field"
          aria-invalid={!!errors.title}
          aria-describedby={errors.title ? "title-error" : undefined}
        />
        {errors.title && <p id="title-error" className="mt-1 text-xs text-red-600">{errors.title}</p>}
      </div>

      <div>
        <label htmlFor="content" className="label-field">Aula relacionada (opcional)</label>
        <select id="content" value={contentId} onChange={(e) => setContentId(e.target.value)} className="input-field">
          <option value="">Nenhuma</option>
          {contents.map((c) => (
            <option key={c.id} value={c.id}>
              Semana {c.week_number} • {c.day_name} • {c.title}
            </option>
          ))}
        </select>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <label htmlFor="review_date" className="label-field">Data da revisão</label>
          <input
            id="review_date"
            type="date"
            value={reviewDate}
            onChange={(e) => setReviewDate(e.target.value)}
            className="input-field"
            aria-invalid={!!errors.review_date}
          />
          {errors.review_date && <p className="mt-1 text-xs text-red-600">{errors.review_date}</p>}
        </div>
        <div>
          <label htmlFor="minutes" className="label-field">Tempo estudado (minutos)</label>
          <input
            id="minutes"
            type="number"
            min={0}
            value={minutes}
            onChange={(e) => setMinutes(Number(e.target.value))}
            className="input-field"
            aria-invalid={!!errors.minutes}
          />
          {errors.minutes && <p className="mt-1 text-xs text-red-600">{errors.minutes}</p>}
        </div>
      </div>

      <div>
        <label htmlFor="difficulty" className="label-field">Dificuldade</label>
        <select
          id="difficulty"
          value={difficulty}
          onChange={(e) => setDifficulty(e.target.value as Difficulty)}
          className="input-field"
        >
          <option value="easy">Fácil</option>
          <option value="medium">Média</option>
          <option value="hard">Difícil</option>
        </select>
      </div>

      <div>
        <label htmlFor="notes" className="label-field">Observações</label>
        <textarea id="notes" value={notes} onChange={(e) => setNotes(e.target.value)} rows={3} className="input-field" />
      </div>

      {errors.form && <p role="alert" className="text-sm text-red-600 dark:text-red-400">{errors.form}</p>}

      <div className="flex justify-end gap-3 pt-2">
        <button type="button" onClick={onCancel} className="btn-secondary">
          Cancelar
        </button>
        <button type="submit" disabled={submitting} className="btn-primary">
          {submitting && <Loader2 className="h-4 w-4 animate-spin" />}
          Salvar revisão
        </button>
      </div>
    </form>
  );
}
