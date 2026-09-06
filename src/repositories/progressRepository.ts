import { localDb } from "@/lib/localDb";
import { enqueue, syncInBackground } from "@/services/syncService";
import * as progressService from "@/services/progressService";
import type { StudyProgress } from "@/types/database";

async function reconcile(userId: string, remote: StudyProgress[]): Promise<StudyProgress[]> {
  const pending = await localDb.syncQueue.where({ userId, entity: "study_progress" }).toArray();
  const byContentId = new Map(remote.map((p) => [p.content_id, { ...p, id: p.content_id }]));
  for (const item of pending) {
    // item.entityId é o content_id (ver markContentCompleted)
    const local = await localDb.studyProgress.get(item.entityId);
    if (local) byContentId.set(local.content_id, local);
  }
  return Array.from(byContentId.values());
}

export async function listProgress(userId: string): Promise<{ data: StudyProgress[]; error: string | null }> {
  if (navigator.onLine) {
    const remote = await progressService.listProgress(userId);
    if (!remote.error) {
      const merged = await reconcile(userId, remote.data);
      await localDb.studyProgress.bulkPut(merged.map((p) => ({ ...p, synced: true })));
      return { data: merged, error: null };
    }
  }
  const local = await localDb.studyProgress.where("user_id").equals(userId).toArray();
  return { data: local, error: null };
}

export async function getProgressMap(userId: string): Promise<Record<string, boolean>> {
  const { data } = await listProgress(userId);
  const map: Record<string, boolean> = {};
  for (const p of data) map[p.content_id] = p.completed;
  return map;
}

export async function markContentCompleted(userId: string, contentId: string, completed: boolean) {
  const now = new Date().toISOString();
  const existing = await localDb.studyProgress.get(contentId);
  const record: StudyProgress = {
    id: contentId, // chave local estável: o banco local só guarda os dados de um usuário por vez
    user_id: userId,
    content_id: contentId,
    completed,
    completed_at: completed ? now : null,
    created_at: existing?.created_at ?? now,
    updated_at: now,
  };
  await localDb.studyProgress.put({ ...record, synced: false });
  await enqueue(
    "study_progress",
    contentId,
    "upsert",
    { user_id: userId, content_id: contentId, completed, completed_at: record.completed_at },
    userId
  );
  syncInBackground(userId);
  return { data: record, error: null };
}

export { computeProgressByWeek, type WeekProgress } from "@/services/progressService";
