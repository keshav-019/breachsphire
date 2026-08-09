-- world-53 ("Software Supply Chain Security: Poisoned Dependency") mission
-- content, generated from docs/12-world-story-bible.md. Closes the pipeline
-- arc of Act 7 "Cloudfall". Mission 1 is cross-world-gated on world-52's
-- boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-53a', 'world-53', 'poisoned-dependency', '53A - Poisoned Dependency', 'One widely used package, quietly rewritten, spreading Sentinel-X-compatible behavior into every organization that trusted it.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-53a-1', 'campaign-53a', 'foundations', 'Foundations', 'Typosquatting, dependency confusion, malicious packages and build compromise, learned as an ecosystem-wide incident.', 1),
  ('operation-53a-2', 'campaign-53a', 'investigation', 'Investigation', 'Determine affected versions, contain distribution, and restore trusted builds.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w53-01', 'world-53', 'campaign-53a', 'operation-53a-1', 'not-our-repository', 'Not Our Repository', 'The compromise didn''t start with a stolen signing key or a rogue commit. It started with a dependency, one nearly every project in the org already trusted.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w52-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w53-02', 'world-53', 'campaign-53a', 'operation-53a-1', 'one-character-off', 'One Character Off', 'A package name that looks right at a glance. It isn''t the one anyone meant to install.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w53-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"typosquat-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w53-03', 'world-53', 'campaign-53a', 'operation-53a-1', 'the-diff-that-shouldnt-exist', 'The Diff That Shouldn''t Exist', 'Two versions of the same package, a minor version apart. One of them added something that has nothing to do with the changelog.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w53-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"package-diff-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w53-04', 'world-53', 'campaign-53a', 'operation-53a-2', 'how-far-did-it-spread', 'How Far Did It Spread', 'One poisoned package. Dozens of internal projects. The SBOM is the only way to find every one of them without checking by hand.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w53-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"sbom-query-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w53-05', 'world-53', 'campaign-53a', 'operation-53a-2', 'what-should-have-stopped-this', 'What Should Have Stopped This', 'No registry policy required proof of where this package actually came from. That has to change before this happens again.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w53-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"registry-policy-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w53-06', 'world-53', 'campaign-53a', 'operation-53a-2', 'poisoned-dependency-boss', 'Poisoned Dependency', 'Determine exactly which versions are affected, contain distribution before more projects pull the poisoned package, and restore trusted builds across the org.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w53-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"poisoned-dependency-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["poisoned-dependency"],"skillXp":{"cloud_security":50}}'::jsonb, true, 6);

