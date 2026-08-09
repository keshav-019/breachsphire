-- world-51 ("Kubernetes: Clusterfall") mission content, generated from
-- docs/12-world-story-bible.md. Continues Act 7 "Cloudfall". Mission 1 is
-- cross-world-gated on world-50's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-51a', 'world-51', 'clusterfall', '51A - Clusterfall', 'A poisoned image alone can''t explain reaching high-value services across several clusters. Something in the cluster itself gave it the path.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-51a-1', 'campaign-51a', 'foundations', 'Foundations', 'RBAC, service accounts, namespaces and network policies, learned as a live cluster investigation.', 1),
  ('operation-51a-2', 'campaign-51a', 'investigation', 'Investigation', 'Trace the path from one workload to cluster-wide impact, then break the chain.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w51-01', 'world-51', 'campaign-51a', 'operation-51a-1', 'more-than-one-image', 'More Than One Image', 'The poisoned image explains how Sentinel-X got in. It doesn''t explain how it reached high-value services in clusters that never even pulled that image.', 'intro', ARRAY['ava', 'zayn', 'byte'], '{"requiredMissionIds":["mission-w50-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w51-02', 'world-51', 'campaign-51a', 'operation-51a-1', 'the-role-that-can-do-too-much', 'The Role That Can Do Too Much', 'A service account bound to a role with far more permissions than the pod using it could ever legitimately need.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w51-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"rbac-graph-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w51-03', 'world-51', 'campaign-51a', 'operation-51a-1', 'no-fence-between-namespaces', 'No Fence Between Namespaces', 'Namespaces are supposed to separate workloads. Without a network policy, they''re just labels.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w51-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"network-policy-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w51-04', 'world-51', 'campaign-51a', 'operation-51a-2', 'a-token-that-talked-to-the-api-server', 'A Token That Talked to the API Server', 'A compromised pod used its own service account token to query the Kubernetes API server directly, for things it had no reason to ask about.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w51-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"api-server-audit-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w51-05', 'world-51', 'campaign-51a', 'operation-51a-2', 'nothing-stopped-it-at-the-door', 'Nothing Stopped It at the Door', 'A privileged pod spec was accepted into the cluster with no admission control ever questioning it.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w51-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"admission-control-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w51-06', 'world-51', 'campaign-51a', 'operation-51a-2', 'clusterfall-boss', 'Clusterfall', 'Trace the complete path from one compromised workload to cluster-wide impact, and break the chain at every link that made it possible.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w51-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"clusterfall-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["clusterfall"],"skillXp":{"cloud_security":50}}'::jsonb, true, 6);

