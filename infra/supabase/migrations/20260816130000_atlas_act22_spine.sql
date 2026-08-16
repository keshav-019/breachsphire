-- Atlas Division pathway ("The Silence"): Act row for World VII -- "The
-- Signal Tower" -- plus the World row for its first Act, "Git Becomes
-- Reality" (GitOps). Content (missions) follows in its own migration,
-- same two-step pattern as every prior World.
--
-- Narrative thread: Act 21's transition_hook set this up directly --
-- "what happens once git itself becomes the only thing anyone has to
-- touch at all." Rook wires the entire fleet to a real GitOps
-- controller, reconciling live cluster state to git continuously. The
-- very first real test comes almost by accident: Vey, under real
-- pressure from a genuine traffic spike, makes a fast manual kubectl
-- edit instead of a git commit -- and the controller reverts it within
-- a minute, exactly as designed. This is GitOps' actual promise
-- holding for the first time, not a malfunction -- Rook's own domain
-- ("developer platforms, golden paths, GitOps") come full circle from
-- his Act 4 debut.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-atlas-7', 6, 'the-signal-tower', 'World VII -- The Signal Tower',
   'Every manual fix across this entire story -- Act 9''s zombie fleet, Act 14''s drift, Act 19''s storage class, Act 21''s certificate -- shared one root cause: nothing was ever actually enforcing that changes go through the same trusted path every time. Rook wires the whole cluster to a real GitOps controller, reconciling live state to git continuously, so a manual shortcut can no longer quietly become the new normal. The player learns GitOps, observability and everything Atlas Division actually needs to trust this infrastructure at scale.',
   'Can operate and troubleshoot a Kubernetes cluster directly -> understands GitOps and observability well enough to trust infrastructure without touching it by hand',
   'pathway-atlas');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-git-becomes-reality', 'act-atlas-7', 21, 'git-becomes-reality', 'Git Becomes Reality', 'Git Becomes Reality',
   'Desired state; reconciliation; GitOps principles; Argo CD concepts; Flux concepts; manifests; environment repos; drift detection; auto sync; rollback via Git; secrets.',
   'Real load spikes hard against the collector fleet, and Vey, on call and out of patience, does what this entire story has done a dozen times before -- makes a fast, direct kubectl edit to fix it immediately. One minute later, the change is gone.',
   'Unauthorized Change',
   'Nothing broke, and nobody made a mistake worth apologizing for. Argo CD''s selfHeal did exactly what it was configured to do -- detected a live change that did not come from git, and reverted it automatically, the same way it would revert any drift, on purpose, without waiting for anyone to notice. Vey needed more replicas. He just never got the chance to actually say so in git before the cluster corrected itself back to what git still declared.',
   'For the first time in this entire story, a manual shortcut genuinely does not stick -- only a git commit does. The next question is whether anyone would even notice if it stopped working the way this fleet actually needs it to, since nobody is watching it by hand anymore.',
   'Unauthorized Change', 'RadioTower', 'guarded', 104, 12, 'pathway-atlas');
