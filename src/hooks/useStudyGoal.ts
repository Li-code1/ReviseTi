import { useCallback, useEffect, useState } from "react";
import { useAuth } from "@/hooks/useAuth";
import { getStudyGoal, upsertStudyGoal } from "@/repositories/studyGoalRepository";

export function useStudyGoal() {
  const { user } = useAuth();
  const [weeklyMinutes, setWeeklyMinutes] = useState(600);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const load = useCallback(async () => {
    if (!user) return;
    setLoading(true);
    const { weeklyMinutes, error } = await getStudyGoal(user.id);
    setWeeklyMinutes(weeklyMinutes);
    setError(error);
    setLoading(false);
  }, [user]);

  useEffect(() => {
    load();
  }, [load]);

  async function updateGoal(minutes: number) {
    if (!user) return { error: "Você precisa estar autenticado." };
    const { error } = await upsertStudyGoal(user.id, minutes);
    if (!error) await load();
    return { error };
  }

  return { weeklyMinutes, loading, error, reload: load, updateGoal };
}
