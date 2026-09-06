import { useState } from "react";
import { Link } from "react-router-dom";
import { Clock, CheckCircle2, TrendingUp, HelpCircle, Percent, Plus, ArrowRight } from "lucide-react";
import { useDashboard } from "@/hooks/useDashboard";
import { useProgress } from "@/hooks/useProgress";
import { useStudySessions } from "@/hooks/useStudySessions";
import { useStudyGoal } from "@/hooks/useStudyGoal";
import { useReviews } from "@/hooks/useReviews";
import { useQuestions } from "@/hooks/useQuestions";
import { useOfficialAttempts } from "@/hooks/useOfficialAttempts";
import { getReviewStatus, formatReviewDate, DIFFICULTY_LABELS, DIFFICULTY_COLORS, STATUS_LABELS, STATUS_COLORS } from "@/utils/reviews";
import { getQuestionStats, combineQuestionStats } from "@/utils/questions";
import { formatMinutes } from "@/utils/time";
import { ErrorState } from "@/components/ui/StateMessage";
import { PageSkeleton } from "@/components/ui/Skeleton";
import { Modal } from "@/components/ui/Modal";
import { StudySessionForm, type StudySessionFormValues } from "@/components/dashboard/StudySessionForm";
import { WeeklyGoal } from "@/components/dashboard/WeeklyGoal";
import { WeeklyProgress } from "@/components/dashboard/WeeklyProgress";
import { RecentActivity } from "@/components/dashboard/RecentActivity";
import { StudyHoursChart } from "@/components/charts/StudyHoursChart";
import { ProgressChart } from "@/components/charts/ProgressChart";
import { ReviewStatusChart } from "@/components/charts/ReviewStatusChart";
import { QuestionPerformanceChart } from "@/components/charts/QuestionPerformanceChart";
import { useToast } from "@/components/ui/Toast";
import { actionToastMessage } from "@/utils/offlineToast";
import { useOnlineStatus } from "@/hooks/useOnlineStatus";

