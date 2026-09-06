import { localDb } from "@/lib/localDb";
import { enqueue, syncInBackground } from "@/services/syncService";
import * as reviewService from "@/services/reviewService";
import type { Review, ReviewWithContent } from "@/types/database";

async function attachContent(review: Review): Promise<ReviewWithContent> {
  if (!review.content_id) return { ...review, content: null };
  const content = await localDb.contents.get(review.content_id);
  return { ...review, content: content ? { id: content.id, title: content.title, week_number: content.week_number, day_name: content.day_name } : null };
}

/** Mescla o que veio do Supabase com o que ainda está pendente na fila local (para não "sumir" um item criado offline que ainda não foi enviado). */
async function reconcile(userId: string, remote: Review[]): Promise<Review[]> {
  const pending = await localDb.syncQueue.where({ userId, entity: "reviews" }).toArray();
  const byId = new Map(remote.map((r) => [r.id, r]));
  for (const item of pending) {
    if (item.operation === "delete") {
      byId.delete(item.entityId);
    } else {
      const local = await localDb.reviews.get(item.entityId);
      if (local) byId.set(item.entityId, local);
    }
  }
  return Array.from(byId.values());
}

export async function getReviews(userId: string): Promise<{ data: ReviewWithContent[]; error: string | null }> {
  const online = navigator.onLine;
  if (online) {
    const remote = await reviewService.getReviews(userId);
    if (!remote.error) {
      const merged = await reconcile(userId, remote.data);
      await localDb.reviews.bulkPut(merged.map((r) => ({ ...r, synced: true })));
      const withContent = await Promise.all(merged.map(attachContent));
      return { data: withContent.sort((a, b) => a.review_date.localeCompare(b.review_date)), error: null };
    }
  }
  const local = await localDb.reviews.where("user_id").equals(userId).toArray();
  const withContent = await Promise.all(local.map(attachContent));
  return { data: withContent.sort((a, b) => a.review_date.localeCompare(b.review_date)), error: null };
}

export async function createReview(review: Partial<Review> & { user_id: string; title: string; review_date: string }) {
  const id = crypto.randomUUID();
  const now = new Date().toISOString();
  const record: Review = {
    id,
    user_id: review.user_id,
    content_id: review.content_id ?? null,
    title: review.title,
    notes: review.notes ?? null,
    review_date: review.review_date,
    minutes: review.minutes ?? 0,
    difficulty: review.difficulty ?? "medium",
    completed: review.completed ?? false,
    completed_at: null,
    created_at: now,
    updated_at: now,
  };
  await localDb.reviews.put({ ...record, synced: false });
  await enqueue("reviews", id, "create", { ...record }, review.user_id);
  syncInBackground(review.user_id);
  return { data: record, error: null };
}

export async function updateReview(id: string, updates: Partial<Review>) {
  const current = await localDb.reviews.get(id);
  if (!current) return { data: null, error: "Revisão não encontrada localmente." };
  const merged = { ...current, ...updates, updated_at: new Date().toISOString() };
  await localDb.reviews.put({ ...merged, synced: false });
  await enqueue("reviews", id, "update", { ...updates }, current.user_id);
  syncInBackground(current.user_id);
  return { data: merged, error: null };
}

export async function deleteReview(id: string) {
  const current = await localDb.reviews.get(id);
  if (!current) return { error: null };
  await localDb.reviews.delete(id);
  await enqueue("reviews", id, "delete", {}, current.user_id);
  syncInBackground(current.user_id);
  return { error: null };
}

export async function completeReview(id: string) {
  return updateReview(id, { completed: true, completed_at: new Date().toISOString() });
}

export async function uncompleteReview(id: string) {
  return updateReview(id, { completed: false, completed_at: null });
}
