import type { Review, ReviewStatus } from "@/types/database";
export { formatMinutes, dateToISODate } from "@/utils/time";
import { dateToISODate } from "@/utils/time";

/** Retorna a data de hoje no formato YYYY-MM-DD (mesmo formato de review_date). */
export function todayISODate(): string {
  return dateToISODate(new Date());
}

/**
 * Calcula o status de uma revisão.
 * - completed: completed = true
 * - overdue: completed = false e review_date < hoje
 * - pending: completed = false e review_date >= hoje
 * Uma revisão concluída nunca é considerada atrasada.
 */
export function getReviewStatus(review: Pick<Review, "completed" | "review_date">): ReviewStatus {
  if (review.completed) return "completed";
  return review.review_date < todayISODate() ? "overdue" : "pending";
}

export function isToday(reviewDate: string): boolean {
  return reviewDate === todayISODate();
}

export function isFuture(reviewDate: string): boolean {
  return reviewDate > todayISODate();
}

export function formatReviewDate(dateStr: string): string {
  // review_date é "YYYY-MM-DD"; construir com partes evita bug de fuso horário
  // (new Date("YYYY-MM-DD") interpreta como UTC e pode "voltar um dia").
  const [year, month, day] = dateStr.split("-").map(Number);
  return new Date(year, month - 1, day).toLocaleDateString("pt-BR");
}

export const DIFFICULTY_LABELS: Record<string, string> = {
  easy: "Fácil",
  medium: "Média",
  hard: "Difícil",
};

export const DIFFICULTY_COLORS: Record<string, string> = {
  easy: "bg-green-50 text-green-700 dark:bg-green-900/30 dark:text-green-300",
  medium: "bg-yellow-50 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-300",
  hard: "bg-red-50 text-red-700 dark:bg-red-900/30 dark:text-red-300",
};

export const STATUS_LABELS: Record<ReviewStatus, string> = {
  pending: "Pendente",
  completed: "Concluída",
  overdue: "Atrasada",
};

export const STATUS_COLORS: Record<ReviewStatus, string> = {
  pending: "bg-slate-100 text-slate-700 dark:bg-slate-800 dark:text-slate-300",
  completed: "bg-green-50 text-green-700 dark:bg-green-900/30 dark:text-green-300",
  overdue: "bg-red-50 text-red-700 dark:bg-red-900/30 dark:text-red-300",
};
