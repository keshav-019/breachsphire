/**
 * In-memory virtual filesystem for the Type A terminal simulation
 * (docs/05-lab-system.md). Mission `content.filesystem` authors a flat map
 * of absolute path -> FsNodeSpec (missing parent dirs are created
 * automatically) rather than a nested tree, since that's far easier to
 * author as a single JSON object in a migration's `content` column.
 *
 * Nothing here persists or touches the network — a fresh VirtualFilesystem
 * is built client-side per challenge mount and discarded on unmount.
 */

export interface FsNodeSpec {
  type: "file" | "dir";
  content?: string;
  mode?: string;
  owner?: string;
  group?: string;
}

export interface FsNode {
  type: "file" | "dir";
  name: string;
  path: string;
  content: string;
  mode: string;
  owner: string;
  group: string;
  children: Map<string, FsNode>;
}

export interface FsContext {
  user: string;
  isRoot: boolean;
}

export interface VirtualFilesystem {
  root: FsNode;
  cwd: string;
  homeDir: string;
  protectedPaths: Set<string>;
  tamperedPaths: Set<string>;
  ctx: FsContext;
}

export interface BuildFilesystemOptions {
  user?: string;
  isRoot?: boolean;
  homeDir?: string;
  cwd?: string;
  protectedPaths?: string[];
}

function makeNode(type: "file" | "dir", name: string, path: string, spec?: Omit<FsNodeSpec, "type">): FsNode {
  return {
    type,
    name,
    path,
    content: spec?.content ?? "",
    mode: spec?.mode ?? (type === "dir" ? "755" : "644"),
    owner: spec?.owner ?? "root",
    group: spec?.group ?? spec?.owner ?? "root",
    children: new Map(),
  };
}

export function normalizePath(path: string): string {
  if (path === "") return "/";
  const absolute = path.startsWith("/");
  const parts = path.split("/").filter((p) => p.length > 0 && p !== ".");
  const stack: string[] = [];
  for (const part of parts) {
    if (part === "..") {
      if (stack.length > 0) stack.pop();
    } else {
      stack.push(part);
    }
  }
  const joined = "/" + stack.join("/");
  if (!absolute) return joined;
  return joined;
}

export function resolvePath(fs: VirtualFilesystem, input: string): string {
  let path = input.trim();
  if (path === "" ) path = ".";
  if (path === "~" || path.startsWith("~/")) {
    path = fs.homeDir + path.slice(1);
  }
  const absolute = path.startsWith("/") ? path : `${fs.cwd}/${path}`;
  return normalizePath(absolute);
}

export function buildFilesystem(spec: Record<string, FsNodeSpec>, options: BuildFilesystemOptions = {}): VirtualFilesystem {
  const root = makeNode("dir", "/", "/");

  function ensureDir(path: string): FsNode {
    if (path === "/") return root;
    const segments = path.split("/").filter(Boolean);
    let current = root;
    let currentPath = "";
    for (const seg of segments) {
      currentPath += `/${seg}`;
      let child = current.children.get(seg);
      if (!child) {
        child = makeNode("dir", seg, currentPath);
        current.children.set(seg, child);
      }
      current = child;
    }
    return current;
  }

  const entries = Object.entries(spec).sort((a, b) => a[0].length - b[0].length);
  for (const [rawPath, nodeSpec] of entries) {
    const path = normalizePath(rawPath);
    if (path === "/") continue;
    const parentPath = path.slice(0, path.lastIndexOf("/")) || "/";
    const name = path.slice(path.lastIndexOf("/") + 1);
    const parent = ensureDir(parentPath);
    if (nodeSpec.type === "dir") {
      const existing = parent.children.get(name);
      const node = existing ?? makeNode("dir", name, path, nodeSpec);
      node.mode = nodeSpec.mode ?? node.mode;
      node.owner = nodeSpec.owner ?? node.owner;
      node.group = nodeSpec.group ?? node.owner ?? node.group;
      parent.children.set(name, node);
    } else {
      parent.children.set(name, makeNode("file", name, path, nodeSpec));
    }
  }

  const user = options.user ?? "recruit";
  return {
    root,
    cwd: options.cwd ? normalizePath(options.cwd) : "/",
    homeDir: options.homeDir ?? `/home/${user}`,
    protectedPaths: new Set((options.protectedPaths ?? []).map(normalizePath)),
    tamperedPaths: new Set(),
    ctx: { user, isRoot: options.isRoot ?? false },
  };
}

export function getNode(fs: VirtualFilesystem, path: string): FsNode | undefined {
  const abs = resolvePath(fs, path);
  if (abs === "/") return fs.root;
  const segments = abs.split("/").filter(Boolean);
  let current: FsNode | undefined = fs.root;
  for (const seg of segments) {
    if (!current || current.type !== "dir") return undefined;
    current = current.children.get(seg);
  }
  return current;
}

function modeDigit(node: FsNode, ctx: FsContext): number {
  if (ctx.isRoot) return 7;
  const digits = node.mode.padStart(3, "0").slice(-3);
  const idx = ctx.user === node.owner ? 0 : 2;
  return Number(digits[idx] ?? "0");
}

