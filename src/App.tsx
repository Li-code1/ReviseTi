import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider } from "@/contexts/AuthContext";
import { ToastProvider } from "@/components/ui/Toast";
import { UpdatePrompt } from "@/components/layout/UpdatePrompt";
import { ErrorBoundary } from "@/components/layout/ErrorBoundary";
import { ProtectedRoute, PublicOnlyRoute } from "@/components/layout/ProtectedRoute";
import { AppLayout } from "@/components/layout/AppLayout";

import Login from "@/pages/Login";
import Register from "@/pages/Register";
import ForgotPassword from "@/pages/ForgotPassword";
import ResetPassword from "@/pages/ResetPassword";
import Dashboard from "@/pages/Dashboard";
import Contents from "@/pages/Contents";
import Week from "@/pages/Week";
import ContentDetail from "@/pages/ContentDetail";
import Reviews from "@/pages/Reviews";
import Questions from "@/pages/Questions";
import QuestionsStudy from "@/pages/QuestionsStudy";
import QuestionDetail from "@/pages/QuestionDetail";
import ProgressPage from "@/pages/Progress";
import Sync from "@/pages/Sync";
import Settings from "@/pages/Settings";
import NotFound from "@/pages/NotFound";
import StudySession from "@/pages/StudySession";
import Interview from "@/pages/Interview";

export default function App() {
  return (
    <ErrorBoundary>
      <AuthProvider>
        <ToastProvider>
          <UpdatePrompt />
          <BrowserRouter>
            <Routes>
              <Route path="/" element={<Navigate to="/dashboard" replace />} />

              {/* Rotas públicas */}
              <Route element={<PublicOnlyRoute />}>
                <Route path="/login" element={<Login />} />
                <Route path="/register" element={<Register />} />
                <Route path="/forgot-password" element={<ForgotPassword />} />
              </Route>
              {/* Acessível mesmo autenticado, pois chega via link de email */}
              <Route path="/reset-password" element={<ResetPassword />} />

              {/* Rotas privadas */}
              <Route element={<ProtectedRoute />}>
                <Route element={<AppLayout />}>
                  <Route path="/dashboard" element={<Dashboard />} />
                  <Route path="/contents" element={<Contents />} />
                  <Route path="/contents/week/:weekNumber" element={<Week />} />
                  <Route path="/contents/:id" element={<ContentDetail />} />
                  <Route path="/reviews" element={<Reviews />} />
                  <Route path="/questions" element={<Questions />} />
                  <Route path="/questions/study" element={<QuestionsStudy />} />
                  <Route path="/questions/:id" element={<QuestionDetail />} />
                  <Route path="/progress" element={<ProgressPage />} />
                  <Route path="/interview" element={<Interview />} />
                  <Route path="/study/lesson/:slug" element={<StudySession mode="lesson" />} />
                  <Route path="/study/week/:weekNumber" element={<StudySession mode="week" />} />
                  <Route path="/study/category/:category" element={<StudySession mode="category" />} />
                  <Route path="/study/general" element={<StudySession mode="general" />} />
                  <Route path="/sync" element={<Sync />} />
                  <Route path="/settings" element={<Settings />} />
                  <Route path="*" element={<NotFound />} />
                </Route>
              </Route>

              <Route path="*" element={<NotFound />} />
            </Routes>
          </BrowserRouter>
        </ToastProvider>
      </AuthProvider>
    </ErrorBoundary>
  );
}
