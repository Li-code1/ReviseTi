import { Component, ReactNode } from "react";
import { AlertTriangle } from "lucide-react";

interface Props {
  children: ReactNode;
}

interface State {
  hasError: boolean;
}

/** Evita que um erro em uma página derrube o aplicativo inteiro — mostra um fallback com opção de tentar de novo. */
export class ErrorBoundary extends Component<Props, State> {
  state: State = { hasError: false };

  static getDerivedStateFromError(): State {
    return { hasError: true };
  }

  componentDidCatch(error: unknown) {
    // eslint-disable-next-line no-console
    console.error("Erro não tratado capturado pelo ErrorBoundary:", error);
  }

  handleRetry = () => {
    this.setState({ hasError: false });
  };

  render() {
    if (this.state.hasError) {
      return (
        <div className="flex flex-col items-center justify-center gap-3 rounded-2xl border border-red-100 bg-red-50 px-4 py-16 text-center dark:border-red-900/40 dark:bg-red-950/30">
          <AlertTriangle className="h-8 w-8 text-red-500" />
          <p className="font-medium text-red-700 dark:text-red-300">Algo deu errado.</p>
          <button onClick={this.handleRetry} className="btn-primary">
            Tentar novamente
          </button>
        </div>
      );
    }
    return this.props.children;
  }
}
