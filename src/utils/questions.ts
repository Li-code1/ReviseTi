import type { Question, QuestionStats } from "@/types/database";

/** Retorna null (mostrar "Sem dados") quando a pergunta ainda não tem respostas. */
export function accuracyRate(correct: number, wrong: number): number | null {
  const total = correct + wrong;
  if (total === 0) return null;
  return Math.round((correct / total) * 100);
}

export function getQuestionStats(questions: Pick<Question, "correct_count" | "wrong_count">[]): QuestionStats {
  const correct = questions.reduce((sum, q) => sum + q.correct_count, 0);
  const wrong = questions.reduce((sum, q) => sum + q.wrong_count, 0);
  return { total: questions.length, correct, wrong, accuracyRate: accuracyRate(correct, wrong) };
}

/**
 * Combina estatísticas dos flashcards pessoais com as tentativas no banco
 * oficial (Revisão geral/Entrevista/por tema) — sem isso, quem nunca cria
 * pergunta própria via a tela "Minhas perguntas" veria sempre "Sem dados"
 * mesmo respondendo ativamente no banco oficial.
 */
export function combineQuestionStats(
  personal: { correct: number; wrong: number },
  official: { correct: number; wrong: number }
): { correct: number; wrong: number; total: number; accuracyRate: number | null } {
  const correct = personal.correct + official.correct;
  const wrong = personal.wrong + official.wrong;
  return { correct, wrong, total: correct + wrong, accuracyRate: accuracyRate(correct, wrong) };
}

export function neverReviewed(q: Pick<Question, "last_reviewed_at">): boolean {
  return q.last_reviewed_at === null;
}

/** "Preciso revisar": mais erros que acertos, ou 2+ erros no total. */
export function needsReview(q: Pick<Question, "correct_count" | "wrong_count">): boolean {
  return q.wrong_count > q.correct_count || q.wrong_count >= 2;
}

/**
 * Ordena perguntas para o modo estudo, priorizando:
 * 1. nunca revisadas
 * 2. mais erros
 * 3. dificuldade difícil
 * 4. revisadas há mais tempo
 * Não é repetição espaçada de verdade — só uma heurística organizada,
 * para ser substituída por um algoritmo melhor no futuro sem mudar quem a chama.
 */
export function selectStudyQuestions<T extends Question>(questions: T[]): T[] {
  const difficultyWeight: Record<string, number> = { hard: 0, medium: 1, easy: 2 };
  return [...questions].sort((a, b) => {
    const aNever = neverReviewed(a) ? 0 : 1;
    const bNever = neverReviewed(b) ? 0 : 1;
    if (aNever !== bNever) return aNever - bNever;

    if (b.wrong_count !== a.wrong_count) return b.wrong_count - a.wrong_count;

    const diffCompare = difficultyWeight[a.difficulty] - difficultyWeight[b.difficulty];
    if (diffCompare !== 0) return diffCompare;

    const aTime = a.last_reviewed_at ? new Date(a.last_reviewed_at).getTime() : 0;
    const bTime = b.last_reviewed_at ? new Date(b.last_reviewed_at).getTime() : 0;
    return aTime - bTime;
  });
}

export function formatLastReviewed(dateStr: string | null): string {
  if (!dateStr) return "Nunca revisada";
  return new Date(dateStr).toLocaleDateString("pt-BR");
}
