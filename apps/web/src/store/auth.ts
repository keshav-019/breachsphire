import { create } from "zustand";
import * as authClient from "@/lib/auth-client";
import type { AuthUser, Session } from "@/lib/auth-client";

export type AuthStatus = "loading" | "authenticated" | "unauthenticated";

interface AuthState {
  status: AuthStatus;
  session: Session | null;
  user: AuthUser | null;
  error: string | null;
  init: () => void;
  signIn: (email: string, password: string) => Promise<{ error: string | null }>;
  signUp: (
    email: string,
    password: string,
    displayName: string,
  ) => Promise<{ error: string | null }>;
  signOut: () => Promise<void>;
}

let initialized = false;

function fromSession(session: Session | null) {
  return {
    session,
    user: session?.user ?? null,
    status: (session ? "authenticated" : "unauthenticated") as AuthStatus,
  };
}

function errorMessage(error: unknown) {
  return error instanceof Error ? error.message : "Could not reach the sign-in service";
}

export const useAuthStore = create<AuthState>((set) => ({
  status: "loading",
  session: null,
  user: null,
  error: null,

  init: () => {
    if (initialized) return;
    initialized = true;

    set(fromSession(authClient.getSession()));
    authClient.onSessionChange((session) => set(fromSession(session)));
  },

  signIn: async (email, password) => {
    try {
      await authClient.signIn(email, password);
      set({ error: null });
      return { error: null };
    } catch (error) {
      set({ error: errorMessage(error) });
      return { error: errorMessage(error) };
    }
  },

  signUp: async (email, password, displayName) => {
    try {
      await authClient.signUp(email, password, displayName);
      set({ error: null });
      return { error: null };
    } catch (error) {
      set({ error: errorMessage(error) });
      return { error: errorMessage(error) };
    }
  },

  signOut: async () => {
    await authClient.signOut();
  },
}));
