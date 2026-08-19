import { useEffect, useRef, useState } from "react";
import { ChevronDown, MessageCircle } from "lucide-react";
import { CharacterAvatar } from "./CharacterAvatar";
import { getCharacterProfile } from "@/lib/characters";
import { cn } from "@/lib/utils";

export type DialogueLine = {
  characterId: string;
  text: string;
};

export type ChatDialogueProps = {
  lines: DialogueLine[];
  className?: string;
};

type Side = "left" | "right";

/** First distinct speaker gets the left side, second gets the right, and
 * it cycles from there -- keeps a two-character back-and-forth reading
 * clearly, and stays stable for longer casts instead of assigning sides
 * randomly per line. */
function buildSideMap(lines: DialogueLine[]): Map<string, Side> {
  const map = new Map<string, Side>();
  let next: Side = "left";
  for (const line of lines) {
    if (!map.has(line.characterId)) {
      map.set(line.characterId, next);
      next = next === "left" ? "right" : "left";
    }
  }
  return map;
}

/**
 * Renders a mission's opening story beat as a WhatsApp-style chat thread:
 * one bubble per line, each character's portrait beside their message,
 * revealed one tap at a time rather than dumped on screen all at once.
 */
export function ChatDialogue({ lines, className }: ChatDialogueProps) {
  const [revealedCount, setRevealedCount] = useState(() => (lines.length > 0 ? 1 : 0));
  const threadRef = useRef<HTMLDivElement>(null);
  const sideMapRef = useRef(buildSideMap(lines));

  useEffect(() => {
    threadRef.current?.scrollTo({ top: threadRef.current.scrollHeight, behavior: "smooth" });
  }, [revealedCount]);

  if (lines.length === 0) return null;

  const hasMore = revealedCount < lines.length;

  function advance() {
    setRevealedCount((count) => Math.min(count + 1, lines.length));
  }

  return (
    <div
      className={cn("hud-panel corner-cut relative overflow-hidden", className)}
      onClick={hasMore ? advance : undefined}
      role={hasMore ? "button" : undefined}
      tabIndex={hasMore ? 0 : undefined}
      onKeyDown={
        hasMore
          ? (e) => {
              if (e.key === "Enter" || e.key === " ") advance();
            }
          : undefined
      }
    >
      <div className="flex items-center gap-2 border-b border-border/60 px-4 py-2.5">
        <MessageCircle className="h-3.5 w-3.5 text-primary" />
        <span className="label-mono text-primary">Comms</span>
      </div>

      <div ref={threadRef} className="max-h-[420px] space-y-3 overflow-y-auto px-4 py-4">
        {lines.slice(0, revealedCount).map((line, i) => (
          <ChatBubble
            key={i}
            line={line}
            side={sideMapRef.current.get(line.characterId) ?? "left"}
            isNewest={i === revealedCount - 1}
          />
        ))}
      </div>

      {hasMore && (
        <div className="flex items-center justify-between border-t border-border/60 px-4 py-2.5">
          <span className="label-mono">
            {revealedCount}/{lines.length}
          </span>
          <span className="label-mono pulse-ring flex items-center gap-1 rounded-full bg-primary/10 px-2 py-1 text-primary">
            Tap to continue
            <ChevronDown className="h-3 w-3" />
          </span>
        </div>
      )}
    </div>
  );
}

function ChatBubble({ line, side, isNewest }: { line: DialogueLine; side: Side; isNewest: boolean }) {
  const profile = getCharacterProfile(line.characterId);
  const isLeft = side === "left";

  return (
    <div
      className={cn(
        "flex items-end gap-2",
        isLeft ? "flex-row" : "flex-row-reverse",
        isNewest && "animate-in fade-in slide-in-from-bottom-2 duration-300",
      )}
    >
      <CharacterAvatar
        tag={profile.name}
        characterId={line.characterId}
        size="md"
        shape="circle"
        tone={isLeft ? "telemetry" : "signal"}
        online
      />
      <div
        className={cn(
          "max-w-[78%] rounded-2xl border px-3.5 py-2.5",
          isLeft
            ? "rounded-bl-sm border-border bg-surface-raised/80"
            : "rounded-br-sm border-primary/30 bg-primary/12",
        )}
      >
        <div className={cn("label-mono mb-1", isLeft ? "text-telemetry" : "text-primary")}>{profile.name}</div>
        <p className="text-sm leading-relaxed text-foreground">{line.text}</p>
      </div>
    </div>
  );
}
