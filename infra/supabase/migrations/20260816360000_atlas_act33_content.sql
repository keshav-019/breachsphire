-- Atlas Division pathway ("The Silence") Act 33 -- "FinOps" content,
-- under world-atlas-finops (already inserted separately). 1 campaign,
-- 2 operations, 12 missions (11 lessons + boss), opening World X
-- "Atlas", the pathway's final World.
--
-- Same terminal-engine constraint as every prior Atlas Act. One new
-- host, `atlas-finops-01`, holds every cost report this Act builds.
-- Deliberately references, but never duplicates, real prior-Act
-- artifacts: Act 29's replication cost, Act 10's abandoned second
-- region, and Act 30's owner-tag policy.
--
-- Narrative thread: mission 4 (egress) plants the Act 29 replication
-- cost as legitimate and budgeted well before the boss needs that fact.
-- The boss deliberately confirms that same replication cost (`e2`) as
-- unchanged and correctly expected, and rules it out; the actual
-- explanation requires both the idle-resources report and the stuck
-- autoscaling group together (`e3`+`e4`) -- two ordinary, easy-to-miss
-- things, not one dramatic one, continuing this stretch's now-familiar
-- shape.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-finops', 'world-atlas-finops', 'finops', '10A - FinOps', 'Learn cloud economics from first principles -- the cost model, compute, storage, egress, idle resources, rightsizing, autoscaling economics, reserved capacity, spot, and allocation -- and find out what has actually been driving this fleet''s cloud bill for the last thirty-two Acts.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-finops-1', 'campaign-atlas-finops', 'understanding-the-bill', 'Understanding the Bill', 'Cloud cost model, compute, storage, egress, idle resources and rightsizing.', 1),
  ('operation-atlas-finops-2', 'campaign-atlas-finops', 'making-cost-everyones-job', 'Making Cost Everyone''s Job', 'Autoscaling economics, reserved capacity, spot, allocation, FinOps culture and the bill itself.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-finops-01', 'world-atlas-finops', 'campaign-atlas-finops', 'operation-atlas-finops-1', 'cloud-cost-model', 'Cloud Cost Model', 'Thirty-two Acts of hard-won infrastructure discipline, and nobody has been watching what any of it actually costs.', 'beginner', ARRAY['leena','vey'], null, null, '{"type":"simulation","simulationId":"cloud-cost-model-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-finops-02', 'world-atlas-finops', 'campaign-atlas-finops', 'operation-atlas-finops-1', 'compute', 'Compute', 'Confirm exactly how this fleet''s real compute spend actually breaks down across on-demand, reserved and spot capacity.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-finops-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"compute-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-finops-03', 'world-atlas-finops', 'campaign-atlas-finops', 'operation-atlas-finops-1', 'storage', 'Storage', 'Confirm exactly what this fleet''s real storage spend actually consists of, snapshot schedules included.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-finops-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"storage-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-finops-04', 'world-atlas-finops', 'campaign-atlas-finops', 'operation-atlas-finops-1', 'egress', 'Egress', 'Confirm exactly what actually drives this fleet''s real egress bill, including the real, expected cost of Act 29''s own cross-region replication.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-finops-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"egress-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-finops-05', 'world-atlas-finops', 'campaign-atlas-finops', 'operation-atlas-finops-1', 'idle-resources', 'Idle Resources', 'Confirm exactly what a real idle-resources audit actually finds still running, forgotten, since as far back as Act 10.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-finops-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"idle-resources-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-finops-06', 'world-atlas-finops', 'campaign-atlas-finops', 'operation-atlas-finops-1', 'rightsizing', 'Rightsizing', 'Confirm exactly which real instances this fleet is actually running larger than their measured utilization justifies.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-finops-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"rightsizing-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-finops-07', 'world-atlas-finops', 'campaign-atlas-finops', 'operation-atlas-finops-2', 'autoscaling-economics', 'Autoscaling Economics', 'Confirm exactly what this fleet''s real autoscaling groups have actually been costing, sustained, not just at their intended peak.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-finops-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"autoscaling-economics-sim"}'::jsonb, '{"xp":730,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-finops-08', 'world-atlas-finops', 'campaign-atlas-finops', 'operation-atlas-finops-2', 'reserved-capacity', 'Reserved Capacity', 'Confirm exactly how much this fleet actually saves by committing steady-state workloads to reserved capacity instead of on-demand.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-finops-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"reserved-capacity-sim"}'::jsonb, '{"xp":730,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-finops-09', 'world-atlas-finops', 'campaign-atlas-finops', 'operation-atlas-finops-2', 'spot', 'Spot', 'Confirm exactly which real workloads on this fleet are actually safe to run on interruptible spot capacity, and why.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-finops-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"spot-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-finops-10', 'world-atlas-finops', 'campaign-atlas-finops', 'operation-atlas-finops-2', 'allocation', 'Allocation', 'Confirm exactly how this fleet''s real cost is now actually attributed to the team that owns it, using the same owner tags Act 30 already requires.', 'beginner', ARRAY['leena'], '{"requiredMissionIds":["mission-atlas-finops-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"allocation-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-finops-11', 'world-atlas-finops', 'campaign-atlas-finops', 'operation-atlas-finops-2', 'finops-culture', 'FinOps Culture', 'Understand exactly what actually has to change for cost to become every engineering team''s job, not just finance''s.', 'beginner', ARRAY['leena'], '{"requiredMissionIds":["mission-atlas-finops-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"finops-culture-sim"}'::jsonb, '{"xp":750,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-finops-12', 'world-atlas-finops', 'campaign-atlas-finops', 'operation-atlas-finops-2', 'infinite-bill', 'Infinite Bill', 'Everything this Act taught, turned on one real spike: not to just confirm what it is not, to explain what it actually is.', 'boss', ARRAY['vey','leena','byte'], '{"requiredMissionIds":["mission-atlas-finops-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"infinite-bill-boss-sim"}'::jsonb, '{"xp":840,"credits":205,"badgeIds":["infinite-bill"],"skillXp":{"cloud_devops_fundamentals":140}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-finops-01', 1, 'leena', 'Thirty-two Acts of building resilient, secure, well-platformed infrastructure. Nobody has been watching what any of it actually costs.'),
  ('mission-atlas-finops-01', 2, 'vey', 'Tomas Vey. Every dollar this fleet spends maps to something real -- compute, storage, egress. Understanding the real cost model is the only way to tell a genuine problem from a normal one.'),

  ('mission-atlas-finops-02', 1, 'vey', 'Confirm exactly how this fleet''s real compute spend actually breaks down before assuming anything about where the growth is coming from.'),

  ('mission-atlas-finops-03', 1, 'vey', 'Confirm exactly what real storage spend actually consists of, including every snapshot Act 29''s own 15-minute schedule now takes.'),

  ('mission-atlas-finops-04', 1, 'vey', 'Confirm exactly what actually drives egress cost, including the cross-region replication Act 29 built on purpose -- real, expected, and already budgeted for.'),

  ('mission-atlas-finops-05', 1, 'vey', 'Confirm exactly what a real idle-resources audit actually finds still running today, forgotten, as far back as Act 10.'),

  ('mission-atlas-finops-06', 1, 'vey', 'Confirm exactly which real instances are actually oversized for what they measurably do.'),

  ('mission-atlas-finops-07', 1, 'vey', 'Confirm exactly what a real autoscaling group has actually been costing, sustained over months, not just at the one moment it was meant to peak.'),

  ('mission-atlas-finops-08', 1, 'vey', 'Confirm exactly how much this fleet actually saves committing its real, steady-state workloads to reserved capacity.'),

  ('mission-atlas-finops-09', 1, 'vey', 'Confirm exactly which real workloads are actually safe on interruptible spot capacity, and which absolutely are not.'),

  ('mission-atlas-finops-10', 1, 'leena', 'Confirm exactly how real cost is now actually attributed to the team that owns it, using the same owner tags Act 30 already requires on everything.'),

  ('mission-atlas-finops-11', 1, 'leena', 'Understand exactly what has to change for cost to become every engineering team''s job, visible by default, not something finance discovers a month later.'),

  ('mission-atlas-finops-12', 1, 'leena', 'Everything this Act taught you, turned on one real spike. Not just to confirm what it is not -- to explain what it actually is.'),
  ('mission-atlas-finops-12', 2, 'byte', 'I have the monthly cost trend pulled up. The spike is real, and it has been building for months.'),
  ('mission-atlas-finops-12', 3, 'vey', 'The Act 29 replication cost is exactly what it has always been. Unchanged. That was never the spike.'),
  ('mission-atlas-finops-12', 4, 'leena', 'Then find what actually is, and make sure this fleet never stops watching for it again.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-finops-01-o1', 'mission-atlas-finops-01', 1, 'Explain the cloud cost model', 'Choose the accurate description of how real cloud cost actually accrues.'),

  ('mission-atlas-finops-02-o1', 'mission-atlas-finops-02', 1, 'Read the compute cost breakdown', 'Read the compute cost breakdown and submit the verification code.'),

  ('mission-atlas-finops-03-o1', 'mission-atlas-finops-03', 1, 'Read the storage cost breakdown', 'Read the storage cost breakdown and submit the verification code.'),

  ('mission-atlas-finops-04-o1', 'mission-atlas-finops-04', 1, 'Read the egress cost breakdown', 'Read the egress cost breakdown and submit the verification code.'),

  ('mission-atlas-finops-05-o1', 'mission-atlas-finops-05', 1, 'Read the idle resources report', 'Read the idle resources report and submit the verification code.'),

  ('mission-atlas-finops-06-o1', 'mission-atlas-finops-06', 1, 'Read the rightsizing report', 'Read the rightsizing recommendations report and submit the verification code.'),

  ('mission-atlas-finops-07-o1', 'mission-atlas-finops-07', 1, 'Read the autoscaling cost analysis', 'Read the autoscaling cost analysis and submit the verification code.'),

  ('mission-atlas-finops-08-o1', 'mission-atlas-finops-08', 1, 'Read the reserved capacity analysis', 'Read the reserved capacity analysis and submit the verification code.'),

  ('mission-atlas-finops-09-o1', 'mission-atlas-finops-09', 1, 'Read the spot usage report', 'Read the spot usage report and submit the verification code.'),

  ('mission-atlas-finops-10-o1', 'mission-atlas-finops-10', 1, 'Read the cost allocation report', 'Read the cost allocation report and submit the verification code.'),

  ('mission-atlas-finops-11-o1', 'mission-atlas-finops-11', 1, 'Explain FinOps culture', 'Choose the accurate description of what a real FinOps culture actually requires.'),

  ('mission-atlas-finops-12-o1', 'mission-atlas-finops-12', 1, 'Confirm the monthly cost trend', 'Read the monthly cost trend and submit the verification code.'),
  ('mission-atlas-finops-12-o2', 'mission-atlas-finops-12', 2, 'Confirm the replication cost is unchanged', 'Read the replication cost confirmation and submit the verification code.'),
  ('mission-atlas-finops-12-o3', 'mission-atlas-finops-12', 3, 'Identify what actually drove the spike', 'Find the evidence that explains the real cause of the cost spike.'),
  ('mission-atlas-finops-12-o4', 'mission-atlas-finops-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-finops-01-o1-c1', 'mission-atlas-finops-01-o1', 1, 'multiple_choice', 'Real cloud cost actually accrues...', '{"question":"Real cloud cost actually accrues...","options":[{"id":"a","text":"Continuously, from every provisioned resource, whether it is actively doing useful work or not -- provisioning something is itself the cost event, not just using it"},{"id":"b","text":"Only at the moment a resource is actively processing a real request"},{"id":"c","text":"Only for compute, never for storage or network traffic"},{"id":"d","text":"On a fixed schedule, unrelated to what is actually running"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-finops-02-o1-c1', 'mission-atlas-finops-02-o1', 1, 'terminal_simulation', 'Read the compute cost breakdown and submit the verification code.', '{"instructions":"Read /var/atlas-finops-01/compute-cost-breakdown.txt and submit the verification code with: submit CODE","hostname":"atlas-finops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-finops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-finops-01/compute-cost-breakdown.txt":{"type":"file","content":"compute spend, this month\non-demand: 41 percent\nreserved: 38 percent\nspot: 6 percent\nautoscaling groups (on-demand pricing): 15 percent\n# verification COMPUTECOST-4471\n"}}}'::jsonb, '{"requiredFlag":"COMPUTECOST-4471"}'::jsonb),

  ('mission-atlas-finops-03-o1-c1', 'mission-atlas-finops-03-o1', 1, 'terminal_simulation', 'Read the storage cost breakdown and submit the verification code.', '{"instructions":"Read /var/atlas-finops-01/storage-cost-breakdown.txt and submit the verification code with: submit CODE","hostname":"atlas-finops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-finops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-finops-01/storage-cost-breakdown.txt":{"type":"file","content":"storage spend, this month\nattached volumes: 52 percent\nsnapshots (Act 29''s 15-minute schedule, 30-day retention): 31 percent\nunattached volumes, no instance using them: 17 percent, flagged for review\n# verification STORAGECOST-8802\n"}}}'::jsonb, '{"requiredFlag":"STORAGECOST-8802"}'::jsonb),

  ('mission-atlas-finops-04-o1-c1', 'mission-atlas-finops-04-o1', 1, 'terminal_simulation', 'Read the egress cost breakdown and submit the verification code.', '{"instructions":"Read /var/atlas-finops-01/egress-cost-breakdown.txt and submit the verification code with: submit CODE","hostname":"atlas-finops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-finops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-finops-01/egress-cost-breakdown.txt":{"type":"file","content":"egress spend, this month\ncross-region replication (Act 29 disaster recovery, us-east-1 to us-west-2): 62 percent -- real, expected, unchanged since Act 29 launched\nclient-facing traffic: 38 percent\n# verification EGRESSCOST-2201\n"}}}'::jsonb, '{"requiredFlag":"EGRESSCOST-2201"}'::jsonb),

  ('mission-atlas-finops-05-o1-c1', 'mission-atlas-finops-05-o1', 1, 'terminal_simulation', 'Read the idle resources report and submit the verification code.', '{"instructions":"Read /var/atlas-finops-01/idle-resources-report.txt and submit the verification code with: submit CODE","hostname":"atlas-finops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-finops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-finops-01/idle-resources-report.txt":{"type":"file","content":"idle resources audit\n7 instances and 12 volumes found with zero real traffic or attachment for over 90 days\noldest: dates back to the Act 10 second-region buildout, never decommissioned once traffic was ever routed there\ncombined monthly cost of everything found idle: substantial, and entirely avoidable\n# verification IDLE-3387\n"}}}'::jsonb, '{"requiredFlag":"IDLE-3387"}'::jsonb),

  ('mission-atlas-finops-06-o1-c1', 'mission-atlas-finops-06-o1', 1, 'terminal_simulation', 'Read the rightsizing recommendations report and submit the verification code.', '{"instructions":"Read /var/atlas-finops-01/rightsizing-report.txt and submit the verification code with: submit CODE","hostname":"atlas-finops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-finops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-finops-01/rightsizing-report.txt":{"type":"file","content":"rightsizing recommendations\n9 instances measured running below 20 percent average CPU utilization over 30 days\nrecommendation: downsize each to the next smaller instance class\n# verification RIGHTSIZE-6602\n"}}}'::jsonb, '{"requiredFlag":"RIGHTSIZE-6602"}'::jsonb),

  ('mission-atlas-finops-07-o1-c1', 'mission-atlas-finops-07-o1', 1, 'terminal_simulation', 'Read the autoscaling cost analysis and submit the verification code.', '{"instructions":"Read /var/atlas-finops-01/autoscaling-cost-analysis.txt and submit the verification code with: submit CODE","hostname":"atlas-finops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-finops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-finops-01/autoscaling-cost-analysis.txt":{"type":"file","content":"autoscaling group analysis: collector-asg\ncurrent state: pinned at maximum capacity (20 instances) for the last 4 months straight\nscale-down threshold: manually raised during an old incident, to prevent premature scale-in, and never lowered back afterward\nresult: paying for peak capacity, permanently, for a load that is not actually peak most of the time\n# verification AUTOSCALE-9034\n"}}}'::jsonb, '{"requiredFlag":"AUTOSCALE-9034"}'::jsonb),

  ('mission-atlas-finops-08-o1-c1', 'mission-atlas-finops-08-o1', 1, 'terminal_simulation', 'Read the reserved capacity analysis and submit the verification code.', '{"instructions":"Read /var/atlas-finops-01/reserved-capacity-analysis.txt and submit the verification code with: submit CODE","hostname":"atlas-finops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-finops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-finops-01/reserved-capacity-analysis.txt":{"type":"file","content":"reserved capacity analysis\nsteady-state workloads committed to a 1-year reservation: 38 percent of compute spend\nmeasured savings versus on-demand pricing for the same workloads: 41 percent\n# verification RESERVED-7714\n"}}}'::jsonb, '{"requiredFlag":"RESERVED-7714"}'::jsonb),

  ('mission-atlas-finops-09-o1-c1', 'mission-atlas-finops-09-o1', 1, 'terminal_simulation', 'Read the spot usage report and submit the verification code.', '{"instructions":"Read /var/atlas-finops-01/spot-usage-report.txt and submit the verification code with: submit CODE","hostname":"atlas-finops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-finops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-finops-01/spot-usage-report.txt":{"type":"file","content":"spot capacity usage\nsafe workloads: fault-tolerant, interruption-tolerant batch jobs, like the stateful batch pipeline Act 30 flagged as uncovered\nunsafe workloads: anything stateful and long-running without its own checkpoint-and-resume logic\nmeasured savings on eligible workloads: 68 percent versus on-demand\n# verification SPOT-1187\n"}}}'::jsonb, '{"requiredFlag":"SPOT-1187"}'::jsonb),

  ('mission-atlas-finops-10-o1-c1', 'mission-atlas-finops-10-o1', 1, 'terminal_simulation', 'Read the cost allocation report and submit the verification code.', '{"instructions":"Read /var/atlas-finops-01/cost-allocation-report.txt and submit the verification code with: submit CODE","hostname":"atlas-finops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-finops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-finops-01/cost-allocation-report.txt":{"type":"file","content":"cost allocation, by owning team, using the Act 30 mandatory owner tag\nevery resource created through the platform since Act 30 launch: 100 percent attributed to a real owning team\nresources predating Act 30''s tag requirement: still unattributed, the same resources the idle-resources audit is now finding\n# verification ALLOCATION-2201\n"}}}'::jsonb, '{"requiredFlag":"ALLOCATION-2201"}'::jsonb),

  ('mission-atlas-finops-11-o1-c1', 'mission-atlas-finops-11-o1', 1, 'multiple_choice', 'A real FinOps culture actually requires...', '{"question":"A real FinOps culture actually requires...","options":[{"id":"a","text":"Cost visibility built into every engineering team''s own regular workflow, treated as a shared concern, rather than a finance-only report discovered after the fact"},{"id":"b","text":"A single centralized team responsible for every cost decision across the whole organization"},{"id":"c","text":"Reviewing cost exactly once, at the end of a fiscal year"},{"id":"d","text":"Choosing the cheapest possible option for every resource, regardless of reliability or performance needs"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-finops-12-o1-c1', 'mission-atlas-finops-12-o1', 1, 'terminal_simulation', 'Read the monthly cost trend and submit the verification code.', '{"instructions":"Read /var/atlas-finops-01/monthly-cost-trend.txt and submit the verification code with: submit CODE","hostname":"atlas-finops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-finops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-finops-01/monthly-cost-trend.txt":{"type":"file","content":"monthly cloud spend, last 6 months\nsteady growth of roughly 4 percent per month for the first 4 months\nlast 2 months: growth accelerated to roughly 19 percent per month\n# verification COSTTREND-6631\n"}}}'::jsonb, '{"requiredFlag":"COSTTREND-6631"}'::jsonb),
  ('mission-atlas-finops-12-o2-c1', 'mission-atlas-finops-12-o2', 1, 'terminal_simulation', 'Read the replication cost confirmation and submit the verification code.', '{"instructions":"Read /var/atlas-finops-01/replication-cost-confirmation.txt and submit the verification code with: submit CODE","hostname":"atlas-finops-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-finops-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-finops-01/replication-cost-confirmation.txt":{"type":"file","content":"Act 29 cross-region replication cost, month over month for the last 6 months: flat, within normal variance\nconclusion: not the source of the recent acceleration\n# verification REPLCOST-7742\n"}}}'::jsonb, '{"requiredFlag":"REPLCOST-7742"}'::jsonb),
  ('mission-atlas-finops-12-o3-c1', 'mission-atlas-finops-12-o3', 1, 'investigation', 'Which evidence explains the real cost spike?', '{"evidence":[{"id":"e1","label":"Monthly cost trend","detail":"Growth accelerated from roughly 4 percent to roughly 19 percent per month over the last 2 months"},{"id":"e2","label":"Replication cost confirmation","detail":"Act 29''s cross-region replication cost has stayed flat for 6 months -- confirmed not the source"},{"id":"e3","label":"Idle resources report","detail":"7 instances and 12 volumes, some dating back to Act 10, found idle for over 90 days and never decommissioned"},{"id":"e4","label":"Autoscaling cost analysis","detail":"collector-asg has been pinned at maximum capacity for 4 months because its scale-down threshold was manually raised during an old incident and never lowered back"}],"question":"Which evidence explains the real cost spike?"}'::jsonb, '{"requiredEvidenceIds":["e3","e4"]}'::jsonb),
  ('mission-atlas-finops-12-o4-c1', 'mission-atlas-finops-12-o4', 1, 'boss_encounter', 'Having confirmed the cost trend, the replication cost, and what actually explains it, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-finops-12-o1","label":"Confirm the monthly cost trend"},{"objectiveRef":"mission-atlas-finops-12-o2","label":"Confirm the replication cost is unchanged"},{"objectiveRef":"mission-atlas-finops-12-o3","label":"Identify what actually drove the spike"}],"task":"State the diagnosis in one sentence: Act 29''s cross-region replication is real, expected, budgeted cost that has stayed completely flat, so it was never the cause of the recent acceleration -- the actual spike comes from two ordinary things stacked together, years of quietly forgotten idle resources dating back to Act 10 that were never decommissioned, and one autoscaling group stuck permanently at maximum capacity because a scale-down threshold raised during an old incident was never lowered back afterward -- the fix is decommissioning the idle resources, resetting the threshold, and making sure a regular cost review, not a crisis, is what catches the next one."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-finops-12-o1","mission-atlas-finops-12-o2","mission-atlas-finops-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-finops-01-o1-c1', 'orientation', 'Think about whether provisioning itself is the cost event, or only active use.', 10, 1),
  ('mission-atlas-finops-01-o1-c1', 'solution', 'Cost accrues continuously from provisioning, whether actively used or not.', 20, 2),

  ('mission-atlas-finops-02-o1-c1', 'orientation', 'Try: cat /var/atlas-finops-01/compute-cost-breakdown.txt', 10, 1),
  ('mission-atlas-finops-02-o1-c1', 'solution', 'On-demand, reserved, spot and autoscaling groups, verification COMPUTECOST-4471. submit COMPUTECOST-4471', 20, 2),

  ('mission-atlas-finops-03-o1-c1', 'orientation', 'Try: cat /var/atlas-finops-01/storage-cost-breakdown.txt', 10, 1),
  ('mission-atlas-finops-03-o1-c1', 'solution', 'Attached volumes, snapshots, and unattached volumes flagged for review, verification STORAGECOST-8802. submit STORAGECOST-8802', 20, 2),

  ('mission-atlas-finops-04-o1-c1', 'orientation', 'Try: cat /var/atlas-finops-01/egress-cost-breakdown.txt', 10, 1),
  ('mission-atlas-finops-04-o1-c1', 'solution', 'Replication is 62 percent, real and unchanged, verification EGRESSCOST-2201. submit EGRESSCOST-2201', 20, 2),

  ('mission-atlas-finops-05-o1-c1', 'orientation', 'Try: cat /var/atlas-finops-01/idle-resources-report.txt', 10, 1),
  ('mission-atlas-finops-05-o1-c1', 'solution', '7 instances, 12 volumes, some dating to Act 10, verification IDLE-3387. submit IDLE-3387', 20, 2),

  ('mission-atlas-finops-06-o1-c1', 'orientation', 'Try: cat /var/atlas-finops-01/rightsizing-report.txt', 10, 1),
  ('mission-atlas-finops-06-o1-c1', 'solution', '9 instances under 20 percent utilization, verification RIGHTSIZE-6602. submit RIGHTSIZE-6602', 20, 2),

  ('mission-atlas-finops-07-o1-c1', 'orientation', 'Try: cat /var/atlas-finops-01/autoscaling-cost-analysis.txt', 10, 1),
  ('mission-atlas-finops-07-o1-c1', 'solution', 'Pinned at max capacity 4 months, threshold never lowered back, verification AUTOSCALE-9034. submit AUTOSCALE-9034', 20, 2),

  ('mission-atlas-finops-08-o1-c1', 'orientation', 'Try: cat /var/atlas-finops-01/reserved-capacity-analysis.txt', 10, 1),
  ('mission-atlas-finops-08-o1-c1', 'solution', '41 percent measured savings, verification RESERVED-7714. submit RESERVED-7714', 20, 2),

  ('mission-atlas-finops-09-o1-c1', 'orientation', 'Try: cat /var/atlas-finops-01/spot-usage-report.txt', 10, 1),
  ('mission-atlas-finops-09-o1-c1', 'solution', 'Fault-tolerant batch jobs only, 68 percent savings, verification SPOT-1187. submit SPOT-1187', 20, 2),

  ('mission-atlas-finops-10-o1-c1', 'orientation', 'Try: cat /var/atlas-finops-01/cost-allocation-report.txt', 10, 1),
  ('mission-atlas-finops-10-o1-c1', 'solution', '100 percent attribution since Act 30''s owner tag, older resources still unattributed, verification ALLOCATION-2201. submit ALLOCATION-2201', 20, 2),

  ('mission-atlas-finops-11-o1-c1', 'orientation', 'Think about a shared workflow concern versus a finance-only report.', 10, 1),
  ('mission-atlas-finops-11-o1-c1', 'solution', 'Cost visibility built into every team''s own workflow.', 20, 2),

  ('mission-atlas-finops-12-o1-c1', 'orientation', 'Try: cat /var/atlas-finops-01/monthly-cost-trend.txt', 10, 1),
  ('mission-atlas-finops-12-o1-c1', 'solution', 'Growth jumped from 4 percent to 19 percent per month, verification COSTTREND-6631. submit COSTTREND-6631', 20, 2),
  ('mission-atlas-finops-12-o2-c1', 'orientation', 'Try: cat /var/atlas-finops-01/replication-cost-confirmation.txt', 10, 1),
  ('mission-atlas-finops-12-o2-c1', 'solution', 'Flat for 6 months, not the source, verification REPLCOST-7742. submit REPLCOST-7742', 20, 2),
  ('mission-atlas-finops-12-o3-c1', 'orientation', 'The replication cost is confirmed flat and ruled out. Compare the idle-resources report against the autoscaling analysis.', 10, 1),
  ('mission-atlas-finops-12-o3-c1', 'solution', 'e3 and e4: years of forgotten idle resources, plus one autoscaling group stuck at maximum capacity.', 20, 2),
  ('mission-atlas-finops-12-o4-c1', 'orientation', 'Combine the ruled-out replication cost, the two real causes, and the fix into one sentence.', 15, 1),
  ('mission-atlas-finops-12-o4-c1', 'solution', 'Forgotten idle resources plus a stuck autoscaling threshold, not replication, drove the spike; the fix is cleanup plus a regular cost review.', 25, 2);
