import { useCallback, useEffect, useState } from "react";
import { useAuth } from "@/hooks/useAuth";
import { useOnlineStatus } from "@/hooks/useOnlineStatus";
import { getPendingCount, getQueueItems, processSyncQueue, isSyncing, syncEvents } from "@/services/syncService";
import { getSyncMetadata } from "@/services/offlineService";
import type { SyncQueueItem } from "@/lib/localDb";

export type SyncStatus = "offline" | "syncing" | "synced" | "pending" | "error";

export function useSync() {
  const { user } = useAuth();
  const { isOnline } = useOnlineStatus();
  const [pendingCount, setPendingCount] = useState(0);
  const [errorCount, setErrorCount] = useState(0);
  const [items, setItems] = useState<SyncQueueItem[]>([]);
  const [lastSyncAt, setLastSyncAt] = useState<string | null>(null);
  const [syncing, setSyncing] = useState(false);

  const refresh = useCallback(async () => {
    if (!user) return;
    const [count, queueItems, meta] = await Promise.all([getPendingCount(user.id), getQueueItems(user.id), getSyncMetadata(user.id)]);
    setPendingCount(count);
    setErrorCount(queueItems.filter((i) => i.status === "error").length);
    setItems(queueItems);
    setLastSyncAt(meta.lastSuccessfulSyncAt);
    setSyncing(isSyncing());
  }, [user]);

  useEffect(() => {
    refresh();
    const handler = () => refresh();
    syncEvents.addEventListener("changed", handler);
    return () => syncEvents.removeEventListener("changed", handler);
  }, [refresh]);

  // Sincroniza automaticamente assim que a conexão volta.
  useEffect(() => {
    if (isOnline && user && pendingCount > 0) {
      processSyncQueue(user.id).then(refresh);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isOnline]);

  async function syncNow() {
    if (!user) return { error: "Você precisa estar autenticado." };
    if (!isOnline) return { error: "Você está offline." };
    await processSyncQueue(user.id);
    await refresh();
    return { error: null };
  }

  const status: SyncStatus = !isOnline
    ? "offline"
    : syncing
    ? "syncing"
    : errorCount > 0
    ? "error"
    : pendingCount > 0
    ? "pending"
    : "synced";

  return { status, pendingCount, errorCount, items, lastSyncAt, isOnline, syncNow, refresh };
}
