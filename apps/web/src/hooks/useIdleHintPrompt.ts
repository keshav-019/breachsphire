import { useCallback, useEffect, useRef, useState } from "react";

export const HINT_IDLE_DELAY_MS = 45_000;

type UseIdleHintPromptOptions = {
  challengeId?: string;
  enabled: boolean;
  delayMs?: number;
};

export function useIdleHintPrompt({
  challengeId,
  enabled,
  delayMs = HINT_IDLE_DELAY_MS,
}: UseIdleHintPromptOptions) {
  const timerRef = useRef<number | null>(null);
  const [visible, setVisible] = useState(false);

  const clearTimer = useCallback(() => {
    if (timerRef.current !== null) {
      window.clearTimeout(timerRef.current);
      timerRef.current = null;
    }
  }, []);

  const schedule = useCallback(() => {
    clearTimer();

    if (!enabled || !challengeId) {
      setVisible(false);
      return;
    }

    timerRef.current = window.setTimeout(() => {
      setVisible(true);
      timerRef.current = null;
    }, delayMs);
  }, [challengeId, clearTimer, delayMs, enabled]);

  useEffect(() => {
    setVisible(false);
    schedule();
    return clearTimer;
  }, [challengeId, clearTimer, schedule]);

  const noteActivity = useCallback(() => {
    setVisible(false);
    schedule();
  }, [schedule]);

  return {
    visible,
    noteActivity,
    dismiss: noteActivity,
  };
}
