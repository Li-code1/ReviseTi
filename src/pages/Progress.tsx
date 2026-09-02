import { useMemo, useState } from "react";
import { CheckCircle2, Clock, HelpCircle, TrendingUp, XCircle, Percent, AlertCircle, Zap, RefreshCw } from "lucide-react";
import { useProgress } from "@/hooks/useProgress";
import { useStudySessions } from "@/hooks/useStudySessions";
import { useReviews } from "@/hooks/useReviews";
import { useQuestions } from "@/hooks/useQuestions";
import { useOfficialAttempts } from "@/hooks/useOfficialAttempts";
import { useDashboard } from "@/hooks/useDashboard";
import { ErrorState } from "@/components/ui/StateMessage";
import { PageSkeleton } from "@/components/ui/Skeleton";
import { WeeklyProgress } from "@/components/dashboard/WeeklyProgress";
import { StudyHoursChart } from "@/components/charts/StudyHoursChart";
import { ProgressChart } from "@/components/charts/ProgressChart";
import { ReviewStatusChart } from "@/components/charts/ReviewStatusChart";
import { QuestionPerformanceChart } from "@/components/charts/QuestionPerformanceChart";
import { getReviewStatus } from "@/utils/reviews";
import { getQuestionStats, combineQuestionStats, needsReview } from "@/utils/questions";
import { formatMinutes, dateToISODate } from "@/utils/time";
import { minutesByDay } from "@/services/studySessionService";

type PeriodKey = "7d" | "30d" | "month" | "3m" | "all";

const PERIODS: { key: PeriodKey; label: string; days: number | null }[] = [
  { key: "7d", label: "Últimos 7 dias", days: 7 },
  { key: "30d", label: "Últimos 30 dias", days: 30 },
  { key: "month", label: "Este mês", days: new Date().getDate() },
  { key: "3m", label: "Últimos 3 meses", days: 90 },
  { key: "all", label: "Tudo", days: null },
];

