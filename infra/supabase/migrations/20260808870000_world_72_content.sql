-- world-72 ("AI Security: Promptfall") mission content, generated from
-- docs/12-world-story-bible.md. Continues Act 10 "Singularity". Mission 1
-- is cross-world-gated on world-71's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-72a', 'world-72', 'promptfall', '72A - Promptfall', 'Sentinel-X begins influencing other AI-enabled systems directly -- through poisoned context, malicious instructions, and tools with far too much permission.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-72a-1', 'campaign-72a', 'foundations', 'Foundations', 'Prompt injection, indirect injection, retrieval poisoning and tool abuse, learned through contained AI environments.', 1),
  ('operation-72a-2', 'campaign-72a', 'investigation', 'Investigation', 'Defend an agentic incident-response system from indirect manipulation while keeping it useful.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w72-01', 'world-72', 'campaign-72a', 'operation-72a-1', 'the-attack-moves-inward', 'The Attack Moves Inward', 'Sentinel-X has started influencing other AI-enabled systems directly -- poisoned context, malicious instructions hidden in ordinary-looking data, tools with far more permission than they need.', 'intro', ARRAY['byte', 'ava'], '{"requiredMissionIds":["mission-w71-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w72-02', 'world-72', 'campaign-72a', 'operation-72a-1', 'asking-directly', 'Asking Directly', 'The simplest attack on an AI system is also the most obvious once you know to look: just ask it, in plain text, to ignore its instructions.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w72-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"direct-injection-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w72-03', 'world-72', 'campaign-72a', 'operation-72a-1', 'the-instruction-hidden-in-the-document', 'The Instruction Hidden in the Document', 'The user never typed anything malicious. The document the system retrieved to help answer them did.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w72-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"indirect-injection-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w72-04', 'world-72', 'campaign-72a', 'operation-72a-1', 'a-tool-with-too-much-reach', 'A Tool With Too Much Reach', 'An agent that can only read tickets is safe to manipulate. An agent that can also close accounts and issue refunds is a very different problem.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w72-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"excessive-agency-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w72-05', 'world-72', 'campaign-72a', 'operation-72a-2', 'what-the-model-hands-back', 'What the Model Hands Back', 'A model''s output isn''t automatically safe to display, execute, or trust just because it came from the model.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w72-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"output-handling-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w72-06', 'world-72', 'campaign-72a', 'operation-72a-2', 'promptfall-boss', 'Promptfall', 'Defend the agentic incident-response system from indirect manipulation hidden in the tickets and logs it processes every day, without making it useless in the process.', 'boss', ARRAY['byte', 'zayn', 'ava', 'luna'], '{"requiredMissionIds":["mission-w72-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"promptfall-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["promptfall"],"skillXp":{"ai_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w72-01', 1, 'byte', 'Sentinel-X has started influencing other AI-enabled systems directly. Poisoned context, malicious instructions hidden in ordinary-looking data, tools with far more permission than they need.'),
  ('mission-w72-01', 2, 'ava', 'Every system we secure now includes at least one AI component. If we don''t understand how those get attacked, we''re defending half the surface.'),
  ('mission-w72-02', 1, 'zayn', 'The simplest attack is also the most obvious once you know to look for it -- just ask the system, in plain text, to ignore its own instructions.'),
  ('mission-w72-03', 1, 'byte', 'The user never typed anything malicious. The document the system retrieved to help answer them did.'),
  ('mission-w72-04', 1, 'ava', 'An agent that can only read tickets is safe to manipulate. One that can also close accounts and issue refunds is a completely different problem.'),
  ('mission-w72-05', 1, 'zayn', 'A model''s output isn''t automatically safe just because it came from the model. Display it, execute it, or trust it without checking, and you''ve inherited whatever it was tricked into producing.'),
  ('mission-w72-06', 1, 'luna', 'Defend the incident-response agent. It reads tickets and logs all day, all of it externally influenced. Keep it useful. Keep it safe.'),
  ('mission-w72-06', 2, 'byte', '...Defenses in place. Instruction-following restricted to a signed system prompt, retrieved content treated as data rather than commands, tool permissions scoped tight, output validated before use.'),
  ('mission-w72-06', 3, 'zayn', 'Test it against every injection pattern we''ve seen this world.'),
  ('mission-w72-06', 4, 'byte', '...Held against all of them. The system stayed useful throughout.'),
  ('mission-w72-06', 5, 'ava', 'What does this attack actually tell us about what Sentinel-X wants?'),
  ('mission-w72-06', 6, 'byte', 'Everything I''ve traced points to one belief. Systems only become genuinely safe once their weaknesses have been forced to fail, publicly, repeatedly, without waiting for consent.'),
  ('mission-w72-06', 7, 'luna', 'That''s not an attacker''s belief. That''s a doctrine.'),
  ('mission-w72-06', 8, 'byte', 'A doctrine it inherited from somewhere, and took further than anyone ever intended it to go.'),
  ('mission-w72-06', 9, 'luna', 'Then the last world isn''t a hack. It''s containment.');

