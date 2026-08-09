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

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w49-01', 1, 'ava', 'That automation identity from World 48 had excessive privileges across the account. We need to know everywhere it actually went, not just where we already caught it.'),
  ('mission-w49-01', 2, 'zayn', 'Cloud compromises rarely stay in one place. One misconfiguration usually leads straight into the next.'),
  ('mission-w49-02', 1, 'zayn', 'A storage bucket, set public for a demo years ago and never locked back down. It''s been sitting there the entire time.'),
  ('mission-w49-03', 1, 'byte', 'Every cloud instance can ask its own metadata service "who am I, and what can I do." An app with a request-forwarding bug let someone else ask on its behalf.'),
  ('mission-w49-04', 1, 'zayn', 'A serverless function''s configuration panel had a database password sitting in plain text. Anyone who could view settings could read it.'),
  ('mission-w49-05', 1, 'ava', 'A security group open to any address on the internet, on a port meant to only ever hear from one internal service. That''s not a typo, that''s an invitation.'),
  ('mission-w49-06', 1, 'zayn', 'Reproduce the whole path -- bucket, metadata service, secret, network exposure -- start to finish, in a sandboxed replica.'),
  ('mission-w49-06', 2, 'byte', '...Path confirmed. Every step chains into the next. This wasn''t one mistake, it was four small ones that happened to line up perfectly.'),
  ('mission-w49-06', 3, 'ava', 'Close every one of them without taking the application down. Customers are still using this system right now.'),
  ('mission-w49-06', 4, 'zayn', 'Done. Bucket locked, metadata service hardened, secret rotated into a vault, security group scoped to exactly what it needs.'),
  ('mission-w49-06', 5, 'byte', 'One more thing. The compromised deployment pulls its container image from a registry we''ve always trusted completely.'),
  ('mission-w49-06', 6, 'ava', 'Then the image itself is the next thing we stop trusting.');

