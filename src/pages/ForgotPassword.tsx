import { useState, FormEvent } from "react";
import { Link } from "react-router-dom";
import { AuthShell } from "@/components/layout/AuthShell";
import { useAuth } from "@/hooks/useAuth";
import { Loader2 } from "lucide-react";

export default function ForgotPassword() {
  const { resetPassword } = useAuth();
  const [email, setEmail] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [sent, setSent] = useState(false);
  const [submitting, setSubmitting] = useState(false);

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    setError(null);
    setSubmitting(true);
    const { error } = await resetPassword(email);
    setSubmitting(false);
    if (error) {
      setError(error);
      return;
    }
    setSent(true);
  }

  if (sent) {
    return (
      <AuthShell title="Recuperar senha">
        <p className="text-sm text-slate-600 dark:text-slate-300">
          Se existir uma conta com esse email, enviamos um link de recuperação. Confira sua caixa de entrada.
        </p>
        <Link to="/login" className="mt-4 inline-block text-sm font-medium text-brand-600 hover:underline dark:text-brand-400">
          Voltar para o login
        </Link>
      </AuthShell>
    );
  }

  return (
    <AuthShell title="Recuperar senha" subtitle="Informe seu email para receber o link de recuperação.">
      <form onSubmit={handleSubmit} noValidate className="space-y-4">
        <div>
          <label htmlFor="email" className="label-field">Email</label>
          <input
            id="email"
            type="email"
            required
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="input-field"
          />
        </div>
        {error && <p role="alert" className="text-sm text-red-600 dark:text-red-400">{error}</p>}
        <button type="submit" disabled={submitting} className="btn-primary w-full">
          {submitting && <Loader2 className="h-4 w-4 animate-spin" />}
          Enviar link de recuperação
        </button>
        <Link to="/login" className="block text-center text-sm text-brand-600 hover:underline dark:text-brand-400">
          Voltar para o login
        </Link>
      </form>
    </AuthShell>
  );
}
