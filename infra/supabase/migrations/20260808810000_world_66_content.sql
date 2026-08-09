-- world-66 ("Governance: The Boardroom") mission content, generated from
-- docs/12-world-story-bible.md. Continues Act 9 "Command". Mission 1 is
-- cross-world-gated on world-65's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-66a', 'world-66', 'the-boardroom', '66A - The Boardroom', 'A board-level simulation, where every leader in the room has conflicting incentives, legal duties, and operational constraints of their own.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-66a-1', 'campaign-66a', 'foundations', 'Foundations', 'Policies, standards, accountability and frameworks, learned as decision systems, not paperwork.', 1),
  ('operation-66a-2', 'campaign-66a', 'investigation', 'Investigation', 'Obtain approval for a defensible security strategy while explaining risk in business language.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w66-01', 'world-66', 'campaign-66a', 'operation-66a-1', 'a-room-full-of-different-priorities', 'A Room Full of Different Priorities', 'The board isn''t hostile to security. Each person in this room simply has a different, legitimate priority pulling against every other one.', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w65-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w66-02', 'world-66', 'campaign-66a', 'operation-66a-1', 'not-the-same-document', 'Not the Same Document', 'A policy states intent. A standard sets a specific bar. A procedure spells out the exact steps. Confusing these three is how governance quietly stops working.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w66-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"policy-standard-procedure-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w66-03', 'world-66', 'campaign-66a', 'operation-66a-1', 'who-actually-signs-off', 'Who Actually Signs Off', 'For any given security decision, exactly one role should be accountable. Not the people who did the work -- the person who owns the outcome.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w66-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"accountability-mapping-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w66-04', 'world-66', 'campaign-66a', 'operation-66a-1', 'frameworks-that-say-the-same-thing-differently', 'Frameworks That Say the Same Thing Differently', 'Two different security frameworks, describing largely the same underlying controls in different language and different structure.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w66-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"framework-alignment-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w66-05', 'world-66', 'campaign-66a', 'operation-66a-2', 'finding-the-position-everyone-can-live-with', 'Finding the Position Everyone Can Live With', 'Legal wants zero exposure. Engineering wants shipping speed. Finance wants a number, not a feeling. Build a strategy all three can actually stand behind.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w66-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"board-dialogue-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w66-06', 'world-66', 'campaign-66a', 'operation-66a-2', 'the-boardroom-boss', 'The Boardroom', 'Obtain approval for a defensible security strategy from this board, explaining every element of risk in language a business leader can act on.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w66-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"the-boardroom-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["the-boardroom"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w66-01', 1, 'luna', 'The board isn''t hostile to security. Each person in that room has a different, legitimate priority pulling against every other one. Your job is a strategy all of them can actually approve.'),
  ('mission-w66-01', 2, 'ava', 'This world trades terminals for briefings. The skill doesn''t change -- you''re still translating a technical reality into a decision someone else has to make.'),
  ('mission-w66-02', 1, 'zayn', 'A policy states intent -- "we will protect customer data." A standard sets a specific bar -- "encryption must meet this specification." A procedure spells out the exact steps to meet it. Confuse the three, and governance quietly stops working.'),
  ('mission-w66-03', 1, 'byte', 'For any given decision, exactly one role should be accountable for it. Not everyone who touched the work -- the person who actually owns the outcome.'),
  ('mission-w66-04', 1, 'ava', 'Two frameworks, largely describing the same underlying controls, in completely different language and structure. Learn to translate between them.'),
  ('mission-w66-05', 1, 'luna', 'Legal wants zero exposure. Engineering wants shipping speed. Finance wants a number, not a feeling. Build a position all three can actually live with.'),
  ('mission-w66-06', 1, 'luna', 'Present the strategy. Every risk explained in terms this board can act on, not terms that only make sense to us.'),
  ('mission-w66-06', 2, 'zayn', '...Strategy approved. Funded, scoped, and every stakeholder in that room signed off on it for their own reasons.'),
  ('mission-w66-06', 3, 'ava', 'That''s the actual skill. Not just being right -- being persuasive to people who don''t share your technical vocabulary.'),
  ('mission-w66-06', 4, 'byte', 'While preparing that briefing, I pulled the board''s archived meeting minutes going back years, looking for precedent.'),
  ('mission-w66-06', 5, 'byte', 'Found something. Years ago, senior leadership approved something called "autonomous resilience testing," with what the minutes themselves describe as insufficient safeguards.'),
  ('mission-w66-06', 6, 'luna', 'That decision predates everyone currently in this room.'),
  ('mission-w66-06', 7, 'ava', 'Predates them, but nobody ever reversed it, either. Now we have to actually build a program that can execute a strategy this board can trust.');

