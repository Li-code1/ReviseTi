import { useCallback, useEffect, useState } from "react";
import { useAuth } from "@/hooks/useAuth";
import { getProfile } from "@/services/profileService";
import { getRecentActivity, getEvolutionData, type ActivityItem, type EvolutionPoint } from "@/services/dashboardService";

/**
 * Dados que não têm um hook próprio (nome do usuário, atividade recente,
 * evolução). O Dashboard combina isso com useProgress/useStudySessions/
 * useStudyGoal/useReviews/useQuestions, cada um cuidando da sua parte —
 * evita concentrar toda a lógica de consulta em um hook gigante.
 */
export function useDashboard() {
  const { user } = useAuth();
  const [firstName, setFirstName] = useState("");
  const [activity, setActivity] = useState<ActivityItem[]>([]);
  const [evolution, setEvolution] = useState<EvolutionPoint[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const load = useCallback(async () => {
    if (!user) return;
    setLoading(true);

    const fetchOnce = () =>
      Promise.all([getProfile(user.id), getRecentActivity(user.id), getEvolutionData(user.id)]);

    let [profile, activityRes, evolutionRes] = await fetchOnce();

    // Uma falha logo na abertura do app costuma ser a conexão ainda "acordando"
    // (comum em dados móveis). Tenta mais uma vez antes de mostrar erro ao usuário.
    if (activityRes.error || evolutionRes.error) {
      await new Promise((resolve) => setTimeout(resolve, 1500));
      [profile, activityRes, evolutionRes] = await fetchOnce();
    }

    setFirstName(profile?.full_name?.split(" ")[0] ?? "");
    setActivity(activityRes.data);
    setEvolution(evolutionRes.data);
    setError(activityRes.error || evolutionRes.error ? activityRes.error ?? evolutionRes.error : null);
    setLoading(false);
  }, [user]);

  useEffect(() => {
    load();
  }, [load]);

  return { firstName, activity, evolution, loading, error, reload: load };
}