export default function Dashboard() {
  const { showToast } = useToast();
  const { isOnline } = useOnlineStatus();
  const dashboard = useDashboard();
  const progress = useProgress();
  const sessions = useStudySessions();
  const goal = useStudyGoal();
  const reviews = useReviews();
  const questions = useQuestions();
  const officialAttempts = useOfficialAttempts();

  const [showSessionForm, setShowSessionForm] = useState(false);

  const loading = dashboard.loading || progress.loading || sessions.loading || reviews.loading || questions.loading || officialAttempts.loading;
  const error = progress.error || sessions.error || reviews.error || questions.error || officialAttempts.error;

  if (loading) return <PageSkeleton />;
  if (error) return <ErrorState title="Algo deu errado" description={error} />;

  const pendingReviews = reviews.reviews.filter((r) => getReviewStatus(r) === "pending").length;
  const completedReviews = reviews.reviews.filter((r) => getReviewStatus(r) === "completed").length;
  const overdueReviews = reviews.reviews.filter((r) => getReviewStatus(r) === "overdue").length;

  const personalStats = getQuestionStats(questions.questions);
  const qStats = combineQuestionStats(personalStats, officialAttempts);
  const questionsAnswered = qStats.correct + qStats.wrong;

  async function handleCreateSession(values: StudySessionFormValues) {
    const { error } = await sessions.create(values);
    if (!error) {
      showToast(actionToastMessage("Sessão de estudo registrada.", isOnline));
      setShowSessionForm(false);
    }
    return { error };
  }

  const upcomingReviews = [...reviews.reviews]
    .filter((r) => getReviewStatus(r) !== "completed")
    .sort((a, b) => {
      const statusOrder = { overdue: 0, pending: 1, completed: 2 } as const;
      const aStatus = getReviewStatus(a);
      const bStatus = getReviewStatus(b);
      if (aStatus !== bStatus) return statusOrder[aStatus] - statusOrder[bStatus];
      return a.review_date.localeCompare(b.review_date);
    })
    .slice(0, 5);

  const continueStudying = progress.contents.filter((c) => !progress.progressMap[c.id]).slice(0, 3);

  const mainCards = [
    { label: "Progresso geral", value: `${progress.overallPercent}%`, sub: `${progress.completedCount} de ${progress.totalCount} conteúdos concluídos`, icon: TrendingUp },
    { label: "Horas estudadas", value: formatMinutes(sessions.hours.totalMinutes), sub: `${formatMinutes(sessions.hours.weekMinutes)} esta semana`, icon: Clock },
    { label: "Conteúdos concluídos", value: `${progress.completedCount}/${progress.totalCount}`, sub: null, icon: CheckCircle2 },
    { label: "Revisões concluídas", value: completedReviews, sub: `${pendingReviews} pendentes · ${overdueReviews} atrasadas`, icon: CheckCircle2 },
    { label: "Perguntas respondidas", value: questionsAnswered, sub: "banco oficial + pessoais", icon: HelpCircle },
    { label: "Taxa de acerto", value: qStats.accuracyRate === null ? "Sem dados" : `${qStats.accuracyRate}%`, sub: null, icon: Percent },
  ];

  return (
    <div className="space-y-8">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Olá{dashboard.firstName ? `, ${dashboard.firstName}` : ""}! 👋</h1>
          <p className="mt-1 text-slate-500 dark:text-slate-400">Continue sua evolução nos estudos.</p>
        </div>
        <button onClick={() => setShowSessionForm(true)} className="btn-primary">
          <Plus className="h-4 w-4" /> Registrar estudo
        </button>
      </div>

      {/* Linha 1 (desktop) — 6 cards principais, sempre com dados reais */}
      <div className="grid grid-cols-2 gap-4 lg:grid-cols-3 xl:grid-cols-6">
        {mainCards.map(({ label, value, sub, icon: Icon }) => (
          <div key={label} className="card">
            <div className="mb-3 flex h-9 w-9 items-center justify-center rounded-lg bg-brand-50 text-brand-600 dark:bg-brand-900/30 dark:text-brand-300">
              <Icon className="h-4.5 w-4.5" />
            </div>
            <p className="text-xl font-bold">{value}</p>
            <p className="text-sm text-slate-500 dark:text-slate-400">{label}</p>
            {sub && <p className="mt-1 text-xs text-slate-400">{sub}</p>}
          </div>
        ))}
      </div>

      {/* Linha 2 — progresso por semana + meta semanal */}
      <div className="grid gap-6 lg:grid-cols-2">
        <section className="card">
          <h2 className="mb-4 text-lg font-semibold">Progresso por semana</h2>
          <WeeklyProgress weeks={progress.byWeek} />
        </section>
        <WeeklyGoal weeklyMinutes={goal.weeklyMinutes} achievedMinutes={sessions.hours.weekMinutes} onUpdateGoal={goal.updateGoal} />
      </div>

      {/* Linha 3 — horas por dia + desempenho */}
      <div className="grid gap-6 lg:grid-cols-2">
        <StudyHoursChart data={sessions.hoursByDay} />
        <ProgressChart data={dashboard.evolution} />
      </div>
      <div className="grid gap-6 lg:grid-cols-2">
        <ReviewStatusChart pending={pendingReviews} completed={completedReviews} overdue={overdueReviews} />
        <QuestionPerformanceChart correct={qStats.correct} wrong={qStats.wrong} />
      </div>

      {/* Linha 4 — próximas revisões + continue estudando */}
      <div className="grid gap-6 lg:grid-cols-2">
        <section>
          <div className="mb-3 flex items-center justify-between">
            <h2 className="text-lg font-semibold">Próximas revisões</h2>
            <Link to="/reviews" className="flex items-center gap-1 text-sm text-brand-600 hover:underline dark:text-brand-400">
              Ver revisões <ArrowRight className="h-3.5 w-3.5" />
            </Link>
          </div>
          {upcomingReviews.length === 0 ? (
            <div className="card text-sm text-slate-500 dark:text-slate-400">Você ainda não possui revisões pendentes.</div>
          ) : (
            <div className="space-y-3">
              {upcomingReviews.map((r) => {
                const status = getReviewStatus(r);
                return (
                  <div key={r.id} className="card flex items-center justify-between gap-3">
                    <div>
                      <p className="font-semibold">{r.title}</p>
                      <p className="text-sm text-slate-500 dark:text-slate-400">{formatReviewDate(r.review_date)}</p>
                    </div>
                    <div className="flex flex-shrink-0 flex-col items-end gap-1">
                      <span className={`rounded-full px-2 py-0.5 text-xs font-medium ${DIFFICULTY_COLORS[r.difficulty]}`}>
                        {DIFFICULTY_LABELS[r.difficulty]}
                      </span>
                      <span className={`rounded-full px-2 py-0.5 text-xs font-medium ${STATUS_COLORS[status]}`}>
                        {STATUS_LABELS[status]}
                      </span>
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </section>

        <section>
          <div className="mb-3 flex items-center justify-between">
            <h2 className="text-lg font-semibold">Continue estudando</h2>
            <Link to="/contents" className="flex items-center gap-1 text-sm text-brand-600 hover:underline dark:text-brand-400">
              Ver tudo <ArrowRight className="h-3.5 w-3.5" />
            </Link>
          </div>
          {continueStudying.length === 0 ? (
            <div className="card text-sm text-slate-500 dark:text-slate-400">
              {progress.totalCount === 0 ? "Nenhum conteúdo disponível ainda." : "Você concluiu todos os conteúdos disponíveis! 🎉"}
            </div>
          ) : (
            <div className="space-y-3">
              {continueStudying.map((c) => (
                <Link key={c.id} to={`/contents/${c.slug}`} className="card block transition hover:border-brand-300">
                  <p className="text-xs font-medium uppercase tracking-wide text-brand-600 dark:text-brand-400">
                    Semana {c.week_number}
                  </p>
                  <p className="mt-1 font-semibold">{c.title}</p>
                  <p className="mt-1 text-sm text-slate-500 dark:text-slate-400">{c.estimated_minutes} min</p>
                </Link>
              ))}
            </div>
          )}
        </section>
      </div>

      {/* Atividade recente */}
      <section className="card">
        <h2 className="mb-4 text-lg font-semibold">Atividade recente</h2>
        {dashboard.error ? (
          <div className="flex flex-col items-center gap-2 py-4 text-center">
            <p className="text-sm text-red-600 dark:text-red-400">{dashboard.error}</p>
            <button onClick={dashboard.reload} className="text-sm font-medium text-brand-600 hover:underline dark:text-brand-400">
              Tentar novamente
            </button>
          </div>
        ) : (
          <RecentActivity items={dashboard.activity} />
        )}
      </section>

      {showSessionForm && (
        <Modal title="Registrar estudo" onClose={() => setShowSessionForm(false)}>
          <StudySessionForm onSubmit={handleCreateSession} onCancel={() => setShowSessionForm(false)} />
        </Modal>
      )}
    </div>
  );
}
