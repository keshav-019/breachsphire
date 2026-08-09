-- world-59 ("Exploit Mitigations: The Mitigation Wall") mission content,
-- generated from docs/12-world-story-bible.md. Continues Act 8 "Zero Day".
-- Mission 1 is cross-world-gated on world-58's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-59a', 'world-59', 'mitigation-wall', '59A - The Mitigation Wall', 'The same bug, safe on one build and dangerous on another. The difference is entirely in what protections were compiled in.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-59a-1', 'campaign-59a', 'foundations', 'Foundations', 'DEP/NX, ASLR, canaries, PIE, RELRO and CFG, learned first as defenses, then as constraints.', 1),
  ('operation-59a-2', 'campaign-59a', 'investigation', 'Investigation', 'Explain why the same bug carries different risk across builds, and recommend the correct hardening controls.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w59-01', 'world-59', 'campaign-59a', 'operation-59a-1', 'safe-here-dangerous-there', 'Safe Here, Dangerous There', 'The parser bug crashes safely on one build and becomes genuinely dangerous on another. The bug didn''t change. The build did.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w58-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w59-02', 'world-59', 'campaign-59a', 'operation-59a-1', 'walls-built-into-the-build', 'Walls Built Into the Build', 'DEP/NX stops execution from data regions. ASLR moves everything around so addresses can''t be guessed. Neither fixes the bug -- both make it harder to abuse.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w59-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"mitigation-concepts-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w59-03', 'world-59', 'campaign-59a', 'operation-59a-1', 'a-tripwire-before-the-return-address', 'A Tripwire Before the Return Address', 'A stack canary sits between local buffers and the return address. Overwrite it, and the program notices before it ever tries to jump anywhere.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w59-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"stack-canary-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w59-04', 'world-59', 'campaign-59a', 'operation-59a-2', 'reading-a-binarys-security-properties', 'Reading a Binary''s Security Properties', 'A single report shows exactly which protections a given binary was actually compiled with -- PIE, RELRO, canaries, NX, all at once.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w59-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"binary-hardening-report-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w59-05', 'world-59', 'campaign-59a', 'operation-59a-2', 'a-call-that-cant-go-anywhere-else', 'A Call That Can''t Go Anywhere Else', 'Control-flow integrity restricts every indirect call to a small set of legitimate targets, no matter what an attacker manages to overwrite.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w59-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"cfi-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w59-06', 'world-59', 'campaign-59a', 'operation-59a-2', 'mitigation-wall-boss', 'The Mitigation Wall', 'Explain exactly why the same parser bug carries different risk on two different builds, and recommend the hardening controls the weaker build is missing.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w59-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"mitigation-wall-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["mitigation-wall"],"skillXp":{"programming":50}}'::jsonb, true, 6);

