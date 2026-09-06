import { supabase } from "@/lib/supabase";
import type { Question, QuestionWithContent } from "@/types/database";

const QUESTION_WITH_CONTENT_SELECT = "*, content:study_contents(id, title, slug, week_number, day_name)";

/** Busca todas as perguntas do usuário em uma única query, já com a aula relacionada. */
export async function getQuestions(userId: string): Promise<{ data: QuestionWithContent[]; error: string | null }> {
  const { data, error } = await supabase
    .from("questions")
    .select(QUESTION_WITH_CONTENT_SELECT)
    .eq("user_id", userId)
    .order("created_at", { ascending: false });
  if (error) return { data: [], error: "Não foi possível carregar suas perguntas." };
  return { data: (data ?? []) as unknown as QuestionWithContent[], error: null };
}

export async function getQuestionById(id: string): Promise<{ data: QuestionWithContent | null; error: string | null }> {
  const { data, error } = await supabase.from("questions").select(QUESTION_WITH_CONTENT_SELECT).eq("id", id).single();
  if (error) return { data: null, error: "Pergunta não encontrada." };
  return { data: data as unknown as QuestionWithContent, error: null };
}

export async function createQuestion(
  question: Partial<Question> & { user_id: string; question: string; answer: string }
) {
  const { data, error } = await supabase
    .from("questions")
    .insert({ ...question, correct_count: 0, wrong_count: 0, last_reviewed_at: null })
    .select()
    .single();
  if (error) return { data: null, error: "Não foi possível salvar a pergunta." };
  return { data: data as Question, error: null };
}

/** Atualiza pergunta/resposta/aula/dificuldade — nunca mexe em estatísticas. */
export async function updateQuestion(
  id: string,
  updates: Partial<Pick<Question, "question" | "answer" | "content_id" | "difficulty">>
) {
  const { data, error } = await supabase
    .from("questions")
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq("id", id)
    .select()
    .single();
  if (error) return { data: null, error: "Não foi possível salvar as alterações." };
  return { data: data as Question, error: null };
}

export async function deleteQuestion(id: string) {
  const { error } = await supabase.from("questions").delete().eq("id", id);
  return { error: error ? "Não foi possível excluir a pergunta." : null };
}

/** Incrementa correct_count com base no valor atual (nunca sobrescreve com um valor fixo). */
export async function registerCorrectAnswer(id: string, currentCorrectCount: number) {
  const { data, error } = await supabase
    .from("questions")
    .update({ correct_count: currentCorrectCount + 1, last_reviewed_at: new Date().toISOString() })
    .eq("id", id)
    .select()
    .single();
  if (error) return { data: null, error: "Não foi possível registrar a resposta." };
  return { data: data as Question, error: null };
}

/** Incrementa wrong_count com base no valor atual (nunca sobrescreve com um valor fixo). */
export async function registerWrongAnswer(id: string, currentWrongCount: number) {
  const { data, error } = await supabase
    .from("questions")
    .update({ wrong_count: currentWrongCount + 1, last_reviewed_at: new Date().toISOString() })
    .eq("id", id)
    .select()
    .single();
  if (error) return { data: null, error: "Não foi possível registrar a resposta." };
  return { data: data as Question, error: null };
}
