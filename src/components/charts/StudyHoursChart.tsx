import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer, CartesianGrid } from "recharts";
import { weekdayShortLabel, formatMinutes } from "@/utils/time";

interface Props {
  data: { date: string; minutes: number }[];
}

export function StudyHoursChart({ data }: Props) {
  const hasData = data.some((d) => d.minutes > 0);
  const chartData = data.map((d) => ({ ...d, label: weekdayShortLabel(d.date) }));

  return (
    <div className="card">
      <h3 className="mb-4 text-base font-semibold">Horas estudadas</h3>
      {!hasData ? (
        <div className="flex h-48 items-center justify-center text-center text-sm text-slate-400">
          Você ainda não possui dados suficientes.
          <br />
          Comece estudando seu primeiro conteúdo.
        </div>
      ) : (
        <ResponsiveContainer width="100%" height={200}>
          <BarChart data={chartData} margin={{ top: 4, right: 8, left: -20, bottom: 0 }}>
            <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e2e8f0" />
            <XAxis dataKey="label" tick={{ fontSize: 12, fill: "#64748b" }} axisLine={false} tickLine={false} />
            <YAxis tick={{ fontSize: 12, fill: "#64748b" }} axisLine={false} tickLine={false} allowDecimals={false} />
            <Tooltip
              formatter={(value: number) => [formatMinutes(value), "Estudado"]}
              labelFormatter={(label) => `${label}`}
              contentStyle={{ borderRadius: 12, border: "1px solid #e2e8f0", fontSize: 13 }}
            />
            <Bar dataKey="minutes" fill="#4f46e5" radius={[6, 6, 0, 0]} maxBarSize={36} />
          </BarChart>
        </ResponsiveContainer>
      )}
    </div>
  );
}
