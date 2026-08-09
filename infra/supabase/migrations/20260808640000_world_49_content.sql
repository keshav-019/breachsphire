-- world-49 ("Cloud Security: Misconfigured Sky") mission content, generated
-- from docs/12-world-story-bible.md. Continues Act 7 "Cloudfall". Mission 1
-- is cross-world-gated on world-48's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-49a', 'world-49', 'misconfigured-sky', '49A - Misconfigured Sky', 'The compromised automation identity had excessive privileges. Find out everywhere it actually went.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-49a-1', 'campaign-49a', 'foundations', 'Foundations', 'Public storage, metadata-service credential theft, secret leakage and network exposure, learned as one spreading account compromise.', 1),
  ('operation-49a-2', 'campaign-49a', 'investigation', 'Investigation', 'Reproduce the attack path end to end, then close it without taking the application down.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w49-01', 'world-49', 'campaign-49a', 'operation-49a-1', 'excessive-privileges', 'Excessive Privileges', 'The automation identity from the last world could touch far more than one region. Everywhere it could reach is now suspect.', 'intro', ARRAY['ava', 'zayn'], '{"requiredMissionIds":["mission-w48-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w49-02', 'world-49', 'campaign-49a', 'operation-49a-1', 'the-bucket-left-open', 'The Bucket Left Open', 'A storage bucket, set to public during a demo years ago and never locked back down, held far more than demo data.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w49-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"public-bucket-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w49-03', 'world-49', 'campaign-49a', 'operation-49a-1', 'the-service-that-answers-anything', 'The Service That Answers Anything', 'Every cloud instance can ask its own metadata service who it is. An app with a request-forwarding bug asked on the attacker''s behalf.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w49-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"metadata-ssrf-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w49-04', 'world-49', 'campaign-49a', 'operation-49a-1', 'a-secret-in-plain-sight', 'A Secret in Plain Sight', 'A serverless function''s configuration held a database password in plain text, visible to anyone who could read its settings.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w49-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"secret-config-review-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w49-05', 'world-49', 'campaign-49a', 'operation-49a-2', 'a-door-wide-open-to-everywhere', 'A Door Wide Open to Everywhere', 'A security group allowing inbound traffic from any address, on a port that should only ever hear from one internal service.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w49-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"security-group-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w49-06', 'world-49', 'campaign-49a', 'operation-49a-2', 'misconfigured-sky-boss', 'Misconfigured Sky', 'Reproduce the complete attack path from public bucket to stolen credentials, then close every step of it without taking the application offline.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w49-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"misconfigured-sky-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["misconfigured-sky"],"skillXp":{"cloud_security":50}}'::jsonb, true, 6);

