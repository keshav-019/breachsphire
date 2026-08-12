import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { AlertTriangle, CheckCircle2, ChevronDown, ChevronUp, MessagesSquare, Send } from "lucide-react";
import { fetchAiInterviews, submitAiInterview } from "@/lib/api";
import { ForgeHeader } from "@/components/backend/ForgeNav";

export default function AiInterviewArenaPage() {
  const queryClient = useQueryClient();
  const [openId, setOpenId] = useState<string | null>(null);
  const [answers, setAnswers] = useState<Record<string, string>>({});
  const { data, isLoading, error } = useQuery({ queryKey: ["ai-interviews"], queryFn: fetchAiInterviews });
  const submit = useMutation({
    mutationFn: ({ id, answer }: { id: string; answer: string }) => submitAiInterview(id, answer),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["ai-interviews"] });
      queryClient.invalidateQueries({ queryKey: ["ai-practice-overview"] });
    },
  });

  if (isLoading) return <div className="px-5 py-8"><span className="label-mono flicker">Loading interview prompts…</span></div>;
  if (error || !data) return <div className="px-5 py-8"><span className="label-mono text-threat">Interview Arena unavailable.</span></div>;
  const attempted = data.filter((question) => question.attemptCount > 0).length;

  return (
    <div className="mx-auto max-w-5xl px-5 py-8">
      <ForgeHeader eyebrow="Interview Arena" title="Explain it. Defend it. Make it precise." description="Answer from first principles, connect the concept to a tradeoff or failure mode, and use the feedback as a rehearsal signal. Reattempts are expected." />
      <div className="mt-7 flex flex-wrap gap-3"><span className="label-mono border border-primary/40 bg-primary/10 px-3 py-2 text-primary">{attempted} / {data.length} practiced</span><span className="label-mono border border-border px-3 py-2">Concepts · production · system design</span></div>

      <section className="mt-6 space-y-3">
        {data.map((question, index) => {
          const open = openId === question.id;
          return (
            <article key={question.id} className="hud-panel corner-cut overflow-hidden">
              <button type="button" onClick={() => setOpenId(open ? null : question.id)} className="flex w-full items-center gap-4 p-5 text-left">
                <span className="grid h-10 w-10 shrink-0 place-items-center border border-primary/40 bg-primary/10 font-mono text-xs text-primary">{String(index + 1).padStart(2, "0")}</span>
                <span className="min-w-0 flex-1"><span className="label-mono text-telemetry">{question.focus}</span><span className="mt-1 block font-display text-base text-foreground">{question.question}</span></span>
                {question.bestScore == null ? <MessagesSquare className="h-5 w-5 text-muted-foreground" /> : <span className="flex items-center gap-1 text-sm text-telemetry"><CheckCircle2 className="h-4 w-4" />{question.bestScore}%</span>}
                {open ? <ChevronUp className="h-5 w-5" /> : <ChevronDown className="h-5 w-5" />}
              </button>
              {open && <div className="border-t border-border p-5">
                <label><span className="label-mono">Your answer</span><textarea value={answers[question.id] ?? ""} onChange={(event) => setAnswers((current) => ({ ...current, [question.id]: event.target.value }))} className="mt-2 min-h-40 w-full resize-y border border-input bg-background/60 p-3 text-sm leading-6 text-foreground outline-none placeholder:text-muted-foreground/60 focus:border-primary" placeholder="Lead with a direct definition, explain the mechanism, then give a tradeoff, failure mode, or concrete example…" /></label>
                {submit.error && submit.variables?.id === question.id && <p className="mt-3 flex items-center gap-2 text-sm text-threat"><AlertTriangle className="h-4 w-4" />{submit.error.message}</p>}
                <button type="button" onClick={() => submit.mutate({ id: question.id, answer: answers[question.id] ?? "" })} disabled={submit.isPending} className="corner-cut mt-4 flex items-center gap-2 bg-primary px-5 py-2.5 font-display text-xs tracking-wider text-primary-foreground uppercase disabled:opacity-50"><Send className="h-4 w-4" />Review answer</button>
                {question.latestAttempt && <div className="mt-5 border border-telemetry/30 bg-telemetry/5 p-4"><div className="flex items-center gap-2"><CheckCircle2 className="h-5 w-5 text-telemetry" /><span className="font-display text-xl text-foreground">Latest: {question.latestAttempt.score}%</span></div><ul className="mt-3 space-y-2">{question.latestAttempt.feedback.map((item) => <li key={item} className="text-sm leading-6 text-muted-foreground">{item}</li>)}</ul></div>}
              </div>}
            </article>
          );
        })}
      </section>
    </div>
  );
}
