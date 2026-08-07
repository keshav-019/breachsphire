import { cn } from "@/lib/utils";

export type XPBarProps = {
  value: number;
  max: number;
  label?: string;
  tone?: "signal" | "telemetry";
  showNumbers?: boolean;
  className?: string;
};

export function XPBar({
  value,
  max,
  label = "XP",
  tone = "signal",
  showNumbers = true,
  className,
}: XPBarProps) {
  const pct = Math.max(0, Math.min(100, (value / max) * 100));
  return (
    <div className={cn("w-full", className)}>
      <div className="flex items-baseline justify-between">
        <span className="label-mono">{label}</span>
        {showNumbers && (
          <span className="font-mono text-xs text-foreground">
            {value.toLocaleString()}
            <span className="text-muted-foreground"> / {max.toLocaleString()}</span>
          </span>
        )}
      </div>
      <div className="mt-2 h-1.5 w-full overflow-hidden bg-muted">
        <div
          className="h-full transition-[width] duration-500"
          style={{
            width: `${pct}%`,
            background: tone === "signal" ? "var(--gradient-signal)" : "var(--gradient-telemetry)",
          }}
        />
      </div>
    </div>
  );
}
