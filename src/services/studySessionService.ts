import { supabase } from "@/lib/supabase";
import type { StudySession } from "@/types/database";
import { dateToISODate, startOfWeek, startOfMonth, lastNDates } from "@/utils/time";

export async function listSessions(userId: string) {
  const { data, error } = await supabase
    .from("study_sessions")
    .select("*")
    .eq("user_id", userId)
    .order("study_date", { ascending: false });
  if (error) return { data: [] as StudySession[], error: "Não foi possível carregar as sessões de estudo." };
  return { data: (data ?? []) as StudySession[], error: null };
}

export async function createStudySession(
  session: Partial<StudySession> & { user_id: string; minutes: number; study_date: string }
) {
  const { data, error } = await supabase.from("study_sessions").insert(session).select().single();
  if (error) return { data: null, error: "Não foi possível registrar a sessão de estudo." };
  return { data: data as StudySession, error: null };
}

export function totalMinutes(sessions: StudySession[]): number {
  return sessions.reduce((sum, s) => sum + (s.minutes || 0), 0);
}

export interface StudyHoursSummary {
  todayMinutes: number;
  weekMinutes: number;
  monthMinutes: number;
  totalMinutes: number;
}

/**
 * Calcula hoje/semana (segunda a domingo)/mês/total a partir das sessões já
 * carregadas — evita repetir a mesma regra de datas em vários componentes.
 */
export function summarizeStudyHours(sessions: StudySession[]): StudyHoursSummary {
  const today = dateToISODate(new Date());
  const weekStart = dateToISODate(startOfWeek());
  const monthStart = dateToISODate(startOfMonth());

  let todayMinutes = 0, weekMinutes = 0, monthMinutes = 0, total = 0;
  for (const s of sessions) {
    total += s.minutes;
    if (s.study_date === today) todayMinutes += s.minutes;
    if (s.study_date >= weekStart) weekMinutes += s.minutes;
    if (s.study_date >= monthStart) monthMinutes += s.minutes;
  }
  return { todayMinutes, weekMinutes, monthMinutes, totalMinutes: total };
}

/** Minutos estudados por dia nos últimos N dias (preenche com 0 os dias sem sessão). */
export function minutesByDay(sessions: StudySession[], days = 7): { date: string; minutes: number }[] {
  const dates = lastNDates(days);
  const map = new Map<string, number>();
  for (const s of sessions) {
    map.set(s.study_date, (map.get(s.study_date) ?? 0) + s.minutes);
  }
  return dates.map((date) => ({ date, minutes: map.get(date) ?? 0 }));
}
