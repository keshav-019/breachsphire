-- world-69 ("Security Assessment & Audit: Proof") mission content,
-- generated from docs/12-world-story-bible.md. Continues Act 9 "Command".
-- Mission 1 is cross-world-gated on world-68's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-69a', 'world-69', 'proof', '69A - Proof', 'The organization claims it fixed years of weaknesses. An independent assessor wants evidence that reality actually matches the policy.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-69a-1', 'campaign-69a', 'foundations', 'Foundations', 'Audit types, sampling, evidence sufficiency and finding classification, framed as proving reality matches policy.', 1),
  ('operation-69a-2', 'campaign-69a', 'investigation', 'Investigation', 'Defend a control set with objective evidence, and acknowledge remaining gaps honestly.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w69-01', 'world-69', 'campaign-69a', 'operation-69a-1', 'claims-versus-proof', 'Claims Versus Proof', 'The organization claims it remediated years of weaknesses. An independent assessor doesn''t take that claim at face value -- they want evidence.', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w68-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w69-02', 'world-69', 'campaign-69a', 'operation-69a-1', 'not-all-audits-ask-the-same-question', 'Not All Audits Ask the Same Question', 'Internal, external, and certification audits all look at controls, but they answer different questions for different audiences.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w69-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"audit-types-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w69-03', 'world-69', 'campaign-69a', 'operation-69a-1', 'you-cant-check-every-single-system', 'You Can''t Check Every Single System', 'Testing a control across a thousand systems doesn''t mean checking all thousand. It means sampling correctly enough that the result actually means something.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w69-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"sampling-methodology-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w69-04', 'world-69', 'campaign-69a', 'operation-69a-1', 'a-policy-document-is-not-evidence', 'A Policy Document Is Not Evidence', 'A written policy proves the organization intended to do something. It doesn''t prove the control actually operated.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w69-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"evidence-sufficiency-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w69-05', 'world-69', 'campaign-69a', 'operation-69a-2', 'not-every-finding-is-equally-urgent', 'Not Every Finding Is Equally Urgent', 'A dozen audit findings, none of them identical in urgency. Classifying them correctly decides what gets fixed this week versus this year.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w69-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"finding-classification-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w69-06', 'world-69', 'campaign-69a', 'operation-69a-2', 'proof-boss', 'Proof', 'Defend the organization''s control set to the assessor using objective evidence, and honestly acknowledge whatever gaps remain instead of hiding them.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w69-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"proof-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["proof"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w69-01', 1, 'luna', 'The organization claims it remediated years of weaknesses. An independent assessor isn''t going to take that on faith. They want evidence.'),
  ('mission-w69-01', 2, 'ava', 'This is where every program we''ve built this year either holds up under real scrutiny, or doesn''t.'),
  ('mission-w69-02', 1, 'zayn', 'Internal, external, certification -- all three look at controls, but they''re answering different questions for different audiences. Confusing them wastes everyone''s time.'),
  ('mission-w69-03', 1, 'byte', 'Testing a control across a thousand systems doesn''t mean checking all thousand. It means sampling well enough that the result actually generalizes.'),
  ('mission-w69-04', 1, 'ava', 'A written policy proves the organization intended to do something. It doesn''t prove the control actually operated, on any given day, in the real world.'),
  ('mission-w69-05', 1, 'luna', 'A dozen findings, none equally urgent. Classify them correctly, or you''ll spend this week fixing something that could safely wait until next year.'),
  ('mission-w69-06', 1, 'luna', 'Defend the control set. Objective evidence for what''s working. Honest acknowledgment for what isn''t.'),
  ('mission-w69-06', 2, 'zayn', '...Defense presented. Every claim backed by real evidence, and the two remaining gaps disclosed up front instead of hidden.'),
  ('mission-w69-06', 3, 'ava', 'That honesty is what makes the rest of the defense credible. An assessor who catches you hiding one gap stops trusting everything else you told them.'),
  ('mission-w69-06', 4, 'byte', 'One of the assessor''s tests went further than a normal audit. They ran a live resilience test on our recovery process.'),
  ('mission-w69-06', 5, 'luna', 'And?'),
  ('mission-w69-06', 6, 'byte', 'It worked, mostly. But it also surfaced hidden single points of failure in our recovery dependencies -- things that look redundant on paper and aren''t, in practice.'),
  ('mission-w69-06', 7, 'luna', 'Then business continuity is where we go next. Recovery objectives that hold up under a real test, not a paper one.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w69-01-o1', 'mission-w69-01', 1, 'Acknowledge the briefing', 'Confirm you understand this world is about proving controls, not just documenting them.'),
  ('mission-w69-02-o1', 'mission-w69-02', 1, 'Match each audit type to its purpose', 'Match internal, external, and certification audits to what question each one answers.'),
  ('mission-w69-03-o1', 'mission-w69-03', 1, 'Choose the correct sampling approach', 'Choose the sampling method that produces a defensible result for a control across many systems.'),
  ('mission-w69-04-o1', 'mission-w69-04', 1, 'Determine evidence sufficiency', 'Decide whether the provided evidence actually proves the control operated.'),
  ('mission-w69-05-o1', 'mission-w69-05', 1, 'Classify the findings by severity', 'Sort each finding into its correct severity and remediation timeline.'),
  ('mission-w69-06-o1', 'mission-w69-06', 1, 'Defend the controls with evidence', 'Select the correct evidence backing each control claim.'),
  ('mission-w69-06-o2', 'mission-w69-06', 2, 'Disclose the remaining gaps honestly', 'Choose the correct way to present remaining gaps to the assessor.'),
  ('mission-w69-06-o3', 'mission-w69-06', 3, 'Confirm the defense', 'Confirm the evidence-backed defense and the honest disclosure together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w69-01-o1-c1', 'mission-w69-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"luna","text":"Prove it, don''t just claim it. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w69-02-o1-c1', 'mission-w69-02-o1', 1, 'drag_and_drop', 'Match each audit type to what question it primarily answers.', '{"items":[{"id":"a1","text":"Internal audit"},{"id":"a2","text":"External audit"},{"id":"a3","text":"Certification audit"}],"targets":[{"id":"t1","label":"Are our own controls actually working, for our own management''s benefit?"},{"id":"t2","label":"Can an independent party outside the organization vouch for our controls, for customers or regulators?"},{"id":"t3","label":"Do we meet a specific named standard''s formal requirements, to earn a recognized certification?"}]}'::jsonb, '{"correctMapping":{"a1":"t1","a2":"t2","a3":"t3"}}'::jsonb),

  ('mission-w69-03-o1-c1', 'mission-w69-03-o1', 1, 'multiple_choice', 'Testing whether a patching control was followed across 1,000 servers, which sampling approach produces a defensible result?', '{"question":"Testing whether a patching control was followed across 1,000 servers, which sampling approach produces a defensible result?","options":[{"id":"a","text":"Check only the 3 servers the IT team suggests looking at"},{"id":"b","text":"A statistically representative random sample, sized appropriately for the population and desired confidence level, drawn independently of which systems the audited team would prefer to show"},{"id":"c","text":"Check every server manually, which would take months and delay the entire audit"},{"id":"d","text":"Skip sampling and just accept the team''s self-reported compliance percentage"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w69-04-o1-c1', 'mission-w69-04-o1', 1, 'investigation', 'Does this evidence actually prove the access-review control operated?', '{"evidence":[{"id":"ev1","label":"Evidence A: The written access-review policy document","detail":"States that reviews should happen quarterly -- proves intent, not execution"},{"id":"ev2","label":"Evidence B: Signed quarterly access-review reports for the last four quarters, each listing reviewed accounts and revoked access, with reviewer names and dates","detail":"Directly demonstrates the control was actually performed, on schedule, with a specific outcome each time"}],"question":"Which evidence actually proves the control operated?"}'::jsonb, '{"requiredEvidenceIds":["ev2"]}'::jsonb),

  ('mission-w69-05-o1-c1', 'mission-w69-05-o1', 1, 'drag_and_drop', 'Classify each finding by severity and remediation urgency.', '{"items":[{"id":"f1","text":"A production database with no encryption at rest, containing regulated customer data"},{"id":"f2","text":"A non-production test environment missing a minor logging configuration, no sensitive data present"},{"id":"f3","text":"An admin account with a password that hasn''t been rotated in 18 months, on a system with access to customer financial records"}],"targets":[{"id":"critical","label":"Critical -- remediate immediately"},{"id":"low","label":"Low -- remediate on standard schedule"}]}'::jsonb, '{"correctMapping":{"f1":"critical","f2":"low","f3":"critical"}}'::jsonb),

  ('mission-w69-06-o1-c1', 'mission-w69-06-o1', 1, 'multiple_choice', 'The assessor asks for evidence the access-review control actually operated this year. What should be presented?', '{"question":"The assessor asks for evidence the access-review control actually operated this year. What should be presented?","options":[{"id":"a","text":"The policy document alone"},{"id":"b","text":"The signed quarterly review reports showing who reviewed what, when, and what was revoked"},{"id":"c","text":"A verbal assurance that reviews happen"},{"id":"d","text":"Nothing -- assessors should just trust the organization"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w69-06-o2-c1', 'mission-w69-06-o2', 1, 'multiple_choice', 'Two genuine gaps remain: one critical finding still being remediated, one accepted low-severity risk. How should these be presented to the assessor?', '{"question":"Two genuine gaps remain: one critical finding still being remediated, one accepted low-severity risk. How should these be presented to the assessor?","options":[{"id":"a","text":"Hide both and hope they aren''t discovered during testing"},{"id":"b","text":"Disclose both proactively, with the remediation plan and timeline for the critical one, and the documented risk-acceptance rationale for the low-severity one"},{"id":"c","text":"Disclose only the low-severity one and hope the critical one isn''t tested"},{"id":"d","text":"Ask the assessor to skip testing those specific areas"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w69-06-o3-c1', 'mission-w69-06-o3', 1, 'boss_encounter', 'Confirm the evidence-backed defense and the honest disclosure together.', '{"stages":[{"objectiveRef":"mission-w69-06-o1","label":"The evidence-backed defense"},{"objectiveRef":"mission-w69-06-o2","label":"The honest disclosure"}],"task":"Confirm the evidence-backed defense and the honest disclosure together."}'::jsonb, '{"requiredObjectiveIds":["mission-w69-06-o1","mission-w69-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w69-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w69-02-o1-c1', 'orientation', 'Ask who each audit is really for -- your own management, an outside party, or a specific standards body.', 15, 1),
  ('mission-w69-02-o1-c1', 'solution', 'Internal audits serve internal management, external audits serve outside stakeholders, and certification audits prove compliance with a specific named standard.', 25, 2),

  ('mission-w69-03-o1-c1', 'orientation', 'A defensible sample has to be both statistically sound and chosen independently of what the audited team wants shown.', 15, 1),
  ('mission-w69-03-o1-c1', 'solution', 'A properly sized, independently drawn random sample (option b) produces a result you can actually generalize -- letting the audited team pick which systems to check defeats the purpose.', 25, 2),

  ('mission-w69-04-o1-c1', 'orientation', 'A policy document says what should happen. Only records of the actual activity prove it did.', 15, 1),
  ('mission-w69-04-o1-c1', 'solution', 'Signed quarterly reports with specific names, dates and outcomes (ev2) prove execution -- the policy document (ev1) only proves intent.', 25, 2),

  ('mission-w69-05-o1-c1', 'orientation', 'Weigh both what data is at risk and how exposed it currently is.', 15, 1),
  ('mission-w69-05-o1-c1', 'solution', 'Unencrypted regulated data and a stale privileged password on a financially sensitive system are both critical -- a minor logging gap on a non-production, non-sensitive system is low severity.', 25, 2),

  ('mission-w69-06-o1-c1', 'orientation', 'The assessor wants proof of execution, not a description of intent.', 15, 1),
  ('mission-w69-06-o1-c1', 'solution', 'The signed quarterly reports with named reviewers and dated outcomes are the actual evidence of the control operating -- the policy alone or a verbal claim aren''t sufficient. Option b.', 25, 2),

  ('mission-w69-06-o2-c1', 'orientation', 'An assessor who finds a hidden gap on their own stops trusting everything else in the report.', 15, 1),
  ('mission-w69-06-o2-c1', 'solution', 'Proactively disclosing both gaps, with a real remediation plan for the critical one and documented rationale for the accepted one, is what actually builds credibility. Option b.', 25, 2),

  ('mission-w69-06-o3-c1', 'orientation', 'You''ve already backed the defense with evidence and disclosed the gaps -- combine them.', 20, 1),
  ('mission-w69-06-o3-c1', 'solution', 'The defense stands on signed, dated evidence of actual control execution, paired with proactive, honest disclosure of the two remaining gaps and their remediation status -- exactly what makes the whole defense credible.', 35, 2);
