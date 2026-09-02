import { useEffect, useState, FormEvent } from "react";
import { Link } from "react-router-dom";
import { Loader2, Cloud, Smartphone, CheckCircle2 } from "lucide-react";
import { useAuth } from "@/hooks/useAuth";
import { getProfile, updateProfile } from "@/services/profileService";
import { useToast } from "@/components/ui/Toast";
import { useSync } from "@/hooks/useSync";
import { useStudyGoal } from "@/hooks/useStudyGoal";
import { useStudySessions } from "@/hooks/useStudySessions";
import { useInstallPrompt } from "@/hooks/useInstallPrompt";
import { useOnlineStatus } from "@/hooks/useOnlineStatus";
import { WeeklyGoal } from "@/components/dashboard/WeeklyGoal";
import { LogoutButton } from "@/components/layout/LogoutButton";

export default function Settings() {
  const { user, updatePassword } = useAuth();
  const { showToast } = useToast();
  const { status, pendingCount, lastSyncAt } = useSync();
  const { isOnline } = useOnlineStatus();
  const goal = useStudyGoal();
  const sessions = useStudySessions();
  const { canInstall, installed, promptInstall } = useInstallPrompt();

  const [name, setName] = useState("");
  const [createdAt, setCreatedAt] = useState<string | null>(null);
  const [savingProfile, setSavingProfile] = useState(false);
  const [newPassword, setNewPassword] = useState("");
  const [savingPassword, setSavingPassword] = useState(false);

  useEffect(() => {
    if (!user) return;
    getProfile(user.id).then((p) => {
      setName(p?.full_name ?? "");
      setCreatedAt(p?.created_at ?? null);
    });
  }, [user]);

  async function handleProfileSubmit(e: FormEvent) {
    e.preventDefault();
    if (!user) return;
    setSavingProfile(true);
    const { error } = await updateProfile(user.id, { full_name: name });
    setSavingProfile(false);
    showToast(error ? "Não foi possível salvar." : "Alterações salvas.", error ? "error" : "success");
  }

  async function handlePasswordSubmit(e: FormEvent) {
    e.preventDefault();
    if (newPassword.length < 6) {
      showToast("A senha precisa ter pelo menos 6 caracteres.", "error");
      return;
    }
    setSavingPassword(true);
    const { error } = await updatePassword(newPassword);
    setSavingPassword(false);
    if (error) showToast(error, "error");
    else {
      showToast("Alterações salvas.");
      setNewPassword("");
    }
  }

  async function handleInstall() {
    const choice = await promptInstall();
    if (choice.outcome === "accepted") showToast("Instalando o ReviseTI...");
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Configurações</h1>
        <p className="mt-1 text-slate-500 dark:text-slate-400">Gerencie sua conta e seus dados.</p>
      </div>

      <section className="card">
        <h2 className="mb-4 text-lg font-semibold">Perfil</h2>
        <form onSubmit={handleProfileSubmit} className="space-y-4">
          <div>
            <label htmlFor="name" className="label-field">Nome</label>
            <input id="name" value={name} onChange={(e) => setName(e.target.value)} className="input-field" />
          </div>
          <div>
            <label htmlFor="email" className="label-field">Email</label>
            <input id="email" value={user?.email ?? ""} disabled className="input-field opacity-60" />
          </div>
          {createdAt && (
            <p className="text-xs text-slate-400">
              Conta criada em {new Date(createdAt).toLocaleDateString("pt-BR")}
            </p>
          )}
          <button type="submit" disabled={savingProfile} className="btn-primary">
            {savingProfile && <Loader2 className="h-4 w-4 animate-spin" />}
            Salvar alterações
          </button>
        </form>
      </section>

      <section className="card">
        <h2 className="mb-1 text-lg font-semibold">Meta semanal</h2>
        <p className="mb-4 text-sm text-slate-500 dark:text-slate-400">Defina quantas horas por semana você quer estudar.</p>
        {!goal.loading && (
          <WeeklyGoal weeklyMinutes={goal.weeklyMinutes} achievedMinutes={sessions.hours.weekMinutes} onUpdateGoal={goal.updateGoal} />
        )}
      </section>

      <section className="card">
        <h2 className="mb-4 text-lg font-semibold">Sincronização</h2>
        <div className="flex items-center justify-between">
          <div>
            <p className="text-sm font-medium">
              {isOnline ? (status === "synced" ? "Sincronizado" : status === "syncing" ? "Sincronizando..." : "Alterações pendentes") : "Offline"}
            </p>
            <p className="text-sm text-slate-500 dark:text-slate-400">
              {lastSyncAt ? `Última sincronização: ${new Date(lastSyncAt).toLocaleString("pt-BR")}` : "Ainda não sincronizado."}
              {pendingCount > 0 && ` · ${pendingCount} pendente${pendingCount === 1 ? "" : "s"}`}
            </p>
          </div>
          <Link to="/sync" className="btn-secondary flex-shrink-0">
            <Cloud className="h-4 w-4" /> Ver detalhes
          </Link>
        </div>
      </section>

      {(canInstall || installed) && (
        <section className="card">
          <h2 className="mb-1 text-lg font-semibold">Instalar aplicativo</h2>
          <p className="mb-4 text-sm text-slate-500 dark:text-slate-400">
            Instale o ReviseTI no seu celular ou computador para acessar mais rápido, inclusive offline.
          </p>
          {installed ? (
            <p className="flex items-center gap-2 text-sm font-medium text-green-600">
              <CheckCircle2 className="h-4 w-4" /> Aplicativo já instalado
            </p>
          ) : (
            <button onClick={handleInstall} className="btn-primary">
              <Smartphone className="h-4 w-4" /> Instalar ReviseTI
            </button>
          )}
        </section>
      )}

      <section className="card">
        <h2 className="mb-4 text-lg font-semibold">Conta</h2>
        <form onSubmit={handlePasswordSubmit} className="space-y-4">
          <div>
            <label htmlFor="newPassword" className="label-field">Nova senha</label>
            <input
              id="newPassword"
              type="password"
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)}
              className="input-field"
            />
          </div>
          <div className="flex gap-3">
            <button type="submit" disabled={savingPassword} className="btn-primary">
              {savingPassword && <Loader2 className="h-4 w-4 animate-spin" />}
              Alterar senha
            </button>
            <LogoutButton className="btn-secondary">
              Sair
            </LogoutButton>
          </div>
        </form>

        <div className="mt-6 border-t border-slate-100 pt-4 dark:border-slate-800">
          <p className="text-sm text-slate-500 dark:text-slate-400">
            Quer excluir sua conta e todos os seus dados? Entre em contato pelo suporte:{" "}
            <a href="mailto:lilianelimafullstackdeveloper@gmail.com" className="font-medium text-brand-600 hover:underline dark:text-brand-400">
              lilianelimafullstackdeveloper@gmail.com
            </a>
          </p>
        </div>
      </section>
    </div>
  );
}
