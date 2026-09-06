import { useEffect, useState, useCallback } from "react";
import { supabase } from "@/lib/supabase";

/**
 * navigator.onLine só diz se o dispositivo tem alguma rede — não garante que
 * o Supabase está alcançável (ex: wifi conectado mas sem internet de fato,
 * ou Supabase fora do ar). Por isso, além dos eventos padrão, validamos a
 * conexão de verdade com uma consulta leve quando necessário.
 */
export function useOnlineStatus() {
  const [isOnline, setIsOnline] = useState(navigator.onLine);
  const [checking, setChecking] = useState(false);

  const verifyConnection = useCallback(async (): Promise<boolean> => {
    if (!navigator.onLine) {
      setIsOnline(false);
      return false;
    }
    setChecking(true);
    try {
      const controller = new AbortController();
      const timeout = setTimeout(() => controller.abort(), 4000);
      // Consulta mínima só para confirmar que o Supabase responde.
      const { error } = await supabase.from("study_contents").select("id").limit(1).abortSignal(controller.signal);
      clearTimeout(timeout);
      const online = !error;
      setIsOnline(online);
      return online;
    } catch {
      setIsOnline(false);
      return false;
    } finally {
      setChecking(false);
    }
  }, []);

  useEffect(() => {
    function handleOnline() {
      verifyConnection();
    }
    function handleOffline() {
      setIsOnline(false);
    }
    window.addEventListener("online", handleOnline);
    window.addEventListener("offline", handleOffline);
    return () => {
      window.removeEventListener("online", handleOnline);
      window.removeEventListener("offline", handleOffline);
    };
  }, [verifyConnection]);

  return { isOnline, checking, verifyConnection };
}
