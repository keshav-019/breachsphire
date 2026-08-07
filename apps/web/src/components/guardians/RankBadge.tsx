import { ShieldHalf } from "lucide-react";
import { cn } from "@/lib/utils";

export type RankBadgeProps = {
  clearance: string;
  title?: string;
  size?: "sm" | "md" | "lg";
  className?: string;
};

const sizes = {
  sm: "h-7 px-2 text-[0.65rem]",
  md: "h-9 px-3 text-xs",
  lg: "h-11 px-4 text-sm",
} as const;

export function RankBadge({ clearance, title, size = "md", className }: RankBadgeProps) {
  return (
    <span
      className={cn(
        "corner-cut inline-flex items-center gap-2 border border-primary/40 bg-primary/10 font-display tracking-[0.14em] text-primary uppercase",
        sizes[size],
        className,
      )}
    >
      <ShieldHalf className="h-3.5 w-3.5" />
      Clearance {clearance}
      {title && <span className="border-l border-primary/30 pl-2 text-foreground">{title}</span>}
    </span>
  );
}
