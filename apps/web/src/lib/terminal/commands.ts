/**
 * Command registry for the simulated shell. Each command is a pure-ish
 * function operating on the shared VirtualFilesystem/Subsystems instances
 * for this challenge mount. `args` are the raw tokens after the command
 * name; `stdin` is the previous pipeline stage's stdout (empty array if
 * this is the first stage) — mirrors real shell pipe semantics closely
 * enough for the puzzles these missions need (grep/wc/sort reading either
 * stdin or a file argument).
 */

import {
  canExecute,
  chmod as fsChmod,
  chown as fsChown,
  formatModeString,
  getNode,
  listChildren,
  makeDir,
  normalizePath,
  readFile,
  removeNode,
  resolvePath,
  writeFile,
  type FsNode,
  type VirtualFilesystem,
} from "./fs";
import { killProcess, serviceAction, type Subsystems } from "./subsystems";

export interface CommandContext {
  fs: VirtualFilesystem;
  subsystems: Subsystems;
  hostname: string;
}

export interface CommandResult {
  stdout: string[];
  stderr: string[];
  exitCode: number;
}

export type CommandFn = (args: string[], stdin: string[], ctx: CommandContext) => CommandResult;

function ok(stdout: string[]): CommandResult {
  return { stdout, stderr: [], exitCode: 0 };
}

/** A file "a\nb\n" is 2 lines, not 3 -- drop the trailing empty element a
 * split on a terminating newline otherwise produces. */
function fileLines(content: string): string[] {
  const lines = content.split("\n");
  if (lines.length > 0 && lines[lines.length - 1] === "") lines.pop();
  return lines;
}

function fail(stderr: string[]): CommandResult {
  return { stdout: [], stderr, exitCode: 1 };
}

interface ParsedArgs {
  flags: Set<string>;
  values: Record<string, string>;
  positional: string[];
}

function parseArgs(args: string[], valuedFlags: string[] = []): ParsedArgs {
  const flags = new Set<string>();
  const values: Record<string, string> = {};
  const positional: string[] = [];
  for (let i = 0; i < args.length; i++) {
    const arg = args[i];
    if (arg.startsWith("--")) {
      const name = arg.slice(2);
      if (valuedFlags.includes(name)) {
        values[name] = args[++i] ?? "";
      } else {
        flags.add(name);
      }
    } else if (arg.startsWith("-") && arg.length > 1) {
      for (const ch of arg.slice(1)) {
        if (valuedFlags.includes(ch)) {
          values[ch] = args[++i] ?? "";
        } else {
          flags.add(ch);
        }
      }
    } else {
      positional.push(arg);
    }
  }
  return { flags, values, positional };
}

function walk(node: FsNode, prefix: string, out: FsNode[]): void {
  out.push(node);
  if (node.type === "dir") {
    for (const child of listChildren(node)) walk(child, `${prefix}/${child.name}`, out);
  }
}

const MAN_PAGES: Record<string, string[]> = {
  pwd: ["pwd - print the current working directory"],
  cd: ["cd [dir] - change the current directory. cd ~ or cd with no args goes home."],
  ls: ["ls [-l] [-a] [-R] [path] - list directory contents. -l long form, -a show hidden, -R recursive."],
  cat: ["cat file [file...] - print file contents"],
  head: ["head [-n N] file - print the first N lines (default 10)"],
  tail: ["tail [-n N] file - print the last N lines (default 10)"],
  file: ["file path - guess the type of a file"],
  wc: ["wc [-l] [-w] [-c] file - count lines, words, bytes"],
  find: ["find [path] [-name pattern] [-type f|d] - search the filesystem"],
  grep: ["grep [-i] [-v] [-r] pattern [file...] - search text, -i ignore case, -v invert, -r recursive"],
  echo: ["echo [text...] - print text"],
  whoami: ["whoami - print the current user"],
  id: ["id - print user and group identity"],
  history: ["history - list previously run commands"],
  chmod: ["chmod MODE path - change permission bits, e.g. chmod 644 file"],
  chown: ["chown OWNER[:GROUP] path - change file ownership"],
  ps: ["ps [aux] - list running processes"],
  kill: ["kill PID - terminate a process by pid"],
  top: ["top - snapshot of running processes"],
  systemctl: ["systemctl {status|start|stop|restart|enable|disable|list-units} [unit] - manage services"],
  journalctl: ["journalctl [-u unit] [-n N] - query the system journal"],
  du: ["du [path] - estimate file/directory space usage"],
  df: ["df - report filesystem disk space"],
  free: ["free - display memory usage"],
  env: ["env - print environment variables"],
  export: ["export NAME=value - set an environment variable"],
  crontab: ["crontab -l - list the current user's scheduled jobs"],
  dpkg: ["dpkg -l - list installed packages and their versions"],
  sed: ["sed 's/find/replace/[g]' [file] - substitute text, first match or all with g"],
  awk: ["awk '{print $N[,$M...]}' [file] - print whitespace-separated fields by position"],
  ss: ["ss - list network connections and their state"],
  netstat: ["netstat - list network connections and their state (alias for ss)"],
  nmap: ["nmap <host> - scan a host and report open ports, protocols and service banners"],
  whois: ["whois <domain> - print public registration records for a domain"],
  dig: ["dig <domain> - query DNS records for a domain"],
  nslookup: ["nslookup <domain> - query DNS records for a domain (alias for dig)"],
  submit: ["submit <value> - report a finding to close out this objective"],
  man: ["man command - show the manual page for a command"],
};

