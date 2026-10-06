const WINDOW_MS = 15 * 60 * 1000;
const MAX_FAILURES = 10;

/**
 * In-memory brake on password guessing: after MAX_FAILURES failed sign-ins
 * for the same email from the same IP within WINDOW_MS, further attempts are
 * refused until the window passes. Per-process only, which is fine for the
 * single API container this runs as.
 */
export class LoginThrottle {
  private failures = new Map<string, number[]>();

  private recent(key: string, now: number) {
    const kept = (this.failures.get(key) ?? []).filter((t) => now - t < WINDOW_MS);
    if (kept.length) this.failures.set(key, kept);
    else this.failures.delete(key);
    return kept;
  }

  /** Seconds until the caller may retry, or 0 if not blocked. */
  retryAfter(key: string, now = Date.now()) {
    const kept = this.recent(key, now);
    return kept.length >= MAX_FAILURES ? Math.ceil((kept[0] + WINDOW_MS - now) / 1000) : 0;
  }

  fail(key: string, now = Date.now()) {
    this.failures.set(key, [...this.recent(key, now), now]);
  }

  succeed(key: string) {
    this.failures.delete(key);
  }
}
