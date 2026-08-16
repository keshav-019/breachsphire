-- Atlas Division pathway ("The Silence") Act 19 -- "State in the
-- Cluster" content, under world-atlas-state-in-the-cluster (already
-- inserted separately). 1 campaign, 2 operations, 12 missions (11
-- lessons + boss), continuing World VI "The Cluster Sea".
--
-- Same terminal-engine constraint as every prior Atlas Act -- every
-- Kubernetes state artifact here is static seeded text read via `cat`.
-- Two hosts, both reused from Acts 17-18: `atlas-devbox-01` for
-- declared YAML manifests and `atlas-k8s-01` for live cluster state
-- (pod status, PVC status). Only "daemonsets" (a pure scheduling
-- concept, no natural artifact needed beyond its own manifest, kept as
-- terminal like the rest for consistency) leans terminal-heavy overall
-- -- this Act has almost no pure-concept missions since nearly every
-- Kubernetes state primitive has a real manifest or status output
-- behind it.
--
-- Narrative thread: mission 2 (Secrets) lands this pathway's fourth
-- distinct secret-exposure mechanism -- Kubernetes Secrets are only
-- base64-encoded by default, not encrypted, a genuinely different
-- problem from Act 6 (git), Act 11 (static credential) and Act 15
-- (Terraform state plaintext). The boss reuses atlas-node-03, the same
-- node drained in Act 17, this time revealing that atlas-metrics-db's
-- StatefulSet and PersistentVolumeClaim were both configured correctly
-- -- the actual mistake was requesting node-local storage
-- (atlas-local-ssd) instead of real portable storage (atlas-ssd) for a
-- workload that needed to survive its node disappearing.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-state-in-the-cluster', 'world-atlas-state-in-the-cluster', 'state-in-the-cluster', '6C - State in the Cluster', 'Learn how Kubernetes actually holds onto state -- ConfigMaps, Secrets, Volumes, PersistentVolumes, PersistentVolumeClaims, StorageClasses, StatefulSets, headless Services, DaemonSets, Jobs and CronJobs -- while atlas-node-03 drains again and takes a database''s data down with it.', 3);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-state-in-the-cluster-1', 'campaign-atlas-state-in-the-cluster', 'what-a-pod-actually-holds', 'What a Pod Actually Holds', 'ConfigMaps, Secrets, Volumes, PersistentVolumes and PersistentVolumeClaims.', 1),
  ('operation-atlas-state-in-the-cluster-2', 'campaign-atlas-state-in-the-cluster', 'workloads-that-are-not-deployments', 'Workloads That Are Not Deployments', 'StorageClasses, StatefulSets, headless Services, DaemonSets, Jobs and CronJobs.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-state-in-the-cluster-01', 'world-atlas-state-in-the-cluster', 'campaign-atlas-state-in-the-cluster', 'operation-atlas-state-in-the-cluster-1', 'configmaps', 'ConfigMaps', 'Rook starts filling in what Kubernetes actually offers for holding onto data pods need.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"configmaps-sim"}'::jsonb, '{"xp":360,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-state-in-the-cluster-02', 'world-atlas-state-in-the-cluster', 'campaign-atlas-state-in-the-cluster', 'operation-atlas-state-in-the-cluster-1', 'secrets-k8s', 'Secrets', 'Confirm what a Kubernetes Secret actually protects, and what it does not.', 'beginner', ARRAY['rook','cross'], '{"requiredMissionIds":["mission-atlas-state-in-the-cluster-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"secrets-k8s-sim"}'::jsonb, '{"xp":360,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-state-in-the-cluster-03', 'world-atlas-state-in-the-cluster', 'campaign-atlas-state-in-the-cluster', 'operation-atlas-state-in-the-cluster-1', 'volumes-k8s', 'Volumes', 'Confirm exactly how long this kind of storage actually survives.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-in-the-cluster-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"volumes-k8s-sim"}'::jsonb, '{"xp":370,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-state-in-the-cluster-04', 'world-atlas-state-in-the-cluster', 'campaign-atlas-state-in-the-cluster', 'operation-atlas-state-in-the-cluster-1', 'pv', 'PersistentVolumes', 'Confirm what actually exists independently of any one pod or node.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-in-the-cluster-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"pv-sim"}'::jsonb, '{"xp":370,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-state-in-the-cluster-05', 'world-atlas-state-in-the-cluster', 'campaign-atlas-state-in-the-cluster', 'operation-atlas-state-in-the-cluster-1', 'pvc', 'PersistentVolumeClaims', 'Confirm how a pod actually asks for storage without ever naming a specific disk.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-in-the-cluster-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"pvc-sim"}'::jsonb, '{"xp":380,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-state-in-the-cluster-06', 'world-atlas-state-in-the-cluster', 'campaign-atlas-state-in-the-cluster', 'operation-atlas-state-in-the-cluster-2', 'storageclasses', 'StorageClasses', 'Confirm exactly what kind of disk actually gets created when a claim like this is requested.', 'beginner', ARRAY['rook','vey'], '{"requiredMissionIds":["mission-atlas-state-in-the-cluster-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"storageclasses-sim"}'::jsonb, '{"xp":380,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-state-in-the-cluster-07', 'world-atlas-state-in-the-cluster', 'campaign-atlas-state-in-the-cluster', 'operation-atlas-state-in-the-cluster-2', 'statefulsets', 'StatefulSets', 'Confirm how atlas-metrics-db actually gets a stable identity and its own storage, not a shared, interchangeable one.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-in-the-cluster-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"statefulsets-sim"}'::jsonb, '{"xp":390,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-state-in-the-cluster-08', 'world-atlas-state-in-the-cluster', 'campaign-atlas-state-in-the-cluster', 'operation-atlas-state-in-the-cluster-2', 'headless-services', 'Headless Services', 'Confirm how each individual replica actually gets its own reachable address.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-in-the-cluster-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"headless-services-sim"}'::jsonb, '{"xp":390,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-state-in-the-cluster-09', 'world-atlas-state-in-the-cluster', 'campaign-atlas-state-in-the-cluster', 'operation-atlas-state-in-the-cluster-2', 'daemonsets', 'DaemonSets', 'Confirm what actually guarantees exactly one of these on every single node.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-in-the-cluster-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"daemonsets-sim"}'::jsonb, '{"xp":390,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-state-in-the-cluster-10', 'world-atlas-state-in-the-cluster', 'campaign-atlas-state-in-the-cluster', 'operation-atlas-state-in-the-cluster-2', 'jobs', 'Jobs', 'Confirm what actually happens once this workload finishes, instead of running forever.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-in-the-cluster-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"jobs-sim"}'::jsonb, '{"xp":400,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-state-in-the-cluster-11', 'world-atlas-state-in-the-cluster', 'campaign-atlas-state-in-the-cluster', 'operation-atlas-state-in-the-cluster-2', 'cronjobs', 'CronJobs', 'Confirm exactly when this actually runs, and what creates it.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-state-in-the-cluster-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"cronjobs-sim"}'::jsonb, '{"xp":400,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-state-in-the-cluster-12', 'world-atlas-state-in-the-cluster', 'campaign-atlas-state-in-the-cluster', 'operation-atlas-state-in-the-cluster-2', 'the-vanishing-disk', 'The Vanishing Disk', 'Everything this Act taught, turned on one stuck pod: not to just wait for the node to come back, to finally explain how correctly-configured persistent storage can still strand real data forever.', 'boss', ARRAY['rook','vey','cross','leena'], '{"requiredMissionIds":["mission-atlas-state-in-the-cluster-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"vanishing-disk-boss-sim"}'::jsonb, '{"xp":660,"credits":155,"badgeIds":["the-vanishing-disk"],"skillXp":{"cloud_devops_fundamentals":105}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-state-in-the-cluster-01', 1, 'leena', 'atlas-node-03 is being drained again, this time for a disk firmware update. Rook is filling in what Kubernetes actually offers for holding onto data before that happens.'),
  ('mission-atlas-state-in-the-cluster-01', 2, 'rook', 'A ConfigMap holds non-sensitive configuration, injected into a pod as environment variables or mounted files, decoupled from the container image itself. Confirm what this one actually stores.'),

  ('mission-atlas-state-in-the-cluster-02', 1, 'cross', 'Imani Cross. After everything this pathway has already found -- a git leak, a static credential, plaintext in Terraform state -- I am checking every new storage mechanism for this on principle now.'),
  ('mission-atlas-state-in-the-cluster-02', 2, 'rook', 'Read the value carefully. A Kubernetes Secret is not encrypted by default -- it is only base64-encoded, readable by anyone who can read the object at all. Encoding is not encryption.'),

  ('mission-atlas-state-in-the-cluster-03', 1, 'rook', 'The simplest kind of storage lives and dies with the pod itself. Confirm exactly how long that actually lasts.'),

  ('mission-atlas-state-in-the-cluster-04', 1, 'rook', 'A PersistentVolume exists as its own real, cluster-level resource -- not tied to any one pod''s lifetime. Confirm it.'),

  ('mission-atlas-state-in-the-cluster-05', 1, 'rook', 'A pod never asks for a specific disk by name. It requests a PersistentVolumeClaim instead, and Kubernetes binds it to a matching PersistentVolume. Confirm how that actually works here.'),

  ('mission-atlas-state-in-the-cluster-06', 1, 'vey', 'Tomas Vey. A StorageClass is what actually decides what kind of disk gets created when a claim like this is requested -- and that choice matters more than most people assume.'),

  ('mission-atlas-state-in-the-cluster-07', 1, 'rook', 'atlas-metrics-db needs a stable identity and its own dedicated storage per replica, not something interchangeable. A StatefulSet is built for exactly that. Confirm how it is actually declared.'),

  ('mission-atlas-state-in-the-cluster-08', 1, 'rook', 'A regular Service load-balances across interchangeable pods. A StatefulSet''s replicas are not interchangeable -- a headless Service gives each one its own direct, individually addressable DNS entry instead.'),

  ('mission-atlas-state-in-the-cluster-09', 1, 'rook', 'A DaemonSet is not about a fixed replica count at all -- it guarantees exactly one matching pod on every node, automatically, including new nodes as they join later.'),

  ('mission-atlas-state-in-the-cluster-10', 1, 'rook', 'Not everything in this cluster is meant to run forever. A Job runs to completion once, then stops -- confirm what this one is actually for.'),

  ('mission-atlas-state-in-the-cluster-11', 1, 'rook', 'A CronJob does not run anything itself -- it creates a new Job on a schedule, automatically. Confirm exactly when this one actually fires.'),

  ('mission-atlas-state-in-the-cluster-12', 1, 'leena', 'Everything this Act taught you, on one stuck pod. Not to just wait for the node to come back -- to finally explain how correctly-configured persistent storage can still strand real data forever.'),
  ('mission-atlas-state-in-the-cluster-12', 2, 'byte', 'I have the pod status and the PVC status both pulled up together. atlas-metrics-db-0 has been stuck Pending for twelve minutes and counting.'),
  ('mission-atlas-state-in-the-cluster-12', 3, 'vey', 'Nothing was deleted. I already checked that much.'),
  ('mission-atlas-state-in-the-cluster-12', 4, 'rook', 'Then find exactly where that data actually still is, and why nothing in this cluster can reach it anymore.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-state-in-the-cluster-01-o1', 'mission-atlas-state-in-the-cluster-01', 1, 'Read the ConfigMap', 'Read the ConfigMap definition and submit the verification code.'),

  ('mission-atlas-state-in-the-cluster-02-o1', 'mission-atlas-state-in-the-cluster-02', 1, 'Read the Secret', 'Read the Secret definition and submit the verification code.'),

  ('mission-atlas-state-in-the-cluster-03-o1', 'mission-atlas-state-in-the-cluster-03', 1, 'Read the emptyDir volume', 'Read the volume definition and submit the verification code.'),

  ('mission-atlas-state-in-the-cluster-04-o1', 'mission-atlas-state-in-the-cluster-04', 1, 'Read the PersistentVolume list', 'Read the PersistentVolume list and submit the verification code.'),

  ('mission-atlas-state-in-the-cluster-05-o1', 'mission-atlas-state-in-the-cluster-05', 1, 'Read the PersistentVolumeClaim', 'Read the PersistentVolumeClaim and submit the verification code.'),

  ('mission-atlas-state-in-the-cluster-06-o1', 'mission-atlas-state-in-the-cluster-06', 1, 'Read the StorageClass', 'Read the StorageClass definition and submit the verification code.'),

  ('mission-atlas-state-in-the-cluster-07-o1', 'mission-atlas-state-in-the-cluster-07', 1, 'Read the StatefulSet', 'Read the StatefulSet definition and submit the verification code.'),

  ('mission-atlas-state-in-the-cluster-08-o1', 'mission-atlas-state-in-the-cluster-08', 1, 'Read the headless Service', 'Read the headless Service definition and submit the verification code.'),

  ('mission-atlas-state-in-the-cluster-09-o1', 'mission-atlas-state-in-the-cluster-09', 1, 'Read the DaemonSet', 'Read the DaemonSet definition and submit the verification code.'),

  ('mission-atlas-state-in-the-cluster-10-o1', 'mission-atlas-state-in-the-cluster-10', 1, 'Read the Job', 'Read the Job definition and submit the verification code.'),

  ('mission-atlas-state-in-the-cluster-11-o1', 'mission-atlas-state-in-the-cluster-11', 1, 'Read the CronJob', 'Read the CronJob definition and submit the verification code.'),

  ('mission-atlas-state-in-the-cluster-12-o1', 'mission-atlas-state-in-the-cluster-12', 1, 'Confirm the pod is stuck', 'Read the pod status and submit the verification code.'),
  ('mission-atlas-state-in-the-cluster-12-o2', 'mission-atlas-state-in-the-cluster-12', 2, 'Confirm the PVC binding', 'Read the PVC status and submit the verification code.'),
  ('mission-atlas-state-in-the-cluster-12-o3', 'mission-atlas-state-in-the-cluster-12', 3, 'Identify what actually explains this', 'Find the evidence that explains why this data cannot be reached from anywhere else in the cluster.'),
  ('mission-atlas-state-in-the-cluster-12-o4', 'mission-atlas-state-in-the-cluster-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-state-in-the-cluster-01-o1-c1', 'mission-atlas-state-in-the-cluster-01-o1', 1, 'terminal_simulation', 'Read the ConfigMap definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-configmap.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-configmap.yaml":{"type":"file","content":"apiVersion: v1\nkind: ConfigMap\nmetadata:\n  name: collector-config\ndata:\n  log_level: info\n  region: eu-west-1\n# non-sensitive configuration, injected into pods as env vars or mounted files\n# verification CONFIGMAP-3312\n"}}}'::jsonb, '{"requiredFlag":"CONFIGMAP-3312"}'::jsonb),

  ('mission-atlas-state-in-the-cluster-02-o1-c1', 'mission-atlas-state-in-the-cluster-02-o1', 1, 'terminal_simulation', 'Read the Secret definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/collector-secret.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/collector-secret.yaml":{"type":"file","content":"apiVersion: v1\nkind: Secret\nmetadata:\n  name: collector-db-creds\ntype: Opaque\ndata:\n  password: cGFzc3dvcmQxMjM=\n# that value is only base64-encoded, not encrypted -- readable by anyone who can read the Secret object at all\n# verification SECRET-6602\n"}}}'::jsonb, '{"requiredFlag":"SECRET-6602"}'::jsonb),

  ('mission-atlas-state-in-the-cluster-03-o1-c1', 'mission-atlas-state-in-the-cluster-03-o1', 1, 'terminal_simulation', 'Read the volume definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/scratch-volume.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/scratch-volume.yaml":{"type":"file","content":"apiVersion: v1\nkind: Pod\nmetadata:\n  name: scratch-pod\nspec:\n  volumes:\n    - name: scratch\n      emptyDir: {}\n# an emptyDir volume lives and dies with the pod -- gone the moment the pod is rescheduled anywhere else\n# verification VOLUME-7714\n"}}}'::jsonb, '{"requiredFlag":"VOLUME-7714"}'::jsonb),

  ('mission-atlas-state-in-the-cluster-04-o1-c1', 'mission-atlas-state-in-the-cluster-04-o1', 1, 'terminal_simulation', 'Read the PersistentVolume list and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/pv-list.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/pv-list.txt":{"type":"file","content":"NAME                  CAPACITY   RECLAIM POLICY   STATUS   CLAIM\natlas-metrics-pv-01   100Gi      Retain           Bound    atlas-metrics/metrics-pvc\n# a PersistentVolume exists independently of any one pod or node\n# verification PV-4471\n"}}}'::jsonb, '{"requiredFlag":"PV-4471"}'::jsonb),

  ('mission-atlas-state-in-the-cluster-05-o1-c1', 'mission-atlas-state-in-the-cluster-05-o1', 1, 'terminal_simulation', 'Read the PersistentVolumeClaim and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/metrics-pvc.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/metrics-pvc.yaml":{"type":"file","content":"apiVersion: v1\nkind: PersistentVolumeClaim\nmetadata:\n  name: metrics-pvc\nspec:\n  accessModes: [ReadWriteOnce]\n  resources:\n    requests:\n      storage: 100Gi\n# a pod requests storage through a claim -- it never talks to the PersistentVolume directly\n# verification PVC-8802\n"}}}'::jsonb, '{"requiredFlag":"PVC-8802"}'::jsonb),

  ('mission-atlas-state-in-the-cluster-06-o1-c1', 'mission-atlas-state-in-the-cluster-06-o1', 1, 'terminal_simulation', 'Read the StorageClass definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/storageclass.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/storageclass.yaml":{"type":"file","content":"apiVersion: storage.k8s.io/v1\nkind: StorageClass\nmetadata:\n  name: atlas-ssd\nprovisioner: ebs.csi.aws.com\nreclaimPolicy: Retain\n# a real, cloud-provisioned disk that is portable across nodes\n# verification STORAGECLASS-2291\n"}}}'::jsonb, '{"requiredFlag":"STORAGECLASS-2291"}'::jsonb),

  ('mission-atlas-state-in-the-cluster-07-o1-c1', 'mission-atlas-state-in-the-cluster-07-o1', 1, 'terminal_simulation', 'Read the StatefulSet definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/metrics-db-statefulset.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/metrics-db-statefulset.yaml":{"type":"file","content":"apiVersion: apps/v1\nkind: StatefulSet\nmetadata:\n  name: atlas-metrics-db\nspec:\n  serviceName: atlas-metrics-db\n  replicas: 1\n  volumeClaimTemplates:\n    - metadata:\n        name: data\n      spec:\n        accessModes: [ReadWriteOnce]\n        resources:\n          requests:\n            storage: 50Gi\n# each replica gets its own stable identity and its own persistent volume claim\n# verification STATEFULSET-9012\n"}}}'::jsonb, '{"requiredFlag":"STATEFULSET-9012"}'::jsonb),

  ('mission-atlas-state-in-the-cluster-08-o1-c1', 'mission-atlas-state-in-the-cluster-08-o1', 1, 'terminal_simulation', 'Read the headless Service definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/metrics-db-headless-service.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/metrics-db-headless-service.yaml":{"type":"file","content":"apiVersion: v1\nkind: Service\nmetadata:\n  name: atlas-metrics-db\nspec:\n  clusterIP: None\n  selector:\n    app: atlas-metrics-db\n# no virtual IP at all -- DNS returns each individual pod address directly\n# verification HEADLESS-3390\n"}}}'::jsonb, '{"requiredFlag":"HEADLESS-3390"}'::jsonb),

  ('mission-atlas-state-in-the-cluster-09-o1-c1', 'mission-atlas-state-in-the-cluster-09-o1', 1, 'terminal_simulation', 'Read the DaemonSet definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/log-agent-daemonset.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/log-agent-daemonset.yaml":{"type":"file","content":"apiVersion: apps/v1\nkind: DaemonSet\nmetadata:\n  name: atlas-log-agent\nspec:\n  template:\n    spec:\n      containers:\n        - name: log-agent\n          image: atlas-images/log-agent:v1.0.0\n# exactly one pod per node, automatically, on every node including new ones as they join\n# verification DAEMONSET-4471\n"}}}'::jsonb, '{"requiredFlag":"DAEMONSET-4471"}'::jsonb),

  ('mission-atlas-state-in-the-cluster-10-o1-c1', 'mission-atlas-state-in-the-cluster-10-o1', 1, 'terminal_simulation', 'Read the Job definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/backup-job.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/backup-job.yaml":{"type":"file","content":"apiVersion: batch/v1\nkind: Job\nmetadata:\n  name: metrics-backup\nspec:\n  template:\n    spec:\n      containers:\n        - name: backup\n          image: atlas-images/backup-tool:v1.0.0\n      restartPolicy: Never\n# runs to completion once, then stops -- not a long-running service\n# verification JOB-8814\n"}}}'::jsonb, '{"requiredFlag":"JOB-8814"}'::jsonb),

  ('mission-atlas-state-in-the-cluster-11-o1-c1', 'mission-atlas-state-in-the-cluster-11-o1', 1, 'terminal_simulation', 'Read the CronJob definition and submit the verification code.', '{"instructions":"Read /repo/infra/k8s/nightly-backup-cronjob.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/k8s/nightly-backup-cronjob.yaml":{"type":"file","content":"apiVersion: batch/v1\nkind: CronJob\nmetadata:\n  name: nightly-metrics-backup\nspec:\n  schedule: \"0 2 * * *\"\n  jobTemplate:\n    spec:\n      template:\n        spec:\n          containers:\n            - name: backup\n              image: atlas-images/backup-tool:v1.0.0\n          restartPolicy: Never\n# creates a new Job automatically on this schedule, every night at 02:00\n# verification CRONJOB-2210\n"}}}'::jsonb, '{"requiredFlag":"CRONJOB-2210"}'::jsonb),

  ('mission-atlas-state-in-the-cluster-12-o1-c1', 'mission-atlas-state-in-the-cluster-12-o1', 1, 'terminal_simulation', 'Read the pod status and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/metrics-db-pod-status.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/metrics-db-pod-status.txt":{"type":"file","content":"NAME                 READY   STATUS    NODE            AGE\natlas-metrics-db-0   0/1     Pending   (unscheduled)   12m\n# rescheduling from atlas-node-03 (drained) has not succeeded\n# verification DBPOD-3312\n"}}}'::jsonb, '{"requiredFlag":"DBPOD-3312"}'::jsonb),
  ('mission-atlas-state-in-the-cluster-12-o2-c1', 'mission-atlas-state-in-the-cluster-12-o2', 1, 'terminal_simulation', 'Read the PVC status and submit the verification code.', '{"instructions":"Read /var/atlas-k8s/metrics-db-pvc-status.txt and submit the verification code with: submit CODE","hostname":"atlas-k8s-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-k8s-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-k8s/metrics-db-pvc-status.txt":{"type":"file","content":"NAME              STATUS   VOLUME                  CAPACITY   STORAGECLASS\ndata-atlas-metrics-db-0   Bound    atlas-metrics-pv-local  50Gi       atlas-local-ssd\n# atlas-metrics-pv-local has node affinity: atlas-node-03 only -- it cannot be mounted anywhere else\n# verification PVCSTATUS-6602\n"}}}'::jsonb, '{"requiredFlag":"PVCSTATUS-6602"}'::jsonb),
  ('mission-atlas-state-in-the-cluster-12-o3-c1', 'mission-atlas-state-in-the-cluster-12-o3', 1, 'investigation', 'Which evidence explains why this data cannot be reached from anywhere else in the cluster?', '{"evidence":[{"id":"e1","label":"Pod status","detail":"atlas-metrics-db-0 has been stuck Pending for 12 minutes, unable to reschedule"},{"id":"e2","label":"PVC status","detail":"The claim is bound to atlas-metrics-pv-local, a PersistentVolume with node affinity locked to atlas-node-03 specifically"},{"id":"e3","label":"PVC storage class request","detail":"The claim explicitly requested the atlas-local-ssd StorageClass instead of the portable atlas-ssd class"},{"id":"e4","label":"StatefulSet declaration","detail":"atlas-metrics-db correctly declares a volumeClaimTemplate, requesting real persistent storage rather than an ephemeral volume"}],"question":"Which evidence explains why this data cannot be reached from anywhere else in the cluster?"}'::jsonb, '{"requiredEvidenceIds":["e2","e3"]}'::jsonb),
  ('mission-atlas-state-in-the-cluster-12-o4-c1', 'mission-atlas-state-in-the-cluster-12-o4', 1, 'boss_encounter', 'Having confirmed the pod is stuck, the PVC binding, and what actually explains this, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-state-in-the-cluster-12-o1","label":"Confirm the pod is stuck"},{"objectiveRef":"mission-atlas-state-in-the-cluster-12-o2","label":"Confirm the PVC binding"},{"objectiveRef":"mission-atlas-state-in-the-cluster-12-o3","label":"Identify what actually explains this"}],"task":"State the diagnosis in one sentence: atlas-metrics-db did everything right by using a StatefulSet with a real PersistentVolumeClaim instead of an ephemeral volume, but that claim requested the atlas-local-ssd StorageClass, which provisions disks physically bound to the node that created them -- the data is completely intact on atlas-node-03, just permanently unreachable from anywhere else, and the fix is migrating to the portable atlas-ssd StorageClass so future reschedules can actually follow the pod."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-state-in-the-cluster-12-o1","mission-atlas-state-in-the-cluster-12-o2","mission-atlas-state-in-the-cluster-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-state-in-the-cluster-01-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-configmap.yaml', 10, 1),
  ('mission-atlas-state-in-the-cluster-01-o1-c1', 'solution', 'It holds non-sensitive config, verification CONFIGMAP-3312. submit CONFIGMAP-3312', 20, 2),

  ('mission-atlas-state-in-the-cluster-02-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/collector-secret.yaml', 10, 1),
  ('mission-atlas-state-in-the-cluster-02-o1-c1', 'solution', 'The value is only base64-encoded, verification SECRET-6602. submit SECRET-6602', 20, 2),

  ('mission-atlas-state-in-the-cluster-03-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/scratch-volume.yaml', 10, 1),
  ('mission-atlas-state-in-the-cluster-03-o1-c1', 'solution', 'emptyDir lives and dies with the pod, verification VOLUME-7714. submit VOLUME-7714', 20, 2),

  ('mission-atlas-state-in-the-cluster-04-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/pv-list.txt', 10, 1),
  ('mission-atlas-state-in-the-cluster-04-o1-c1', 'solution', 'A PV exists independently, verification PV-4471. submit PV-4471', 20, 2),

  ('mission-atlas-state-in-the-cluster-05-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/metrics-pvc.yaml', 10, 1),
  ('mission-atlas-state-in-the-cluster-05-o1-c1', 'solution', 'A claim requests storage without naming a disk, verification PVC-8802. submit PVC-8802', 20, 2),

  ('mission-atlas-state-in-the-cluster-06-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/storageclass.yaml', 10, 1),
  ('mission-atlas-state-in-the-cluster-06-o1-c1', 'solution', 'It provisions a portable EBS disk, verification STORAGECLASS-2291. submit STORAGECLASS-2291', 20, 2),

  ('mission-atlas-state-in-the-cluster-07-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/metrics-db-statefulset.yaml', 10, 1),
  ('mission-atlas-state-in-the-cluster-07-o1-c1', 'solution', 'Each replica gets its own claim, verification STATEFULSET-9012. submit STATEFULSET-9012', 20, 2),

  ('mission-atlas-state-in-the-cluster-08-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/metrics-db-headless-service.yaml', 10, 1),
  ('mission-atlas-state-in-the-cluster-08-o1-c1', 'solution', 'clusterIP is None, verification HEADLESS-3390. submit HEADLESS-3390', 20, 2),

  ('mission-atlas-state-in-the-cluster-09-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/log-agent-daemonset.yaml', 10, 1),
  ('mission-atlas-state-in-the-cluster-09-o1-c1', 'solution', 'One pod per node guaranteed, verification DAEMONSET-4471. submit DAEMONSET-4471', 20, 2),

  ('mission-atlas-state-in-the-cluster-10-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/backup-job.yaml', 10, 1),
  ('mission-atlas-state-in-the-cluster-10-o1-c1', 'solution', 'It runs to completion once, verification JOB-8814. submit JOB-8814', 20, 2),

  ('mission-atlas-state-in-the-cluster-11-o1-c1', 'orientation', 'Try: cat /repo/infra/k8s/nightly-backup-cronjob.yaml', 10, 1),
  ('mission-atlas-state-in-the-cluster-11-o1-c1', 'solution', 'It runs nightly at 02:00, verification CRONJOB-2210. submit CRONJOB-2210', 20, 2),

  ('mission-atlas-state-in-the-cluster-12-o1-c1', 'orientation', 'Try: cat /var/atlas-k8s/metrics-db-pod-status.txt', 10, 1),
  ('mission-atlas-state-in-the-cluster-12-o1-c1', 'solution', 'Stuck Pending for 12 minutes, verification DBPOD-3312. submit DBPOD-3312', 20, 2),
  ('mission-atlas-state-in-the-cluster-12-o2-c1', 'orientation', 'Try: cat /var/atlas-k8s/metrics-db-pvc-status.txt', 10, 1),
  ('mission-atlas-state-in-the-cluster-12-o2-c1', 'solution', 'Bound to a node-local PV, verification PVCSTATUS-6602. submit PVCSTATUS-6602', 20, 2),
  ('mission-atlas-state-in-the-cluster-12-o3-c1', 'orientation', 'The pod being stuck is a symptom, and the StatefulSet itself did nothing wrong. Look at what the claim actually requested and where it got bound.', 10, 1),
  ('mission-atlas-state-in-the-cluster-12-o3-c1', 'solution', 'e2 and e3: bound to a node-local PV, because the claim requested the node-local StorageClass in the first place.', 20, 2),
  ('mission-atlas-state-in-the-cluster-12-o4-c1', 'orientation', 'Combine the stuck pod, the node-local binding, and what should replace it into one sentence.', 15, 1),
  ('mission-atlas-state-in-the-cluster-12-o4-c1', 'solution', 'The data is intact but stranded on atlas-node-03 because the claim requested node-local storage instead of a portable StorageClass -- migrate it to atlas-ssd.', 25, 2);
