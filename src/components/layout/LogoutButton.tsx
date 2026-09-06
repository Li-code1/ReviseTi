import { useState, ReactNode } from "react";
import { useAuth } from "@/hooks/useAuth";
import { useSync } from "@/hooks/useSync";
import { ConfirmDialog } from "@/components/ui/ConfirmDialog";

interface Props {
  className: string;
  children: ReactNode;
  role?: string;
}

/** Botão de logout único e reutilizável: sempre confirma antes de sair se houver alterações não sincronizadas. */
export function LogoutButton({ className, children, role }: Props) {
  const { logout } = useAuth();
  const { pendingCount } = useSync();
  const [showConfirm, setShowConfirm] = useState(false);

  function handleClick() {
    if (pendingCount > 0) setShowConfirm(true);
    else logout();
  }

  return (
    <>
      <button onClick={handleClick} className={className} role={role}>
        {children}
      </button>
      {showConfirm && (
        <ConfirmDialog
          title="Alterações não sincronizadas"
          description={`Você possui ${pendingCount} alteração${pendingCount === 1 ? "" : "ões"} que ainda não foi${pendingCount === 1 ? "" : "ram"} sincronizada${pendingCount === 1 ? "" : "s"}. Se sair agora, elas podem ser perdidas neste aparelho.`}
          confirmLabel="Continuar e perder alterações locais"
          cancelLabel="Cancelar"
          destructive
          onConfirm={() => { setShowConfirm(false); logout(); }}
          onCancel={() => setShowConfirm(false)}
        />
      )}
    </>
  );
}
