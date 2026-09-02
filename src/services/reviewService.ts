import { supabase } from "@/lib/supabase";
import type { Review, ReviewWithContent } from "@/types/database";

const REVIEW_WITH_CONTENT_SELECT = "*, content:study_contents(id, title, week_number, day_name)";

/** Busca todas as revisões do usuário em uma única query, já com a aula relacionada. */
export async function getReviews(userId: string): Promise<{ data: ReviewWithContent[]; error: string | null }> {
  const { data, error } = await supabase
    .from("reviews")
    .select(REVIEW_WITH_CONTENT_SELECT)
    .eq("user_id", userId)
    .order("review_date", { ascending: true });
  if (error) return { data: [], error: "Não foi possível carregar suas revisões." };
  return { data: (data ?? []) as unknown as ReviewWithContent[], error: null };
}

export async function getReviewById(id: string): Promise<{ data: ReviewWithContent | null; error: string | null }> {
  const { data, error } = await supabase.from("reviews").select(REVIEW_WITH_CONTENT_SELECT).eq("id", id).single();
  if (error) return { data: null, error: "Revisão não encontrada." };
  return { data: data as unknown as ReviewWithContent, error: null };
}

export async function createReview(review: Partial<Review> & { user_id: string; title: string; review_date: string }) {
  const { data, error } = await supabase.from("reviews").insert(review).select().single();
  if (error) return { data: null, error: "Não foi possível salvar a revisão." };
  return { data: data as Review, error: null };
}

export async function updateReview(id: string, updates: Partial<Review>) {
  const { data, error } = await supabase
    .from("reviews")
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq("id", id)
    .select()
    .single();
  if (error) return { data: null, error: "Não foi possível salvar as alterações." };
  return { data: data as Review, error: null };
}

export async function deleteReview(id: string) {
  const { error } = await supabase.from("reviews").delete().eq("id", id);
  return { error: error ? "Não foi possível excluir a revisão." : null };
}

export async function completeReview(id: string) {
  return updateReview(id, { completed: true, completed_at: new Date().toISOString() });
}

export async function uncompleteReview(id: string) {
  return updateReview(id, { completed: false, completed_at: null });
}
