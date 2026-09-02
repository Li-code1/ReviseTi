import { LucideIcon, Loader2, Inbox, AlertTriangle } from "lucide-react";

interface Props {
  icon?: LucideIcon;
  title: string;
  description?: string;
}

export function LoadingState({ label = "Carregando..." }: { label?: string }) {
  return (
    <div className="flex flex-col items-center justify-center gap-3 py-16 text-slate-500 dark:text-slate-400">
      <Loader2 className="h-6 w-6 animate-spin" aria-hidden="true" />
      <p className="text-sm">{label}</p>
    </div>
  );
}

export function EmptyState({ icon: Icon = Inbox, title, description }: Props) {
  return (
    <div className="flex flex-col items-center justify-center gap-2 rounded-2xl border border-dashed border-slate-200 py-16 text-center dark:border-slate-800">
      <Icon className="h-8 w-8 text-slate-300 dark:text-slate-600" aria-hidden="true" />
      <p className="font-medium text-slate-700 dark:text-slate-200">{title}</p>
      {description && <p className="max-w-xs text-sm text-slate-500 dark:text-slate-400">{description}</p>}
    </div>
  );
}

export function ErrorState({ icon: Icon = AlertTriangle, title, description }: Props) {
  return (
    <div
      role="alert"
      className="flex flex-col items-center justify-center gap-2 rounded-2xl border border-red-100 bg-red-50 py-16 text-center dark:border-red-900/40 dark:bg-red-950/30"
    >
      <Icon className="h-8 w-8 text-red-500" aria-hidden="true" />
      <p className="font-medium text-red-700 dark:text-red-300">{title}</p>
      {description && <p className="max-w-xs text-sm text-red-600 dark:text-red-400">{description}</p>}
    </div>
  );
}
