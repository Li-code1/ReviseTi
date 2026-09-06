import { useState } from "react";
import { Outlet } from "react-router-dom";
import { X } from "lucide-react";
import { Sidebar } from "./Sidebar";
import { Header } from "./Header";
import { ConnectionBanner } from "./ConnectionBanner";
import { BottomNav } from "./BottomNav";
import { ErrorBoundary } from "./ErrorBoundary";
import { useAuth } from "@/hooks/useAuth";
import { useEffect } from "react";
import { getProfile } from "@/services/profileService";

export function AppLayout() {
  const { user } = useAuth();
  const [mobileOpen, setMobileOpen] = useState(false);
  const [fullName, setFullName] = useState<string>("");

  useEffect(() => {
    if (!user) return;
    getProfile(user.id).then((profile) => setFullName(profile?.full_name ?? user.email ?? "Usuário"));
  }, [user]);

  return (
    <div className="flex h-screen overflow-hidden bg-slate-50 dark:bg-slate-950">
      {/* Sidebar - desktop */}
      <aside className="hidden w-64 flex-shrink-0 border-r border-slate-200 bg-white dark:border-slate-800 dark:bg-slate-900 lg:block">
        <Sidebar userName={fullName} />
      </aside>

      {/* Sidebar - mobile drawer */}
      {mobileOpen && (
        <div className="fixed inset-0 z-40 lg:hidden">
          <div className="absolute inset-0 bg-black/40" onClick={() => setMobileOpen(false)} />
          <div className="relative flex h-full w-72 flex-col bg-white shadow-xl dark:bg-slate-900">
            <button
              onClick={() => setMobileOpen(false)}
              aria-label="Fechar menu"
              className="absolute right-3 top-4 rounded-lg p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800"
            >
              <X className="h-5 w-5" />
            </button>
            <Sidebar userName={fullName} onNavigate={() => setMobileOpen(false)} />
          </div>
        </div>
      )}

      <div className="flex min-w-0 flex-1 flex-col">
        <ConnectionBanner />
        <Header userName={fullName} onMenuClick={() => setMobileOpen(true)} />
        <main className="flex-1 overflow-y-auto px-4 py-6 pb-20 lg:px-8 lg:py-8 lg:pb-8">
          <div className="mx-auto max-w-6xl">
            <ErrorBoundary>
              <Outlet />
            </ErrorBoundary>
          </div>
        </main>
      </div>
      <BottomNav />
    </div>
  );
}
