import { useState } from "react";
import { Flag } from "lucide-react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import type { ChallengeComponentProps } from "./types";

interface PhishingMessage {
  from?: string;
  displayName?: string;
  subject?: string | null;
  body?: string;
  receivedAt?: string;
  link?: string;
}

export function PhishingIdentificationChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const message = (content.message as PhishingMessage | undefined) ?? {};
  const artifacts = (content.artifacts as { id: string; label: string; text: string }[] | undefined) ?? [];
  const [flagged, setFlagged] = useState<Set<string>>(new Set());

  const toggle = (id: string) =>
    setFlagged((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });

  return (
    <div className="mx-auto max-w-xl space-y-4">
      <div className="border border-border bg-surface-raised/40 p-3 font-mono text-xs">
        <div>
          <span className="text-muted-foreground">From: </span>
          <span className="text-foreground">
            {message.displayName} &lt;{message.from}&gt;
          </span>
        </div>
        {message.subject && (
          <div>
            <span className="text-muted-foreground">Subject: </span>
            <span className="text-foreground">{message.subject}</span>
          </div>
        )}
        {message.receivedAt && (
          <div>
            <span className="text-muted-foreground">Received: </span>
            <span className="text-foreground">{message.receivedAt}</span>
          </div>
        )}
        {message.link && (
          <div>
            <span className="text-muted-foreground">Link: </span>
            <span className="text-foreground">{message.link}</span>
          </div>
        )}
        {message.body && <p className="mt-2 leading-relaxed text-foreground">{message.body}</p>}
      </div>

      <div>
        <span className="label-mono">Flag every element that's a red flag</span>
        <div className="mt-2 flex flex-wrap gap-2">
          {artifacts.map((a) => {
            const active = flagged.has(a.id);
            return (
              <button
                key={a.id}
                type="button"
                onClick={() => toggle(a.id)}
                className={cn(
                  "flex items-center gap-1.5 border px-3 py-1.5 text-left text-xs transition-colors",
                  active
                    ? "border-threat/60 bg-threat/10 text-threat"
                    : "border-border text-muted-foreground hover:border-border/60",
                )}
              >
                <Flag className="h-3 w-3" />
                <span>
                  {a.label}: {a.text}
                </span>
              </button>
            );
          })}
        </div>
      </div>

      <Button
        disabled={flagged.size === 0 || submitting}
        onClick={() => onSubmit({ selectedArtifactIds: Array.from(flagged) })}
      >
        Submit
      </Button>
    </div>
  );
}
