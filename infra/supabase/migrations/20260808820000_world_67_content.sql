-- world-67 ("Security Program Management: Program Zero") mission content,
-- generated from docs/12-world-story-bible.md. Continues Act 9 "Command".
-- Mission 1 is cross-world-gated on world-66's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-67a', 'world-67', 'program-zero', '67A - Program Zero', 'The board approved the strategy. The organization still doesn''t have the people, process, or budget to actually execute it.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-67a-1', 'campaign-67a', 'foundations', 'Foundations', 'Roadmaps, staffing, budgeting and metrics, presented as a multi-quarter strategy simulation.', 1),
  ('operation-67a-2', 'campaign-67a', 'investigation', 'Investigation', 'Build a 12-month program that materially reduces Sentinel-related risk under fixed budget and staffing.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w67-01', 'world-67', 'campaign-67a', 'operation-67a-1', 'approved-doesnt-mean-staffed', 'Approved Doesn''t Mean Staffed', 'The board approved the strategy. That''s a starting line, not a finish line -- the organization still needs people, process and budget to actually execute it.', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w66-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w67-02', 'world-67', 'campaign-67a', 'operation-67a-1', 'what-has-to-happen-before-what', 'What Has to Happen Before What', 'A 12-month roadmap isn''t a wish list. Some initiatives are prerequisites for others, whether or not the calendar agrees.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w67-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"roadmap-sequencing-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w67-03', 'world-67', 'campaign-67a', 'operation-67a-1', 'three-open-roles-eight-priorities', 'Three Open Roles, Eight Priorities', 'Limited headcount, more priorities than people to cover them. Every staffing decision is really a prioritization decision in disguise.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w67-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"staffing-allocation-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w67-04', 'world-67', 'campaign-67a', 'operation-67a-1', 'a-metric-that-actually-means-something', 'A Metric That Actually Means Something', 'A dashboard full of numbers means nothing if none of them would actually change a decision. Real metrics either predict a problem or confirm progress.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w67-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"kpi-kri-design-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w67-05', 'world-67', 'campaign-67a', 'operation-67a-2', 'a-vendor-that-wont-show-its-work', 'A Vendor That Won''t Show Its Work', 'A key supplier keeps passing the annual security questionnaire, but has stopped providing the underlying evidence anyone can actually verify.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w67-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"supplier-management-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w67-06', 'world-67', 'campaign-67a', 'operation-67a-2', 'program-zero-boss', 'Program Zero', 'Build a 12-month program that materially reduces Sentinel-related risk, under the fixed budget and staffing this organization actually has.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w67-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"program-zero-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["program-zero"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

