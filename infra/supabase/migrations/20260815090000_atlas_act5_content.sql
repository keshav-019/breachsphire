-- Atlas Division pathway ("The Silence") Act 5 -- "The Artifact
-- Factory" content, under world-atlas-artifact-factory (already
-- inserted separately). 1 campaign, 2 operations, 12 missions (11
-- lessons + boss), continuing World II "The Factory" (Acts 4-7).
--
-- Same terminal-engine constraint as Act 4 (no git/build-specific
-- commands exist in apps/web/src/lib/terminal/commands.ts) -- every
-- build artifact here (dependency manifest, lockfile, build-hash
-- comparison, artifact repository index, registry catalog, checksum
-- record, signing log, local dev build log, pipeline run history) is
-- static seeded filesystem content read via `cat`. Purely conceptual
-- topics (build pipelines, registries-vs-repositories, SBOM, build
-- cache, promotion not rebuild) stay multiple_choice.
--
-- Narrative thread: Rook picks up exactly where Act 4 left off -- v12.1.0
-- was tagged and merged but never became a real release. This Act
-- traces that gap from the other direction (the build/artifact side
-- rather than the git side), independently reconfirming the same hole
-- three more times (release history in Act 4, now also the artifact
-- repository index and the registry catalog) before the boss finally
-- explains *why*: the developer built and tested the fix once, by hand,
-- on their own machine -- successfully -- but the pre-push hook that was
-- supposed to trigger the real pipeline (the exact stub Rook already
-- found in Act 4) never fired, so that working local build never became
-- a trustworthy, reproducible, checksummed, signed release artifact.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-artifact-factory', 'world-atlas-artifact-factory', 'artifact-factory', '2B - The Artifact Factory', 'Learn how a tagged commit is supposed to become a trustworthy artifact -- build pipelines, dependencies, lockfiles, reproducible builds, artifact repositories, registries, checksums, SBOM concepts, signing, build cache and promotion -- while Rook traces v12.1.0''s missing release from the factory-floor side.', 2);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-artifact-factory-1', 'campaign-atlas-artifact-factory', 'build-inputs-not-magic', 'Build Inputs, Not Magic', 'Build pipelines, dependencies, lockfiles, reproducible builds, artifact repositories and registries.', 1),
  ('operation-atlas-artifact-factory-2', 'campaign-atlas-artifact-factory', 'proving-what-shipped', 'Proving What Shipped', 'Checksums, SBOM concepts, signing, build cache and promotion instead of rebuilding.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-artifact-factory-01', 'world-atlas-artifact-factory', 'campaign-atlas-artifact-factory', 'operation-atlas-artifact-factory-1', 'build-pipelines', 'Build Pipelines', 'Git proved v12.1.0 exists. It said nothing about how a tag becomes a running system. Rook starts at the other end of that gap.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"build-pipelines-sim"}'::jsonb, '{"xp":190,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-artifact-factory-02', 'world-atlas-artifact-factory', 'campaign-atlas-artifact-factory', 'operation-atlas-artifact-factory-1', 'dependencies', 'Dependencies', 'A build does not start from nothing. Confirm exactly what the collector''s build declares it depends on.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-artifact-factory-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"dependencies-sim"}'::jsonb, '{"xp":190,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-artifact-factory-03', 'world-atlas-artifact-factory', 'campaign-atlas-artifact-factory', 'operation-atlas-artifact-factory-1', 'lockfiles', 'Lockfiles', 'A version range is not a version. Confirm exactly which resolved versions the lockfile actually pins.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-artifact-factory-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"lockfiles-sim"}'::jsonb, '{"xp":200,"credits":35}'::jsonb, false, 3),
  ('mission-atlas-artifact-factory-04', 'world-atlas-artifact-factory', 'campaign-atlas-artifact-factory', 'operation-atlas-artifact-factory-1', 'reproducible-builds', 'Reproducible Builds', 'When the pipeline is actually used, it proves itself. Confirm two independent builds of the same tag produced byte-identical output.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-artifact-factory-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"reproducible-builds-sim"}'::jsonb, '{"xp":200,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-artifact-factory-05', 'world-atlas-artifact-factory', 'campaign-atlas-artifact-factory', 'operation-atlas-artifact-factory-1', 'artifact-repositories', 'Artifact Repositories', 'Release history said nothing was ever built for v12.1.0. Confirm the actual artifact repository agrees.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-artifact-factory-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"artifact-repositories-sim"}'::jsonb, '{"xp":210,"credits":40}'::jsonb, false, 5),
  ('mission-atlas-artifact-factory-06', 'world-atlas-artifact-factory', 'campaign-atlas-artifact-factory', 'operation-atlas-artifact-factory-1', 'registries', 'Registries', 'A repository stores the raw artifact. A registry is what makes it addressable and pullable by name and version. Confirm whether v12.1.0 was ever published to either.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-artifact-factory-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"registries-sim"}'::jsonb, '{"xp":210,"credits":40}'::jsonb, false, 6),
  ('mission-atlas-artifact-factory-07', 'world-atlas-artifact-factory', 'campaign-atlas-artifact-factory', 'operation-atlas-artifact-factory-2', 'checksums', 'Checksums', 'Every artifact that did ship has a recorded checksum proving it has not changed since it was built. Confirm one.', 'beginner', ARRAY['rook','byte'], '{"requiredMissionIds":["mission-atlas-artifact-factory-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"checksums-sim"}'::jsonb, '{"xp":220,"credits":40}'::jsonb, false, 7),
  ('mission-atlas-artifact-factory-08', 'world-atlas-artifact-factory', 'campaign-atlas-artifact-factory', 'operation-atlas-artifact-factory-2', 'sbom-concepts', 'SBOM Concepts', 'If a dependency this build uses turns out to be vulnerable tomorrow, Atlas Division needs to know instantly which artifacts contain it.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-artifact-factory-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"sbom-concepts-sim"}'::jsonb, '{"xp":220,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-artifact-factory-09', 'world-atlas-artifact-factory', 'campaign-atlas-artifact-factory', 'operation-atlas-artifact-factory-2', 'signing', 'Signing', 'A checksum proves an artifact has not changed. A signature proves who actually built it. Confirm the signing record.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-artifact-factory-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"signing-sim"}'::jsonb, '{"xp":230,"credits":45}'::jsonb, false, 9),
  ('mission-atlas-artifact-factory-10', 'world-atlas-artifact-factory', 'campaign-atlas-artifact-factory', 'operation-atlas-artifact-factory-2', 'build-cache', 'Build Cache', 'A cache keyed on the wrong inputs does not save time. It serves stale output and calls it done.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-artifact-factory-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"build-cache-sim"}'::jsonb, '{"xp":230,"credits":45}'::jsonb, false, 10),
  ('mission-atlas-artifact-factory-11', 'world-atlas-artifact-factory', 'campaign-atlas-artifact-factory', 'operation-atlas-artifact-factory-2', 'promotion-not-rebuild', 'Promotion, Not Rebuild', 'The exact artifact that passed testing is what should reach production -- not a fresh build that merely claims to be the same thing.', 'beginner', ARRAY['rook','leena'], '{"requiredMissionIds":["mission-atlas-artifact-factory-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"promotion-not-rebuild-sim"}'::jsonb, '{"xp":240,"credits":45}'::jsonb, false, 11),
  ('mission-atlas-artifact-factory-12', 'world-atlas-artifact-factory', 'campaign-atlas-artifact-factory', 'operation-atlas-artifact-factory-2', 'works-on-my-machine', 'Works on My Machine', 'Everything this Act taught, turned on one fix: not to rebuild it, to finally explain how a change can work perfectly and still never become a real release.', 'boss', ARRAY['rook','leena','byte'], '{"requiredMissionIds":["mission-atlas-artifact-factory-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"works-on-my-machine-boss-sim"}'::jsonb, '{"xp":460,"credits":100,"badgeIds":["works-on-my-machine"],"skillXp":{"cloud_devops_fundamentals":70}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-artifact-factory-01', 1, 'leena', 'Git proved the fix exists. It proved nothing about how a tagged commit is supposed to become a system actually running in production. That is a different machine entirely.'),
  ('mission-atlas-artifact-factory-01', 2, 'rook', 'A build pipeline is that machine -- an automated sequence that fetches the source, resolves dependencies, compiles or packages it, runs its tests, and produces one specific artifact, triggered by an event, not by a person remembering to run it by hand.'),
  ('mission-atlas-artifact-factory-01', 3, 'rook', 'v12.1.0 has a tag. It should have triggered exactly that sequence. Let''s find out whether it actually did.'),

  ('mission-atlas-artifact-factory-02', 1, 'rook', 'No build starts from nothing. It declares what it depends on first -- and those declarations are usually ranges, not exact versions, on purpose.'),

  ('mission-atlas-artifact-factory-03', 1, 'rook', 'A range like ^2.0.0 is a promise, not a version. The lockfile is what actually got resolved and installed the last time this built successfully -- the real, exact versions, pinned.'),

  ('mission-atlas-artifact-factory-04', 1, 'rook', 'A build is reproducible if the same source, the same locked dependencies and the same configuration always produce byte-identical output, no matter who runs it or when. When this pipeline is actually used, it proves exactly that.'),

  ('mission-atlas-artifact-factory-05', 1, 'rook', 'The release history already said nothing was ever built for v12.1.0. That was one system''s record. Let''s check a second, independent one -- the artifact repository itself, the actual place a built artifact would have to land.'),

  ('mission-atlas-artifact-factory-06', 1, 'rook', 'A repository just stores the raw artifact somewhere. A registry is what indexes it -- addressable by name and version, so anything else in Atlas Division can pull it by reference instead of hunting for a file. Two different systems, two more chances to have caught this.'),
  ('mission-atlas-artifact-factory-06', 2, 'byte', 'Neither one has ever heard of v12.1.0. Three independent records now agree on the exact same gap.'),

  ('mission-atlas-artifact-factory-07', 1, 'rook', 'Every artifact that actually shipped carries a recorded checksum -- proof it is bit-for-bit the same thing today as the moment it was built. No checksum, no proof.'),

  ('mission-atlas-artifact-factory-08', 1, 'rook', 'An SBOM is the complete, itemized list of every component and dependency, with exact versions, that went into a built artifact. The day one of those turns out to be vulnerable, this is how Atlas Division finds out which artifacts are actually affected in minutes, not weeks.'),

  ('mission-atlas-artifact-factory-09', 1, 'rook', 'A checksum proves an artifact has not changed. A signature proves who -- or what -- actually built it in the first place. Confirm which artifacts here actually carry one.'),

  ('mission-atlas-artifact-factory-10', 1, 'rook', 'A build cache is only safe if it is keyed on every real input -- source, dependencies, configuration, all of it. Key it on anything less, and it will happily serve yesterday''s output and call it correct.'),

  ('mission-atlas-artifact-factory-11', 1, 'rook', 'The artifact that passed testing is the one that should reach production -- promoted forward unchanged, not rebuilt fresh for every environment on the way there. A second build is never guaranteed to be the first build, no matter how identical the source looks.'),
  ('mission-atlas-artifact-factory-11', 2, 'leena', 'That is the whole point of everything you just learned. Reproducibility is what makes promotion trustworthy in the first place.'),

  ('mission-atlas-artifact-factory-12', 1, 'rook', 'Everything this Act taught you, on one fix. Not to rebuild it -- to finally explain how a change can work, genuinely work, and still never become a real release.'),
  ('mission-atlas-artifact-factory-12', 2, 'byte', 'I have a local build log, a full pipeline run history and every gap we have already confirmed pulled up together. Nothing here was ever broken. Something here was simply never triggered.'),
  ('mission-atlas-artifact-factory-12', 3, 'rook', 'Find the one thing that was supposed to connect a tag landing in git to a pipeline actually starting -- and confirm whether it exists.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-artifact-factory-01-o1', 'mission-atlas-artifact-factory-01', 1, 'Define a build pipeline', 'Choose the accurate description of what a build pipeline actually is.'),

  ('mission-atlas-artifact-factory-02-o1', 'mission-atlas-artifact-factory-02', 1, 'Read the dependency manifest', 'Read the build''s declared dependencies and submit the verification code.'),

  ('mission-atlas-artifact-factory-03-o1', 'mission-atlas-artifact-factory-03', 1, 'Read the lockfile', 'Read the lockfile''s resolved versions and submit the verification code.'),

  ('mission-atlas-artifact-factory-04-o1', 'mission-atlas-artifact-factory-04', 1, 'Confirm reproducibility', 'Compare two independent builds of the same tag and submit the verification code.'),

  ('mission-atlas-artifact-factory-05-o1', 'mission-atlas-artifact-factory-05', 1, 'Check the artifact repository', 'Read the artifact repository index and submit the verification code.'),

  ('mission-atlas-artifact-factory-06-o1', 'mission-atlas-artifact-factory-06', 1, 'Check the registry catalog', 'Read the registry catalog and submit the verification code.'),

  ('mission-atlas-artifact-factory-07-o1', 'mission-atlas-artifact-factory-07', 1, 'Confirm a checksum record', 'Read the checksum record and submit the verification code.'),

  ('mission-atlas-artifact-factory-08-o1', 'mission-atlas-artifact-factory-08', 1, 'Define an SBOM', 'Choose the accurate description of what an SBOM actually records.'),

  ('mission-atlas-artifact-factory-09-o1', 'mission-atlas-artifact-factory-09', 1, 'Confirm a signing record', 'Read the signing log and submit the verification code.'),

  ('mission-atlas-artifact-factory-10-o1', 'mission-atlas-artifact-factory-10', 1, 'Explain safe build caching', 'Choose the accurate description of what a build cache must be keyed on to stay safe.'),

  ('mission-atlas-artifact-factory-11-o1', 'mission-atlas-artifact-factory-11', 1, 'Explain promotion versus rebuilding', 'Choose the accurate description of why the same tested artifact, not a fresh build, should reach production.'),

  ('mission-atlas-artifact-factory-12-o1', 'mission-atlas-artifact-factory-12', 1, 'Read the local dev build log', 'Read the developer''s local build log and submit the verification code.'),
  ('mission-atlas-artifact-factory-12-o2', 'mission-atlas-artifact-factory-12', 2, 'Read the pipeline run history', 'Read the pipeline''s run history and submit the verification code.'),
  ('mission-atlas-artifact-factory-12-o3', 'mission-atlas-artifact-factory-12', 3, 'Identify the root cause', 'Find the evidence that explains why the pipeline never ran for this fix.'),
  ('mission-atlas-artifact-factory-12-o4', 'mission-atlas-artifact-factory-12', 4, 'State the diagnosis', 'Having confirmed all three, explain how a working fix never became a real release.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-artifact-factory-01-o1-c1', 'mission-atlas-artifact-factory-01-o1', 1, 'multiple_choice', 'A build pipeline is best described as...', '{"question":"A build pipeline is best described as...","options":[{"id":"a","text":"An automated sequence -- fetch source, resolve dependencies, build, test, produce an artifact -- triggered by a defined event rather than run by hand each time"},{"id":"b","text":"A single manual command a developer runs locally before every release"},{"id":"c","text":"A synonym for a version control system"},{"id":"d","text":"A dashboard for viewing server metrics"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-artifact-factory-02-o1-c1', 'mission-atlas-artifact-factory-02-o1', 1, 'terminal_simulation', 'Read the build''s declared dependencies and submit the verification code.', '{"instructions":"Read /repo/package-manifest.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/package-manifest.txt":{"type":"file","content":"name: atlas-metrics-agent\ndependencies:\n  libatlas-collect: ^2.0.0\n  atlas-auth-sdk: ~1.4.0\n  json-shim: >=3.1.0\n# verification DEP-6120\n"}}}'::jsonb, '{"requiredFlag":"DEP-6120"}'::jsonb),

  ('mission-atlas-artifact-factory-03-o1-c1', 'mission-atlas-artifact-factory-03-o1', 1, 'terminal_simulation', 'Read the lockfile''s resolved versions and submit the verification code.', '{"instructions":"Read /repo/lockfile.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/lockfile.txt":{"type":"file","content":"libatlas-collect: 2.3.1  (resolved from ^2.0.0)\natlas-auth-sdk: 1.4.2   (resolved from ~1.4.0)\njson-shim: 3.2.0        (resolved from >=3.1.0)\n# verification LOCK-8843\n"}}}'::jsonb, '{"requiredFlag":"LOCK-8843"}'::jsonb),

  ('mission-atlas-artifact-factory-04-o1-c1', 'mission-atlas-artifact-factory-04-o1', 1, 'terminal_simulation', 'Compare two independent builds of the same tag and submit the verification code.', '{"instructions":"Read /repo/build-hashes.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/build-hashes.txt":{"type":"file","content":"build A (ci-runner-3, 2026-06-02): sha256=7f3a9c1e...  atlas-image-v11.4.0.tar.gz\nbuild B (ci-runner-7, 2026-06-02): sha256=7f3a9c1e...  atlas-image-v11.4.0.tar.gz\nidentical hashes -- same source, same locked deps, same output, regardless of which runner built it\n# verification REPRO-3390\n"}}}'::jsonb, '{"requiredFlag":"REPRO-3390"}'::jsonb),

  ('mission-atlas-artifact-factory-05-o1-c1', 'mission-atlas-artifact-factory-05-o1', 1, 'terminal_simulation', 'Read the artifact repository index and submit the verification code.', '{"instructions":"Read /var/atlas-artifacts/index.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-artifacts/index.txt":{"type":"file","content":"atlas-image-v11.4.0.tar.gz       stored 2026-05-01\natlas-image-v12.0.0-test.tar.gz  stored 2026-06-10\n(no entry for v12.1.0)\n# verification ARTREPO-4471\n"}}}'::jsonb, '{"requiredFlag":"ARTREPO-4471"}'::jsonb),

  ('mission-atlas-artifact-factory-06-o1-c1', 'mission-atlas-artifact-factory-06-o1', 1, 'terminal_simulation', 'Read the registry catalog and submit the verification code.', '{"instructions":"Read /var/atlas-artifacts/registry-catalog.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-artifacts/registry-catalog.txt":{"type":"file","content":"atlas-images/atlas-metrics-agent\n  11.4.0       -> pullable\n  12.0.0-test  -> pullable\n  (12.1.0 has never been published)\n# verification REG-5502\n"}}}'::jsonb, '{"requiredFlag":"REG-5502"}'::jsonb),

  ('mission-atlas-artifact-factory-07-o1-c1', 'mission-atlas-artifact-factory-07-o1', 1, 'terminal_simulation', 'Read the checksum record and submit the verification code.', '{"instructions":"Read /var/atlas-artifacts/checksums.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-artifacts/checksums.txt":{"type":"file","content":"atlas-image-v12.0.0-test.tar.gz  sha256=9b1d44ef...\nrecorded checksum matches the artifact repository entry exactly -- unchanged since it was built\n# verification CHECKSUM-2231\n"}}}'::jsonb, '{"requiredFlag":"CHECKSUM-2231"}'::jsonb),

  ('mission-atlas-artifact-factory-08-o1-c1', 'mission-atlas-artifact-factory-08-o1', 1, 'multiple_choice', 'An SBOM (software bill of materials) is best described as...', '{"question":"An SBOM (software bill of materials) is best described as...","options":[{"id":"a","text":"A complete, itemized inventory of every component and dependency, with exact versions, that went into a built artifact"},{"id":"b","text":"A list of every developer who has ever contributed to the repository"},{"id":"c","text":"A pricing invoice for cloud infrastructure usage"},{"id":"d","text":"A synonym for a changelog"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-artifact-factory-09-o1-c1', 'mission-atlas-artifact-factory-09-o1', 1, 'terminal_simulation', 'Read the signing log and submit the verification code.', '{"instructions":"Read /var/atlas-artifacts/signing-log.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-artifacts/signing-log.txt":{"type":"file","content":"atlas-image-v11.4.0.tar.gz        signed  key=atlas-release-2026a\natlas-image-v12.0.0-test.tar.gz   signed  key=atlas-release-2026a\n(v12.1.0 was never built, so it was never signed either)\n# verification SIGN-7714\n"}}}'::jsonb, '{"requiredFlag":"SIGN-7714"}'::jsonb),

  ('mission-atlas-artifact-factory-10-o1-c1', 'mission-atlas-artifact-factory-10-o1', 1, 'multiple_choice', 'A build cache stays safe only when it is keyed on...', '{"question":"A build cache stays safe only when it is keyed on...","options":[{"id":"a","text":"A hash of every real input -- source, locked dependencies and configuration -- so any change forces a real rebuild instead of serving stale output"},{"id":"b","text":"The current date, refreshed once every 24 hours regardless of what changed"},{"id":"c","text":"The name of the developer who last touched the repository"},{"id":"d","text":"Nothing -- caches are always safe to reuse indefinitely"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-artifact-factory-11-o1-c1', 'mission-atlas-artifact-factory-11-o1', 1, 'multiple_choice', 'The same tested artifact should be promoted to production, rather than rebuilt, because...', '{"question":"The same tested artifact should be promoted to production, rather than rebuilt, because...","options":[{"id":"a","text":"A second build is never guaranteed to be identical to the first, so rebuilding risks a subtly different artifact reaching production than the one actually tested"},{"id":"b","text":"Rebuilding is always faster than promoting"},{"id":"c","text":"Promotion is only a naming convention with no real difference from rebuilding"},{"id":"d","text":"Tests only need to run once per developer, not once per artifact"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-artifact-factory-12-o1-c1', 'mission-atlas-artifact-factory-12-o1', 1, 'terminal_simulation', 'Read the developer''s local build log and submit the verification code.', '{"instructions":"Read /repo/dev-build-log.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/dev-build-log.txt":{"type":"file","content":"local build: atlas-image-v12.1.0-dev  (built manually on dev laptop)\nnot checksummed, not signed, never uploaded to the artifact repository\ntests: PASS\nnote: \"works fine on my machine -- will push the tag and let CI pick it up later\"\n# verification LOCAL-9012\n"}}}'::jsonb, '{"requiredFlag":"LOCAL-9012"}'::jsonb),
  ('mission-atlas-artifact-factory-12-o2-c1', 'mission-atlas-artifact-factory-12-o2', 1, 'terminal_simulation', 'Read the pipeline''s run history and submit the verification code.', '{"instructions":"Read /repo/pipeline-runs.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/pipeline-runs.txt":{"type":"file","content":"pipeline runs:\n  v11.4.0       run #204  SUCCESS  2026-05-01\n  v12.0.0-test  run #211  SUCCESS  2026-06-10\n  (no run has ever been recorded for v12.1.0)\n# verification PIPELINE-4471\n"}}}'::jsonb, '{"requiredFlag":"PIPELINE-4471"}'::jsonb),
  ('mission-atlas-artifact-factory-12-o3-c1', 'mission-atlas-artifact-factory-12-o3', 1, 'investigation', 'Which evidence explains why the pipeline never ran for this fix?', '{"evidence":[{"id":"e1","label":"Local dev build log","detail":"The developer built and tested v12.1.0-dev manually on their own laptop and it passed -- but never uploaded, checksummed or signed"},{"id":"e2","label":"Pipeline run history","detail":"No pipeline run has ever been recorded for tag v12.1.0"},{"id":"e3","label":"Pre-push hook (found in Act 4)","detail":"The repository''s pre-push hook, which is supposed to trigger a build on a new tag, is a stub that never fires -- \"TODO: never wired up to the build pipeline\""},{"id":"e4","label":"Dependency and lockfile records","detail":"Both the manifest and the lockfile for this build are complete and internally consistent"}],"question":"Which evidence explains why the pipeline never ran for this fix?"}'::jsonb, '{"requiredEvidenceIds":["e3"]}'::jsonb),
  ('mission-atlas-artifact-factory-12-o4-c1', 'mission-atlas-artifact-factory-12-o4', 1, 'boss_encounter', 'Having confirmed the local build, the missing pipeline run, and the root cause, explain how a working fix never became a real release.', '{"stages":[{"objectiveRef":"mission-atlas-artifact-factory-12-o1","label":"Read the local dev build log"},{"objectiveRef":"mission-atlas-artifact-factory-12-o2","label":"Read the pipeline run history"},{"objectiveRef":"mission-atlas-artifact-factory-12-o3","label":"Identify the root cause"}],"task":"State the diagnosis in one sentence: the developer built and tested the fix once, successfully, by hand on their own machine -- but the pre-push hook that was supposed to turn a new tag into a real pipeline run was the same never-wired stub already found in Act 4, so that working local build never became a reproducible, checksummed, signed release artifact, and v12.1.0 stayed exactly as unreal as it was the moment it was tagged."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-artifact-factory-12-o1","mission-atlas-artifact-factory-12-o2","mission-atlas-artifact-factory-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-artifact-factory-01-o1-c1', 'orientation', 'Think about what triggers it, and what it is not: a person typing a command by hand.', 10, 1),
  ('mission-atlas-artifact-factory-01-o1-c1', 'solution', 'It is an automated, event-triggered sequence: fetch, resolve, build, test, produce an artifact.', 20, 2),

  ('mission-atlas-artifact-factory-02-o1-c1', 'orientation', 'Try: cat /repo/package-manifest.txt', 10, 1),
  ('mission-atlas-artifact-factory-02-o1-c1', 'solution', 'The manifest ends with verification DEP-6120. submit DEP-6120', 20, 2),

  ('mission-atlas-artifact-factory-03-o1-c1', 'orientation', 'Try: cat /repo/lockfile.txt', 10, 1),
  ('mission-atlas-artifact-factory-03-o1-c1', 'solution', 'The lockfile ends with verification LOCK-8843. submit LOCK-8843', 20, 2),

  ('mission-atlas-artifact-factory-04-o1-c1', 'orientation', 'Try: cat /repo/build-hashes.txt', 10, 1),
  ('mission-atlas-artifact-factory-04-o1-c1', 'solution', 'Both builds share the identical hash, verification REPRO-3390. submit REPRO-3390', 20, 2),

  ('mission-atlas-artifact-factory-05-o1-c1', 'orientation', 'Try: cat /var/atlas-artifacts/index.txt', 10, 1),
  ('mission-atlas-artifact-factory-05-o1-c1', 'solution', 'v12.1.0 has no entry, verification ARTREPO-4471. submit ARTREPO-4471', 20, 2),

  ('mission-atlas-artifact-factory-06-o1-c1', 'orientation', 'Try: cat /var/atlas-artifacts/registry-catalog.txt', 10, 1),
  ('mission-atlas-artifact-factory-06-o1-c1', 'solution', '12.1.0 has never been published, verification REG-5502. submit REG-5502', 20, 2),

  ('mission-atlas-artifact-factory-07-o1-c1', 'orientation', 'Try: cat /var/atlas-artifacts/checksums.txt', 10, 1),
  ('mission-atlas-artifact-factory-07-o1-c1', 'solution', 'The checksum matches, verification CHECKSUM-2231. submit CHECKSUM-2231', 20, 2),

  ('mission-atlas-artifact-factory-08-o1-c1', 'orientation', 'Think about what needs to be known instantly the day a dependency turns out to be vulnerable.', 10, 1),
  ('mission-atlas-artifact-factory-08-o1-c1', 'solution', 'An SBOM is a complete, itemized inventory of every component and version in a built artifact.', 20, 2),

  ('mission-atlas-artifact-factory-09-o1-c1', 'orientation', 'Try: cat /var/atlas-artifacts/signing-log.txt', 10, 1),
  ('mission-atlas-artifact-factory-09-o1-c1', 'solution', 'v12.1.0 was never signed either, verification SIGN-7714. submit SIGN-7714', 20, 2),

  ('mission-atlas-artifact-factory-10-o1-c1', 'orientation', 'Ask what happens if the cache key ignores one of the real inputs.', 10, 1),
  ('mission-atlas-artifact-factory-10-o1-c1', 'solution', 'It must be keyed on a hash of every real input, or it will serve stale output.', 20, 2),

  ('mission-atlas-artifact-factory-11-o1-c1', 'orientation', 'Ask whether a second build is guaranteed to be identical to the first.', 10, 1),
  ('mission-atlas-artifact-factory-11-o1-c1', 'solution', 'A rebuild is never guaranteed identical to what was actually tested -- promote the tested artifact instead.', 20, 2),

  ('mission-atlas-artifact-factory-12-o1-c1', 'orientation', 'Try: cat /repo/dev-build-log.txt', 10, 1),
  ('mission-atlas-artifact-factory-12-o1-c1', 'solution', 'The build passed locally but was never uploaded, verification LOCAL-9012. submit LOCAL-9012', 20, 2),
  ('mission-atlas-artifact-factory-12-o2-c1', 'orientation', 'Try: cat /repo/pipeline-runs.txt', 10, 1),
  ('mission-atlas-artifact-factory-12-o2-c1', 'solution', 'No run was ever recorded for v12.1.0, verification PIPELINE-4471. submit PIPELINE-4471', 20, 2),
  ('mission-atlas-artifact-factory-12-o3-c1', 'orientation', 'The local build actually worked. Look for what was supposed to connect that success to the real pipeline.', 10, 1),
  ('mission-atlas-artifact-factory-12-o3-c1', 'solution', 'e3: the pre-push hook was never wired up to trigger a build -- that is why the pipeline never ran.', 20, 2),
  ('mission-atlas-artifact-factory-12-o4-c1', 'orientation', 'Combine the working local build, the missing pipeline run, and the dead hook into one sentence.', 15, 1),
  ('mission-atlas-artifact-factory-12-o4-c1', 'solution', 'The developer''s fix worked, by hand, on their own machine -- but the never-wired pre-push hook meant it was never turned into a reproducible, checksummed, signed release, so v12.1.0 stayed exactly as unreal as the day it was tagged.', 25, 2);
