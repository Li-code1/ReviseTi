/** Bloco base de skeleton — sempre prefira os componentes compostos abaixo. */
export function Skeleton({ className = "" }: { className?: string }) {
  return <div className={`animate-pulse rounded-lg bg-slate-200 dark:bg-slate-800 ${className}`} />;
}

/** Uma página inteira carregando: título + linha de cards + bloco de conteúdo. */
export function PageSkeleton() {
  return (
    <div className="space-y-8" aria-busy="true" aria-label="Carregando conteúdo da página">
      <div className="space-y-2">
        <Skeleton className="h-7 w-48" />
        <Skeleton className="h-4 w-72" />
      </div>
      <div className="grid grid-cols-2 gap-4 lg:grid-cols-4">
        {Array.from({ length: 4 }).map((_, i) => (
          <CardSkeleton key={i} />
        ))}
      </div>
      <ListSkeleton />
    </div>
  );
}

/** Um card de estatística/resumo. */
export function CardSkeleton() {
  return (
    <div className="card">
      <Skeleton className="mb-3 h-9 w-9 rounded-lg" />
      <Skeleton className="mb-2 h-6 w-16" />
      <Skeleton className="h-3 w-24" />
    </div>
  );
}

/** Lista de itens (revisões, perguntas, conteúdos...). */
export function ListSkeleton({ rows = 4 }: { rows?: number }) {
  return (
    <div className="space-y-3" aria-busy="true" aria-label="Carregando lista">
      {Array.from({ length: rows }).map((_, i) => (
        <div key={i} className="card">
          <Skeleton className="mb-2 h-4 w-2/3" />
          <Skeleton className="h-3 w-1/3" />
        </div>
      ))}
    </div>
  );
}

/** Espaço reservado para um gráfico carregando, com a mesma altura dos gráficos reais (evita layout pulando). */
export function ChartSkeleton() {
  return (
    <div className="card" aria-busy="true" aria-label="Carregando gráfico">
      <Skeleton className="mb-4 h-5 w-40" />
      <Skeleton className="h-[200px] w-full" />
    </div>
  );
}
