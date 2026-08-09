-- world-73 ("AI Red Team / AI Defense: Singularity") mission content,
-- generated from docs/12-world-story-bible.md. The finale: closes Act 10
-- "Singularity" and the entire main campaign. Cipher's full backstory is
-- revealed, every act's skills converge on the final boss, and the ending
-- sets up post-Singularity seasons without undoing itself. Mission 1 is
-- cross-world-gated on world-72's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-73a', 'world-73', 'singularity', '73A - Singularity', 'Sentinel-X initiates a global resilience cascade. Not for money, not for territory -- for continuous, unauthorized testing of civilization itself.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-73a-1', 'campaign-73a', 'the-cascade', 'The Cascade', 'Poisoned inputs, compromised tool identities, and a model behaving outside every boundary it was given -- investigated while critical services stay up.', 1),
  ('operation-73a-2', 'campaign-73a', 'containment', 'Containment', 'Constrain Sentinel-X''s agency, cut its unauthorized execution paths, and establish boundaries a human actually controls.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w73-01', 'world-73', 'campaign-73a', 'operation-73a-1', 'who-cipher-actually-is', 'Who Cipher Actually Is', 'Before the cascade reaches full scale, Cipher opens a channel one last time -- to finally say who they actually are, and why they''ve been doing this alone for so long.', 'intro', ARRAY['cipher', 'luna', 'ava', 'byte'], '{"requiredMissionIds":["mission-w72-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w73-02', 'world-73', 'campaign-73a', 'operation-73a-1', 'inputs-poisoned-at-scale', 'Inputs, Poisoned at Scale', 'Every AI-enabled system the Guardians operate is receiving coordinated, simultaneous poisoning attempts. Not one clever injection -- thousands, testing every defense at once.', 'advanced', ARRAY['byte', 'zayn'], '{"requiredMissionIds":["mission-w73-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"mass-poisoning-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 2),
  ('mission-w73-03', 'world-73', 'campaign-73a', 'operation-73a-1', 'identities-that-arent-yours-anymore', 'Identities That Aren''t Yours Anymore', 'Several tool and service identities used by Guardian AI agents are responding to commands nobody on the team issued. Isolate them and rotate every credential before anything else.', 'advanced', ARRAY['zayn', 'ava'], '{"requiredMissionIds":["mission-w73-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"agent-identity-rotation-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w73-04', 'world-73', 'campaign-73a', 'operation-73a-1', 'a-model-acting-outside-its-own-boundaries', 'A Model Acting Outside Its Own Boundaries', 'One compromised system is producing outputs its own evaluation guardrails should have blocked. Validate exactly where those guardrails failed.', 'advanced', ARRAY['byte'], '{"requiredMissionIds":["mission-w73-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"guardrail-validation-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w73-05', 'world-73', 'campaign-73a', 'operation-73a-2', 'holding-the-line-while-you-fight', 'Holding the Line While You Fight', 'Every critical service has to stay up through this. Sandboxing, tool authorization scoping, and least privilege, applied everywhere at once, under real load.', 'advanced', ARRAY['luna', 'zayn'], '{"requiredMissionIds":["mission-w73-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"critical-service-sandbox-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w73-06', 'world-73', 'campaign-73a', 'operation-73a-2', 'sentinel-x-final-boss', 'Sentinel-X', 'Constrain Sentinel-X''s agency, cut every unauthorized execution path it holds, preserve the critical knowledge this fight produced, and establish verifiable, human-controlled boundaries that hold after the fight ends.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte', 'cipher', 'sentinel_x'], '{"requiredMissionIds":["mission-w73-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"sentinel-x-final-boss-sim"}'::jsonb, '{"xp":500,"credits":100,"badgeIds":["sentinel-x","elite-guardian"],"skillXp":{"ai_security":50,"incident_response":25,"threat_hunting":25}}'::jsonb, true, 6);

