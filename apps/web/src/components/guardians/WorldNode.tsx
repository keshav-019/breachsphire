import { Check, Crosshair, Lock, Skull } from "lucide-react";
import type { World } from "@/lib/api";
import { cn } from "@/lib/utils";

export type WorldNodeProps = {
  world: World;
  selected?: boolean;
  onSelect?: (world: World) => void;
  className?: string;
  style?: React.CSSProperties;
};

const stateStyles = {
  cleared: "border-telemetry/70 bg-telemetry/15 text-telemetry",
  active: "border-primary bg-primary/20 text-primary pulse-ring",
  unlocked: "border-foreground/40 bg-surface-raised text-foreground",
  locked: "border-border bg-surface text-muted-foreground",
} as const;

export function WorldNode({ world, selected, onSelect, className, style }: WorldNodeProps) {
  const Icon = world.icon;
  const StateIcon =
    world.state === "cleared" ? Check : world.state === "locked" ? Lock : Crosshair;

  return (
    <button
      type="button"
      onClick={() => onSelect?.(world)}
      aria-label={world.name}
      className={cn("group flex w-24 flex-col items-center gap-2 text-center", className)}
      style={style}
    >
      <span className="relative">
        <span
          className={cn(
            "grid h-14 w-14 place-items-center rounded-full border-2 transition-transform group-hover:scale-110",
            stateStyles[world.state],
            selected && "ring-2 ring-primary ring-offset-2 ring-offset-background",
          )}
        >
          <Icon className="h-6 w-6" />
        </span>
        <span className="absolute -right-1 -bottom-1 grid h-5 w-5 place-items-center rounded-full border border-border bg-background">
          <StateIcon className="h-3 w-3" />
        </span>
        {world.boss && (
          <span className="absolute -top-2 -left-2 grid h-5 w-5 place-items-center rounded-full border border-threat/60 bg-background text-threat">
            <Skull className="h-3 w-3" />
          </span>
        )}
      </span>

      <span className="font-display text-[0.7rem] leading-tight text-foreground">
        {world.short}
      </span>
      <span className="h-1 w-14 overflow-hidden bg-muted">
        <span
          className="block h-full"
          style={{
            width: `${world.completion}%`,
            background:
              world.state === "cleared" ? "var(--gradient-telemetry)" : "var(--gradient-signal)",
          }}
        />
      </span>
      <span className="label-mono text-[0.6rem]">{world.completion}%</span>
    </button>
  );
}
