import { NavLink } from "react-router-dom";
import { Map, Radar, Crosshair, Trophy, Medal, UserRound } from "lucide-react";
import type { LucideIcon } from "lucide-react";
import { HudBar } from "./HudBar";
import { SystemStatus } from "../SystemStatus";

type NavItem = { to: string; label: string; icon: LucideIcon };

export const NAV_ITEMS: NavItem[] = [
  { to: "/", label: "Command", icon: Radar },
  { to: "/map", label: "World Map", icon: Map },
  { to: "/mission", label: "Mission", icon: Crosshair },
  { to: "/profile", label: "Dossier", icon: UserRound },
  { to: "/leaderboard", label: "Standings", icon: Trophy },
  { to: "/achievements", label: "Commendations", icon: Medal },
];

export function AppShell({ children }: { children: React.ReactNode }) {
  return (
    <div className="min-h-screen">
      <HudBar />
      <div className="flex">
        <aside className="sticky top-16 hidden h-[calc(100vh-4rem)] w-16 shrink-0 flex-col items-center gap-1 border-r border-border bg-surface/40 py-4 md:flex xl:w-52 xl:items-stretch xl:px-3">
          {NAV_ITEMS.map((item) => (
            <NavLink
              key={item.to}
              to={item.to}
              end={item.to === "/"}
              className={({ isActive }) =>
                `corner-cut flex items-center justify-center gap-3 px-3 py-3 transition-colors xl:justify-start ${
                  isActive
                    ? "bg-primary/15 text-primary glow-signal"
                    : "text-muted-foreground hover:text-foreground"
                }`
              }
              title={item.label}
            >
              <item.icon className="h-5 w-5 shrink-0" />
              <span className="label-mono hidden text-inherit xl:inline">{item.label}</span>
            </NavLink>
          ))}
          <div className="mt-auto hidden px-3 xl:block">
            <div className="label-mono">Build 2.7.1</div>
            <SystemStatus />
          </div>
        </aside>

        <div className="min-w-0 flex-1 pb-20 md:pb-0">{children}</div>
      </div>

      <nav className="fixed inset-x-0 bottom-0 z-50 flex border-t border-border bg-background/95 backdrop-blur md:hidden">
        {NAV_ITEMS.map((item) => (
          <NavLink
            key={item.to}
            to={item.to}
            end={item.to === "/"}
            className={({ isActive }) =>
              `flex flex-1 flex-col items-center gap-1 py-2.5 ${
                isActive ? "text-primary" : "text-muted-foreground"
              }`
            }
          >
            <item.icon className="h-5 w-5" />
            <span className="font-mono text-[0.55rem] tracking-widest uppercase">
              {item.label.split(" ")[0]}
            </span>
          </NavLink>
        ))}
      </nav>
    </div>
  );
}
