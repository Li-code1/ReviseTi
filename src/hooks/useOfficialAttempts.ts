import { useCallback, useEffect, useState } from "react";
import { useAuth } from "@/hooks/useAuth";
import { getAttempts } from "@/repositories/officialQuestionRepository";
import type { QuestionAttempt } from "@/types/database";

/**
 * Tentativas do usuário no banco de questões OFICIAL (Revisão geral, Entrevista,
 * por tema, por aula/semana) — separado das tentativas em flashcards pessoais
 * (useQuestions), para que o Dashboard/Progresso possam somar as duas fontes.
 */
export function useOfficialAttempts() {
  const { user } = useAuth();
  const [attempts, setAttempts] = useState<QuestionAttempt[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const load = useCallback(async () => {
    if (!user) return;
    setLoading(true);
    try {
      const data = await getAttempts(user.id);
      setAttempts(data);
      setError(null);
    } catch {
      setError("Não foi possível carregar suas tentativas.");
    } finally {
      setLoading(false);
    }
  }, [user]);

  useEffect(() => {
    load();
  }, [load]);

  const correct = attempts.filter((a) => a.is_correct).length;
  const wrong = attempts.filter((a) => !a.is_correct).length;

  return { attempts, correct, wrong, total: attempts.length, loading, error, reload: load };
}
