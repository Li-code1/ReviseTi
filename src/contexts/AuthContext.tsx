import { createContext, useEffect, useState, ReactNode } from "react";
import type { Session, User } from "@supabase/supabase-js";
import { supabase } from "@/lib/supabase";
import { ensureLocalDataOwnership, hasLocalData, pullInitialData } from "@/services/offlineService";
import { clearPrivateLocalData } from "@/lib/localDb";

interface AuthContextValue {
  user: User | null;
  session: Session | null;
  loading: boolean;
  login: (email: string, password: string) => Promise<{ error: string | null }>;
  register: (name: string, email: string, password: string) => Promise<{ error: string | null }>;
  logout: () => Promise<void>;
  resetPassword: (email: string) => Promise<{ error: string | null }>;
  updatePassword: (newPassword: string) => Promise<{ error: string | null }>;
}

// Maps raw Supabase error messages to friendly Portuguese copy. We never show
// the technical Supabase error string directly to the end user.
function friendlyAuthError(message: string): string {
  const m = message.toLowerCase();
  if (m.includes("invalid login credentials")) return "Email ou senha inválidos.";
  if (m.includes("email not confirmed")) return "Confirme seu email antes de entrar.";
  if (m.includes("user already registered")) return "Já existe uma conta com esse email.";
  if (m.includes("password should be at least")) return "A senha precisa ter pelo menos 6 caracteres.";
  if (m.includes("network")) return "Verifique sua conexão com a internet.";
  return "Não foi possível concluir a operação. Tente novamente.";
}

export const AuthContext = createContext<AuthContextValue | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [session, setSession] = useState<Session | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    supabase.auth.getSession().then(({ data }) => {
      setSession(data.session);
      setUser(data.session?.user ?? null);
      setLoading(false);
    });

    const { data: listener } = supabase.auth.onAuthStateChange((_event, newSession) => {
      setSession(newSession);
      setUser(newSession?.user ?? null);

      if (newSession?.user) {
        const userId = newSession.user.id;
        // Garante que dados locais de uma conta anterior no mesmo aparelho
        // sejam removidos antes de usar/baixar os dados deste usuário.
        ensureLocalDataOwnership(userId).then(async () => {
          if (navigator.onLine) {
            const alreadySynced = await hasLocalData(userId);
            // Primeira sincronização é obrigatória; depois disso, cada tela já
            // busca dados frescos quando online via seus próprios repositories.
            if (!alreadySynced) await pullInitialData(userId);
          }
        });
      } else {
        // Logout: nunca deixar dados privados de um usuário disponíveis para o próximo.
        clearPrivateLocalData();
      }
    });

    return () => listener.subscription.unsubscribe();
  }, []);

  async function login(email: string, password: string) {
    const { error } = await supabase.auth.signInWithPassword({ email, password });
    return { error: error ? friendlyAuthError(error.message) : null };
  }

  async function register(name: string, email: string, password: string) {
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: { data: { full_name: name } },
    });
    if (error) return { error: friendlyAuthError(error.message) };

    // O Supabase não retorna erro quando o email já está cadastrado (é proposital,
    // para não permitir descobrir quais emails existem). O sinal real é
    // `identities` vir vazio nesse caso — só assim dá pra distinguir de um
    // cadastro novo de verdade.
    if (data.user && data.user.identities && data.user.identities.length === 0) {
      return { error: "Já existe uma conta com esse email." };
    }

    return { error: null };
  }

  async function logout() {
    await supabase.auth.signOut();
  }

  async function resetPassword(email: string) {
    const { error } = await supabase.auth.resetPasswordForEmail(email, {
      redirectTo: `${window.location.origin}/reset-password`,
    });
    return { error: error ? friendlyAuthError(error.message) : null };
  }

  async function updatePassword(newPassword: string) {
    const { error } = await supabase.auth.updateUser({ password: newPassword });
    return { error: error ? friendlyAuthError(error.message) : null };
  }

  return (
    <AuthContext.Provider
      value={{ user, session, loading, login, register, logout, resetPassword, updatePassword }}
    >
      {children}
    </AuthContext.Provider>
  );
}
