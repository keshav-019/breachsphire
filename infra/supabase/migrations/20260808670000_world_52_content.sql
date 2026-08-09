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

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w52-01', 1, 'ava', 'That malicious deployment came through a signed CI/CD pipeline. Every commit is legitimate. Every test passed. The signature checks out.'),
  ('mission-w52-01', 2, 'byte', 'Which means the pipeline itself has to be treated as production infrastructure, not just the thing that ships it.'),
  ('mission-w52-02', 1, 'zayn', 'Source, build, test, sign, deploy. Each stage exists to catch what slipped past the one before it. Find the stage where that stopped being true.'),
  ('mission-w52-03', 1, 'byte', 'A dozen scanner alerts on this build. Most are the usual noise. One of them is describing something real.'),
  ('mission-w52-04', 1, 'zayn', 'Someone checked in a CI configuration file for convenience, and it''s holding something that was never supposed to leave a developer''s machine.'),
  ('mission-w52-05', 1, 'ava', 'The artifact is signed, and the signature is cryptographically valid. That only proves who signed it -- not that what they signed was ever supposed to exist.'),
  ('mission-w52-06', 1, 'zayn', 'Find the exact point where trust was misplaced. Not "the pipeline is bad" -- the specific stage, the specific assumption.'),
  ('mission-w52-06', 2, 'byte', '...Found it. Signing happened before dependency resolution was locked and verified. Anything pulled in during that window got signed along with everything else, no questions asked.'),
  ('mission-w52-06', 3, 'ava', 'So the compromise didn''t need to touch the repository at all.'),
  ('mission-w52-06', 4, 'byte', 'Correct. It came from a dependency, pulled in during that unverified window.'),
  ('mission-w52-06', 5, 'zayn', 'Redesign is done. Dependencies lock and get verified before signing, not after. Provenance now records exactly what was resolved, not just what was committed.'),
  ('mission-w52-06', 6, 'ava', 'Then the dependency itself is where this actually started. Time to go find it.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w52-01-o1', 'mission-w52-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to treat the pipeline as production infrastructure.'),
  ('mission-w52-02-o1', 'mission-w52-02', 1, 'Find the stage with no real checkpoint', 'Identify which pipeline stage fails to verify what it claims to verify.'),
  ('mission-w52-03-o1', 'mission-w52-03', 1, 'Triage the scanner findings', 'Identify which scanner alert represents a real, actionable finding.'),
  ('mission-w52-04-o1', 'mission-w52-04', 1, 'Find the leaked secret', 'Identify the field in the CI configuration holding a real secret.'),
  ('mission-w52-05-o1', 'mission-w52-05', 1, 'Distinguish valid from trustworthy', 'Determine what a valid signature does and doesn''t prove.'),
  ('mission-w52-06-o1', 'mission-w52-06', 1, 'Find where trust was misplaced', 'Identify the exact pipeline ordering flaw that let an unverified dependency get signed.'),
  ('mission-w52-06-o2', 'mission-w52-06', 2, 'Redesign the build path', 'Choose the pipeline redesign that makes tampering visible instead of trusted.'),
  ('mission-w52-06-o3', 'mission-w52-06', 3, 'Confirm the redesign', 'Confirm the misplaced-trust finding and the redesign together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w52-01-o1-c1', 'mission-w52-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"ava","text":"Every step of this pipeline checks out on paper. Ready to find out why that isn''t enough?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w52-02-o1-c1', 'mission-w52-02-o1', 1, 'interactive_diagram', 'Which pipeline stage fails to verify what it claims to verify?', '{"hotspots":[{"id":"source","label":"Source stage -- requires signed commits from verified contributors","explanation":"Actually enforced -- unsigned commits are rejected."},{"id":"build","label":"Build stage -- compiles from source and resolves dependencies from the lockfile","explanation":"Resolves dependencies, but doesn''t re-verify their hashes against the lockfile."},{"id":"test","label":"Test stage -- runs the full automated test suite","explanation":"Actually enforced -- failing tests block the pipeline."},{"id":"sign","label":"Sign stage -- signs the final build artifact","explanation":"Signs whatever the build stage produced, without knowing if dependency resolution was tampered with."}],"task":"Which stage has a gap between what it claims and what it actually checks?"}'::jsonb, '{"correctOrderIds":["build"]}'::jsonb),

  ('mission-w52-03-o1-c1', 'mission-w52-03-o1', 1, 'browser_simulation', 'Which scanner alert represents a real, actionable finding?', '{"screen":"scanner-findings-triage","findings":[{"id":"f1","tool":"SAST","detail":"Flags a false positive on a sanitized template string, already reviewed and suppressed twice before"},{"id":"f2","tool":"SCA","detail":"Flags a transitive dependency pulled in at a version range that resolves differently than what''s pinned in the lockfile"},{"id":"f3","tool":"DAST","detail":"Flags a verbose error message on a non-production test endpoint that doesn''t exist in the real build"}],"question":"Which finding is real and actionable?"}'::jsonb, '{"correctOptionId":"f2"}'::jsonb),

  ('mission-w52-04-o1-c1', 'mission-w52-04-o1', 1, 'code_debugging', 'Find the field in the CI configuration holding a real secret.', '{"language":"yaml","code":"name: build-and-deploy\non: [push]\njobs:\n  build:\n    runs-on: ubuntu-latest\n    env:\n      NODE_ENV: production\n      REGISTRY_TOKEN: ghp_9K2mQ7xR4tYvL8nZ1pW6sA3bC5dE0fG2h\n    steps:\n      - uses: actions/checkout@v4\n      - run: npm ci && npm run build","question":"Which field is the security issue, and why?"}'::jsonb, '{"requiredLineIds":["REGISTRY_TOKEN: ghp_9K2mQ7xR4tYvL8nZ1pW6sA3bC5dE0fG2h"]}'::jsonb),

  ('mission-w52-05-o1-c1', 'mission-w52-05-o1', 1, 'multiple_choice', 'The build artifact has a cryptographically valid signature. What does that actually prove?', '{"question":"The build artifact has a cryptographically valid signature. What does that actually prove?","options":[{"id":"a","text":"Nothing in the artifact was ever tampered with, at any stage"},{"id":"b","text":"Only that whoever held the signing key at signing time signed exactly these bytes -- it says nothing about whether those bytes should have existed"},{"id":"c","text":"The artifact passed every security scanner"},{"id":"d","text":"The dependencies used are all safe"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w52-06-o1-c1', 'mission-w52-06-o1', 1, 'multiple_choice', 'Signing happens after the build stage produces an artifact, but before dependency hashes are re-verified against the lockfile. What does this ordering allow?', '{"question":"Signing happens after the build stage produces an artifact, but before dependency hashes are re-verified against the lockfile. What does this ordering allow?","options":[{"id":"a","text":"Nothing -- signing always happens last regardless of order"},{"id":"b","text":"A dependency resolved outside the pinned lockfile during build can get bundled and signed as if it were legitimate, with no verification step ever catching the mismatch"},{"id":"c","text":"It only affects build speed, not security"},{"id":"d","text":"Signing keys get rotated automatically to fix this"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w52-06-o2-c1', 'mission-w52-06-o2', 1, 'drag_and_drop', 'Order the redesigned pipeline stages so tampering becomes visible instead of trusted.', '{"items":[{"id":"s1","text":"Resolve dependencies strictly from the lockfile"},{"id":"s2","text":"Verify every resolved dependency''s hash against the lockfile before build"},{"id":"s3","text":"Build the artifact"},{"id":"s4","text":"Generate a provenance attestation recording exactly what was resolved and built"},{"id":"s5","text":"Sign the artifact together with its provenance attestation"}],"targets":[{"id":"order","label":"Correct pipeline order"}]}'::jsonb, '{"correctOrderIds":["s1","s2","s3","s4","s5"]}'::jsonb),

  ('mission-w52-06-o3-c1', 'mission-w52-06-o3', 1, 'boss_encounter', 'Confirm the misplaced-trust finding and the redesigned build path together.', '{"stages":[{"objectiveRef":"mission-w52-06-o1","label":"Where trust was misplaced"},{"objectiveRef":"mission-w52-06-o2","label":"The redesigned build path"}],"task":"Confirm the misplaced-trust finding and the redesigned build path together."}'::jsonb, '{"requiredObjectiveIds":["mission-w52-06-o1","mission-w52-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w52-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w52-02-o1-c1', 'orientation', 'Ask which stage produces something without re-checking it against a known-good reference.', 15, 1),
  ('mission-w52-02-o1-c1', 'solution', 'The build stage resolves dependencies but never re-verifies their hashes against the lockfile -- everything downstream trusts whatever it produced.', 25, 2),

  ('mission-w52-03-o1-c1', 'orientation', 'Two of these three findings describe things that were already reviewed or don''t exist in production.', 15, 1),
  ('mission-w52-03-o1-c1', 'solution', 'A transitive dependency resolving outside the pinned lockfile range (f2) is a real, actionable supply-chain finding -- the other two are already-suppressed or non-production noise.', 25, 2),

  ('mission-w52-04-o1-c1', 'orientation', 'Three of these four config fields are completely normal to have in plain text in a CI file.', 15, 1),
  ('mission-w52-04-o1-c1', 'solution', 'REGISTRY_TOKEN holding a raw token value is the leak -- it belongs in the CI system''s secrets store, referenced by name, never committed as a literal value.', 25, 2),

  ('mission-w52-05-o1-c1', 'orientation', 'A signature proves who signed something. It doesn''t say anything about whether it should have existed in the first place.', 15, 1),
  ('mission-w52-05-o1-c1', 'solution', 'A valid signature only proves the signer signed exactly these bytes -- it says nothing about whether those bytes were legitimately produced. Option b.', 25, 2),

  ('mission-w52-06-o1-c1', 'orientation', 'Ask what happens to anything resolved between "build starts" and "signing happens," if nothing checks it in between.', 15, 1),
  ('mission-w52-06-o1-c1', 'concept', 'A verification step that runs after the thing it''s supposed to verify has already been trusted downstream isn''t really verifying anything.', 25, 2),
  ('mission-w52-06-o1-c1', 'solution', 'Signing before dependency hashes are re-verified means anything pulled in during that window -- including a tampered or malicious dependency -- gets signed as if it were legitimate. Option b.', 35, 3),

  ('mission-w52-06-o2-c1', 'orientation', 'Every verification step needs to happen before the step that "seals" the result, not after.', 15, 1),
  ('mission-w52-06-o2-c1', 'solution', 'Resolve strictly from the lockfile, verify hashes before building, build, record provenance, then sign the artifact together with its provenance -- verification always precedes the seal.', 25, 2),

  ('mission-w52-06-o3-c1', 'orientation', 'You''ve already found the misplaced trust and the redesign -- combine them.', 20, 1),
  ('mission-w52-06-o3-c1', 'solution', 'Trust was misplaced by signing before dependency hashes were re-verified against the lockfile -- the redesign moves verification before signing and records exactly what was resolved in a provenance attestation, so a tampered dependency can no longer ride along unnoticed.', 35, 2);
