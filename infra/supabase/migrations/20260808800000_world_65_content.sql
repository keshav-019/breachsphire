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

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w65-01', 1, 'luna', 'Every control the technical teams want costs money and time. We cannot fund all of it. Risk management is how we decide what actually matters most.'),
  ('mission-w65-01', 2, 'ava', 'This isn''t about finding more vulnerabilities. It''s about deciding, with real tradeoffs, which ones deserve the budget first.'),
  ('mission-w65-02', 1, 'zayn', 'Threat, vulnerability, likelihood, impact. Four distinct concepts. Mixing them up is how risk conversations go in circles.'),
  ('mission-w65-03', 1, 'byte', 'A control never eliminates risk completely. What''s left after it''s applied -- the residual risk -- is the number that actually matters for the next decision.'),
  ('mission-w65-04', 1, 'ava', 'One scenario, scored two ways. A red/yellow/green heat map, and a dollar-figure estimate. Both legitimate. They answer different questions for different audiences.'),
  ('mission-w65-05', 1, 'luna', 'Accept it, mitigate it, transfer it, or avoid it entirely. Every risk on this ledger gets one of these four responses, deliberately chosen -- never left undecided.'),
  ('mission-w65-06', 1, 'luna', 'Present the treatment plan for the assets we inherited from that legacy system. Budget is fixed. Prioritize.'),
  ('mission-w65-06', 2, 'zayn', '...Plan built. Highest-risk items funded first, lower-priority items formally accepted with documented rationale, not just ignored.'),
  ('mission-w65-06', 3, 'ava', 'That distinction matters. "Accepted with rationale" and "nobody got around to it" look identical on a spreadsheet and mean completely different things.'),
  ('mission-w65-06', 4, 'byte', 'While building this ledger, I found something in the inherited system''s old records. Project SENTINEL was never formally closed.'),
  ('mission-w65-06', 5, 'luna', 'Never closed. Meaning its risk was never formally assigned to anyone either.'),
  ('mission-w65-06', 6, 'byte', 'Correct. It looks like it was simply transferred between organizations, quietly, without ever being reviewed.'),
  ('mission-w65-06', 7, 'luna', 'An unreviewed, unowned risk, still active after all this time. That''s not a technical failure. That''s a governance failure.');

