import { CheckCircle2, BookOpenCheck, HelpCircle, Clock } from "lucide-react";
import type { ActivityItem } from "@/services/dashboardService";
import { relativeTime } from "@/utils/time";

const ICONS = {
  content_completed: CheckCircle2,
  review_completed: BookOpenCheck,
  question_answered: HelpCircle,
  study_session: Clock,
};

export function RecentActivity({ items }: { items: ActivityItem[] }) {
  if (items.length === 0) {
    return <p className="text-sm text-slate-400">Nenhuma atividade ainda. Comece estudando seu primeiro conteúdo.</p>;
  }

  return (
    <ul className="space-y-3">
      {items.map((item, i) => {
        const Icon = ICONS[item.kind];
        return (
          <li key={i} className="flex items-start gap-3">
            <div className="mt-0.5 flex h-7 w-7 flex-shrink-0 items-center justify-center rounded-full bg-brand-50 text-brand-600 dark:bg-brand-900/30 dark:text-brand-300">
              <Icon className="h-3.5 w-3.5" />
            </div>
            <div>
              <p className="text-sm text-slate-700 dark:text-slate-300">{item.label}</p>
              <p className="text-xs text-slate-400">{relativeTime(item.timestamp)}</p>
            </div>
          </li>
        );
      })}
    </ul>
  );
}
