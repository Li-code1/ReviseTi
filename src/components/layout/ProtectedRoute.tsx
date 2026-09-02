import { Navigate, Outlet } from "react-router-dom";
import { useAuth } from "@/hooks/useAuth";
import { LoadingState } from "@/components/ui/StateMessage";

export function ProtectedRoute() {
  const { user, loading } = useAuth();

  if (loading) return <LoadingState label="Verificando sua sessão..." />;
  if (!user) return <Navigate to="/login" replace />;
  return <Outlet />;
}

export function PublicOnlyRoute() {
  const { user, loading } = useAuth();

  if (loading) return <LoadingState label="Carregando..." />;
  if (user) return <Navigate to="/dashboard" replace />;
  return <Outlet />;
}
