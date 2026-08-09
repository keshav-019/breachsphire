-- world-42 ("Threat Hunting: Hunt Without an Alert") mission content,
-- generated from docs/12-world-story-bible.md. Closes Act 6 "The Hunt" --
-- Luna hands the player a hypothesis instead of an alert, and the resulting
-- hunt finds a dormant Sentinel-X foothold at another organization that has
-- never tripped a signature. The capstone ends on a live cliffhanger: the
-- foothold activates and starts a destructive incident, handing off directly
-- into world-43 (Incident Response: Containment), authored separately.
-- Mission 1 is cross-world-gated on world-41's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-42a', 'world-42', 'hunt-without-an-alert', '42A - Hunt Without an Alert', 'Hypothesis-driven hunting, baselining, rare-process analysis and ATT&CK-based hunt plans, learned through one open investigation with no alert to start from.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-42a-1', 'campaign-42a', 'foundations', 'Foundations', 'Hypothesis-driven hunting, baselining and rare-process analysis, learned as the discipline of looking before anything trips a wire.', 1),
  ('operation-42a-2', 'campaign-42a', 'the-hunt', 'The Hunt', 'One open investigation, one hypothesis, and a foothold that has never triggered a single signature.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w42-01', 'world-42', 'campaign-42a', 'operation-42a-1', 'a-hypothesis-not-an-alert', 'A Hypothesis, Not an Alert', 'Luna doesn''t hand over an alert this time. She hands over a hypothesis: Sentinel-X has already pre-positioned access in another organization.', 'intro', ARRAY['luna', 'zayn', 'byte'], '{"requiredMissionIds":["mission-w41-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w42-02', 'world-42', 'campaign-42a', 'operation-42a-1', 'what-normal-actually-looks-like', 'What Normal Actually Looks Like', 'Baselining sounds simple: know what normal looks like, so anything else stands out. Actually doing it takes months of patient counting.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w42-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"baseline-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w42-03', 'world-42', 'campaign-42a', 'operation-42a-1', 'building-the-hunt-plan', 'Building the Hunt Plan', 'A hunt isn''t "look around and see what feels weird." A real hunt plan starts with a hypothesis you can actually prove or disprove.', 'beginner', ARRAY['zayn', 'luna'], '{"requiredMissionIds":["mission-w42-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"hunt-plan-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w42-04', 'world-42', 'campaign-42a', 'operation-42a-2', 'a-name-that-resolves-to-nothing-useful', 'A Name That Resolves to Nothing Useful', 'Most DNS traffic is boring on purpose. The interesting part is whatever refuses to be boring.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w42-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"dns-anomaly-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w42-05', 'world-42', 'campaign-42a', 'operation-42a-2', 'a-login-from-nowhere', 'A Login From Nowhere', 'Eleven months of history, and this account has never once logged in interactively. Today it did.', 'advanced', ARRAY['byte', 'zayn'], '{"requiredMissionIds":["mission-w42-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"auth-anomaly-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w42-06', 'world-42', 'campaign-42a', 'operation-42a-2', 'sleeper-boss', 'Sleeper', 'Find a dormant foothold that has not triggered any signature.', 'boss', ARRAY['luna', 'byte', 'zayn'], '{"requiredMissionIds":["mission-w42-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"sleeper-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["sleeper"],"skillXp":{"threat_hunting":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w42-01', 1, 'luna', 'No alert today. Just a hypothesis: Sentinel-X has already pre-positioned access in another organization, sitting there, doing nothing, waiting.'),
  ('mission-w42-01', 2, 'zayn', 'Waiting for what?'),
  ('mission-w42-01', 3, 'luna', 'That''s what we''re here to find out. Nothing has fired. Nothing will fire, if it''s good at its job.'),
  ('mission-w42-01', 4, 'byte', 'Which means we can''t start from a queue this time. We have to start from a question, and go looking for the answer ourselves.'),
  ('mission-w42-01', 5, 'luna', 'Welcome to hunting. Nobody''s going to tell you where to look.'),
  ('mission-w42-02', 1, 'byte', 'Baselining sounds simple: know what normal looks like, so anything else stands out. Actually doing it means months of patient counting.'),
  ('mission-w42-02', 2, 'byte', 'Four thousand eight hundred hosts. I know what runs on almost all of them, almost all the time. That "almost" is where hunting happens.'),
  ('mission-w42-03', 1, 'zayn', 'A hunt isn''t "look around and see what feels weird." That''s how you miss things and burn out in a week.'),
  ('mission-w42-03', 2, 'luna', 'A real hunt plan starts with a hypothesis you can actually prove or disprove, and only then decides what to go looking for.'),
  ('mission-w42-04', 1, 'zayn', 'Most DNS traffic is boring on purpose. The interesting part is whatever refuses to be boring.'),
  ('mission-w42-04', 2, 'zayn', 'A domain that never resolves the same way twice, queried by exactly one host, on a timer nobody set -- that''s not boring.'),
  ('mission-w42-05', 1, 'byte', 'Eleven months of history, and this account has never once logged in interactively. Today it did.'),
  ('mission-w42-05', 2, 'zayn', 'One login isn''t proof of anything by itself. It''s a thread. Pull it.'),
  ('mission-w42-06', 1, 'luna', 'You''ve got fragments: a process that never runs, an account that woke up once, a DNS lookup that led nowhere. Put them together.'),
  ('mission-w42-06', 2, 'byte', 'None of it ever crossed a threshold. Nothing here would have ever fired a rule.'),
  ('mission-w42-06', 3, 'zayn', 'That''s what a sleeper looks like when it''s good. It doesn''t hide from detection. It just never gives detection a reason to look.'),
  ('mission-w42-06', 4, 'luna', 'Find the host. Prove it''s real. Then explain why six months of monitoring never once caught it.'),
  ('mission-w42-06', 5, 'byte', '...Confirmed. FOUNDRY-APP03. One scheduled task, one dormant account, one DNS lookup that never got a second try -- everything staged, nothing repeated.'),
  ('mission-w42-06', 6, 'luna', 'A foothold that did everything exactly once could sit there for years.'),
  ('mission-w42-06', 7, 'zayn', 'Could have. Past tense might not fit anymore --'),
  ('mission-w42-06', 8, 'byte', '...The task just executed. Right now. First time in four months.'),
  ('mission-w42-06', 9, 'luna', 'That''s not a hunt anymore.'),
  ('mission-w42-06', 10, 'byte', 'File encryption processes spinning up across FOUNDRY-APP03 and two adjacent hosts. This is live.'),
  ('mission-w42-06', 11, 'zayn', 'The foothold activated and went straight for something destructive.'),
  ('mission-w42-06', 12, 'luna', 'Everyone, this is now an active incident. Containment starts now.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w42-01-o1', 'mission-w42-01', 1, 'Accept the hunting hypothesis', 'Confirm you''re ready to hunt from a hypothesis instead of an alert.'),
  ('mission-w42-02-o1', 'mission-w42-02', 1, 'Recognize what a baseline would actually flag', 'Determine which observation deviates enough from baseline to be worth a closer look.'),
  ('mission-w42-03-o1', 'mission-w42-03', 1, 'Order the hunt plan', 'Put the steps of a real hunt plan in the correct order.'),
  ('mission-w42-04-o1', 'mission-w42-04', 1, 'Spot the DNS anomaly', 'Determine which DNS pattern is worth pulling a thread on.'),
  ('mission-w42-05-o1', 'mission-w42-05', 1, 'Identify the authentication anomaly', 'Determine which login is the anomaly worth pursuing.'),
  ('mission-w42-05-o2', 'mission-w42-05', 2, 'Decide the next hunting move', 'Choose the correct next step once the anomaly is confirmed.'),
  ('mission-w42-06-o1', 'mission-w42-06', 1, 'Locate the dormant foothold', 'Determine which host is actually holding a dormant foothold.'),
  ('mission-w42-06-o2', 'mission-w42-06', 2, 'Explain why it was never caught', 'State why this foothold never triggered a single signature.'),
  ('mission-w42-06-o3', 'mission-w42-06', 3, 'Close the hunt', 'Confirm the foothold and the explanation together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w42-01-o1-c1', 'mission-w42-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to hunt.', '{"lines":[{"characterId":"luna","text":"No alert, just a hypothesis. Ready to go looking?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w42-02-o1-c1', 'mission-w42-02-o1', 1, 'investigation', 'Which of these would a baseline actually flag as worth a closer look?', '{"evidence":[{"id":"b1","label":"svchost.exe","detail":"Runs on 4,800 of 4,800 hosts -- completely ordinary Windows process"},{"id":"b2","label":"rundll32.exe with an unusual argument","detail":"Runs on 1 of 4,800 hosts, calling a DLL export that appears nowhere else in six months of history"},{"id":"b3","label":"chrome.exe","detail":"Runs on 4,650 of 4,800 hosts -- extremely common browser process"}],"question":"Which of these would a baseline actually flag as worth a closer look?"}'::jsonb, '{"requiredEvidenceIds":["b2"]}'::jsonb),

  ('mission-w42-03-o1-c1', 'mission-w42-03-o1', 1, 'interactive_diagram', 'Put the steps of a real hunt plan in the correct order.', '{"hotspots":[{"id":"hypothesis","label":"Form a specific, testable hypothesis","explanation":"The starting point -- something you can actually prove or disprove, not a vague feeling."},{"id":"technique_source","label":"Pick the ATT&CK technique and data sources that would prove or disprove it","explanation":"Decide what evidence would actually settle the question."},{"id":"baseline","label":"Establish the baseline for that data source across the environment","explanation":"You can''t spot an outlier without knowing what normal looks like first."},{"id":"deviation","label":"Pull everything that deviates from baseline","explanation":"Surface the candidates that don''t match the established norm."},{"id":"triage","label":"Triage the deviations by hand, one at a time","explanation":"Every outlier still needs a human decision before it means anything."}],"task":"Put the steps of a real hunt plan in the correct order."}'::jsonb, '{"correctOrderIds":["hypothesis","technique_source","baseline","deviation","triage"]}'::jsonb),

  ('mission-w42-04-o1-c1', 'mission-w42-04-o1', 1, 'investigation', 'Which DNS pattern is worth pulling a thread on?', '{"evidence":[{"id":"d1","label":"DNS query pattern A","detail":"Query to update-service.microsoft.com, resolved normally, queried by 1,200 hosts"},{"id":"d2","label":"DNS query pattern B","detail":"Query to a 32-character random-looking subdomain of a rarely-used TLD, made once every ten minutes by exactly one host, resolving to a different IP almost every time"},{"id":"d3","label":"DNS query pattern C","detail":"Query to an internal file server, resolved via internal DNS, queried by finance team hosts during business hours"}],"question":"Which DNS pattern is worth pulling a thread on?"}'::jsonb, '{"requiredEvidenceIds":["d2"]}'::jsonb),

  ('mission-w42-05-o1-c1', 'mission-w42-05-o1', 1, 'investigation', 'Which login is the anomaly worth pursuing?', '{"evidence":[{"id":"a1","label":"Login A","detail":"Interactive login using a service account that has never authenticated interactively in eleven months of history, from a host it has never touched, at 02:14 local time"},{"id":"a2","label":"Login B","detail":"Standard interactive login by a human user from their assigned workstation during business hours"}],"question":"Which login is the anomaly worth pursuing?"}'::jsonb, '{"requiredEvidenceIds":["a1"]}'::jsonb),

  ('mission-w42-05-o2-c1', 'mission-w42-05-o2', 1, 'multiple_choice', 'You''ve confirmed the anomaly. What''s the right next hunting move?', '{"question":"You''ve confirmed the anomaly. What''s the right next hunting move?","options":[{"id":"a","text":"Close the investigation -- one odd login isn''t enough"},{"id":"b","text":"Pivot from that account: pull everything else it touched around that timestamp, across every host and log source available"},{"id":"c","text":"Immediately disable the account with no further investigation"},{"id":"d","text":"Wait for a SIEM alert to confirm it independently"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w42-06-o1-c1', 'mission-w42-06-o1', 1, 'log_analysis', 'Across everything you''ve gathered, which host is actually holding a dormant foothold?', '{"logLines":[{"id":"g1","source":"Process","text":"A signed, legitimate-looking scheduled task binary on FOUNDRY-APP03 has not executed in four months, despite being registered to run weekly"},{"id":"g2","source":"Identity","text":"A service account tied to that scheduled task authenticated successfully once, four months ago, and has been completely silent since -- no failures, no further use, no alerts"},{"id":"g3","source":"DNS","text":"A single DNS lookup for a domain that has never resolved to anything, made once, four months ago, from FOUNDRY-APP03, never repeated"},{"id":"g4","source":"Baseline","text":"FOUNDRY-APP03 otherwise behaves identically to forty other application servers in its group"}],"question":"Across everything you''ve gathered, which host is actually holding a dormant foothold?"}'::jsonb, '{"requiredLogLineIds":["g1","g2","g3"]}'::jsonb),

  ('mission-w42-06-o2-c1', 'mission-w42-06-o2', 1, 'multiple_choice', 'Why has this never triggered a single signature?', '{"question":"Why has this never triggered a single signature?","options":[{"id":"a","text":"Because it''s not actually there"},{"id":"b","text":"Because it did everything exactly once, months ago, and has been indistinguishable from silence ever since -- there was never a repeating pattern for a signature to match"},{"id":"c","text":"Because the SIEM is broken"},{"id":"d","text":"Because it uses a valid, signed binary, which is the only reason"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w42-06-o3-c1', 'mission-w42-06-o3', 1, 'boss_encounter', 'Confirm the foothold and the explanation together.', '{"stages":[{"objectiveRef":"mission-w42-06-o1","label":"The dormant foothold"},{"objectiveRef":"mission-w42-06-o2","label":"Why it was never caught"}],"task":"Confirm the foothold and the explanation together."}'::jsonb, '{"requiredObjectiveIds":["mission-w42-06-o1","mission-w42-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w42-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w42-02-o1-c1', 'orientation', 'Ask how many hosts run each of these, and how often.', 15, 1),
  ('mission-w42-02-o1-c1', 'concept', 'A baseline flags rarity combined with novelty -- something almost nobody does, doing something nobody else has ever done.', 25, 2),
  ('mission-w42-02-o1-c1', 'solution', 'b2 is the anomaly: a single host, with an argument pattern seen nowhere else in six months. b1 and b3 are both extremely common, ordinary processes.', 35, 3),

  ('mission-w42-03-o1-c1', 'orientation', 'Start from the question you''re trying to answer, not from the data itself.', 15, 1),
  ('mission-w42-03-o1-c1', 'concept', 'You need to know what "normal" looks like before you can find what deviates from it, and every deviation still needs a human look before it means anything.', 25, 2),
  ('mission-w42-03-o1-c1', 'solution', 'Hypothesis, then technique and data source, then baseline, then deviation, then manual triage -- in that order.', 35, 3),

  ('mission-w42-04-o1-c1', 'orientation', 'Two of these three patterns have an ordinary explanation you could name in one sentence.', 15, 1),
  ('mission-w42-04-o1-c1', 'concept', 'A domain that never resolves the same way twice, queried on a fixed interval by exactly one host, doesn''t look like anything a normal application does.', 25, 2),
  ('mission-w42-04-o1-c1', 'solution', 'd2''s randomized subdomain, single-host querier and shifting resolution is the pattern worth pulling a thread on -- d1 and d3 are both ordinary, explainable traffic.', 35, 3),

  ('mission-w42-05-o1-c1', 'orientation', 'One of these two logins breaks an eleven-month pattern. The other is exactly what you''d expect.', 15, 1),
  ('mission-w42-05-o1-c1', 'solution', 'a1 is the anomaly: a service account authenticating interactively for the first time ever, from a new host, at an unusual hour.', 25, 2),

  ('mission-w42-05-o2-c1', 'orientation', 'Think about what one login actually proves, and what it doesn''t.', 15, 1),
  ('mission-w42-05-o2-c1', 'solution', 'A single anomaly is a thread, not a conclusion -- pivot from the account to see everything else it touched around that timestamp. Option b.', 25, 2),

  ('mission-w42-06-o1-c1', 'orientation', 'Three of these four observations point at the same host. One is there to reassure you nothing''s wrong.', 15, 1),
  ('mission-w42-06-o1-c1', 'concept', 'A dormant scheduled task, a service account used exactly once, and a DNS lookup that never repeated are all pointing at the same machine.', 25, 2),
  ('mission-w42-06-o1-c1', 'tool_direction', 'Check which host each piece of evidence actually names.', 35, 3),
  ('mission-w42-06-o1-c1', 'near_solution', 'g1, g2 and g3 all name FOUNDRY-APP03. g4 is the baseline comparison saying the host looks normal on the surface -- which is exactly the problem.', 45, 4),
  ('mission-w42-06-o1-c1', 'solution', 'FOUNDRY-APP03 is the dormant foothold -- the scheduled task (g1), the once-used service account (g2), and the single unrepeated DNS lookup (g3) all point to the same host, despite it otherwise blending in with forty peers (g4).', 55, 5),

  ('mission-w42-06-o2-c1', 'orientation', 'Ask what a signature actually needs in order to match something.', 15, 1),
  ('mission-w42-06-o2-c1', 'solution', 'A signature needs a repeating pattern to match against. Something that happened exactly once, months ago, and then went silent never gave one -- that''s option b.', 25, 2),

  ('mission-w42-06-o3-c1', 'orientation', 'You''ve already found the host and the reason -- bring both together.', 20, 1),
  ('mission-w42-06-o3-c1', 'concept', 'Closing this out means naming the specific host and explaining, in plain terms, why six months of monitoring missed it.', 30, 2),
  ('mission-w42-06-o3-c1', 'tool_direction', 'Name the host and its evidence first, then the one-time-only nature of its activity.', 40, 3),
  ('mission-w42-06-o3-c1', 'near_solution', 'FOUNDRY-APP03, holding a foothold built from a task, an account and a DNS lookup that each fired exactly once -- nothing repeating for a signature to catch.', 50, 4),
  ('mission-w42-06-o3-c1', 'solution', 'The dormant foothold is on FOUNDRY-APP03: a scheduled task, a service account, and a DNS lookup that each activated exactly once, four months ago, then went completely silent. It was never caught because a signature needs a repeating pattern, and this foothold never gave it one -- it did everything once and waited.', 65, 5);
