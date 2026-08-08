/**
 * Line interpreter for the simulated shell: quote-aware tokenizer, `|`
 * pipeline threading, `>`/`>>` redirection into the virtual filesystem, and
 * the `submit`/`done` builtins a terminal_simulation challenge uses to hand
 * a finding back to React (see TerminalChallenge.tsx).
 */

import { COMMANDS, type CommandContext } from "./commands";
import { getNode, listChildren, resolvePath, writeFile, type VirtualFilesystem } from "./fs";
import type { Subsystems } from "./subsystems";

export interface InterpreterState {
  fs: VirtualFilesystem;
  subsystems: Subsystems;
  hostname: string;
  availableCommands?: Set<string>;
}

export interface TerminalLine {
  kind: "output" | "error";
  text: string;
}

export interface RunResult {
  lines: TerminalLine[];
  submitted?: string;
  cleared?: boolean;
}

const ALWAYS_AVAILABLE = new Set(["help", "man", "clear", "history", "submit", "done"]);

export function tokenize(line: string): string[] {
  const tokens: string[] = [];
  let current = "";
  let quote: string | null = null;
  for (let i = 0; i < line.length; i++) {
    const ch = line[i];
    if (quote) {
      if (ch === quote) {
        quote = null;
      } else {
        current += ch;
      }
      continue;
    }
    if (ch === '"' || ch === "'") {
      quote = ch;
      continue;
    }
    if (ch === " " || ch === "\t") {
      if (current) {
        tokens.push(current);
        current = "";
      }
      continue;
    }
    if (ch === "|" || ch === ">") {
      if (current) {
        tokens.push(current);
        current = "";
      }
      if (ch === ">" && line[i + 1] === ">") {
        tokens.push(">>");
        i++;
      } else {
        tokens.push(ch);
      }
      continue;
    }
    current += ch;
  }
  if (current) tokens.push(current);
  return tokens;
}

export function runLine(raw: string, state: InterpreterState): RunResult {
  const trimmed = raw.trim();
  if (!trimmed) return { lines: [] };
  const tokens = tokenize(trimmed);

  const stages: string[][] = [[]];
  for (const t of tokens) {
    if (t === "|") stages.push([]);
    else stages[stages.length - 1].push(t);
  }

  let redirectTarget: string | undefined;
  let redirectAppend = false;
  const lastStage = stages[stages.length - 1];
  const redirIdx = lastStage.findIndex((t) => t === ">" || t === ">>");
  if (redirIdx >= 0) {
    redirectAppend = lastStage[redirIdx] === ">>";
    redirectTarget = lastStage[redirIdx + 1];
    stages[stages.length - 1] = lastStage.slice(0, redirIdx);
  }

  let stdin: string[] = [];
  const stderrAll: string[] = [];
  const ctx: CommandContext = { fs: state.fs, subsystems: state.subsystems, hostname: state.hostname };

  for (const stage of stages) {
    if (stage.length === 0) continue;
    const [cmdName, ...args] = stage;

    if (cmdName === "clear") return { lines: [], cleared: true };
    if (cmdName === "submit" || cmdName === "done") {
      const value = args.join(" ");
      return {
        lines: [{ kind: "output", text: value ? `Submitted: ${value}` : "Nothing to submit — try again with a value." }],
        submitted: value || undefined,
      };
    }

    if (state.availableCommands && !ALWAYS_AVAILABLE.has(cmdName) && !state.availableCommands.has(cmdName)) {
      stderrAll.push(`${cmdName}: not available on this system`);
      stdin = [];
      continue;
    }

    const fn = COMMANDS[cmdName];
    if (!fn) {
      stderrAll.push(`${cmdName}: command not found`);
      stdin = [];
      continue;
    }

    const result = fn(args, stdin, ctx);
    stdin = result.stdout;
    stderrAll.push(...result.stderr);
  }

  if (redirectTarget) {
    writeFile(state.fs, redirectTarget, stdin.join("\n") + (stdin.length ? "\n" : ""), redirectAppend);
    stdin = [];
  }

  return {
    lines: [
      ...stdin.map((text): TerminalLine => ({ kind: "output", text })),
      ...stderrAll.map((text): TerminalLine => ({ kind: "error", text })),
    ],
  };
}

export function suggestCompletions(fs: VirtualFilesystem, partial: string): string[] {
  const lastSlash = partial.lastIndexOf("/");
  const dirPart = lastSlash >= 0 ? partial.slice(0, lastSlash) || "/" : ".";
  const namePart = lastSlash >= 0 ? partial.slice(lastSlash + 1) : partial;
  const dirNode = getNode(fs, resolvePath(fs, dirPart));
  if (!dirNode || dirNode.type !== "dir") return [];
  return listChildren(dirNode)
    .filter((c) => c.name.startsWith(namePart))
    .map((c) => (lastSlash >= 0 ? `${dirPart}/${c.name}` : c.name) + (c.type === "dir" ? "/" : ""));
}
