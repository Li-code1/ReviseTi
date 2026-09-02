import { NavLink } from "react-router-dom";
import { LayoutDashboard, BookOpen, RefreshCw, HelpCircle, TrendingUp } from "lucide-react";

// Máximo 5 itens principais — ações secundárias (Configurações, Sincronização,
// Sair) ficam no menu do usuário / gaveta, não aqui.
const ITEMS = [
  { to: "/dashboard", label: "Início", icon: LayoutDashboard },
  { to: "/contents", label: "Conteúdo", icon: BookOpen },
  { to: "/reviews", label: "Revisões", icon: RefreshCw },
  { to: "/questions", label: "Perguntas", icon: HelpCircle },
  { to: "/progress", label: "Progresso", icon: TrendingUp },
];

export function BottomNav() {
  return (
    <nav
      aria-label="Navegação principal"
      className="fixed inset-x-0 bottom-0 z-30 flex border-t border-slate-200 bg-white pb-[env(safe-area-inset-bottom)] dark:border-slate-800 dark:bg-slate-900 lg:hidden"
    >
      {ITEMS.map(({ to, label, icon: Icon }) => (
        <NavLink
          key={to}
          to={to}
          className={({ isActive }) =>
            `flex flex-1 flex-col items-center gap-0.5 py-2 text-[11px] font-medium transition ${
              isActive ? "text-brand-600 dark:text-brand-400" : "text-slate-500 dark:text-slate-400"
            }`
          }
        >
          {({ isActive }) => (
            <>
              <Icon className="h-5 w-5" strokeWidth={isActive ? 2.5 : 2} aria-hidden="true" />
              {label}
            </>
          )}
        </NavLink>
      ))}
    </nav>
  );
}
