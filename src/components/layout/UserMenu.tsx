import { useEffect, useRef, useState } from "react";
import { useNavigate } from "react-router-dom";
import { User, Settings, Cloud, LogOut } from "lucide-react";
import { useSync } from "@/hooks/useSync";
import { LogoutButton } from "./LogoutButton";

export function UserMenu({ userName }: { userName: string }) {
  const { pendingCount } = useSync();
  const navigate = useNavigate();
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  const initials = userName.split(" ").map((p) => p[0]).slice(0, 2).join("").toUpperCase();

  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    }
    function handleEscape(e: KeyboardEvent) {
      if (e.key === "Escape") setOpen(false);
    }
    document.addEventListener("mousedown", handleClickOutside);
    document.addEventListener("keydown", handleEscape);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
      document.removeEventListener("keydown", handleEscape);
    };
  }, []);

  function go(path: string) {
    setOpen(false);
    navigate(path);
  }

  return (
    <div className="relative" ref={ref}>
      <button
        onClick={() => setOpen((v) => !v)}
        aria-haspopup="menu"
        aria-expanded={open}
        aria-label="Menu do usuário"
        className="flex h-9 w-9 items-center justify-center rounded-full bg-brand-100 text-sm font-semibold text-brand-700 transition hover:ring-2 hover:ring-brand-200 dark:bg-brand-900/40 dark:text-brand-300"
      >
        {initials || "U"}
      </button>

      {open && (
        <div
          role="menu"
          className="absolute right-0 z-20 mt-2 w-52 rounded-xl border border-slate-200 bg-white py-1 shadow-lg dark:border-slate-700 dark:bg-slate-900"
        >
          <div className="truncate border-b border-slate-100 px-3.5 py-2 text-sm font-medium text-slate-700 dark:border-slate-800 dark:text-slate-300">
            {userName}
          </div>
          <button role="menuitem" onClick={() => go("/settings")} className="flex w-full items-center gap-2 px-3.5 py-2 text-left text-sm hover:bg-slate-50 dark:hover:bg-slate-800">
            <User className="h-4 w-4" /> Perfil
          </button>
          <button role="menuitem" onClick={() => go("/settings")} className="flex w-full items-center gap-2 px-3.5 py-2 text-left text-sm hover:bg-slate-50 dark:hover:bg-slate-800">
            <Settings className="h-4 w-4" /> Configurações
          </button>
          <button role="menuitem" onClick={() => go("/sync")} className="flex w-full items-center gap-2 px-3.5 py-2 text-left text-sm hover:bg-slate-50 dark:hover:bg-slate-800">
            <Cloud className="h-4 w-4" /> Sincronização
            {pendingCount > 0 && (
              <span className="ml-auto rounded-full bg-yellow-100 px-1.5 py-0.5 text-xs font-semibold text-yellow-700 dark:bg-yellow-900/40 dark:text-yellow-300">
                {pendingCount}
              </span>
            )}
          </button>
          <LogoutButton
            role="menuitem"
            className="flex w-full items-center gap-2 border-t border-slate-100 px-3.5 py-2 text-left text-sm text-red-600 hover:bg-red-50 dark:border-slate-800 dark:hover:bg-red-950/30"
          >
            <LogOut className="h-4 w-4" /> Sair
          </LogoutButton>
        </div>
      )}
    </div>
  );
}
