import { Link, useNavigate } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { Radar, Coins, Zap, LogOut } from "lucide-react";
import { useAuthStore } from "@/store/auth";
import { fetchMe } from "@/lib/api";
import { rankDisplay } from "@/lib/rank";
import { usePathwayStore } from "@/store/pathway";

const PATHWAY_STATIONS: Record<string, string> = {
  "cyber-guardians": "Ops Division // Node 07",
  "backend-engineering": "Forge Division // Node 12",
  "ai-ml": "Cipher Division // Node 03",
};

export function HudBar() {
  const user = useAuthStore((s) => s.user);
  const signOut = useAuthStore((s) => s.signOut);
  const pathwaySlug = usePathwayStore((s) => s.selectedPathwaySlug);
  const navigate = useNavigate();
  const { data: me } = useQuery({ queryKey: ["me"], queryFn: fetchMe });

  const displayName: string =
    me?.displayName ??
    (user?.user_metadata?.display_name as string | undefined) ??
    user?.email?.split("@")[0] ??
    "Agent";
  const initials = displayName.slice(0, 2).toUpperCase();
  const clearance = rankDisplay(me?.rank ?? "recruit").clearance;

  const stats = [
    { icon: Zap, label: "XP", value: me ? me.xp.toLocaleString() : "—", tone: "telemetry" as const },
    { icon: Coins, label: "Credits", value: me ? me.credits.toLocaleString() : "—", tone: "signal" as const },
  ];

  const onLogout = async () => {
    await signOut();
    navigate("/login", { replace: true });
  };

  return (
    <header className="sticky top-0 z-50 border-b border-border/80 bg-background/80 backdrop-blur-xl">
      <div className="flex h-16 items-center gap-6 px-5">
        <Link to="/" className="flex items-center gap-3">
          <div className="corner-cut grid h-9 w-9 place-items-center bg-primary/15 text-primary glow-signal">
            <Radar className="h-5 w-5" />
          </div>
          <div className="leading-none">
            <div className="font-display text-sm font-bold tracking-[0.22em] text-foreground uppercase">
              Breachsphire
            </div>
            <div className="label-mono mt-1 whitespace-nowrap">
              {(pathwaySlug && PATHWAY_STATIONS[pathwaySlug]) ?? "Nexus // Pathway Registry"}
            </div>
          </div>
        </Link>

        <div className="ml-auto flex items-center gap-2 sm:gap-4">
          {stats.map((s) => (
            <div
              key={s.label}
              className="hidden items-center gap-2 border-l border-border/70 pl-3 sm:flex"
            >
              <s.icon
                className={`h-4 w-4 ${s.tone === "signal" ? "text-primary" : "text-telemetry"}`}
              />
              <div className="leading-none">
                <div className="font-mono text-sm font-medium text-foreground">{s.value}</div>
                <div className="label-mono mt-0.5 text-[0.6rem]">{s.label}</div>
              </div>
            </div>
          ))}
          <Link to="/profile" className="flex items-center gap-3 border-l border-border/70 pl-3">
            <div className="hidden text-right leading-none md:block">
              <div className="font-display text-sm text-foreground uppercase">{displayName}</div>
              <div className="label-mono mt-1 text-telemetry">Clearance {clearance}</div>
            </div>
            <div className="corner-cut grid h-9 w-9 place-items-center bg-gradient-to-br from-telemetry/30 to-primary/25 font-display text-sm text-foreground">
              {initials}
            </div>
          </Link>
          <button
            type="button"
            onClick={onLogout}
            title="Sign out"
            aria-label="Sign out"
            className="border-l border-border/70 pl-3 text-muted-foreground transition-colors hover:text-threat"
          >
            <LogOut className="h-4 w-4" />
          </button>
        </div>
      </div>
    </header>
  );
}