export function canRead(node: FsNode, ctx: FsContext): boolean {
  return (modeDigit(node, ctx) & 4) !== 0;
}

export function canWrite(node: FsNode, ctx: FsContext): boolean {
  return (modeDigit(node, ctx) & 2) !== 0;
}

export function canExecute(node: FsNode, ctx: FsContext): boolean {
  return (modeDigit(node, ctx) & 1) !== 0;
}

export function listChildren(node: FsNode): FsNode[] {
  return Array.from(node.children.values()).sort((a, b) => a.name.localeCompare(b.name));
}

export interface FsResult {
  ok: boolean;
  error?: string;
  node?: FsNode;
}

export function readFile(fs: VirtualFilesystem, path: string): FsResult {
  const node = getNode(fs, path);
  if (!node) return { ok: false, error: `cat: ${path}: No such file or directory` };
  if (node.type === "dir") return { ok: false, error: `cat: ${path}: Is a directory` };
  if (!canRead(node, fs.ctx)) return { ok: false, error: `cat: ${path}: Permission denied` };
  return { ok: true, node };
}

export function writeFile(fs: VirtualFilesystem, path: string, content: string, append: boolean): FsResult {
  const abs = resolvePath(fs, path);
  const existing = getNode(fs, abs);
  if (existing?.type === "dir") return { ok: false, error: `${path}: Is a directory` };
  if (existing && !canWrite(existing, fs.ctx)) return { ok: false, error: `${path}: Permission denied` };
  if (existing && fs.protectedPaths.has(abs)) fs.tamperedPaths.add(abs);

  const parentPath = abs.slice(0, abs.lastIndexOf("/")) || "/";
  const parent = getNode(fs, parentPath);
  if (!parent || parent.type !== "dir") return { ok: false, error: `${path}: No such file or directory` };
  const name = abs.slice(abs.lastIndexOf("/") + 1);

  if (existing) {
    existing.content = append ? existing.content + content : content;
  } else {
    const node = makeNode("file", name, abs, { content, owner: fs.ctx.user });
    parent.children.set(name, node);
  }
  return { ok: true };
}

export function makeDir(fs: VirtualFilesystem, path: string): FsResult {
  const abs = resolvePath(fs, path);
  if (getNode(fs, abs)) return { ok: false, error: `mkdir: cannot create directory '${path}': File exists` };
  const parentPath = abs.slice(0, abs.lastIndexOf("/")) || "/";
  const parent = getNode(fs, parentPath);
  if (!parent || parent.type !== "dir") {
    return { ok: false, error: `mkdir: cannot create directory '${path}': No such file or directory` };
  }
  const name = abs.slice(abs.lastIndexOf("/") + 1);
  parent.children.set(name, makeNode("dir", name, abs, { owner: fs.ctx.user }));
  return { ok: true };
}

export function removeNode(fs: VirtualFilesystem, path: string, recursive: boolean): FsResult {
  const abs = resolvePath(fs, path);
  if (abs === "/") return { ok: false, error: "rm: refusing to remove '/'" };
  const node = getNode(fs, abs);
  if (!node) return { ok: false, error: `rm: cannot remove '${path}': No such file or directory` };
  if (node.type === "dir" && node.children.size > 0 && !recursive) {
    return { ok: false, error: `rm: cannot remove '${path}': Is a directory (use -r)` };
  }
  const parentPath = abs.slice(0, abs.lastIndexOf("/")) || "/";
  const parent = getNode(fs, parentPath);
  if (!parent || parent.type !== "dir") return { ok: false, error: `rm: cannot remove '${path}'` };
  if (fs.protectedPaths.has(abs)) fs.tamperedPaths.add(abs);
  parent.children.delete(node.name);
  return { ok: true };
}

export function chmod(fs: VirtualFilesystem, path: string, mode: string): FsResult {
  const node = getNode(fs, path);
  if (!node) return { ok: false, error: `chmod: cannot access '${path}': No such file or directory` };
  if (!/^[0-7]{3,4}$/.test(mode)) return { ok: false, error: `chmod: invalid mode: '${mode}'` };
  node.mode = mode.slice(-3);
  return { ok: true };
}

export function chown(fs: VirtualFilesystem, path: string, owner: string, group?: string): FsResult {
  const node = getNode(fs, path);
  if (!node) return { ok: false, error: `chown: cannot access '${path}': No such file or directory` };
  node.owner = owner;
  if (group) node.group = group;
  return { ok: true };
}

export function isEvidenceIntact(fs: VirtualFilesystem): boolean {
  return fs.tamperedPaths.size === 0;
}

export function formatModeString(node: FsNode): string {
  const digits = node.mode.padStart(3, "0").slice(-3);
  const triad = (d: string) => {
    const n = Number(d);
    return `${n & 4 ? "r" : "-"}${n & 2 ? "w" : "-"}${n & 1 ? "x" : "-"}`;
  };
  const typeChar = node.type === "dir" ? "d" : "-";
  return `${typeChar}${triad(digits[0])}${triad(digits[1])}${triad(digits[2])}`;
}
