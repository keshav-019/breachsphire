-- Atlas Division pathway ("The Silence"): World row for Act 21,
-- "Kubernetes Operations", closing act-atlas-6 ("World VI -- The
-- Cluster Sea", Acts 17-21, confirmed via the doc's own "# WORLD VII"
-- heading appearing only after this Act's boss). Content (missions)
-- follows in its own migration.
--
-- Narrative thread: directly answering Act 20's crash-loop incident,
-- Rook builds a validating admission webhook that rejects any
-- Deployment missing real resource limits -- then, during a routine
-- cluster upgrade, that webhook's own TLS certificate quietly expires,
-- and its fail-closed policy blocks every deployment cluster-wide.
-- Closes this World's whole throughline: every safety net this story
-- has built (Act 12's Lambda, Act 18's NetworkPolicy, now this
-- webhook) needs its own maintenance, or it becomes exactly the single
-- point of failure it was built to prevent.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-kubernetes-operations', 'act-atlas-6', 20, 'kubernetes-operations', 'Kubernetes Operations', 'Kubernetes Operations',
   'Helm; Charts; values; Kustomize; RBAC; ServiceAccounts; admission concepts; autoscaling; upgrades; node maintenance; troubleshooting.',
   'Rook deploys a validating admission webhook that rejects any Deployment missing real resource limits -- a direct answer to Act 20''s crash loop. During the next routine cluster upgrade, every single deployment attempt starts failing, cluster-wide, with no obvious reason.',
   'The Broken Cluster',
   'The webhook is not malfunctioning -- it is doing exactly what fail-closed means. Its own TLS certificate, issued the day it was first deployed, quietly expired, and rather than risk letting an unvalidated Deployment through, the API server rejects everything until the webhook can actually be reached again. The safety net built specifically to catch the last incident became the incident, because nothing was watching its own certificate.',
   'Every safety mechanism this cluster runs -- webhooks, policies, autoscalers -- is finally understood well enough to actually maintain, not just deploy once and trust. Everything since Act 10 has assumed infrastructure someone has to reach out and touch. The next question is what happens once git itself becomes the only thing anyone has to touch at all.',
   'The Broken Cluster', 'ShieldAlert', 'critical', 92, 44, 'pathway-atlas');
