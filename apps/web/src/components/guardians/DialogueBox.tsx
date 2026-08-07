import { CharacterAvatar } from "./CharacterAvatar";
import { cn } from "@/lib/utils";

export type DialogueBoxProps = {
  speaker: string;
  role?: string;
  line: string;
  tone?: "signal" | "telemetry" | "threat";
  className?: string;
};

export function DialogueBox({
  speaker,
  role,
  line,
  tone = "telemetry",
  className,
}: DialogueBoxProps) {
  return (
    <div className={cn("hud-panel corner-cut scanline relative p-4", className)}>
      <div className="flex items-center gap-3">
        <CharacterAvatar tag={speaker} size="lg" tone={tone} online />
        <div className="min-w-0">
          <div className="font-display text-sm tracking-wide text-foreground uppercase">
            {speaker}
          </div>
          {role && <div className="label-mono mt-1">{role}</div>}
        </div>
      </div>
      <p className="mt-4 border-l-2 border-primary/60 pl-3 text-sm leading-relaxed text-muted-foreground">
        {line}
      </p>
    </div>
  );
}
