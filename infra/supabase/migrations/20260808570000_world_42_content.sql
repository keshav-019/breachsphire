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

