import { useState, type FormEvent } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { Radar, ShieldAlert } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useAuthStore } from "@/store/auth";

export default function LoginPage() {
  const signIn = useAuthStore((s) => s.signIn);
  const navigate = useNavigate();
  const location = useLocation();
  const from = (location.state as { from?: string } | null)?.from ?? "/";

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);

  const onSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setSubmitting(true);
    setError(null);
    const { error } = await signIn(email, password);
    setSubmitting(false);
    if (error) {
      setError(error);
      return;
    }
    navigate(from, { replace: true });
  };

  return (
    <div className="hud-grid flex min-h-screen items-center justify-center px-4">
      <div className="hud-panel corner-cut w-full max-w-sm p-8">
        <div className="flex items-center gap-3">
          <div className="corner-cut grid h-9 w-9 place-items-center bg-primary/15 text-primary glow-signal">
            <Radar className="h-5 w-5" />
          </div>
          <div className="leading-none">
            <div className="font-display text-sm font-bold tracking-[0.22em] text-foreground uppercase">
              Cyber Guardians
            </div>
            <div className="label-mono mt-1">Ops Division // Node 07</div>
          </div>
        </div>

        <h1 className="mt-8 text-xl font-bold text-foreground">Agent sign-in</h1>
        <p className="mt-1 text-sm text-muted-foreground">
          Authenticate to resume your active operations.
        </p>

        <form className="mt-6 space-y-4" onSubmit={onSubmit}>
          <div className="space-y-1.5">
            <Label htmlFor="email" className="label-mono">
              Email
            </Label>
            <Input
              id="email"
              type="email"
              autoComplete="email"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="agent@guardians.dev"
            />
          </div>
          <div className="space-y-1.5">
            <Label htmlFor="password" className="label-mono">
              Password
            </Label>
            <Input
              id="password"
              type="password"
              autoComplete="current-password"
              required
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="••••••••"
            />
          </div>

          {error && (
            <div className="flex items-center gap-2 border border-threat/50 bg-threat/10 px-3 py-2 text-xs text-threat">
              <ShieldAlert className="h-3.5 w-3.5 shrink-0" />
              {error}
            </div>
          )}

          <Button
            type="submit"
            disabled={submitting}
            className="corner-cut w-full glow-signal font-display uppercase tracking-[0.12em]"
          >
            {submitting ? "Authenticating…" : "Sign in"}
          </Button>
        </form>

        <p className="label-mono mt-6 text-center">
          No clearance yet?{" "}
          <Link to="/signup" className="text-primary hover:underline">
            Request access
          </Link>
        </p>
      </div>
    </div>
  );
}
