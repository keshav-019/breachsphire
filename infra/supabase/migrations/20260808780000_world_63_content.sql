-- world-63 ("Product Security: Secure by Design") mission content,
-- generated from docs/12-world-story-bible.md. Closes Act 8 "Zero Day".
-- Mission 1 is cross-world-gated on world-62's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-63a', 'world-63', 'secure-by-design', '63A - Secure by Design', 'A product team, before a single line of code exists, trying to prevent the next Sentinel-compatible failure instead of finding it afterward.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-63a-1', 'campaign-63a', 'foundations', 'Foundations', 'Threat modelling, architecture review and dependency risk, learned as a proactive discipline.', 1),
  ('operation-63a-2', 'campaign-63a', 'investigation', 'Investigation', 'Approve, revise, or reject a new product architecture, and justify the security requirements before launch.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w63-01', 'world-63', 'campaign-63a', 'operation-63a-1', 'before-the-code-exists', 'Before the Code Exists', 'Luna is asking you to join a product team before a single line of code has been written. This time, the job is to prevent the next Sentinel-compatible failure, not investigate it after the fact.', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w62-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w63-02', 'world-63', 'campaign-63a', 'operation-63a-1', 'naming-the-threats-before-they-exist', 'Naming the Threats Before They Exist', 'A threat model asks what could go wrong before anything has actually gone wrong. Every proposed feature gets sorted into categories of failure.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w63-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"threat-modeling-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w63-03', 'world-63', 'campaign-63a', 'operation-63a-1', 'a-boundary-that-was-never-drawn', 'A Boundary That Was Never Drawn', 'An architecture diagram, missing exactly one trust boundary. Everything downstream of that gap inherits the risk.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w63-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"architecture-review-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w63-04', 'world-63', 'campaign-63a', 'operation-63a-2', 'a-dependency-request-worth-questioning', 'A Dependency Request Worth Questioning', 'A team wants to add a new third-party dependency. After everything this year, that request gets a real evaluation.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w63-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"dependency-risk-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w63-05', 'world-63', 'campaign-63a', 'operation-63a-2', 'the-gate-before-launch', 'The Gate Before Launch', 'A release checklist stands between this product and its launch date. Some items on it are not optional, no matter the deadline.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w63-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"release-gate-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w63-06', 'world-63', 'campaign-63a', 'operation-63a-2', 'secure-by-design-boss', 'Secure by Design', 'Approve, revise, or reject this new product architecture, and justify the security requirements you''re attaching to it before launch.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w63-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"secure-by-design-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["secure-by-design"],"skillXp":{"web_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w63-01', 1, 'luna', 'Join a product team before a single line of code has been written. This time, prevent the next Sentinel-compatible failure. Don''t investigate it afterward.'),
  ('mission-w63-01', 2, 'ava', 'Everything you''ve learned all year -- request smuggling, poisoned dependencies, memory corruption -- none of it started as an emergency. It started as a decision nobody questioned.'),
  ('mission-w63-02', 1, 'zayn', 'A threat model asks what could go wrong before anything has actually gone wrong. Sort every proposed feature into what kind of failure it could invite.'),
  ('mission-w63-03', 1, 'byte', 'An architecture diagram, missing exactly one trust boundary. Everything downstream of that gap inherits whatever risk lives on the other side of it.'),
  ('mission-w63-04', 1, 'ava', 'A team wants a new third-party dependency added. After everything this year, that request earns a real evaluation, not a rubber stamp.'),
  ('mission-w63-05', 1, 'luna', 'A release checklist stands between this product and its launch date. Some items on it are not optional, no matter how close that date is.'),
  ('mission-w63-06', 1, 'luna', 'Approve it, revise it, or reject it. Whatever you decide, justify the security requirements in terms the product team can actually act on.'),
  ('mission-w63-06', 2, 'zayn', '...Decision made: revise, not reject. The core design is sound. Two specific gaps need closing before this ships.'),
  ('mission-w63-06', 3, 'byte', 'Missing trust boundary on the ingestion path, and no dependency review gate in the build pipeline. Both fixable before launch, neither fixable after an incident.'),
  ('mission-w63-06', 4, 'ava', 'That''s the whole point of this world. You caught both before either one became a headline.'),
  ('mission-w63-06', 5, 'luna', 'Here''s what this exercise should make clear. Look back at every incident this year. How many of them were really about a missing patch, and how many were about a decision nobody ever revisited?'),
  ('mission-w63-06', 6, 'byte', 'Most of them trace back further than the technical failure. To a choice that was never written down, or a boundary nobody was assigned to own.'),
  ('mission-w63-06', 7, 'luna', 'Technical failures and governance failures. You''re about to spend an entire act learning the second kind.');

