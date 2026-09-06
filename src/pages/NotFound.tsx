import { Link } from "react-router-dom";
import { Compass } from "lucide-react";

export default function NotFound() {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center gap-4 bg-slate-50 px-4 text-center dark:bg-slate-950">
      <div className="flex h-14 w-14 items-center justify-center rounded-2xl bg-brand-50 text-brand-600 dark:bg-brand-900/30 dark:text-brand-300">
        <Compass className="h-7 w-7" />
      </div>
      <h1 className="text-xl font-bold tracking-tight">Página não encontrada</h1>
      <p className="max-w-xs text-sm text-slate-500 dark:text-slate-400">
        A página que você procura não existe ou foi movida.
      </p>
      <Link to="/dashboard" className="btn-primary">
        Voltar para o Dashboard
      </Link>
    </div>
  );
}
