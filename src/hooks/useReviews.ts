import { useCallback, useEffect, useState } from "react";
import { useAuth } from "@/hooks/useAuth";
import {
  getReviews,
  createReview,
  updateReview,
  deleteReview,
  completeReview,
  uncompleteReview,
} from "@/repositories/reviewRepository";
import type { Review, ReviewWithContent } from "@/types/database";

export function useReviews() {
  const { user } = useAuth();
  const [reviews, setReviews] = useState<ReviewWithContent[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const load = useCallback(async () => {
    if (!user) return;
    setLoading(true);
    const { data, error } = await getReviews(user.id);
    setReviews(data);
    setError(error);
    setLoading(false);
  }, [user]);

  useEffect(() => {
    load();
  }, [load]);

  async function create(review: Partial<Review> & { title: string; review_date: string }) {
    if (!user) return { error: "Você precisa estar autenticado." };
    const { error } = await createReview({ ...review, user_id: user.id });
    if (!error) await load();
    return { error };
  }

  async function update(id: string, updates: Partial<Review>) {
    const { error } = await updateReview(id, updates);
    if (!error) await load();
    return { error };
  }

  async function remove(id: string) {
    const { error } = await deleteReview(id);
    if (!error) await load();
    return { error };
  }

  async function complete(id: string) {
    const { error } = await completeReview(id);
    if (!error) await load();
    return { error };
  }

  async function uncomplete(id: string) {
    const { error } = await uncompleteReview(id);
    if (!error) await load();
    return { error };
  }

  return { reviews, loading, error, reload: load, create, update, remove, complete, uncomplete };
}
