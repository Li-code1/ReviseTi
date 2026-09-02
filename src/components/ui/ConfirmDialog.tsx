import { Modal } from "./Modal";

interface Props {
  title: string;
  description: string;
  confirmLabel?: string;
  cancelLabel?: string;
  destructive?: boolean;
  onConfirm: () => void;
  onCancel: () => void;
}

export function ConfirmDialog({
  title,
  description,
  confirmLabel = "Confirmar",
  cancelLabel = "Cancelar",
  destructive = false,
  onConfirm,
  onCancel,
}: Props) {
  return (
    <Modal title={title} onClose={onCancel}>
      <p className="text-sm text-slate-600 dark:text-slate-300">{description}</p>
      <div className="mt-6 flex justify-end gap-3">
        <button onClick={onCancel} className="btn-secondary">
          {cancelLabel}
        </button>
        <button
          onClick={onConfirm}
          className={destructive ? "btn-primary bg-red-600 hover:bg-red-700" : "btn-primary"}
        >
          {confirmLabel}
        </button>
      </div>
    </Modal>
  );
}
