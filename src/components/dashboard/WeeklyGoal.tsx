import { useState } from "react";
import { Pencil } from "lucide-react";
import { Modal } from "@/components/ui/Modal";
import { formatMinutes } from "@/utils/time";

const PRESETS = [60, 180, 300, 420, 600, 900, 1200]; // 1h,3h,5h,7h,10h,15h,20h

interface Props {
  weeklyMinutes: number;
  achievedMinutes: number;
  onUpdateGoal: (minutes: number) => Promise<{ error: string | null }>;
}

export function WeeklyGoal({ weeklyMinutes, achievedMinutes, onUpdateGoal }: Props) {
  const [editing, setEditing] = useState(false);
  const [selected, setSelected] = useState<number>(weeklyMinutes);
  const [customHours, setCustomHours] = useState("");
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const percent = weeklyMinutes > 0 ? Math.round((achievedMinutes / weeklyMinutes) * 100) : 0;
  const visualPercent = Math.min(percent, 100);
  const achieved = percent >= 100;

  async function handleSave() {
    const minutes = customHours ? Math.round(Number(customHours) * 60) : selected;
    if (!minutes || minutes <= 0) {
      setError("Informe uma meta válida.");
      return;
    }
    setSaving(true);
    const { error } = await onUpdateGoal(minutes);
    setSaving(false);
    if (error) {
      setError(error);
      return;
    }
    setEditing(false);
    setCustomHours("");
  }

  return (
    <div className="card">
      <div className="flex items-center justify-between">
        <h3 className="text-base font-semibold">Meta semanal</h3>
        <button
          onClick={() => { setSelected(weeklyMinutes); setEditing(true); }}
          aria-label="Editar meta"
          className="rounded-lg p-1.5 text-slate-400 hover:bg-slate-100 hover:text-slate-600 dark:hover:bg-slate-800"
        >
          <Pencil className="h-4 w-4" />
        </button>
      </div>

      <p className="mt-3 text-sm text-slate-500 dark:text-slate-400">
        {formatMinutes(achievedMinutes)} / {formatMinutes(weeklyMinutes)}
      </p>
      <div className="mt-2 h-2.5 w-full overflow-hidden rounded-full bg-slate-100 dark:bg-slate-800">
        <div
          className={`h-full rounded-full transition-all ${achieved ? "bg-green-600" : "bg-brand-600"}`}
          style={{ width: `${visualPercent}%` }}
        />
      </div>
      <p className="mt-2 text-sm font-medium">
        {achieved ? "Meta atingida! 🎉" : `${percent}%`}
      </p>

      {editing && (
        <Modal title="Editar meta semanal" onClose={() => setEditing(false)}>
          <div className="space-y-4">
            <div className="grid grid-cols-4 gap-2">
              {PRESETS.map((m) => (
                <button
                  key={m}
                  onClick={() => { setSelected(m); setCustomHours(""); }}
                  className={`rounded-xl border px-2 py-2 text-sm font-medium transition ${
                    selected === m && !customHours
                      ? "border-brand-600 bg-brand-50 text-brand-700 dark:bg-brand-900/30 dark:text-brand-300"
                      : "border-slate-200 hover:bg-slate-50 dark:border-slate-700 dark:hover:bg-slate-800"
                  }`}
                >
                  {formatMinutes(m)}
                </button>
              ))}
            </div>
            <div>
              <label htmlFor="custom" className="label-field">Ou personalizado (horas por semana)</label>
              <input
                id="custom"
                type="number"
                min={0.5}
                step={0.5}
                value={customHours}
                onChange={(e) => setCustomHours(e.target.value)}
                placeholder="Ex: 12.5"
                className="input-field"
              />
            </div>
            {error && <p role="alert" className="text-sm text-red-600 dark:text-red-400">{error}</p>}
            <div className="flex justify-end gap-3 pt-2">
              <button onClick={() => setEditing(false)} className="btn-secondary">Cancelar</button>
              <button onClick={handleSave} disabled={saving} className="btn-primary">Salvar meta</button>
            </div>
          </div>
        </Modal>
      )}
    </div>
  );
}
