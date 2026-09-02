/**
 * Utilitários de tempo compartilhados pelo Dashboard, Progresso, Revisões e Sessões.
 * Regra de "semana" usada em todo o app: segunda a domingo.
 */

/** 0 -> "0 min" · 30 -> "30 min" · 60 -> "1h" · 90 -> "1h 30min". */
export function formatMinutes(minutes: number): string {
  if (minutes < 60) return `${minutes} min`;
  const hours = Math.floor(minutes / 60);
  const rest = minutes % 60;
  return rest === 0 ? `${hours}h` : `${hours}h ${rest}min`;
}

function toLocalDate(d: Date): Date {
  return new Date(d.getFullYear(), d.getMonth(), d.getDate());
}

export function dateToISODate(d: Date): string {
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, "0");
  const day = String(d.getDate()).padStart(2, "0");
  return `${y}-${m}-${day}`;
}

/** Início da semana (segunda-feira) contendo a data informada. */
export function startOfWeek(date: Date = new Date()): Date {
  const d = toLocalDate(date);
  const day = d.getDay(); // 0 = domingo, 1 = segunda...
  const diff = day === 0 ? -6 : 1 - day; // volta até a segunda-feira
  d.setDate(d.getDate() + diff);
  return d;
}

export function startOfMonth(date: Date = new Date()): Date {
  const d = toLocalDate(date);
  d.setDate(1);
  return d;
}

/** Últimos N dias, incluindo hoje, em ordem cronológica ("YYYY-MM-DD"). */
export function lastNDates(n: number, from: Date = new Date()): string[] {
  const dates: string[] = [];
  for (let i = n - 1; i >= 0; i--) {
    const d = toLocalDate(from);
    d.setDate(d.getDate() - i);
    dates.push(dateToISODate(d));
  }
  return dates;
}

const WEEKDAY_SHORT = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];

export function weekdayShortLabel(isoDate: string): string {
  const [y, m, d] = isoDate.split("-").map(Number);
  return WEEKDAY_SHORT[new Date(y, m - 1, d).getDay()];
}

/** "há 20 minutos" / "há 2 horas" / "ontem" / "há 3 dias" / data completa se muito antigo. */
export function relativeTime(dateStr: string): string {
  const date = new Date(dateStr);
  const now = new Date();
  const diffMs = now.getTime() - date.getTime();
  const diffMin = Math.floor(diffMs / 60000);

  if (diffMin < 1) return "agora mesmo";
  if (diffMin < 60) return `há ${diffMin} ${diffMin === 1 ? "minuto" : "minutos"}`;

  const diffHours = Math.floor(diffMin / 60);
  if (diffHours < 24) return `há ${diffHours} ${diffHours === 1 ? "hora" : "horas"}`;

  const diffDays = Math.floor(diffHours / 24);
  if (diffDays === 1) return "ontem";
  if (diffDays < 7) return `há ${diffDays} dias`;

  return date.toLocaleDateString("pt-BR");
}
