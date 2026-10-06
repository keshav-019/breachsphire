-- Atlas Division pathway ("The Silence") Act 21 -- "Kubernetes
-- Operations" content, under world-atlas-kubernetes-operations
-- (already inserted separately). 1 campaign, 2 operations, 12 missions
-- (11 lessons + boss), closing World VI "The Cluster Sea" (Acts
-- 17-21).
--
-- Same terminal-engine constraint as every prior Atlas Act -- every
-- operations artifact here is static seeded text read via `cat`. Two
-- hosts, both reused: `atlas-devbox-01` for declared Helm/Kustomize/
-- RBAC/webhook YAML and `atlas-k8s-01` for live cluster state (upgrade
-- log, cordon/drain log, the deployment failure and webhook cert
-- status that drive the boss). Only "autoscaling" (cluster-level, a
-- concept distinct from Act 20's pod-level HPA) and "troubleshooting"
-- (methodology, no single artifact) stay multiple_choice.
--
-- Narrative thread: mission 3 (values) plants the direct fix for Act
-- 20's crash loop -- the Helm chart''s resource limits are finally set
-- to the real number (2048Mi), not the old 512Mi. Mission 7 (admission
-- concepts) introduces the webhook built specifically to enforce that
-- going forward. The boss reveals the webhook''s own TLS certificate,
-- issued once and never rotated, silently expired -- and its
-- fail-closed policy blocked every deployment cluster-wide, not just
-- bad ones. This closes World VI''s whole throughline: every safety net
-- since Act 12 needs its own maintenance, or it becomes the incident.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-kubernetes-operations', 'world-atlas-kubernetes-operations', 'kubernetes-operations', '6E - Kubernetes Operations', 'Learn how a real cluster is actually operated day to day -- Helm, Charts, values, Kustomize, RBAC, ServiceAccounts, admission concepts, autoscaling, upgrades, node maintenance and troubleshooting -- while the safety net Rook built for Act 20 becomes this World''s final incident.', 5);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-kubernetes-operations-1', 'campaign-atlas-kubernetes-operations', 'packaging-and-permission', 'Packaging and Permission', 'Helm, Charts, values, Kustomize, RBAC and ServiceAccounts.', 1),
  ('operation-atlas-kubernetes-operations-2', 'campaign-atlas-kubernetes-operations', 'keeping-the-cluster-itself-healthy', 'Keeping the Cluster Itself Healthy', 'Admission concepts, autoscaling, upgrades, node maintenance and troubleshooting.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-kubernetes-operations-01', 'world-atlas-kubernetes-operations', 'campaign-atlas-kubernetes-operations', 'operation-atlas-kubernetes-operations-1', 'helm', 'Helm', 'Rook starts packaging the collector properly, instead of hand-writing every manifest from scratch each time.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"helm-sim"}'::jsonb, '{"xp":420,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-kubernetes-operations-02', 'world-atlas-kubernetes-operations', 'campaign-atlas-kubernetes-operations', 'operation-atlas-kubernetes-operations-1', 'charts', 'Charts', 'Confirm exactly what this chart actually declares about itself.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-kubernetes-operations-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"charts-sim"}'::jsonb, '{"xp":420,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-kubernetes-operations-03', 'world-atlas-kubernetes-operations', 'campaign-atlas-kubernetes-operations', 'operation-atlas-kubernetes-operations-1', 'values', 'Values', 'Confirm the resource limits are finally set to the real number from Act 20''s fix.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-kubernetes-operations-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"values-sim"}'::jsonb, '{"xp":430,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-kubernetes-operations-04', 'world-atlas-kubernetes-operations', 'campaign-atlas-kubernetes-operations', 'operation-atlas-kubernetes-operations-1', 'kustomize', 'Kustomize', 'Confirm how eu-west and us-east each get their own configuration without duplicating a single base manifest.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-kubernetes-operations-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"kustomize-sim"}'::jsonb, '{"xp":430,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-kubernetes-operations-05', 'world-atlas-kubernetes-operations', 'campaign-atlas-kubernetes-operations', 'operation-atlas-kubernetes-operations-1', 'rbac', 'RBAC', 'Confirm exactly what this role actually permits, and nothing more.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-kubernetes-operations-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"rbac-sim"}'::jsonb, '{"xp":440,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-kubernetes-operations-06', 'world-atlas-kubernetes-operations', 'campaign-atlas-kubernetes-operations', 'operation-atlas-kubernetes-operations-1', 'serviceaccounts', 'ServiceAccounts', 'Confirm the identity this pod itself actually uses to talk to the cluster.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-kubernetes-operations-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"serviceaccounts-sim"}'::jsonb, '{"xp":440,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-kubernetes-operations-07', 'world-atlas-kubernetes-operations', 'campaign-atlas-kubernetes-operations', 'operation-atlas-kubernetes-operations-2', 'admission-concepts', 'Admission Concepts', 'Confirm what Rook actually built to enforce Act 20''s lesson automatically, going forward.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-kubernetes-operations-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"admission-concepts-sim"}'::jsonb, '{"xp":450,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-kubernetes-operations-08', 'world-atlas-kubernetes-operations', 'campaign-atlas-kubernetes-operations', 'operation-atlas-kubernetes-operations-2', 'autoscaling', 'Autoscaling', 'Understand what actually adds a whole new node, not just a new pod.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-kubernetes-operations-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"autoscaling-sim"}'::jsonb, '{"xp":450,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-kubernetes-operations-09', 'world-atlas-kubernetes-operations', 'campaign-atlas-kubernetes-operations', 'operation-atlas-kubernetes-operations-2', 'upgrades', 'Upgrades', 'Confirm how the last cluster upgrade actually happened without taking anything down.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-kubernetes-operations-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"upgrades-sim"}'::jsonb, '{"xp":460,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-kubernetes-operations-10', 'world-atlas-kubernetes-operations', 'campaign-atlas-kubernetes-operations', 'operation-atlas-kubernetes-operations-2', 'node-maintenance', 'Node Maintenance', 'Confirm the actual two steps that safely take a node out of service.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-kubernetes-operations-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"node-maintenance-sim"}'::jsonb, '{"xp":460,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-kubernetes-operations-11', 'world-atlas-kubernetes-operations', 'campaign-atlas-kubernetes-operations', 'operation-atlas-kubernetes-operations-2', 'troubleshooting', 'Troubleshooting', 'Understand the actual discipline for narrowing down a failure across every layer this World has taught.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-kubernetes-operations-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"troubleshooting-sim"}'::jsonb, '{"xp":460,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-kubernetes-operations-12', 'world-atlas-kubernetes-operations', 'campaign-atlas-kubernetes-operations', 'operation-atlas-kubernetes-operations-2', 'the-broken-cluster', 'The Broken Cluster', 'Everything this World taught, turned on one cluster-wide failure: not to disable the safety net, to finally explain how the thing built to prevent the last incident became this one.', 'boss', ARRAY['rook','cross','vey','leena'], '{"requiredMissionIds":["mission-atlas-kubernetes-operations-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"broken-cluster-boss-sim"}'::jsonb, '{"xp":700,"credits":165,"badgeIds":["the-broken-cluster"],"skillXp":{"cloud_devops_fundamentals":110}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-kubernetes-operations-01', 1, 'leena', 'Rook is packaging the collector properly now, instead of hand-writing every manifest from scratch each time it needs to change.'),
  ('mission-atlas-kubernetes-operations-01', 2, 'rook', 'Helm is a package manager for Kubernetes -- a Chart bundles templated manifests together with configurable values, versioned and installable as one unit instead of a folder of loose YAML.'),

  ('mission-atlas-kubernetes-operations-02', 1, 'rook', 'A Chart declares its own name, version and what it actually deploys. Confirm this one.'),

  ('mission-atlas-kubernetes-operations-03', 1, 'rook', 'Values are what actually get filled into the templates -- image tag, replica count, resource limits. Confirm the resource limits specifically. That number should look familiar after Act 20.'),

  ('mission-atlas-kubernetes-operations-04', 1, 'rook', 'Kustomize layers small, per-environment patches on top of one shared base -- eu-west and us-east each get exactly what is different about them, without copying the whole manifest twice.'),

  ('mission-atlas-kubernetes-operations-05', 1, 'cross', 'Imani Cross. RBAC governs who, or what, is allowed to do anything at all inside this cluster. Confirm exactly what this specific role permits -- and confirm it is nothing more than that.'),

  ('mission-atlas-kubernetes-operations-06', 1, 'cross', 'A ServiceAccount is not a person''s login. It is the identity a pod itself presents to the API server when it needs to ask for anything. Confirm which one this workload actually uses.'),

  ('mission-atlas-kubernetes-operations-07', 1, 'rook', 'This is the actual answer to Act 20. A validating admission webhook can reject a Deployment outright if it does not declare real resource limits -- enforced automatically, every time, not hoped for.'),

  ('mission-atlas-kubernetes-operations-08', 1, 'vey', 'Tomas Vey. HPA adds more pods. It cannot add more room to run them on. Cluster autoscaling is the layer underneath that -- it actually adds or removes whole nodes based on what is genuinely waiting to be scheduled.'),

  ('mission-atlas-kubernetes-operations-09', 1, 'rook', 'Confirm how the last control-plane upgrade actually happened -- one node at a time, cordoned, drained, replaced, without anyone noticing.'),

  ('mission-atlas-kubernetes-operations-10', 1, 'rook', 'Taking a node out of service safely is two distinct steps, not one. Confirm what each one actually does.'),

  ('mission-atlas-kubernetes-operations-11', 1, 'cross', 'Every layer this World has taught -- Helm, RBAC, admission control, the scheduler itself -- is a place a failure could actually be hiding. Troubleshooting is the discipline of narrowing that down methodically, not guessing.'),

  ('mission-atlas-kubernetes-operations-12', 1, 'leena', 'Everything this World taught you, on one cluster-wide failure. Not to just disable the safety net and move on -- to finally explain how the exact thing built to prevent the last incident became this one.'),
  ('mission-atlas-kubernetes-operations-12', 2, 'byte', 'I have every failed deployment attempt from the last 40 minutes pulled up together. Every single one failed the exact same way.'),
  ('mission-atlas-kubernetes-operations-12', 3, 'rook', 'That webhook has been running, untouched, since the day I deployed it.'),
  ('mission-atlas-kubernetes-operations-12', 4, 'cross', 'Untouched is exactly the word to be suspicious of. Find out what it actually needed, and never got.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-kubernetes-operations-01-o1', 'mission-atlas-kubernetes-operations-01', 1, 'Read the Helm chart directory', 'Read the chart structure and submit the verification code.'),

  ('mission-atlas-kubernetes-operations-02-o1', 'mission-atlas-kubernetes-operations-02', 1, 'Read Chart.yaml', 'Read the Chart.yaml file and submit the verification code.'),

  ('mission-atlas-kubernetes-operations-03-o1', 'mission-atlas-kubernetes-operations-03', 1, 'Read values.yaml', 'Read the values file and submit the verification code.'),

  ('mission-atlas-kubernetes-operations-04-o1', 'mission-atlas-kubernetes-operations-04', 1, 'Read the kustomization', 'Read the kustomization file and submit the verification code.'),

  ('mission-atlas-kubernetes-operations-05-o1', 'mission-atlas-kubernetes-operations-05', 1, 'Read the RBAC Role', 'Read the Role definition and submit the verification code.'),

  ('mission-atlas-kubernetes-operations-06-o1', 'mission-atlas-kubernetes-operations-06', 1, 'Read the ServiceAccount', 'Read the ServiceAccount definition and submit the verification code.'),

  ('mission-atlas-kubernetes-operations-07-o1', 'mission-atlas-kubernetes-operations-07', 1, 'Read the admission webhook', 'Read the ValidatingWebhookConfiguration and submit the verification code.'),

  ('mission-atlas-kubernetes-operations-08-o1', 'mission-atlas-kubernetes-operations-08', 1, 'Explain cluster autoscaling', 'Choose the accurate description of what cluster autoscaling actually does.'),

  ('mission-atlas-kubernetes-operations-09-o1', 'mission-atlas-kubernetes-operations-09', 1, 'Read the upgrade log', 'Read the upgrade log and submit the verification code.'),

  ('mission-atlas-kubernetes-operations-10-o1', 'mission-atlas-kubernetes-operations-10', 1, 'Read the cordon and drain log', 'Read the cordon and drain log and submit the verification code.'),

  ('mission-atlas-kubernetes-operations-11-o1', 'mission-atlas-kubernetes-operations-11', 1, 'Explain troubleshooting methodology', 'Choose the accurate description of how a genuine troubleshooting process actually works.'),

  ('mission-atlas-kubernetes-operations-12-o1', 'mission-atlas-kubernetes-operations-12', 1, 'Confirm the cluster-wide failure', 'Read the deployment failure log and submit the verification code.'),
  ('mission-atlas-kubernetes-operations-12-o2', 'mission-atlas-kubernetes-operations-12', 2, 'Confirm the webhook certificate status', 'Read the webhook certificate status and submit the verification code.'),
  ('mission-atlas-kubernetes-operations-12-o3', 'mission-atlas-kubernetes-operations-12', 3, 'Identify what actually explains this', 'Find the evidence that explains why every deployment is failing the same way.'),
  ('mission-atlas-kubernetes-operations-12-o4', 'mission-atlas-kubernetes-operations-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-kubernetes-operations-01-o1-c1', 'mission-atlas-kubernetes-operations-01-o1', 1, 'terminal_simulation', 'Read the chart structure and submit the verification code.', '{"instructions":"Read /repo/infra/helm/atlas-collector/structure.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/helm/atlas-collector/structure.txt":{"type":"file","content":"atlas-collector/\n  Chart.yaml\n  values.yaml\n  templates/deployment.yaml\n  templates/service.yaml\n# a Chart bundles templated manifests and configurable values into one installable unit\n# verification HELM-3312\n"}}}'::jsonb, '{"requiredFlag":"HELM-3312"}'::jsonb),

  ('mission-atlas-kubernetes-operations-02-o1-c1', 'mission-atlas-kubernetes-operations-02-o1', 1, 'terminal_simulation', 'Read the Chart.yaml file and submit the verification code.', '{"instructions":"Read /repo/infra/helm/atlas-collector/Chart.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/helm/atlas-collector/Chart.yaml":{"type":"file","content":"apiVersion: v2\nname: atlas-collector\nversion: 1.4.0\nappVersion: v13.0.0\ndescription: Atlas metrics collector, packaged as a reusable Helm chart\n# verification CHART-6602\n"}}}'::jsonb, '{"requiredFlag":"CHART-6602"}'::jsonb),

  ('mission-atlas-kubernetes-operations-03-o1-c1', 'mission-atlas-kubernetes-operations-03-o1', 1, 'terminal_simulation', 'Read the values file and submit the verification code.', '{"instructions":"Read /repo/infra/helm/atlas-collector/values.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/helm/atlas-collector/values.yaml":{"type":"file","content":"replicaCount: 2\nimage:\n  repository: atlas-images/atlas-metrics-agent\n  tag: v13.0.0\nresources:\n  requests:\n    cpu: 250m\n    memory: 256Mi\n  limits:\n    cpu: 500m\n    memory: 2048Mi\n# 2048Mi -- the real number from Act 20''s fix, finally set as a configurable value\n# verification VALUES-7714\n"}}}'::jsonb, '{"requiredFlag":"VALUES-7714"}'::jsonb),

  ('mission-atlas-kubernetes-operations-04-o1-c1', 'mission-atlas-kubernetes-operations-04-o1', 1, 'terminal_simulation', 'Read the kustomization file and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/overlays/kustomization.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/overlays/kustomization.yaml":{"type":"file","content":"resources:\n  - ../../base\npatches:\n  - path: eu-west-patch.yaml\nnamespace: atlas-metrics\n# eu-west and us-east each get their own overlay, without duplicating the base manifests\n# verification KUSTOMIZE-8802\n"}}}'::jsonb, '{"requiredFlag":"KUSTOMIZE-8802"}'::jsonb),

  ('mission-atlas-kubernetes-operations-05-o1-c1', 'mission-atlas-kubernetes-operations-05-o1', 1, 'terminal_simulation', 'Read the Role definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-role.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-role.yaml":{"type":"file","content":"apiVersion: rbac.authorization.k8s.io/v1\nkind: Role\nmetadata:\n  name: collector-reader\n  namespace: atlas-metrics\nrules:\n  - apiGroups: [\"\"]\n    resources: [\"pods\", \"services\"]\n    verbs: [\"get\", \"list\", \"watch\"]\n# grants exactly read access within one namespace, nothing more\n# verification RBAC-2291\n"}}}'::jsonb, '{"requiredFlag":"RBAC-2291"}'::jsonb),

  ('mission-atlas-kubernetes-operations-06-o1-c1', 'mission-atlas-kubernetes-operations-06-o1', 1, 'terminal_simulation', 'Read the ServiceAccount definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-serviceaccount.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-serviceaccount.yaml":{"type":"file","content":"apiVersion: v1\nkind: ServiceAccount\nmetadata:\n  name: collector-sa\n  namespace: atlas-metrics\n# the identity this pod itself uses to talk to the Kubernetes API -- not a person, a workload\n# verification SVCACCOUNT-4471\n"}}}'::jsonb, '{"requiredFlag":"SVCACCOUNT-4471"}'::jsonb),

  ('mission-atlas-kubernetes-operations-07-o1-c1', 'mission-atlas-kubernetes-operations-07-o1', 1, 'terminal_simulation', 'Read the ValidatingWebhookConfiguration and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/require-limits-webhook.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/require-limits-webhook.yaml":{"type":"file","content":"apiVersion: admissionregistration.k8s.io/v1\nkind: ValidatingWebhookConfiguration\nmetadata:\n  name: require-resource-limits\nwebhooks:\n  - name: require-limits.atlas.internal\n    failurePolicy: Fail\n    rules:\n      - apiGroups: [\"apps\"]\n        resources: [\"deployments\"]\n        operations: [\"CREATE\", \"UPDATE\"]\n# rejects any Deployment that does not declare resource limits -- built directly in response to Act 20\n# verification ADMISSION-5541\n"}}}'::jsonb, '{"requiredFlag":"ADMISSION-5541"}'::jsonb),

  ('mission-atlas-kubernetes-operations-08-o1-c1', 'mission-atlas-kubernetes-operations-08-o1', 1, 'multiple_choice', 'Cluster autoscaling actually does what HPA cannot?', '{"question":"Cluster autoscaling actually does what HPA cannot?","options":[{"id":"a","text":"Add or remove whole nodes automatically based on pods that are genuinely waiting to be scheduled, rather than adjusting a pod replica count"},{"id":"b","text":"Adjust how much CPU a single pod is allowed to use"},{"id":"c","text":"Replace the need for resource requests entirely"},{"id":"d","text":"Only works for stateful workloads"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-kubernetes-operations-09-o1-c1', 'mission-atlas-kubernetes-operations-09-o1', 1, 'terminal_simulation', 'Read the upgrade log and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/upgrade-log.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/upgrade-log.txt":{"type":"file","content":"cluster control plane upgraded: v1.28 -> v1.29\nnodes upgraded one at a time: cordoned, drained, replaced, uncordoned -- zero downtime\n# verification UPGRADE-9012\n"}}}'::jsonb, '{"requiredFlag":"UPGRADE-9012"}'::jsonb),

  ('mission-atlas-kubernetes-operations-10-o1-c1', 'mission-atlas-kubernetes-operations-10-o1', 1, 'terminal_simulation', 'Read the cordon and drain log and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/cordon-drain-log.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/cordon-drain-log.txt":{"type":"file","content":"$ kubectl cordon atlas-node-02\n$ kubectl drain atlas-node-02 --ignore-daemonsets\nnode/atlas-node-02 cordoned\nevicting pod atlas-metrics/atlas-collector-7f9-a1b2c\nnode/atlas-node-02 drained\n# cordon stops new pods from scheduling here; drain then safely evicts what is already running\n# verification CORDONDRAIN-3390\n"}}}'::jsonb, '{"requiredFlag":"CORDONDRAIN-3390"}'::jsonb),

  ('mission-atlas-kubernetes-operations-11-o1-c1', 'mission-atlas-kubernetes-operations-11-o1', 1, 'multiple_choice', 'A genuine troubleshooting process actually works by...', '{"question":"A genuine troubleshooting process actually works by...","options":[{"id":"a","text":"Methodically narrowing down which layer -- application, scheduling, RBAC, admission control, networking -- is actually responsible, rather than guessing at a fix"},{"id":"b","text":"Restarting every pod in the cluster until the problem happens to go away"},{"id":"c","text":"Always assuming the most recently deployed change is the cause"},{"id":"d","text":"Disabling every safety mechanism until something works"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-kubernetes-operations-12-o1-c1', 'mission-atlas-kubernetes-operations-12-o1', 1, 'terminal_simulation', 'Read the deployment failure log and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/deploy-failure.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/deploy-failure.txt":{"type":"file","content":"$ kubectl apply -f collector-deployment.yaml\nError from server: error when creating collector-deployment.yaml: admission webhook require-limits.atlas.internal denied the request: failed calling webhook: x509 certificate has expired\n# every deployment attempt cluster-wide has failed the exact same way for the last 40 minutes\n# verification DEPLOYFAIL-3312\n"}}}'::jsonb, '{"requiredFlag":"DEPLOYFAIL-3312"}'::jsonb),
  ('mission-atlas-kubernetes-operations-12-o2-c1', 'mission-atlas-kubernetes-operations-12-o2', 1, 'terminal_simulation', 'Read the webhook certificate status and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/webhook-cert-status.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/webhook-cert-status.txt":{"type":"file","content":"webhook: require-limits.atlas.internal\ncertificate expired: 2026-08-16T15:00:00\ncertificate never rotated since it was first issued during Act 21''s rollout\nfailurePolicy: Fail -- the API server rejects everything rather than skip a webhook it cannot reach\n# verification CERTSTATUS-6602\n"}}}'::jsonb, '{"requiredFlag":"CERTSTATUS-6602"}'::jsonb),
  ('mission-atlas-kubernetes-operations-12-o3-c1', 'mission-atlas-kubernetes-operations-12-o3', 1, 'investigation', 'Which evidence explains why every deployment is failing the same way?', '{"evidence":[{"id":"e1","label":"Deployment failure log","detail":"Every attempted deployment is rejected with the identical x509 certificate expired error"},{"id":"e2","label":"Webhook certificate status","detail":"The admission webhook''s TLS certificate expired and was never rotated since it was first issued"},{"id":"e3","label":"RBAC Role","detail":"collector-reader is correctly scoped to read-only access within one namespace"},{"id":"e4","label":"Kustomize overlay","detail":"The eu-west overlay applies correctly on top of the shared base manifests"}],"question":"Which evidence explains why every deployment is failing the same way?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2"]}'::jsonb),
  ('mission-atlas-kubernetes-operations-12-o4-c1', 'mission-atlas-kubernetes-operations-12-o4', 1, 'boss_encounter', 'Having confirmed the cluster-wide failure, the certificate status, and what actually explains this, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-kubernetes-operations-12-o1","label":"Confirm the cluster-wide failure"},{"objectiveRef":"mission-atlas-kubernetes-operations-12-o2","label":"Confirm the webhook certificate status"},{"objectiveRef":"mission-atlas-kubernetes-operations-12-o3","label":"Identify what actually explains this"}],"task":"State the diagnosis in one sentence: the admission webhook built specifically to enforce Act 20''s resource-limits lesson is not malfunctioning -- its own TLS certificate, issued once and never rotated, simply expired, and its fail-closed policy correctly rejects every deployment rather than risk letting one through unvalidated, so the fix is renewing the certificate immediately and adding rotation so this safety mechanism never again becomes the single point of failure it was built to prevent."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-kubernetes-operations-12-o1","mission-atlas-kubernetes-operations-12-o2","mission-atlas-kubernetes-operations-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-kubernetes-operations-01-o1-c1', 'orientation', 'Try: cat /repo/infra/helm/atlas-collector/structure.txt', 10, 1),
  ('mission-atlas-kubernetes-operations-01-o1-c1', 'solution', 'A Chart bundles templates and values, verification HELM-3312. submit HELM-3312', 20, 2),

  ('mission-atlas-kubernetes-operations-02-o1-c1', 'orientation', 'Try: cat /repo/infra/helm/atlas-collector/Chart.yaml', 10, 1),
  ('mission-atlas-kubernetes-operations-02-o1-c1', 'solution', 'Version 1.4.0, verification CHART-6602. submit CHART-6602', 20, 2),

  ('mission-atlas-kubernetes-operations-03-o1-c1', 'orientation', 'Try: cat /repo/infra/helm/atlas-collector/values.yaml', 10, 1),
  ('mission-atlas-kubernetes-operations-03-o1-c1', 'solution', 'The memory limit is 2048Mi now, verification VALUES-7714. submit VALUES-7714', 20, 2),

  ('mission-atlas-kubernetes-operations-04-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/overlays/kustomization.yaml', 10, 1),
  ('mission-atlas-kubernetes-operations-04-o1-c1', 'solution', 'Patches apply on top of a shared base, verification KUSTOMIZE-8802. submit KUSTOMIZE-8802', 20, 2),

  ('mission-atlas-kubernetes-operations-05-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-role.yaml', 10, 1),
  ('mission-atlas-kubernetes-operations-05-o1-c1', 'solution', 'Only get, list and watch are granted, verification RBAC-2291. submit RBAC-2291', 20, 2),

  ('mission-atlas-kubernetes-operations-06-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-serviceaccount.yaml', 10, 1),
  ('mission-atlas-kubernetes-operations-06-o1-c1', 'solution', 'It is the pod''s own identity, verification SVCACCOUNT-4471. submit SVCACCOUNT-4471', 20, 2),

  ('mission-atlas-kubernetes-operations-07-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/require-limits-webhook.yaml', 10, 1),
  ('mission-atlas-kubernetes-operations-07-o1-c1', 'solution', 'It rejects deployments missing resource limits, verification ADMISSION-5541. submit ADMISSION-5541', 20, 2),

  ('mission-atlas-kubernetes-operations-08-o1-c1', 'orientation', 'Think about whether the fleet has room to grow at the node level, not just the pod level.', 10, 1),
  ('mission-atlas-kubernetes-operations-08-o1-c1', 'solution', 'Cluster autoscaling adds or removes nodes based on pending pod demand.', 20, 2),

  ('mission-atlas-kubernetes-operations-09-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/upgrade-log.txt', 10, 1),
  ('mission-atlas-kubernetes-operations-09-o1-c1', 'solution', 'One node at a time, zero downtime, verification UPGRADE-9012. submit UPGRADE-9012', 20, 2),

  ('mission-atlas-kubernetes-operations-10-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/cordon-drain-log.txt', 10, 1),
  ('mission-atlas-kubernetes-operations-10-o1-c1', 'solution', 'Cordon first, then drain, verification CORDONDRAIN-3390. submit CORDONDRAIN-3390', 20, 2),

  ('mission-atlas-kubernetes-operations-11-o1-c1', 'orientation', 'Think about narrowing down layers methodically versus guessing.', 10, 1),
  ('mission-atlas-kubernetes-operations-11-o1-c1', 'solution', 'Methodically isolate which layer is actually responsible.', 20, 2),

  ('mission-atlas-kubernetes-operations-12-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/deploy-failure.txt', 10, 1),
  ('mission-atlas-kubernetes-operations-12-o1-c1', 'solution', 'Every attempt fails the same way, verification DEPLOYFAIL-3312. submit DEPLOYFAIL-3312', 20, 2),
  ('mission-atlas-kubernetes-operations-12-o2-c1', 'orientation', 'Try: cat /var/atlas-k8s/webhook-cert-status.txt', 10, 1),
  ('mission-atlas-kubernetes-operations-12-o2-c1', 'solution', 'The certificate expired and was never rotated, verification CERTSTATUS-6602. submit CERTSTATUS-6602', 20, 2),
  ('mission-atlas-kubernetes-operations-12-o3-c1', 'orientation', 'RBAC and Kustomize are both fine and irrelevant to this specific failure. Look at the error itself and the certificate together.', 10, 1),
  ('mission-atlas-kubernetes-operations-12-o3-c1', 'solution', 'e1 and e2: the identical error every time, caused by an expired, never-rotated webhook certificate.', 20, 2),
  ('mission-atlas-kubernetes-operations-12-o4-c1', 'orientation', 'Combine the cluster-wide failure, the expired cert, and what has to change into one sentence.', 15, 1),
  ('mission-atlas-kubernetes-operations-12-o4-c1', 'solution', 'The webhook is correctly fail-closed on an expired certificate that was never rotated -- renew it now and add rotation so the safety net cannot become the incident again.', 25, 2);
