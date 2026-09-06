import Dexie, { type Table } from "dexie";
import type {
  StudyContent,
  ContentTopic,
  Review,
  Question,
  StudySession,
  StudyProgress,
  StudyGoal,
  OfficialQuestion,
  QuestionAttempt,
} from "@/types/database";

// -----------------------------------------------------------------------
// Banco local (IndexedDB via Dexie). É o cache + fila de sincronização
// offline do ReviseTI. O Supabase continua sendo a fonte oficial dos dados;
// isto aqui existe para o app funcionar sem internet e para não perder
// alterações feitas offline.
//
// Tabelas privadas (reviews, questions, studySessions, studyProgress,
// studyGoals, syncQueue) sempre guardam `userId` e todo acesso é filtrado
// por ele — isolamento entre usuários também no armazenamento local.
// `contents`/`contentTopics` são dados públicos/compartilhados, sem userId.
// -----------------------------------------------------------------------

export type SyncEntity = "reviews" | "questions" | "study_progress" | "study_sessions" | "study_goals" | "question_attempts";
export type SyncOperation = "create" | "update" | "delete" | "complete" | "uncomplete" | "increment_correct" | "increment_wrong" | "upsert";
export type SyncStatus = "pending" | "error";

export interface SyncQueueItem {
  id?: number; // autoincrement local
  entity: SyncEntity;
  entityId: string;
  operation: SyncOperation;
  payload: Record<string, unknown>;
  userId: string;
  createdAt: string;
  retryCount: number;
  lastError: string | null;
  status: SyncStatus;
  nextAttemptAt: string; // ISO — respeita o backoff entre tentativas
}

export interface LocalContent extends StudyContent {
  topics?: ContentTopic[];
}

export interface LocalReview extends Review {
  synced: boolean;
}

export interface LocalQuestion extends Question {
  synced: boolean;
}

export interface LocalStudySession extends StudySession {
  synced: boolean;
}

export interface LocalStudyProgress extends StudyProgress {
  synced: boolean;
}

export interface LocalStudyGoal extends StudyGoal {
  synced: boolean;
}

// official_questions é conteúdo público (como contents) — cache simples, sem "synced".
export interface LocalQuestionAttempt extends QuestionAttempt {
  synced: boolean;
}

export interface MetadataRow {
  key: string; // ex: "sync:<userId>"
  value: {
    userId: string;
    lastSyncAt: string | null;
    lastSuccessfulSyncAt: string | null;
    syncVersion: number;
  };
}

class ReviseTILocalDb extends Dexie {
  contents!: Table<LocalContent, string>;
  officialQuestions!: Table<OfficialQuestion, string>;
  reviews!: Table<LocalReview, string>;
  questions!: Table<LocalQuestion, string>;
  studySessions!: Table<LocalStudySession, string>;
  studyProgress!: Table<LocalStudyProgress, string>;
  studyGoals!: Table<LocalStudyGoal, string>;
  questionAttempts!: Table<LocalQuestionAttempt, string>;
  syncQueue!: Table<SyncQueueItem, number>;
  metadata!: Table<MetadataRow, string>;

  constructor() {
    super("reviseti-local-db");
    this.version(1).stores({
      contents: "id, slug, week_number",
      reviews: "id, user_id, review_date, completed",
      questions: "id, user_id, content_id",
      studySessions: "id, user_id, study_date",
      studyProgress: "id, user_id, content_id",
      studyGoals: "id, user_id",
      syncQueue: "++id, entity, entityId, userId, status",
      metadata: "key",
    });
    this.version(2).stores({
      officialQuestions: "id, content_id, category, is_interview_question",
      questionAttempts: "id, user_id, official_question_id",
    });
  }
}

export const localDb = new ReviseTILocalDb();

/** Remove todos os dados PRIVADOS de um usuário do banco local (usado no logout/troca de conta). */
export async function clearPrivateLocalData(): Promise<void> {
  await localDb.transaction(
    "rw",
    [localDb.reviews, localDb.questions, localDb.studySessions, localDb.studyProgress, localDb.studyGoals, localDb.questionAttempts, localDb.syncQueue, localDb.metadata],
    async () => {
      await Promise.all([
        localDb.reviews.clear(),
        localDb.questions.clear(),
        localDb.studySessions.clear(),
        localDb.studyProgress.clear(),
        localDb.studyGoals.clear(),
        localDb.questionAttempts.clear(),
        localDb.syncQueue.clear(),
        localDb.metadata.clear(),
      ]);
    }
  );
  // `contents`/`officialQuestions` (dados públicos/oficiais) são mantidos de propósito —
  // não há necessidade de baixá-los de novo para o próximo usuário no mesmo aparelho.
}
