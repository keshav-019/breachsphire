-- Atlas Division pathway ("The Silence") Act 25 -- "Reliability"
-- content, under world-atlas-reliability (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), closing World VII "The Signal Tower" (Acts 22-25).
--
-- Same terminal-engine constraint as every prior Atlas Act -- every SRE
-- artifact here is static seeded text read via `cat`. Two hosts: the
-- reused `atlas-devbox-01`, still hosting an `sre/` directory inside
-- the Act 22 `infra-envs` GitOps repo (SLI/SLO/latency/burn-rate
-- definitions, an automation log), and a new `atlas-sre-01` for live
-- SRE data (current measured availability, the four-nines proposal,
-- historical incident-backed availability). Concept-only topics with
-- no natural artifact (what is SRE, SLA, toil, velocity vs
-- reliability) stay multiple_choice.
--
-- Narrative thread: mission 6 (availability) plants the fleet's actual
-- current SLI (99.61%, tracking fine against the existing 99.5% SLO)
-- as a plain fact, before the boss raises the stakes to a completely
-- different target. The boss's investigation deliberately requires
-- both the actual measured number (e2) and what four nines
-- mathematically allows (e3) as the two required evidence items --
-- the proposal itself (e1) and toil/automation notes (e4) are
-- deliberate distractors, since the gap is entirely about honest
-- measurement versus an aspirational number, not about effort or
-- cost.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-reliability', 'world-atlas-reliability', 'reliability', '7D - Reliability', 'Learn SRE foundations -- what SRE actually is, SLIs, SLOs, SLAs, error budgets, availability, latency objectives, burn rates, toil, automation and velocity versus reliability -- while Cross checks whether this fleet can honestly promise four nines to a paying customer.', 4);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-reliability-1', 'campaign-atlas-reliability', 'measuring-what-reliable-means', 'Measuring What Reliable Means', 'What SRE actually is, SLIs, SLOs, SLAs, error budgets and availability.', 1),
  ('operation-atlas-reliability-2', 'campaign-atlas-reliability', 'what-a-promise-actually-costs', 'What a Promise Actually Costs', 'Latency objectives, burn rates, toil, automation and velocity versus reliability.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-reliability-01', 'world-atlas-reliability', 'campaign-atlas-reliability', 'operation-atlas-reliability-1', 'what-is-sre', 'What Is SRE', 'Chasing a new enterprise customer, Atlas Division leadership wants to commit to four nines. Cross is asked to confirm it.', 'beginner', ARRAY['leena','cross'], null, null, '{"type":"simulation","simulationId":"what-is-sre-sim"}'::jsonb, '{"xp":620,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-reliability-02', 'world-atlas-reliability', 'campaign-atlas-reliability', 'operation-atlas-reliability-1', 'sli', 'SLI', 'Confirm the exact, quantitative measure this fleet actually tracks as its own reliability.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-reliability-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"sli-sim"}'::jsonb, '{"xp":620,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-reliability-03', 'world-atlas-reliability', 'campaign-atlas-reliability', 'operation-atlas-reliability-1', 'slo', 'SLO', 'Confirm the actual target this fleet has already committed to internally.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-reliability-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"slo-sim"}'::jsonb, '{"xp":630,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-reliability-04', 'world-atlas-reliability', 'campaign-atlas-reliability', 'operation-atlas-reliability-1', 'sla', 'SLA', 'Understand what actually changes once a number like this is written into a contract instead of an internal target.', 'beginner', ARRAY['leena'], '{"requiredMissionIds":["mission-atlas-reliability-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"sla-sim"}'::jsonb, '{"xp":630,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-reliability-05', 'world-atlas-reliability', 'campaign-atlas-reliability', 'operation-atlas-reliability-1', 'error-budgets', 'Error Budgets', 'Confirm exactly how much room to fail the current SLO actually allows.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-reliability-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"error-budgets-sim"}'::jsonb, '{"xp":640,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-reliability-06', 'world-atlas-reliability', 'campaign-atlas-reliability', 'operation-atlas-reliability-1', 'availability', 'Availability', 'Confirm exactly where this fleet is actually tracking against its existing SLO right now.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-reliability-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"availability-sim"}'::jsonb, '{"xp":640,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-reliability-07', 'world-atlas-reliability', 'campaign-atlas-reliability', 'operation-atlas-reliability-2', 'latency-objectives', 'Latency Objectives', 'Confirm that being reliable was never only ever about whether a request succeeded.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-reliability-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"latency-objectives-sim"}'::jsonb, '{"xp":650,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-reliability-08', 'world-atlas-reliability', 'campaign-atlas-reliability', 'operation-atlas-reliability-2', 'burn-rates', 'Burn Rates', 'Confirm what actually fires an alert here -- not just crossing a line, spending the budget too fast.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-reliability-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"burn-rates-sim"}'::jsonb, '{"xp":650,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-reliability-09', 'world-atlas-reliability', 'campaign-atlas-reliability', 'operation-atlas-reliability-2', 'toil', 'Toil', 'Understand exactly what kind of work SRE actually exists to eliminate, not just automate for its own sake.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-reliability-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"toil-sim"}'::jsonb, '{"xp":660,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-reliability-10', 'world-atlas-reliability', 'campaign-atlas-reliability', 'operation-atlas-reliability-2', 'automation', 'Automation', 'Confirm one specific piece of toil that genuinely does not happen by hand anymore.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-reliability-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"automation-sim"}'::jsonb, '{"xp":660,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-reliability-11', 'world-atlas-reliability', 'campaign-atlas-reliability', 'operation-atlas-reliability-2', 'velocity-vs-reliability', 'Velocity vs Reliability', 'Understand what an error budget actually settles that used to just be an argument.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-reliability-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"velocity-vs-reliability-sim"}'::jsonb, '{"xp":670,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-reliability-12', 'world-atlas-reliability', 'campaign-atlas-reliability', 'operation-atlas-reliability-2', 'four-nines', 'Four Nines', 'Everything this World taught, turned on one proposal: not to just say yes to sound impressive, to finally explain what a promise like this actually requires.', 'boss', ARRAY['cross','leena','rook','byte'], '{"requiredMissionIds":["mission-atlas-reliability-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"four-nines-boss-sim"}'::jsonb, '{"xp":780,"credits":185,"badgeIds":["four-nines"],"skillXp":{"cloud_devops_fundamentals":120}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-reliability-01', 1, 'leena', 'Chasing a new enterprise customer, leadership wants to commit to four nines -- 99.99% availability -- starting next quarter. Cross is being asked to confirm we can actually deliver it.'),
  ('mission-atlas-reliability-01', 2, 'cross', 'Imani Cross. SRE means treating reliability as an actual engineering property -- measured, budgeted, and improved on purpose -- not a mood, and not whatever number sounds most impressive in a meeting.'),

  ('mission-atlas-reliability-02', 1, 'cross', 'Before promising anything, confirm what we actually measure. A Service Level Indicator is one specific, quantitative signal -- not a vibe, a number.'),

  ('mission-atlas-reliability-03', 1, 'cross', 'An SLO is a target for that indicator, over a defined window. Confirm what this fleet has already committed to internally, before anyone talks about a new number.'),

  ('mission-atlas-reliability-04', 1, 'leena', 'An SLA is different -- it is what actually goes into a contract, usually looser than our own internal target, with real consequences attached if it is missed. Understand exactly what changes once a number leaves this room.'),

  ('mission-atlas-reliability-05', 1, 'cross', 'An SLO is meaningless without knowing exactly how much room to fail it actually allows. Confirm the real number.'),

  ('mission-atlas-reliability-06', 1, 'cross', 'Confirm exactly where we are actually tracking right now, against the target that already exists -- not the one someone is about to propose.'),

  ('mission-atlas-reliability-07', 1, 'cross', 'A request that succeeds but takes eight seconds did not actually work, not for whoever was waiting on it. Confirm that latency has its own real target too.'),

  ('mission-atlas-reliability-08', 1, 'cross', 'A single error-rate threshold either fires too late or too often. A burn-rate alert asks a sharper question instead -- at this rate, how soon would the entire budget actually be gone. Confirm how this one is tuned.'),

  ('mission-atlas-reliability-09', 1, 'rook', 'Toil is repetitive, manual, automatable work that produces no lasting value no matter how many times you do it by hand. SRE exists specifically to drive that toward zero, not to automate everything indiscriminately.'),

  ('mission-atlas-reliability-10', 1, 'rook', 'Confirm one specific piece of toil that genuinely does not happen by hand anymore -- proof this is not just a definition, it actually changed something.'),

  ('mission-atlas-reliability-11', 1, 'cross', 'An error budget settles an argument that used to just be politics -- ship faster, or protect reliability. As long as the budget is not spent, ship. The moment it is, reliability wins the argument automatically, with a number, not a vote.'),

  ('mission-atlas-reliability-12', 1, 'leena', 'Everything this World taught you, on one proposal. Not to just say yes because it sounds impressive -- to finally explain what a promise like this actually requires, honestly.'),
  ('mission-atlas-reliability-12', 2, 'byte', 'I have the proposal and this fleet''s real, measured incident history both pulled up together. Acts 9, 17, 18, 19, 20, 21 and 23 -- real hours, not minutes.'),
  ('mission-atlas-reliability-12', 3, 'cross', 'None of that makes four nines a bad thing to eventually want.'),
  ('mission-atlas-reliability-12', 4, 'rook', 'It just makes committing to it today, in writing, to a paying customer, a promise nobody here could actually keep yet. Find the real gap, and say so honestly.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-reliability-01-o1', 'mission-atlas-reliability-01', 1, 'Explain what SRE actually is', 'Choose the accurate description of what SRE actually treats reliability as.'),

  ('mission-atlas-reliability-02-o1', 'mission-atlas-reliability-02', 1, 'Read the SLI definition', 'Read the SLI definition and submit the verification code.'),

  ('mission-atlas-reliability-03-o1', 'mission-atlas-reliability-03', 1, 'Read the SLO definition', 'Read the SLO definition and submit the verification code.'),

  ('mission-atlas-reliability-04-o1', 'mission-atlas-reliability-04', 1, 'Explain SLAs', 'Choose the accurate description of what actually changes once a target becomes an SLA.'),

  ('mission-atlas-reliability-05-o1', 'mission-atlas-reliability-05', 1, 'Read the error budget', 'Read the error budget calculation and submit the verification code.'),

  ('mission-atlas-reliability-06-o1', 'mission-atlas-reliability-06', 1, 'Read current availability', 'Read the current availability report and submit the verification code.'),

  ('mission-atlas-reliability-07-o1', 'mission-atlas-reliability-07', 1, 'Read the latency SLO', 'Read the latency objective and submit the verification code.'),

  ('mission-atlas-reliability-08-o1', 'mission-atlas-reliability-08', 1, 'Read the burn-rate alert', 'Read the burn-rate alert and submit the verification code.'),

  ('mission-atlas-reliability-09-o1', 'mission-atlas-reliability-09', 1, 'Explain toil', 'Choose the accurate description of what toil actually is.'),

  ('mission-atlas-reliability-10-o1', 'mission-atlas-reliability-10', 1, 'Read the automation log', 'Read the automation log and submit the verification code.'),

  ('mission-atlas-reliability-11-o1', 'mission-atlas-reliability-11', 1, 'Explain velocity vs reliability', 'Choose the accurate description of what an error budget actually settles.'),

  ('mission-atlas-reliability-12-o1', 'mission-atlas-reliability-12', 1, 'Confirm the four-nines proposal', 'Read the proposal and submit the verification code.'),
  ('mission-atlas-reliability-12-o2', 'mission-atlas-reliability-12', 2, 'Confirm the real measured history', 'Read the historical availability report and submit the verification code.'),
  ('mission-atlas-reliability-12-o3', 'mission-atlas-reliability-12', 3, 'Identify what actually explains the gap', 'Find the evidence that explains why this commitment cannot honestly be made yet.'),
  ('mission-atlas-reliability-12-o4', 'mission-atlas-reliability-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what should actually be proposed instead.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-reliability-01-o1-c1', 'mission-atlas-reliability-01-o1', 1, 'multiple_choice', 'SRE actually treats reliability as...', '{"question":"SRE actually treats reliability as...","options":[{"id":"a","text":"An engineered, measurable property -- budgeted and improved on purpose, not a vague aspiration or whatever number sounds most impressive"},{"id":"b","text":"Something that cannot be measured, only felt"},{"id":"c","text":"A one-time achievement, done once and never revisited"},{"id":"d","text":"Purely a marketing decision with no engineering component"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-reliability-02-o1-c1', 'mission-atlas-reliability-02-o1', 1, 'terminal_simulation', 'Read the SLI definition and submit the verification code.', '{"instructions":"Read /repo/infra-envs/sre/sli-definitions.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/sre/sli-definitions.yaml":{"type":"file","content":"sli: request_success_rate\n  good_events: http_requests_total status not 500\n  total_events: http_requests_total\n# a specific, quantitative measure of one aspect of the service\n# verification SLI-3312\n"}}}'::jsonb, '{"requiredFlag":"SLI-3312"}'::jsonb),

  ('mission-atlas-reliability-03-o1-c1', 'mission-atlas-reliability-03-o1', 1, 'terminal_simulation', 'Read the SLO definition and submit the verification code.', '{"instructions":"Read /repo/infra-envs/sre/slo-collector.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/sre/slo-collector.yaml":{"type":"file","content":"slo: request_success_rate\n  target: 99.5%\n  window: 28d\n# a target for the SLI over a defined rolling window\n# verification SLO-6602\n"}}}'::jsonb, '{"requiredFlag":"SLO-6602"}'::jsonb),

  ('mission-atlas-reliability-04-o1-c1', 'mission-atlas-reliability-04-o1', 1, 'multiple_choice', 'An SLA actually differs from an internal SLO in that...', '{"question":"An SLA actually differs from an internal SLO in that...","options":[{"id":"a","text":"It is a contractual promise, usually looser than the internal target, with real consequences attached if it is missed"},{"id":"b","text":"They are functionally identical in every way"},{"id":"c","text":"An SLA is always stricter than any internal SLO"},{"id":"d","text":"An SLA requires no measurement at all"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-reliability-05-o1-c1', 'mission-atlas-reliability-05-o1', 1, 'terminal_simulation', 'Read the error budget calculation and submit the verification code.', '{"instructions":"Read /repo/infra-envs/sre/error-budget.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/sre/error-budget.txt":{"type":"file","content":"SLO: 99.5%\nerror budget: 100% - 99.5% = 0.5% of requests allowed to fail over the 28-day window\n0.5% over 28 days is roughly 3.4 hours of full downtime, or a proportional mix of partial degradation\n# verification BUDGET-4471\n"}}}'::jsonb, '{"requiredFlag":"BUDGET-4471"}'::jsonb),

  ('mission-atlas-reliability-06-o1-c1', 'mission-atlas-reliability-06-o1', 1, 'terminal_simulation', 'Read the current availability report and submit the verification code.', '{"instructions":"Read /var/atlas-sre-01/current-availability.txt and submit the verification code with: submit CODE","hostname":"atlas-sre-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-sre-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-sre-01/current-availability.txt":{"type":"file","content":"request_success_rate, trailing 28 days: 99.61%\nerror budget remaining: 22% of the 0.5% allowed\n# currently tracking within budget against the existing 99.5% SLO\n# verification AVAILABILITY-8802\n"}}}'::jsonb, '{"requiredFlag":"AVAILABILITY-8802"}'::jsonb),

  ('mission-atlas-reliability-07-o1-c1', 'mission-atlas-reliability-07-o1', 1, 'terminal_simulation', 'Read the latency objective and submit the verification code.', '{"instructions":"Read /repo/infra-envs/sre/latency-slo.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/sre/latency-slo.yaml":{"type":"file","content":"slo: request_latency_p99\n  target: under 300ms\n  window: 28d\n# reliability is not only about whether a request succeeds -- how long it takes matters too\n# verification LATENCY-2291\n"}}}'::jsonb, '{"requiredFlag":"LATENCY-2291"}'::jsonb),

  ('mission-atlas-reliability-08-o1-c1', 'mission-atlas-reliability-08-o1', 1, 'terminal_simulation', 'Read the burn-rate alert and submit the verification code.', '{"instructions":"Read /repo/infra-envs/sre/burn-rate-alert.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/sre/burn-rate-alert.yaml":{"type":"file","content":"alert: FastBudgetBurn\nexpr: error_budget_burn_rate above 14.4\nfor: 5m\n# a burn rate this high would exhaust the entire 28-day budget in about 2 days if it kept up\n# verification BURNRATE-9012\n"}}}'::jsonb, '{"requiredFlag":"BURNRATE-9012"}'::jsonb),

  ('mission-atlas-reliability-09-o1-c1', 'mission-atlas-reliability-09-o1', 1, 'multiple_choice', 'Toil is best described as...', '{"question":"Toil is best described as...","options":[{"id":"a","text":"Repetitive, manual, automatable operational work that produces no lasting value no matter how many times it is done by hand"},{"id":"b","text":"Any engineering work at all, regardless of whether it is repetitive"},{"id":"c","text":"Work that only exists in incident response, never elsewhere"},{"id":"d","text":"A synonym for an error budget"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-reliability-10-o1-c1', 'mission-atlas-reliability-10-o1', 1, 'terminal_simulation', 'Read the automation log and submit the verification code.', '{"instructions":"Read /repo/infra-envs/sre/automation-log.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/sre/automation-log.txt":{"type":"file","content":"runbook: restart stuck collector pod\nprevious: manual, 15 times last quarter\nnow: automated via Kubernetes liveness probe restart, zero manual interventions since\n# verification AUTOMATION-3390\n"}}}'::jsonb, '{"requiredFlag":"AUTOMATION-3390"}'::jsonb),

  ('mission-atlas-reliability-11-o1-c1', 'mission-atlas-reliability-11-o1', 1, 'multiple_choice', 'An error budget actually settles the argument between velocity and reliability by...', '{"question":"An error budget actually settles the argument between velocity and reliability by...","options":[{"id":"a","text":"Letting teams ship freely as long as the budget is not spent, and requiring reliability work to take priority automatically once it is -- decided by a number, not a vote"},{"id":"b","text":"Always favoring shipping features regardless of reliability"},{"id":"c","text":"Always favoring reliability work regardless of feature deadlines"},{"id":"d","text":"Removing the need for any SLO at all"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-reliability-12-o1-c1', 'mission-atlas-reliability-12-o1', 1, 'terminal_simulation', 'Read the proposal and submit the verification code.', '{"instructions":"Read /var/atlas-sre-01/four-nines-proposal.txt and submit the verification code with: submit CODE","hostname":"atlas-sre-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-sre-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-sre-01/four-nines-proposal.txt":{"type":"file","content":"proposal: commit to 99.99% (four nines) availability for atlas-collector, starting next quarter\nrequested by: Atlas Division leadership, in response to a new enterprise customer ask\nfour nines allows approximately 52 minutes of downtime per year\n# verification PROPOSAL-3312\n"}}}'::jsonb, '{"requiredFlag":"PROPOSAL-3312"}'::jsonb),
  ('mission-atlas-reliability-12-o2-c1', 'mission-atlas-reliability-12-o2', 1, 'terminal_simulation', 'Read the historical availability report and submit the verification code.', '{"instructions":"Read /var/atlas-sre-01/historical-availability.txt and submit the verification code with: submit CODE","hostname":"atlas-sre-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-sre-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-sre-01/historical-availability.txt":{"type":"file","content":"measured availability, last 90 days: 99.2%\nincidents included: Act 9 zombie fleet, Act 17 pod zero, Act 18 service unreachable, Act 19 vanishing disk, Act 20 crashloop city, Act 21 broken cluster, Act 23 invisible failure\ntotal downtime at 99.2% over one year: roughly 70 hours\n# verification HISTORY-6602\n"}}}'::jsonb, '{"requiredFlag":"HISTORY-6602"}'::jsonb),
  ('mission-atlas-reliability-12-o3-c1', 'mission-atlas-reliability-12-o3', 1, 'investigation', 'Which evidence explains why this commitment cannot honestly be made yet?', '{"evidence":[{"id":"e1","label":"Four-nines proposal","detail":"Leadership wants to commit to 99.99% availability starting next quarter"},{"id":"e2","label":"Historical availability report","detail":"Measured availability over the last 90 days is 99.2%, roughly 70 hours of downtime per year at that rate"},{"id":"e3","label":"What four nines actually requires","detail":"99.99% allows only about 52 minutes of downtime across an entire year"},{"id":"e4","label":"Toil and automation notes","detail":"Several pieces of manual toil have already been successfully automated this World"}],"question":"Which evidence explains why this commitment cannot honestly be made yet?"}'::jsonb, '{"requiredEvidenceIds":["e2","e3"]}'::jsonb),
  ('mission-atlas-reliability-12-o4-c1', 'mission-atlas-reliability-12-o4', 1, 'boss_encounter', 'Having confirmed the proposal, the real measured history, and what actually explains the gap, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-reliability-12-o1","label":"Confirm the four-nines proposal"},{"objectiveRef":"mission-atlas-reliability-12-o2","label":"Confirm the real measured history"},{"objectiveRef":"mission-atlas-reliability-12-o3","label":"Identify what actually explains the gap"}],"task":"State the diagnosis in one sentence: four nines allows roughly 52 minutes of downtime a year, and this fleet''s real, measured history sits at about 99.2% -- roughly 70 hours -- so committing to four nines today, in writing, to a paying customer, is a promise that cannot honestly be kept without an order of investment nobody has funded yet, and the right move is proposing a realistic, evidence-based SLO now with a genuine improvement path toward four nines later, not agreeing to a number because it sounds impressive."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-reliability-12-o1","mission-atlas-reliability-12-o2","mission-atlas-reliability-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-reliability-01-o1-c1', 'orientation', 'Think about a number versus a feeling.', 10, 1),
  ('mission-atlas-reliability-01-o1-c1', 'solution', 'SRE treats reliability as an engineered, measured, budgeted property.', 20, 2),

  ('mission-atlas-reliability-02-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/sre/sli-definitions.yaml', 10, 1),
  ('mission-atlas-reliability-02-o1-c1', 'solution', 'Success rate is a specific quantitative measure, verification SLI-3312. submit SLI-3312', 20, 2),

  ('mission-atlas-reliability-03-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/sre/slo-collector.yaml', 10, 1),
  ('mission-atlas-reliability-03-o1-c1', 'solution', '99.5% over 28 days, verification SLO-6602. submit SLO-6602', 20, 2),

  ('mission-atlas-reliability-04-o1-c1', 'orientation', 'Think about a contract versus an internal target.', 10, 1),
  ('mission-atlas-reliability-04-o1-c1', 'solution', 'An SLA is contractual, usually looser, with real consequences if missed.', 20, 2),

  ('mission-atlas-reliability-05-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/sre/error-budget.txt', 10, 1),
  ('mission-atlas-reliability-05-o1-c1', 'solution', '0.5% is roughly 3.4 hours over 28 days, verification BUDGET-4471. submit BUDGET-4471', 20, 2),

  ('mission-atlas-reliability-06-o1-c1', 'orientation', 'Try: cat /var/atlas-sre-01/current-availability.txt', 10, 1),
  ('mission-atlas-reliability-06-o1-c1', 'solution', '99.61%, within budget, verification AVAILABILITY-8802. submit AVAILABILITY-8802', 20, 2),

  ('mission-atlas-reliability-07-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/sre/latency-slo.yaml', 10, 1),
  ('mission-atlas-reliability-07-o1-c1', 'solution', 'p99 under 300ms, verification LATENCY-2291. submit LATENCY-2291', 20, 2),

  ('mission-atlas-reliability-08-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/sre/burn-rate-alert.yaml', 10, 1),
  ('mission-atlas-reliability-08-o1-c1', 'solution', 'Above 14.4x burns the budget in about 2 days, verification BURNRATE-9012. submit BURNRATE-9012', 20, 2),

  ('mission-atlas-reliability-09-o1-c1', 'orientation', 'Think about repetition and lasting value.', 10, 1),
  ('mission-atlas-reliability-09-o1-c1', 'solution', 'Toil is repetitive, manual, automatable work with no lasting value.', 20, 2),

  ('mission-atlas-reliability-10-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/sre/automation-log.txt', 10, 1),
  ('mission-atlas-reliability-10-o1-c1', 'solution', 'Pod restarts are now automated, verification AUTOMATION-3390. submit AUTOMATION-3390', 20, 2),

  ('mission-atlas-reliability-11-o1-c1', 'orientation', 'Think about what happens once the budget is exhausted, versus while it is not.', 10, 1),
  ('mission-atlas-reliability-11-o1-c1', 'solution', 'Ship freely until the budget is spent, then reliability wins automatically.', 20, 2),

  ('mission-atlas-reliability-12-o1-c1', 'orientation', 'Try: cat /var/atlas-sre-01/four-nines-proposal.txt', 10, 1),
  ('mission-atlas-reliability-12-o1-c1', 'solution', 'Four nines allows about 52 minutes a year, verification PROPOSAL-3312. submit PROPOSAL-3312', 20, 2),
  ('mission-atlas-reliability-12-o2-c1', 'orientation', 'Try: cat /var/atlas-sre-01/historical-availability.txt', 10, 1),
  ('mission-atlas-reliability-12-o2-c1', 'solution', '99.2%, roughly 70 hours a year, verification HISTORY-6602. submit HISTORY-6602', 20, 2),
  ('mission-atlas-reliability-12-o3-c1', 'orientation', 'The proposal itself and the automation wins are both real but do not explain the gap. Compare the measured history against what the target actually requires.', 10, 1),
  ('mission-atlas-reliability-12-o3-c1', 'solution', 'e2 and e3: 70 real hours of downtime a year versus the 52 minutes four nines actually allows.', 20, 2),
  ('mission-atlas-reliability-12-o4-c1', 'orientation', 'Combine the target, the real history, and what to propose instead into one sentence.', 15, 1),
  ('mission-atlas-reliability-12-o4-c1', 'solution', 'Four nines allows 52 minutes a year against a real history of about 70 hours -- propose an honest, evidence-based SLO now with a real path toward four nines later, not a number that sounds impressive.', 25, 2);
