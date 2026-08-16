-- Atlas Division pathway ("The Silence"): Act row for World VI -- "The
-- Cluster Sea" -- plus the World row for its first Act, "The
-- Orchestrator" (Kubernetes foundations). Content (missions) follows
-- in its own migration, same two-step pattern as every prior World.
--
-- Narrative thread: Act 16 diagnosed metrics-collector-01 as a
-- snowflake that needed replacing outright, not patching. Vey deploys
-- its replacement, `collector-pod-zero`, as fast as possible on the
-- team's brand-new Kubernetes cluster -- as a bare, uncontrolled Pod,
-- to get something running immediately. The exact same "nothing here
-- is actually watching this" pattern that made metrics-collector-01 a
-- snowflake resurfaces immediately in its own replacement, in a new
-- technology, until fixed properly.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-atlas-6', 5, 'the-cluster-sea', 'World VI -- The Cluster Sea',
   'Individual hosts, containers and configuration management have carried this story since Act 1. Vey stands up Atlas Division''s first real Kubernetes cluster and deploys metrics-collector-01''s replacement onto it immediately -- and in the rush to finally retire the pathway''s oldest snowflake, deploys it in the one way Kubernetes itself cannot protect. The player learns container orchestration end to end while discovering that speed and safety are not automatically the same thing, even inside a system built to be self-healing.',
   'Can configure and manage individual hosts safely -> understands container orchestration well enough to run workloads that heal themselves',
   'pathway-atlas');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-the-orchestrator', 'act-atlas-6', 16, 'the-orchestrator', 'The Orchestrator', 'The Orchestrator',
   'Why Kubernetes; the cluster model; the control plane; nodes; Pods; ReplicaSets; Deployments; Services; namespaces; kubectl; declarative resources.',
   'Vey deploys collector-pod-zero -- metrics-collector-01''s replacement -- onto the brand-new cluster as fast as possible, as a single bare Pod, just to finally retire the snowflake. Forty minutes later, a routine node drain for maintenance takes it down, and nothing brings it back.',
   'Pod Zero',
   'A bare Pod has no controller watching it -- no ReplicaSet, no Deployment, nothing reconciling its desired state back into existence. When its node was drained for routine maintenance, exactly like any other node in this cluster eventually will be, nothing rescheduled it, because nothing owned it. The same "nothing here is actually watching this" pattern that made metrics-collector-01 a snowflake in the first place resurfaced immediately in its own replacement -- just in a new technology.',
   'One pod, finally managed by a real controller instead of running bare, is the first workload in this cluster that can actually survive a node going away. The next question is how anything is even supposed to find it once there is more than one.',
   'Pod Zero', 'Boxes', 'elevated', 92, 12, 'pathway-atlas');
