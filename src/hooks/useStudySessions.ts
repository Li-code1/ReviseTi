import { useCallback, useEffect, useState } from "react";
import { useAuth } from "@/hooks/useAuth";
import { listSessions, createStudySession, summarizeStudyHours, minutesByDay } from "@/repositories/studySessionRepository";
import type { StudySession } from "@/types/database";

export function useStudySessions() {
  const { user } = useAuth();
  const [sessions, setSessions] = useState<StudySession[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const load = useCallback(async () => {
    if (!user) return;
    setLoading(true);
    const { data, error } = await listSessions(user.id);
    setSessions(data);
    setError(error);
    setLoading(false);
  }, [user]);

  useEffect(() => {
    load();
  }, [load]);

  async function create(session: Partial<StudySession> & { minutes: number; study_date: string }) {
    if (!user) return { error: "Você precisa estar autenticado." };
    const { error } = await createStudySession({ ...session, user_id: user.id });
    if (!error) await load();
    return { error };
  }

  return {
    sessions,
    loading,
    error,
    reload: load,
    create,
    hours: summarizeStudyHours(sessions),
    hoursByDay: minutesByDay(sessions, 7),
  };
}
