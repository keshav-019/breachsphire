-- world-69 ("Security Assessment & Audit: Proof") mission content,
-- generated from docs/12-world-story-bible.md. Continues Act 9 "Command".
-- Mission 1 is cross-world-gated on world-68's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-69a', 'world-69', 'proof', '69A - Proof', 'The organization claims it fixed years of weaknesses. An independent assessor wants evidence that reality actually matches the policy.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-69a-1', 'campaign-69a', 'foundations', 'Foundations', 'Audit types, sampling, evidence sufficiency and finding classification, framed as proving reality matches policy.', 1),
  ('operation-69a-2', 'campaign-69a', 'investigation', 'Investigation', 'Defend a control set with objective evidence, and acknowledge remaining gaps honestly.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w69-01', 'world-69', 'campaign-69a', 'operation-69a-1', 'claims-versus-proof', 'Claims Versus Proof', 'The organization claims it remediated years of weaknesses. An independent assessor doesn''t take that claim at face value -- they want evidence.', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w68-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w69-02', 'world-69', 'campaign-69a', 'operation-69a-1', 'not-all-audits-ask-the-same-question', 'Not All Audits Ask the Same Question', 'Internal, external, and certification audits all look at controls, but they answer different questions for different audiences.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w69-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"audit-types-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w69-03', 'world-69', 'campaign-69a', 'operation-69a-1', 'you-cant-check-every-single-system', 'You Can''t Check Every Single System', 'Testing a control across a thousand systems doesn''t mean checking all thousand. It means sampling correctly enough that the result actually means something.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w69-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"sampling-methodology-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w69-04', 'world-69', 'campaign-69a', 'operation-69a-1', 'a-policy-document-is-not-evidence', 'A Policy Document Is Not Evidence', 'A written policy proves the organization intended to do something. It doesn''t prove the control actually operated.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w69-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"evidence-sufficiency-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w69-05', 'world-69', 'campaign-69a', 'operation-69a-2', 'not-every-finding-is-equally-urgent', 'Not Every Finding Is Equally Urgent', 'A dozen audit findings, none of them identical in urgency. Classifying them correctly decides what gets fixed this week versus this year.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w69-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"finding-classification-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w69-06', 'world-69', 'campaign-69a', 'operation-69a-2', 'proof-boss', 'Proof', 'Defend the organization''s control set to the assessor using objective evidence, and honestly acknowledge whatever gaps remain instead of hiding them.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w69-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"proof-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["proof"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

