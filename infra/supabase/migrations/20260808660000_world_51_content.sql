-- world-51 ("Kubernetes: Clusterfall") mission content, generated from
-- docs/12-world-story-bible.md. Continues Act 7 "Cloudfall". Mission 1 is
-- cross-world-gated on world-50's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-51a', 'world-51', 'clusterfall', '51A - Clusterfall', 'A poisoned image alone can''t explain reaching high-value services across several clusters. Something in the cluster itself gave it the path.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-51a-1', 'campaign-51a', 'foundations', 'Foundations', 'RBAC, service accounts, namespaces and network policies, learned as a live cluster investigation.', 1),
  ('operation-51a-2', 'campaign-51a', 'investigation', 'Investigation', 'Trace the path from one workload to cluster-wide impact, then break the chain.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w51-01', 'world-51', 'campaign-51a', 'operation-51a-1', 'more-than-one-image', 'More Than One Image', 'The poisoned image explains how Sentinel-X got in. It doesn''t explain how it reached high-value services in clusters that never even pulled that image.', 'intro', ARRAY['ava', 'zayn', 'byte'], '{"requiredMissionIds":["mission-w50-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w51-02', 'world-51', 'campaign-51a', 'operation-51a-1', 'the-role-that-can-do-too-much', 'The Role That Can Do Too Much', 'A service account bound to a role with far more permissions than the pod using it could ever legitimately need.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w51-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"rbac-graph-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w51-03', 'world-51', 'campaign-51a', 'operation-51a-1', 'no-fence-between-namespaces', 'No Fence Between Namespaces', 'Namespaces are supposed to separate workloads. Without a network policy, they''re just labels.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w51-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"network-policy-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w51-04', 'world-51', 'campaign-51a', 'operation-51a-2', 'a-token-that-talked-to-the-api-server', 'A Token That Talked to the API Server', 'A compromised pod used its own service account token to query the Kubernetes API server directly, for things it had no reason to ask about.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w51-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"api-server-audit-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w51-05', 'world-51', 'campaign-51a', 'operation-51a-2', 'nothing-stopped-it-at-the-door', 'Nothing Stopped It at the Door', 'A privileged pod spec was accepted into the cluster with no admission control ever questioning it.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w51-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"admission-control-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w51-06', 'world-51', 'campaign-51a', 'operation-51a-2', 'clusterfall-boss', 'Clusterfall', 'Trace the complete path from one compromised workload to cluster-wide impact, and break the chain at every link that made it possible.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w51-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"clusterfall-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["clusterfall"],"skillXp":{"cloud_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w51-01', 1, 'ava', 'The poisoned image explains the initial foothold. It doesn''t explain how Sentinel-X reached high-value services in clusters that never even pulled that image.'),
  ('mission-w51-01', 2, 'byte', 'Something in the cluster configuration itself is giving it a path -- RBAC, namespaces, network policy, or all three.'),
  ('mission-w51-01', 3, 'zayn', 'Which means this is a live cluster investigation, not another Dockerfile. Different terrain, same instinct: find what shouldn''t be reachable.'),
  ('mission-w51-02', 1, 'zayn', 'A service account bound to a role that can list secrets cluster-wide, when the pod using it only needed to read its own config map.'),
  ('mission-w51-03', 1, 'byte', 'Namespaces look like walls. Without a network policy enforcing them, they''re just labels -- any pod can talk to any other pod.'),
  ('mission-w51-04', 1, 'zayn', 'A compromised pod used its own service account token to query the Kubernetes API server directly -- listing secrets, other pods, other namespaces.'),
  ('mission-w51-05', 1, 'ava', 'A privileged pod spec -- host network access, no resource limits -- went straight into the cluster. No admission controller even looked at it.'),
  ('mission-w51-06', 1, 'zayn', 'Trace the whole path. One compromised workload, all the way to cluster-wide impact.'),
  ('mission-w51-06', 2, 'byte', '...Full chain confirmed: over-permissioned service account, no network policy between namespaces, direct API server access, and a privileged pod that sailed through with no admission control at all.'),
  ('mission-w51-06', 3, 'ava', 'Break every link. Least-privilege RBAC, default-deny network policy, and an admission policy that actually rejects privileged specs.'),
  ('mission-w51-06', 4, 'zayn', 'Done. And I traced how that first malicious deployment even got into the cluster in the first place.'),
  ('mission-w51-06', 5, 'byte', 'It came through a CI/CD pipeline. A signed one. Someone -- or something -- with legitimate signing access pushed it.'),
  ('mission-w51-06', 6, 'ava', 'Then the pipeline itself is the next thing we can''t trust blindly.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w51-01-o1', 'mission-w51-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to investigate the live cluster.'),
  ('mission-w51-02-o1', 'mission-w51-02', 1, 'Find the over-permissioned binding', 'Identify which RBAC role binding grants more than the pod needs.'),
  ('mission-w51-03-o1', 'mission-w51-03', 1, 'Identify the missing network policy', 'Determine what''s missing that lets cross-namespace traffic flow freely.'),
  ('mission-w51-04-o1', 'mission-w51-04', 1, 'Spot the anomalous API server query', 'Identify which API server request is consistent with a compromised pod escalating access.'),
  ('mission-w51-05-o1', 'mission-w51-05', 1, 'Identify the missing admission control', 'Choose the admission policy that would have rejected the privileged pod spec.'),
  ('mission-w51-06-o1', 'mission-w51-06', 1, 'Trace workload to cluster-wide impact', 'Order the complete chain from compromised workload to cluster-wide impact.'),
  ('mission-w51-06-o2', 'mission-w51-06', 2, 'Break every link', 'Choose the combination of fixes that closes the entire chain.'),
  ('mission-w51-06-o3', 'mission-w51-06', 3, 'Confirm the hardening', 'Confirm the traced chain and the fixes together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w51-01-o1-c1', 'mission-w51-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"byte","text":"The image explains the foothold, not the reach. Ready to look at the cluster itself?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w51-02-o1-c1', 'mission-w51-02-o1', 1, 'browser_simulation', 'Which RBAC role binding grants more than the pod needs?', '{"screen":"rbac-graph-viewer","bindings":[{"id":"b1","serviceAccount":"config-reader","role":"reads its own namespace''s ConfigMaps only"},{"id":"b2","serviceAccount":"config-reader","role":"cluster-admin -- full read/write on every resource in every namespace"}],"question":"Which binding is the over-permissioned one?"}'::jsonb, '{"correctOptionId":"b2"}'::jsonb),

  ('mission-w51-03-o1-c1', 'mission-w51-03-o1', 1, 'multiple_choice', 'Two namespaces have no NetworkPolicy resource defined at all. What does that mean for traffic between them?', '{"question":"Two namespaces have no NetworkPolicy resource defined at all. What does that mean for traffic between them?","options":[{"id":"a","text":"Kubernetes blocks cross-namespace traffic by default"},{"id":"b","text":"Without an explicit NetworkPolicy, Kubernetes allows all traffic between pods by default -- namespaces alone provide no network isolation"},{"id":"c","text":"Only DNS traffic is allowed between namespaces by default"},{"id":"d","text":"It depends on which cloud provider is hosting the cluster"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w51-04-o1-c1', 'mission-w51-04-o1', 1, 'investigation', 'Which API server request is consistent with a compromised pod escalating access?', '{"evidence":[{"id":"a1","label":"API server audit log entry A","detail":"A monitoring pod''s service account listing pod status in its own namespace, on its normal 30-second interval"},{"id":"a2","label":"API server audit log entry B","detail":"A web-frontend pod''s service account listing secrets across every namespace in the cluster, once, at an unusual hour"}],"question":"Which entry shows a compromised pod escalating access?"}'::jsonb, '{"requiredEvidenceIds":["a2"]}'::jsonb),

  ('mission-w51-05-o1-c1', 'mission-w51-05-o1', 1, 'multiple_choice', 'Which admission control would have rejected a pod spec requesting host network access and no resource limits?', '{"question":"Which admission control would have rejected a pod spec requesting host network access and no resource limits?", "options":[{"id":"a","text":"A Pod Security admission policy enforcing the restricted profile"},{"id":"b","text":"A larger cluster autoscaler"},{"id":"c","text":"A more permissive default service account"},{"id":"d","text":"Nothing -- pod specs can''t be validated before they run"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-w51-06-o1-c1', 'mission-w51-06-o1', 1, 'interactive_diagram', 'Order the complete chain from one compromised workload to cluster-wide impact.', '{"hotspots":[{"id":"compromise","label":"Initial workload compromise -- poisoned image runs in one namespace","explanation":"The starting point from the last world."},{"id":"rbac","label":"Over-permissioned service account lets the workload query far beyond its own namespace","explanation":"Turns a single-pod compromise into cluster-wide visibility."},{"id":"network","label":"No network policy lets it reach pods in other namespaces directly","explanation":"Visibility becomes reachability."},{"id":"privileged_pod","label":"A privileged pod spec is deployed with no admission control rejecting it","explanation":"Reachability becomes host-level control across the cluster."}],"task":"Order the chain from initial compromise to cluster-wide impact."}'::jsonb, '{"correctOrderIds":["compromise","rbac","network","privileged_pod"]}'::jsonb),

  ('mission-w51-06-o2-c1', 'mission-w51-06-o2', 1, 'drag_and_drop', 'Match each fix to the link in the chain it breaks.', '{"items":[{"id":"f1","text":"Scope the service account role to only what the pod''s own namespace needs"},{"id":"f2","text":"Add a default-deny NetworkPolicy, then explicitly allow only required traffic"},{"id":"f3","text":"Enforce a restricted Pod Security admission policy cluster-wide"}],"targets":[{"id":"rbac_link","label":"The RBAC over-permission link"},{"id":"network_link","label":"The missing network policy link"},{"id":"admission_link","label":"The missing admission control link"}]}'::jsonb, '{"correctMapping":{"f1":"rbac_link","f2":"network_link","f3":"admission_link"}}'::jsonb),

  ('mission-w51-06-o3-c1', 'mission-w51-06-o3', 1, 'boss_encounter', 'Confirm the traced chain and the complete set of fixes together.', '{"stages":[{"objectiveRef":"mission-w51-06-o1","label":"The full chain"},{"objectiveRef":"mission-w51-06-o2","label":"The fixes for each link"}],"task":"Confirm the traced chain and the complete set of fixes together."}'::jsonb, '{"requiredObjectiveIds":["mission-w51-06-o1","mission-w51-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w51-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w51-02-o1-c1', 'orientation', 'Ask what the pod''s actual job is, then compare that to what its role permits.', 15, 1),
  ('mission-w51-02-o1-c1', 'solution', 'A pod that only needs to read its own ConfigMaps has no business holding a cluster-admin binding -- that''s b2, the over-permissioned one.', 25, 2),

  ('mission-w51-03-o1-c1', 'orientation', 'Namespaces are an organizational boundary, not automatically a network boundary.', 15, 1),
  ('mission-w51-03-o1-c1', 'solution', 'Kubernetes allows all pod-to-pod traffic by default unless a NetworkPolicy explicitly restricts it -- namespaces alone enforce nothing. Option b.', 25, 2),

  ('mission-w51-04-o1-c1', 'orientation', 'Compare each request against what that pod''s actual job would ever require.', 15, 1),
  ('mission-w51-04-o1-c1', 'solution', 'A web-frontend pod has no legitimate reason to list secrets cluster-wide -- that''s a2, the escalation attempt. The monitoring pod''s routine check (a1) is normal.', 25, 2),

  ('mission-w51-05-o1-c1', 'orientation', 'Ask what kind of policy is specifically designed to inspect and reject risky pod specs before they run.', 15, 1),
  ('mission-w51-05-o1-c1', 'solution', 'A Pod Security admission policy enforcing the restricted profile blocks host network access and unbounded resource requests at admission time. Option a.', 25, 2),

  ('mission-w51-06-o1-c1', 'orientation', 'Start from the single compromised pod, and ask what each missing control let it reach next.', 15, 1),
  ('mission-w51-06-o1-c1', 'concept', 'Compromise gave a foothold; RBAC over-permission turned it into visibility; missing network policy turned visibility into reachability; missing admission control turned reachability into privileged, cluster-wide impact.', 25, 2),
  ('mission-w51-06-o1-c1', 'solution', 'Compromise -> over-permissioned RBAC -> no network policy -> unrejected privileged pod spec -> cluster-wide impact.', 35, 3),

  ('mission-w51-06-o2-c1', 'orientation', 'Match each fix to the specific gap it closes, not just to "security" in general.', 15, 1),
  ('mission-w51-06-o2-c1', 'solution', 'Scoped RBAC closes the over-permission link, a default-deny NetworkPolicy closes the missing-isolation link, and a restricted Pod Security admission policy closes the missing-admission-control link.', 25, 2),

  ('mission-w51-06-o3-c1', 'orientation', 'You''ve already traced the chain and matched the fixes -- combine them.', 20, 1),
  ('mission-w51-06-o3-c1', 'solution', 'The chain runs from a single compromised pod, through an over-permissioned service account and a missing network policy, to a privileged pod that no admission control ever questioned -- each link now closed by scoped RBAC, default-deny networking, and restricted Pod Security admission.', 35, 2);
