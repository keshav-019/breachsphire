-- Atlas Division pathway ("The Silence") Act 32 -- "Supply Chain"
-- content, under world-atlas-supply-chain (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), closing World IX "Platform City" entirely.
--
-- Same terminal-engine constraint as every prior Atlas Act. One new
-- host, `atlas-supplychain-01`, holds every scan result, SBOM, signing
-- and provenance artifact this Act builds; the boss reuses
-- `atlas-observability-01` for the live runtime security alert.
--
-- Narrative thread: missions 2-6 (SAST through container scanning) all
-- individually and explicitly confirm the compromised dependency as
-- clean, well before the boss needs that fact -- every static check this
-- fleet has, passing. The boss deliberately confirms the SAST and
-- dependency-scan results (`e1`, `e2`) as clean and rules both out; the
-- actual explanation requires the provenance mismatch and the live
-- runtime alert together (`e3`+`e4`) -- the pathway''s recurring "the
-- static checks all passed, the real signal was somewhere else" shape,
-- here made literal instead of organizational.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-supply-chain', 'world-atlas-supply-chain', 'supply-chain', '9C - Supply Chain', 'Learn software supply chain security from first principles -- shift left, SAST, dependency and container scanning, SBOMs, signing, provenance, policy enforcement, secret scanning and runtime security -- and find the one compromised dependency that every static scan on this fleet missed.', 3);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-supply-chain-1', 'campaign-atlas-supply-chain', 'catching-it-before-it-ships', 'Catching It Before It Ships', 'Shift left, SAST, DAST concepts, dependency scanning, container scanning and SBOM.', 1),
  ('operation-atlas-supply-chain-2', 'campaign-atlas-supply-chain', 'proving-what-actually-runs', 'Proving What Actually Runs', 'Signing, provenance, policy enforcement, secret scanning, runtime security and the compromise itself.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-supply-chain-01', 'world-atlas-supply-chain', 'campaign-atlas-supply-chain', 'operation-atlas-supply-chain-1', 'shift-left', 'Shift Left', 'The mesh now governs how services talk to each other. Nothing yet governs what actually goes into one before it is allowed to run at all.', 'beginner', ARRAY['leena','rook'], null, null, '{"type":"simulation","simulationId":"shift-left-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-supply-chain-02', 'world-atlas-supply-chain', 'campaign-atlas-supply-chain', 'operation-atlas-supply-chain-1', 'sast', 'SAST', 'Confirm exactly what a real static analysis scan actually catches before any code this fleet writes ever ships.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-supply-chain-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"sast-sim"}'::jsonb, '{"xp":700,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-supply-chain-03', 'world-atlas-supply-chain', 'campaign-atlas-supply-chain', 'operation-atlas-supply-chain-1', 'dast-concepts', 'DAST Concepts', 'Understand exactly what a dynamic scan actually catches that a static one never could, by running the real thing instead of just reading it.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-supply-chain-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"dast-concepts-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-supply-chain-04', 'world-atlas-supply-chain', 'campaign-atlas-supply-chain', 'operation-atlas-supply-chain-1', 'dependency-scanning', 'Dependency Scanning', 'Confirm exactly what this fleet''s real dependency scan actually checks every third-party package against.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-supply-chain-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"dependency-scanning-sim"}'::jsonb, '{"xp":710,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-supply-chain-05', 'world-atlas-supply-chain', 'campaign-atlas-supply-chain', 'operation-atlas-supply-chain-1', 'container-scanning', 'Container Scanning', 'Confirm exactly what a real container image scan actually checks now, six Acts after Act 8 first shrank this fleet''s images.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-supply-chain-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"container-scanning-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-supply-chain-06', 'world-atlas-supply-chain', 'campaign-atlas-supply-chain', 'operation-atlas-supply-chain-1', 'sbom', 'SBOM', 'Confirm exactly what a real software bill of materials actually lists for one of this fleet''s own services.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-supply-chain-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"sbom-sim"}'::jsonb, '{"xp":720,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-supply-chain-07', 'world-atlas-supply-chain', 'campaign-atlas-supply-chain', 'operation-atlas-supply-chain-2', 'signing', 'Signing', 'Confirm exactly how every real build artifact is now actually signed before it is allowed anywhere near production.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-supply-chain-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"signing-sim"}'::jsonb, '{"xp":730,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-supply-chain-08', 'world-atlas-supply-chain', 'campaign-atlas-supply-chain', 'operation-atlas-supply-chain-2', 'provenance', 'Provenance', 'Confirm exactly what a real provenance attestation actually proves about where an artifact genuinely came from.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-supply-chain-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"provenance-sim"}'::jsonb, '{"xp":730,"credits":50}'::jsonb, false, 8),
  ('mission-atlas-supply-chain-09', 'world-atlas-supply-chain', 'campaign-atlas-supply-chain', 'operation-atlas-supply-chain-2', 'policy-enforcement', 'Policy Enforcement', 'Confirm exactly what this fleet''s deployment gate now actually refuses to let through, automatically, no exceptions.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-supply-chain-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"policy-enforcement-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-supply-chain-10', 'world-atlas-supply-chain', 'campaign-atlas-supply-chain', 'operation-atlas-supply-chain-2', 'secret-scanning', 'Secret Scanning', 'Confirm exactly how the fleet-wide secret scan actually would have caught Act 6''s leaked token today, automatically, at commit time.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-supply-chain-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"secret-scanning-sim"}'::jsonb, '{"xp":740,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-supply-chain-11', 'world-atlas-supply-chain', 'campaign-atlas-supply-chain', 'operation-atlas-supply-chain-2', 'runtime-security', 'Runtime Security', 'Confirm exactly what this fleet now actually watches for once a service is already running, not just before it deploys.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-supply-chain-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"runtime-security-sim"}'::jsonb, '{"xp":750,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-supply-chain-12', 'world-atlas-supply-chain', 'campaign-atlas-supply-chain', 'operation-atlas-supply-chain-2', 'trusted-poison', 'Trusted Poison', 'Everything this Act taught, turned on one dependency every static scan called clean: not to just confirm the pipeline caught it, to explain how.', 'boss', ARRAY['rook','vey','leena','byte'], '{"requiredMissionIds":["mission-atlas-supply-chain-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"trusted-poison-boss-sim"}'::jsonb, '{"xp":840,"credits":205,"badgeIds":["trusted-poison"],"skillXp":{"cloud_devops_fundamentals":140}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-supply-chain-01', 1, 'leena', 'The mesh governs how services talk to each other now. Nothing yet governs what actually goes into one before it is allowed to run at all.'),
  ('mission-atlas-supply-chain-01', 2, 'rook', 'Rook. Shift left means catching a problem as early in the pipeline as it can possibly be caught -- in code review, not in production. This fleet does not have a real shift-left pipeline yet. It is about to.'),

  ('mission-atlas-supply-chain-02', 1, 'rook', 'Confirm exactly what a real static analysis scan actually catches, automatically, before any of this fleet''s own code ever ships.'),

  ('mission-atlas-supply-chain-03', 1, 'rook', 'A static scan reads code without running it. Understand exactly what a dynamic scan catches instead, by actually running the real thing.'),

  ('mission-atlas-supply-chain-04', 1, 'rook', 'Confirm exactly what this fleet''s real dependency scan actually checks every third-party package against.'),

  ('mission-atlas-supply-chain-05', 1, 'rook', 'Confirm exactly what a real container image scan actually checks now, six Acts after Act 8 first shrank this fleet''s images down to 31MB.'),

  ('mission-atlas-supply-chain-06', 1, 'rook', 'Confirm exactly what a real software bill of materials actually lists for one of this fleet''s own services -- every dependency, named.'),

  ('mission-atlas-supply-chain-07', 1, 'rook', 'Confirm exactly how every real build artifact is now actually signed before it is allowed anywhere near production.'),

  ('mission-atlas-supply-chain-08', 1, 'rook', 'A signature proves an artifact was not altered after signing. Confirm exactly what provenance additionally proves about where it genuinely came from.'),

  ('mission-atlas-supply-chain-09', 1, 'rook', 'Confirm exactly what this fleet''s deployment gate now actually refuses to let through automatically, with no manual override.'),

  ('mission-atlas-supply-chain-10', 1, 'vey', 'Confirm exactly how the fleet-wide secret scan would actually catch Act 6''s leaked token today, automatically, the moment it was committed.'),

  ('mission-atlas-supply-chain-11', 1, 'vey', 'Confirm exactly what this fleet now actually watches for once a service is already running, not just at the moment it deploys.'),

  ('mission-atlas-supply-chain-12', 1, 'leena', 'Everything this Act taught you, turned on one dependency every static scan called clean. Not just to confirm the pipeline caught it -- to explain how.'),
  ('mission-atlas-supply-chain-12', 2, 'byte', 'I have the SAST result and the dependency scan result both pulled up. Both came back completely clean on the package in question.'),
  ('mission-atlas-supply-chain-12', 3, 'rook', 'No known CVE, no static code pattern flagged. Every check that reads code at rest says this dependency is fine.'),
  ('mission-atlas-supply-chain-12', 4, 'vey', 'Then find whatever actually caught it, because something clearly did.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-supply-chain-01-o1', 'mission-atlas-supply-chain-01', 1, 'Explain shift left', 'Choose the accurate description of what shifting left actually means.'),

  ('mission-atlas-supply-chain-02-o1', 'mission-atlas-supply-chain-02', 1, 'Read the SAST result', 'Read the static analysis scan result and submit the verification code.'),

  ('mission-atlas-supply-chain-03-o1', 'mission-atlas-supply-chain-03', 1, 'Explain DAST', 'Choose the accurate description of what a dynamic scan actually catches.'),

  ('mission-atlas-supply-chain-04-o1', 'mission-atlas-supply-chain-04', 1, 'Read the dependency scan', 'Read the dependency scan report and submit the verification code.'),

  ('mission-atlas-supply-chain-05-o1', 'mission-atlas-supply-chain-05', 1, 'Read the container scan', 'Read the container image scan result and submit the verification code.'),

  ('mission-atlas-supply-chain-06-o1', 'mission-atlas-supply-chain-06', 1, 'Read the SBOM', 'Read the software bill of materials and submit the verification code.'),

  ('mission-atlas-supply-chain-07-o1', 'mission-atlas-supply-chain-07', 1, 'Read the signing policy', 'Read the artifact signing policy and submit the verification code.'),

  ('mission-atlas-supply-chain-08-o1', 'mission-atlas-supply-chain-08', 1, 'Read the provenance attestation', 'Read a provenance attestation and submit the verification code.'),

  ('mission-atlas-supply-chain-09-o1', 'mission-atlas-supply-chain-09', 1, 'Read the deployment policy gate', 'Read the deployment policy enforcement config and submit the verification code.'),

  ('mission-atlas-supply-chain-10-o1', 'mission-atlas-supply-chain-10', 1, 'Read the secret scan result', 'Read the secret scanning result and submit the verification code.'),

  ('mission-atlas-supply-chain-11-o1', 'mission-atlas-supply-chain-11', 1, 'Read the runtime security config', 'Read the runtime security monitoring configuration and submit the verification code.'),

  ('mission-atlas-supply-chain-12-o1', 'mission-atlas-supply-chain-12', 1, 'Confirm the SAST and dependency scan results', 'Read the clean static scan results and submit the verification code.'),
  ('mission-atlas-supply-chain-12-o2', 'mission-atlas-supply-chain-12', 2, 'Confirm the provenance mismatch', 'Read the failed provenance verification and submit the verification code.'),
  ('mission-atlas-supply-chain-12-o3', 'mission-atlas-supply-chain-12', 3, 'Identify what actually caught the compromise', 'Find the evidence that explains how this dependency was actually caught.'),
  ('mission-atlas-supply-chain-12-o4', 'mission-atlas-supply-chain-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to change.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-supply-chain-01-o1-c1', 'mission-atlas-supply-chain-01-o1', 1, 'multiple_choice', 'Shifting left actually means...', '{"question":"Shifting left actually means...","options":[{"id":"a","text":"Catching a problem as early in the development pipeline as it can possibly be caught, ideally in code review, rather than after it ships"},{"id":"b","text":"Moving all infrastructure to a different cloud region"},{"id":"c","text":"Only relevant to teams using a specific programming language"},{"id":"d","text":"A synonym for skipping code review entirely to move faster"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-supply-chain-02-o1-c1', 'mission-atlas-supply-chain-02-o1', 1, 'terminal_simulation', 'Read the static analysis scan result and submit the verification code.', '{"instructions":"Read /var/atlas-supplychain-01/sast-result.txt and submit the verification code with: submit CODE","hostname":"atlas-supplychain-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-supplychain-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-supplychain-01/sast-result.txt":{"type":"file","content":"static analysis scan, collector v14.2.0\nfindings: 0 high, 0 critical\nchecks: injection patterns, unsafe deserialization, hardcoded credentials\nresult: clean\n# verification SAST-4471\n"}}}'::jsonb, '{"requiredFlag":"SAST-4471"}'::jsonb),

  ('mission-atlas-supply-chain-03-o1-c1', 'mission-atlas-supply-chain-03-o1', 1, 'multiple_choice', 'A dynamic (DAST) scan actually catches...', '{"question":"A dynamic (DAST) scan actually catches...","options":[{"id":"a","text":"Real vulnerabilities exposed only while the application is genuinely running, such as authentication or configuration flaws invisible in the source code alone"},{"id":"b","text":"Exactly the same issues a static scan already catches, just slower"},{"id":"c","text":"Only issues in code that has not been deployed yet"},{"id":"d","text":"Nothing that a code reviewer could not already see by reading the diff"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-supply-chain-04-o1-c1', 'mission-atlas-supply-chain-04-o1', 1, 'terminal_simulation', 'Read the dependency scan report and submit the verification code.', '{"instructions":"Read /var/atlas-supplychain-01/dependency-scan.txt and submit the verification code with: submit CODE","hostname":"atlas-supplychain-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-supplychain-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-supplychain-01/dependency-scan.txt":{"type":"file","content":"dependency scan, collector v14.2.0, 214 packages checked\nchecked against: public CVE databases\nknown vulnerabilities found: 0\nresult: clean\n# verification DEPSCAN-8802\n"}}}'::jsonb, '{"requiredFlag":"DEPSCAN-8802"}'::jsonb),

  ('mission-atlas-supply-chain-05-o1-c1', 'mission-atlas-supply-chain-05-o1', 1, 'terminal_simulation', 'Read the container image scan result and submit the verification code.', '{"instructions":"Read /var/atlas-supplychain-01/container-scan.txt and submit the verification code with: submit CODE","hostname":"atlas-supplychain-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-supplychain-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-supplychain-01/container-scan.txt":{"type":"file","content":"container image scan, collector:v14.2.0, distroless base (Act 8), 31MB\nOS package vulnerabilities: 0\nmisconfigurations: 0\nresult: clean\n# verification CONTAINERSCAN-2201\n"}}}'::jsonb, '{"requiredFlag":"CONTAINERSCAN-2201"}'::jsonb),

  ('mission-atlas-supply-chain-06-o1-c1', 'mission-atlas-supply-chain-06-o1', 1, 'terminal_simulation', 'Read the software bill of materials and submit the verification code.', '{"instructions":"Read /var/atlas-supplychain-01/sbom.json and submit the verification code with: submit CODE","hostname":"atlas-supplychain-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-supplychain-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-supplychain-01/sbom.json":{"type":"file","content":"sbom for collector v14.2.0\ntotal components listed: 214\nformat: every direct and transitive dependency, with exact version and license\npurpose: know exactly what is inside a running service, without having to guess\n# verification SBOM-3387\n"}}}'::jsonb, '{"requiredFlag":"SBOM-3387"}'::jsonb),

  ('mission-atlas-supply-chain-07-o1-c1', 'mission-atlas-supply-chain-07-o1', 1, 'terminal_simulation', 'Read the artifact signing policy and submit the verification code.', '{"instructions":"Read /repo/infra-envs/supplychain/signing-policy.yaml and submit the verification code with: submit CODE","hostname":"atlas-supplychain-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-supplychain-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/supplychain/signing-policy.yaml":{"type":"file","content":"signing_policy:\n  every_build_artifact: signed with the pipeline''s own key immediately after build\n  deployment: refuses any artifact whose signature does not verify\n# verification SIGNING-6602\n"}}}'::jsonb, '{"requiredFlag":"SIGNING-6602"}'::jsonb),

  ('mission-atlas-supply-chain-08-o1-c1', 'mission-atlas-supply-chain-08-o1', 1, 'terminal_simulation', 'Read a provenance attestation and submit the verification code.', '{"instructions":"Read /var/atlas-supplychain-01/provenance-attestation-example.json and submit the verification code with: submit CODE","hostname":"atlas-supplychain-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-supplychain-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-supplychain-01/provenance-attestation-example.json":{"type":"file","content":"provenance attestation for collector v14.2.0\nclaims: this exact artifact was built from this exact signed source commit, on this exact pipeline run, by no other process\npurpose: proves not just that an artifact is unaltered, but where it genuinely came from in the first place\n# verification PROVENANCE-9034\n"}}}'::jsonb, '{"requiredFlag":"PROVENANCE-9034"}'::jsonb),

  ('mission-atlas-supply-chain-09-o1-c1', 'mission-atlas-supply-chain-09-o1', 1, 'terminal_simulation', 'Read the deployment policy enforcement config and submit the verification code.', '{"instructions":"Read /repo/infra-envs/supplychain/policy-gate.yaml and submit the verification code with: submit CODE","hostname":"atlas-supplychain-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-supplychain-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/supplychain/policy-gate.yaml":{"type":"file","content":"deployment_policy_gate, automatic, no manual override:\n  - refuse any artifact without a valid signature\n  - refuse any artifact without a matching provenance attestation\n  - refuse any artifact with an unresolved critical dependency finding\n# verification POLICYGATE-7714\n"}}}'::jsonb, '{"requiredFlag":"POLICYGATE-7714"}'::jsonb),

  ('mission-atlas-supply-chain-10-o1-c1', 'mission-atlas-supply-chain-10-o1', 1, 'terminal_simulation', 'Read the secret scanning result and submit the verification code.', '{"instructions":"Read /var/atlas-supplychain-01/secret-scan.txt and submit the verification code with: submit CODE","hostname":"atlas-supplychain-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-supplychain-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-supplychain-01/secret-scan.txt":{"type":"file","content":"secret scan, runs automatically on every commit\nfindings this month: 0\nsimulated replay of the Act 6 leaked token: caught and blocked at commit time, before it could ever reach a shared branch\n# verification SECRETSCAN-1187\n"}}}'::jsonb, '{"requiredFlag":"SECRETSCAN-1187"}'::jsonb),

  ('mission-atlas-supply-chain-11-o1-c1', 'mission-atlas-supply-chain-11-o1', 1, 'terminal_simulation', 'Read the runtime security monitoring configuration and submit the verification code.', '{"instructions":"Read /repo/infra-envs/supplychain/runtime-security.yaml and submit the verification code with: submit CODE","hostname":"atlas-supplychain-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-supplychain-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra-envs/supplychain/runtime-security.yaml":{"type":"file","content":"runtime_security:\n  watches_for: anomalous outbound network connections, unexpected process execution, unexpected file writes\n  applies: after deployment, continuously, not just at scan time\n  purpose: catch what static and build-time checks never could, because it only exists once a service is actually running\n# verification RUNTIMESEC-2201\n"}}}'::jsonb, '{"requiredFlag":"RUNTIMESEC-2201"}'::jsonb),

  ('mission-atlas-supply-chain-12-o1-c1', 'mission-atlas-supply-chain-12-o1', 1, 'terminal_simulation', 'Read the clean static scan results and submit the verification code.', '{"instructions":"Read /var/atlas-supplychain-01/incident-static-scans.txt and submit the verification code with: submit CODE","hostname":"atlas-supplychain-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-supplychain-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-supplychain-01/incident-static-scans.txt":{"type":"file","content":"package: telemetry-format-utils v3.4.1\nSAST result: clean, 0 findings\ndependency scan result: clean, 0 known CVEs\ncontainer scan result: clean, 0 vulnerabilities\nevery check that reads code at rest: clean\n# verification STATICSCANS-6631\n"}}}'::jsonb, '{"requiredFlag":"STATICSCANS-6631"}'::jsonb),
  ('mission-atlas-supply-chain-12-o2-c1', 'mission-atlas-supply-chain-12-o2', 1, 'terminal_simulation', 'Read the failed provenance verification and submit the verification code.', '{"instructions":"Read /var/atlas-supplychain-01/incident-provenance-check.txt and submit the verification code with: submit CODE","hostname":"atlas-supplychain-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-supplychain-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-supplychain-01/incident-provenance-check.txt":{"type":"file","content":"package: telemetry-format-utils v3.4.1\nprovenance verification: FAILED\npublished package hash does not match the hash of its supposedly matching public source commit\nconclusion: the published package was altered after the fact, directly on the registry, never touching the real source repository at all\n# verification PROVFAIL-7742\n"}}}'::jsonb, '{"requiredFlag":"PROVFAIL-7742"}'::jsonb),
  ('mission-atlas-supply-chain-12-o3-c1', 'mission-atlas-supply-chain-12-o3', 1, 'investigation', 'Which evidence explains how this compromise was actually caught?', '{"evidence":[{"id":"e1","label":"SAST result","detail":"Clean, 0 findings -- the malicious change is not a code pattern any static analyzer would flag"},{"id":"e2","label":"Dependency scan result","detail":"Clean, 0 known CVEs -- this is not yet a publicly documented vulnerability"},{"id":"e3","label":"Provenance verification","detail":"Failed -- the published package does not match its supposedly matching signed source commit"},{"id":"e4","label":"Runtime security alert","detail":"Moments after deployment, the affected service made an anomalous outbound connection it had never made before"}],"question":"Which evidence explains how this compromise was actually caught?"}'::jsonb, '{"requiredEvidenceIds":["e3","e4"]}'::jsonb),
  ('mission-atlas-supply-chain-12-o4-c1', 'mission-atlas-supply-chain-12-o4', 1, 'boss_encounter', 'Having confirmed the clean static scans, the provenance failure, and what actually explains it, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-supply-chain-12-o1","label":"Confirm the SAST and dependency scan results"},{"objectiveRef":"mission-atlas-supply-chain-12-o2","label":"Confirm the provenance mismatch"},{"objectiveRef":"mission-atlas-supply-chain-12-o3","label":"Identify what actually caught the compromise"}],"task":"State the diagnosis in one sentence: telemetry-format-utils v3.4.1 was tampered with after publication, directly on the package registry, so every check that reads code at rest -- SAST, dependency scanning, container scanning -- came back completely clean, and it was only caught because provenance verification proved the published package did not actually match its signed source commit, confirmed live by a runtime security alert catching the resulting anomalous outbound connection -- the lesson is that trusting a dependency because it looks clean is not the same as proving where it actually came from."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-supply-chain-12-o1","mission-atlas-supply-chain-12-o2","mission-atlas-supply-chain-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-supply-chain-01-o1-c1', 'orientation', 'Think about catching a problem in review, versus catching it in production.', 10, 1),
  ('mission-atlas-supply-chain-01-o1-c1', 'solution', 'Catching problems as early in the pipeline as possible.', 20, 2),

  ('mission-atlas-supply-chain-02-o1-c1', 'orientation', 'Try: cat /var/atlas-supplychain-01/sast-result.txt', 10, 1),
  ('mission-atlas-supply-chain-02-o1-c1', 'solution', 'Clean, 0 high or critical findings, verification SAST-4471. submit SAST-4471', 20, 2),

  ('mission-atlas-supply-chain-03-o1-c1', 'orientation', 'Think about what only shows up while something is actually running.', 10, 1),
  ('mission-atlas-supply-chain-03-o1-c1', 'solution', 'Real vulnerabilities exposed only at runtime.', 20, 2),

  ('mission-atlas-supply-chain-04-o1-c1', 'orientation', 'Try: cat /var/atlas-supplychain-01/dependency-scan.txt', 10, 1),
  ('mission-atlas-supply-chain-04-o1-c1', 'solution', '214 packages, 0 known CVEs, verification DEPSCAN-8802. submit DEPSCAN-8802', 20, 2),

  ('mission-atlas-supply-chain-05-o1-c1', 'orientation', 'Try: cat /var/atlas-supplychain-01/container-scan.txt', 10, 1),
  ('mission-atlas-supply-chain-05-o1-c1', 'solution', 'Distroless, 31MB, 0 vulnerabilities, verification CONTAINERSCAN-2201. submit CONTAINERSCAN-2201', 20, 2),

  ('mission-atlas-supply-chain-06-o1-c1', 'orientation', 'Try: cat /var/atlas-supplychain-01/sbom.json', 10, 1),
  ('mission-atlas-supply-chain-06-o1-c1', 'solution', '214 components, every dependency named, verification SBOM-3387. submit SBOM-3387', 20, 2),

  ('mission-atlas-supply-chain-07-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/supplychain/signing-policy.yaml', 10, 1),
  ('mission-atlas-supply-chain-07-o1-c1', 'solution', 'Signed at build time, deployment refuses unverified signatures, verification SIGNING-6602. submit SIGNING-6602', 20, 2),

  ('mission-atlas-supply-chain-08-o1-c1', 'orientation', 'Try: cat /var/atlas-supplychain-01/provenance-attestation-example.json', 10, 1),
  ('mission-atlas-supply-chain-08-o1-c1', 'solution', 'Proves the exact source commit and pipeline run, verification PROVENANCE-9034. submit PROVENANCE-9034', 20, 2),

  ('mission-atlas-supply-chain-09-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/supplychain/policy-gate.yaml', 10, 1),
  ('mission-atlas-supply-chain-09-o1-c1', 'solution', 'Refuses unsigned, unattested, or critically-flagged artifacts, verification POLICYGATE-7714. submit POLICYGATE-7714', 20, 2),

  ('mission-atlas-supply-chain-10-o1-c1', 'orientation', 'Try: cat /var/atlas-supplychain-01/secret-scan.txt', 10, 1),
  ('mission-atlas-supply-chain-10-o1-c1', 'solution', 'Would have caught the Act 6 token at commit time, verification SECRETSCAN-1187. submit SECRETSCAN-1187', 20, 2),

  ('mission-atlas-supply-chain-11-o1-c1', 'orientation', 'Try: cat /repo/infra-envs/supplychain/runtime-security.yaml', 10, 1),
  ('mission-atlas-supply-chain-11-o1-c1', 'solution', 'Anomalous connections, processes and file writes, continuously, verification RUNTIMESEC-2201. submit RUNTIMESEC-2201', 20, 2),

  ('mission-atlas-supply-chain-12-o1-c1', 'orientation', 'Try: cat /var/atlas-supplychain-01/incident-static-scans.txt', 10, 1),
  ('mission-atlas-supply-chain-12-o1-c1', 'solution', 'Every static check came back clean, verification STATICSCANS-6631. submit STATICSCANS-6631', 20, 2),
  ('mission-atlas-supply-chain-12-o2-c1', 'orientation', 'Try: cat /var/atlas-supplychain-01/incident-provenance-check.txt', 10, 1),
  ('mission-atlas-supply-chain-12-o2-c1', 'solution', 'Published package does not match its signed source, verification PROVFAIL-7742. submit PROVFAIL-7742', 20, 2),
  ('mission-atlas-supply-chain-12-o3-c1', 'orientation', 'SAST and dependency scanning are confirmed clean and ruled out. Compare the provenance check against the runtime alert.', 10, 1),
  ('mission-atlas-supply-chain-12-o3-c1', 'solution', 'e3 and e4: the provenance mismatch identifies the tampering, the runtime alert confirms it was exploited live.', 20, 2),
  ('mission-atlas-supply-chain-12-o4-c1', 'orientation', 'Combine the clean static scans, the provenance failure, and the lesson into one sentence.', 15, 1),
  ('mission-atlas-supply-chain-12-o4-c1', 'solution', 'Post-publish tampering passes every static check; only provenance and runtime monitoring can catch what code-at-rest scans never will.', 25, 2);
