import { apiUrl } from "./api-base";

/**
 * Session handling against the API's /auth endpoints. The session lives in
 * localStorage, is shared across tabs via
 * the storage event, and the access token is refreshed shortly before it
 * expires.
 */

export interface AuthUser {
  id: string;
  email: string;
  displayName: string;
}

export interface Session {
  accessToken: string;
  refreshToken: string;
  /** Access token expiry, Unix seconds. */
  expiresAt: number;
  user: AuthUser;
}

const STORAGE_KEY = "breachsphire.session";
const REFRESH_MARGIN_SECONDS = 60;

type Listener = (session: Session | null) => void;
const listeners = new Set<Listener>();

function isSession(value: unknown): value is Session {
  const s = value as Session | null;
  return (
    !!s &&
    typeof s.accessToken === "string" &&
    typeof s.refreshToken === "string" &&
    typeof s.expiresAt === "number" &&
    typeof s.user?.id === "string"
  );
}

function load(): Session | null {
  try {
    const parsed: unknown = JSON.parse(localStorage.getItem(STORAGE_KEY) ?? "null");
    return isSession(parsed) ? parsed : null;
  } catch {
    return null;
  }
}

let current: Session | null = load();

function setSession(next: Session | null) {
  current = next;
  try {
    if (next) localStorage.setItem(STORAGE_KEY, JSON.stringify(next));
    else localStorage.removeItem(STORAGE_KEY);
  } catch {
    // Storage unavailable (private mode etc.): the session lives in memory only.
  }
  listeners.forEach((listener) => listener(next));
}

window.addEventListener("storage", (event) => {
  if (event.key !== STORAGE_KEY) return;
  current = load();
  listeners.forEach((listener) => listener(current));
});

export function getSession() {
  return current;
}

export function onSessionChange(listener: Listener) {
  listeners.add(listener);
  return () => {
    listeners.delete(listener);
  };
}

export class AuthError extends Error {
  constructor(
    message: string,
    readonly status: number,
  ) {
    super(message);
  }
}

async function post(path: string, body: unknown): Promise<Response> {
  return fetch(apiUrl(path), {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });
}

async function readSession(res: Response): Promise<Session> {
  if (!res.ok) {
    let message = `Sign-in service responded with ${res.status}`;
    try {
      const body = (await res.json()) as { message?: string | string[] };
      const text = Array.isArray(body.message) ? body.message.join(" ") : body.message;
      if (text) message = text;
    } catch {
      // keep the generic message
    }
    throw new AuthError(message, res.status);
  }
  const session: unknown = await res.json();
  if (!isSession(session)) {
    throw new AuthError("Sign-in service returned an unexpected response", res.status);
  }
  return session;
}

export async function signIn(email: string, password: string) {
  setSession(await readSession(await post("/auth/login", { email, password })));
}

export async function signUp(email: string, password: string, displayName: string) {
  setSession(await readSession(await post("/auth/signup", { email, password, displayName })));
}

export async function signOut() {
  const refreshToken = current?.refreshToken;
  setSession(null);
  if (refreshToken) {
    // Best effort: the local session is already gone either way.
    await post("/auth/logout", { refreshToken }).catch(() => undefined);
  }
}

let refreshing: Promise<void> | null = null;

function refresh() {
  refreshing ??= (async () => {
    const refreshToken = current?.refreshToken;
    if (!refreshToken) return;
    try {
      setSession(await readSession(await post("/auth/refresh", { refreshToken })));
    } catch (error) {
      // Rejected token: the session is over. Network errors keep the
      // session so a later call can retry.
      if (error instanceof AuthError && error.status === 401) setSession(null);
    }
  })().finally(() => {
    refreshing = null;
  });
  return refreshing;
}

/** A valid access token, refreshing first if it is about to expire. */
export async function getAccessToken(): Promise<string | null> {
  if (!current) return null;
  if (current.expiresAt - Date.now() / 1000 < REFRESH_MARGIN_SECONDS) {
    await refresh();
  }
  return current?.accessToken ?? null;
}

/** Called when the API rejects a token we believed valid. */
export function handleUnauthorized() {
  setSession(null);
}
