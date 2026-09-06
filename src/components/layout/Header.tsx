import { Menu } from "lucide-react";
import { SyncIndicator } from "./SyncIndicator";
import { UserMenu } from "./UserMenu";

export function Header({ userName, onMenuClick }: { userName: string; onMenuClick: () => void }) {
  return (
    <header className="flex h-16 items-center justify-between border-b border-slate-200 bg-white px-4 dark:border-slate-800 dark:bg-slate-900 lg:px-8">
      <button
        onClick={onMenuClick}
        aria-label="Abrir menu"
        className="rounded-lg p-2 text-slate-600 hover:bg-slate-100 dark:text-slate-300 dark:hover:bg-slate-800 lg:hidden"
      >
        <Menu className="h-5 w-5" />
      </button>
      <span className="text-base font-semibold lg:hidden">ReviseTI</span>
      <div className="ml-auto flex items-center gap-3">
        <SyncIndicator />
        <div className="hidden text-sm font-medium text-slate-700 dark:text-slate-300 sm:block">{userName}</div>
        <UserMenu userName={userName} />
      </div>
    </header>
  );
}
