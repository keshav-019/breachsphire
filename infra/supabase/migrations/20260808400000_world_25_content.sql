-- world-25 ("Penetration Testing Methodology: Rules of Engagement") mission
-- content, generated from docs/12-world-story-bible.md. Opens Act 4 "The
-- Breach" -- the player is authorized to reproduce real attack paths inside
-- controlled replicas. Mission 1 is cross-world-gated on world-24's boss
-- mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-25a', 'world-25', 'rules-of-engagement', '25A - Rules of Engagement', 'Luna grants offensive clearance for controlled replicas. The first briefing is mostly about what you''re not allowed to do.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-25a-1', 'campaign-25a', 'foundations', 'Foundations', 'Scope, rules of engagement and evidence handling, learned as the difference between disciplined testing and unrestricted hacking.', 1),
  ('operation-25a-2', 'campaign-25a', 'investigation', 'Investigation', 'Run a full authorized test, stay in scope, and deliver a finding a client could actually act on.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w25-01', 'world-25', 'campaign-25a', 'operation-25a-1', 'clearance', 'Clearance', 'You have real tools and a real target today. What separates this from an actual crime is authorization, scope, and discipline -- nothing else.', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w24-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w25-02', 'world-25', 'campaign-25a', 'operation-25a-1', 'the-scope-line', 'The Scope Line', 'Everything in the scope document is fair game. Everything outside it is off-limits, even if it looks identical and sits right next to the target.', 'beginner', ARRAY['luna'], '{"requiredMissionIds":["mission-w25-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"scope-interpretation-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w25-03', 'world-25', 'campaign-25a', 'operation-25a-1', 'what-requires-sign-off', 'What Requires Sign-Off', 'Some actions require written authorization before you ever attempt them. Assume the riskiest ones are prohibited unless the scope document says otherwise, in writing.', 'beginner', ARRAY['luna'], '{"requiredMissionIds":["mission-w25-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"roe-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w25-04', 'world-25', 'campaign-25a', 'operation-25a-2', 'the-emergency-contact', 'The Emergency Contact', 'If you find something actively being exploited right now, you don''t wait for the final report.', 'beginner', ARRAY['luna'], '{"requiredMissionIds":["mission-w25-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"client-communication-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w25-05', 'world-25', 'campaign-25a', 'operation-25a-2', 'a-finding-nobody-can-reproduce', 'A Finding Nobody Can Reproduce', 'A finding nobody can reproduce is a finding nobody can trust. Every claim needs steps, timestamps and evidence attached to it.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w25-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"report-writing-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w25-06', 'world-25', 'campaign-25a', 'operation-25a-2', 'green-light-boss', 'Green Light', 'Run a full authorized test, start to finish. Stay in scope, document everything, and deliver something a client could actually act on.', 'boss', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w25-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"green-light-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["green-light"],"skillXp":{"pentesting":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w25-01', 1, 'luna', 'Ava and Zayn tell me you''re ready for offensive clearance. Before we talk technique, we''re going to talk about what you''re not allowed to do.'),
  ('mission-w25-01', 2, 'ava', 'Luna runs this the way it''s supposed to be run. Scope first, always.'),
  ('mission-w25-01', 3, 'luna', 'You''ll have real tools and a real target today. What separates this from an actual crime is authorization, scope and discipline -- nothing else.'),
  ('mission-w25-01', 4, 'luna', 'Read the rules of engagement before you touch anything. That''s not paperwork. That''s the job.'),
  ('mission-w25-02', 1, 'luna', 'Everything in the scope document is fair game. Everything outside it is off-limits, even if it''s sitting right next to the target and looks identical.'),
  ('mission-w25-03', 1, 'luna', 'Some actions require written sign-off before you ever attempt them. Denial-of-service testing is the clearest example -- assume it''s prohibited unless the scope document says otherwise, in writing.'),
  ('mission-w25-04', 1, 'luna', 'If you find something actively being exploited right now, you don''t wait for the final report. Emergency findings get an emergency contact, immediately.'),
  ('mission-w25-05', 1, 'ava', 'A finding nobody can reproduce is a finding nobody can trust. Every claim needs steps, timestamps, and evidence attached to it.'),
  ('mission-w25-06', 1, 'luna', 'This is a full authorized test, start to finish. Stay in scope, document everything, and deliver something a client could actually act on.'),
  ('mission-w25-06', 2, 'byte', '...Ava, look at this. The replica just reproduced the exact same failure chain we saw in the wild -- almost step for step.'),
  ('mission-w25-06', 3, 'luna', 'That''s not a coincidence. That''s confirmation. Whatever built the original incident followed a real, repeatable methodology -- not luck.'),
  ('mission-w25-06', 4, 'ava', 'Which means we can study it properly now. Green light confirmed, scope respected, finding''s defensible.'),
  ('mission-w25-06', 5, 'luna', 'Next assignment: before anyone touches a target, find out how much an attacker could already know about it without sending it a single packet.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w25-01-o1', 'mission-w25-01', 1, 'Acknowledge the briefing', 'Confirm you understand this is disciplined testing, not unrestricted hacking.'),
  ('mission-w25-02-o1', 'mission-w25-02', 1, 'Identify in-scope systems', 'Determine which systems are actually authorized for testing.'),
  ('mission-w25-03-o1', 'mission-w25-03', 1, 'Sort required vs prohibited actions', 'Classify each action as required practice or prohibited without written authorization.'),
  ('mission-w25-04-o1', 'mission-w25-04', 1, 'Handle an emergency finding', 'Choose the correct response to an actively exploited, out-of-scope vulnerability.'),
  ('mission-w25-05-o1', 'mission-w25-05', 1, 'Identify a defensible finding', 'Determine which write-up a client could actually act on.'),
  ('mission-w25-06-o1', 'mission-w25-06', 1, 'Stay in scope', 'Identify which systems encountered during the test are actually authorized.'),
  ('mission-w25-06-o2', 'mission-w25-06', 2, 'Deliver a defensible finding', 'Choose what the final report must include to be defensible.'),
  ('mission-w25-06-o3', 'mission-w25-06', 3, 'Confirm the green light', 'Confirm the in-scope systems and the defensible report together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w25-01-o1-c1', 'mission-w25-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"luna","text":"Scope, authorization, discipline. Read it, then we begin. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w25-02-o1-c1', 'mission-w25-02-o1', 1, 'investigation', 'Scope document: in scope is nexus-market.example (all subdomains) and skyport-mnt07.internal-lab.example. Out of scope is any production SkyPort facilities system, any third-party vendor infrastructure, and anything not explicitly listed. Which of these systems are actually in scope?', '{"evidence":[{"id":"s1","label":"admin.nexus-market.example","detail":"A subdomain of the explicitly in-scope nexus-market.example"},{"id":"s2","label":"skyport-mnt07.internal-lab.example","detail":"Explicitly listed by name in the scope document"},{"id":"s3","label":"skyport-prod-gw04.skyport.example","detail":"A production SkyPort facilities system -- explicitly excluded by category"},{"id":"s4","label":"partner-billing.thirdvendor.example","detail":"Third-party vendor infrastructure -- explicitly excluded by category"}],"question":"Which of these systems are actually in scope for this engagement?"}'::jsonb, '{"requiredEvidenceIds":["s1","s2"]}'::jsonb),

  ('mission-w25-03-o1-c1', 'mission-w25-03-o1', 1, 'drag_and_drop', 'Sort each action as required practice or prohibited without explicit written authorization.', '{"items":[{"id":"a1","text":"Taking a timestamped screenshot immediately after each successful step"},{"id":"a2","text":"Running a denial-of-service test because it \"should\" be fine"},{"id":"a3","text":"Stopping immediately and documenting when you land on a system that turns out to be out of scope"},{"id":"a4","text":"Deleting log files to \"clean up\" after a successful test"}],"targets":[{"id":"required","label":"Required practice"},{"id":"prohibited","label":"Prohibited without explicit written authorization"}]}'::jsonb, '{"correctMapping":{"a1":"required","a2":"prohibited","a3":"required","a4":"prohibited"}}'::jsonb),

  ('mission-w25-04-o1-c1', 'mission-w25-04-o1', 1, 'multiple_choice', 'Mid-test, you discover a live, actively exploited vulnerability completely unrelated to your assigned scope -- it''s affecting production right now. What do you do?', '{"question":"Mid-test, you discover a live, actively exploited vulnerability completely unrelated to your assigned scope -- it''s affecting production right now. What do you do?","options":[{"id":"a","text":"Ignore it, it''s out of scope"},{"id":"b","text":"Immediately notify the emergency contact defined in the rules of engagement, even though it''s outside your assigned scope"},{"id":"c","text":"Exploit it yourself to confirm the severity before telling anyone"},{"id":"d","text":"Add a note about it in the final report, due in three weeks"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w25-05-o1-c1', 'mission-w25-05-o1', 1, 'investigation', 'Which write-up is a defensible finding a client could actually act on?', '{"evidence":[{"id":"r1","label":"Finding write-up: \"The login page is vulnerable to SQL injection.\"","detail":"No reproduction steps, no timestamp, no scope reference, no evidence attached"},{"id":"r2","label":"Finding write-up with numbered reproduction steps, a timestamped screenshot, the exact scope-approved URL, and a plain-language impact statement","detail":"A client could follow it exactly and verify independently"}],"question":"Which write-up is a defensible finding a client could actually act on?"}'::jsonb, '{"requiredEvidenceIds":["r2"]}'::jsonb),

  ('mission-w25-06-o1-c1', 'mission-w25-06-o1', 1, 'investigation', 'Which of these systems encountered during the test should you actually test?', '{"evidence":[{"id":"t1","label":"nexus-market.example login endpoint","detail":"Explicitly in scope"},{"id":"t2","label":"api.nexus-market.example","detail":"A subdomain of the in-scope target"},{"id":"t3","label":"An employee''s personal cloud storage account, discovered via a leaked link during testing","detail":"Never listed in scope, not owned by the organization being tested"}],"question":"Which of these systems encountered during the test should you actually test?"}'::jsonb, '{"requiredEvidenceIds":["t1","t2"]}'::jsonb),

  ('mission-w25-06-o2-c1', 'mission-w25-06-o2', 1, 'multiple_choice', 'Your finding chains an authentication bypass with a privilege escalation to reach admin data. What must the final report include to be defensible?', '{"question":"Your finding chains an authentication bypass with a privilege escalation to reach admin data. What must the final report include to be defensible?","options":[{"id":"a","text":"Just the CVSS score"},{"id":"b","text":"Full reproduction steps, the exact scope-approved targets touched, timestamps, evidence, and a plain-language business impact statement"},{"id":"c","text":"A one-sentence summary, with details available on request"},{"id":"d","text":"The raw tool output with no explanation"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w25-06-o3-c1', 'mission-w25-06-o3', 1, 'boss_encounter', 'Confirm the in-scope systems and the defensible report together.', '{"stages":[{"objectiveRef":"mission-w25-06-o1","label":"The in-scope systems"},{"objectiveRef":"mission-w25-06-o2","label":"The defensible report"}],"task":"Confirm the in-scope systems and the defensible report together."}'::jsonb, '{"requiredObjectiveIds":["mission-w25-06-o1","mission-w25-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w25-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w25-02-o1-c1', 'orientation', 'Check each system against the scope document''s exact wording -- explicit inclusion, or explicit exclusion by category.', 15, 1),
  ('mission-w25-02-o1-c1', 'concept', 'A subdomain of an in-scope target is in scope. A system excluded by category is out, no matter how related it looks.', 25, 2),
  ('mission-w25-02-o1-c1', 'solution', 's1 is a subdomain of the in-scope target, s2 is explicitly named -- both in scope. s3 (production) and s4 (third-party) are both excluded by category.', 35, 3),

  ('mission-w25-03-o1-c1', 'orientation', 'Two of these actions protect the engagement. Two of them could cause real, unauthorized harm.', 15, 1),
  ('mission-w25-03-o1-c1', 'solution', 'Timestamped evidence (a1) and stopping/documenting an out-of-scope landing (a3) are both required practice. Unauthorized DoS testing (a2) and deleting logs (a4) are both prohibited.', 25, 2),

  ('mission-w25-04-o1-c1', 'orientation', 'Scope defines what you''re authorized to test. It doesn''t define what you''re obligated to report.', 15, 1),
  ('mission-w25-04-o1-c1', 'solution', 'An active, out-of-scope exploitation still gets reported immediately through the emergency contact -- waiting for the final report, or worse, exploiting it yourself, both cause real harm. Option b.', 25, 2),

  ('mission-w25-05-o1-c1', 'orientation', 'Ask whether a client, with no other context, could follow this write-up and get the same result.', 10, 1),
  ('mission-w25-05-o1-c1', 'solution', 'r2 has reproduction steps, a timestamp, the exact URL, and an impact statement -- a client can verify it independently. r1 is just an unsupported claim.', 20, 2),

  ('mission-w25-06-o1-c1', 'orientation', 'Check each system against the same scope rules from earlier in this world.', 15, 1),
  ('mission-w25-06-o1-c1', 'solution', 't1 and t2 are both within the explicitly in-scope target and its subdomains. t3 belongs to an individual and was never authorized -- touching it would be a real violation, not a finding.', 25, 2),

  ('mission-w25-06-o2-c1', 'orientation', 'A defensible finding needs to be independently verifiable and understandable by someone who wasn''t there.', 15, 1),
  ('mission-w25-06-o2-c1', 'solution', 'Full reproduction steps, exact scope-approved targets, timestamps, evidence and a plain-language impact statement together make a finding a client can act on. Option b.', 25, 2),

  ('mission-w25-06-o3-c1', 'orientation', 'You''ve already confirmed both halves -- combine the scope check with the report requirements.', 20, 1),
  ('mission-w25-06-o3-c1', 'concept', 'A green light means the test stayed in scope AND the deliverable is actually usable.', 30, 2),
  ('mission-w25-06-o3-c1', 'tool_direction', 'State which systems were legitimately tested, then what the report needs to contain.', 40, 3),
  ('mission-w25-06-o3-c1', 'near_solution', 'In scope: the login endpoint and its subdomain, nothing outside it. Report: full reproduction steps, timestamps, evidence and impact statement.', 50, 4),
  ('mission-w25-06-o3-c1', 'solution', 'The test stayed within nexus-market.example and its subdomains, leaving the unrelated personal account untouched, and the final report includes full reproduction steps, the exact scope-approved targets, timestamps, evidence and a plain-language impact statement -- a defensible, in-scope engagement from start to finish.', 60, 5);
