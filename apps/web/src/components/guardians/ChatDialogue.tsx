import { useMemo, useRef, useState } from "react";
import { ArrowRight, ChevronDown, MessageCircle } from "lucide-react";
import { CharacterAvatar } from "./CharacterAvatar";
import { getCharacterProfile } from "@/lib/characters";
import { cn } from "@/lib/utils";

export type DialogueLine = {
  characterId: string;
  text: string;
};

export type ChatDialogueProps = {
  lines: DialogueLine[];
  /** Called once, the moment the player taps past the final line -- the
   * caller is expected to clear this component from view and show the
   * actual task/challenge in its place. */
  onComplete: () => void;
  className?: string;
};

type Tone = "signal" | "telemetry" | "clearance";
const TONE_CYCLE: Tone[] = ["signal", "telemetry", "clearance"];

/** Stable per-character accent so a multi-character conversation stays
 * readable without needing a left/right chat-app layout -- first speaker
 * encountered gets the first tone, second gets the next, cycling. */
function buildToneMap(lines: DialogueLine[]): Map<string, Tone> {
  const map = new Map<string, Tone>();
  let i = 0;
  for (const line of lines) {
    if (!map.has(line.characterId)) {
      map.set(line.characterId, TONE_CYCLE[i % TONE_CYCLE.length]!);
      i += 1;
    }
  }
  return map;
}

const TONE_TEXT: Record<Tone, string> = {
  signal: "text-primary",
  telemetry: "text-telemetry",
  clearance: "text-clearance",
};

const TONE_AVATAR: Record<Tone, "signal" | "telemetry" | "threat"> = {
  signal: "signal",
  telemetry: "telemetry",
  clearance: "threat",
};

/**
 * Mission opening scene, presented like a mobile visual-novel stage: one
 * large portrait for whoever is currently speaking, centered, with the
 * transcript building downward underneath as the player taps through it
 * one line at a time. Once every line has been shown, the final tap
 * hands off to `onComplete` instead of revealing anything further.
 */
export function ChatDialogue({ lines, onComplete, className }: ChatDialogueProps) {
  const [revealedCount, setRevealedCount] = useState(() => Math.min(1, lines.length));
  const toneMapRef = useRef(useMemo(() => buildToneMap(lines), [lines]));

  if (lines.length === 0) return null;

  const hasMore = revealedCount < lines.length;
  const latestLine = lines[revealedCount - 1];
  const speaker = latestLine ? getCharacterProfile(latestLine.characterId) : null;
  const speakerTone = latestLine ? (toneMapRef.current.get(latestLine.characterId) ?? "signal") : "signal";

  function handleTap() {
    if (hasMore) {
      setRevealedCount((count) => Math.min(count + 1, lines.length));
    } else {
      onComplete();
    }
  }

  return (
    <div
      data-testid="dialogue-stage"
      className={cn("mx-auto flex w-full max-w-xl cursor-pointer flex-col items-center", className)}
      onClick={handleTap}
      role="button"
      tabIndex={0}
      onKeyDown={(e) => {
        if (e.key === "Enter" || e.key === " ") handleTap();
      }}
    >
      {speaker && (
        <div data-testid="dialogue-current-speaker" className="flex flex-col items-center">
          <CharacterAvatar
            key={latestLine!.characterId}
            tag={speaker.name}
            characterId={latestLine!.characterId}
            size="2xl"
            tone={TONE_AVATAR[speakerTone]}
            className="animate-in fade-in zoom-in-95 duration-300"
          />
          <div className={cn("mt-3 font-display text-lg tracking-wide uppercase", TONE_TEXT[speakerTone])}>
            {speaker.name}
          </div>
          {speaker.role && <div className="label-mono mt-0.5">{speaker.role}</div>}
        </div>
      )}

      <div data-testid="dialogue-transcript" className="mt-5 flex w-full flex-col gap-3">
        {lines.slice(0, revealedCount).map((line, i) => {
          const tone = toneMapRef.current.get(line.characterId) ?? "signal";
          const isLatest = i === revealedCount - 1;
          return (
            <div
              key={i}
              className={cn(
                "hud-panel corner-cut px-4 py-3 text-center",
                isLatest && "animate-in fade-in slide-in-from-bottom-2 duration-300",
              )}
            >
              <div className={cn("label-mono mb-1", TONE_TEXT[tone])}>{getCharacterProfile(line.characterId).name}</div>
              <p className="text-sm leading-relaxed text-foreground">{line.text}</p>
            </div>
          );
        })}
      </div>

      <div className="mt-5 flex items-center gap-2">
        <MessageCircle className="h-3.5 w-3.5 text-muted-foreground" />
        <span className="label-mono">
          {revealedCount}/{lines.length}
        </span>
        <span
          data-testid="dialogue-advance-prompt"
          className={cn(
            "label-mono pulse-ring ml-2 flex items-center gap-1 rounded-full px-3 py-1.5",
            hasMore ? "bg-surface-raised text-foreground" : "bg-primary/15 text-primary",
          )}
        >
          {hasMore ? (
            <>
              Tap to continue
              <ChevronDown className="h-3 w-3" />
            </>
          ) : (
            <>
              Continue
              <ArrowRight className="h-3 w-3" />
            </>
          )}
        </span>
      </div>
    </div>
  );
}
