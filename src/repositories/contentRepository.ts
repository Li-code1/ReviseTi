import { localDb } from "@/lib/localDb";
import * as contentService from "@/services/contentService";
import type { StudyContent, ContentTopic } from "@/types/database";

export async function listContents(): Promise<{ data: StudyContent[]; error: string | null }> {
  if (navigator.onLine) {
    const remote = await contentService.listContents();
    if (!remote.error) return remote; // localDb.contents é populado no pull inicial / sync; não sobrescrevemos aqui para não perder os topics já salvos.
  }
  const local = await localDb.contents.orderBy("week_number").toArray();
  return { data: local, error: null };
}

export async function listContentsByWeek(weekNumber: number): Promise<{ data: StudyContent[]; error: string | null }> {
  if (navigator.onLine) {
    const remote = await contentService.listContentsByWeek(weekNumber);
    if (!remote.error) return remote;
  }
  const local = await localDb.contents.where("week_number").equals(weekNumber).sortBy("order_index");
  return { data: local, error: null };
}

export async function getContentBySlug(slug: string): Promise<{ data: StudyContent | null; error: string | null }> {
  if (navigator.onLine) {
    const remote = await contentService.getContentBySlug(slug);
    if (!remote.error) return remote;
  }
  const local = await localDb.contents.where("slug").equals(slug).first();
  return { data: local ?? null, error: local ? null : "Conteúdo não encontrado offline." };
}

export async function getTopicsForContent(contentId: string): Promise<{ data: ContentTopic[]; error: string | null }> {
  if (navigator.onLine) {
    const remote = await contentService.getTopicsForContent(contentId);
    if (!remote.error) return remote;
  }
  const local = await localDb.contents.get(contentId);
  return { data: local?.topics ?? [], error: null };
}
