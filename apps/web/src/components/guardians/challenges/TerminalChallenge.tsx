import { useEffect, useRef, useState } from "react";
import { Terminal } from "@xterm/xterm";
import { FitAddon } from "@xterm/addon-fit";
import "@xterm/xterm/css/xterm.css";
import type { ChallengeComponentProps } from "./types";
import {
  buildFilesystem,
  isEvidenceIntact,
  type FsNodeSpec,
  type VirtualFilesystem,
} from "@/lib/terminal/fs";
import { buildSubsystems, type SubsystemsSpec, type Subsystems } from "@/lib/terminal/subsystems";
import { runLine, suggestCompletions, type InterpreterState } from "@/lib/terminal/interpreter";

// Named via String.fromCharCode rather than escape-sequence literals
// ("\r", "\x7f", ...) -- those round-tripped incorrectly through prior
// edits in this file (silently became different bytes/text), which made
// Enter/Backspace/Ctrl-C/arrow-key handling silently no-op. This form has
// no ambiguity: it's always exactly the control byte it names.
const KEY_ENTER = String.fromCharCode(13);
const KEY_BACKSPACE = String.fromCharCode(127);
const KEY_BACKSPACE_ALT = String.fromCharCode(8);
const KEY_CTRL_C = String.fromCharCode(3);
const KEY_ESC = String.fromCharCode(27);
const KEY_UP = KEY_ESC + "[A";
const KEY_DOWN = KEY_ESC + "[B";

interface TerminalChallengeContent extends SubsystemsSpec {
  instructions?: string;
  task?: string;
  hostname?: string;
  user?: string;
  isRoot?: boolean;
  homeDir?: string;
  cwd?: string;
  filesystem?: Record<string, FsNodeSpec>;
  protectedPaths?: string[];
  availableCommands?: string[];
}

const THEME = {
  background: "oklch(0.16 0.028 258)",
  foreground: "oklch(0.94 0.012 240)",
  cursor: "oklch(0.78 0.16 68)",
  selectionBackground: "oklch(0.32 0.035 250)",
  green: "oklch(0.78 0.13 190)",
  brightGreen: "oklch(0.78 0.13 190)",
  red: "oklch(0.66 0.21 22)",
  brightRed: "oklch(0.66 0.21 22)",
  yellow: "oklch(0.78 0.16 68)",
  brightYellow: "oklch(0.78 0.16 68)",
};

function displayCwd(fs: VirtualFilesystem): string {
  if (fs.cwd === fs.homeDir) return "~";
  if (fs.cwd.startsWith(fs.homeDir + "/")) return "~" + fs.cwd.slice(fs.homeDir.length);
  return fs.cwd;
}

