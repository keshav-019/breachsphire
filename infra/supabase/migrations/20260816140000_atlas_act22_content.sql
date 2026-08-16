-- Atlas Division pathway ("The Silence") Act 22 -- "Git Becomes
-- Reality" content, under world-atlas-git-becomes-reality (already
-- inserted separately). 1 campaign, 2 operations, 12 missions (11
-- lessons + boss), opening World VII "The Signal Tower".
--
-- Same terminal-engine constraint as every prior Atlas Act -- every
-- GitOps artifact here is static seeded text read via `cat`. Two
-- hosts: the reused `atlas-devbox-01` for the environment repo itself
-- (manifests, sealed secrets), and a new `atlas-gitops-01` for the
-- Argo CD controller's own live state (Application status, sync
-- history, drift diffs). Purely conceptual topics with no natural
-- artifact (desired state, GitOps principles, Flux concepts, rollback
-- via Git) stay multiple_choice.
--
-- Narrative thread: mission 9 (auto sync) plants selfHeal as a concept
-- before the boss makes it real. The boss is this pathway's first
-- genuinely positive validation of a brand-new safety mechanism
-- (matching Act 8's pattern, not Act 12/18/20/21's "safety net needed
-- maintenance" pattern) -- Vey's well-intentioned manual fix under
-- real pressure gets automatically reverted within a minute, and the
-- investigation deliberately requires both the mechanism (sync
-- history) and the human context (why Vey did it) to land the actual
-- lesson: intent has to go through git, no matter how urgent it feels,
-- and that discipline is enforced now, automatically, for the first
-- time in this entire story.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-git-becomes-reality', 'world-atlas-git-becomes-reality', 'git-becomes-reality', '7A - Git Becomes Reality', 'Learn GitOps from first principles -- desired state, reconciliation, GitOps principles, Argo CD concepts, Flux concepts, manifests, environment repos, drift detection, auto sync, rollback via Git and secrets -- while Vey''s own manual shortcut becomes the first real test of whether any of it actually holds.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-git-becomes-reality-1', 'campaign-atlas-git-becomes-reality', 'the-repo-is-the-truth-now', 'The Repo Is the Truth Now', 'Desired state, reconciliation, GitOps principles, Argo CD concepts and Flux concepts.', 1),
  ('operation-atlas-git-becomes-reality-2', 'campaign-atlas-git-becomes-reality', 'proving-the-shortcut-does-not-stick', 'Proving the Shortcut Does Not Stick', 'Manifests, environment repos, drift detection, auto sync, rollback via Git and secrets.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-git-becomes-reality-01', 'world-atlas-git-becomes-reality', 'campaign-atlas-git-becomes-reality', 'operation-atlas-git-becomes-reality-1', 'desired-state', 'Desired State', 'Real load spikes hard against the collector fleet, and Vey does what this entire story has done a dozen times before.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"desired-state-sim"}'::jsonb, '{"xp":440,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-git-becomes-reality-02', 'world-atlas-git-becomes-reality', 'campaign-atlas-git-becomes-reality', 'operation-atlas-git-becomes-reality-1', 'reconciliation', 'Reconciliation', 'Understand what actually keeps comparing reality to git, continuously, without anyone triggering it.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-git-becomes-reality-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"reconciliation-sim"}'::jsonb, '{"xp":440,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-git-becomes-reality-03', 'world-atlas-git-becomes-reality', 'campaign-atlas-git-becomes-reality', 'operation-atlas-git-becomes-reality-1', 'gitops-principles', 'GitOps Principles', 'Understand exactly what makes this different from just running kubectl apply from a script.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-git-becomes-reality-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"gitops-principles-sim"}'::jsonb, '{"xp":450,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-git-becomes-reality-04', 'world-atlas-git-becomes-reality', 'campaign-atlas-git-becomes-reality', 'operation-atlas-git-becomes-reality-1', 'argo-cd-concepts', 'Argo CD Concepts', 'Confirm exactly what this Application actually watches, and where it deploys to.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-git-becomes-reality-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"argo-cd-concepts-sim"}'::jsonb, '{"xp":450,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-git-becomes-reality-05', 'world-atlas-git-becomes-reality', 'campaign-atlas-git-becomes-reality', 'operation-atlas-git-becomes-reality-1', 'flux-concepts', 'Flux Concepts', 'Understand what a different GitOps controller offers, without needing to switch to it.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-git-becomes-reality-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"flux-concepts-sim"}'::jsonb, '{"xp":460,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-git-becomes-reality-06', 'world-atlas-git-becomes-reality', 'campaign-atlas-git-becomes-reality', 'operation-atlas-git-becomes-reality-2', 'manifests', 'Manifests', 'Confirm every manifest this cluster actually runs now lives in exactly one place.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-git-becomes-reality-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"manifests-sim"}'::jsonb, '{"xp":460,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-git-becomes-reality-07', 'world-atlas-git-becomes-reality', 'campaign-atlas-git-becomes-reality', 'operation-atlas-git-becomes-reality-2', 'environment-repos', 'Environment Repos', 'Confirm how dev, staging and production each stay isolated from each other''s changes.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-git-becomes-reality-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"environment-repos-sim"}'::jsonb, '{"xp":460,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-git-becomes-reality-08', 'world-atlas-git-becomes-reality', 'campaign-atlas-git-becomes-reality', 'operation-atlas-git-becomes-reality-2', 'drift-detection', 'Drift Detection', 'Confirm exactly how the controller actually knows live state has stopped matching git.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-git-becomes-reality-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"drift-detection-sim"}'::jsonb, '{"xp":470,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-git-becomes-reality-09', 'world-atlas-git-becomes-reality', 'campaign-atlas-git-becomes-reality', 'operation-atlas-git-becomes-reality-2', 'auto-sync', 'Auto Sync', 'Confirm what actually happens the moment drift like that is detected, without anyone approving it.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-git-becomes-reality-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"auto-sync-sim"}'::jsonb, '{"xp":470,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-git-becomes-reality-10', 'world-atlas-git-becomes-reality', 'campaign-atlas-git-becomes-reality', 'operation-atlas-git-becomes-reality-2', 'rollback-via-git', 'Rollback via Git', 'Understand what actually undoes a bad release now, and what command never has to run again to do it.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-git-becomes-reality-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"rollback-via-git-sim"}'::jsonb, '{"xp":480,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-git-becomes-reality-11', 'world-atlas-git-becomes-reality', 'campaign-atlas-git-becomes-reality', 'operation-atlas-git-becomes-reality-2', 'secrets-gitops', 'Secrets', 'Confirm what actually makes it safe to commit this to a public-facing repo at all.', 'beginner', ARRAY['rook','cross'], '{"requiredMissionIds":["mission-atlas-git-becomes-reality-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"secrets-gitops-sim"}'::jsonb, '{"xp":480,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-git-becomes-reality-12', 'world-atlas-git-becomes-reality', 'campaign-atlas-git-becomes-reality', 'operation-atlas-git-becomes-reality-2', 'unauthorized-change', 'Unauthorized Change', 'Everything this Act taught, turned on one vanished fix: not to panic and reapply it by hand again, to finally explain why a manual change genuinely does not stick here anymore.', 'boss', ARRAY['rook','vey','cross','leena'], '{"requiredMissionIds":["mission-atlas-git-becomes-reality-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"unauthorized-change-boss-sim"}'::jsonb, '{"xp":720,"credits":170,"badgeIds":["unauthorized-change"],"skillXp":{"cloud_devops_fundamentals":115}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-git-becomes-reality-01', 1, 'leena', 'Real load just spiked hard against the collector fleet, and Vey did what this entire story has done a dozen times before -- a fast, direct kubectl edit to fix it immediately.'),
  ('mission-atlas-git-becomes-reality-01', 2, 'rook', 'Rook. GitOps starts with one idea: git is the single source of truth for what should be running -- desired state, written down, versioned, reviewable. Not a memory of what someone meant to do.'),

  ('mission-atlas-git-becomes-reality-02', 1, 'rook', 'A controller does not wait to be told. It continuously compares what git actually declares against what is actually running, and corrects the difference on its own, on a loop, forever.'),

  ('mission-atlas-git-becomes-reality-03', 1, 'rook', 'A script that runs kubectl apply is still someone deciding when to run it. GitOps means the cluster itself is always pulling toward whatever git currently says, with nobody having to remember to trigger anything.'),

  ('mission-atlas-git-becomes-reality-04', 1, 'rook', 'An Argo CD Application ties one specific git path to one specific destination cluster and namespace. Confirm exactly what this one is actually watching.'),

  ('mission-atlas-git-becomes-reality-05', 1, 'rook', 'Flux is a different GitOps controller, same core principles, different implementation. Understanding it is not about switching -- it is about recognizing the pattern anywhere it shows up.'),

  ('mission-atlas-git-becomes-reality-06', 1, 'rook', 'Every manifest this cluster actually runs -- every Deployment, every Service, everything from Acts 17 through 21 -- lives in exactly one place now. Confirm it.'),

  ('mission-atlas-git-becomes-reality-07', 1, 'rook', 'Dev, staging and production each get their own directory, watched by their own Application, so a change meant for one never accidentally reaches another. Confirm how this is actually organized.'),

  ('mission-atlas-git-becomes-reality-08', 1, 'cross', 'Imani Cross. Confirm exactly how the controller actually knows live state has stopped matching what git declares -- not by guessing, by diffing.'),

  ('mission-atlas-git-becomes-reality-09', 1, 'rook', 'Detecting drift is only half of it. Confirm what actually happens the moment drift like that is found, automatically, without anyone approving a thing.'),

  ('mission-atlas-git-becomes-reality-10', 1, 'rook', 'A bad release does not need a special rollback procedure anymore. Revert the commit, and the controller reconciles the cluster right back to whatever git says now -- the exact same mechanism as any other change.'),

  ('mission-atlas-git-becomes-reality-11', 1, 'cross', 'Nothing here changes the rule Act 6 already set -- no plaintext secret ever belongs in git, committed or not. Confirm what actually makes this one safe to commit at all.'),

  ('mission-atlas-git-becomes-reality-12', 1, 'leena', 'Everything this Act taught you, on one vanished fix. Not to panic and reapply it by hand again -- to finally explain why a manual change genuinely does not stick here anymore.'),
  ('mission-atlas-git-becomes-reality-12', 2, 'vey', 'Tomas Vey. I bumped the replica count directly, to handle a real spike, meant to actually write it into git right after -- and then got pulled into something else. One minute later, it was back to 2.'),
  ('mission-atlas-git-becomes-reality-12', 3, 'byte', 'I have the sync history and the current status both pulled up together. Nothing in this cluster is broken.'),
  ('mission-atlas-git-becomes-reality-12', 4, 'rook', 'Confirm exactly what actually happened to that change, and say plainly why this was never a bug.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-git-becomes-reality-01-o1', 'mission-atlas-git-becomes-reality-01', 1, 'Explain desired state', 'Choose the accurate description of what desired state actually means in GitOps.'),

  ('mission-atlas-git-becomes-reality-02-o1', 'mission-atlas-git-becomes-reality-02', 1, 'Explain reconciliation', 'Choose the accurate description of what a reconciliation loop actually does.'),

  ('mission-atlas-git-becomes-reality-03-o1', 'mission-atlas-git-becomes-reality-03', 1, 'Explain GitOps principles', 'Choose the accurate description of what actually distinguishes GitOps from a deploy script.'),

  ('mission-atlas-git-becomes-reality-04-o1', 'mission-atlas-git-becomes-reality-04', 1, 'Read the Argo CD Application', 'Read the Application definition and submit the verification code.'),

  ('mission-atlas-git-becomes-reality-05-o1', 'mission-atlas-git-becomes-reality-05', 1, 'Explain Flux concepts', 'Choose the accurate description of what Flux offers as an alternative GitOps controller.'),

  ('mission-atlas-git-becomes-reality-06-o1', 'mission-atlas-git-becomes-reality-06', 1, 'Read the manifest directory', 'Read the manifest directory listing and submit the verification code.'),

  ('mission-atlas-git-becomes-reality-07-o1', 'mission-atlas-git-becomes-reality-07', 1, 'Read the environment repo layout', 'Read the environment repo README and submit the verification code.'),

  ('mission-atlas-git-becomes-reality-08-o1', 'mission-atlas-git-becomes-reality-08', 1, 'Read the drift diff', 'Read the sync status and submit the verification code.'),

  ('mission-atlas-git-becomes-reality-09-o1', 'mission-atlas-git-becomes-reality-09', 1, 'Read the sync policy', 'Read the sync policy and submit the verification code.'),

  ('mission-atlas-git-becomes-reality-10-o1', 'mission-atlas-git-becomes-reality-10', 1, 'Explain rollback via Git', 'Choose the accurate description of how a rollback actually happens under GitOps.'),

  ('mission-atlas-git-becomes-reality-11-o1', 'mission-atlas-git-becomes-reality-11', 1, 'Read the sealed secret', 'Read the sealed secret and submit the verification code.'),

  ('mission-atlas-git-becomes-reality-12-o1', 'mission-atlas-git-becomes-reality-12', 1, 'Confirm the auto-revert', 'Read the sync history and submit the verification code.'),
  ('mission-atlas-git-becomes-reality-12-o2', 'mission-atlas-git-becomes-reality-12', 2, 'Confirm the current state', 'Read the current sync status and submit the verification code.'),
  ('mission-atlas-git-becomes-reality-12-o3', 'mission-atlas-git-becomes-reality-12', 3, 'Identify what actually explains this', 'Find the evidence that explains why the manual change disappeared.'),
  ('mission-atlas-git-becomes-reality-12-o4', 'mission-atlas-git-becomes-reality-12', 4, 'State the diagnosis', 'Having confirmed all three, explain why this was never a bug.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-git-becomes-reality-01-o1-c1', 'mission-atlas-git-becomes-reality-01-o1', 1, 'multiple_choice', 'Desired state in GitOps actually means...', '{"question":"Desired state in GitOps actually means...","options":[{"id":"a","text":"Git is the single source of truth describing what should be running, versioned and reviewable, rather than whatever someone last remembered to apply"},{"id":"b","text":"Whatever is currently running in the cluster, regardless of what git says"},{"id":"c","text":"A one-time snapshot taken when the cluster was first created"},{"id":"d","text":"A synonym for a Kubernetes namespace"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-git-becomes-reality-02-o1-c1', 'mission-atlas-git-becomes-reality-02-o1', 1, 'multiple_choice', 'A reconciliation loop actually does what?', '{"question":"A reconciliation loop actually does what?","options":[{"id":"a","text":"Continuously compares desired state in git against actual live state, and corrects any difference automatically, on a loop"},{"id":"b","text":"Runs exactly once, when the Application is first created"},{"id":"c","text":"Only runs when a human explicitly triggers a sync"},{"id":"d","text":"Only detects drift, but never corrects it"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-git-becomes-reality-03-o1-c1', 'mission-atlas-git-becomes-reality-03-o1', 1, 'multiple_choice', 'GitOps actually differs from a deploy script that runs kubectl apply in that...', '{"question":"GitOps actually differs from a deploy script that runs kubectl apply in that...","options":[{"id":"a","text":"The cluster itself continuously pulls toward whatever git currently declares, without anyone having to remember to trigger anything"},{"id":"b","text":"They are functionally identical in every way"},{"id":"c","text":"GitOps only works for stateless workloads"},{"id":"d","text":"A deploy script is always safer than GitOps"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-git-becomes-reality-04-o1-c1', 'mission-atlas-git-becomes-reality-04-o1', 1, 'terminal_simulation', 'Read the Application definition and submit the verification code.', '{"instructions":"Read /var/atlas-gitops/argocd-application.yaml and submit the verification code with: submit CODE","hostname":"atlas-gitops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-gitops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-gitops/argocd-application.yaml":{"type":"file","content":"apiVersion: argoproj.io/v1alpha1\nkind: Application\nmetadata:\n  name: atlas-collector\nspec:\n  source:\n    repoURL: https://git.atlas.internal/infra-envs.git\n    path: environments/eu-west\n  destination:\n    server: https://atlas-cluster.internal\n    namespace: atlas-metrics\n  syncPolicy:\n    automated:\n      prune: true\n      selfHeal: true\n# verification ARGOCD-3312\n"}}}'::jsonb, '{"requiredFlag":"ARGOCD-3312"}'::jsonb),

  ('mission-atlas-git-becomes-reality-05-o1-c1', 'mission-atlas-git-becomes-reality-05-o1', 1, 'multiple_choice', 'Flux, as a GitOps controller, actually offers...', '{"question":"Flux, as a GitOps controller, actually offers...","options":[{"id":"a","text":"The same core GitOps principles as Argo CD -- pulling desired state from git and reconciling the cluster to match -- through a different implementation"},{"id":"b","text":"A completely different, incompatible model with no relation to desired state or reconciliation"},{"id":"c","text":"Only manual, human-triggered deployments"},{"id":"d","text":"A replacement for git itself"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-git-becomes-reality-06-o1-c1', 'mission-atlas-git-becomes-reality-06-o1', 1, 'terminal_simulation', 'Read the manifest directory listing and submit the verification code.', '{"instructions":"Read /repo/infra-envs/environments/eu-west/structure.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/environments/eu-west/structure.txt":{"type":"file","content":"environments/eu-west/\n  collector-deployment.yaml\n  collector-service.yaml\n  collector-hpa.yaml\n# every manifest this cluster runs now lives here, in git, not hand-applied\n# verification MANIFESTS-6602\n"}}}'::jsonb, '{"requiredFlag":"MANIFESTS-6602"}'::jsonb),

  ('mission-atlas-git-becomes-reality-07-o1-c1', 'mission-atlas-git-becomes-reality-07-o1', 1, 'terminal_simulation', 'Read the environment repo README and submit the verification code.', '{"instructions":"Read /repo/infra-envs/README.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/README.txt":{"type":"file","content":"environments/\n  dev/\n  staging/\n  eu-west/   (production)\n  us-east/   (production)\neach environment has its own Argo CD Application watching only its own directory\n# verification ENVREPOS-7714\n"}}}'::jsonb, '{"requiredFlag":"ENVREPOS-7714"}'::jsonb),

  ('mission-atlas-git-becomes-reality-08-o1-c1', 'mission-atlas-git-becomes-reality-08-o1', 1, 'terminal_simulation', 'Read the sync status and submit the verification code.', '{"instructions":"Read /var/atlas-gitops/sync-status.txt and submit the verification code with: submit CODE","hostname":"atlas-gitops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-gitops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-gitops/sync-status.txt":{"type":"file","content":"Application: atlas-collector\nSync Status: OutOfSync\nHealth Status: Healthy\ndiff: replicas  git=2  live=5\n# live state has drifted from what git actually declares\n# verification DRIFT-4471\n"}}}'::jsonb, '{"requiredFlag":"DRIFT-4471"}'::jsonb),

  ('mission-atlas-git-becomes-reality-09-o1-c1', 'mission-atlas-git-becomes-reality-09-o1', 1, 'terminal_simulation', 'Read the sync policy and submit the verification code.', '{"instructions":"Read /var/atlas-gitops/sync-policy.txt and submit the verification code with: submit CODE","hostname":"atlas-gitops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-gitops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-gitops/sync-policy.txt":{"type":"file","content":"syncPolicy:\n  automated:\n    prune: true\n    selfHeal: true\n# selfHeal means any manual change to the live cluster is automatically reverted back to match git, without anyone asking\n# verification AUTOSYNC-8802\n"}}}'::jsonb, '{"requiredFlag":"AUTOSYNC-8802"}'::jsonb),

  ('mission-atlas-git-becomes-reality-10-o1-c1', 'mission-atlas-git-becomes-reality-10-o1', 1, 'multiple_choice', 'A rollback under GitOps actually happens by...', '{"question":"A rollback under GitOps actually happens by...","options":[{"id":"a","text":"Reverting the git commit -- the controller reconciles the cluster back to whatever git now declares, the same mechanism as any other change"},{"id":"b","text":"Running a special, separate rollback command that bypasses the controller entirely"},{"id":"c","text":"Manually recreating the previous version''s resources by hand"},{"id":"d","text":"Rollbacks are not possible once a change has synced"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-git-becomes-reality-11-o1-c1', 'mission-atlas-git-becomes-reality-11-o1', 1, 'terminal_simulation', 'Read the sealed secret and submit the verification code.', '{"instructions":"Read /repo/infra-envs/environments/eu-west/sealed-secret.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/environments/eu-west/sealed-secret.yaml":{"type":"file","content":"apiVersion: bitnami.com/v1alpha1\nkind: SealedSecret\nmetadata:\n  name: collector-db-creds\nspec:\n  encryptedData:\n    password: AgBy8hCiOaX9nR2m...\n# safe to commit to git -- encrypted at rest in the repo itself, not just base64 like a plain Secret\n# verification SEALEDSECRET-9012\n"}}}'::jsonb, '{"requiredFlag":"SEALEDSECRET-9012"}'::jsonb),

  ('mission-atlas-git-becomes-reality-12-o1-c1', 'mission-atlas-git-becomes-reality-12-o1', 1, 'terminal_simulation', 'Read the sync history and submit the verification code.', '{"instructions":"Read /var/atlas-gitops/sync-history.txt and submit the verification code with: submit CODE","hostname":"atlas-gitops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-gitops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-gitops/sync-history.txt":{"type":"file","content":"14:02 - manual kubectl edit detected: replicas 2 -> 5 (not from git)\n14:02 - selfHeal triggered\n14:03 - reconciled back to git desired state: replicas = 2\n# verification SYNCHISTORY-3312\n"}}}'::jsonb, '{"requiredFlag":"SYNCHISTORY-3312"}'::jsonb),
  ('mission-atlas-git-becomes-reality-12-o2-c1', 'mission-atlas-git-becomes-reality-12-o2', 1, 'terminal_simulation', 'Read the current sync status and submit the verification code.', '{"instructions":"Read /var/atlas-gitops/current-sync-status.txt and submit the verification code with: submit CODE","hostname":"atlas-gitops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-gitops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-gitops/current-sync-status.txt":{"type":"file","content":"Application: atlas-collector\nSync Status: Synced\nHealth Status: Healthy\n# live state exactly matches git\n# verification CURRENTSYNC-6602\n"}}}'::jsonb, '{"requiredFlag":"CURRENTSYNC-6602"}'::jsonb),
  ('mission-atlas-git-becomes-reality-12-o3-c1', 'mission-atlas-git-becomes-reality-12-o3', 1, 'investigation', 'Which evidence explains why the manual change disappeared?', '{"evidence":[{"id":"e1","label":"Sync history","detail":"A manual kubectl edit set replicas to 5; selfHeal detected it was not from git and reverted it to 2 within a minute"},{"id":"e2","label":"Current sync status","detail":"The Application is fully Synced and Healthy right now"},{"id":"e3","label":"Vey''s own account","detail":"He bumped replicas manually to handle a real traffic spike, intending to commit it to git right after, but got pulled into something else first"},{"id":"e4","label":"Sealed secret status","detail":"collector-db-creds remains encrypted and unaffected"}],"question":"Which evidence explains why the manual change disappeared?"}'::jsonb, '{"requiredEvidenceIds":["e1","e3"]}'::jsonb),
  ('mission-atlas-git-becomes-reality-12-o4-c1', 'mission-atlas-git-becomes-reality-12-o4', 1, 'boss_encounter', 'Having confirmed the auto-revert, the current state, and what actually explains this, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-git-becomes-reality-12-o1","label":"Confirm the auto-revert"},{"objectiveRef":"mission-atlas-git-becomes-reality-12-o2","label":"Confirm the current state"},{"objectiveRef":"mission-atlas-git-becomes-reality-12-o3","label":"Identify what actually explains this"}],"task":"State the diagnosis in one sentence: nothing broke -- Vey made a genuine, well-intentioned manual fix under real pressure, intending to commit it to git right after, and Argo CD''s selfHeal correctly reverted it within a minute because it never came from git in the first place, which means the fleet''s real need for more replicas has to actually be written into git now, not patched by hand, because for the first time in this entire story a manual shortcut genuinely does not stick."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-git-becomes-reality-12-o1","mission-atlas-git-becomes-reality-12-o2","mission-atlas-git-becomes-reality-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-git-becomes-reality-01-o1-c1', 'orientation', 'Think about what a human remembering to apply something versus a written, versioned declaration.', 10, 1),
  ('mission-atlas-git-becomes-reality-01-o1-c1', 'solution', 'Git is the single, versioned source of truth for what should be running.', 20, 2),

  ('mission-atlas-git-becomes-reality-02-o1-c1', 'orientation', 'Think about whether this runs once or continuously.', 10, 1),
  ('mission-atlas-git-becomes-reality-02-o1-c1', 'solution', 'It continuously compares and corrects, on a loop, automatically.', 20, 2),

  ('mission-atlas-git-becomes-reality-03-o1-c1', 'orientation', 'Think about who or what decides when to actually apply a change.', 10, 1),
  ('mission-atlas-git-becomes-reality-03-o1-c1', 'solution', 'The cluster itself continuously pulls toward git, nobody has to trigger it.', 20, 2),

  ('mission-atlas-git-becomes-reality-04-o1-c1', 'orientation', 'Try: cat /var/atlas-gitops/argocd-application.yaml', 10, 1),
  ('mission-atlas-git-becomes-reality-04-o1-c1', 'solution', 'It watches environments/eu-west, verification ARGOCD-3312. submit ARGOCD-3312', 20, 2),

  ('mission-atlas-git-becomes-reality-05-o1-c1', 'orientation', 'Think about whether the core idea changes between different GitOps tools.', 10, 1),
  ('mission-atlas-git-becomes-reality-05-o1-c1', 'solution', 'Flux shares the same principles, just a different implementation.', 20, 2),

  ('mission-atlas-git-becomes-reality-06-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/environments/eu-west/structure.txt', 10, 1),
  ('mission-atlas-git-becomes-reality-06-o1-c1', 'solution', 'Every manifest lives here now, verification MANIFESTS-6602. submit MANIFESTS-6602', 20, 2),

  ('mission-atlas-git-becomes-reality-07-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/README.txt', 10, 1),
  ('mission-atlas-git-becomes-reality-07-o1-c1', 'solution', 'Each environment has its own directory and Application, verification ENVREPOS-7714. submit ENVREPOS-7714', 20, 2),

  ('mission-atlas-git-becomes-reality-08-o1-c1', 'orientation', 'Try: cat /var/atlas-gitops/sync-status.txt', 10, 1),
  ('mission-atlas-git-becomes-reality-08-o1-c1', 'solution', 'Replicas differ between git and live, verification DRIFT-4471. submit DRIFT-4471', 20, 2),

  ('mission-atlas-git-becomes-reality-09-o1-c1', 'orientation', 'Try: cat /var/atlas-gitops/sync-policy.txt', 10, 1),
  ('mission-atlas-git-becomes-reality-09-o1-c1', 'solution', 'selfHeal reverts drift automatically, verification AUTOSYNC-8802. submit AUTOSYNC-8802', 20, 2),

  ('mission-atlas-git-becomes-reality-10-o1-c1', 'orientation', 'Think about whether rollback needs a special separate command.', 10, 1),
  ('mission-atlas-git-becomes-reality-10-o1-c1', 'solution', 'Revert the commit; the controller reconciles the cluster to match.', 20, 2),

  ('mission-atlas-git-becomes-reality-11-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/environments/eu-west/sealed-secret.yaml', 10, 1),
  ('mission-atlas-git-becomes-reality-11-o1-c1', 'solution', 'It is encrypted, not just base64, verification SEALEDSECRET-9012. submit SEALEDSECRET-9012', 20, 2),

  ('mission-atlas-git-becomes-reality-12-o1-c1', 'orientation', 'Try: cat /var/atlas-gitops/sync-history.txt', 10, 1),
  ('mission-atlas-git-becomes-reality-12-o1-c1', 'solution', 'selfHeal reverted the manual edit within a minute, verification SYNCHISTORY-3312. submit SYNCHISTORY-3312', 20, 2),
  ('mission-atlas-git-becomes-reality-12-o2-c1', 'orientation', 'Try: cat /var/atlas-gitops/current-sync-status.txt', 10, 1),
  ('mission-atlas-git-becomes-reality-12-o2-c1', 'solution', 'Fully Synced and Healthy, verification CURRENTSYNC-6602. submit CURRENTSYNC-6602', 20, 2),
  ('mission-atlas-git-becomes-reality-12-o3-c1', 'orientation', 'The current status and the secret are both fine and do not explain why the change vanished. Look at the sync history and Vey''s own account together.', 10, 1),
  ('mission-atlas-git-becomes-reality-12-o3-c1', 'solution', 'e1 and e3: selfHeal reverted a change that never came from git, made under real pressure with genuine intent to follow up.', 20, 2),
  ('mission-atlas-git-becomes-reality-12-o4-c1', 'orientation', 'Combine the auto-revert, the intent behind the change, and why this is not a bug into one sentence.', 15, 1),
  ('mission-atlas-git-becomes-reality-12-o4-c1', 'solution', 'selfHeal correctly reverted a well-intentioned manual change that never went through git -- the fleet''s real need has to be committed, not patched by hand, and for the first time that discipline is enforced automatically.', 25, 2);
