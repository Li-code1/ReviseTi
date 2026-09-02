import { useState } from "react";
import { Cloud, CloudOff, RefreshCw, AlertTriangle, Clock3, Loader2 } from "lucide-react";
import { useSync } from "@/hooks/useSync";
import { useToast } from "@/components/ui/Toast";

const ENTITY_LABELS: Record<string, string> = {
  reviews: "Revisão",
  questions: "Pergunta",
  study_progress: "Progresso de aula",
  study_sessions: "Sessão de estudo",
  study_goals: "Meta semanal",
};

const OPERATION_LABELS: Record<string, string> = {
  create: "criar",
  update: "atualizar",
  delete: "excluir",
  complete: "concluir",
  uncomplete: "desfazer conclusão",
  increment_correct: "registrar acerto",
  increment_wrong: "registrar erro",
  upsert: "salvar",
};

const STATUS_CONFIG = {
  offline: { icon: CloudOff, label: "Offline", color: "text-slate-400" },
  syncing: { icon: RefreshCw, label: "Sincronizando...", color: "text-brand-600" },
  error: { icon: AlertTriangle, label: "Erro de sincronização", color: "text-red-600" },
  pending: { icon: Clock3, label: "Alterações pendentes", color: "text-yellow-600" },
  synced: { icon: Cloud, label: "Sincronizado", color: "text-green-600" },
} as const;

export default function Sync() {
  const { status, pendingCount, errorCount, items, lastSyncAt, isOnline, syncNow } = useSync();
  const { showToast } = useToast();
  const [syncing, setSyncingState] = useState(false);

  async function handleSyncNow() {
    setSyncingState(true);
    const { error } = await syncNow();
    setSyncingState(false);
    if (error) showToast(error, "error");
    else showToast("Sincronização concluída.");
  }

  const { icon: StatusIcon, label: statusLabel, color } = STATUS_CONFIG[status];

  return (
    <div className="mx-auto max-w-2xl space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Sincronização</h1>
        <p className="mt-1 text-slate-500 dark:text-slate-400">
          O ReviseTI funciona offline — suas alterações ficam salvas neste aparelho e são enviadas ao Supabase assim que a conexão volta.
        </p>
      </div>

      <div className="card">
        <div className="flex items-center gap-3">
          <div className={`flex h-11 w-11 items-center justify-center rounded-xl bg-slate-50 dark:bg-slate-800 ${color}`}>
            <StatusIcon className={`h-5 w-5 ${status === "syncing" ? "animate-spin" : ""}`} />
          </div>
          <div>
            <p className="font-semibold">{statusLabel}</p>
            <p className="text-sm text-slate-500 dark:text-slate-400">
              {lastSyncAt ? `Última sincronização: ${new Date(lastSyncAt).toLocaleString("pt-BR")}` : "Ainda não sincronizado neste aparelho."}
            </p>
          </div>
        </div>

        <div className="mt-4 grid grid-cols-2 gap-4 border-t border-slate-100 pt-4 dark:border-slate-800">
          <div>
            <p className="text-xl font-bold">{pendingCount}</p>
            <p className="text-sm text-slate-500 dark:text-slate-400">
              {pendingCount === 0 ? "Nenhuma alteração pendente" : `alteração${pendingCount === 1 ? "" : "ões"} aguardando sincronização`}
            </p>
          </div>
          <div>
            <p className="text-xl font-bold text-red-600">{errorCount}</p>
            <p className="text-sm text-slate-500 dark:text-slate-400">com erro</p>
          </div>
        </div>

        <button onClick={handleSyncNow} disabled={!isOnline || syncing} className="btn-primary mt-4 w-full justify-center">
          {syncing && <Loader2 className="h-4 w-4 animate-spin" />}
          {isOnline ? "Sincronizar agora" : "Você está offline"}
        </button>
      </div>

      {items.length > 0 && (
        <div className="card">
          <h2 className="mb-3 text-lg font-semibold">Alterações pendentes</h2>
          <div className="space-y-2">
            {items.map((item) => (
              <div
                key={item.id}
                className={`flex items-center justify-between rounded-xl border px-3 py-2.5 text-sm ${
                  item.status === "error" ? "border-red-200 bg-red-50 dark:border-red-900/40 dark:bg-red-950/30" : "border-slate-100 dark:border-slate-800"
                }`}
              >
                <div>
                  <p className="font-medium">
                    {OPERATION_LABELS[item.operation] ?? item.operation} · {ENTITY_LABELS[item.entity] ?? item.entity}
                  </p>
                  {item.lastError && <p className="mt-0.5 text-xs text-red-600 dark:text-red-400">{item.lastError}</p>}
                </div>
                {item.retryCount > 0 && (
                  <span className="flex-shrink-0 text-xs text-slate-400">{item.retryCount}x tentativas</span>
                )}
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}
