import { useRegisterSW } from "virtual:pwa-register/react";
import { Download, X } from "lucide-react";

/**
 * Mostra um aviso discreto quando uma nova versão do app já foi baixada em
 * segundo plano. Nunca atualiza sozinho — o registerType "prompt" (vite.config.ts)
 * garante que uma sessão de estudo em andamento nunca é interrompida por uma
 * atualização silenciosa.
 */
export function UpdatePrompt() {
  const { needRefresh: [needRefresh], updateServiceWorker } = useRegisterSW({
    onRegisteredSW(_url, registration) {
      // Verifica periodicamente se existe uma versão nova publicada.
      if (registration) {
        setInterval(() => registration.update(), 60 * 60 * 1000);
      }
    },
  });

  if (!needRefresh) return null;

  return (
    <div className="fixed inset-x-0 bottom-4 z-50 flex justify-center px-4">
      <div className="flex items-center gap-3 rounded-xl border border-slate-200 bg-white px-4 py-3 shadow-lg dark:border-slate-700 dark:bg-slate-900">
        <Download className="h-4 w-4 flex-shrink-0 text-brand-600" />
        <p className="text-sm">Nova versão disponível.</p>
        <button onClick={() => updateServiceWorker(true)} className="btn-primary px-3 py-1.5 text-xs">
          Atualizar
        </button>
      </div>
    </div>
  );
}
