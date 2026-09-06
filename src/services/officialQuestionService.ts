import { supabase } from "@/lib/supabase";
import type { OfficialQuestion, QuestionAttempt } from "@/types/database";

export async function listQuestionsByContent(contentId: string): Promise<{ data: OfficialQuestion[]; error: string | null }> {
  const { data, error } = await supabase
    .from("official_questions")
    .select("*")
    .eq("content_id", contentId)
    .order("order_index", { ascending: true });
  if (error) return { data: [], error: "Não foi possível carregar as perguntas desta aula." };
  return { data: (data ?? []) as OfficialQuestion[], error: null };
}

export async function listQuestionsByWeek(weekNumber: number): Promise<{ data: OfficialQuestion[]; error: string | null }> {
  // Busca via join: perguntas cujo content_id pertence a uma aula daquela semana.
  const { data, error } = await supabase
    .from("official_questions")
    .select("*, content:study_contents!inner(week_number)")
    .eq("content.week_number", weekNumber)
    .order("order_index", { ascending: true });
  if (error) return { data: [], error: "Não foi possível carregar as perguntas desta semana." };
  return { data: (data ?? []) as unknown as OfficialQuestion[], error: null };
}

export async function listQuestionsByCategory(category: string): Promise<{ data: OfficialQuestion[]; error: string | null }> {
  const { data, error } = await supabase
    .from("official_questions")
    .select("*")
    .eq("category", category)
    .order("order_index", { ascending: true });
  if (error) return { data: [], error: "Não foi possível carregar as perguntas." };
  return { data: (data ?? []) as OfficialQuestion[], error: null };
}

export async function listInterviewQuestions(): Promise<{ data: OfficialQuestion[]; error: string | null }> {
  const { data, error } = await supabase
    .from("official_questions")
    .select("*")
    .eq("is_interview_question", true)
    .order("order_index", { ascending: true });
  if (error) return { data: [], error: "Não foi possível carregar as perguntas de entrevista." };
  return { data: (data ?? []) as OfficialQuestion[], error: null };
}

/** Todas as perguntas oficiais — usada só para a sincronização inicial (cache offline), nunca para renderizar 300+ de uma vez numa tela. */
export async function listAllQuestions(): Promise<{ data: OfficialQuestion[]; error: string | null }> {
  const { data, error } = await supabase.from("official_questions").select("*").order("order_index", { ascending: true });
  if (error) return { data: [], error: "Não foi possível carregar o banco de questões." };
  return { data: (data ?? []) as OfficialQuestion[], error: null };
}

export async function getAttempts(userId: string): Promise<{ data: QuestionAttempt[]; error: string | null }> {
  const { data, error } = await supabase
    .from("question_attempts")
    .select("*")
    .eq("user_id", userId)
    .order("answered_at", { ascending: false });
  if (error) return { data: [], error: "Não foi possível carregar suas tentativas." };
  return { data: (data ?? []) as QuestionAttempt[], error: null };
}

export async function recordAttempt(attempt: {
  user_id: string;
  official_question_id: string;
  selected_answer: string | null;
  is_correct: boolean;
}) {
  const { data, error } = await supabase.from("question_attempts").insert(attempt).select().single();
  if (error) return { data: null, error: "Não foi possível registrar sua resposta." };
  return { data: data as QuestionAttempt, error: null };
}
