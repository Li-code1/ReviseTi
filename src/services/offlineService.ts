import { localDb, clearPrivateLocalData, type LocalContent } from "@/lib/localDb";
import { supabase } from "@/lib/supabase";
import { listContents } from "@/services/contentService";
import { getReviews } from "@/services/reviewService";
import { getQuestions } from "@/services/questionService";
import { listProgress } from "@/services/progressService";
import { listSessions } from "@/services/studySessionService";
import { getStudyGoal } from "@/services/studyGoalService";
import { listAllQuestions, getAttempts } from "@/services/officialQuestionService";
import type { ContentTopic } from "@/types/database";

const SESSIONS_SYNC_WINDOW_DAYS = 90;

async function getMetadata(userId: string) {
  return localDb.metadata.get(`sync:${userId}`);
}

async function setMetadata(userId: string, patch: Partial<{ lastSyncAt: string; lastSuccessfulSyncAt: string; syncVersion: number }>) {
  const current = await getMetadata(userId);
  await localDb.metadata.put({
    key: `sync:${userId}`,
    value: {
      userId,
      lastSyncAt: current?.value.lastSyncAt ?? null,
      lastSuccessfulSyncAt: current?.value.lastSuccessfulSyncAt ?? null,
      syncVersion: current?.value.syncVersion ?? 1,
      ...patch,
    },
  });
}

export async function getSyncMetadata(userId: string) {
  const row = await getMetadata(userId);
  return row?.value ?? { userId, lastSyncAt: null, lastSuccessfulSyncAt: null, syncVersion: 1 };
}

/**
 * Ao logar, garante que os dados locais pertencem ao usuário atual.
 * Se o último usuário guardado localmente for outro, limpa tudo antes —
 * é o que impede o usuário B de ver dados do usuário A no mesmo aparelho.
 */
export async function ensureLocalDataOwnership(userId: string): Promise<void> {
  const keys = await localDb.metadata.toCollection().primaryKeys();
  const isDifferentUser = keys.length > 0 && !keys.includes(`sync:${userId}`);
  if (isDifferentUser) {
    await clearPrivateLocalData();
  }
}

/** Baixa os dados essenciais do usuário do Supabase e popula o IndexedDB. Only chamado quando online. */
export async function pullInitialData(userId: string): Promise<{ error: string | null }> {
  try {
    const [contentsRes, reviewsRes, questionsRes, progressRes, sessionsRes, goalRes, topicsRes, officialQuestionsRes, attemptsRes] = await Promise.all([
      listContents(),
      getReviews(userId),
      getQuestions(userId),
      listProgress(userId),
      listSessions(userId),
      getStudyGoal(userId),
      supabase.from("content_topics").select("*"),
      listAllQuestions(),
      getAttempts(userId),
    ]);

    if (contentsRes.error) return { error: contentsRes.error };

    // Agrupa tópicos por content_id para não fazer N chamadas.
    const topicsByContent = new Map<string, ContentTopic[]>();
    for (const t of (topicsRes.data ?? []) as ContentTopic[]) {
      topicsByContent.set(t.content_id, [...(topicsByContent.get(t.content_id) ?? []), t]);
    }
    const localContents: LocalContent[] = contentsRes.data.map((c) => ({ ...c, topics: topicsByContent.get(c.id) ?? [] }));

    // Sessões: só os últimos 90 dias, para não baixar histórico infinito.
    const cutoff = new Date();
    cutoff.setDate(cutoff.getDate() - SESSIONS_SYNC_WINDOW_DAYS);
    const cutoffISO = cutoff.toISOString().slice(0, 10);
    const recentSessions = sessionsRes.data.filter((s) => s.study_date >= cutoffISO);

    await localDb.transaction(
      "rw",
      [localDb.contents, localDb.reviews, localDb.questions, localDb.studyProgress, localDb.studySessions, localDb.studyGoals, localDb.officialQuestions, localDb.questionAttempts],
      async () => {
        await localDb.contents.clear();
        await localDb.contents.bulkPut(localContents);

        await localDb.reviews.clear();
        await localDb.reviews.bulkPut(reviewsRes.data.map(({ content: _content, ...r }) => ({ ...r, synced: true })));

        await localDb.questions.clear();
        await localDb.questions.bulkPut(questionsRes.data.map(({ content: _content, ...q }) => ({ ...q, synced: true })));

        await localDb.studyProgress.clear();
        await localDb.studyProgress.bulkPut(progressRes.data.map((p) => ({ ...p, id: p.content_id, synced: true })));

        await localDb.studySessions.clear();
        await localDb.studySessions.bulkPut(recentSessions.map((s) => ({ ...s, synced: true })));

        await localDb.studyGoals.clear();
        if (goalRes.data) await localDb.studyGoals.put({ ...goalRes.data, id: userId, synced: true });

        if (!officialQuestionsRes.error) {
          await localDb.officialQuestions.clear();
          await localDb.officialQuestions.bulkPut(officialQuestionsRes.data);
        }

        if (!attemptsRes.error) {
          await localDb.questionAttempts.clear();
          await localDb.questionAttempts.bulkPut(attemptsRes.data.map((a) => ({ ...a, synced: true })));
        }
      }
    );

    const now = new Date().toISOString();
    await setMetadata(userId, { lastSyncAt: now, lastSuccessfulSyncAt: now });
    return { error: null };
  } catch (e) {
    return { error: e instanceof Error ? e.message : "Falha ao sincronizar dados iniciais." };
  }
}

export async function hasLocalData(userId: string): Promise<boolean> {
  const meta = await getMetadata(userId);
  return !!meta?.value.lastSuccessfulSyncAt;
}

export async function markSyncAttempt(userId: string) {
  await setMetadata(userId, { lastSyncAt: new Date().toISOString() });
}

export async function markSyncSuccess(userId: string) {
  const now = new Date().toISOString();
  await setMetadata(userId, { lastSyncAt: now, lastSuccessfulSyncAt: now });
}
