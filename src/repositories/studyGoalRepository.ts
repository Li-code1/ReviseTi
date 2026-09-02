import { localDb } from "@/lib/localDb";
import { enqueue, syncInBackground } from "@/services/syncService";
import * as studyGoalService from "@/services/studyGoalService";

const DEFAULT_WEEKLY_MINUTES = 600;

export async function getStudyGoal(userId: string): Promise<{ weeklyMinutes: number; error: string | null }> {
  if (navigator.onLine) {
    const remote = await studyGoalService.getStudyGoal(userId);
    if (!remote.error) {
      await localDb.studyGoals.put({
        id: userId,
        user_id: userId,
        weekly_minutes: remote.weeklyMinutes,
        created_at: remote.data?.created_at ?? new Date().toISOString(),
        updated_at: remote.data?.updated_at ?? new Date().toISOString(),
        synced: true,
      });
      return { weeklyMinutes: remote.weeklyMinutes, error: null };
    }
  }
  const local = await localDb.studyGoals.get(userId);
  return { weeklyMinutes: local?.weekly_minutes ?? DEFAULT_WEEKLY_MINUTES, error: null };
}

export async function upsertStudyGoal(userId: string, weeklyMinutes: number) {
  const now = new Date().toISOString();
  const existing = await localDb.studyGoals.get(userId);
  await localDb.studyGoals.put({
    id: userId,
    user_id: userId,
    weekly_minutes: weeklyMinutes,
    created_at: existing?.created_at ?? now,
    updated_at: now,
    synced: false,
  });
  await enqueue("study_goals", userId, "upsert", { weekly_minutes: weeklyMinutes }, userId);
  syncInBackground(userId);
  return { error: null };
}
