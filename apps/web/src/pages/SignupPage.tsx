import { useState, type FormEvent } from "react";
import { Link, useNavigate } from "react-router-dom";
import { Radar, ShieldAlert } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useAuthStore } from "@/store/auth";

export default function SignupPage() {
  const signUp = useAuthStore((s) => s.signUp);
  const navigate = useNavigate();

  const [displayName, setDisplayName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);

  const onSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setSubmitting(true);
    setError(null);
    const { error } = await signUp(email, password, displayName);
    setSubmitting(false);
    if (error) {
      setError(error);
      return;
    }
    navigate("/", { replace: true });
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

        <h1 className="mt-8 text-xl font-bold text-foreground">Request clearance</h1>
        <p className="mt-1 text-sm text-muted-foreground">
          Enlist as a recruit. Every agent starts at Clearance I.
        </p>

        <form className="mt-6 space-y-4" onSubmit={onSubmit}>
          <div className="space-y-1.5">
            <Label htmlFor="displayName" className="label-mono">
              Callsign
            </Label>
            <Input
              id="displayName"
              type="text"
              autoComplete="nickname"
              required
              value={displayName}
              onChange={(e) => setDisplayName(e.target.value)}
              placeholder="NOVA"
            />
          </div>
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
              autoComplete="new-password"
              required
              minLength={6}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="At least 6 characters"
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
            {submitting ? "Enlisting…" : "Create account"}
          </Button>
        </form>

        <p className="label-mono mt-6 text-center">
          Already enlisted?{" "}
          <Link to="/login" className="text-primary hover:underline">
            Sign in
          </Link>
        </p>
      </div>
    </div>
  );
}
