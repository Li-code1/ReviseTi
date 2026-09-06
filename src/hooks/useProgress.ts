import { useCallback, useEffect, useState } from "react";
import { useAuth } from "@/hooks/useAuth";
import { listContents } from "@/repositories/contentRepository";
import { getProgressMap, computeProgressByWeek, type WeekProgress } from "@/repositories/progressRepository";
import type { StudyContent } from "@/types/database";

export function useProgress() {
  const { user } = useAuth();
  const [contents, setContents] = useState<StudyContent[]>([]);
  const [progressMap, setProgressMap] = useState<Record<string, boolean>>({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const load = useCallback(async () => {
    if (!user) return;
    setLoading(true);
    const [contentsRes, map] = await Promise.all([listContents(), getProgressMap(user.id)]);
    setContents(contentsRes.data);
    setError(contentsRes.error);
    setProgressMap(map);
    setLoading(false);
  }, [user]);

  useEffect(() => {
    load();
  }, [load]);

  const byWeek: WeekProgress[] = computeProgressByWeek(contents, progressMap);
  const completedCount = contents.filter((c) => progressMap[c.id]).length;
  const totalCount = contents.length;
  const overallPercent = totalCount > 0 ? Math.round((completedCount / totalCount) * 100) : 0;

  return { contents, progressMap, byWeek, completedCount, totalCount, overallPercent, loading, error, reload: load };
}
