import { Link } from "react-router-dom";
import { Cloud, CloudOff, RefreshCw, AlertTriangle, Clock3 } from "lucide-react";
import { useSync } from "@/hooks/useSync";

const CONFIG = {
  offline: { icon: CloudOff, label: "Offline", className: "text-slate-400" },
  syncing: { icon: RefreshCw, label: "Sincronizando...", className: "text-brand-600 animate-pulse" },
  error: { icon: AlertTriangle, label: "Erro de sincronização", className: "text-red-600" },
  pending: { icon: Clock3, label: "Alterações pendentes", className: "text-yellow-600" },
  synced: { icon: Cloud, label: "Sincronizado", className: "text-green-600" },
} as const;

export function SyncIndicator() {
  const { status, pendingCount } = useSync();
  const { icon: Icon, label, className } = CONFIG[status];

  const text = status === "pending" ? `${pendingCount} pendente${pendingCount === 1 ? "" : "s"}` : label;

  return (
    <Link
      to="/sync"
      title={label}
      className={`flex items-center gap-1.5 rounded-full px-2.5 py-1 text-xs font-medium hover:bg-slate-100 dark:hover:bg-slate-800 ${className}`}
    >
      <Icon className={`h-3.5 w-3.5 ${status === "syncing" ? "animate-spin" : ""}`} />
      <span className="hidden sm:inline">{text}</span>
    </Link>
  );
}