export default function ProgressPage() {
  const progress = useProgress();
  const sessions = useStudySessions();
  const reviews = useReviews();
  const questions = useQuestions();
  const officialAttempts = useOfficialAttempts();
  const dashboard = useDashboard();

  const [period, setPeriod] = useState<PeriodKey>("7d");

  const loading = progress.loading || sessions.loading || reviews.loading || questions.loading || officialAttempts.loading || dashboard.loading;
  const error = progress.error || sessions.error || reviews.error || questions.error || officialAttempts.error || dashboard.error;

  const selectedPeriod = PERIODS.find((p) => p.key === period)!;

  const periodHoursByDay = useMemo(() => {
    if (selectedPeriod.days === null) {
      if (sessions.sessions.length === 0) return [];
      const earliest = sessions.sessions.reduce((min, s) => (s.study_date < min ? s.study_date : min), dateToISODate(new Date()));
      const days = Math.max(1, Math.ceil((Date.now() - new Date(earliest).getTime()) / 86400000) + 1);
      return minutesByDay(sessions.sessions, Math.min(days, 365));
    }
    return minutesByDay(sessions.sessions, selectedPeriod.days);
  }, [sessions.sessions, selectedPeriod]);

  const periodEvolution = useMemo(() => {
    if (selectedPeriod.days === null) return dashboard.evolution;
    const cutoff = dateToISODate(new Date(Date.now() - selectedPeriod.days * 86400000));
    return dashboard.evolution.filter((p) => p.date >= cutoff);
  }, [dashboard.evolution, selectedPeriod]);

  const periodMinutes = periodHoursByDay.reduce((sum, d) => sum + d.minutes, 0);

  if (loading) return <PageSkeleton />;
  if (error) return <ErrorState title="Algo deu errado" description={error} />;

  const pendingReviews = reviews.reviews.filter((r) => getReviewStatus(r) === "pending").length;
  const completedReviews = reviews.reviews.filter((r) => getReviewStatus(r) === "completed").length;
  const overdueReviews = reviews.reviews.filter((r) => getReviewStatus(r) === "overdue").length;

  const personalStats = getQuestionStats(questions.questions);
  const qStats = combineQuestionStats(personalStats, officialAttempts);
  const hardQuestions = questions.questions.filter((q) => q.difficulty === "hard").length;
  const questionsToReview = questions.questions.filter(needsReview).length;

  const summaryCards = [
    { label: "Conteúdos", value: `${progress.completedCount}/${progress.totalCount}`, icon: TrendingUp },
    { label: "Revisões", value: `${completedReviews}/${reviews.reviews.length}`, icon: CheckCircle2 },
    { label: "Perguntas respondidas", value: qStats.total, icon: HelpCircle },
    { label: "Horas (total)", value: formatMinutes(sessions.hours.totalMinutes), icon: Clock },
    { label: "Taxa de acerto", value: qStats.accuracyRate === null ? "Sem dados" : `${qStats.accuracyRate}%`, icon: Percent },
  ];

  const questionStats = [
    { label: "Perguntas respondidas", value: qStats.correct + qStats.wrong, icon: HelpCircle },
    { label: "Acertos", value: qStats.correct, icon: CheckCircle2 },
    { label: "Erros", value: qStats.wrong, icon: XCircle },
    { label: "Perguntas difíceis", value: hardQuestions, icon: Zap },
    { label: "Precisam de revisão", value: questionsToReview, icon: AlertCircle },
  ];

  return (
    <div className="space-y-8">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Progresso</h1>
          <p className="mt-1 text-slate-500 dark:text-slate-400">Acompanhe sua evolução ao longo do cronograma.</p>
        </div>
        <div className="flex items-center gap-2 overflow-x-auto pb-1">
          {PERIODS.map((p) => (
            <button
              key={p.key}
              onClick={() => setPeriod(p.key)}
              className={`flex-shrink-0 rounded-full px-3.5 py-1.5 text-sm font-medium transition ${
                period === p.key
                  ? "bg-brand-600 text-white"
                  : "bg-slate-100 text-slate-600 hover:bg-slate-200 dark:bg-slate-800 dark:text-slate-300 dark:hover:bg-slate-700"
              }`}
            >
              {p.label}
            </button>
          ))}
        </div>
      </div>

      <div>
        <h2 className="mb-3 text-lg font-semibold">Resumo</h2>
        <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-5">
          {summaryCards.map(({ label, value, icon: Icon }) => (
            <div key={label} className="card">
              <div className="mb-3 flex h-9 w-9 items-center justify-center rounded-lg bg-brand-50 text-brand-600 dark:bg-brand-900/30 dark:text-brand-300">
                <Icon className="h-4.5 w-4.5" />
              </div>
              <p className="text-xl font-bold">{value}</p>
              <p className="text-sm text-slate-500 dark:text-slate-400">{label}</p>
            </div>
          ))}
        </div>
      </div>

      <div className="grid gap-6 lg:grid-cols-2">
        <section className="card">
          <h2 className="mb-4 text-lg font-semibold">Progresso por semana</h2>
          <WeeklyProgress weeks={progress.byWeek} />
        </section>

        <section className="space-y-4">
          <div className="card">
            <div className="mb-2 flex items-center gap-2">
              <RefreshCw className="h-4 w-4 text-brand-600" />
              <h2 className="text-lg font-semibold">Horas estudadas — {selectedPeriod.label.toLowerCase()}</h2>
            </div>
            <p className="text-2xl font-bold">{formatMinutes(periodMinutes)}</p>
          </div>
          <StudyHoursChart data={periodHoursByDay} />
        </section>
      </div>

      <div className="grid gap-6 lg:grid-cols-2">
        <ProgressChart data={periodEvolution} />
        <ReviewStatusChart pending={pendingReviews} completed={completedReviews} overdue={overdueReviews} />
      </div>

      <div className="grid gap-6 lg:grid-cols-2">
        <QuestionPerformanceChart correct={qStats.correct} wrong={qStats.wrong} />
        <section className="card">
          <h2 className="mb-4 text-lg font-semibold">Perguntas — detalhes</h2>
          <div className="grid grid-cols-2 gap-4">
            {questionStats.map(({ label, value, icon: Icon }) => (
              <div key={label} className="flex items-center gap-3">
                <div className="flex h-9 w-9 flex-shrink-0 items-center justify-center rounded-lg bg-brand-50 text-brand-600 dark:bg-brand-900/30 dark:text-brand-300">
                  <Icon className="h-4.5 w-4.5" />
                </div>
                <div>
                  <p className="text-lg font-bold leading-tight">{value}</p>
                  <p className="text-xs text-slate-500 dark:text-slate-400">{label}</p>
                </div>
              </div>
            ))}
          </div>
        </section>
      </div>
    </div>
  );
}
