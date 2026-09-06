import { useMemo, useState } from "react";
import { Plus, Search, CalendarDays, List, Sun, ListTodo, CheckCircle2, AlertTriangle } from "lucide-react";
import { useReviews } from "@/hooks/useReviews";
import { Modal } from "@/components/ui/Modal";
import { ConfirmDialog } from "@/components/ui/ConfirmDialog";
import { ReviewForm, type ReviewFormValues } from "@/components/reviews/ReviewForm";
import { ReviewCard } from "@/components/reviews/ReviewCard";
import { ReviewCalendar } from "@/components/reviews/ReviewCalendar";
import { EmptyState, ErrorState } from "@/components/ui/StateMessage";
import { PageSkeleton } from "@/components/ui/Skeleton";
import { useToast } from "@/components/ui/Toast";
import { getReviewStatus, isToday, isFuture, formatReviewDate } from "@/utils/reviews";
import { actionToastMessage } from "@/utils/offlineToast";
import { useOnlineStatus } from "@/hooks/useOnlineStatus";
import type { ReviewWithContent } from "@/types/database";

type FilterKey = "all" | "today" | "pending" | "completed" | "overdue" | "future";

const FILTERS: { key: FilterKey; label: string }[] = [
  { key: "all", label: "Todas" },
  { key: "today", label: "Hoje" },
  { key: "pending", label: "Pendentes" },
  { key: "completed", label: "Concluídas" },
  { key: "overdue", label: "Atrasadas" },
  { key: "future", label: "Futuras" },
];

