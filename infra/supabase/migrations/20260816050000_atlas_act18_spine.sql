-- Atlas Division pathway ("The Silence"): World row for Act 18,
-- "Discovery", still under act-atlas-6 ("World VI -- The Cluster
-- Sea"). Content (missions) follows in its own migration.
--
-- Narrative thread: with collector-pod-zero finally running as a real
-- Deployment, Cross hardens its Service with a NetworkPolicy, scoped
-- to exactly the traffic she could confirm was legitimate at the time
-- -- and the load balancer's own health checks, running from a
-- namespace nobody thought to include, get silently dropped. Same
-- "least privilege scoped to what was understood, not to reality"
-- pattern as Act 13's IAM role, now in Kubernetes networking instead
-- of cloud identity.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-discovery', 'act-atlas-6', 17, 'discovery', 'Discovery', 'Discovery',
   'Cluster networking; service discovery; ClusterIP; NodePort; LoadBalancer; Ingress; controllers; DNS; NetworkPolicy; CNI concepts; the Gateway API.',
   'Pod Zero is finally a real Deployment. Cross adds a NetworkPolicy to lock its Service down to exactly the traffic she can confirm is legitimate -- and within the hour, the load balancer''s own health checks start failing. Every pod is healthy. Every endpoint is correct. Nothing responds anyway.',
   'Service Unreachable',
   'Nothing was ever actually broken -- the pods are healthy, the Service has real endpoints, DNS resolves correctly. The NetworkPolicy only allows ingress from the one namespace Cross could confirm needed it, and the load balancer''s health check runs from a completely different namespace nobody thought to include. Scoped correctly for what was understood, exactly like Act 13''s IAM role -- and exactly as incomplete once reality asked for something the design never accounted for.',
   'Every layer between a request and a healthy pod is now understood end to end, and secured to match what actually calls it, not just what was assumed to. The next question is what happens to everything this cluster is holding onto once a pod disappears and needs to come back exactly as it was.',
   'Service Unreachable', 'Network', 'guarded', 92, 20, 'pathway-atlas');
