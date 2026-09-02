import { supabase } from "@/lib/supabase";

export type ActivityKind = "content_completed" | "review_completed" | "question_answered" | "study_session";

export interface ActivityItem {
  kind: ActivityKind;
  label: string;
  timestamp: string; // ISO
}

/**
 * Monta uma lista de atividade recente combinando eventos de várias tabelas
 * existentes (sem precisar de uma tabela activity_log dedicada).
 * Busca um lote pequeno de cada fonte e ordena no frontend.
 */
export async function getRecentActivity(userId: string, limit = 8): Promise<{ data: ActivityItem[]; error: string | null }> {
  const [progressRes, reviewsRes, questionsRes, sessionsRes] = await Promise.all([
    supabase
      .from("study_progress")
      .select("completed_at, content:study_contents(title)")
      .eq("user_id", userId)
      .eq("completed", true)
      .order("completed_at", { ascending: false })
      .limit(limit),
    supabase
      .from("reviews")
      .select("title, completed_at")
      .eq("user_id", userId)
      .eq("completed", true)
      .order("completed_at", { ascending: false })
      .limit(limit),
    supabase
      .from("questions")
      .select("question, last_reviewed_at")
      .eq("user_id", userId)
      .not("last_reviewed_at", "is", null)
      .order("last_reviewed_at", { ascending: false })
      .limit(limit),
    supabase
      .from("study_sessions")
      .select("minutes, created_at")
      .eq("user_id", userId)
      .order("created_at", { ascending: false })
      .limit(limit),
  ]);

  if (progressRes.error || reviewsRes.error || questionsRes.error || sessionsRes.error) {
    return { data: [], error: "Não foi possível carregar a atividade recente." };
  }

  const items: ActivityItem[] = [];

  for (const p of (progressRes.data ?? []) as unknown as { completed_at: string; content: { title: string } | null }[]) {
    if (!p.completed_at) continue;
    items.push({ kind: "content_completed", label: `Você concluiu "${p.content?.title ?? "uma aula"}"`, timestamp: p.completed_at });
  }
  for (const r of (reviewsRes.data ?? []) as { title: string; completed_at: string | null }[]) {
    if (!r.completed_at) continue;
    items.push({ kind: "review_completed", label: `Você concluiu a revisão "${r.title}"`, timestamp: r.completed_at });
  }
  for (const q of (questionsRes.data ?? []) as { question: string; last_reviewed_at: string | null }[]) {
    if (!q.last_reviewed_at) continue;
    items.push({ kind: "question_answered", label: "Você respondeu uma pergunta", timestamp: q.last_reviewed_at });
  }
  for (const s of (sessionsRes.data ?? []) as { minutes: number; created_at: string }[]) {
    items.push({ kind: "study_session", label: `Você estudou ${s.minutes} minutos`, timestamp: s.created_at });
  }

  items.sort((a, b) => new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime());
  return { data: items.slice(0, limit), error: null };
}

export interface EvolutionPoint {
  date: string;
  completedContents: number; // cumulativo
}

/**
 * Evolução do progresso ao longo do tempo: contagem cumulativa de aulas
 * concluídas por data de conclusão. Base simples para o gráfico de linha —
 * não inventa pontos: se não houver aulas concluídas, retorna array vazio.
 */
export async function getEvolutionData(userId: string): Promise<{ data: EvolutionPoint[]; error: string | null }> {
  const { data, error } = await supabase
    .from("study_progress")
    .select("completed_at")
    .eq("user_id", userId)
    .eq("completed", true)
    .not("completed_at", "is", null)
    .order("completed_at", { ascending: true });

  if (error) return { data: [], error: "Não foi possível carregar sua evolução." };

  const byDate = new Map<string, number>();
  for (const row of (data ?? []) as { completed_at: string }[]) {
    const date = row.completed_at.slice(0, 10);
    byDate.set(date, (byDate.get(date) ?? 0) + 1);
  }

  let cumulative = 0;
  const points: EvolutionPoint[] = [];
  for (const [date, count] of Array.from(byDate.entries()).sort()) {
    cumulative += count;
    points.push({ date, completedContents: cumulative });
  }
  return { data: points, error: null };
}
