import { useState, FormEvent } from "react";
import { Link, useNavigate } from "react-router-dom";
import { AuthShell } from "@/components/layout/AuthShell";
import { useAuth } from "@/hooks/useAuth";
import { useToast } from "@/components/ui/Toast";
import { Loader2 } from "lucide-react";

export default function Register() {
  const { register } = useAuth();
  const { showToast } = useToast();
  const navigate = useNavigate();

  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [submitting, setSubmitting] = useState(false);

  function validate(): boolean {
    const next: Record<string, string> = {};
    if (!name.trim()) next.name = "Informe seu nome.";
    if (!/^\S+@\S+\.\S+$/.test(email)) next.email = "Informe um email válido.";
    if (password.length < 6) next.password = "A senha precisa ter pelo menos 6 caracteres.";
    if (confirmPassword !== password) next.confirmPassword = "As senhas não coincidem.";
    setErrors(next);
    return Object.keys(next).length === 0;
  }

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    if (!validate()) return;
    setSubmitting(true);
    const { error } = await register(name, email, password);
    setSubmitting(false);
    if (error) {
      setErrors({ form: error });
      return;
    }
    showToast("Conta criada com sucesso. Verifique seu email, se necessário, e faça login.");
    navigate("/login");
  }

  return (
    <AuthShell title="Criar conta" subtitle="Comece sua jornada de estudos em TI.">
      <form onSubmit={handleSubmit} noValidate className="space-y-4">
        <div>
          <label htmlFor="name" className="label-field">Nome</label>
          <input
            id="name"
            value={name}
            onChange={(e) => setName(e.target.value)}
            className="input-field"
            aria-invalid={!!errors.name}
            aria-describedby={errors.name ? "name-error" : undefined}
          />
          {errors.name && <p id="name-error" className="mt-1 text-xs text-red-600">{errors.name}</p>}
        </div>
        <div>
          <label htmlFor="email" className="label-field">Email</label>
          <input
            id="email"
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="input-field"
            aria-invalid={!!errors.email}
            aria-describedby={errors.email ? "email-error" : undefined}
          />
          {errors.email && <p id="email-error" className="mt-1 text-xs text-red-600">{errors.email}</p>}
        </div>
        <div>
          <label htmlFor="password" className="label-field">Senha</label>
          <input
            id="password"
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            className="input-field"
            aria-invalid={!!errors.password}
            aria-describedby={errors.password ? "password-error" : undefined}
          />
          {errors.password && <p id="password-error" className="mt-1 text-xs text-red-600">{errors.password}</p>}
        </div>
        <div>
          <label htmlFor="confirmPassword" className="label-field">Confirmar senha</label>
          <input
            id="confirmPassword"
            type="password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            className="input-field"
            aria-invalid={!!errors.confirmPassword}
            aria-describedby={errors.confirmPassword ? "confirm-error" : undefined}
          />
          {errors.confirmPassword && (
            <p id="confirm-error" className="mt-1 text-xs text-red-600">{errors.confirmPassword}</p>
          )}
        </div>

        {errors.form && <p role="alert" className="text-sm text-red-600 dark:text-red-400">{errors.form}</p>}

        <button type="submit" disabled={submitting} className="btn-primary w-full">
          {submitting && <Loader2 className="h-4 w-4 animate-spin" />}
          Criar conta
        </button>

        <p className="text-center text-sm text-slate-500 dark:text-slate-400">
          Já tem conta?{" "}
          <Link to="/login" className="font-medium text-brand-600 hover:underline dark:text-brand-400">
            Entrar
          </Link>
        </p>
      </form>
    </AuthShell>
  );
}
