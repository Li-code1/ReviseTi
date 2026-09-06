export type Difficulty = "easy" | "medium" | "hard";
export type ReviewStatus = "pending" | "completed" | "overdue";

export interface Profile {
  id: string;
  full_name: string;
  avatar_url: string | null;
  created_at: string;
  updated_at: string;
}

export interface StudyContent {
  id: string;
  week_number: number;
  day_of_week: number;
  day_name: string | null;
  title: string;
  slug: string;
  description: string | null;
  content: string | null;
  estimated_minutes: number;
  order_index: number;
  is_active: boolean;
  topic_count: number;
  metadata: Record<string, unknown>;
  created_at: string;
  updated_at: string;
}

export interface ContentTopic {
  id: string;
  content_id: string;
  title: string;
  description: string | null;
  order_index: number;
  created_at: string;
}

export interface Review {
  id: string;
  user_id: string;
  content_id: string | null;
  title: string;
  notes: string | null;
  review_date: string;
  minutes: number;
  difficulty: Difficulty;
  completed: boolean;
  completed_at: string | null;
  created_at: string;
  updated_at: string;
}

// Resultado de getReviews(), com a aula relacionada já embutida via join
// (evita uma chamada extra ao Supabase por revisão).
export interface ReviewWithContent extends Review {
  content: { id: string; title: string; week_number: number; day_name: string | null } | null;
}

export interface Question {
  id: string;
  user_id: string;
  content_id: string | null;
  question: string;
  answer: string;
  difficulty: Difficulty;
  correct_count: number;
  wrong_count: number;
  last_reviewed_at: string | null;
  created_at: string;
  updated_at: string;
}

// Resultado de getQuestions(), com a aula relacionada já embutida via join
// (evita uma chamada extra ao Supabase por pergunta).
export interface QuestionWithContent extends Question {
  content: { id: string; title: string; slug: string; week_number: number; day_name: string | null } | null;
}

export interface QuestionStats {
  total: number;
  correct: number;
  wrong: number;
  accuracyRate: number | null; // null = "Sem dados" (nenhuma resposta ainda)
}

export interface StudyProgress {
  id: string;
  user_id: string;
  content_id: string;
  completed: boolean;
  completed_at: string | null;
  created_at: string;
  updated_at: string;
}

export interface StudyGoal {
  id: string;
  user_id: string;
  weekly_minutes: number;
  created_at: string;
  updated_at: string;
}

export type OfficialQuestionType = "open" | "multiple_choice" | "true_false" | "code";

export interface OfficialQuestionOption {
  id: string;
  text: string;
}

export interface OfficialQuestion {
  id: string;
  content_id: string | null;
  question_key: string;
  category: string;
  question_type: OfficialQuestionType;
  difficulty: Difficulty;
  question: string;
  options: OfficialQuestionOption[] | null;
  correct_option: string | null;
  answer: string;
  explanation: string;
  is_interview_question: boolean;
  order_index: number;
  created_at: string;
  updated_at: string;
}

export interface QuestionAttempt {
  id: string;
  user_id: string;
  official_question_id: string;
  selected_answer: string | null;
  is_correct: boolean;
  answered_at: string;
  created_at: string;
}

export interface StudySession {
  id: string;
  user_id: string;
  content_id: string | null;
  study_date: string;
  minutes: number;
  notes: string | null;
  created_at: string;
}

// Minimal typed schema shape consumed by the Supabase client generics.
export interface Database {
  public: {
    Tables: {
      profiles: { Row: Profile; Insert: Partial<Profile> & { id: string; full_name: string }; Update: Partial<Profile> };
      study_contents: { Row: StudyContent; Insert: Partial<StudyContent>; Update: Partial<StudyContent> };
      reviews: { Row: Review; Insert: Partial<Review> & { user_id: string; title: string }; Update: Partial<Review> };
      questions: { Row: Question; Insert: Partial<Question> & { user_id: string; question: string; answer: string }; Update: Partial<Question> };
      study_progress: { Row: StudyProgress; Insert: Partial<StudyProgress> & { user_id: string; content_id: string }; Update: Partial<StudyProgress> };
      study_sessions: { Row: StudySession; Insert: Partial<StudySession> & { user_id: string }; Update: Partial<StudySession> };
    };
  };
}
