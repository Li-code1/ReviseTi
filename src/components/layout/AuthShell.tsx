import { ReactNode } from "react";
import { GraduationCap } from "lucide-react";

export function AuthShell({ title, subtitle, children }: { title: string; subtitle?: string; children: ReactNode }) {
  return (
    <div className="flex min-h-screen items-center justify-center bg-slate-50 px-4 py-10 dark:bg-slate-950">
      <div className="w-full max-w-sm">
        <div className="mb-8 flex flex-col items-center text-center">
          <div className="mb-3 flex h-12 w-12 items-center justify-center rounded-2xl bg-brand-600 text-white">
            <GraduationCap className="h-6 w-6" />
          </div>
          <h1 className="text-2xl font-bold tracking-tight">ReviseTI</h1>
          <p className="mt-1 text-sm text-slate-500 dark:text-slate-400">Seu estudo. Seu progresso. Sua evolução.</p>
        </div>
        <div className="card">
          <h2 className="mb-1 text-lg font-semibold">{title}</h2>
          {subtitle && <p className="mb-5 text-sm text-slate-500 dark:text-slate-400">{subtitle}</p>}
          {children}
        </div>
      </div>
    </div>
  );
}
