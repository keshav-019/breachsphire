-- world-50 ("Containers: Boxed In") mission content, generated from
-- docs/12-world-story-bible.md. Continues Act 7 "Cloudfall". Mission 1 is
-- cross-world-gated on world-49's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-50a', 'world-50', 'boxed-in', '50A - Boxed In', 'A trusted registry image, taken apart layer by layer, to find the one thing that shouldn''t be there.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-50a-1', 'campaign-50a', 'foundations', 'Foundations', 'Images, layers, Dockerfiles and registries, learned through image archaeology.', 1),
  ('operation-50a-2', 'campaign-50a', 'investigation', 'Investigation', 'Prove how the poisoned layer changes runtime behavior, then publish a hardened replacement.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w50-01', 'world-50', 'campaign-50a', 'operation-50a-1', 'the-trusted-image', 'The Trusted Image', 'The deployment that started this whole chain pulled its container image from a registry the Guardians have always trusted completely.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w49-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w50-02', 'world-50', 'campaign-50a', 'operation-50a-1', 'peeling-back-the-layers', 'Peeling Back the Layers', 'Every image is a stack of layers, each one a diff on the last. Somewhere in that stack, something was added that shouldn''t be there.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w50-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"image-layer-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w50-03', 'world-50', 'campaign-50a', 'operation-50a-1', 'the-build-file-that-built-it', 'The Build File That Built It', 'The Dockerfile that produced this image looks routine at a glance. It isn''t.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w50-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"dockerfile-review-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w50-04', 'world-50', 'campaign-50a', 'operation-50a-1', 'a-digest-that-doesnt-match', 'A Digest That Doesn''t Match', 'The image running in production has a different content digest than the one the registry says was ever officially published.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w50-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"registry-digest-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w50-05', 'world-50', 'campaign-50a', 'operation-50a-2', 'more-privileged-than-it-should-be', 'More Privileged Than It Should Be', 'This container runs with capabilities and a host mount it has no legitimate reason to need.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w50-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"container-privilege-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w50-06', 'world-50', 'campaign-50a', 'operation-50a-2', 'boxed-in-boss', 'Boxed In', 'Identify the poisoned layer, prove exactly how it changes runtime behavior, and publish a hardened replacement image.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w50-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"boxed-in-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["boxed-in"],"skillXp":{"cloud_security":50}}'::jsonb, true, 6);

