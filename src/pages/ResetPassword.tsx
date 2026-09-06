import { useState, FormEvent } from "react";
import { useNavigate } from "react-router-dom";
import { AuthShell } from "@/components/layout/AuthShell";
import { useAuth } from "@/hooks/useAuth";
import { useToast } from "@/components/ui/Toast";
import { Loader2 } from "lucide-react";

export default function ResetPassword() {
  const { updatePassword } = useAuth();
  const { showToast } = useToast();
  const navigate = useNavigate();
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    if (password.length < 6) {
      setError("A senha precisa ter pelo menos 6 caracteres.");
      return;
    }
    if (password !== confirmPassword) {
      setError("As senhas não coincidem.");
      return;
    }
    setError(null);
    setSubmitting(true);
    const { error } = await updatePassword(password);
    setSubmitting(false);
    if (error) {
      setError(error);
      return;
    }
    showToast("Senha atualizada com sucesso.");
    navigate("/dashboard");
  }

  return (
    <AuthShell title="Definir nova senha" subtitle="Acesse pelo link enviado ao seu email e defina uma nova senha.">
      <form onSubmit={handleSubmit} noValidate className="space-y-4">
        <div>
          <label htmlFor="password" className="label-field">Nova senha</label>
          <input
            id="password"
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            className="input-field"
          />
        </div>
        <div>
          <label htmlFor="confirmPassword" className="label-field">Confirmar nova senha</label>
          <input
            id="confirmPassword"
            type="password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            className="input-field"
          />
        </div>
        {error && <p role="alert" className="text-sm text-red-600 dark:text-red-400">{error}</p>}
        <button type="submit" disabled={submitting} className="btn-primary w-full">
          {submitting && <Loader2 className="h-4 w-4 animate-spin" />}
          Salvar nova senha
        </button>
      </form>
    </AuthShell>
  );
}
