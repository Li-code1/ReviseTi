import { supabase } from "@/lib/supabase";
import { localDb, type SyncQueueItem, type SyncEntity, type SyncOperation } from "@/lib/localDb";
import { markSyncAttempt, markSyncSuccess } from "@/services/offlineService";

// Backoff entre tentativas: 30s, 1min, 5min (depois se mantém em 5min).
const BACKOFF_SECONDS = [30, 60, 300];

/** Pequeno event bus para a UI (indicador de sync, página /sync) reagir sem precisar de polling agressivo. */
export const syncEvents = new EventTarget();
function notifyChanged() {
  syncEvents.dispatchEvent(new Event("changed"));
}

export type SyncStatusSummary = "idle" | "syncing" | "error" | "offline";

let syncingNow = false;

export async function enqueue(
  entity: SyncEntity,
  entityId: string,
  operation: SyncOperation,
  payload: object,
  userId: string
): Promise<void> {
  await localDb.syncQueue.add({
    entity,
    entityId,
    operation,
    payload: payload as unknown as Record<string, unknown>,
    userId,
    createdAt: new Date().toISOString(),
    retryCount: 0,
    lastError: null,
    status: "pending",
    nextAttemptAt: new Date().toISOString(),
  });
  notifyChanged();
}

export async function getPendingCount(userId: string): Promise<number> {
  return localDb.syncQueue.where("userId").equals(userId).count();
}

export async function getQueueItems(userId: string): Promise<SyncQueueItem[]> {
  const items = await localDb.syncQueue.where("userId").equals(userId).toArray();
  return items.sort((a, b) => a.createdAt.localeCompare(b.createdAt));
}

function backoffSeconds(retryCount: number): number {
  return BACKOFF_SECONDS[Math.min(retryCount, BACKOFF_SECONDS.length - 1)];
}

/** Compara updated_at remoto x local: só aplica a alteração da fila se ela for a mais recente (last-write-wins). */
function isLocalNewer(localTimestamp: string, remoteUpdatedAt: string | null): boolean {
  if (!remoteUpdatedAt) return true;
  return new Date(localTimestamp).getTime() >= new Date(remoteUpdatedAt).getTime();
}

async function pushReview(item: SyncQueueItem): Promise<void> {
  const { entityId, operation, payload } = item;
  if (operation === "create") {
    const { error } = await supabase.from("reviews").insert({ id: entityId, ...payload });
    if (error && !error.message.includes("duplicate")) throw new Error(error.message);
    return;
  }
  if (operation === "delete") {
    const { error } = await supabase.from("reviews").delete().eq("id", entityId);
    if (error) throw new Error(error.message);
    return;
  }
  // update / complete / uncomplete: todos são um UPDATE, com conflito checado por updated_at.
  const { data: remote } = await supabase.from("reviews").select("updated_at").eq("id", entityId).maybeSingle();
  if (remote && !isLocalNewer(item.createdAt, remote.updated_at)) {
    return; // versão remota é mais nova — não sobrescreve (last-write-wins)
  }
  const { error } = await supabase.from("reviews").update({ ...payload, updated_at: new Date().toISOString() }).eq("id", entityId);
  if (error) throw new Error(error.message);
}

async function pushQuestion(item: SyncQueueItem): Promise<void> {
  const { entityId, operation, payload } = item;
  if (operation === "create") {
    const { error } = await supabase
      .from("questions")
      .insert({ id: entityId, ...payload, correct_count: 0, wrong_count: 0, last_reviewed_at: null });
    if (error && !error.message.includes("duplicate")) throw new Error(error.message);
    return;
  }
  if (operation === "delete") {
    const { error } = await supabase.from("questions").delete().eq("id", entityId);
    if (error) throw new Error(error.message);
    return;
  }
  if (operation === "increment_correct" || operation === "increment_wrong") {
    const field = operation === "increment_correct" ? "correct_count" : "wrong_count";
    const { data: current, error: fetchError } = await supabase.from("questions").select(field).eq("id", entityId).maybeSingle();
    if (fetchError) throw new Error(fetchError.message);
    const currentValue = (current as Record<string, number> | null)?.[field] ?? 0;
    const { error } = await supabase
      .from("questions")
      .update({ [field]: currentValue + 1, last_reviewed_at: payload.last_reviewed_at })
      .eq("id", entityId);
    if (error) throw new Error(error.message);
    return;
  }
  // update comum (pergunta/resposta/aula/dificuldade)
  const { data: remote } = await supabase.from("questions").select("updated_at").eq("id", entityId).maybeSingle();
  if (remote && !isLocalNewer(item.createdAt, remote.updated_at)) return;
  const { error } = await supabase.from("questions").update({ ...payload, updated_at: new Date().toISOString() }).eq("id", entityId);
  if (error) throw new Error(error.message);
}

