import { NavLink } from "react-router-dom";
import { Map, Radar, Crosshair, Trophy, Medal, UserRound, Waypoints, Anvil, BrainCircuit } from "lucide-react";
import type { LucideIcon } from "lucide-react";
import { HudBar } from "./HudBar";
import { SystemStatus } from "../SystemStatus";
import { usePathwayStore } from "@/store/pathway";

type NavItem = { to: string; label: string; icon: LucideIcon };

export const NAV_ITEMS: NavItem[] = [
  { to: "/", label: "Command", icon: Radar },
  { to: "/map", label: "World Map", icon: Map },
  { to: "/mission", label: "Mission", icon: Crosshair },
  { to: "/pathways", label: "Pathways", icon: Waypoints },
  { to: "/profile", label: "Dossier", icon: UserRound },
  { to: "/leaderboard", label: "Standings", icon: Trophy },
  { to: "/achievements", label: "Commendations", icon: Medal },
];

export function AppShell({ children }: { children: React.ReactNode }) {
  const pathwayTitle = usePathwayStore((s) => s.selectedPathwayTitle);
  const pathwaySlug = usePathwayStore((s) => s.selectedPathwaySlug);
  const hasLab = pathwaySlug === "backend-engineering" || pathwaySlug === "ai-ml";
  const labItem = pathwaySlug === "ai-ml"
    ? { to: "/forge", label: "Cipher Lab", icon: BrainCircuit }
    : { to: "/forge", label: "Forge Lab", icon: Anvil };
  const navItems = hasLab
    ? [...NAV_ITEMS.slice(0, 3), labItem, ...NAV_ITEMS.slice(3)]
    : NAV_ITEMS;
  const mobileLabels = hasLab
    ? new Set(["Command", "World Map", labItem.label, "Pathways", "Dossier"])
    : new Set(["Command", "World Map", "Pathways", "Dossier", "Commendations"]);
  const mobileNavItems = navItems.filter((item) => mobileLabels.has(item.label));
  return (
    <div className="min-h-screen">
      <HudBar />
      <div className="flex">
        <aside className="sticky top-16 hidden h-[calc(100vh-4rem)] w-16 shrink-0 flex-col items-center gap-1 border-r border-border bg-surface/40 py-4 md:flex xl:w-52 xl:items-stretch xl:px-3">
          {navItems.map((item) => (
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
            {pathwayTitle && (
              <NavLink to="/pathways" className="label-mono mb-2 block truncate text-primary hover:underline">
                {pathwayTitle} · Switch
              </NavLink>
            )}
            <div className="label-mono">Build 2.7.1</div>
            <SystemStatus />
          </div>
        </aside>

        <div className="min-w-0 flex-1 pb-20 md:pb-0">{children}</div>
      </div>

      <nav className="fixed inset-x-0 bottom-0 z-50 flex border-t border-border bg-background/95 backdrop-blur md:hidden">
        {mobileNavItems.map((item) => (
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
              {item.label === "World Map" ? "Map" : item.label.split(" ")[0]}
            </span>
          </NavLink>
        ))}
      </nav>
    </div>
  );
}
