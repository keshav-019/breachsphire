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

