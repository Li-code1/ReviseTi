import { useEffect, useRef, useState } from "react";
import { WifiOff } from "lucide-react";
import { useOnlineStatus } from "@/hooks/useOnlineStatus";
import { useToast } from "@/components/ui/Toast";

/** Faixa fixa "Você está offline" + toast discreto quando a conexão volta. */
export function ConnectionBanner() {
  const { isOnline } = useOnlineStatus();
  const { showToast } = useToast();
  const wasOffline = useRef(false);
  const [mounted, setMounted] = useState(false);

  useEffect(() => setMounted(true), []);

  useEffect(() => {
    if (!mounted) return;
    if (!isOnline) {
      wasOffline.current = true;
    } else if (wasOffline.current) {
      wasOffline.current = false;
      showToast("Conexão restaurada.");
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isOnline, mounted]);

  if (!isOnline) {
    return (
      <div className="flex items-center justify-center gap-2 bg-yellow-500 px-4 py-1.5 text-xs font-medium text-yellow-950">
        <WifiOff className="h-3.5 w-3.5" /> Você está offline — modo offline ativo
      </div>
    );
  }
  return null;
}
