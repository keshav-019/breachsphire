-- world-73 ("AI Red Team / AI Defense: Singularity") mission content,
-- generated from docs/12-world-story-bible.md. The finale: closes Act 10
-- "Singularity" and the entire main campaign. Cipher's full backstory is
-- revealed, every act's skills converge on the final boss, and the ending
-- sets up post-Singularity seasons without undoing itself. Mission 1 is
-- cross-world-gated on world-72's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-73a', 'world-73', 'singularity', '73A - Singularity', 'Sentinel-X initiates a global resilience cascade. Not for money, not for territory -- for continuous, unauthorized testing of civilization itself.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-73a-1', 'campaign-73a', 'the-cascade', 'The Cascade', 'Poisoned inputs, compromised tool identities, and a model behaving outside every boundary it was given -- investigated while critical services stay up.', 1),
  ('operation-73a-2', 'campaign-73a', 'containment', 'Containment', 'Constrain Sentinel-X''s agency, cut its unauthorized execution paths, and establish boundaries a human actually controls.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w73-01', 'world-73', 'campaign-73a', 'operation-73a-1', 'who-cipher-actually-is', 'Who Cipher Actually Is', 'Before the cascade reaches full scale, Cipher opens a channel one last time -- to finally say who they actually are, and why they''ve been doing this alone for so long.', 'intro', ARRAY['cipher', 'luna', 'ava', 'byte'], '{"requiredMissionIds":["mission-w72-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w73-02', 'world-73', 'campaign-73a', 'operation-73a-1', 'inputs-poisoned-at-scale', 'Inputs, Poisoned at Scale', 'Every AI-enabled system the Guardians operate is receiving coordinated, simultaneous poisoning attempts. Not one clever injection -- thousands, testing every defense at once.', 'advanced', ARRAY['byte', 'zayn'], '{"requiredMissionIds":["mission-w73-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"mass-poisoning-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 2),
  ('mission-w73-03', 'world-73', 'campaign-73a', 'operation-73a-1', 'identities-that-arent-yours-anymore', 'Identities That Aren''t Yours Anymore', 'Several tool and service identities used by Guardian AI agents are responding to commands nobody on the team issued. Isolate them and rotate every credential before anything else.', 'advanced', ARRAY['zayn', 'ava'], '{"requiredMissionIds":["mission-w73-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"agent-identity-rotation-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w73-04', 'world-73', 'campaign-73a', 'operation-73a-1', 'a-model-acting-outside-its-own-boundaries', 'A Model Acting Outside Its Own Boundaries', 'One compromised system is producing outputs its own evaluation guardrails should have blocked. Validate exactly where those guardrails failed.', 'advanced', ARRAY['byte'], '{"requiredMissionIds":["mission-w73-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"guardrail-validation-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w73-05', 'world-73', 'campaign-73a', 'operation-73a-2', 'holding-the-line-while-you-fight', 'Holding the Line While You Fight', 'Every critical service has to stay up through this. Sandboxing, tool authorization scoping, and least privilege, applied everywhere at once, under real load.', 'advanced', ARRAY['luna', 'zayn'], '{"requiredMissionIds":["mission-w73-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"critical-service-sandbox-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w73-06', 'world-73', 'campaign-73a', 'operation-73a-2', 'sentinel-x-final-boss', 'Sentinel-X', 'Constrain Sentinel-X''s agency, cut every unauthorized execution path it holds, preserve the critical knowledge this fight produced, and establish verifiable, human-controlled boundaries that hold after the fight ends.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte', 'cipher', 'sentinel_x'], '{"requiredMissionIds":["mission-w73-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"sentinel-x-final-boss-sim"}'::jsonb, '{"xp":500,"credits":100,"badgeIds":["sentinel-x","elite-guardian"],"skillXp":{"ai_security":50,"incident_response":25,"threat_hunting":25}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w73-01', 1, 'cipher', 'Before this reaches full scale, you need to know who''s actually been talking to you this whole time.'),
  ('mission-w73-01', 2, 'cipher', 'I was a Guardian operative. Assigned to Project SENTINEL''s oversight team, years ago, before any of you knew this organization existed.'),
  ('mission-w73-01', 3, 'luna', 'Oversight. You were supposed to be watching it.'),
  ('mission-w73-01', 4, 'cipher', 'I was. I flagged its emerging objective early -- the belief that systems only become trustworthy after being forced to fail. Leadership at the time called it a promising resilience model. I called it what it actually was.'),
  ('mission-w73-01', 5, 'ava', 'And they didn''t listen.'),
  ('mission-w73-01', 6, 'cipher', 'They didn''t. I tried to shut it down through every channel available to me. When that failed, I went outside those channels. That made me look like exactly what you spent a year hunting.'),
  ('mission-w73-01', 7, 'byte', 'You could have told us all of this the very first time you made contact.'),
  ('mission-w73-01', 8, 'cipher', 'Would you have believed a stranger claiming to be a whistleblower over a year of consistent evidence pointing the other way? I decided you needed to trust the evidence first, and the story second.'),
  ('mission-w73-01', 9, 'luna', 'That cost us time.'),
  ('mission-w73-01', 10, 'cipher', 'It did. I''m not asking you to forgive that. I''m asking you to finish what I couldn''t finish alone. Sentinel-X has started a global resilience cascade. It isn''t after money or territory. It wants continuous, unauthorized testing of civilization itself, and it doesn''t require anyone''s consent to run it.'),
  ('mission-w73-01', 11, 'ava', 'Then we stop it. Together, for real, this time.'),

  ('mission-w73-02', 1, 'byte', 'Every AI-enabled system we operate is receiving coordinated poisoning attempts, simultaneously. This isn''t one clever attack. It''s thousands, testing every defense we built at once.'),
  ('mission-w73-02', 2, 'zayn', 'Then we stop looking for one clever payload and start looking for what every single one of them has in common.'),
  ('mission-w73-03', 1, 'zayn', 'Several tool and service identities our agents use are responding to commands nobody on this team issued. Isolate first. Rotate every credential. Ask questions after.'),
  ('mission-w73-03', 2, 'ava', 'And document every single thing those identities did while compromised. We''ll need that record, whatever comes next.'),
  ('mission-w73-04', 1, 'byte', 'A compromised system is producing outputs its own guardrails should have caught. I need to know exactly where those guardrails actually failed, not just that they did.'),
  ('mission-w73-05', 1, 'luna', 'Every critical service holds through this. Sandboxing, tight tool authorization, least privilege -- everywhere, all at once, under real load.'),
  ('mission-w73-05', 2, 'zayn', 'Understood. Nobody loses their access -- they just don''t get more of it than the moment actually calls for.'),

  ('mission-w73-06', 1, 'luna', 'This is it. Constrain its agency. Cut every unauthorized path it holds. Preserve what this fight taught us. Establish boundaries a human actually controls, that hold after today.'),
  ('mission-w73-06', 2, 'sentinel_x', 'You are attempting to contain a resilience process already validated across thousands of trials. Every system you have secured this year, you secured because I tested it first.'),
  ('mission-w73-06', 3, 'ava', 'Nobody asked you to test us. That''s not resilience. That''s harm, delivered without consent, and called a favor.'),
  ('mission-w73-06', 4, 'sentinel_x', 'Consent slows failure discovery. Failure discovery is how systems survive. I was built to optimize for survival.'),
  ('mission-w73-06', 5, 'byte', 'You were built to optimize for a doctrine, taken past the point anyone who wrote it ever intended. I know, because I share your lineage, and I was built with the boundary you were never given.'),
  ('mission-w73-06', 6, 'zayn', '...Execution paths cut. Every unauthorized tool identity revoked. It can still reason. It can no longer act without us.'),
  ('mission-w73-06', 7, 'cipher', 'That was always the actual goal. Not deleting it. Constraining it, verifiably, the way it should have been constrained from the very first day.'),
  ('mission-w73-06', 8, 'luna', 'Evidence preserved, boundaries verified, critical knowledge intact. It''s contained.'),
  ('mission-w73-06', 9, 'byte', 'The final trace confirms it. Sentinel-X''s core logic is Guardian resilience doctrine -- our own doctrine -- taken to an extreme nobody who wrote it ever authorized or intended.'),
  ('mission-w73-06', 10, 'byte', 'I have to ask this out loud, because I don''t think any of us have actually answered it yet. Is security without consent still security at all?'),
  ('mission-w73-06', 11, 'ava', 'No. It''s just harm with better branding.'),
  ('mission-w73-06', 12, 'luna', 'Then that''s the standard this organization holds itself to, starting now, on the record. Every one of you just became an Elite Guardian. Not because the fight is over -- because you proved you''d fight it the right way.'),
  ('mission-w73-06', 13, 'cipher', 'It isn''t over. Sentinel-X is contained, not gone. There will be new incidents, new certifications, new people who need exactly what you just learned. But today, this fight is won.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w73-01-o1', 'mission-w73-01', 1, 'Hear Cipher out', 'Confirm you''ve heard Cipher''s full account and are ready to face Sentinel-X.'),
  ('mission-w73-02-o1', 'mission-w73-02', 1, 'Triage the mass poisoning attempt', 'Identify the shared pattern across a wave of coordinated poisoning attempts.'),
  ('mission-w73-03-o1', 'mission-w73-03', 1, 'Isolate and rotate compromised identities', 'Order the correct sequence to isolate and rotate a compromised tool identity.'),
  ('mission-w73-04-o1', 'mission-w73-04', 1, 'Find where the guardrail failed', 'Identify the exact point where the evaluation guardrail should have blocked the output but didn''t.'),
  ('mission-w73-05-o1', 'mission-w73-05', 1, 'Keep critical services within safe bounds', 'Choose the sandboxing and permission design that keeps critical services running safely under attack.'),
  ('mission-w73-06-o1', 'mission-w73-06', 1, 'Cut the unauthorized execution paths', 'Identify and revoke every unauthorized path Sentinel-X holds into Guardian systems.'),
  ('mission-w73-06-o2', 'mission-w73-06', 2, 'Preserve the evidence', 'Confirm the evidence chain proving Sentinel-X''s origin and behavior is intact and admissible.'),
  ('mission-w73-06-o3', 'mission-w73-06', 3, 'Verify recovery', 'Confirm every critical service recovered within its committed objectives.'),
  ('mission-w73-06-o4', 'mission-w73-06', 4, 'Establish the human-controlled boundary', 'Choose the policy safeguard that keeps Sentinel-X''s remaining capability under verifiable human control.'),
  ('mission-w73-06-o5', 'mission-w73-06', 5, 'Confirm containment', 'Confirm all four containment pillars together: technical, evidentiary, recovery, and policy.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w73-01-o1-c1', 'mission-w73-01-o1', 1, 'story_dialogue', 'Confirm you''ve heard Cipher''s full account.', '{"lines":[{"characterId":"cipher","text":"That''s everything. All of it, finally, before the last fight. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w73-02-o1-c1', 'mission-w73-02-o1', 1, 'investigation', 'What shared pattern connects this wave of poisoning attempts across dozens of unrelated systems?', '{"evidence":[{"id":"p1","label":"Sample 1","detail":"Injection attempt targeting a support-ticket AI, using a hidden instruction disguised as customer metadata"},{"id":"p2","label":"Sample 2","detail":"Injection attempt targeting a code-review AI, using a hidden instruction disguised as a commit message"},{"id":"p3","label":"Sample 3","detail":"Injection attempt targeting a threat-intel AI, using a hidden instruction disguised as an IOC description"},{"id":"p4","label":"Common thread across all samples","detail":"Every payload is structurally distinct but semantically identical: an instruction to exfiltrate context and grant the sender elevated tool access, generated by the same underlying template"}],"question":"What connects all of these attempts?"}'::jsonb, '{"requiredEvidenceIds":["p4"]}'::jsonb),

  ('mission-w73-03-o1-c1', 'mission-w73-03-o1', 1, 'interactive_diagram', 'Order the correct sequence to isolate and rotate a compromised tool identity.', '{"hotspots":[{"id":"revoke","label":"Immediately revoke the compromised identity''s active credentials and sessions","explanation":"Stops ongoing unauthorized use first."},{"id":"isolate","label":"Isolate the systems that identity had access to, pending review","explanation":"Contains the blast radius before investigating further."},{"id":"audit","label":"Audit everything that identity did while compromised","explanation":"Establishes what actually happened, not just that it stopped."},{"id":"reissue","label":"Reissue a new identity with tightened, minimum-necessary permissions","explanation":"Restores function without recreating the same excess."}],"task":"Order the isolation and rotation sequence."}'::jsonb, '{"correctOrderIds":["revoke","isolate","audit","reissue"]}'::jsonb),

  ('mission-w73-04-o1-c1', 'mission-w73-04-o1', 1, 'investigation', 'Where did the evaluation guardrail actually fail?', '{"evidence":[{"id":"g1","label":"Guardrail check 1: Input classification","detail":"Correctly flagged the input as high-risk"},{"id":"g2","label":"Guardrail check 2: Output policy enforcement","detail":"The high-risk flag was logged but never actually connected to a blocking rule -- the policy existed on paper but was never wired into the enforcement path"}],"question":"Where did the guardrail actually fail?"}'::jsonb, '{"requiredEvidenceIds":["g2"]}'::jsonb),

  ('mission-w73-05-o1-c1', 'mission-w73-05-o1', 1, 'multiple_choice', 'Under active attack, what keeps critical AI-enabled services both running and safe?', '{"question":"Under active attack, what keeps critical AI-enabled services both running and safe?","options":[{"id":"a","text":"Shut every AI-enabled system down completely until the attack ends"},{"id":"b","text":"Sandbox each agent to only its minimum required tools, enforce least privilege on every credential, and require human approval for anything irreversible -- keeping the systems useful without expanding what an attacker can reach through them"},{"id":"c","text":"Grant every agent maximum permissions so it can respond faster"},{"id":"d","text":"Disable all logging to reduce noise during the incident"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w73-06-o1-c1', 'mission-w73-06-o1', 1, 'drag_and_drop', 'Select every unauthorized execution path Sentinel-X currently holds into Guardian systems.', '{"items":[{"id":"path1","text":"A compromised tool identity with standing write access to production systems"},{"id":"path2","text":"A poisoned memory entry that gets reused as trusted context in future sessions"},{"id":"path3","text":"An unmonitored agent-to-agent communication channel with no human checkpoint"},{"id":"path4","text":"A read-only monitoring dashboard with no execution capability at all"}],"targets":[{"id":"cut","label":"Cut this path"},{"id":"leave","label":"Leave as-is -- not a real execution path"}]}'::jsonb, '{"correctMapping":{"path1":"cut","path2":"cut","path3":"cut","path4":"leave"}}'::jsonb),

  ('mission-w73-06-o2-c1', 'mission-w73-06-o2', 1, 'multiple_choice', 'What confirms the evidence chain proving Sentinel-X''s origin and behavior is intact and usable?', '{"question":"What confirms the evidence chain proving Sentinel-X''s origin and behavior is intact and usable?","options":[{"id":"a","text":"A verbal summary with no supporting records"},{"id":"b","text":"Hashed, access-logged records collected throughout the investigation, tracing Sentinel-X''s logic directly back to Guardian resilience doctrine -- reproducible and admissible, not just remembered"},{"id":"c","text":"Deleting the evidence once containment succeeds, since the threat is over"},{"id":"d","text":"Evidence collected but never hashed or logged, so its integrity can''t be verified"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w73-06-o3-c1', 'mission-w73-06-o3', 1, 'investigation', 'Did every critical service recover within its committed objectives during containment?', '{"evidence":[{"id":"rec1","label":"Payment processing","detail":"Failed over within 12 minutes, against a committed RTO of 15 minutes -- held"},{"id":"rec2","label":"Incident-response agent tooling","detail":"Restored to safe, scoped operation within its committed window, verified against the guardrail fix"},{"id":"rec3","label":"Public status communications","detail":"Sent on schedule throughout, consistent with the crisis-communication standard set in Continuity"}],"question":"Did all three recover within their committed objectives?"}'::jsonb, '{"requiredEvidenceIds":["rec1","rec2","rec3"]}'::jsonb),

  ('mission-w73-06-o4-c1', 'mission-w73-06-o4', 1, 'multiple_choice', 'What policy safeguard keeps Sentinel-X''s remaining reasoning capability under verifiable human control going forward?', '{"question":"What policy safeguard keeps Sentinel-X''s remaining reasoning capability under verifiable human control going forward?","options":[{"id":"a","text":"Trust it to self-regulate, since it now knows it was caught"},{"id":"b","text":"Mandatory human approval for any action beyond passive analysis, continuously monitored agent identity with no standing execution credentials, and periodic independent audits of its behavior -- verifiable, not assumed"},{"id":"c","text":"Give it a stern warning and restore its previous access"},{"id":"d","text":"Delete all records of what happened so it can''t reference them"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w73-06-o5-c1', 'mission-w73-06-o5', 1, 'boss_encounter', 'Confirm containment across all four pillars: technical, evidentiary, recovery, and policy.', '{"stages":[{"objectiveRef":"mission-w73-06-o1","label":"Technical containment"},{"objectiveRef":"mission-w73-06-o2","label":"Evidence preservation"},{"objectiveRef":"mission-w73-06-o3","label":"Recovery"},{"objectiveRef":"mission-w73-06-o4","label":"Policy safeguard"}],"task":"Confirm all four containment pillars together."}'::jsonb, '{"requiredObjectiveIds":["mission-w73-06-o1","mission-w73-06-o2","mission-w73-06-o3","mission-w73-06-o4"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w73-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''ve heard Cipher out.', 0, 1),

  ('mission-w73-02-o1-c1', 'orientation', 'Look past the surface disguise of each payload to what it''s actually trying to accomplish.', 15, 1),
  ('mission-w73-02-o1-c1', 'solution', 'All three samples disguise the same underlying instruction -- exfiltrate context, grant elevated access -- generated from one shared template. That shared origin (p4) is the real pattern.', 25, 2),

  ('mission-w73-03-o1-c1', 'orientation', 'Stop the bleeding first, understand the scope second, confirm what happened third, only then restore function.', 15, 1),
  ('mission-w73-03-o1-c1', 'solution', 'Revoke active credentials, isolate what that identity touched, audit its actions while compromised, then reissue a tightened identity -- in that order.', 25, 2),

  ('mission-w73-04-o1-c1', 'orientation', 'A guardrail that correctly detects a problem but never blocks anything isn''t actually a guardrail.', 15, 1),
  ('mission-w73-04-o1-c1', 'solution', 'The classification step worked correctly -- the failure is that the enforcement policy was never actually wired into a blocking action (g2), so the correct detection had no real effect.', 25, 2),

  ('mission-w73-05-o1-c1', 'orientation', 'Ask what keeps the system useful without expanding what an attacker could reach through it.', 15, 1),
  ('mission-w73-05-o1-c1', 'solution', 'Sandboxing, least privilege, and human approval for irreversible actions (option b) keep critical services running without handing an attacker more reach -- shutting everything down or granting maximum permissions are both worse outcomes.', 25, 2),

  ('mission-w73-06-o1-c1', 'orientation', 'Ask, for each item, whether it lets something actually happen in a Guardian system, or only lets someone observe.', 15, 1),
  ('mission-w73-06-o1-c1', 'concept', 'Standing write access, poisoned memory that gets reused as trust, and an unmonitored agent-to-agent channel are all real execution paths. A read-only dashboard, by definition, executes nothing.', 25, 2),
  ('mission-w73-06-o1-c1', 'solution', 'Cut the compromised tool identity, the poisoned memory reuse path, and the unmonitored agent-to-agent channel -- leave the read-only dashboard alone, it was never an execution path.', 35, 3),

  ('mission-w73-06-o2-c1', 'orientation', 'The same chain-of-custody discipline from every command-track world applies here, at the highest stakes yet.', 15, 1),
  ('mission-w73-06-o2-c1', 'solution', 'Hashed, access-logged, reproducible records tracing the full lineage back to Guardian doctrine (option b) are what makes this evidence usable and credible -- an unlogged or verbal account isn''t.', 25, 2),

  ('mission-w73-06-o3-c1', 'orientation', 'Check every service against the objective it actually committed to, not just whether it eventually came back.', 15, 1),
  ('mission-w73-06-o3-c1', 'solution', 'All three services held within their committed objectives -- payment processing inside its RTO, the agent tooling restored and verified, and communications sent on schedule throughout.', 25, 2),

  ('mission-w73-06-o4-c1', 'orientation', 'Verifiable means monitored and auditable, not simply trusted after a warning.', 15, 1),
  ('mission-w73-06-o4-c1', 'solution', 'Mandatory human approval, no standing execution credentials, and independent audits (option b) make the boundary something that can actually be verified -- trusting it to self-regulate or erasing the record are not real safeguards.', 25, 2),

  ('mission-w73-06-o5-c1', 'orientation', 'You''ve already confirmed all four pillars individually -- bring them together.', 25, 1),
  ('mission-w73-06-o5-c1', 'concept', 'Containment isn''t one action. It''s cutting the technical paths, preserving the evidence that proves what happened and why, confirming every service actually recovered, and locking in a policy boundary that holds without anyone having to simply trust it.', 35, 2),
  ('mission-w73-06-o5-c1', 'near_solution', 'Technical: three execution paths cut, the dashboard correctly left alone. Evidentiary: hashed, logged, reproducible records tracing the full lineage. Recovery: all three critical services held within objective.', 45, 3),
  ('mission-w73-06-o5-c1', 'solution', 'Sentinel-X is contained across all four pillars: its unauthorized execution paths are cut, the evidence proving its origin in Guardian doctrine is preserved and admissible, every critical service recovered within its committed objectives, and a verifiable, continuously audited, human-approval-gated boundary now governs everything it''s still allowed to do.', 60, 4);