export default function Reviews() {
  const { reviews, loading, error, create, update, remove, complete, uncomplete } = useReviews();
  const { isOnline } = useOnlineStatus();
  const { showToast } = useToast();

  const [showForm, setShowForm] = useState(false);
  const [editingReview, setEditingReview] = useState<ReviewWithContent | null>(null);
  const [deletingReview, setDeletingReview] = useState<ReviewWithContent | null>(null);
  const [filter, setFilter] = useState<FilterKey>("all");
  const [search, setSearch] = useState("");
  const [view, setView] = useState<"list" | "calendar">("list");
  const [selectedDate, setSelectedDate] = useState<string | null>(null);

  const summary = useMemo(() => {
    let today = 0, pending = 0, completed = 0, overdue = 0;
    for (const r of reviews) {
      const status = getReviewStatus(r);
      if (isToday(r.review_date)) today++;
      if (status === "pending") pending++;
      if (status === "completed") completed++;
      if (status === "overdue") overdue++;
    }
    return { today, pending, completed, overdue };
  }, [reviews]);

  const filtered = useMemo(() => {
    let list = reviews;
    if (filter !== "all") {
      list = list.filter((r) => {
        const status = getReviewStatus(r);
        if (filter === "today") return isToday(r.review_date);
        if (filter === "future") return status === "pending" && isFuture(r.review_date);
        return status === filter;
      });
    }
    if (search.trim()) {
      const term = search.trim().toLowerCase();
      list = list.filter(
        (r) => r.title.toLowerCase().includes(term) || (r.notes ?? "").toLowerCase().includes(term)
      );
    }
    return list;
  }, [reviews, filter, search]);

  async function handleCreate(values: ReviewFormValues) {
    const { error } = await create({ ...values, completed: false });
    if (!error) {
      showToast(actionToastMessage("Revisão criada com sucesso.", isOnline));
      setShowForm(false);
    }
    return { error };
  }

  async function handleUpdate(values: ReviewFormValues) {
    if (!editingReview) return { error: "Revisão inválida." };
    const { error } = await update(editingReview.id, values);
    if (!error) {
      showToast(actionToastMessage("Revisão atualizada.", isOnline));
      setEditingReview(null);
    }
    return { error };
  }

  async function handleComplete(id: string) {
    const { error } = await complete(id);
    if (error) showToast(error, "error");
    else showToast(actionToastMessage("Revisão concluída!", isOnline));
  }

  async function handleUncomplete(id: string) {
    const { error } = await uncomplete(id);
    if (error) showToast(error, "error");
  }

  async function handleDelete() {
    if (!deletingReview) return;
    const { error } = await remove(deletingReview.id);
    setDeletingReview(null);
    if (error) showToast(error, "error");
    else showToast(actionToastMessage("Revisão excluída.", isOnline));
  }

  if (loading) return <PageSkeleton />;
  if (error) return <ErrorState title="Não foi possível carregar suas revisões" description={error} />;

  const summaryCards = [
    { label: "Hoje", value: summary.today, icon: Sun },
    { label: "Pendentes", value: summary.pending, icon: ListTodo },
    { label: "Concluídas", value: summary.completed, icon: CheckCircle2 },
    { label: "Atrasadas", value: summary.overdue, icon: AlertTriangle },
  ];

  return (
    <div className="space-y-6">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Minhas revisões</h1>
          <p className="mt-1 text-slate-500 dark:text-slate-400">Organize suas revisões e acompanhe sua evolução.</p>
        </div>
        <button onClick={() => setShowForm(true)} className="btn-primary">
          <Plus className="h-4 w-4" /> Nova revisão
        </button>
      </div>

      <div className="grid grid-cols-2 gap-4 lg:grid-cols-4">
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

      <div className="flex flex-col gap-3">
        <div className="relative">
          <Search className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400" />
          <input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Buscar revisão..."
            className="input-field pl-9"
            aria-label="Buscar revisão"
          />
        </div>

        <div className="flex items-center gap-2 overflow-x-auto pb-1">
          {view === "list" &&
            FILTERS.map(({ key, label }) => (
              <button
                key={key}
                onClick={() => setFilter(key)}
                className={`flex-shrink-0 rounded-full px-3.5 py-1.5 text-sm font-medium transition ${
                  filter === key
                    ? "bg-brand-600 text-white"
                    : "bg-slate-100 text-slate-600 hover:bg-slate-200 dark:bg-slate-800 dark:text-slate-300 dark:hover:bg-slate-700"
                }`}
              >
                {label}
              </button>
            ))}
          <div className="ml-auto flex flex-shrink-0 items-center gap-1 rounded-full bg-slate-100 p-1 dark:bg-slate-800">
            <button
              onClick={() => setView("list")}
              aria-pressed={view === "list"}
              className={`flex items-center gap-1.5 rounded-full px-3 py-1 text-sm font-medium transition ${
                view === "list" ? "bg-white text-slate-700 shadow-sm dark:bg-slate-700 dark:text-slate-100" : "text-slate-500 dark:text-slate-400"
              }`}
            >
              <List className="h-3.5 w-3.5" /> Lista
            </button>
            <button
              onClick={() => setView("calendar")}
              aria-pressed={view === "calendar"}
              className={`flex items-center gap-1.5 rounded-full px-3 py-1 text-sm font-medium transition ${
                view === "calendar" ? "bg-white text-slate-700 shadow-sm dark:bg-slate-700 dark:text-slate-100" : "text-slate-500 dark:text-slate-400"
              }`}
            >
              <CalendarDays className="h-3.5 w-3.5" /> Calendário
            </button>
          </div>
        </div>
      </div>

      {view === "calendar" ? (
        <div className="space-y-4">
          <ReviewCalendar reviews={reviews} selectedDate={selectedDate} onSelectDate={setSelectedDate} />

          {reviews.length === 0 ? (
            <div className="flex flex-col items-center justify-center gap-2 rounded-2xl border border-dashed border-slate-200 py-12 text-center dark:border-slate-800">
              <p className="font-medium text-slate-700 dark:text-slate-200">Você ainda não possui revisões agendadas.</p>
              <p className="max-w-xs text-sm text-slate-500 dark:text-slate-400">Quando você cadastrar uma revisão, ela aparecerá aqui.</p>
            </div>
          ) : selectedDate ? (
            <div>
              <h3 className="mb-3 text-sm font-semibold text-slate-600 dark:text-slate-300">
                Revisões de {formatReviewDate(selectedDate)}
              </h3>
              {reviews.filter((r) => r.review_date === selectedDate).length === 0 ? (
                <p className="text-sm text-slate-400">Nenhuma revisão nesta data.</p>
              ) : (
                <div className="space-y-3">
                  {reviews
                    .filter((r) => r.review_date === selectedDate)
                    .map((r) => (
                      <ReviewCard
                        key={r.id}
                        review={r}
                        onComplete={() => handleComplete(r.id)}
                        onUncomplete={() => handleUncomplete(r.id)}
                        onEdit={() => setEditingReview(r)}
                        onDelete={() => setDeletingReview(r)}
                      />
                    ))}
                </div>
              )}
            </div>
          ) : (
            <p className="text-center text-sm text-slate-400">Selecione um dia no calendário para ver as revisões.</p>
          )}
        </div>
      ) : filtered.length === 0 ? (
        reviews.length === 0 ? (
          <div className="flex flex-col items-center justify-center gap-3 rounded-2xl border border-dashed border-slate-200 py-16 text-center dark:border-slate-800">
            <p className="font-medium text-slate-700 dark:text-slate-200">Você ainda não possui revisões.</p>
            <p className="max-w-xs text-sm text-slate-500 dark:text-slate-400">
              Crie sua primeira revisão para começar a acompanhar seu progresso.
            </p>
            <button onClick={() => setShowForm(true)} className="btn-primary mt-2">
              <Plus className="h-4 w-4" /> Criar primeira revisão
            </button>
          </div>
        ) : (
          <EmptyState title="Nenhuma revisão encontrada." description="Tente outro filtro ou termo de busca." />
        )
      ) : (
        <div className="space-y-3">
          {filtered.map((r) => (
            <ReviewCard
              key={r.id}
              review={r}
              onComplete={() => handleComplete(r.id)}
              onUncomplete={() => handleUncomplete(r.id)}
              onEdit={() => setEditingReview(r)}
              onDelete={() => setDeletingReview(r)}
            />
          ))}
        </div>
      )}

      {showForm && (
        <Modal title="Nova revisão" onClose={() => setShowForm(false)}>
          <ReviewForm onSubmit={handleCreate} onCancel={() => setShowForm(false)} />
        </Modal>
      )}

      {editingReview && (
        <Modal title="Editar revisão" onClose={() => setEditingReview(null)}>
          <ReviewForm initial={editingReview} onSubmit={handleUpdate} onCancel={() => setEditingReview(null)} />
        </Modal>
      )}

      {deletingReview && (
        <ConfirmDialog
          title="Excluir revisão?"
          description="Essa ação não poderá ser desfeita."
          confirmLabel="Excluir"
          destructive
          onConfirm={handleDelete}
          onCancel={() => setDeletingReview(null)}
        />
      )}
    </div>
  );
}
