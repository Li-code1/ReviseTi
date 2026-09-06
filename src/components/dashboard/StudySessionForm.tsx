import { useEffect, useState, FormEvent } from "react";
import { Loader2 } from "lucide-react";
import { listContents } from "@/repositories/contentRepository";
import type { StudyContent } from "@/types/database";
import { dateToISODate } from "@/utils/time";

export interface StudySessionFormValues {
  content_id: string | null;
  study_date: string;
  minutes: number;
  notes: string;
}

interface Props {
  onSubmit: (values: StudySessionFormValues) => Promise<{ error: string | null }>;
  onCancel: () => void;
}

export function StudySessionForm({ onSubmit, onCancel }: Props) {
  const [contents, setContents] = useState<StudyContent[]>([]);
  const [contentId, setContentId] = useState("");
  const [studyDate, setStudyDate] = useState(dateToISODate(new Date()));
  const [minutes, setMinutes] = useState(30);
  const [notes, setNotes] = useState("");
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    listContents().then(({ data }) => setContents(data));
  }, []);

  function validate(): boolean {
    const next: Record<string, string> = {};
    if (!studyDate) next.study_date = "Informe uma data válida.";
    if (!minutes || minutes <= 0) next.minutes = "O tempo deve ser maior que 0.";
    setErrors(next);
    return Object.keys(next).length === 0;
  }

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    if (!validate()) return;
    setSubmitting(true);
    const { error } = await onSubmit({ content_id: contentId || null, study_date: studyDate, minutes, notes: notes.trim() });
    setSubmitting(false);
    if (error) setErrors({ form: error });
  }

  return (
    <form onSubmit={handleSubmit} noValidate className="space-y-4">
      <div>
        <label htmlFor="content" className="label-field">Aula (opcional)</label>
        <select id="content" value={contentId} onChange={(e) => setContentId(e.target.value)} className="input-field">
          <option value="">Nenhuma</option>
          {contents.map((c) => (
            <option key={c.id} value={c.id}>
              Semana {c.week_number} • {c.title}
            </option>
          ))}
        </select>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <label htmlFor="study_date" className="label-field">Data</label>
          <input
            id="study_date"
            type="date"
            value={studyDate}
            onChange={(e) => setStudyDate(e.target.value)}
            className="input-field"
            aria-invalid={!!errors.study_date}
          />
          {errors.study_date && <p className="mt-1 text-xs text-red-600">{errors.study_date}</p>}
        </div>
        <div>
          <label htmlFor="minutes" className="label-field">Tempo estudado (minutos)</label>
          <input
            id="minutes"
            type="number"
            min={1}
            value={minutes}
            onChange={(e) => setMinutes(Number(e.target.value))}
            className="input-field"
            aria-invalid={!!errors.minutes}
          />
          {errors.minutes && <p className="mt-1 text-xs text-red-600">{errors.minutes}</p>}
        </div>
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
          Registrar
        </button>
      </div>
    </form>
  );
}
