import { PieChart, Pie, Cell, Tooltip, Legend, ResponsiveContainer } from "recharts";

interface Props {
  pending: number;
  completed: number;
  overdue: number;
}

const COLORS = { pending: "#94a3b8", completed: "#16a34a", overdue: "#dc2626" };

export function ReviewStatusChart({ pending, completed, overdue }: Props) {
  const total = pending + completed + overdue;
  const data = [
    { name: "Pendentes", value: pending, color: COLORS.pending },
    { name: "Concluídas", value: completed, color: COLORS.completed },
    { name: "Atrasadas", value: overdue, color: COLORS.overdue },
  ];

  return (
    <div className="card">
      <h3 className="mb-4 text-base font-semibold">Status das revisões</h3>
      {total === 0 ? (
        <div className="flex h-48 items-center justify-center text-center text-sm text-slate-400">
          Você ainda não possui revisões cadastradas.
        </div>
      ) : (
        <ResponsiveContainer width="100%" height={200}>
          <PieChart>
            <Pie data={data} dataKey="value" nameKey="name" innerRadius={50} outerRadius={80} paddingAngle={2}>
              {data.map((d) => (
                <Cell key={d.name} fill={d.color} />
              ))}
            </Pie>
            <Tooltip formatter={(value: number, name: string) => [value, name]} contentStyle={{ borderRadius: 12, border: "1px solid #e2e8f0", fontSize: 13 }} />
            <Legend verticalAlign="bottom" height={32} iconType="circle" wrapperStyle={{ fontSize: 12 }} />
          </PieChart>
        </ResponsiveContainer>
      )}
    </div>
  );
}
