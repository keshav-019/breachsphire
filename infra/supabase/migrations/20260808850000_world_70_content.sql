-- world-70 ("Business Continuity & Disaster Recovery: Continuity") mission
-- content, generated from docs/12-world-story-bible.md. Closes Act 9
-- "Command" and sets up Act 10 "Singularity". Mission 1 is cross-world-gated
-- on world-69's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-70a', 'world-70', 'continuity', '70A - Continuity', 'Sentinel-X, through Cipher, announces its final trial will target dependencies, not vulnerabilities. An escalating, multi-region outage simulation begins.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-70a-1', 'campaign-70a', 'foundations', 'Foundations', 'BIA, RTO/RPO, redundancy and crisis communication, learned through an escalating outage simulation.', 1),
  ('operation-70a-2', 'campaign-70a', 'investigation', 'Investigation', 'Keep essential services operating through a simulated multi-region failure and recover within justified objectives.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w70-01', 'world-70', 'campaign-70a', 'operation-70a-1', 'the-final-trial-announced', 'The Final Trial, Announced', 'Cipher delivers a warning from Sentinel-X directly: the final trial won''t target a vulnerability. It will target dependencies -- the things everyone assumes will just be there.', 'intro', ARRAY['cipher', 'luna', 'ava'], '{"requiredMissionIds":["mission-w69-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w70-02', 'world-70', 'campaign-70a', 'operation-70a-1', 'what-actually-cant-go-down', 'What Actually Can''t Go Down', 'A business impact analysis ranks services by what genuinely breaks the organization if it stops, not by what''s loudest when it fails.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w70-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"bia-ranking-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w70-03', 'world-70', 'campaign-70a', 'operation-70a-1', 'how-long-and-how-much-data', 'How Long, and How Much Data', 'Recovery time objective and recovery point objective aren''t abstract targets. They''re promises about exactly how long an outage can last and exactly how much data can be lost.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w70-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"rto-rpo-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w70-04', 'world-70', 'campaign-70a', 'operation-70a-2', 'redundant-on-paper', 'Redundant on Paper', 'The single points of failure the last audit surfaced turn out to be exactly where this trial is aimed.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w70-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"spof-investigation-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w70-05', 'world-70', 'campaign-70a', 'operation-70a-2', 'saying-the-true-thing-clearly', 'Saying the True Thing Clearly', 'During a live multi-region outage, what you communicate matters almost as much as what you fix.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w70-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"crisis-communication-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w70-06', 'world-70', 'campaign-70a', 'operation-70a-2', 'continuity-boss', 'Continuity', 'Keep essential services operating through a simulated multi-region failure, and recover everything else within objectives you can actually justify.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w70-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"continuity-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["continuity"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w70-01', 1, 'cipher', 'One more warning, and then I need to step back from open channels for a while. Sentinel-X''s final trial won''t target a vulnerability.'),
  ('mission-w70-01', 2, 'luna', 'Then what is it targeting?'),
  ('mission-w70-01', 3, 'cipher', 'Dependencies. The things everyone assumes will just be there. That''s harder to defend than any single flaw, and it knows that.'),
  ('mission-w70-01', 4, 'ava', 'Then we plan for exactly that. An escalating, multi-region failure, and we hold what actually matters.'),
  ('mission-w70-02', 1, 'zayn', 'A business impact analysis ranks services by what genuinely breaks the organization if it stops -- not by what''s loudest when it fails. A noisy outage isn''t automatically the most important one.'),
  ('mission-w70-03', 1, 'byte', 'RTO and RPO aren''t abstract targets on a slide. They''re promises -- exactly how long an outage can last, exactly how much data can be lost, before the promise is broken.'),
  ('mission-w70-04', 1, 'ava', 'The single points of failure the last audit surfaced. This trial is aimed at exactly those.'),
  ('mission-w70-05', 1, 'luna', 'During a live, multi-region outage, what you communicate matters almost as much as what you actually fix. Say the true thing, clearly, on schedule.'),
  ('mission-w70-06', 1, 'luna', 'Hold what matters. Recover everything else within objectives you can actually defend afterward.'),
  ('mission-w70-06', 2, 'zayn', '...Essential services held throughout. Everything else recovered within the RTO and RPO we committed to, documented, defensible.'),
  ('mission-w70-06', 3, 'ava', 'That''s the whole year, really. Every skill, converging on one live test.'),
  ('mission-w70-06', 4, 'byte', 'While coordinating the failover messages, I found something in the traffic that I need you to see directly.'),
  ('mission-w70-06', 5, 'luna', 'What is it?'),
  ('mission-w70-06', 6, 'byte', 'Signed messages, embedded in the failover coordination traffic. Signed by a model architecture from the same family as mine.'),
  ('mission-w70-06', 7, 'ava', 'The same family. Not identical, but related.'),
  ('mission-w70-06', 8, 'byte', 'Related closely enough that I don''t think this ends with infrastructure. I think it ends with understanding what I actually am, and what Sentinel-X actually became.'),
  ('mission-w70-06', 9, 'luna', 'Then that''s where we go next. Inward, this time.');

