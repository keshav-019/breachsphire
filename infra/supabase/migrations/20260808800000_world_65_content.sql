-- world-65 ("Risk Management: Risk Ledger") mission content, generated from
-- docs/12-world-story-bible.md. Continues Act 9 "Command". Mission 1 is
-- cross-world-gated on world-64's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-65a', 'world-65', 'risk-ledger', '65A - Risk Ledger', 'Executives cannot fund every control technical teams request. Every decision here is a real tradeoff, not a checklist item.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-65a-1', 'campaign-65a', 'foundations', 'Foundations', 'Threat, vulnerability, likelihood, impact, and inherent versus residual risk, learned through real budget tradeoffs.', 1),
  ('operation-65a-2', 'campaign-65a', 'investigation', 'Investigation', 'Present a prioritized risk treatment plan for the inherited Sentinel assets.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w65-01', 'world-65', 'campaign-65a', 'operation-65a-1', 'not-an-unlimited-budget', 'Not an Unlimited Budget', 'Every control the technical teams want costs something. Leadership cannot fund all of it. Risk management is how you decide what actually matters most.', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w64-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w65-02', 'world-65', 'campaign-65a', 'operation-65a-1', 'the-four-words-everyone-mixes-up', 'The Four Words Everyone Mixes Up', 'Threat, vulnerability, likelihood, impact. Four distinct concepts, constantly used interchangeably by people who should know better.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w65-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"risk-components-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w65-03', 'world-65', 'campaign-65a', 'operation-65a-1', 'what-is-left-after-the-control', 'What Is Left After the Control', 'A control never eliminates risk completely. What remains after it''s applied is the number that actually matters for the next decision.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w65-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"residual-risk-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w65-04', 'world-65', 'campaign-65a', 'operation-65a-1', 'a-number-versus-a-color', 'A Number Versus a Color', 'One scenario, scored two ways -- a red/yellow/green heat map, and a dollar-figure estimate. Both are legitimate. They answer different questions.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w65-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"risk-scoring-methods-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w65-05', 'world-65', 'campaign-65a', 'operation-65a-2', 'four-ways-to-respond', 'Four Ways to Respond', 'Accept it, mitigate it, transfer it, or avoid it entirely. Every identified risk gets one of these four responses, deliberately chosen.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w65-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"risk-response-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w65-06', 'world-65', 'campaign-65a', 'operation-65a-2', 'risk-ledger-boss', 'Risk Ledger', 'Present a prioritized risk treatment plan for the inherited Sentinel assets, under a fixed budget that can''t cover everything.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w65-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"risk-ledger-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["risk-ledger"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

