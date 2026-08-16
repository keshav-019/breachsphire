-- Atlas Division pathway ("The Silence") Act 35 -- "The Control Plane"
-- content, under world-atlas-control-plane (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), continuing World X "Atlas".
--
-- Same terminal-engine constraint as every prior Atlas Act. One new
-- host, `atlas-control-01`, holds every control-plane config and
-- controller log this Act builds. Deliberately references, but never
-- duplicates, the Act 30 platform's own self-service database feature.
--
-- Narrative thread: mission 7 (leader election) and mission 9 (rate
-- limits) each plant one of the two real contributing gaps as a plain
-- fact, well before the boss needs either one -- both look like minor,
-- individually defensible omissions at the time. The boss requires all
-- three pieces of evidence together (`e2`+`e3`+`e4`) rather than the
-- usual two -- reconciliation logic, missing leader election, and
-- missing rate limits all had to be true simultaneously for the
-- incident to happen, the most compound cause this pathway has built,
-- fitting the Act it closes out on.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-control-plane', 'world-atlas-control-plane', 'control-plane', '10C - The Control Plane', 'Learn infrastructure architecture from first principles -- control versus data plane, management APIs, schedulers, controllers, reconciliation, desired state, leader election, coordination, rate limits, safe automation and blast radius -- and find out why one automated controller nearly took down the very API every other controller on this fleet depends on.', 3);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-control-plane-1', 'campaign-atlas-control-plane', 'how-automation-actually-decides', 'How Automation Actually Decides', 'Control vs data plane, management APIs, schedulers, controllers, reconciliation and desired state.', 1),
  ('operation-atlas-control-plane-2', 'campaign-atlas-control-plane', 'what-keeps-automation-safe', 'What Keeps Automation Safe', 'Leader election, coordination, rate limits, safe automation, blast radius, and the controller itself.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-control-plane-01', 'world-atlas-control-plane', 'campaign-atlas-control-plane', 'operation-atlas-control-plane-1', 'control-vs-data-plane', 'Control vs Data Plane', 'The Act 30 platform''s own auto-remediation controller has started hammering the management API, with no real work getting done.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"control-vs-data-plane-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-control-plane-02', 'world-atlas-control-plane', 'campaign-atlas-control-plane', 'operation-atlas-control-plane-1', 'management-apis', 'Management APIs', 'Confirm exactly what this fleet''s real management API actually controls, and why every controller on this fleet depends on that same one.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-control-plane-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"management-apis-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-control-plane-03', 'world-atlas-control-plane', 'campaign-atlas-control-plane', 'operation-atlas-control-plane-1', 'schedulers', 'Schedulers', 'Confirm exactly how a real scheduler, first met back in Act 17, actually decides where something desired should actually run.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-control-plane-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"schedulers-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-control-plane-04', 'world-atlas-control-plane', 'campaign-atlas-control-plane', 'operation-atlas-control-plane-1', 'controllers', 'Controllers', 'Confirm exactly what a real controller actually does, in a continuous loop, that a one-time script never could.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-control-plane-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"controllers-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-control-plane-05', 'world-atlas-control-plane', 'campaign-atlas-control-plane', 'operation-atlas-control-plane-1', 'reconciliation', 'Reconciliation', 'Confirm exactly what the Act 30 platform''s own database-backup controller is actually supposed to reconcile toward.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-control-plane-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"reconciliation-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-control-plane-06', 'world-atlas-control-plane', 'campaign-atlas-control-plane', 'operation-atlas-control-plane-1', 'desired-state', 'Desired State', 'Confirm exactly what desired state this controller''s reconciliation loop is actually comparing real state against.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-control-plane-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"desired-state-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-control-plane-07', 'world-atlas-control-plane', 'campaign-atlas-control-plane', 'operation-atlas-control-plane-2', 'leader-election', 'Leader Election', 'Confirm exactly how many real replicas of this controller are actually running right now, and whether only one of them is actually supposed to act.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-control-plane-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"leader-election-sim"}'::jsonb, '{"xp":730,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-control-plane-08', 'world-atlas-control-plane', 'campaign-atlas-control-plane', 'operation-atlas-control-plane-2', 'coordination', 'Coordination', 'Understand exactly what actually goes wrong when multiple automated actors act on the same real resource with no coordination between them.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-control-plane-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"coordination-sim"}'::jsonb, '{"xp":730,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-control-plane-09', 'world-atlas-control-plane', 'campaign-atlas-control-plane', 'operation-atlas-control-plane-2', 'rate-limits', 'Rate Limits', 'Confirm exactly what actually rate-limits this controller''s own calls to the shared management API, if anything does.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-control-plane-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"rate-limits-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-control-plane-10', 'world-atlas-control-plane', 'campaign-atlas-control-plane', 'operation-atlas-control-plane-2', 'safe-automation', 'Safe Automation', 'Understand exactly what real safeguards separate automation this fleet can actually trust from automation that can quietly run away.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-control-plane-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"safe-automation-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-control-plane-11', 'world-atlas-control-plane', 'campaign-atlas-control-plane', 'operation-atlas-control-plane-2', 'blast-radius', 'Blast Radius', 'Confirm exactly how far this one controller''s real blast radius actually reached once its calls started crowding out everything else.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-control-plane-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"blast-radius-sim"}'::jsonb, '{"xp":750,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-control-plane-12', 'world-atlas-control-plane', 'campaign-atlas-control-plane', 'operation-atlas-control-plane-2', 'controller-gone-wild', 'Controller Gone Wild', 'Everything this Act taught, turned on one real runaway controller: not to just confirm it was hammering the API, to explain every real reason it was ever able to.', 'boss', ARRAY['rook','cross','leena','byte'], '{"requiredMissionIds":["mission-atlas-control-plane-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"controller-gone-wild-boss-sim"}'::jsonb, '{"xp":850,"credits":210,"badgeIds":["controller-gone-wild"],"skillXp":{"cloud_devops_fundamentals":145}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-control-plane-01', 1, 'leena', 'The Act 30 platform''s own auto-remediation controller has started hammering the management API. No real work is actually getting done.'),
  ('mission-atlas-control-plane-01', 2, 'rook', 'Rook. The data plane serves real traffic. The control plane decides what should exist and pushes toward it. Something in this controller''s own control-plane logic has clearly gone wrong.'),

  ('mission-atlas-control-plane-02', 1, 'rook', 'Confirm exactly what this fleet''s real management API actually controls, and why every single controller on this fleet ultimately depends on that one shared API.'),

  ('mission-atlas-control-plane-03', 1, 'rook', 'Confirm exactly how a real scheduler, first met back in Act 17, actually decides where something desired should run in the first place.'),

  ('mission-atlas-control-plane-04', 1, 'rook', 'Confirm exactly what a real controller actually does, continuously, in a loop, that a one-time script never could.'),

  ('mission-atlas-control-plane-05', 1, 'rook', 'Confirm exactly what the Act 30 platform''s own database-backup controller is actually supposed to reconcile real state toward.'),

  ('mission-atlas-control-plane-06', 1, 'rook', 'Confirm exactly what desired state this controller''s reconciliation loop is actually comparing real state against, field by field.'),

  ('mission-atlas-control-plane-07', 1, 'cross', 'Imani Cross. Confirm exactly how many real replicas of this controller are actually running right now, and whether only one of them was ever supposed to act at a time.'),

  ('mission-atlas-control-plane-08', 1, 'cross', 'Understand exactly what actually goes wrong when multiple automated actors, with no coordination between them, all act on the exact same real resource.'),

  ('mission-atlas-control-plane-09', 1, 'cross', 'Confirm exactly what actually rate-limits this controller''s own calls to the shared management API -- if anything genuinely does.'),

  ('mission-atlas-control-plane-10', 1, 'cross', 'Understand exactly what real safeguards separate automation this fleet can actually trust from automation that can quietly run away unnoticed.'),

  ('mission-atlas-control-plane-11', 1, 'cross', 'Confirm exactly how far this one controller''s real blast radius actually reached once it started crowding out every other controller sharing that same API.'),

  ('mission-atlas-control-plane-12', 1, 'leena', 'Everything this Act taught you, turned on one real runaway controller. Not just to confirm it was hammering the API -- to explain every real reason it was ever able to.'),
  ('mission-atlas-control-plane-12', 2, 'byte', 'I have the management API request log pulled up. This one controller alone accounts for the overwhelming majority of all recent traffic.'),
  ('mission-atlas-control-plane-12', 3, 'rook', 'And I have its reconciliation loop. It is comparing against a field that changes on every single read -- it will never see a match, ever, even when nothing real has actually changed.'),
  ('mission-atlas-control-plane-12', 4, 'cross', 'That alone explains constant reapplying. It does not explain the full scale of this. Find what let it get this far.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-control-plane-01-o1', 'mission-atlas-control-plane-01', 1, 'Explain control vs data plane', 'Choose the accurate description of the difference between the control plane and the data plane.'),

  ('mission-atlas-control-plane-02-o1', 'mission-atlas-control-plane-02', 1, 'Read the management API reference', 'Read the management API reference and submit the verification code.'),

  ('mission-atlas-control-plane-03-o1', 'mission-atlas-control-plane-03', 1, 'Read the scheduler overview', 'Read the scheduler overview and submit the verification code.'),

  ('mission-atlas-control-plane-04-o1', 'mission-atlas-control-plane-04', 1, 'Read the controller overview', 'Read the controller overview and submit the verification code.'),

  ('mission-atlas-control-plane-05-o1', 'mission-atlas-control-plane-05', 1, 'Read the reconciliation purpose', 'Read the backup controller''s reconciliation purpose and submit the verification code.'),

  ('mission-atlas-control-plane-06-o1', 'mission-atlas-control-plane-06', 1, 'Read the desired state manifest', 'Read the desired state manifest and submit the verification code.'),

  ('mission-atlas-control-plane-07-o1', 'mission-atlas-control-plane-07', 1, 'Read the leader election status', 'Read the leader election status and submit the verification code.'),

  ('mission-atlas-control-plane-08-o1', 'mission-atlas-control-plane-08', 1, 'Explain coordination', 'Choose the accurate description of what goes wrong without coordination between automated actors.'),

  ('mission-atlas-control-plane-09-o1', 'mission-atlas-control-plane-09', 1, 'Read the rate limit configuration', 'Read the controller''s API rate limit configuration and submit the verification code.'),

  ('mission-atlas-control-plane-10-o1', 'mission-atlas-control-plane-10', 1, 'Explain safe automation', 'Choose the accurate description of what makes automation genuinely safe to trust.'),

  ('mission-atlas-control-plane-11-o1', 'mission-atlas-control-plane-11', 1, 'Read the blast radius report', 'Read the blast radius report and submit the verification code.'),

  ('mission-atlas-control-plane-12-o1', 'mission-atlas-control-plane-12', 1, 'Confirm the API request log', 'Read the management API request log and submit the verification code.'),
  ('mission-atlas-control-plane-12-o2', 'mission-atlas-control-plane-12', 2, 'Confirm the reconciliation loop bug', 'Read the reconciliation loop code and submit the verification code.'),
  ('mission-atlas-control-plane-12-o3', 'mission-atlas-control-plane-12', 3, 'Identify every real contributing cause', 'Find every piece of evidence that explains how this controller was ever able to reach this scale.'),
  ('mission-atlas-control-plane-12-o4', 'mission-atlas-control-plane-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-control-plane-01-o1-c1', 'mission-atlas-control-plane-01-o1', 1, 'multiple_choice', 'The control plane and the data plane actually differ by...', '{"question":"The control plane and the data plane actually differ by...","options":[{"id":"a","text":"The control plane decides and pushes toward what should exist; the data plane actually carries and serves the real traffic itself"},{"id":"b","text":"They are two names for exactly the same layer"},{"id":"c","text":"The data plane only exists in Kubernetes, never anywhere else"},{"id":"d","text":"The control plane only matters during a deployment and is otherwise unused"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-control-plane-02-o1-c1', 'mission-atlas-control-plane-02-o1', 1, 'terminal_simulation', 'Read the management API reference and submit the verification code.', '{"instructions":"Read /repo/infra-envs/control/management-api-reference.yaml and submit the verification code with: submit CODE","hostname":"atlas-control-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-control-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/control/management-api-reference.yaml":{"type":"file","content":"management_api:\n  controls: every real resource''s desired state -- deployments, databases, secrets, DNS records\n  shared_by: every controller on this fleet, including the mesh control plane and the Act 30 platform controllers\n# a single overloaded management API is a single shared dependency for all of them\n# verification MGMTAPI-4471\n"}}}'::jsonb, '{"requiredFlag":"MGMTAPI-4471"}'::jsonb),

  ('mission-atlas-control-plane-03-o1-c1', 'mission-atlas-control-plane-03-o1', 1, 'terminal_simulation', 'Read the scheduler overview and submit the verification code.', '{"instructions":"Read /repo/infra-envs/control/scheduler-overview.yaml and submit the verification code with: submit CODE","hostname":"atlas-control-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-control-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/control/scheduler-overview.yaml":{"type":"file","content":"scheduler:\n  decides: which real node a desired workload should actually run on\n  inputs: available resources per node, workload requirements, placement constraints\n  first introduced: Act 17, still the same core scheduling logic\n# verification SCHEDULER-8802\n"}}}'::jsonb, '{"requiredFlag":"SCHEDULER-8802"}'::jsonb),

  ('mission-atlas-control-plane-04-o1-c1', 'mission-atlas-control-plane-04-o1', 1, 'terminal_simulation', 'Read the controller overview and submit the verification code.', '{"instructions":"Read /repo/infra-envs/control/controller-overview.yaml and submit the verification code with: submit CODE","hostname":"atlas-control-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-control-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/control/controller-overview.yaml":{"type":"file","content":"controller:\n  runs: continuously, in a loop, not once\n  each iteration: observes real state, compares it against desired state, takes action to close any real gap\n# a one-time script only ever checks once; a controller keeps checking forever\n# verification CONTROLLER-2201\n"}}}'::jsonb, '{"requiredFlag":"CONTROLLER-2201"}'::jsonb),

  ('mission-atlas-control-plane-05-o1-c1', 'mission-atlas-control-plane-05-o1', 1, 'terminal_simulation', 'Read the backup controller''s reconciliation purpose and submit the verification code.', '{"instructions":"Read /repo/infra-envs/control/backup-controller-purpose.yaml and submit the verification code with: submit CODE","hostname":"atlas-control-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-control-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/control/backup-controller-purpose.yaml":{"type":"file","content":"backup_controller:\n  purpose: ensure every self-service database provisioned through the Act 30 platform has an up-to-date backup schedule matching its declared RPO\n  introduced: alongside the Act 30 platform launch\n# verification RECONPURPOSE-3387\n"}}}'::jsonb, '{"requiredFlag":"RECONPURPOSE-3387"}'::jsonb),

  ('mission-atlas-control-plane-06-o1-c1', 'mission-atlas-control-plane-06-o1', 1, 'terminal_simulation', 'Read the desired state manifest and submit the verification code.', '{"instructions":"Read /repo/infra-envs/control/desired-state-manifest.yaml and submit the verification code with: submit CODE","hostname":"atlas-control-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-control-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/control/desired-state-manifest.yaml":{"type":"file","content":"desired_state, per database:\n  backup_schedule: matches declared RPO\n  last_checked: a timestamp, updated on every single reconciliation pass\n# last_checked is part of the object being compared, and it always differs from one pass to the next\n# verification DESIREDSTATE-6602\n"}}}'::jsonb, '{"requiredFlag":"DESIREDSTATE-6602"}'::jsonb),

  ('mission-atlas-control-plane-07-o1-c1', 'mission-atlas-control-plane-07-o1', 1, 'terminal_simulation', 'Read the leader election status and submit the verification code.', '{"instructions":"Read /var/atlas-control-01/leader-election-status.txt and submit the verification code with: submit CODE","hostname":"atlas-control-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-control-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-control-01/leader-election-status.txt":{"type":"file","content":"backup_controller replicas running: 3\nleader_election: disabled\nresult: all 3 replicas independently run the same reconciliation loop, on the same real resources, at the same time\n# verification LEADERELECT-9034\n"}}}'::jsonb, '{"requiredFlag":"LEADERELECT-9034"}'::jsonb),

  ('mission-atlas-control-plane-08-o1-c1', 'mission-atlas-control-plane-08-o1', 1, 'multiple_choice', 'Without coordination between automated actors, multiple actors acting on the same resource actually...', '{"question":"Without coordination between automated actors, multiple actors acting on the same resource actually...","options":[{"id":"a","text":"Multiply whatever effect a single actor alone would already have had, whether that effect was correct or not"},{"id":"b","text":"Automatically cancel each other out safely, with no real consequence"},{"id":"c","text":"Only ever matters if the actors are running in different cloud regions"},{"id":"d","text":"Never actually happens in a real distributed system"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-control-plane-09-o1-c1', 'mission-atlas-control-plane-09-o1', 1, 'terminal_simulation', 'Read the controller''s API rate limit configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/control/backup-controller-rate-limit.yaml and submit the verification code with: submit CODE","hostname":"atlas-control-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-control-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/control/backup-controller-rate-limit.yaml":{"type":"file","content":"backup_controller:\n  client_side_rate_limit: none configured\n  management_api_side_rate_limit: none configured for internal controller traffic, only for external API consumers\n# nothing anywhere in this path was ever going to slow this controller down on its own\n# verification RATELIMIT-7714\n"}}}'::jsonb, '{"requiredFlag":"RATELIMIT-7714"}'::jsonb),

  ('mission-atlas-control-plane-10-o1-c1', 'mission-atlas-control-plane-10-o1', 1, 'multiple_choice', 'Automation this fleet can genuinely trust actually requires...', '{"question":"Automation this fleet can genuinely trust actually requires...","options":[{"id":"a","text":"Rate limiting its own calls, comparing against genuinely stable state, and coordinating so only one actor takes action at a time"},{"id":"b","text":"Running as many redundant replicas as possible, with no other safeguards"},{"id":"c","text":"Never comparing against real state at all, only ever acting on a fixed schedule"},{"id":"d","text":"Nothing beyond simply having monitoring in place after the fact"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-control-plane-11-o1-c1', 'mission-atlas-control-plane-11-o1', 1, 'terminal_simulation', 'Read the blast radius report and submit the verification code.', '{"instructions":"Read /var/atlas-control-01/blast-radius-report.txt and submit the verification code with: submit CODE","hostname":"atlas-control-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-control-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-control-01/blast-radius-report.txt":{"type":"file","content":"blast radius of the runaway backup controller\ndirectly affected: every other controller sharing the management API, including the mesh control plane, all experienced elevated latency and some throttled requests\nnot affected: real customer-facing traffic, which never touches the management API directly\n# verification BLASTRADIUS-1187\n"}}}'::jsonb, '{"requiredFlag":"BLASTRADIUS-1187"}'::jsonb),

  ('mission-atlas-control-plane-12-o1-c1', 'mission-atlas-control-plane-12-o1', 1, 'terminal_simulation', 'Read the management API request log and submit the verification code.', '{"instructions":"Read /var/atlas-control-01/incident-api-request-log.txt and submit the verification code with: submit CODE","hostname":"atlas-control-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-control-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-control-01/incident-api-request-log.txt":{"type":"file","content":"management API request volume, last hour\ntotal requests: 340,000\nrequests from backup_controller alone: 318,000 (94 percent of all traffic)\nevery one of those requests: a reapply that changed nothing real\n# verification APIREQLOG-6631\n"}}}'::jsonb, '{"requiredFlag":"APIREQLOG-6631"}'::jsonb),
  ('mission-atlas-control-plane-12-o2-c1', 'mission-atlas-control-plane-12-o2', 1, 'terminal_simulation', 'Read the reconciliation loop code and submit the verification code.', '{"instructions":"Read /var/atlas-control-01/incident-reconciliation-code.txt and submit the verification code with: submit CODE","hostname":"atlas-control-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-control-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-control-01/incident-reconciliation-code.txt":{"type":"file","content":"reconciliation comparison, backup_controller\ncompares the full desired_state object, including last_checked, against real state\nlast_checked is updated on every pass, so the comparison never finds a true match, ever\nresult: reapplies every single pass, on every real database, forever, even when nothing actually needs to change\n# verification RECONCODE-7742\n"}}}'::jsonb, '{"requiredFlag":"RECONCODE-7742"}'::jsonb),
  ('mission-atlas-control-plane-12-o3-c1', 'mission-atlas-control-plane-12-o3', 1, 'investigation', 'Which evidence together explains how this controller was ever able to reach this scale?', '{"evidence":[{"id":"e1","label":"Management API request log","detail":"318,000 of 340,000 requests in one hour came from this one controller, every one a no-op reapply"},{"id":"e2","label":"Leader election status","detail":"3 replicas running with leader election disabled, so all 3 run the same broken loop simultaneously"},{"id":"e3","label":"Reconciliation loop code","detail":"Compares against a field that changes on every read, so it never sees a true match and always reapplies"},{"id":"e4","label":"Rate limit configuration","detail":"No client-side or API-side rate limit exists anywhere for internal controller traffic"}],"question":"Which evidence together explains how this controller was ever able to reach this scale?"}'::jsonb, '{"requiredEvidenceIds":["e2","e3","e4"]}'::jsonb),
  ('mission-atlas-control-plane-12-o4-c1', 'mission-atlas-control-plane-12-o4', 1, 'boss_encounter', 'Having confirmed the API request log, the reconciliation loop code, and every real contributing cause, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-control-plane-12-o1","label":"Confirm the API request log"},{"objectiveRef":"mission-atlas-control-plane-12-o2","label":"Confirm the reconciliation loop bug"},{"objectiveRef":"mission-atlas-control-plane-12-o3","label":"Identify every real contributing cause"}],"task":"State the diagnosis in one sentence: the backup controller''s reconciliation loop compares against a field that changes on every read, so it always believes real state has drifted and always reapplies, even when nothing actually needs to change; running 3 replicas with no leader election let all 3 do this simultaneously instead of just one; and no rate limit anywhere on its calls to the shared management API meant nothing was ever going to stop it before it started crowding out every other controller on this fleet -- fixing any one of these three would have helped, but fixing all three -- a stable comparison, a single elected leader, and a real rate limit -- is what makes this kind of automation actually safe to trust."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-control-plane-12-o1","mission-atlas-control-plane-12-o2","mission-atlas-control-plane-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-control-plane-01-o1-c1', 'orientation', 'Think about deciding what should exist versus actually carrying real traffic.', 10, 1),
  ('mission-atlas-control-plane-01-o1-c1', 'solution', 'Control plane decides and pushes; data plane serves real traffic.', 20, 2),

  ('mission-atlas-control-plane-02-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/control/management-api-reference.yaml', 10, 1),
  ('mission-atlas-control-plane-02-o1-c1', 'solution', 'Controls desired state, shared by every controller, verification MGMTAPI-4471. submit MGMTAPI-4471', 20, 2),

  ('mission-atlas-control-plane-03-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/control/scheduler-overview.yaml', 10, 1),
  ('mission-atlas-control-plane-03-o1-c1', 'solution', 'Decides node placement from resources and constraints, verification SCHEDULER-8802. submit SCHEDULER-8802', 20, 2),

  ('mission-atlas-control-plane-04-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/control/controller-overview.yaml', 10, 1),
  ('mission-atlas-control-plane-04-o1-c1', 'solution', 'Runs continuously, observes and reconciles, verification CONTROLLER-2201. submit CONTROLLER-2201', 20, 2),

  ('mission-atlas-control-plane-05-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/control/backup-controller-purpose.yaml', 10, 1),
  ('mission-atlas-control-plane-05-o1-c1', 'solution', 'Keeps every self-service database backup schedule matching its RPO, verification RECONPURPOSE-3387. submit RECONPURPOSE-3387', 20, 2),

  ('mission-atlas-control-plane-06-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/control/desired-state-manifest.yaml', 10, 1),
  ('mission-atlas-control-plane-06-o1-c1', 'solution', 'Includes last_checked, which always differs, verification DESIREDSTATE-6602. submit DESIREDSTATE-6602', 20, 2),

  ('mission-atlas-control-plane-07-o1-c1', 'orientation', 'Try: cat /var/atlas-control-01/leader-election-status.txt', 10, 1),
  ('mission-atlas-control-plane-07-o1-c1', 'solution', '3 replicas, leader election disabled, verification LEADERELECT-9034. submit LEADERELECT-9034', 20, 2),

  ('mission-atlas-control-plane-08-o1-c1', 'orientation', 'Think about one actor''s effect, multiplied by however many are acting at once.', 10, 1),
  ('mission-atlas-control-plane-08-o1-c1', 'solution', 'Multiplies whatever effect a single actor would have had.', 20, 2),

  ('mission-atlas-control-plane-09-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/control/backup-controller-rate-limit.yaml', 10, 1),
  ('mission-atlas-control-plane-09-o1-c1', 'solution', 'No rate limit configured anywhere for internal traffic, verification RATELIMIT-7714. submit RATELIMIT-7714', 20, 2),

  ('mission-atlas-control-plane-10-o1-c1', 'orientation', 'Think about stable comparisons, a single actor, and a real limit on calls.', 10, 1),
  ('mission-atlas-control-plane-10-o1-c1', 'solution', 'Rate limiting, stable state comparison, and single-actor coordination.', 20, 2),

  ('mission-atlas-control-plane-11-o1-c1', 'orientation', 'Try: cat /var/atlas-control-01/blast-radius-report.txt', 10, 1),
  ('mission-atlas-control-plane-11-o1-c1', 'solution', 'Every controller sharing the API, not customer traffic, verification BLASTRADIUS-1187. submit BLASTRADIUS-1187', 20, 2),

  ('mission-atlas-control-plane-12-o1-c1', 'orientation', 'Try: cat /var/atlas-control-01/incident-api-request-log.txt', 10, 1),
  ('mission-atlas-control-plane-12-o1-c1', 'solution', '94 percent of all traffic, every request a no-op, verification APIREQLOG-6631. submit APIREQLOG-6631', 20, 2),
  ('mission-atlas-control-plane-12-o2-c1', 'orientation', 'Try: cat /var/atlas-control-01/incident-reconciliation-code.txt', 10, 1),
  ('mission-atlas-control-plane-12-o2-c1', 'solution', 'Compares an always-changing field, verification RECONCODE-7742. submit RECONCODE-7742', 20, 2),
  ('mission-atlas-control-plane-12-o3-c1', 'orientation', 'This one needs all three real contributing gaps together, not just the reconciliation bug.', 10, 1),
  ('mission-atlas-control-plane-12-o3-c1', 'solution', 'e2, e3 and e4: no leader election, an unstable comparison, and no rate limit, all at once.', 20, 2),
  ('mission-atlas-control-plane-12-o4-c1', 'orientation', 'Combine all three compounding gaps and the fix into one sentence.', 15, 1),
  ('mission-atlas-control-plane-12-o4-c1', 'solution', 'An unstable comparison, tripled by missing leader election, unchecked by any rate limit -- fixing all three makes the automation trustworthy.', 25, 2);
