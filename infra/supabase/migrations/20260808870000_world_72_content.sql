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

