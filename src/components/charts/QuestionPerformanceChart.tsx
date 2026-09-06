import { PieChart, Pie, Cell, Tooltip, Legend, ResponsiveContainer } from "recharts";

interface Props {
  correct: number;
  wrong: number;
}

export function QuestionPerformanceChart({ correct, wrong }: Props) {
  const total = correct + wrong;
  const data = [
    { name: "Acertos", value: correct, color: "#16a34a" },
    { name: "Erros", value: wrong, color: "#dc2626" },
  ];

  return (
    <div className="card">
      <h3 className="mb-4 text-base font-semibold">Desempenho nas perguntas</h3>
      {total === 0 ? (
        <div className="flex h-48 items-center justify-center text-center text-sm text-slate-400">
          Responda perguntas no modo estudo para ver seu desempenho aqui.
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
