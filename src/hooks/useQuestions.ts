import { useCallback, useEffect, useState } from "react";
import { useAuth } from "@/hooks/useAuth";
import {
  getQuestions,
  createQuestion,
  updateQuestion,
  deleteQuestion,
  registerCorrectAnswer,
  registerWrongAnswer,
} from "@/repositories/questionRepository";
import type { Question, QuestionWithContent } from "@/types/database";

export function useQuestions() {
  const { user } = useAuth();
  const [questions, setQuestions] = useState<QuestionWithContent[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const load = useCallback(async () => {
    if (!user) return;
    setLoading(true);
    const { data, error } = await getQuestions(user.id);
    setQuestions(data);
    setError(error);
    setLoading(false);
  }, [user]);

  useEffect(() => {
    load();
  }, [load]);

  async function create(question: Partial<Question> & { question: string; answer: string }) {
    if (!user) return { error: "Você precisa estar autenticado." };
    const { error } = await createQuestion({ ...question, user_id: user.id });
    if (!error) await load();
    return { error };
  }

  async function update(id: string, updates: Partial<Pick<Question, "question" | "answer" | "content_id" | "difficulty">>) {
    const { error } = await updateQuestion(id, updates);
    if (!error) await load();
    return { error };
  }

  async function remove(id: string) {
    const { error } = await deleteQuestion(id);
    if (!error) await load();
    return { error };
  }

  async function registerCorrect(id: string, currentCorrectCount: number) {
    const { error } = await registerCorrectAnswer(id, currentCorrectCount);
    if (!error) await load();
    return { error };
  }

  async function registerWrong(id: string, currentWrongCount: number) {
    const { error } = await registerWrongAnswer(id, currentWrongCount);
    if (!error) await load();
    return { error };
  }

  return { questions, loading, error, reload: load, create, update, remove, registerCorrect, registerWrong };
}
