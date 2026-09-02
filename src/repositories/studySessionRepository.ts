import { localDb } from "@/lib/localDb";
import { enqueue, syncInBackground } from "@/services/syncService";
import * as studySessionService from "@/services/studySessionService";
import type { StudySession } from "@/types/database";

async function reconcile(userId: string, remote: StudySession[]): Promise<StudySession[]> {
  const pending = await localDb.syncQueue.where({ userId, entity: "study_sessions" }).toArray();
  const byId = new Map(remote.map((s) => [s.id, s]));
  for (const item of pending) {
    const local = await localDb.studySessions.get(item.entityId);
    if (local) byId.set(item.entityId, local);
  }
  return Array.from(byId.values());
}

export async function listSessions(userId: string): Promise<{ data: StudySession[]; error: string | null }> {
  if (navigator.onLine) {
    const remote = await studySessionService.listSessions(userId);
    if (!remote.error) {
      const merged = await reconcile(userId, remote.data);
      await localDb.studySessions.bulkPut(merged.map((s) => ({ ...s, synced: true })));
      return { data: merged.sort((a, b) => b.study_date.localeCompare(a.study_date)), error: null };
    }
  }
  const local = await localDb.studySessions.where("user_id").equals(userId).toArray();
  return { data: local.sort((a, b) => b.study_date.localeCompare(a.study_date)), error: null };
}

export async function createStudySession(session: Partial<StudySession> & { user_id: string; minutes: number; study_date: string }) {
  const id = crypto.randomUUID();
  const now = new Date().toISOString();
  const record: StudySession = {
    id,
    user_id: session.user_id,
    content_id: session.content_id ?? null,
    study_date: session.study_date,
    minutes: session.minutes,
    notes: session.notes ?? null,
    created_at: now,
  };
  await localDb.studySessions.put({ ...record, synced: false });
  await enqueue("study_sessions", id, "create", { ...record }, session.user_id);
  syncInBackground(session.user_id);
  return { data: record, error: null };
}

export { totalMinutes, summarizeStudyHours, minutesByDay } from "@/services/studySessionService";
