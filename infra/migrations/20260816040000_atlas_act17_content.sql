-- Atlas Division pathway ("The Silence") Act 17 -- "The Orchestrator"
-- content, under world-atlas-the-orchestrator (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), opening World VI "The Cluster Sea".
--
-- Same terminal-engine constraint as every prior Atlas Act -- no
-- kubectl-specific commands exist in the engine -- so every Kubernetes
-- artifact here is static seeded text read via `cat`. Two hosts: the
-- reused `atlas-devbox-01` for declared YAML manifests (repo-side, the
-- same pattern as Terraform in Acts 14-15), and a new `atlas-k8s-01`
-- for live cluster state (cluster info, node list, pod status,
-- namespaces) -- the same "declared vs actual" split used throughout
-- this pathway, now applied to Kubernetes.
--
-- Narrative thread: mission 5 plants the setup -- collector-pod-zero
-- is declared as a bare Pod, not wrapped in a ReplicaSet or Deployment,
-- deployed in a hurry specifically to retire the Act 16 snowflake as
-- fast as possible. Mission 7's Deployment example (a completely
-- different service, atlas-ci-runner) is the deliberate contrast the
-- boss needs: proof that properly-controlled workloads in this exact
-- cluster do survive what collector-pod-zero did not. The boss reveals
-- a routine node drain took collector-pod-zero down with it, and
-- nothing rescheduled it, because nothing owned it.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-the-orchestrator', 'world-atlas-the-orchestrator', 'the-orchestrator', '6A - The Orchestrator', 'Learn Kubernetes from first principles -- why Kubernetes, the cluster model, the control plane, nodes, Pods, ReplicaSets, Deployments, Services, namespaces, kubectl and declarative resources -- while Vey''s rush to retire metrics-collector-01 creates a brand-new version of the exact same problem.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-the-orchestrator-1', 'campaign-atlas-the-orchestrator', 'a-cluster-built-from-nothing', 'A Cluster Built From Nothing', 'Why Kubernetes, the cluster model, the control plane, nodes, Pods and ReplicaSets.', 1),
  ('operation-atlas-the-orchestrator-2', 'campaign-atlas-the-orchestrator', 'nothing-was-watching-it', 'Nothing Was Watching It', 'Deployments, Services, namespaces, kubectl and declarative resources.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-the-orchestrator-01', 'world-atlas-the-orchestrator', 'campaign-atlas-the-orchestrator', 'operation-atlas-the-orchestrator-1', 'why-kubernetes', 'Why Kubernetes', 'Vey deployed metrics-collector-01''s replacement onto the brand-new cluster as fast as possible. Forty minutes later, it is gone.', 'beginner', ARRAY['leena','vey'], null, null, '{"type":"simulation","simulationId":"why-kubernetes-sim"}'::jsonb, '{"xp":320,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-the-orchestrator-02', 'world-atlas-the-orchestrator', 'campaign-atlas-the-orchestrator', 'operation-atlas-the-orchestrator-1', 'cluster-model', 'Cluster Model', 'Understand the actual split between what decides and what runs.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-orchestrator-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"cluster-model-sim"}'::jsonb, '{"xp":320,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-the-orchestrator-03', 'world-atlas-the-orchestrator', 'campaign-atlas-the-orchestrator', 'operation-atlas-the-orchestrator-1', 'control-plane', 'Control Plane', 'Confirm what actually makes the decisions for this cluster.', 'beginner', ARRAY['vey','rook'], '{"requiredMissionIds":["mission-atlas-the-orchestrator-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"control-plane-sim"}'::jsonb, '{"xp":330,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-the-orchestrator-04', 'world-atlas-the-orchestrator', 'campaign-atlas-the-orchestrator', 'operation-atlas-the-orchestrator-1', 'nodes', 'Nodes', 'Confirm exactly which machines are actually available to run anything right now.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-orchestrator-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"nodes-sim"}'::jsonb, '{"xp":330,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-the-orchestrator-05', 'world-atlas-the-orchestrator', 'campaign-atlas-the-orchestrator', 'operation-atlas-the-orchestrator-1', 'pods', 'Pods', 'Confirm exactly how collector-pod-zero was actually deployed.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-orchestrator-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"pods-sim"}'::jsonb, '{"xp":340,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-the-orchestrator-06', 'world-atlas-the-orchestrator', 'campaign-atlas-the-orchestrator', 'operation-atlas-the-orchestrator-1', 'replicasets', 'ReplicaSets', 'Understand what actually keeps a set number of pods alive without anyone watching a dashboard.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-the-orchestrator-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"replicasets-sim"}'::jsonb, '{"xp":340,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-the-orchestrator-07', 'world-atlas-the-orchestrator', 'campaign-atlas-the-orchestrator', 'operation-atlas-the-orchestrator-2', 'deployments', 'Deployments', 'Confirm how a completely different service in this same cluster is actually protected.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-the-orchestrator-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"deployments-sim"}'::jsonb, '{"xp":350,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-the-orchestrator-08', 'world-atlas-the-orchestrator', 'campaign-atlas-the-orchestrator', 'operation-atlas-the-orchestrator-2', 'services', 'Services', 'Confirm how anything else is actually supposed to reach this workload, regardless of which pod is currently running it.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-orchestrator-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"services-sim"}'::jsonb, '{"xp":350,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-the-orchestrator-09', 'world-atlas-the-orchestrator', 'campaign-atlas-the-orchestrator', 'operation-atlas-the-orchestrator-2', 'namespaces', 'Namespaces', 'Confirm how this one cluster actually keeps different teams'' workloads separate.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-orchestrator-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"namespaces-sim"}'::jsonb, '{"xp":350,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-the-orchestrator-10', 'world-atlas-the-orchestrator', 'campaign-atlas-the-orchestrator', 'operation-atlas-the-orchestrator-2', 'kubectl', 'kubectl', 'Confirm the actual commands used to inspect anything running in this cluster.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-orchestrator-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"kubectl-sim"}'::jsonb, '{"xp":360,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-the-orchestrator-11', 'world-atlas-the-orchestrator', 'campaign-atlas-the-orchestrator', 'operation-atlas-the-orchestrator-2', 'declarative-resources', 'Declarative Resources', 'Understand why nobody ever tells this cluster what to do step by step.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-the-orchestrator-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"declarative-resources-sim"}'::jsonb, '{"xp":360,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-the-orchestrator-12', 'world-atlas-the-orchestrator', 'campaign-atlas-the-orchestrator', 'operation-atlas-the-orchestrator-2', 'pod-zero', 'Pod Zero', 'Everything this Act taught, turned on one missing pod: not to just redeploy it and move on, to finally explain how the fastest fix for one snowflake quietly became a brand-new version of it.', 'boss', ARRAY['vey','rook','cross','leena'], '{"requiredMissionIds":["mission-atlas-the-orchestrator-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"pod-zero-boss-sim"}'::jsonb, '{"xp":620,"credits":145,"badgeIds":["pod-zero"],"skillXp":{"cloud_devops_fundamentals":100}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-the-orchestrator-01', 1, 'leena', 'Vey deployed metrics-collector-01''s replacement onto the brand-new cluster as fast as possible, to finally retire the snowflake from Act 16. Forty minutes later, it is gone.'),
  ('mission-atlas-the-orchestrator-01', 2, 'vey', 'Tomas Vey. Kubernetes runs and heals containerized workloads at a scale no human, and no Ansible playbook, can watch by hand -- restarting what fails, rescheduling what disappears, entirely on its own. That is exactly what was supposed to happen here.'),

  ('mission-atlas-the-orchestrator-02', 1, 'vey', 'A cluster splits cleanly into two halves: something that decides what should be running, and something else that actually runs it. Confuse which one you are looking at, and nothing after this makes sense.'),

  ('mission-atlas-the-orchestrator-03', 1, 'rook', 'The control plane is the half that decides -- API server, scheduler, controller manager, all backed by etcd as the source of truth. Confirm it is actually up before assuming anything else.'),

  ('mission-atlas-the-orchestrator-04', 1, 'vey', 'Nodes are the half that actually runs things -- real machines, with real capacity. Confirm which ones are actually available right now.'),

  ('mission-atlas-the-orchestrator-05', 1, 'vey', 'A Pod is the smallest thing Kubernetes actually schedules. Confirm exactly how collector-pod-zero was declared.'),

  ('mission-atlas-the-orchestrator-06', 1, 'rook', 'A ReplicaSet does one job: keep a fixed number of pods running, always. Lose one, and it schedules a replacement without anyone asking. That is the entire point.'),

  ('mission-atlas-the-orchestrator-07', 1, 'rook', 'This is a different service in this same cluster. Confirm what is actually standing between it and disappearing the same way collector-pod-zero did.'),

  ('mission-atlas-the-orchestrator-08', 1, 'vey', 'Pods come and go, and their addresses change every time. A Service gives whatever is behind it one stable identity, regardless of which specific pod currently answers.'),

  ('mission-atlas-the-orchestrator-09', 1, 'vey', 'One cluster, several teams, several concerns -- namespaces keep them from colliding with each other. Confirm how this one is actually organized.'),

  ('mission-atlas-the-orchestrator-10', 1, 'vey', 'kubectl is the one tool used to inspect and manage everything in this cluster. Confirm the commands actually being used here.'),

  ('mission-atlas-the-orchestrator-11', 1, 'rook', 'Nobody ever tells this cluster what to do step by step. You declare the state you want, and the cluster continuously works to make reality match it -- the same principle Act 14 already taught for infrastructure, now applied to workloads.'),

  ('mission-atlas-the-orchestrator-12', 1, 'leena', 'Everything this Act taught you, on one missing pod. Not to just redeploy it and move on -- to finally explain how the fastest possible fix for one snowflake quietly became a brand-new version of the exact same problem.'),
  ('mission-atlas-the-orchestrator-12', 2, 'byte', 'I have the pod status and its own description both pulled up together. Nothing about this was an attack, and nothing about the cluster itself failed.'),
  ('mission-atlas-the-orchestrator-12', 3, 'cross', 'Imani Cross. A node draining for routine maintenance is not an incident on its own. What happens to the workload that was on it is the actual question.'),
  ('mission-atlas-the-orchestrator-12', 4, 'vey', 'Find out exactly what was, and was not, watching collector-pod-zero, and say plainly what has to replace it.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-the-orchestrator-01-o1', 'mission-atlas-the-orchestrator-01', 1, 'Explain why Kubernetes exists', 'Choose the accurate description of what Kubernetes actually provides.'),

  ('mission-atlas-the-orchestrator-02-o1', 'mission-atlas-the-orchestrator-02', 1, 'Explain the cluster model', 'Choose the accurate description of how a cluster is actually split.'),

  ('mission-atlas-the-orchestrator-03-o1', 'mission-atlas-the-orchestrator-03', 1, 'Read the control plane status', 'Read the cluster info and submit the verification code.'),

  ('mission-atlas-the-orchestrator-04-o1', 'mission-atlas-the-orchestrator-04', 1, 'Read the node list', 'Read the node list and submit the verification code.'),

  ('mission-atlas-the-orchestrator-05-o1', 'mission-atlas-the-orchestrator-05', 1, 'Read the Pod Zero manifest', 'Read the Pod manifest and submit the verification code.'),

  ('mission-atlas-the-orchestrator-06-o1', 'mission-atlas-the-orchestrator-06', 1, 'Explain ReplicaSets', 'Choose the accurate description of what a ReplicaSet actually guarantees.'),

  ('mission-atlas-the-orchestrator-07-o1', 'mission-atlas-the-orchestrator-07', 1, 'Read the Deployment', 'Read the Deployment manifest and submit the verification code.'),

  ('mission-atlas-the-orchestrator-08-o1', 'mission-atlas-the-orchestrator-08', 1, 'Read the Service', 'Read the Service manifest and submit the verification code.'),

  ('mission-atlas-the-orchestrator-09-o1', 'mission-atlas-the-orchestrator-09', 1, 'Read the namespace list', 'Read the namespace list and submit the verification code.'),

  ('mission-atlas-the-orchestrator-10-o1', 'mission-atlas-the-orchestrator-10', 1, 'Read the kubectl session', 'Read the kubectl command log and submit the verification code.'),

  ('mission-atlas-the-orchestrator-11-o1', 'mission-atlas-the-orchestrator-11', 1, 'Explain declarative resources', 'Choose the accurate description of what declarative management actually means.'),

  ('mission-atlas-the-orchestrator-12-o1', 'mission-atlas-the-orchestrator-12', 1, 'Confirm the pod is gone', 'Read the pod status and submit the verification code.'),
  ('mission-atlas-the-orchestrator-12-o2', 'mission-atlas-the-orchestrator-12', 2, 'Confirm it had no controller', 'Read the pod description and submit the verification code.'),
  ('mission-atlas-the-orchestrator-12-o3', 'mission-atlas-the-orchestrator-12', 3, 'Identify what actually explains this', 'Find the evidence that explains why collector-pod-zero was never rescheduled.'),
  ('mission-atlas-the-orchestrator-12-o4', 'mission-atlas-the-orchestrator-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to replace it.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-the-orchestrator-01-o1-c1', 'mission-atlas-the-orchestrator-01-o1', 1, 'multiple_choice', 'Kubernetes actually provides...', '{"question":"Kubernetes actually provides...","options":[{"id":"a","text":"Automated scheduling, restarting and rescheduling of containerized workloads at a scale no human or script can watch by hand"},{"id":"b","text":"A replacement for having any servers at all"},{"id":"c","text":"Guaranteed protection for every workload regardless of how it is deployed"},{"id":"d","text":"A synonym for a container registry"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-orchestrator-02-o1-c1', 'mission-atlas-the-orchestrator-02-o1', 1, 'multiple_choice', 'A Kubernetes cluster is actually split into...', '{"question":"A Kubernetes cluster is actually split into...","options":[{"id":"a","text":"A control plane that decides what should be running, and nodes that actually run it"},{"id":"b","text":"Only nodes -- there is no separate decision-making layer"},{"id":"c","text":"A single machine that does everything at once"},{"id":"d","text":"Front-end nodes and back-end nodes"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-orchestrator-03-o1-c1', 'mission-atlas-the-orchestrator-03-o1', 1, 'terminal_simulation', 'Read the cluster info and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/cluster-info.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/cluster-info.txt":{"type":"file","content":"Kubernetes control plane is running at https://atlas-cluster.internal:6443\ncore components: kube-apiserver, kube-scheduler, kube-controller-manager, etcd\n# the control plane decides what should run; nodes are where it actually runs\n# verification CONTROLPLANE-3312\n"}}}'::jsonb, '{"requiredFlag":"CONTROLPLANE-3312"}'::jsonb),

  ('mission-atlas-the-orchestrator-04-o1-c1', 'mission-atlas-the-orchestrator-04-o1', 1, 'terminal_simulation', 'Read the node list and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/nodes.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/nodes.txt":{"type":"file","content":"NAME             STATUS   ROLES    AGE\natlas-node-01    Ready    worker   14d\natlas-node-02    Ready    worker   14d\natlas-node-03    Ready    worker   2h\n# verification NODES-6602\n"}}}'::jsonb, '{"requiredFlag":"NODES-6602"}'::jsonb),

  ('mission-atlas-the-orchestrator-05-o1-c1', 'mission-atlas-the-orchestrator-05-o1', 1, 'terminal_simulation', 'Read the Pod manifest and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/pod-zero.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/pod-zero.yaml":{"type":"file","content":"apiVersion: v1\nkind: Pod\nmetadata:\n  name: collector-pod-zero\nspec:\n  containers:\n    - name: atlas-metrics-agent\n      image: atlas-images/atlas-metrics-agent:v13.0.0\n# deployed directly as a bare Pod, to replace metrics-collector-01 as fast as possible\n# verification PODZERO-7714\n"}}}'::jsonb, '{"requiredFlag":"PODZERO-7714"}'::jsonb),

  ('mission-atlas-the-orchestrator-06-o1-c1', 'mission-atlas-the-orchestrator-06-o1', 1, 'multiple_choice', 'A ReplicaSet actually guarantees that...', '{"question":"A ReplicaSet actually guarantees that...","options":[{"id":"a","text":"A fixed number of matching pods keeps running at all times, scheduling a replacement automatically the moment one disappears"},{"id":"b","text":"A pod will never be moved to a different node once scheduled"},{"id":"c","text":"Every pod it creates is automatically load balanced"},{"id":"d","text":"It only applies to stateless workloads"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-orchestrator-07-o1-c1', 'mission-atlas-the-orchestrator-07-o1', 1, 'terminal_simulation', 'Read the Deployment manifest and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/ci-runner-deployment.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/ci-runner-deployment.yaml":{"type":"file","content":"apiVersion: apps/v1\nkind: Deployment\nmetadata:\n  name: atlas-ci-runner\nspec:\n  replicas: 3\n  template:\n    spec:\n      containers:\n        - name: runner\n          image: atlas-images/ci-runner:v2.0.0\n# a Deployment manages a ReplicaSet automatically -- if a pod dies, a new one is scheduled without anyone asking\n# verification DEPLOYMENT-4471\n"}}}'::jsonb, '{"requiredFlag":"DEPLOYMENT-4471"}'::jsonb),

  ('mission-atlas-the-orchestrator-08-o1-c1', 'mission-atlas-the-orchestrator-08-o1', 1, 'terminal_simulation', 'Read the Service manifest and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-service.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-service.yaml":{"type":"file","content":"apiVersion: v1\nkind: Service\nmetadata:\n  name: collector-svc\nspec:\n  selector:\n    app: collector\n  ports:\n    - port: 9090\n# a stable network identity that routes to whichever pods currently match the selector\n# verification SERVICE-8802\n"}}}'::jsonb, '{"requiredFlag":"SERVICE-8802"}'::jsonb),

  ('mission-atlas-the-orchestrator-09-o1-c1', 'mission-atlas-the-orchestrator-09-o1', 1, 'terminal_simulation', 'Read the namespace list and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/namespaces.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/namespaces.txt":{"type":"file","content":"NAME             STATUS\ndefault          Active\natlas-metrics    Active\natlas-ci         Active\nkube-system      Active\n# verification NAMESPACE-2291\n"}}}'::jsonb, '{"requiredFlag":"NAMESPACE-2291"}'::jsonb),

  ('mission-atlas-the-orchestrator-10-o1-c1', 'mission-atlas-the-orchestrator-10-o1', 1, 'terminal_simulation', 'Read the kubectl command log and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/kubectl-session.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/kubectl-session.txt":{"type":"file","content":"$ kubectl get pods -n atlas-metrics\n$ kubectl describe pod collector-pod-zero -n atlas-metrics\n$ kubectl logs collector-pod-zero -n atlas-metrics\n# kubectl is the one tool used to inspect and manage everything in the cluster\n# verification KUBECTL-9012\n"}}}'::jsonb, '{"requiredFlag":"KUBECTL-9012"}'::jsonb),

  ('mission-atlas-the-orchestrator-11-o1-c1', 'mission-atlas-the-orchestrator-11-o1', 1, 'multiple_choice', 'Declarative management in Kubernetes actually means...', '{"question":"Declarative management in Kubernetes actually means...","options":[{"id":"a","text":"You declare the desired end state in a manifest, and the cluster continuously reconciles actual state toward it, rather than being told each step to take"},{"id":"b","text":"Every change must be applied manually, one command at a time"},{"id":"c","text":"Configuration can only ever be applied once, at cluster creation"},{"id":"d","text":"A synonym for imperative kubectl commands"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-orchestrator-12-o1-c1', 'mission-atlas-the-orchestrator-12-o1', 1, 'terminal_simulation', 'Read the pod status and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/pod-status.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/pod-status.txt":{"type":"file","content":"$ kubectl get pods -n atlas-metrics\nNAME   READY   STATUS    RESTARTS   AGE\n(no pods found matching collector-pod-zero)\n# collector-pod-zero has not existed since atlas-node-03 was drained for maintenance 40 minutes ago\n# verification PODSTATUS-4471\n"}}}'::jsonb, '{"requiredFlag":"PODSTATUS-4471"}'::jsonb),
  ('mission-atlas-the-orchestrator-12-o2-c1', 'mission-atlas-the-orchestrator-12-o2', 1, 'terminal_simulation', 'Read the pod description and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/pod-zero-describe.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/pod-zero-describe.txt":{"type":"file","content":"Name: collector-pod-zero\nControlled By: <none>\nNode: atlas-node-03 (drained 2026-08-16T14:00:00, pod not rescheduled)\n# verification DESCRIBE-8814\n"}}}'::jsonb, '{"requiredFlag":"DESCRIBE-8814"}'::jsonb),
  ('mission-atlas-the-orchestrator-12-o3-c1', 'mission-atlas-the-orchestrator-12-o3', 1, 'investigation', 'Which evidence explains why collector-pod-zero was never rescheduled?', '{"evidence":[{"id":"e1","label":"Pod status","detail":"collector-pod-zero no longer exists, since the node it was on was drained for routine maintenance 40 minutes ago"},{"id":"e2","label":"Pod description","detail":"Controlled By: none -- this pod was never owned by a ReplicaSet or Deployment"},{"id":"e3","label":"Deployment example","detail":"atlas-ci-runner, a different service in this same cluster, has 3 replicas managed by a real Deployment"},{"id":"e4","label":"Service manifest","detail":"collector-svc itself is unaffected and still routing correctly -- it simply has no healthy pod left to route to"}],"question":"Which evidence explains why collector-pod-zero was never rescheduled?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2"]}'::jsonb),
  ('mission-atlas-the-orchestrator-12-o4-c1', 'mission-atlas-the-orchestrator-12-o4', 1, 'boss_encounter', 'Having confirmed the pod is gone, that it had no controller, and what explains this, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-the-orchestrator-12-o1","label":"Confirm the pod is gone"},{"objectiveRef":"mission-atlas-the-orchestrator-12-o2","label":"Confirm it had no controller"},{"objectiveRef":"mission-atlas-the-orchestrator-12-o3","label":"Identify what actually explains this"}],"task":"State the diagnosis in one sentence: collector-pod-zero was deployed as a bare, uncontrolled Pod specifically to retire the Act 16 snowflake as fast as possible, and when its node was drained for routine maintenance, nothing rescheduled it because nothing owned it -- the fix is to redeploy it as a real Deployment so the cluster itself guarantees a replacement gets scheduled automatically, so the fastest fix for one unmanaged host does not quietly become a brand-new unmanaged workload in its place."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-the-orchestrator-12-o1","mission-atlas-the-orchestrator-12-o2","mission-atlas-the-orchestrator-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-the-orchestrator-01-o1-c1', 'orientation', 'Think about what happens automatically when something crashes or a node disappears.', 10, 1),
  ('mission-atlas-the-orchestrator-01-o1-c1', 'solution', 'Kubernetes automates scheduling, restarting and rescheduling at a scale nobody could watch by hand.', 20, 2),

  ('mission-atlas-the-orchestrator-02-o1-c1', 'orientation', 'Think about deciding versus doing.', 10, 1),
  ('mission-atlas-the-orchestrator-02-o1-c1', 'solution', 'A control plane decides; nodes actually run the work.', 20, 2),

  ('mission-atlas-the-orchestrator-03-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/cluster-info.txt', 10, 1),
  ('mission-atlas-the-orchestrator-03-o1-c1', 'solution', 'The control plane is up, verification CONTROLPLANE-3312. submit CONTROLPLANE-3312', 20, 2),

  ('mission-atlas-the-orchestrator-04-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/nodes.txt', 10, 1),
  ('mission-atlas-the-orchestrator-04-o1-c1', 'solution', 'All three nodes are Ready, verification NODES-6602. submit NODES-6602', 20, 2),

  ('mission-atlas-the-orchestrator-05-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/pod-zero.yaml', 10, 1),
  ('mission-atlas-the-orchestrator-05-o1-c1', 'solution', 'It is a bare Pod, verification PODZERO-7714. submit PODZERO-7714', 20, 2),

  ('mission-atlas-the-orchestrator-06-o1-c1', 'orientation', 'Think about what happens the moment a matching pod disappears.', 10, 1),
  ('mission-atlas-the-orchestrator-06-o1-c1', 'solution', 'A fixed number of pods is guaranteed, with automatic replacement.', 20, 2),

  ('mission-atlas-the-orchestrator-07-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/ci-runner-deployment.yaml', 10, 1),
  ('mission-atlas-the-orchestrator-07-o1-c1', 'solution', 'It has 3 replicas via a real Deployment, verification DEPLOYMENT-4471. submit DEPLOYMENT-4471', 20, 2),

  ('mission-atlas-the-orchestrator-08-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-service.yaml', 10, 1),
  ('mission-atlas-the-orchestrator-08-o1-c1', 'solution', 'The Service routes by label selector, verification SERVICE-8802. submit SERVICE-8802', 20, 2),

  ('mission-atlas-the-orchestrator-09-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/namespaces.txt', 10, 1),
  ('mission-atlas-the-orchestrator-09-o1-c1', 'solution', 'Four namespaces are active, verification NAMESPACE-2291. submit NAMESPACE-2291', 20, 2),

  ('mission-atlas-the-orchestrator-10-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/kubectl-session.txt', 10, 1),
  ('mission-atlas-the-orchestrator-10-o1-c1', 'solution', 'get, describe and logs are all used, verification KUBECTL-9012. submit KUBECTL-9012', 20, 2),

  ('mission-atlas-the-orchestrator-11-o1-c1', 'orientation', 'Think about telling the cluster what you want versus telling it what to do.', 10, 1),
  ('mission-atlas-the-orchestrator-11-o1-c1', 'solution', 'You declare desired state; the cluster continuously reconciles toward it.', 20, 2),

  ('mission-atlas-the-orchestrator-12-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/pod-status.txt', 10, 1),
  ('mission-atlas-the-orchestrator-12-o1-c1', 'solution', 'The pod no longer exists, verification PODSTATUS-4471. submit PODSTATUS-4471', 20, 2),
  ('mission-atlas-the-orchestrator-12-o2-c1', 'orientation', 'Try: cat /var/atlas-k8s/pod-zero-describe.txt', 10, 1),
  ('mission-atlas-the-orchestrator-12-o2-c1', 'solution', 'Controlled By is none, verification DESCRIBE-8814. submit DESCRIBE-8814', 20, 2),
  ('mission-atlas-the-orchestrator-12-o3-c1', 'orientation', 'The Deployment example and the Service manifest are both fine and irrelevant to why this specific pod vanished. Look at the pod status and its own description together.', 10, 1),
  ('mission-atlas-the-orchestrator-12-o3-c1', 'solution', 'e1 and e2: the pod is gone after a routine node drain, and it was never owned by any controller that could reschedule it.', 20, 2),
  ('mission-atlas-the-orchestrator-12-o4-c1', 'orientation', 'Combine the missing pod, the missing controller, and what should replace it into one sentence.', 15, 1),
  ('mission-atlas-the-orchestrator-12-o4-c1', 'solution', 'A bare Pod with no controller was never rescheduled after a routine node drain -- redeploy it as a Deployment so the cluster itself guarantees a replacement.', 25, 2);
