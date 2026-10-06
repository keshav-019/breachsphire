-- Atlas Division pathway ("The Silence"): World row for Act 19,
-- "State in the Cluster", still under act-atlas-6 ("World VI -- The
-- Cluster Sea"). Content (missions) follows in its own migration.
--
-- Narrative thread: atlas-node-03 (the same node drained in Act 17) is
-- drained again for routine maintenance, and this time it takes
-- atlas-metrics-db's data with it -- not deleted, just physically
-- stranded. The StatefulSet and its PersistentVolumeClaim were both
-- configured correctly; the actual mistake was requesting node-local
-- storage for a workload that needed to survive its node disappearing.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-state-in-the-cluster', 'act-atlas-6', 18, 'state-in-the-cluster', 'State in the Cluster', 'State in the Cluster',
   'ConfigMaps; Secrets; Volumes; PersistentVolumes; PersistentVolumeClaims; StorageClasses; StatefulSets; headless Services; DaemonSets; Jobs; CronJobs.',
   'atlas-node-03 is drained again, this time for a disk firmware update. atlas-metrics-db-0, rescheduled off it like everything else, comes back up with an empty disk -- and stays stuck Pending, unable to reschedule at all.',
   'The Vanishing Disk',
   'Nothing was ever deleted. atlas-metrics-db correctly used a StatefulSet with a real PersistentVolumeClaim, not an ephemeral volume -- but that claim requested the atlas-local-ssd StorageClass, which provisions disks physically bound to whichever node created them. The data is still there, completely intact, sitting on atlas-node-03. It is simply unreachable from anywhere else in the cluster, forever, unless that exact node comes back.',
   'Every stateful workload in this cluster now uses storage that can actually follow it anywhere. The next question is what keeps any of these pods, stateful or not, healthy enough to stay running in the first place.',
   'The Vanishing Disk', 'HardDrive', 'elevated', 92, 28, 'pathway-atlas');
