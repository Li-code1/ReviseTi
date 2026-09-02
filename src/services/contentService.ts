import { supabase } from "@/lib/supabase";
import type { StudyContent, ContentTopic } from "@/types/database";

export async function listContents(): Promise<{ data: StudyContent[]; error: string | null }> {
  const { data, error } = await supabase
    .from("study_contents")
    .select("*")
    .eq("is_active", true)
    .order("week_number", { ascending: true })
    .order("order_index", { ascending: true });
  if (error) return { data: [], error: "Não foi possível carregar os conteúdos." };
  return { data: (data ?? []) as StudyContent[], error: null };
}

export async function listContentsByWeek(weekNumber: number): Promise<{ data: StudyContent[]; error: string | null }> {
  const { data, error } = await supabase
    .from("study_contents")
    .select("*")
    .eq("is_active", true)
    .eq("week_number", weekNumber)
    .order("order_index", { ascending: true });
  if (error) return { data: [], error: "Não foi possível carregar a semana." };
  return { data: (data ?? []) as StudyContent[], error: null };
}

export async function getContentBySlug(slug: string): Promise<{ data: StudyContent | null; error: string | null }> {
  const { data, error } = await supabase.from("study_contents").select("*").eq("slug", slug).single();
  if (error) return { data: null, error: "Conteúdo não encontrado." };
  return { data: data as StudyContent, error: null };
}

export async function getTopicsForContent(contentId: string): Promise<{ data: ContentTopic[]; error: string | null }> {
  const { data, error } = await supabase
    .from("content_topics")
    .select("*")
    .eq("content_id", contentId)
    .order("order_index", { ascending: true });
  if (error) return { data: [], error: "Não foi possível carregar os tópicos." };
  return { data: (data ?? []) as ContentTopic[], error: null };
}
