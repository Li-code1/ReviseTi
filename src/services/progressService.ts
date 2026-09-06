import { supabase } from "@/lib/supabase";
import type { StudyContent, StudyProgress } from "@/types/database";

export async function listProgress(userId: string) {
  const { data, error } = await supabase.from("study_progress").select("*").eq("user_id", userId);
  if (error) return { data: [] as StudyProgress[], error: "Não foi possível carregar o progresso." };
  return { data: (data ?? []) as StudyProgress[], error: null };
}

/**
 * Busca o progresso do usuário em uma única query e devolve um mapa
 * content_id -> completed, para fazer o merge no frontend sem uma
 * requisição por aula.
 */
export async function getProgressMap(userId: string): Promise<Record<string, boolean>> {
  const { data } = await listProgress(userId);
  const map: Record<string, boolean> = {};
  for (const p of data) {
    map[p.content_id] = p.completed;
  }
  return map;
}

export async function markContentCompleted(userId: string, contentId: string, completed: boolean) {
  const { data, error } = await supabase
    .from("study_progress")
    .upsert(
      {
        user_id: userId,
        content_id: contentId,
        completed,
        completed_at: completed ? new Date().toISOString() : null,
        updated_at: new Date().toISOString(),
      },
      { onConflict: "user_id,content_id" }
    )
    .select()
    .single();
  return { data, error: error ? "Não foi possível atualizar o progresso." : null };
}

export interface WeekProgress {
  weekNumber: number;
  completed: number;
  total: number;
  percent: number;
}

/** Agrupa o progresso por semana, a partir dos conteúdos e do mapa de progresso já buscados. */
export function computeProgressByWeek(contents: StudyContent[], progressMap: Record<string, boolean>): WeekProgress[] {
  const grouped = new Map<number, StudyContent[]>();
  for (const c of contents) {
    grouped.set(c.week_number, [...(grouped.get(c.week_number) ?? []), c]);
  }
  return Array.from(grouped.entries())
    .sort(([a], [b]) => a - b)
    .map(([weekNumber, items]) => {
      const completed = items.filter((c) => progressMap[c.id]).length;
      const total = items.length;
      return { weekNumber, completed, total, percent: total > 0 ? Math.round((completed / total) * 100) : 0 };
    });
}
