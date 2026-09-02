import { NavLink } from "react-router-dom";
import { LayoutDashboard, BookOpen, RefreshCw, HelpCircle, TrendingUp, Settings, LogOut, GraduationCap, Cloud, Briefcase } from "lucide-react";
import { useSync } from "@/hooks/useSync";
import { LogoutButton } from "./LogoutButton";

const NAV_ITEMS = [
  { to: "/dashboard", label: "Dashboard", icon: LayoutDashboard },
  { to: "/contents", label: "Conteúdos", icon: BookOpen },
  { to: "/reviews", label: "Revisões", icon: RefreshCw },
  { to: "/questions", label: "Perguntas", icon: HelpCircle },
  { to: "/interview", label: "Entrevista", icon: Briefcase },
  { to: "/progress", label: "Progresso", icon: TrendingUp },
  { to: "/sync", label: "Sincronização", icon: Cloud },
  { to: "/settings", label: "Configurações", icon: Settings },
];

export function Sidebar({ userName, onNavigate }: { userName: string; onNavigate?: () => void }) {
  const { pendingCount } = useSync();

  return (
    <div className="flex h-full flex-col">
      <div className="flex items-center gap-2 px-6 py-6">
        <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-brand-600 text-white">
          <GraduationCap className="h-5 w-5" />
        </div>
        <span className="text-lg font-bold tracking-tight">ReviseTI</span>
      </div>

      <nav className="flex-1 space-y-1 px-3">
        {NAV_ITEMS.map(({ to, label, icon: Icon }) => (
          <NavLink
            key={to}
            to={to}
            onClick={onNavigate}
            className={({ isActive }) =>
              `flex items-center gap-3 rounded-xl px-3 py-2.5 text-sm font-medium transition ${
                isActive
                  ? "bg-brand-50 text-brand-700 dark:bg-brand-900/30 dark:text-brand-300"
                  : "text-slate-600 hover:bg-slate-100 dark:text-slate-300 dark:hover:bg-slate-800"
              }`
            }
          >
            <Icon className="h-4.5 w-4.5" aria-hidden="true" />
            {label}
            {to === "/sync" && pendingCount > 0 && (
              <span className="ml-auto rounded-full bg-yellow-100 px-1.5 py-0.5 text-xs font-semibold text-yellow-700 dark:bg-yellow-900/40 dark:text-yellow-300">
                {pendingCount}
              </span>
            )}
          </NavLink>
        ))}
      </nav>

      <div className="border-t border-slate-200 px-3 py-4 dark:border-slate-800">
        <div className="mb-2 truncate px-3 text-sm font-medium text-slate-700 dark:text-slate-300">{userName}</div>
        <LogoutButton className="flex w-full items-center gap-3 rounded-xl px-3 py-2.5 text-sm font-medium text-slate-600 transition hover:bg-slate-100 dark:text-slate-300 dark:hover:bg-slate-800">
          <LogOut className="h-4.5 w-4.5" aria-hidden="true" />
          Sair
        </LogoutButton>
      </div>
    </div>
  );
}
