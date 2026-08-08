/**
 * Strips answer-revealing fields from a challenge's `content` before it's
 * sent to a player. `content` and `completionConditions` are meant to be
 * a clean split (Phase 2.5: the client never sees `completionConditions`
 * at all) but two of the World 0 challenge types were authored with the
 * answer embedded directly in `content` instead — `isMalicious`/
 * `explanation` per phishing artifact, `isFake`/`note` per browser-sim
 * page. A network-tab read of the mission-detail response would trivially
 * solve those without the redaction here.
 *
 * Redacting at this boundary (not scrubbing the stored rows) keeps the
 * authored explanations available for a future debrief/admin view — they
 * have real value there, just not before the player has answered.
 */
export function redactChallengeContent(type: string, content: unknown): unknown {
  if (type === "phishing_identification" && isPlainRecord(content) && Array.isArray(content.artifacts)) {
    return {
      ...content,
      artifacts: content.artifacts.map((artifact) => {
        if (!isPlainRecord(artifact)) return artifact;
        const { isMalicious: _isMalicious, explanation: _explanation, ...rest } = artifact;
        return rest;
      }),
    };
  }

  if (type === "browser_simulation" && isPlainRecord(content) && Array.isArray(content.pages)) {
    return {
      ...content,
      pages: content.pages.map((page) => {
        if (!isPlainRecord(page)) return page;
        const { isFake: _isFake, note: _note, ...rest } = page;
        return rest;
      }),
    };
  }

  return content;
}

function isPlainRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}
