-- world-52 ("DevSecOps: Pipeline Breach") mission content, generated from
-- docs/12-world-story-bible.md. Continues Act 7 "Cloudfall". Mission 1 is
-- cross-world-gated on world-51's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-52a', 'world-52', 'pipeline-breach', '52A - Pipeline Breach', 'Valid commits. Passing tests. Signed artifacts. And still, compromised software came out the other end.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-52a-1', 'campaign-52a', 'foundations', 'Foundations', 'Secure SDLC, SAST/DAST/SCA, secret scanning and signing/provenance, learned by treating the pipeline as production infrastructure.', 1),
  ('operation-52a-2', 'campaign-52a', 'investigation', 'Investigation', 'Find exactly where trust was misplaced, then redesign the build path to make tampering visible.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w52-01', 'world-52', 'campaign-52a', 'operation-52a-1', 'the-pipeline-that-signed-off-on-it', 'The Pipeline That Signed Off On It', 'That malicious Kubernetes deployment came through a CI/CD pipeline. A signed one. Every commit, test, and signature checks out.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w51-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w52-02', 'world-52', 'campaign-52a', 'operation-52a-1', 'every-stage-a-checkpoint', 'Every Stage a Checkpoint', 'Source, build, test, sign, deploy. Each stage is supposed to catch what the last one missed.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w52-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"pipeline-stage-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w52-03', 'world-52', 'campaign-52a', 'operation-52a-1', 'noise-versus-a-real-finding', 'Noise Versus a Real Finding', 'The static and dependency scanners fired a dozen alerts on this build. Eleven are noise. One isn''t.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w52-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"scanner-triage-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w52-04', 'world-52', 'campaign-52a', 'operation-52a-1', 'checked-in-by-accident', 'Checked In by Accident', 'A CI configuration file, checked in for convenience, holding something it was never supposed to hold.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w52-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"secret-scan-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w52-05', 'world-52', 'campaign-52a', 'operation-52a-2', 'a-signature-that-proves-less-than-it-looks-like', 'A Signature That Proves Less Than It Looks Like', 'The artifact is signed. The signature is valid. But valid isn''t the same question as trustworthy.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w52-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"provenance-attestation-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w52-06', 'world-52', 'campaign-52a', 'operation-52a-2', 'pipeline-breach-boss', 'Pipeline Breach', 'Identify exactly where trust was misplaced in this pipeline, and redesign the build path so the next tampering attempt can''t stay invisible.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w52-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"pipeline-breach-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["pipeline-breach"],"skillXp":{"cloud_security":50}}'::jsonb, true, 6);

