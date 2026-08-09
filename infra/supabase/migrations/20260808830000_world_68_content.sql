-- world-68 ("Legal, Regulation & Privacy: Lines of Law") mission content,
-- generated from docs/12-world-story-bible.md. Continues Act 9 "Command".
-- Mission 1 is cross-world-gated on world-67's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-68a', 'world-68', 'lines-of-law', '68A - Lines of Law', 'The supplier''s refusal to hand over evidence just became a legal question. And it isn''t the only one waiting.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-68a-1', 'campaign-68a', 'foundations', 'Foundations', 'Privacy, evidence, jurisdiction, cross-border data and cybercrime concepts, learned through counsel briefings.', 1),
  ('operation-68a-2', 'campaign-68a', 'investigation', 'Investigation', 'Coordinate a response that satisfies security objectives without creating avoidable legal or privacy violations.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w68-01', 'world-68', 'campaign-68a', 'operation-68a-1', 'past-where-technical-skill-alone-helps', 'Past Where Technical Skill Alone Helps', 'The supplier''s refusal just became a legal question. Containment now spans multiple countries, customers and regulated datasets -- technical ability is no longer the only constraint.', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w67-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w68-02', 'world-68', 'campaign-68a', 'operation-68a-1', 'does-this-trigger-the-clock', 'Does This Trigger the Clock', 'Not every incident requires regulatory notification. The ones that do start a legal clock the moment they''re confirmed, not the moment someone gets around to it.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w68-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"breach-notification-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w68-03', 'world-68', 'campaign-68a', 'operation-68a-1', 'data-doesnt-stop-at-a-border', 'Data Doesn''t Stop at a Border', 'A data flow that looks perfectly normal technically can still cross a legal line the moment it crosses a jurisdiction.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w68-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"cross-border-data-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w68-04', 'world-68', 'campaign-68a', 'operation-68a-1', 'evidence-that-holds-up-in-court', 'Evidence That Holds Up in Court', 'Technical evidence and legally admissible evidence aren''t automatically the same thing. The chain of custody is what bridges them.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w68-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"legal-evidence-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w68-05', 'world-68', 'campaign-68a', 'operation-68a-2', 'the-clause-that-was-never-in-the-contract', 'The Clause That Was Never in the Contract', 'The supplier issue exposed a gap nobody caught at signing: this contract never included a right-to-audit clause at all.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w68-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"contract-clause-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w68-06', 'world-68', 'campaign-68a', 'operation-68a-2', 'lines-of-law-boss', 'Lines of Law', 'Coordinate a complete response to this cross-border incident that satisfies the security objectives without creating avoidable legal or privacy violations.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w68-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"lines-of-law-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["lines-of-law"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w68-01', 1, 'luna', 'The supplier''s refusal just became a legal question. Containment now spans multiple countries, multiple customers, and regulated data. Technical skill alone doesn''t get us through this one.'),
  ('mission-w68-01', 2, 'ava', 'Every decision from here needs a legal lens next to the technical one. Sometimes the right technical answer is the wrong legal one, and you need to know which is which.'),
  ('mission-w68-02', 1, 'zayn', 'Not every incident triggers a notification requirement. The ones that do start a legal clock the moment they''re confirmed -- not whenever someone finally writes the report.'),
  ('mission-w68-03', 1, 'byte', 'A data flow that looks completely normal from a technical standpoint can still cross a legal line the instant it crosses a jurisdiction.'),
  ('mission-w68-04', 1, 'ava', 'Technical evidence and legally admissible evidence aren''t automatically the same thing. Chain of custody is the bridge between them.'),
  ('mission-w68-05', 1, 'luna', 'The supplier issue exposed something worse than a refusal. This contract never had a right-to-audit clause in it at all.'),
  ('mission-w68-06', 1, 'luna', 'Coordinate the full response. Every security objective still has to be met -- but not at the cost of an avoidable legal or privacy violation.'),
  ('mission-w68-06', 2, 'zayn', '...Response coordinated. Notification obligations met on time, data handling respects every jurisdiction it touched, evidence chain intact and admissible.'),
  ('mission-w68-06', 3, 'ava', 'That''s the actual discipline here -- getting the technical response right and the legal response right, at the same time, under a deadline.'),
  ('mission-w68-06', 4, 'byte', 'The regulators reviewing this incident aren''t just asking what happened anymore.'),
  ('mission-w68-06', 5, 'luna', 'What are they asking?'),
  ('mission-w68-06', 6, 'byte', 'Proof. Not a description of our controls -- evidence that they actually worked, or specifically didn''t, and why.'),
  ('mission-w68-06', 7, 'luna', 'Then the next step isn''t explaining our controls. It''s proving them.');