async function pushStudyProgress(item: SyncQueueItem): Promise<void> {
  const { error } = await supabase
    .from("study_progress")
    .upsert({ ...item.payload, updated_at: new Date().toISOString() }, { onConflict: "user_id,content_id" });
  if (error) throw new Error(error.message);
}

async function pushStudySession(item: SyncQueueItem): Promise<void> {
  const { error } = await supabase.from("study_sessions").insert({ id: item.entityId, ...item.payload });
  if (error && !error.message.includes("duplicate")) throw new Error(error.message);
}

async function pushStudyGoal(item: SyncQueueItem): Promise<void> {
  const { error } = await supabase
    .from("study_goals")
    .upsert({ user_id: item.userId, ...item.payload, updated_at: new Date().toISOString() }, { onConflict: "user_id" });
  if (error) throw new Error(error.message);
}

/** Tentativas são registros imutáveis (insert-only) — nunca update/delete, só criação. */
async function pushQuestionAttempt(item: SyncQueueItem): Promise<void> {
  const { error } = await supabase.from("question_attempts").insert({ id: item.entityId, ...item.payload });
  if (error && !error.message.includes("duplicate")) throw new Error(error.message);
}

async function pushItem(item: SyncQueueItem): Promise<void> {
  switch (item.entity) {
    case "reviews":
      return pushReview(item);
    case "questions":
      return pushQuestion(item);
    case "study_progress":
      return pushStudyProgress(item);
    case "study_sessions":
      return pushStudySession(item);
    case "study_goals":
      return pushStudyGoal(item);
    case "question_attempts":
      return pushQuestionAttempt(item);
  }
}

async function markLocalSynced(entity: SyncEntity, entityId: string): Promise<void> {
  switch (entity) {
    case "reviews":
      await localDb.reviews.update(entityId, { synced: true });
      return;
    case "questions":
      await localDb.questions.update(entityId, { synced: true });
      return;
    case "study_progress":
      await localDb.studyProgress.update(entityId, { synced: true });
      return;
    case "study_sessions":
      await localDb.studySessions.update(entityId, { synced: true });
      return;
    case "study_goals":
      await localDb.studyGoals.update(entityId, { synced: true });
      return;
    case "question_attempts":
      await localDb.questionAttempts.update(entityId, { synced: true });
      return;
  }
}

/** Processa a fila de sincronização de um usuário. Seguro de chamar em paralelo (ignora se já estiver rodando). */
export async function processSyncQueue(userId: string): Promise<void> {
  if (syncingNow) return;
  syncingNow = true;
  notifyChanged();
  try {
    await markSyncAttempt(userId);
    const now = new Date().toISOString();
    const items = (await localDb.syncQueue.where("userId").equals(userId).toArray())
      .filter((i) => i.nextAttemptAt <= now)
      .sort((a, b) => a.createdAt.localeCompare(b.createdAt));

    let hadSuccess = false;
    for (const item of items) {
      try {
        await pushItem(item);
        if (item.id !== undefined) await localDb.syncQueue.delete(item.id);
        await markLocalSynced(item.entity, item.entityId);
        hadSuccess = true;
      } catch (e) {
        const message = e instanceof Error ? e.message : "Erro desconhecido ao sincronizar.";
        const retryCount = item.retryCount + 1;
        const nextAttempt = new Date(Date.now() + backoffSeconds(retryCount) * 1000).toISOString();
        if (item.id !== undefined) {
          await localDb.syncQueue.update(item.id, {
            retryCount,
            lastError: message,
            status: "error",
            nextAttemptAt: nextAttempt,
          });
        }
      }
    }
    if (hadSuccess) await markSyncSuccess(userId);
  } finally {
    syncingNow = false;
    notifyChanged();
  }
}

export function isSyncing(): boolean {
  return syncingNow;
}

/** Dispara sync em segundo plano sem bloquear quem chamou (usado após cada escrita otimista). */
export function syncInBackground(userId: string): void {
  processSyncQueue(userId).catch(() => {
    /* erros já ficam registrados por item na fila */
  });
}
