-- Atlas Division pathway ("The Silence") Act 29 -- "Disaster" content,
-- under world-atlas-disaster (already inserted separately). 1 campaign,
-- 2 operations, 12 missions (11 lessons + boss), closing World VIII
-- "The Failure Zone" entirely.
--
-- Same terminal-engine constraint as every prior Atlas Act -- every
-- business-continuity artifact here is static seeded text read via
-- `cat`. Two hosts, both reused: `atlas-devbox-01`, now also hosting a
-- new `dr/` directory inside the Act 22 `infra-envs` GitOps repo (backup
-- policy, snapshot schedule, replication config, RPO/RTO targets,
-- topology decision, DNS failover config, recovery procedure and the
-- runbook itself), and `atlas-observability-01` for the region-wide
-- Black Sky drill (the execution log, the replica promotion result, and
-- the client-observed recovery time). Concept-only topics with no
-- natural single artifact (failure domains, active-active) stay
-- multiple_choice.
--
-- Narrative thread: mission 9 (DNS failover) plants the actual gap as a
-- plain fact in the config itself -- a 3600-second TTL, never revisited
-- -- well before the boss frames it as a problem. The boss deliberately
-- confirms the replica promotion result (`e2`) as proof the new RPO/RTO
-- targets were met, and explicitly rules it out as the explanation for
-- why real users were still down longer; the actual explanation requires
-- both the DNS TTL itself and the measured client-observed recovery time
-- (`e3` + `e4`) -- the same "the thing we built worked, something above
-- it did not" shape as Act 28''s own story_reveal, one layer further out.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-disaster', 'world-atlas-disaster', 'disaster', '8D - Disaster', 'Learn business continuity from first principles -- failure domains, backups, snapshots, replication, RPO, RTO, active-passive, active-active, DNS failover, recovery and runbooks -- and run this fleet''s first full region-loss drill to find out whether atlas-metrics-db can actually survive losing an entire region on purpose.', 4);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-disaster-1', 'campaign-atlas-disaster', 'build-it-before-it-is-needed', 'Build It Before It Is Needed', 'Failure domains, backups, snapshots, replication, RPO and RTO.', 1),
  ('operation-atlas-disaster-2', 'campaign-atlas-disaster', 'prove-the-region-can-fall', 'Prove the Region Can Fall', 'Active-passive, active-active, DNS failover, recovery, runbooks and the region-loss drill itself.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-disaster-01', 'world-atlas-disaster', 'campaign-atlas-disaster', 'operation-atlas-disaster-1', 'failure-domains', 'Failure Domains', 'Act 28 proved this fleet survives losing a zone. Vey wants to know exactly what boundary atlas-metrics-db is still not protected against.', 'beginner', ARRAY['leena','cross'], null, null, '{"type":"simulation","simulationId":"failure-domains-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-disaster-02', 'world-atlas-disaster', 'campaign-atlas-disaster', 'operation-atlas-disaster-1', 'backups', 'Backups', 'Confirm exactly what this fleet''s real backup policy actually commits to now, beyond the single daily snapshot Act 28 found.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-disaster-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"backups-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-disaster-03', 'world-atlas-disaster', 'campaign-atlas-disaster', 'operation-atlas-disaster-1', 'snapshots', 'Snapshots', 'Confirm exactly how often a real point-in-time snapshot is actually being taken now, separate from the nightly full backup.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-disaster-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"snapshots-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-disaster-04', 'world-atlas-disaster', 'campaign-atlas-disaster', 'operation-atlas-disaster-1', 'replication', 'Replication', 'Confirm exactly where atlas-metrics-db''s new live replica is actually running, and how far behind it actually stays.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-disaster-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"replication-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-disaster-05', 'world-atlas-disaster', 'campaign-atlas-disaster', 'operation-atlas-disaster-1', 'rpo', 'RPO', 'Confirm exactly how much data loss this fleet has actually committed to accepting, in writing, if the primary region is lost.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-disaster-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"rpo-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-disaster-06', 'world-atlas-disaster', 'campaign-atlas-disaster', 'operation-atlas-disaster-1', 'rto', 'RTO', 'Confirm exactly how long this fleet has actually committed to recovering in, and how that compares to Act 28''s undocumented 47-minute restore.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-disaster-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"rto-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-disaster-07', 'world-atlas-disaster', 'campaign-atlas-disaster', 'operation-atlas-disaster-2', 'active-passive', 'Active-Passive', 'Confirm exactly why Vey chose a standby replica over a fully active second copy for this specific database.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-disaster-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"active-passive-sim"}'::jsonb, '{"xp":730,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-disaster-08', 'world-atlas-disaster', 'campaign-atlas-disaster', 'operation-atlas-disaster-2', 'active-active', 'Active-Active', 'Understand what an active-active topology actually trades away in exchange for zero failover time.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-disaster-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"active-active-sim"}'::jsonb, '{"xp":730,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-disaster-09', 'world-atlas-disaster', 'campaign-atlas-disaster', 'operation-atlas-disaster-2', 'dns-failover', 'DNS Failover', 'Confirm exactly how traffic is actually supposed to find the database once its replica has been promoted.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-disaster-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"dns-failover-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-disaster-10', 'world-atlas-disaster', 'campaign-atlas-disaster', 'operation-atlas-disaster-2', 'recovery', 'Recovery', 'Confirm exactly what actual steps this fleet has committed to running, in order, the moment the primary region is confirmed lost.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-disaster-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"recovery-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-disaster-11', 'world-atlas-disaster', 'campaign-atlas-disaster', 'operation-atlas-disaster-2', 'runbooks', 'Runbooks', 'Confirm that everything this Act built now actually lives somewhere real, not just in Vey''s own head.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-disaster-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"runbooks-sim"}'::jsonb, '{"xp":750,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-disaster-12', 'world-atlas-disaster', 'campaign-atlas-disaster', 'operation-atlas-disaster-2', 'black-sky', 'Black Sky', 'Everything this Act taught, turned on one entire region gone dark: not to just confirm the failover met its target, to explain why real recovery still took longer than that.', 'boss', ARRAY['vey','cross','rook','leena','byte'], '{"requiredMissionIds":["mission-atlas-disaster-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"black-sky-boss-sim"}'::jsonb, '{"xp":840,"credits":205,"badgeIds":["black-sky"],"skillXp":{"cloud_devops_fundamentals":135}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-disaster-01', 1, 'leena', 'Act 28 proved this fleet survives losing an entire availability zone. It still has no answer for losing more than that.'),
  ('mission-atlas-disaster-01', 2, 'cross', 'Tomas is right to push on this. A failure domain is the actual boundary a single failure can occur inside -- instance, zone, region. Every plan has to say, explicitly, which one it is actually protecting against.'),

  ('mission-atlas-disaster-02', 1, 'rook', 'Confirm exactly what this fleet''s real backup policy actually commits to now, in writing -- not just the one daily snapshot Act 28 happened to find.'),

  ('mission-atlas-disaster-03', 1, 'rook', 'A nightly backup alone still allows up to a full day of lost data. Confirm how often a real point-in-time snapshot is actually being taken now instead.'),

  ('mission-atlas-disaster-04', 1, 'vey', 'Tomas Vey. Confirm exactly where atlas-metrics-db''s new live replica is actually running, and how far behind the primary it actually stays in practice.'),

  ('mission-atlas-disaster-05', 1, 'cross', 'RPO is how much data this fleet has actually agreed, in writing, it is willing to lose if the primary region goes down. Confirm the real number.'),

  ('mission-atlas-disaster-06', 1, 'cross', 'RTO is how long this fleet has actually agreed it is willing to stay down. Confirm the real number, and compare it against Act 28''s own undocumented 47-minute restore.'),

  ('mission-atlas-disaster-07', 1, 'vey', 'A standby replica, promoted only when the primary actually fails, is simpler and avoids write conflicts entirely. Confirm why that tradeoff was the right one for this specific database.'),

  ('mission-atlas-disaster-08', 1, 'vey', 'Active-active means both regions accept live writes at the same time -- zero failover time, in exchange for real conflict-resolution complexity every relational write now has to deal with.'),

  ('mission-atlas-disaster-09', 1, 'vey', 'Promoting a replica does nothing on its own if nothing actually points traffic at it afterward. Confirm exactly how this fleet''s DNS is actually supposed to handle that.'),

  ('mission-atlas-disaster-10', 1, 'vey', 'Confirm the actual, ordered steps this fleet has committed to running the moment the primary region is confirmed lost -- not what anyone assumes they would do in the moment.'),

  ('mission-atlas-disaster-11', 1, 'rook', 'None of this counts as real continuity if it only lives in Tomas''s own head. Confirm it is actually written down somewhere the whole fleet can reach.'),

  ('mission-atlas-disaster-12', 1, 'leena', 'Everything this Act taught you, turned on one entire region gone dark. Not just to confirm the failover met its target -- to explain why real recovery still took longer than that.'),
  ('mission-atlas-disaster-12', 2, 'byte', 'I have the full drill execution log and the replica promotion result both pulled up together. The database side of this hit its target with room to spare.'),
  ('mission-atlas-disaster-12', 3, 'vey', 'RTO and RPO both came in under target. That was never the failure here.'),
  ('mission-atlas-disaster-12', 4, 'cross', 'Then find what actually kept real users down longer than that, and why nothing built so far was ever going to catch it.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-disaster-01-o1', 'mission-atlas-disaster-01', 1, 'Explain failure domains', 'Choose the accurate description of what a failure domain actually is.'),

  ('mission-atlas-disaster-02-o1', 'mission-atlas-disaster-02', 1, 'Read the backup policy', 'Read the backup policy and submit the verification code.'),

  ('mission-atlas-disaster-03-o1', 'mission-atlas-disaster-03', 1, 'Read the snapshot schedule', 'Read the snapshot schedule and submit the verification code.'),

  ('mission-atlas-disaster-04-o1', 'mission-atlas-disaster-04', 1, 'Read the replication config', 'Read the replication configuration and submit the verification code.'),

  ('mission-atlas-disaster-05-o1', 'mission-atlas-disaster-05', 1, 'Read the RPO target', 'Read the RPO target and submit the verification code.'),

  ('mission-atlas-disaster-06-o1', 'mission-atlas-disaster-06', 1, 'Read the RTO target', 'Read the RTO target and submit the verification code.'),

  ('mission-atlas-disaster-07-o1', 'mission-atlas-disaster-07', 1, 'Read the topology decision', 'Read the active-passive topology decision and submit the verification code.'),

  ('mission-atlas-disaster-08-o1', 'mission-atlas-disaster-08', 1, 'Explain active-active', 'Choose the accurate description of what an active-active topology actually trades away.'),

  ('mission-atlas-disaster-09-o1', 'mission-atlas-disaster-09', 1, 'Read the DNS failover config', 'Read the DNS failover configuration and submit the verification code.'),

  ('mission-atlas-disaster-10-o1', 'mission-atlas-disaster-10', 1, 'Read the recovery procedure', 'Read the recovery procedure and submit the verification code.'),

  ('mission-atlas-disaster-11-o1', 'mission-atlas-disaster-11', 1, 'Read the DR runbook', 'Read the disaster recovery runbook and submit the verification code.'),

  ('mission-atlas-disaster-12-o1', 'mission-atlas-disaster-12', 1, 'Confirm the drill execution log', 'Read the Black Sky drill execution log and submit the verification code.'),
  ('mission-atlas-disaster-12-o2', 'mission-atlas-disaster-12', 2, 'Confirm the replica promotion result', 'Read the replica promotion result and submit the verification code.'),
  ('mission-atlas-disaster-12-o3', 'mission-atlas-disaster-12', 3, 'Identify what actually kept users down longer', 'Find the evidence that explains why real recovery took longer than the infrastructure''s own RTO.'),
  ('mission-atlas-disaster-12-o4', 'mission-atlas-disaster-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-disaster-01-o1-c1', 'mission-atlas-disaster-01-o1', 1, 'multiple_choice', 'A failure domain actually is...', '{"question":"A failure domain actually is...","options":[{"id":"a","text":"The boundary within which a single failure can occur -- instance, zone, or region -- and DR planning has to state explicitly which one it is actually protecting against"},{"id":"b","text":"A synonym for any outage, regardless of scope"},{"id":"c","text":"Only relevant to physical, on-premises data centers"},{"id":"d","text":"A boundary that only matters once a system has already failed"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-disaster-02-o1-c1', 'mission-atlas-disaster-02-o1', 1, 'terminal_simulation', 'Read the backup policy and submit the verification code.', '{"instructions":"Read /repo/infra-envs/dr/backup-policy.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/dr/backup-policy.yaml":{"type":"file","content":"backup_policy:\n  full_backup: weekly, Sunday 02:00 UTC\n  incremental_backup: daily, 02:00 UTC\n  retention: 30 days\n  applies_to: every stateful service, not just atlas-metrics-db\n# verification BACKUPPOLICY-4471\n"}}}'::jsonb, '{"requiredFlag":"BACKUPPOLICY-4471"}'::jsonb),

  ('mission-atlas-disaster-03-o1-c1', 'mission-atlas-disaster-03-o1', 1, 'terminal_simulation', 'Read the snapshot schedule and submit the verification code.', '{"instructions":"Read /repo/infra-envs/dr/snapshot-schedule.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/dr/snapshot-schedule.yaml":{"type":"file","content":"snapshot_schedule:\n  interval: every 15 minutes\n  type: point-in-time, incremental\n  purpose: allows restoring to any point within the retention window, not just the last nightly backup\n# verification SNAPSHOT-8802\n"}}}'::jsonb, '{"requiredFlag":"SNAPSHOT-8802"}'::jsonb),

  ('mission-atlas-disaster-04-o1-c1', 'mission-atlas-disaster-04-o1', 1, 'terminal_simulation', 'Read the replication configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/dr/replication-config.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/dr/replication-config.yaml":{"type":"file","content":"primary_region: us-east-1\nreplica_region: us-west-2\nreplication_mode: asynchronous\ntypical_lag: under 30 seconds\n# verification REPLICATION-2291\n"}}}'::jsonb, '{"requiredFlag":"REPLICATION-2291"}'::jsonb),

  ('mission-atlas-disaster-05-o1-c1', 'mission-atlas-disaster-05-o1', 1, 'terminal_simulation', 'Read the RPO target and submit the verification code.', '{"instructions":"Read /repo/infra-envs/dr/rpo-target.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/dr/rpo-target.yaml":{"type":"file","content":"recovery_point_objective: 5 minutes maximum data loss\nmeasured_against: replication lag at time of failure\ncurrent typical lag (30s) is well inside this target\n# verification RPO-6602\n"}}}'::jsonb, '{"requiredFlag":"RPO-6602"}'::jsonb),

  ('mission-atlas-disaster-06-o1-c1', 'mission-atlas-disaster-06-o1', 1, 'terminal_simulation', 'Read the RTO target and submit the verification code.', '{"instructions":"Read /repo/infra-envs/dr/rto-target.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/dr/rto-target.yaml":{"type":"file","content":"recovery_time_objective: 10 minutes maximum, from confirmed primary loss to promoted replica serving traffic\nfor comparison: the undocumented manual restore drilled in Act 28 took 47 minutes, with no target at all\n# verification RTO-3312\n"}}}'::jsonb, '{"requiredFlag":"RTO-3312"}'::jsonb),

  ('mission-atlas-disaster-07-o1-c1', 'mission-atlas-disaster-07-o1', 1, 'terminal_simulation', 'Read the active-passive topology decision and submit the verification code.', '{"instructions":"Read /repo/infra-envs/dr/topology-decision.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/dr/topology-decision.yaml":{"type":"file","content":"chosen_topology: active-passive\nreason: a single relational primary avoids write-conflict resolution entirely; the standby only ever serves reads until it is promoted\ntradeoff accepted: a real, though small, failover time instead of zero\n# verification TOPOLOGY-7714\n"}}}'::jsonb, '{"requiredFlag":"TOPOLOGY-7714"}'::jsonb),

  ('mission-atlas-disaster-08-o1-c1', 'mission-atlas-disaster-08-o1', 1, 'multiple_choice', 'An active-active topology actually trades away...', '{"question":"An active-active topology actually trades away...","options":[{"id":"a","text":"Simplicity -- both regions accept live writes at once, so real conflict-resolution logic is required, in exchange for zero failover time"},{"id":"b","text":"Nothing at all -- it is strictly better than active-passive in every case"},{"id":"c","text":"The need for backups, since a second live copy already exists"},{"id":"d","text":"The need for monitoring in one of the two regions"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-disaster-09-o1-c1', 'mission-atlas-disaster-09-o1', 1, 'terminal_simulation', 'Read the DNS failover configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/dr/dns-failover.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/dr/dns-failover.yaml":{"type":"file","content":"record: atlas-metrics-db.internal\nrouting_policy: failover, health-check driven\nprimary: us-east-1 endpoint\nsecondary: us-west-2 endpoint\nttl: 3600s\n# ttl has never been revisited since this record was first created\n# verification DNSFAILOVER-9034\n"}}}'::jsonb, '{"requiredFlag":"DNSFAILOVER-9034"}'::jsonb),

  ('mission-atlas-disaster-10-o1-c1', 'mission-atlas-disaster-10-o1', 1, 'terminal_simulation', 'Read the recovery procedure and submit the verification code.', '{"instructions":"Read /repo/infra-envs/dr/recovery-procedure.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/dr/recovery-procedure.yaml":{"type":"file","content":"recovery_procedure:\n  1: confirm primary region genuinely unreachable, not just one host\n  2: promote the us-west-2 replica to primary\n  3: update the DNS failover record to point at the new primary\n  4: verify the collector reconnects successfully\n  5: validate data integrity against the last known-good snapshot\n# verification RECOVERY-1187\n"}}}'::jsonb, '{"requiredFlag":"RECOVERY-1187"}'::jsonb),

  ('mission-atlas-disaster-11-o1-c1', 'mission-atlas-disaster-11-o1', 1, 'terminal_simulation', 'Read the disaster recovery runbook and submit the verification code.', '{"instructions":"Read /repo/infra-envs/dr/dr-runbook.md and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/dr/dr-runbook.md":{"type":"file","content":"# atlas-metrics-db disaster recovery runbook\n\nRPO: 5 minutes. RTO: 10 minutes. Topology: active-passive, us-east-1 primary, us-west-2 standby.\nRecovery steps: see recovery-procedure.yaml, followed in order, no steps skipped.\nThis runbook must be re-validated with a real drill at least once per quarter, or it is assumed stale.\n# verification RUNBOOK-2201\n"}}}'::jsonb, '{"requiredFlag":"RUNBOOK-2201"}'::jsonb),

  ('mission-atlas-disaster-12-o1-c1', 'mission-atlas-disaster-12-o1', 1, 'terminal_simulation', 'Read the Black Sky drill execution log and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/black-sky-execution-log.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/black-sky-execution-log.txt":{"type":"file","content":"10:00:00 - drill begins: entire us-east-1 region simulated as unreachable\n10:00:30 - replication lag at time of failure: 22 seconds, well inside the 5-minute RPO\n10:04:00 - us-west-2 replica promoted to primary\n10:04:00 - DNS failover record updated to point at us-west-2\n10:08:00 - collector successfully reconnects to the new primary\n10:41:00 - real user-facing error rate finally returns to normal\n# verification BLACKSKY-6631\n"}}}'::jsonb, '{"requiredFlag":"BLACKSKY-6631"}'::jsonb),
  ('mission-atlas-disaster-12-o2-c1', 'mission-atlas-disaster-12-o2', 1, 'terminal_simulation', 'Read the replica promotion result and submit the verification code.', '{"instructions":"Read /var/atlas-observability-01/replica-promotion-result.txt and submit the verification code with: submit CODE","hostname":"atlas-observability-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-observability-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-observability-01/replica-promotion-result.txt":{"type":"file","content":"promotion_time: 4 minutes, well inside the 10-minute RTO\ndata_loss: 22 seconds of replication lag, well inside the 5-minute RPO\nconclusion: the database itself recovered fully within both defined targets\n# verification PROMOTION-7742\n"}}}'::jsonb, '{"requiredFlag":"PROMOTION-7742"}'::jsonb),
  ('mission-atlas-disaster-12-o3-c1', 'mission-atlas-disaster-12-o3', 1, 'investigation', 'Which evidence explains why real recovery took longer than the database''s own RTO?', '{"evidence":[{"id":"e1","label":"Black Sky drill execution log","detail":"The replica promoted and DNS updated by 10:04, but real user-facing error rate did not return to normal until 10:41 -- 37 minutes later"},{"id":"e2","label":"Replica promotion result","detail":"Promotion completed in 4 minutes and data loss was 22 seconds -- both well inside the defined RTO and RPO targets"},{"id":"e3","label":"DNS failover configuration","detail":"The DNS record for atlas-metrics-db has a 3600-second (one-hour) TTL that has never been revisited since it was first created"},{"id":"e4","label":"Recovery procedure","detail":"Steps 1 through 5 were followed in order with nothing skipped, ending in a successful collector reconnection at 10:08"}],"question":"Which evidence explains why real recovery took longer than the database''s own RTO?"}'::jsonb, '{"requiredEvidenceIds":["e3"]}'::jsonb),
  ('mission-atlas-disaster-12-o4-c1', 'mission-atlas-disaster-12-o4', 1, 'boss_encounter', 'Having confirmed the drill execution log, the replica promotion result, and what actually explains it, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-disaster-12-o1","label":"Confirm the drill execution log"},{"objectiveRef":"mission-atlas-disaster-12-o2","label":"Confirm the replica promotion result"},{"objectiveRef":"mission-atlas-disaster-12-o3","label":"Identify what actually kept users down longer"}],"task":"State the diagnosis in one sentence: atlas-metrics-db itself recovered completely within its own defined RPO and RTO -- the replica promoted in 4 minutes with only 22 seconds of data loss, so the database was never the problem -- but the DNS record pointing at it still carries a one-hour TTL that was never revisited once the failover itself was built, so real users kept resolving the dead primary until their own cached answer finally expired -- the fix is lowering that TTL to match the RTO it is supposed to serve, because a recovery target the DNS layer cannot actually honor is not a real recovery target at all."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-disaster-12-o1","mission-atlas-disaster-12-o2","mission-atlas-disaster-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-disaster-01-o1-c1', 'orientation', 'Think about the actual boundary a single failure can occur inside.', 10, 1),
  ('mission-atlas-disaster-01-o1-c1', 'solution', 'Instance, zone, or region -- planning has to state which one, explicitly.', 20, 2),

  ('mission-atlas-disaster-02-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/dr/backup-policy.yaml', 10, 1),
  ('mission-atlas-disaster-02-o1-c1', 'solution', 'Weekly full plus daily incremental, 30-day retention, verification BACKUPPOLICY-4471. submit BACKUPPOLICY-4471', 20, 2),

  ('mission-atlas-disaster-03-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/dr/snapshot-schedule.yaml', 10, 1),
  ('mission-atlas-disaster-03-o1-c1', 'solution', 'Every 15 minutes, verification SNAPSHOT-8802. submit SNAPSHOT-8802', 20, 2),

  ('mission-atlas-disaster-04-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/dr/replication-config.yaml', 10, 1),
  ('mission-atlas-disaster-04-o1-c1', 'solution', 'us-west-2, async, under 30 seconds lag, verification REPLICATION-2291. submit REPLICATION-2291', 20, 2),

  ('mission-atlas-disaster-05-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/dr/rpo-target.yaml', 10, 1),
  ('mission-atlas-disaster-05-o1-c1', 'solution', '5 minutes maximum data loss, verification RPO-6602. submit RPO-6602', 20, 2),

  ('mission-atlas-disaster-06-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/dr/rto-target.yaml', 10, 1),
  ('mission-atlas-disaster-06-o1-c1', 'solution', '10 minutes maximum, versus Act 28''s undocumented 47, verification RTO-3312. submit RTO-3312', 20, 2),

  ('mission-atlas-disaster-07-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/dr/topology-decision.yaml', 10, 1),
  ('mission-atlas-disaster-07-o1-c1', 'solution', 'Active-passive avoids write conflicts entirely, verification TOPOLOGY-7714. submit TOPOLOGY-7714', 20, 2),

  ('mission-atlas-disaster-08-o1-c1', 'orientation', 'Think about what both regions accepting live writes at once actually costs.', 10, 1),
  ('mission-atlas-disaster-08-o1-c1', 'solution', 'Real conflict-resolution complexity, in exchange for zero failover time.', 20, 2),

  ('mission-atlas-disaster-09-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/dr/dns-failover.yaml', 10, 1),
  ('mission-atlas-disaster-09-o1-c1', 'solution', 'Health-check-driven failover record, ttl 3600s, verification DNSFAILOVER-9034. submit DNSFAILOVER-9034', 20, 2),

  ('mission-atlas-disaster-10-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/dr/recovery-procedure.yaml', 10, 1),
  ('mission-atlas-disaster-10-o1-c1', 'solution', 'Five ordered steps, promote then repoint DNS then verify, verification RECOVERY-1187. submit RECOVERY-1187', 20, 2),

  ('mission-atlas-disaster-11-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/dr/dr-runbook.md', 10, 1),
  ('mission-atlas-disaster-11-o1-c1', 'solution', 'RPO 5 minutes, RTO 10 minutes, quarterly drill required, verification RUNBOOK-2201. submit RUNBOOK-2201', 20, 2),

  ('mission-atlas-disaster-12-o1-c1', 'orientation', 'Try: cat /var/atlas-observability-01/black-sky-execution-log.txt', 10, 1),
  ('mission-atlas-disaster-12-o1-c1', 'solution', 'Promoted by 10:04, but users not normal until 10:41, verification BLACKSKY-6631. submit BLACKSKY-6631', 20, 2),
  ('mission-atlas-disaster-12-o2-c1', 'orientation', 'Try: cat /var/atlas-observability-01/replica-promotion-result.txt', 10, 1),
  ('mission-atlas-disaster-12-o2-c1', 'solution', '4 minutes, 22 seconds of loss, both inside target, verification PROMOTION-7742. submit PROMOTION-7742', 20, 2),
  ('mission-atlas-disaster-12-o3-c1', 'orientation', 'The replica promotion result is confirmed clean and ruled out as the explanation. Compare the promotion timestamp against how long the DNS TTL actually lasts.', 10, 1),
  ('mission-atlas-disaster-12-o3-c1', 'solution', 'e3: a one-hour DNS TTL nobody ever revisited, letting clients keep resolving the dead primary long after failover completed.', 20, 2),
  ('mission-atlas-disaster-12-o4-c1', 'orientation', 'Combine the on-target database recovery, the stale DNS TTL, and the fix into one sentence.', 15, 1),
  ('mission-atlas-disaster-12-o4-c1', 'solution', 'The database met its RTO and RPO completely; the DNS TTL pointing at it was never lowered to match, so real users stayed down until their own cache finally expired.', 25, 2);
