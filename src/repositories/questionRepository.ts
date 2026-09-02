import { localDb } from "@/lib/localDb";
import { enqueue, syncInBackground } from "@/services/syncService";
import * as questionService from "@/services/questionService";
import type { Question, QuestionWithContent } from "@/types/database";

async function attachContent(question: Question): Promise<QuestionWithContent> {
  if (!question.content_id) return { ...question, content: null };
  const content = await localDb.contents.get(question.content_id);
  return {
    ...question,
    content: content ? { id: content.id, title: content.title, slug: content.slug, week_number: content.week_number, day_name: content.day_name } : null,
  };
}

async function reconcile(userId: string, remote: Question[]): Promise<Question[]> {
  const pending = await localDb.syncQueue.where({ userId, entity: "questions" }).toArray();
  const byId = new Map(remote.map((q) => [q.id, q]));
  for (const item of pending) {
    if (item.operation === "delete") {
      byId.delete(item.entityId);
    } else {
      const local = await localDb.questions.get(item.entityId);
      if (local) byId.set(item.entityId, local);
    }
  }
  return Array.from(byId.values());
}

export async function getQuestions(userId: string): Promise<{ data: QuestionWithContent[]; error: string | null }> {
  if (navigator.onLine) {
    const remote = await questionService.getQuestions(userId);
    if (!remote.error) {
      const merged = await reconcile(userId, remote.data);
      await localDb.questions.bulkPut(merged.map((q) => ({ ...q, synced: true })));
      const withContent = await Promise.all(merged.map(attachContent));
      return { data: withContent.sort((a, b) => b.created_at.localeCompare(a.created_at)), error: null };
    }
  }
  const local = await localDb.questions.where("user_id").equals(userId).toArray();
  const withContent = await Promise.all(local.map(attachContent));
  return { data: withContent.sort((a, b) => b.created_at.localeCompare(a.created_at)), error: null };
}

export async function getQuestionById(id: string): Promise<{ data: QuestionWithContent | null; error: string | null }> {
  const local = await localDb.questions.get(id);
  if (local) return { data: await attachContent(local), error: null };
  if (navigator.onLine) return questionService.getQuestionById(id);
  return { data: null, error: "Pergunta não encontrada offline." };
}

export async function createQuestion(question: Partial<Question> & { user_id: string; question: string; answer: string }) {
  const id = crypto.randomUUID();
  const now = new Date().toISOString();
  const record: Question = {
    id,
    user_id: question.user_id,
    content_id: question.content_id ?? null,
    question: question.question,
    answer: question.answer,
    difficulty: question.difficulty ?? "medium",
    correct_count: 0,
    wrong_count: 0,
    last_reviewed_at: null,
    created_at: now,
    updated_at: now,
  };
  await localDb.questions.put({ ...record, synced: false });
  await enqueue("questions", id, "create", { ...record }, question.user_id);
  syncInBackground(question.user_id);
  return { data: record, error: null };
}

export async function updateQuestion(id: string, updates: Partial<Pick<Question, "question" | "answer" | "content_id" | "difficulty">>) {
  const current = await localDb.questions.get(id);
  if (!current) return { data: null, error: "Pergunta não encontrada localmente." };
  const merged = { ...current, ...updates, updated_at: new Date().toISOString() };
  await localDb.questions.put({ ...merged, synced: false });
  await enqueue("questions", id, "update", { ...updates }, current.user_id);
  syncInBackground(current.user_id);
  return { data: merged, error: null };
}

export async function deleteQuestion(id: string) {
  const current = await localDb.questions.get(id);
  if (!current) return { error: null };
  await localDb.questions.delete(id);
  await enqueue("questions", id, "delete", {}, current.user_id);
  syncInBackground(current.user_id);
  return { error: null };
}

/** Incrementa localmente para feedback imediato; a fila envia um delta (+1) — nunca sobrescreve o valor absoluto no servidor. */
export async function registerCorrectAnswer(id: string, _currentCorrectCount: number) {
  const current = await localDb.questions.get(id);
  if (!current) return { data: null, error: "Pergunta não encontrada localmente." };
  const now = new Date().toISOString();
  const merged = { ...current, correct_count: current.correct_count + 1, last_reviewed_at: now };
  await localDb.questions.put({ ...merged, synced: false });
  await enqueue("questions", id, "increment_correct", { last_reviewed_at: now }, current.user_id);
  syncInBackground(current.user_id);
  return { data: merged, error: null };
}

export async function registerWrongAnswer(id: string, _currentWrongCount: number) {
  const current = await localDb.questions.get(id);
  if (!current) return { data: null, error: "Pergunta não encontrada localmente." };
  const now = new Date().toISOString();
  const merged = { ...current, wrong_count: current.wrong_count + 1, last_reviewed_at: now };
  await localDb.questions.put({ ...merged, synced: false });
  await enqueue("questions", id, "increment_wrong", { last_reviewed_at: now }, current.user_id);
  syncInBackground(current.user_id);
  return { data: merged, error: null };
}