export const COMMANDS: Record<string, CommandFn> = {
  pwd: (_args, _stdin, ctx) => ok([ctx.fs.cwd]),

  cd: (args, _stdin, ctx) => {
    const target = args[0] ? resolvePath(ctx.fs, args[0]) : ctx.fs.homeDir;
    const node = getNode(ctx.fs, target);
    if (!node) return fail([`cd: ${args[0]}: No such file or directory`]);
    if (node.type !== "dir") return fail([`cd: ${args[0]}: Not a directory`]);
    if (!canExecute(node, ctx.fs.ctx)) return fail([`cd: ${args[0]}: Permission denied`]);
    ctx.fs.cwd = node.path;
    return ok([]);
  },

  ls: (args, _stdin, ctx) => {
    const { flags, positional } = parseArgs(args);
    const targetPath = positional[0] ?? ctx.fs.cwd;
    const node = getNode(ctx.fs, targetPath);
    if (!node) return fail([`ls: cannot access '${targetPath}': No such file or directory`]);

    const render = (n: FsNode, indent = ""): string[] => {
      const entries = listChildren(n).filter((c) => flags.has("a") || !c.name.startsWith("."));
      const lines: string[] = [];
      for (const entry of entries) {
        if (flags.has("l")) {
          lines.push(
            `${indent}${formatModeString(entry)} ${entry.owner.padEnd(8)} ${entry.group.padEnd(8)} ${entry.type === "dir" ? "-" : String(entry.content.length).padStart(5)} ${entry.name}${entry.type === "dir" ? "/" : ""}`,
          );
        } else {
          lines.push(`${indent}${entry.name}${entry.type === "dir" ? "/" : ""}`);
        }
      }
      if (flags.has("R")) {
        for (const entry of entries.filter((e) => e.type === "dir")) {
          lines.push(`${indent}${entry.path}:`);
          lines.push(...render(entry, indent));
        }
      }
      return lines;
    };

    if (node.type === "file") return ok([node.name]);
    return ok(render(node));
  },

  cat: (args, stdin, ctx) => {
    if (args.length === 0) return ok(stdin);
    const out: string[] = [];
    const errs: string[] = [];
    for (const path of args) {
      const result = readFile(ctx.fs, path);
      if (!result.ok || !result.node) {
        errs.push(result.error!);
        continue;
      }
      out.push(...fileLines(result.node.content));
    }
    return { stdout: out, stderr: errs, exitCode: errs.length ? 1 : 0 };
  },

  head: (args, stdin, ctx) => {
    const { values, positional } = parseArgs(args, ["n"]);
    const n = Number(values.n ?? 10);
    const lines = positional[0] ? readFile(ctx.fs, positional[0]) : undefined;
    if (positional[0] && (!lines?.ok || !lines.node)) return fail([lines?.error ?? "head: error"]);
    const source = positional[0] ? fileLines(lines!.node!.content) : stdin;
    return ok(source.slice(0, n));
  },

  tail: (args, stdin, ctx) => {
    const { values, positional } = parseArgs(args, ["n"]);
    const n = Number(values.n ?? 10);
    const lines = positional[0] ? readFile(ctx.fs, positional[0]) : undefined;
    if (positional[0] && (!lines?.ok || !lines.node)) return fail([lines?.error ?? "tail: error"]);
    const source = positional[0] ? fileLines(lines!.node!.content) : stdin;
    return ok(source.slice(-n));
  },

  file: (args, _stdin, ctx) => {
    if (!args[0]) return fail(["file: missing operand"]);
    const node = getNode(ctx.fs, args[0]);
    if (!node) return fail([`file: cannot open '${args[0]}' (No such file or directory)`]);
    if (node.type === "dir") return ok([`${args[0]}: directory`]);
    const looksBinary = /[^\x09\x0a\x0d\x20-\x7e]/.test(node.content.slice(0, 200));
    return ok([`${args[0]}: ${looksBinary ? "data" : "ASCII text"}`]);
  },

  wc: (args, stdin, ctx) => {
    const { flags, positional } = parseArgs(args);
    const content = positional[0] ? readFile(ctx.fs, positional[0]) : undefined;
    if (positional[0] && (!content?.ok || !content.node)) return fail([content?.error ?? "wc: error"]);
    const lines = positional[0] ? fileLines(content!.node!.content) : stdin;
    const text = lines.join("\n");
    const nLines = lines.length;
    const nWords = text.split(/\s+/).filter(Boolean).length;
    const nChars = text.length;
    const parts: string[] = [];
    if (flags.has("l") || flags.size === 0) parts.push(String(nLines));
    if (flags.has("w") || flags.size === 0) parts.push(String(nWords));
    if (flags.has("c") || flags.size === 0) parts.push(String(nChars));
    return ok([`${parts.join(" ")}${positional[0] ? ` ${positional[0]}` : ""}`]);
  },

  find: (args, _stdin, ctx) => {
    const startPath = args[0] && !args[0].startsWith("-") ? args[0] : ".";
    const start = getNode(ctx.fs, startPath);
    if (!start) return fail([`find: '${startPath}': No such file or directory`]);
    const nameIdx = args.indexOf("-name");
    const namePattern = nameIdx >= 0 ? args[nameIdx + 1] : undefined;
    const typeIdx = args.indexOf("-type");
    const typeFilter = typeIdx >= 0 ? args[typeIdx + 1] : undefined;

    const all: FsNode[] = [];
    walk(start, start.path, all);
    const regex = namePattern
      ? new RegExp("^" + namePattern.replace(/[.+^${}()|[\]\\]/g, "\\$&").replace(/\*/g, ".*") + "$")
      : undefined;
    const results = all.filter((n) => {
      if (regex && !regex.test(n.name)) return false;
      if (typeFilter === "f" && n.type !== "file") return false;
      if (typeFilter === "d" && n.type !== "dir") return false;
      return true;
    });
    return ok(results.map((n) => n.path));
  },

  grep: (args, stdin, ctx) => {
    const { flags, positional } = parseArgs(args);
    const pattern = positional[0];
    if (!pattern) return fail(["grep: missing pattern"]);
    const files = positional.slice(1);
    const regex = new RegExp(pattern, flags.has("i") ? "i" : "");

    const matchLines = (lines: string[], label?: string): string[] =>
      lines
        .filter((line) => (flags.has("v") ? !regex.test(line) : regex.test(line)))
        .map((line) => (label ? `${label}:${line}` : line));

    if (files.length === 0) return ok(matchLines(stdin));

    const out: string[] = [];
    const errs: string[] = [];
    for (const path of files) {
      const node = getNode(ctx.fs, path);
      if (!node) {
        errs.push(`grep: ${path}: No such file or directory`);
        continue;
      }
      if (node.type === "dir") {
        if (!flags.has("r")) {
          errs.push(`grep: ${path}: Is a directory`);
          continue;
        }
        const all: FsNode[] = [];
        walk(node, node.path, all);
        for (const f of all.filter((n) => n.type === "file")) {
          out.push(...matchLines(fileLines(f.content), files.length > 1 || flags.has("r") ? f.path : undefined));
        }
      } else {
        out.push(...matchLines(fileLines(node.content), files.length > 1 ? path : undefined));
      }
    }
    return { stdout: out, stderr: errs, exitCode: errs.length ? 1 : 0 };
  },

  echo: (args) => ok([args.join(" ")]),

  whoami: (_args, _stdin, ctx) => ok([ctx.fs.ctx.user]),

  id: (_args, _stdin, ctx) => ok([`uid=1000(${ctx.fs.ctx.user}) gid=1000(${ctx.fs.ctx.user}) groups=1000(${ctx.fs.ctx.user})`]),

  history: () => ok([]),

  chmod: (args, _stdin, ctx) => {
    const [mode, path] = args;
    if (!mode || !path) return fail(["chmod: missing operand"]);
    const result = fsChmod(ctx.fs, path, mode);
    return result.ok ? ok([]) : fail([result.error!]);
  },

  chown: (args, _stdin, ctx) => {
    const [spec, path] = args;
    if (!spec || !path) return fail(["chown: missing operand"]);
    const [owner, group] = spec.split(":");
    const result = fsChown(ctx.fs, path, owner, group);
    return result.ok ? ok([]) : fail([result.error!]);
  },

  mkdir: (args, _stdin, ctx) => {
    if (!args[0]) return fail(["mkdir: missing operand"]);
    const result = makeDir(ctx.fs, args[0]);
    return result.ok ? ok([]) : fail([result.error!]);
  },

  rm: (args, _stdin, ctx) => {
    const { flags, positional } = parseArgs(args);
    if (!positional[0]) return fail(["rm: missing operand"]);
    const result = removeNode(ctx.fs, positional[0], flags.has("r") || flags.has("R"));
    return result.ok ? ok([]) : fail([result.error!]);
  },

  ps: (args, _stdin, ctx) => {
    const rows = Array.from(ctx.subsystems.processes.values());
    const header = "USER       PID  CMD";
    const lines = rows.map((p) => `${p.user.padEnd(10)} ${String(p.pid).padStart(4)}  ${p.cmd}`);
    return ok([header, ...lines]);
  },

  top: (args, stdin, ctx) => COMMANDS.ps(args, stdin, ctx),

  netstat: (args, stdin, ctx) => COMMANDS.ss(args, stdin, ctx),

  kill: (args, _stdin, ctx) => {
    const pidArg = args.find((a) => !a.startsWith("-"));
    const pid = Number(pidArg);
    if (!pidArg || Number.isNaN(pid)) return fail(["kill: usage: kill pid"]);
    const result = killProcess(ctx.subsystems, pid);
    return result.ok ? ok([]) : fail([result.error!]);
  },

  systemctl: (args, _stdin, ctx) => {
    const [action, unit] = args;
    if (action === "list-units") {
      const rows = Array.from(ctx.subsystems.services.values());
      return ok(["UNIT               STATUS", ...rows.map((s) => `${s.name.padEnd(18)} ${s.status}`)]);
    }
    if (action === "status") {
      const svc = ctx.subsystems.services.get(unit);
      if (!svc) return fail([`Unit ${unit}.service could not be found.`]);
      return ok([
        `${svc.name}.service - ${svc.description ?? ""}`,
        `   Active: ${svc.status}${svc.enabled ? " (enabled)" : ""}`,
      ]);
    }
    if (["start", "stop", "restart", "enable", "disable"].includes(action)) {
      const result = serviceAction(ctx.subsystems, unit, action as "start" | "stop" | "restart" | "enable" | "disable");
      return result.ok ? ok([]) : fail([result.error!]);
    }
    return fail([`systemctl: unknown action '${action}'`]);
  },

  journalctl: (args, _stdin, ctx) => {
    const { values } = parseArgs(args, ["u", "n"]);
    let entries = ctx.subsystems.journal;
    if (values.u) entries = entries.filter((e) => e.unit === values.u);
    if (values.n) entries = entries.slice(-Number(values.n));
    return ok(entries.map((e) => `${e.timestamp} ${e.unit ? e.unit + ": " : ""}${e.message}`));
  },

  du: (args, _stdin, ctx) => {
    const target = getNode(ctx.fs, args[0] ?? ctx.fs.cwd);
    if (!target) return fail([`du: cannot access '${args[0]}': No such file or directory`]);
    const all: FsNode[] = [];
    walk(target, target.path, all);
    const total = all.filter((n) => n.type === "file").reduce((sum, n) => sum + n.content.length, 0);
    return ok([`${Math.max(1, Math.ceil(total / 1024))}K\t${target.path}`]);
  },

  df: () => ok(["Filesystem     Size  Used  Avail  Use%  Mounted on", "sim-root       20G   4.1G  15.9G   21%  /"]),

  free: () => ok(["              total        used        free", "Mem:        4096000     512000     3584000"]),

  env: (_args, _stdin, ctx) => ok(Object.entries(ctx.subsystems.env).map(([k, v]) => `${k}=${v}`)),

  export: (args, _stdin, ctx) => {
    const [assignment] = args;
    const eq = assignment?.indexOf("=") ?? -1;
    if (!assignment || eq < 0) return fail(["export: usage: export NAME=value"]);
    ctx.subsystems.env[assignment.slice(0, eq)] = assignment.slice(eq + 1);
    return ok([]);
  },

  crontab: (args, _stdin, ctx) => {
    if (args[0] !== "-l") return fail(["crontab: usage: crontab -l"]);
    if (ctx.subsystems.cron.length === 0) return ok(["no crontab for " + ctx.fs.ctx.user]);
    return ok(ctx.subsystems.cron.map((c) => `${c.schedule}  ${c.command}`));
  },

  dpkg: (args, _stdin, ctx) => {
    if (args[0] !== "-l") return fail(["dpkg: usage: dpkg -l"]);
    const header = "Name                 Version";
    return ok([header, ...ctx.subsystems.packages.map((p) => `${p.name.padEnd(20)} ${p.version}`)]);
  },

  sed: (args, stdin, ctx) => {
    const { positional } = parseArgs(args);
    const expr = positional[0];
    const filePath = positional[1];
    const match = expr?.match(/^s\/(.*?)\/(.*?)\/(g)?$/);
    if (!match) return fail(["sed: unsupported expression (only s/find/replace/ or s/find/replace/g is supported)"]);
    const [, find, replace, global] = match;
    const regex = new RegExp(find, global ? "g" : "");
    const file = filePath ? readFile(ctx.fs, filePath) : undefined;
    if (filePath && (!file?.ok || !file.node)) return fail([file?.error ?? "sed: error"]);
    const lines = filePath ? fileLines(file!.node!.content) : stdin;
    return ok(lines.map((line) => line.replace(regex, replace)));
  },

  awk: (args, stdin, ctx) => {
    const { values, positional } = parseArgs(args, ["F"]);
    const sep = values.F ? new RegExp(values.F) : /\s+/;
    const program = positional[0];
    const filePath = positional[1];
    const match = program?.match(/^\{\s*print\s+(.+?)\s*\}$/);
    if (!match) return fail(["awk: unsupported program (only '{print $N[,$M...]}' is supported)"]);
    const fieldExprs = match[1].split(",").map((s) => s.trim());
    const file = filePath ? readFile(ctx.fs, filePath) : undefined;
    if (filePath && (!file?.ok || !file.node)) return fail([file?.error ?? "awk: error"]);
    const lines = filePath ? fileLines(file!.node!.content) : stdin;
    return ok(
      lines.map((line) => {
        const fields = line.split(sep);
        return fieldExprs
          .map((expr) => {
            const n = Number(expr.replace("$", ""));
            return n === 0 ? line : (fields[n - 1] ?? "");
          })
          .join(" ");
      }),
    );
  },

  ss: (_args, _stdin, ctx) => {
    const header = "Proto  Local Address:Port    State        Process";
    const rows = ctx.subsystems.connections.map(
      (c) => `${c.proto.padEnd(6)} ${`${c.localAddress}:${c.localPort}`.padEnd(22)} ${c.state.padEnd(12)} ${c.process ?? ""}`,
    );
    return ok([header, ...rows]);
  },

  nmap: (args, _stdin, ctx) => {
    const host = args.find((a) => !a.startsWith("-"));
    if (!host) return fail(["nmap: usage: nmap <host>"]);
    const target = ctx.subsystems.scanTargets.find((t) => t.host === host);
    if (!target) return fail([`nmap: no route to host ${host}`]);
    const lines = [`Nmap scan report for ${target.host}`, "PORT      STATE  SERVICE      BANNER"];
    for (const p of target.ports) {
      lines.push(
        `${`${p.port}/${p.proto}`.padEnd(9)} ${(p.state ?? "open").padEnd(6)} ${p.service.padEnd(12)} ${p.banner ?? ""}`,
      );
    }
    return ok(lines);
  },

  whois: (args, _stdin, ctx) => {
    const domain = args[0];
    if (!domain) return fail(["whois: usage: whois <domain>"]);
    const record = ctx.subsystems.whoisRecords.find((r) => r.domain === domain);
    if (!record) return fail([`whois: no match for domain ${domain}`]);
    return ok(record.lines);
  },

  dig: (args, _stdin, ctx) => {
    const domain = args.find((a) => !a.startsWith("-"));
    if (!domain) return fail(["dig: usage: dig <domain>"]);
    const record = ctx.subsystems.dnsRecords.find((r) => r.domain === domain);
    if (!record) return ok([`;; connection timed out; no servers could be reached for ${domain}`]);
    return ok(record.records.map((r) => `${domain}.  IN  ${r.type}  ${r.value}`));
  },

  nslookup: (args, stdin, ctx) => COMMANDS.dig(args, stdin, ctx),

  man: (args) => {
    const page = MAN_PAGES[args[0]];
    if (!page) return fail([`No manual entry for ${args[0]}`]);
    return ok(page);
  },

  help: () =>
    ok([
      "Available commands:",
      Object.keys(MAN_PAGES).sort().join("  "),
      "Type 'man <command>' for details.",
    ]),
};

export { normalizePath };
