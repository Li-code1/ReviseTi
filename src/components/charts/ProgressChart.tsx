import { LineChart, Line, XAxis, YAxis, Tooltip, ResponsiveContainer, CartesianGrid } from "recharts";
import type { EvolutionPoint } from "@/services/dashboardService";

interface Props {
  data: EvolutionPoint[];
}

export function ProgressChart({ data }: Props) {
  const hasEnoughData = data.length >= 2;

  return (
    <div className="card">
      <h3 className="mb-4 text-base font-semibold">Evolução dos estudos</h3>
      {!hasEnoughData ? (
        <div className="flex h-48 items-center justify-center text-center text-sm text-slate-400">
          Continue estudando para visualizar sua evolução.
        </div>
      ) : (
        <ResponsiveContainer width="100%" height={200}>
          <LineChart data={data} margin={{ top: 4, right: 8, left: -20, bottom: 0 }}>
            <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e2e8f0" />
            <XAxis
              dataKey="date"
              tick={{ fontSize: 12, fill: "#64748b" }}
              axisLine={false}
              tickLine={false}
              tickFormatter={(v: string) => new Date(v).toLocaleDateString("pt-BR", { day: "2-digit", month: "2-digit" })}
            />
            <YAxis tick={{ fontSize: 12, fill: "#64748b" }} axisLine={false} tickLine={false} allowDecimals={false} />
            <Tooltip
              formatter={(value: number) => [value, "Aulas concluídas (total)"]}
              labelFormatter={(v: string) => new Date(v).toLocaleDateString("pt-BR")}
              contentStyle={{ borderRadius: 12, border: "1px solid #e2e8f0", fontSize: 13 }}
            />
            <Line type="monotone" dataKey="completedContents" stroke="#4f46e5" strokeWidth={2} dot={false} />
          </LineChart>
        </ResponsiveContainer>
      )}
    </div>
  );
}