export function TerminalChallenge({ content, onSubmit, submitting }: ChallengeComponentProps) {
  const c = content as TerminalChallengeContent;
  const containerRef = useRef<HTMLDivElement>(null);
  const termRef = useRef<Terminal | null>(null);
  const fsRef = useRef<VirtualFilesystem | null>(null);
  const subsystemsRef = useRef<Subsystems | null>(null);
  const lineBufferRef = useRef("");
  const historyRef = useRef<string[]>([]);
  const historyIndexRef = useRef(0);
  const submittingRef = useRef(submitting ?? false);
  const [submittedValue, setSubmittedValue] = useState<string | null>(null);

  useEffect(() => {
    submittingRef.current = submitting ?? false;
  }, [submitting]);

  useEffect(() => {
    if (!containerRef.current) return;

    const fs = buildFilesystem(c.filesystem ?? {}, {
      user: c.user ?? "recruit",
      isRoot: c.isRoot ?? false,
      homeDir: c.homeDir,
      cwd: c.cwd,
      protectedPaths: c.protectedPaths,
    });
    const subsystems = buildSubsystems({
      processes: c.processes,
      services: c.services,
      packages: c.packages,
      cron: c.cron,
      journal: c.journal,
      env: c.env,
    });
    fsRef.current = fs;
    subsystemsRef.current = subsystems;

    const hostname = c.hostname ?? "sim-host";
    const availableCommands = c.availableCommands ? new Set(c.availableCommands) : undefined;
    const state: InterpreterState = { fs, subsystems, hostname, availableCommands };

    const term = new Terminal({
      convertEol: true,
      fontSize: 13,
      fontFamily: "ui-monospace, SFMono-Regular, Menlo, Consolas, monospace",
      cursorBlink: true,
      theme: THEME,
      scrollback: 2000,
    });
    const fitAddon = new FitAddon();
    term.loadAddon(fitAddon);
    term.open(containerRef.current);
    termRef.current = term;

    // fit() reads layout/font metrics that aren't reliably available in the
    // same tick term.open() runs in (container can still report zero size),
    // so defer to the next frame instead of fitting synchronously.
    requestAnimationFrame(() => fitAddon.fit());

    const writePrompt = () => {
      term.write(`\r\n${fs.ctx.user}@${hostname}:${displayCwd(fs)}$ `);
    };

    term.writeln(`Connected to ${hostname}. Type 'help' for available commands.`);
    writePrompt();

    term.onData(handleData);

    function handleData(data: string) {
      if (submittingRef.current) return;

      if (data === KEY_ENTER) {
        const line = lineBufferRef.current;
        term.write("\r\n");
        if (line.trim()) {
          historyRef.current.push(line);
          historyIndexRef.current = historyRef.current.length;
        }
        lineBufferRef.current = "";

        const result = runLine(line, state);
        if (result.cleared) {
          term.clear();
          writePrompt();
          return;
        }
        for (const l of result.lines) {
          term.writeln(l.kind === "error" ? `\x1b[31m${l.text}\x1b[0m` : l.text);
        }
        if (result.submitted) {
          const evidencePreserved = isEvidenceIntact(fs);
          setSubmittedValue(result.submitted);
          onSubmit({ flag: result.submitted, evidencePreserved });
          term.writeln(evidencePreserved ? "\x1b[32mFinding recorded.\x1b[0m" : "\x1b[31mFinding recorded — but evidence was altered.\x1b[0m");
        }
        writePrompt();
        return;
      }

      if (data === KEY_BACKSPACE || data === KEY_BACKSPACE_ALT) {
        if (lineBufferRef.current.length > 0) {
          lineBufferRef.current = lineBufferRef.current.slice(0, -1);
          term.write("\b \b");
        }
        return;
      }

      if (data === KEY_CTRL_C) {
        lineBufferRef.current = "";
        term.write("^C");
        writePrompt();
        return;
      }

      if (data === "\t") {
        const partial = lineBufferRef.current.split(" ").pop() ?? "";
        const matches = suggestCompletions(fs, partial);
        if (matches.length === 1) {
          const addition = matches[0].slice(partial.lastIndexOf("/") + 1);
          lineBufferRef.current += addition;
          term.write(addition);
        } else if (matches.length > 1) {
          term.write(`\r\n${matches.join("  ")}`);
          writePrompt();
          term.write(lineBufferRef.current);
        }
        return;
      }

      if (data === KEY_UP) {
        if (historyIndexRef.current > 0) {
          historyIndexRef.current -= 1;
          const entry = historyRef.current[historyIndexRef.current] ?? "";
          term.write("\r\x1b[K" + `${fs.ctx.user}@${hostname}:${displayCwd(fs)}$ ` + entry);
          lineBufferRef.current = entry;
        }
        return;
      }

      if (data === KEY_DOWN) {
        if (historyIndexRef.current < historyRef.current.length) {
          historyIndexRef.current += 1;
          const entry = historyRef.current[historyIndexRef.current] ?? "";
          term.write("\r\x1b[K" + `${fs.ctx.user}@${hostname}:${displayCwd(fs)}$ ` + entry);
          lineBufferRef.current = entry;
        }
        return;
      }

      if (data.charCodeAt(0) < 32) return;

      lineBufferRef.current += data;
      term.write(data);
    }

    const handleResize = () => fitAddon.fit();
    window.addEventListener("resize", handleResize);

    return () => {
      window.removeEventListener("resize", handleResize);
      term.dispose();
      termRef.current = null;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const instructions = c.instructions ?? c.task;

  return (
    <div className="mx-auto max-w-3xl space-y-3">
      {instructions && <p className="text-sm leading-relaxed text-foreground">{instructions}</p>}
      <div className="border border-border bg-background/80 p-2">
        <div ref={containerRef} className="h-80 w-full" />
      </div>
      {submittedValue && (
        <p className="label-mono text-[0.7rem] text-telemetry">Last submission: {submittedValue}</p>
      )}
    </div>
  );
}
