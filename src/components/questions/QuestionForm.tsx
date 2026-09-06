import { useEffect, useState, FormEvent } from "react";
import { Loader2 } from "lucide-react";
import { listContents } from "@/repositories/contentRepository";
import type { Difficulty, Question, StudyContent } from "@/types/database";

export interface QuestionFormValues {
  question: string;
  answer: string;
  content_id: string | null;
  difficulty: Difficulty;
}

interface Props {
  initial?: Question | null;
  onSubmit: (values: QuestionFormValues) => Promise<{ error: string | null }>;
  onCancel: () => void;
}

export function QuestionForm({ initial, onSubmit, onCancel }: Props) {
  const [contents, setContents] = useState<StudyContent[]>([]);
  const [question, setQuestion] = useState(initial?.question ?? "");
  const [answer, setAnswer] = useState(initial?.answer ?? "");
  const [contentId, setContentId] = useState(initial?.content_id ?? "");
  const [difficulty, setDifficulty] = useState<Difficulty>(initial?.difficulty ?? "medium");
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    listContents().then(({ data }) => setContents(data));
  }, []);

  function validate(): boolean {
    const next: Record<string, string> = {};
    if (!question.trim()) next.question = "A pergunta é obrigatória.";
    if (!answer.trim()) next.answer = "A resposta é obrigatória.";
    setErrors(next);
    return Object.keys(next).length === 0;
  }

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    if (!validate()) return;
    setSubmitting(true);
    const { error } = await onSubmit({
      question: question.trim(),
      answer: answer.trim(),
      content_id: contentId || null,
      difficulty,
    });
    setSubmitting(false);
    if (error) setErrors({ form: error });
  }

  return (
    <form onSubmit={handleSubmit} noValidate className="space-y-4">
      <div>
        <label htmlFor="question" className="label-field">Pergunta</label>
        <textarea
          id="question"
          value={question}
          onChange={(e) => setQuestion(e.target.value)}
          rows={2}
          className="input-field"
          aria-invalid={!!errors.question}
          aria-describedby={errors.question ? "question-error" : undefined}
        />
        {errors.question && <p id="question-error" className="mt-1 text-xs text-red-600">{errors.question}</p>}
      </div>

      <div>
        <label htmlFor="answer" className="label-field">Resposta</label>
        <textarea
          id="answer"
          value={answer}
          onChange={(e) => setAnswer(e.target.value)}
          rows={3}
          className="input-field"
          aria-invalid={!!errors.answer}
          aria-describedby={errors.answer ? "answer-error" : undefined}
        />
        {errors.answer && <p id="answer-error" className="mt-1 text-xs text-red-600">{errors.answer}</p>}
      </div>

      <div>
        <label htmlFor="content" className="label-field">Aula relacionada (opcional)</label>
        <select id="content" value={contentId} onChange={(e) => setContentId(e.target.value)} className="input-field">
          <option value="">Nenhuma</option>
          {contents.map((c) => (
            <option key={c.id} value={c.id}>
              Semana {c.week_number} • {c.title}
            </option>
          ))}
        </select>
      </div>

      <div>
        <label htmlFor="difficulty" className="label-field">Dificuldade</label>
        <select id="difficulty" value={difficulty} onChange={(e) => setDifficulty(e.target.value as Difficulty)} className="input-field">
          <option value="easy">Fácil</option>
          <option value="medium">Média</option>
          <option value="hard">Difícil</option>
        </select>
      </div>

      {errors.form && <p role="alert" className="text-sm text-red-600 dark:text-red-400">{errors.form}</p>}

      <div className="flex justify-end gap-3 pt-2">
        <button type="button" onClick={onCancel} className="btn-secondary">
          Cancelar
        </button>
        <button type="submit" disabled={submitting} className="btn-primary">
          {submitting && <Loader2 className="h-4 w-4 animate-spin" />}
          Salvar
        </button>
      </div>
    </form>
  );
}
