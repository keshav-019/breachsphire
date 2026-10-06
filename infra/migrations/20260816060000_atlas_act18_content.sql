-- Atlas Division pathway ("The Silence") Act 18 -- "Discovery"
-- content, under world-atlas-discovery (already inserted separately).
-- 1 campaign, 2 operations, 12 missions (11 lessons + boss), continuing
-- World VI "The Cluster Sea".
--
-- Same terminal-engine constraint as every prior Atlas Act -- every
-- Kubernetes networking artifact here is static seeded text read via
-- `cat`. Two hosts, both reused from Act 17: `atlas-devbox-01` for
-- declared YAML manifests (Services, Ingress, NetworkPolicy) and
-- `atlas-k8s-01` for live cluster state (CoreDNS status, pod status,
-- endpoints, a connection test). Purely conceptual topics with no
-- natural artifact (cluster networking, controllers, CNI concepts, the
-- Gateway API) stay multiple_choice.
--
-- Narrative thread: mission 9 plants the setup -- Cross''s new
-- NetworkPolicy only allows ingress from the one namespace she could
-- confirm needed it. The boss rules out every generic cause one at a
-- time (healthy pods, populated endpoints, working DNS -- all
-- established as clean) before a fresh connection test reveals the
-- load balancer''s health check, running from kube-system, was never
-- included in the policy''s allowed sources -- the same "scoped to what
-- was understood, not to reality" pattern as Act 13's IAM role, now in
-- network policy instead of cloud identity.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-discovery', 'world-atlas-discovery', 'discovery', '6B - Discovery', 'Learn Kubernetes networking from first principles -- cluster networking, service discovery, ClusterIP, NodePort, LoadBalancer, Ingress, controllers, DNS, NetworkPolicy, CNI concepts and the Gateway API -- while Cross''s own security hardening quietly blocks the one traffic source nobody thought to name.', 2);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-discovery-1', 'campaign-atlas-discovery', 'finding-anything-in-here', 'Finding Anything in Here', 'Cluster networking, service discovery, ClusterIP, NodePort, LoadBalancer and Ingress.', 1),
  ('operation-atlas-discovery-2', 'campaign-atlas-discovery', 'scoped-for-what-was-known', 'Scoped for What Was Known', 'Controllers, DNS, NetworkPolicy, CNI concepts and the Gateway API.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-discovery-01', 'world-atlas-discovery', 'campaign-atlas-discovery', 'operation-atlas-discovery-1', 'cluster-networking', 'Cluster Networking', 'Pod Zero is finally a real Deployment. Cross starts hardening its network access.', 'beginner', ARRAY['leena','cross'], null, null, '{"type":"simulation","simulationId":"cluster-networking-sim"}'::jsonb, '{"xp":340,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-discovery-02', 'world-atlas-discovery', 'campaign-atlas-discovery', 'operation-atlas-discovery-1', 'service-discovery', 'Service Discovery', 'Confirm how anything in this cluster actually finds the collector without ever hardcoding an IP.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-discovery-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"service-discovery-sim"}'::jsonb, '{"xp":340,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-discovery-03', 'world-atlas-discovery', 'campaign-atlas-discovery', 'operation-atlas-discovery-1', 'clusterip', 'ClusterIP', 'Confirm exactly who is actually allowed to reach this address.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-discovery-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"clusterip-sim"}'::jsonb, '{"xp":350,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-discovery-04', 'world-atlas-discovery', 'campaign-atlas-discovery', 'operation-atlas-discovery-1', 'nodeport', 'NodePort', 'Confirm a simpler way something gets exposed outside the cluster entirely.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-discovery-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"nodeport-sim"}'::jsonb, '{"xp":350,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-discovery-05', 'world-atlas-discovery', 'campaign-atlas-discovery', 'operation-atlas-discovery-1', 'loadbalancer', 'LoadBalancer', 'Confirm what actually gets provisioned the moment a Service asks for one.', 'beginner', ARRAY['cross','vey'], '{"requiredMissionIds":["mission-atlas-discovery-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"loadbalancer-sim"}'::jsonb, '{"xp":360,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-discovery-06', 'world-atlas-discovery', 'campaign-atlas-discovery', 'operation-atlas-discovery-1', 'ingress', 'Ingress', 'Confirm how several different services actually share one entrypoint instead of each needing their own.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-discovery-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"ingress-sim"}'::jsonb, '{"xp":360,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-discovery-07', 'world-atlas-discovery', 'campaign-atlas-discovery', 'operation-atlas-discovery-2', 'controllers', 'Controllers', 'Understand why an Ingress resource by itself does not actually route a single request.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-discovery-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"controllers-sim"}'::jsonb, '{"xp":370,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-discovery-08', 'world-atlas-discovery', 'campaign-atlas-discovery', 'operation-atlas-discovery-2', 'dns', 'DNS', 'Confirm the cluster''s own name resolution is actually working before assuming anything else is wrong.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-discovery-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"dns-k8s-sim"}'::jsonb, '{"xp":370,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-discovery-09', 'world-atlas-discovery', 'campaign-atlas-discovery', 'operation-atlas-discovery-2', 'networkpolicy', 'NetworkPolicy', 'Confirm exactly what Cross''s new policy actually allows in, and from where.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-discovery-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"networkpolicy-sim"}'::jsonb, '{"xp":380,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-discovery-10', 'world-atlas-discovery', 'campaign-atlas-discovery', 'operation-atlas-discovery-2', 'cni-concepts', 'CNI Concepts', 'Understand what actually enforces pod networking and policy underneath every abstraction taught so far.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-discovery-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"cni-concepts-sim"}'::jsonb, '{"xp":380,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-discovery-11', 'world-atlas-discovery', 'campaign-atlas-discovery', 'operation-atlas-discovery-2', 'gateway-api', 'Gateway API', 'Understand what the newer alternative to Ingress actually offers that Ingress does not.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-discovery-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"gateway-api-sim"}'::jsonb, '{"xp":380,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-discovery-12', 'world-atlas-discovery', 'campaign-atlas-discovery', 'operation-atlas-discovery-2', 'service-unreachable', 'Service Unreachable', 'Everything this Act taught, turned on one silent failure: not to just widen the policy and hope, to finally explain how a healthy service with correct endpoints and working DNS can still answer nobody.', 'boss', ARRAY['cross','rook','vey','leena'], '{"requiredMissionIds":["mission-atlas-discovery-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"service-unreachable-boss-sim"}'::jsonb, '{"xp":640,"credits":150,"badgeIds":["service-unreachable"],"skillXp":{"cloud_devops_fundamentals":105}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-discovery-01', 1, 'leena', 'Pod Zero is finally a real Deployment. Cross is hardening its network access next -- exactly what should be allowed to reach it, and nothing more.'),
  ('mission-atlas-discovery-01', 2, 'cross', 'Imani Cross. Every pod gets its own real IP address in a flat network -- any pod can reach any other pod directly, across any node, by default. That default is exactly what I am about to narrow.'),

  ('mission-atlas-discovery-02', 1, 'cross', 'Nothing in this cluster should ever hardcode another pod''s IP -- pods come and go, and addresses change every time. Confirm how service discovery actually resolves a name instead.'),

  ('mission-atlas-discovery-03', 1, 'cross', 'A ClusterIP is only ever reachable from inside the cluster -- a stable virtual address, never exposed outward on its own. Confirm it.'),

  ('mission-atlas-discovery-04', 1, 'cross', 'A NodePort is the simplest way out -- one fixed port, opened on every single node. Simple, and exactly as exposed as that sounds. Confirm it.'),

  ('mission-atlas-discovery-05', 1, 'vey', 'Tomas Vey. A LoadBalancer-type Service does not just open a port -- it actually provisions a real load balancer through the cloud provider, the exact same ALB concept from Act 12, now automated by Kubernetes itself.'),

  ('mission-atlas-discovery-06', 1, 'cross', 'One Ingress can route by hostname and path to several completely different services, instead of every service needing its own external load balancer. Confirm how this one is actually routed.'),

  ('mission-atlas-discovery-07', 1, 'rook', 'An Ingress resource by itself is just a declaration -- nothing routes a single request until an Ingress controller is actually watching for it and doing the work. The resource and the thing enforcing it are never the same object.'),

  ('mission-atlas-discovery-08', 1, 'cross', 'Before assuming anything about the network is broken, confirm the cluster can even resolve its own service names correctly.'),

  ('mission-atlas-discovery-09', 1, 'cross', 'This is the policy I just added. Confirm exactly what it actually allows in, and where that traffic has to come from.'),

  ('mission-atlas-discovery-10', 1, 'rook', 'Every Service, every NetworkPolicy, every abstraction this Act has taught is enforced somewhere underneath by the CNI plugin -- the actual layer wiring pod networking and policy into the real network. Kubernetes describes the rules; the CNI is what makes them real.'),

  ('mission-atlas-discovery-11', 1, 'rook', 'Gateway API is a newer, more expressive alternative to Ingress -- more explicit about who owns which part of the routing configuration. Ingress still works here. This is what eventually replaces it.'),

  ('mission-atlas-discovery-12', 1, 'leena', 'Everything this Act taught you, on one silent failure. Not to just widen the policy and hope -- to finally explain how a healthy service, with correct endpoints and working DNS, can still answer nobody at all.'),
  ('mission-atlas-discovery-12', 2, 'byte', 'I have the pod status, the endpoints, and a fresh connection test all pulled up together. Every generic explanation so far has come back clean.'),
  ('mission-atlas-discovery-12', 3, 'cross', 'I scoped that policy to exactly what I could confirm needed access at the time. If something real got left out, that is worth finding honestly, not defending.'),
  ('mission-atlas-discovery-12', 4, 'rook', 'Find exactly who is actually being blocked, and say plainly what the policy has to include now.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-discovery-01-o1', 'mission-atlas-discovery-01', 1, 'Explain cluster networking', 'Choose the accurate description of how pods are actually networked by default.'),

  ('mission-atlas-discovery-02-o1', 'mission-atlas-discovery-02', 1, 'Read the service discovery notes', 'Read the service discovery notes and submit the verification code.'),

  ('mission-atlas-discovery-03-o1', 'mission-atlas-discovery-03', 1, 'Read the ClusterIP Service', 'Read the ClusterIP Service definition and submit the verification code.'),

  ('mission-atlas-discovery-04-o1', 'mission-atlas-discovery-04', 1, 'Read the NodePort Service', 'Read the NodePort Service definition and submit the verification code.'),

  ('mission-atlas-discovery-05-o1', 'mission-atlas-discovery-05', 1, 'Read the LoadBalancer Service', 'Read the LoadBalancer Service definition and submit the verification code.'),

  ('mission-atlas-discovery-06-o1', 'mission-atlas-discovery-06', 1, 'Read the Ingress resource', 'Read the Ingress resource and submit the verification code.'),

  ('mission-atlas-discovery-07-o1', 'mission-atlas-discovery-07', 1, 'Explain Ingress controllers', 'Choose the accurate description of what an Ingress controller actually does.'),

  ('mission-atlas-discovery-08-o1', 'mission-atlas-discovery-08', 1, 'Read the DNS status', 'Read the CoreDNS status and submit the verification code.'),

  ('mission-atlas-discovery-09-o1', 'mission-atlas-discovery-09', 1, 'Read the NetworkPolicy', 'Read the NetworkPolicy definition and submit the verification code.'),

  ('mission-atlas-discovery-10-o1', 'mission-atlas-discovery-10', 1, 'Explain CNI concepts', 'Choose the accurate description of what a CNI plugin actually does.'),

  ('mission-atlas-discovery-11-o1', 'mission-atlas-discovery-11', 1, 'Explain the Gateway API', 'Choose the accurate description of what the Gateway API actually offers over Ingress.'),

  ('mission-atlas-discovery-12-o1', 'mission-atlas-discovery-12', 1, 'Confirm the pods are healthy', 'Read the pod status and submit the verification code.'),
  ('mission-atlas-discovery-12-o2', 'mission-atlas-discovery-12', 2, 'Confirm the Service has endpoints', 'Read the endpoints and submit the verification code.'),
  ('mission-atlas-discovery-12-o3', 'mission-atlas-discovery-12', 3, 'Identify what actually explains this', 'Find the evidence that explains why the service is unreachable.'),
  ('mission-atlas-discovery-12-o4', 'mission-atlas-discovery-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-discovery-01-o1-c1', 'mission-atlas-discovery-01-o1', 1, 'multiple_choice', 'By default, pod networking in a Kubernetes cluster means...', '{"question":"By default, pod networking in a Kubernetes cluster means...","options":[{"id":"a","text":"Every pod gets its own real IP address in a flat network, and any pod can reach any other pod directly, across any node"},{"id":"b","text":"Pods can only ever communicate through a Service, never directly"},{"id":"c","text":"Every pod shares one IP address with every other pod on the same node"},{"id":"d","text":"Pods cannot communicate across different nodes at all"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-discovery-02-o1-c1', 'mission-atlas-discovery-02-o1', 1, 'terminal_simulation', 'Read the service discovery notes and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/service-discovery-notes.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/service-discovery-notes.txt":{"type":"file","content":"any pod in this cluster can reach the collector service at:\n  collector-svc.atlas-metrics.svc.cluster.local\nno IP address ever needs to be hardcoded -- Kubernetes resolves the name to whichever healthy pods currently back it\n# verification DISCOVERY-3312\n"}}}'::jsonb, '{"requiredFlag":"DISCOVERY-3312"}'::jsonb),

  ('mission-atlas-discovery-03-o1-c1', 'mission-atlas-discovery-03-o1', 1, 'terminal_simulation', 'Read the ClusterIP Service definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-service.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-service.yaml":{"type":"file","content":"apiVersion: v1\nkind: Service\nmetadata:\n  name: collector-svc\nspec:\n  type: ClusterIP\n  clusterIP: 10.96.14.22\n  selector:\n    app: collector\n  ports:\n    - port: 9090\n# only reachable from inside the cluster\n# verification CLUSTERIP-6602\n"}}}'::jsonb, '{"requiredFlag":"CLUSTERIP-6602"}'::jsonb),

  ('mission-atlas-discovery-04-o1-c1', 'mission-atlas-discovery-04-o1', 1, 'terminal_simulation', 'Read the NodePort Service definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/debug-nodeport.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/debug-nodeport.yaml":{"type":"file","content":"apiVersion: v1\nkind: Service\nmetadata:\n  name: debug-console\nspec:\n  type: NodePort\n  ports:\n    - port: 8080\n      nodePort: 30080\n# reachable at any node''s IP on port 30080 -- simple, but exposes a fixed port on every node\n# verification NODEPORT-7714\n"}}}'::jsonb, '{"requiredFlag":"NODEPORT-7714"}'::jsonb),

  ('mission-atlas-discovery-05-o1-c1', 'mission-atlas-discovery-05-o1', 1, 'terminal_simulation', 'Read the LoadBalancer Service definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-lb.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-lb.yaml":{"type":"file","content":"apiVersion: v1\nkind: Service\nmetadata:\n  name: collector-external\nspec:\n  type: LoadBalancer\nstatus:\n  provisioned: atlas-global-lb\n# the same ALB concept from Act 12, now provisioned automatically by Kubernetes itself\n# verification LOADBALANCER-4471\n"}}}'::jsonb, '{"requiredFlag":"LOADBALANCER-4471"}'::jsonb),

  ('mission-atlas-discovery-06-o1-c1', 'mission-atlas-discovery-06-o1', 1, 'terminal_simulation', 'Read the Ingress resource and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-ingress.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-ingress.yaml":{"type":"file","content":"apiVersion: networking.k8s.io/v1\nkind: Ingress\nmetadata:\n  name: atlas-ingress\nspec:\n  rules:\n    - host: metrics.atlas.internal\n      http:\n        paths:\n          - path: /\n            backend:\n              service:\n                name: collector-svc\n                port: 9090\n# routes by hostname and path to different services behind one shared entrypoint\n# verification INGRESS-8802\n"}}}'::jsonb, '{"requiredFlag":"INGRESS-8802"}'::jsonb),

  ('mission-atlas-discovery-07-o1-c1', 'mission-atlas-discovery-07-o1', 1, 'multiple_choice', 'An Ingress controller actually does what an Ingress resource alone cannot?', '{"question":"An Ingress controller actually does what an Ingress resource alone cannot?","options":[{"id":"a","text":"It watches for Ingress resources and actually implements the routing they declare -- the resource is only ever a declaration, never the thing enforcing it"},{"id":"b","text":"It replaces the need for a Service entirely"},{"id":"c","text":"It only runs once, at cluster creation, and never again"},{"id":"d","text":"It is a synonym for a LoadBalancer-type Service"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-discovery-08-o1-c1', 'mission-atlas-discovery-08-o1', 1, 'terminal_simulation', 'Read the CoreDNS status and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/coredns-status.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/coredns-status.txt":{"type":"file","content":"coredns: 2/2 pods Running\n$ nslookup collector-svc.atlas-metrics.svc.cluster.local\n=> 10.96.14.22\n# DNS resolution inside the cluster is working correctly\n# verification DNS-2291\n"}}}'::jsonb, '{"requiredFlag":"DNS-2291"}'::jsonb),

  ('mission-atlas-discovery-09-o1-c1', 'mission-atlas-discovery-09-o1', 1, 'terminal_simulation', 'Read the NetworkPolicy definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-networkpolicy.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-networkpolicy.yaml":{"type":"file","content":"apiVersion: networking.k8s.io/v1\nkind: NetworkPolicy\nmetadata:\n  name: collector-restrict-ingress\nspec:\n  podSelector:\n    matchLabels:\n      app: collector\n  policyTypes:\n    - Ingress\n  ingress:\n    - from:\n        - namespaceSelector:\n            matchLabels:\n              team: atlas-ci\n# added to lock the collector down to only traffic Cross explicitly approved\n# verification NETPOL-9012\n"}}}'::jsonb, '{"requiredFlag":"NETPOL-9012"}'::jsonb),

  ('mission-atlas-discovery-10-o1-c1', 'mission-atlas-discovery-10-o1', 1, 'multiple_choice', 'A CNI plugin actually does what?', '{"question":"A CNI plugin actually does what?","options":[{"id":"a","text":"It is the layer underneath Kubernetes that actually implements pod networking and enforces NetworkPolicy rules on the real network"},{"id":"b","text":"It is only responsible for DNS resolution"},{"id":"c","text":"It replaces kubectl as the primary cluster management tool"},{"id":"d","text":"It only matters for clusters with a single node"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-discovery-11-o1-c1', 'mission-atlas-discovery-11-o1', 1, 'multiple_choice', 'The Gateway API actually offers over Ingress...', '{"question":"The Gateway API actually offers over Ingress...","options":[{"id":"a","text":"A more expressive, role-oriented model that is more explicit about which team owns which part of the routing configuration"},{"id":"b","text":"It is only a renamed version of Ingress with no functional difference"},{"id":"c","text":"It removes the need for a controller entirely"},{"id":"d","text":"It only works with NodePort-type Services"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-discovery-12-o1-c1', 'mission-atlas-discovery-12-o1', 1, 'terminal_simulation', 'Read the pod status and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/collector-pods-status.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/collector-pods-status.txt":{"type":"file","content":"NAME                          READY   STATUS    RESTARTS   AGE\ncollector-7f9b8c6d4-abcde      1/1     Running   0          2h\ncollector-7f9b8c6d4-fghij      1/1     Running   0          2h\n# all pods healthy and ready\n# verification PODSHEALTHY-3312\n"}}}'::jsonb, '{"requiredFlag":"PODSHEALTHY-3312"}'::jsonb),
  ('mission-atlas-discovery-12-o2-c1', 'mission-atlas-discovery-12-o2', 1, 'terminal_simulation', 'Read the endpoints and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/collector-endpoints.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/collector-endpoints.txt":{"type":"file","content":"$ kubectl get endpoints collector-svc -n atlas-metrics\nNAME            ENDPOINTS\ncollector-svc   10.40.1.14:9090,10.40.2.9:9090\n# the service has real, healthy endpoints behind it\n# verification ENDPOINTS-6602\n"}}}'::jsonb, '{"requiredFlag":"ENDPOINTS-6602"}'::jsonb),
  ('mission-atlas-discovery-12-o3-c1', 'mission-atlas-discovery-12-o3', 1, 'investigation', 'Which evidence explains why the service is unreachable?', '{"evidence":[{"id":"e1","label":"Pod status","detail":"Both collector pods are Running and 1/1 ready"},{"id":"e2","label":"Service endpoints","detail":"collector-svc has two real, healthy endpoints registered"},{"id":"e3","label":"DNS resolution","detail":"collector-svc.atlas-metrics.svc.cluster.local resolves correctly to its ClusterIP"},{"id":"e4","label":"NetworkPolicy","detail":"collector-restrict-ingress only allows traffic from the atlas-ci namespace"},{"id":"e5","label":"Connection test","detail":"A probe run from kube-system, the namespace the load balancer''s health check actually runs from, times out reaching the collector"}],"question":"Which evidence explains why the service is unreachable?"}'::jsonb, '{"requiredEvidenceIds":["e4","e5"]}'::jsonb),
  ('mission-atlas-discovery-12-o4-c1', 'mission-atlas-discovery-12-o4', 1, 'boss_encounter', 'Having confirmed the pods are healthy, the endpoints are correct, and what actually explains this, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-discovery-12-o1","label":"Confirm the pods are healthy"},{"objectiveRef":"mission-atlas-discovery-12-o2","label":"Confirm the Service has endpoints"},{"objectiveRef":"mission-atlas-discovery-12-o3","label":"Identify what actually explains this"}],"task":"State the diagnosis in one sentence: nothing was actually broken -- pods healthy, endpoints correct, DNS resolving -- but the NetworkPolicy only allows ingress from the atlas-ci namespace, and the load balancer''s own health check runs from kube-system, a source nobody thought to include when the policy was scoped to exactly what was understood at the time, and the fix is to add that source explicitly rather than widen the policy blindly."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-discovery-12-o1","mission-atlas-discovery-12-o2","mission-atlas-discovery-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-discovery-01-o1-c1', 'orientation', 'Think about whether pods need any special routing to reach each other by default.', 10, 1),
  ('mission-atlas-discovery-01-o1-c1', 'solution', 'Every pod gets its own IP in a flat network, reachable directly across nodes.', 20, 2),

  ('mission-atlas-discovery-02-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/service-discovery-notes.txt', 10, 1),
  ('mission-atlas-discovery-02-o1-c1', 'solution', 'Names resolve automatically, verification DISCOVERY-3312. submit DISCOVERY-3312', 20, 2),

  ('mission-atlas-discovery-03-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-service.yaml', 10, 1),
  ('mission-atlas-discovery-03-o1-c1', 'solution', 'It is ClusterIP, internal only, verification CLUSTERIP-6602. submit CLUSTERIP-6602', 20, 2),

  ('mission-atlas-discovery-04-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/debug-nodeport.yaml', 10, 1),
  ('mission-atlas-discovery-04-o1-c1', 'solution', 'Port 30080 on every node, verification NODEPORT-7714. submit NODEPORT-7714', 20, 2),

  ('mission-atlas-discovery-05-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-lb.yaml', 10, 1),
  ('mission-atlas-discovery-05-o1-c1', 'solution', 'A real ALB gets provisioned, verification LOADBALANCER-4471. submit LOADBALANCER-4471', 20, 2),

  ('mission-atlas-discovery-06-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-ingress.yaml', 10, 1),
  ('mission-atlas-discovery-06-o1-c1', 'solution', 'It routes by host and path, verification INGRESS-8802. submit INGRESS-8802', 20, 2),

  ('mission-atlas-discovery-07-o1-c1', 'orientation', 'Think about whether the resource itself does any routing on its own.', 10, 1),
  ('mission-atlas-discovery-07-o1-c1', 'solution', 'A controller actually implements what the Ingress resource only declares.', 20, 2),

  ('mission-atlas-discovery-08-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/coredns-status.txt', 10, 1),
  ('mission-atlas-discovery-08-o1-c1', 'solution', 'DNS resolves correctly, verification DNS-2291. submit DNS-2291', 20, 2),

  ('mission-atlas-discovery-09-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-networkpolicy.yaml', 10, 1),
  ('mission-atlas-discovery-09-o1-c1', 'solution', 'Only atlas-ci namespace traffic is allowed, verification NETPOL-9012. submit NETPOL-9012', 20, 2),

  ('mission-atlas-discovery-10-o1-c1', 'orientation', 'Think about what actually wires the abstractions into the real network.', 10, 1),
  ('mission-atlas-discovery-10-o1-c1', 'solution', 'The CNI plugin implements pod networking and enforces policy on the real network.', 20, 2),

  ('mission-atlas-discovery-11-o1-c1', 'orientation', 'Think about ownership and expressiveness, not just routing.', 10, 1),
  ('mission-atlas-discovery-11-o1-c1', 'solution', 'It is more expressive and explicit about who owns which part of routing.', 20, 2),

  ('mission-atlas-discovery-12-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/collector-pods-status.txt', 10, 1),
  ('mission-atlas-discovery-12-o1-c1', 'solution', 'Both pods are healthy, verification PODSHEALTHY-3312. submit PODSHEALTHY-3312', 20, 2),
  ('mission-atlas-discovery-12-o2-c1', 'orientation', 'Try: cat /var/atlas-k8s/collector-endpoints.txt', 10, 1),
  ('mission-atlas-discovery-12-o2-c1', 'solution', 'Two real endpoints exist, verification ENDPOINTS-6602. submit ENDPOINTS-6602', 20, 2),
  ('mission-atlas-discovery-12-o3-c1', 'orientation', 'Pods, endpoints and DNS are all fine and irrelevant to this specific failure. Look at the policy and who is actually being blocked.', 10, 1),
  ('mission-atlas-discovery-12-o3-c1', 'solution', 'e4 and e5: the policy only allows atlas-ci, and the health check runs from kube-system, which was never included.', 20, 2),
  ('mission-atlas-discovery-12-o4-c1', 'orientation', 'Combine the healthy pods, the correct endpoints, and the missing policy source into one sentence.', 15, 1),
  ('mission-atlas-discovery-12-o4-c1', 'solution', 'The service is genuinely healthy end to end -- the NetworkPolicy simply never included kube-system, where the load balancer''s health check actually runs from -- add that source explicitly.', 25, 2);
