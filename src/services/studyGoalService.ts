import { supabase } from "@/lib/supabase";
import type { StudyGoal } from "@/types/database";

const DEFAULT_WEEKLY_MINUTES = 600; // 10h, mesmo padrão da coluna no banco

/** Retorna a meta do usuário, ou o padrão (600min/10h) se ele ainda não definiu uma. */
export async function getStudyGoal(userId: string): Promise<{ data: StudyGoal | null; weeklyMinutes: number; error: string | null }> {
  const { data, error } = await supabase.from("study_goals").select("*").eq("user_id", userId).maybeSingle();
  if (error) return { data: null, weeklyMinutes: DEFAULT_WEEKLY_MINUTES, error: "Não foi possível carregar sua meta." };
  return { data: data as StudyGoal | null, weeklyMinutes: data?.weekly_minutes ?? DEFAULT_WEEKLY_MINUTES, error: null };
}

export async function upsertStudyGoal(userId: string, weeklyMinutes: number) {
  const { data, error } = await supabase
    .from("study_goals")
    .upsert({ user_id: userId, weekly_minutes: weeklyMinutes, updated_at: new Date().toISOString() }, { onConflict: "user_id" })
    .select()
    .single();
  if (error) return { data: null, error: "Não foi possível salvar sua meta." };
  return { data: data as StudyGoal, error: null };
}
