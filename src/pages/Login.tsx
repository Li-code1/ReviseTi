import { useState, FormEvent } from "react";
import { Link, useNavigate } from "react-router-dom";
import { AuthShell } from "@/components/layout/AuthShell";
import { useAuth } from "@/hooks/useAuth";
import { useToast } from "@/components/ui/Toast";
import { useOnlineStatus } from "@/hooks/useOnlineStatus";
import { Loader2, WifiOff } from "lucide-react";

export default function Login() {
  const { login } = useAuth();
  const { showToast } = useToast();
  const navigate = useNavigate();
  const { isOnline } = useOnlineStatus();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    setError(null);
    setSubmitting(true);
    const { error } = await login(email, password);
    setSubmitting(false);
    if (error) {
      setError(error);
      return;
    }
    showToast("Login realizado com sucesso.");
    navigate("/dashboard");
  }

  return (
    <AuthShell title="Entrar" subtitle="Acesse sua conta para continuar estudando.">
      {!isOnline && (
        <div className="mb-4 flex items-center gap-2 rounded-xl bg-yellow-50 px-3.5 py-2.5 text-sm text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-300">
          <WifiOff className="h-4 w-4 flex-shrink-0" />
          É necessário conectar-se à internet para entrar pela primeira vez.
        </div>
      )}
      <form onSubmit={handleSubmit} noValidate className="space-y-4">
        <div>
          <label htmlFor="email" className="label-field">Email</label>
          <input
            id="email"
            type="email"
            required
            autoComplete="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="input-field"
            aria-describedby={error ? "login-error" : undefined}
          />
        </div>
        <div>
          <label htmlFor="password" className="label-field">Senha</label>
          <input
            id="password"
            type="password"
            required
            autoComplete="current-password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            className="input-field"
          />
        </div>

        {error && (
          <p id="login-error" role="alert" className="text-sm text-red-600 dark:text-red-400">
            {error}
          </p>
        )}

        <button type="submit" disabled={submitting} className="btn-primary w-full">
          {submitting && <Loader2 className="h-4 w-4 animate-spin" />}
          Entrar
        </button>

        <div className="flex items-center justify-between text-sm">
          <Link to="/forgot-password" className="text-brand-600 hover:underline dark:text-brand-400">
            Esqueci minha senha
          </Link>
          <Link to="/register" className="text-brand-600 hover:underline dark:text-brand-400">
            Criar minha conta
          </Link>
        </div>
      </form>
    </AuthShell>
  );
}
