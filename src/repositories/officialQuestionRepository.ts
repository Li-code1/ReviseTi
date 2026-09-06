import { localDb } from "@/lib/localDb";
import { enqueue, syncInBackground } from "@/services/syncService";
import * as svc from "@/services/officialQuestionService";
import type { OfficialQuestion, QuestionAttempt } from "@/types/database";

export async function listQuestionsByContent(contentId: string): Promise<OfficialQuestion[]> {
  if (navigator.onLine) {
    const remote = await svc.listQuestionsByContent(contentId);
    if (!remote.error) {
      await localDb.officialQuestions.bulkPut(remote.data);
      return remote.data;
    }
  }
  return localDb.officialQuestions.where("content_id").equals(contentId).sortBy("order_index");
}

export async function listQuestionsByWeek(weekNumber: number): Promise<OfficialQuestion[]> {
  if (navigator.onLine) {
    const remote = await svc.listQuestionsByWeek(weekNumber);
    if (!remote.error && remote.data.length > 0) {
      await localDb.officialQuestions.bulkPut(remote.data);
      return remote.data;
    }
  }
  // Offline: busca localmente via os content_id daquela semana.
  const contents = await localDb.contents.where("week_number").equals(weekNumber).toArray();
  const contentIds = new Set(contents.map((c) => c.id));
  const all = await localDb.officialQuestions.toArray();
  return all.filter((q) => q.content_id && contentIds.has(q.content_id)).sort((a, b) => a.order_index - b.order_index);
}

export async function listQuestionsByCategory(category: string): Promise<OfficialQuestion[]> {
  if (navigator.onLine) {
    const remote = await svc.listQuestionsByCategory(category);
    if (!remote.error) {
      await localDb.officialQuestions.bulkPut(remote.data);
      return remote.data;
    }
  }
  return localDb.officialQuestions.where("category").equals(category).sortBy("order_index");
}

export async function listInterviewQuestions(): Promise<OfficialQuestion[]> {
  if (navigator.onLine) {
    const remote = await svc.listInterviewQuestions();
    if (!remote.error) {
      await localDb.officialQuestions.bulkPut(remote.data);
      return remote.data;
    }
  }
  const all = await localDb.officialQuestions.toArray();
  return all.filter((q) => q.is_interview_question).sort((a, b) => a.order_index - b.order_index);
}

/** Todas as perguntas cacheadas localmente — usada para "Revisão geral" (não busca as 300+ do Supabase toda vez). */
export async function listAllCached(): Promise<OfficialQuestion[]> {
  const all = await localDb.officialQuestions.toArray();
  return all.sort((a, b) => a.order_index - b.order_index);
}

export async function getAttempts(userId: string): Promise<QuestionAttempt[]> {
  if (navigator.onLine) {
    const remote = await svc.getAttempts(userId);
    if (!remote.error) {
      await localDb.questionAttempts.bulkPut(remote.data.map((a) => ({ ...a, synced: true })));
      return remote.data;
    }
  }
  return localDb.questionAttempts.where("user_id").equals(userId).toArray();
}

export async function recordAttempt(attempt: {
  user_id: string;
  official_question_id: string;
  selected_answer: string | null;
  is_correct: boolean;
}) {
  const id = crypto.randomUUID();
  const now = new Date().toISOString();
  const record: QuestionAttempt = { id, ...attempt, answered_at: now, created_at: now };
  await localDb.questionAttempts.put({ ...record, synced: false });
  await enqueue("question_attempts", id, "create", { ...attempt, answered_at: now }, attempt.user_id);
  syncInBackground(attempt.user_id);
  return record;
}
