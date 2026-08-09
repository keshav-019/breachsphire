import { cn } from "@/lib/utils";
import { getCharacterProfile } from "@/lib/characters";

export type CharacterAvatarProps = {
  tag: string;
  characterId?: string;
  size?: "sm" | "md" | "lg" | "xl";
  tone?: "signal" | "telemetry" | "threat";
  online?: boolean;
  className?: string;
};

const sizes = {
  sm: "h-8 w-8 text-[0.65rem]",
  md: "h-10 w-10 text-xs",
  lg: "h-14 w-14 text-base",
  xl: "h-24 w-24 text-2xl",
} as const;

const tones = {
  signal: "from-primary/35 to-primary/10 text-primary",
  telemetry: "from-telemetry/35 to-telemetry/10 text-telemetry",
  threat: "from-threat/35 to-threat/10 text-threat",
} as const;

export function CharacterAvatar({
  tag,
  characterId,
  size = "md",
  tone = "telemetry",
  online,
  className,
}: CharacterAvatarProps) {
  const avatarUrl = characterId ? getCharacterProfile(characterId).avatarUrl : undefined;

  return (
    <span className={cn("relative inline-flex shrink-0", className)}>
      <span
        className={cn(
          "corner-cut grid place-items-center overflow-hidden border border-border bg-gradient-to-br font-display tracking-widest",
          sizes[size],
          tones[tone],
        )}
      >
        {avatarUrl ? (
          <img
            src={avatarUrl}
            alt={`${tag} avatar`}
            className="h-full w-full object-cover"
            decoding="async"
            loading="lazy"
          />
        ) : (
          tag.slice(0, 2).toUpperCase()
        )}
      </span>
      {online && (
        <span className="absolute -right-0.5 -bottom-0.5 h-2.5 w-2.5 rounded-full border-2 border-background bg-telemetry" />
      )}
    </span>
  );
}
