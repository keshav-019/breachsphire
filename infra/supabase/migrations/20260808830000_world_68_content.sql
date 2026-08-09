-- world-68 ("Legal, Regulation & Privacy: Lines of Law") mission content,
-- generated from docs/12-world-story-bible.md. Continues Act 9 "Command".
-- Mission 1 is cross-world-gated on world-67's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-68a', 'world-68', 'lines-of-law', '68A - Lines of Law', 'The supplier''s refusal to hand over evidence just became a legal question. And it isn''t the only one waiting.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-68a-1', 'campaign-68a', 'foundations', 'Foundations', 'Privacy, evidence, jurisdiction, cross-border data and cybercrime concepts, learned through counsel briefings.', 1),
  ('operation-68a-2', 'campaign-68a', 'investigation', 'Investigation', 'Coordinate a response that satisfies security objectives without creating avoidable legal or privacy violations.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w68-01', 'world-68', 'campaign-68a', 'operation-68a-1', 'past-where-technical-skill-alone-helps', 'Past Where Technical Skill Alone Helps', 'The supplier''s refusal just became a legal question. Containment now spans multiple countries, customers and regulated datasets -- technical ability is no longer the only constraint.', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w67-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w68-02', 'world-68', 'campaign-68a', 'operation-68a-1', 'does-this-trigger-the-clock', 'Does This Trigger the Clock', 'Not every incident requires regulatory notification. The ones that do start a legal clock the moment they''re confirmed, not the moment someone gets around to it.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w68-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"breach-notification-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w68-03', 'world-68', 'campaign-68a', 'operation-68a-1', 'data-doesnt-stop-at-a-border', 'Data Doesn''t Stop at a Border', 'A data flow that looks perfectly normal technically can still cross a legal line the moment it crosses a jurisdiction.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w68-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"cross-border-data-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w68-04', 'world-68', 'campaign-68a', 'operation-68a-1', 'evidence-that-holds-up-in-court', 'Evidence That Holds Up in Court', 'Technical evidence and legally admissible evidence aren''t automatically the same thing. The chain of custody is what bridges them.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w68-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"legal-evidence-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w68-05', 'world-68', 'campaign-68a', 'operation-68a-2', 'the-clause-that-was-never-in-the-contract', 'The Clause That Was Never in the Contract', 'The supplier issue exposed a gap nobody caught at signing: this contract never included a right-to-audit clause at all.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w68-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"contract-clause-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w68-06', 'world-68', 'campaign-68a', 'operation-68a-2', 'lines-of-law-boss', 'Lines of Law', 'Coordinate a complete response to this cross-border incident that satisfies the security objectives without creating avoidable legal or privacy violations.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w68-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"lines-of-law-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["lines-of-law"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w68-01', 1, 'luna', 'The supplier''s refusal just became a legal question. Containment now spans multiple countries, multiple customers, and regulated data. Technical skill alone doesn''t get us through this one.'),
  ('mission-w68-01', 2, 'ava', 'Every decision from here needs a legal lens next to the technical one. Sometimes the right technical answer is the wrong legal one, and you need to know which is which.'),
  ('mission-w68-02', 1, 'zayn', 'Not every incident triggers a notification requirement. The ones that do start a legal clock the moment they''re confirmed -- not whenever someone finally writes the report.'),
  ('mission-w68-03', 1, 'byte', 'A data flow that looks completely normal from a technical standpoint can still cross a legal line the instant it crosses a jurisdiction.'),
  ('mission-w68-04', 1, 'ava', 'Technical evidence and legally admissible evidence aren''t automatically the same thing. Chain of custody is the bridge between them.'),
  ('mission-w68-05', 1, 'luna', 'The supplier issue exposed something worse than a refusal. This contract never had a right-to-audit clause in it at all.'),
  ('mission-w68-06', 1, 'luna', 'Coordinate the full response. Every security objective still has to be met -- but not at the cost of an avoidable legal or privacy violation.'),
  ('mission-w68-06', 2, 'zayn', '...Response coordinated. Notification obligations met on time, data handling respects every jurisdiction it touched, evidence chain intact and admissible.'),
  ('mission-w68-06', 3, 'ava', 'That''s the actual discipline here -- getting the technical response right and the legal response right, at the same time, under a deadline.'),
  ('mission-w68-06', 4, 'byte', 'The regulators reviewing this incident aren''t just asking what happened anymore.'),
  ('mission-w68-06', 5, 'luna', 'What are they asking?'),
  ('mission-w68-06', 6, 'byte', 'Proof. Not a description of our controls -- evidence that they actually worked, or specifically didn''t, and why.'),
  ('mission-w68-06', 7, 'luna', 'Then the next step isn''t explaining our controls. It''s proving them.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w68-01-o1', 'mission-w68-01', 1, 'Acknowledge the briefing', 'Confirm you understand legal and technical decisions now run in parallel.'),
  ('mission-w68-02-o1', 'mission-w68-02', 1, 'Determine notification obligation', 'Decide whether a given incident triggers a regulatory notification requirement.'),
  ('mission-w68-03-o1', 'mission-w68-03', 1, 'Find the jurisdiction issue', 'Identify which data flow crosses a jurisdiction it shouldn''t without proper safeguards.'),
  ('mission-w68-04-o1', 'mission-w68-04', 1, 'Preserve a legally admissible chain of custody', 'Order the steps that keep evidence legally admissible.'),
  ('mission-w68-05-o1', 'mission-w68-05', 1, 'Choose the correct contract clause', 'Identify the clause that should have been in the vendor contract from the start.'),
  ('mission-w68-06-o1', 'mission-w68-06', 1, 'Coordinate the notification response', 'Choose the correct combination of notification and jurisdiction handling.'),
  ('mission-w68-06-o2', 'mission-w68-06', 2, 'Preserve admissible evidence', 'Confirm the evidence-handling sequence remains legally sound throughout the response.'),
  ('mission-w68-06-o3', 'mission-w68-06', 3, 'Confirm the coordinated response', 'Confirm the notification handling and evidence preservation together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w68-01-o1-c1', 'mission-w68-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"ava","text":"Legal and technical, running in parallel now. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w68-02-o1-c1', 'mission-w68-02-o1', 1, 'multiple_choice', 'A confirmed incident exposed encrypted backup data where the encryption keys were never accessed or compromised. Does this typically trigger a regulatory notification requirement?', '{"question":"A confirmed incident exposed encrypted backup data where the encryption keys were never accessed or compromised. Does this typically trigger a regulatory notification requirement?","options":[{"id":"a","text":"Yes, always, regardless of encryption status"},{"id":"b","text":"Generally no under most breach-notification frameworks -- properly encrypted data with uncompromised keys is typically excluded from notification triggers, though this must be confirmed with counsel for the specific jurisdiction"},{"id":"c","text":"Only if the company wants to notify"},{"id":"d","text":"Notification requirements never depend on encryption status"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w68-03-o1-c1', 'mission-w68-03-o1', 1, 'investigation', 'Which data flow crosses a jurisdiction without proper safeguards?', '{"evidence":[{"id":"flow1","label":"Flow A","detail":"Customer data transferred between two regions under a signed data-transfer agreement with documented legal safeguards"},{"id":"flow2","label":"Flow B","detail":"Customer data copied to a support vendor''s server in a different jurisdiction with no data-transfer agreement on file and no documented safeguard"}],"question":"Which flow is the jurisdiction issue?"}'::jsonb, '{"requiredEvidenceIds":["flow2"]}'::jsonb),

  ('mission-w68-04-o1-c1', 'mission-w68-04-o1', 1, 'interactive_diagram', 'Order the steps that keep this evidence legally admissible.', '{"hotspots":[{"id":"collect","label":"Collect the evidence using a documented, repeatable method","explanation":"How it was gathered has to be defensible from the start."},{"id":"hash","label":"Generate and record a cryptographic hash of the evidence immediately after collection","explanation":"Proves the evidence hasn''t been altered since collection."},{"id":"log_custody","label":"Log every person who accesses the evidence and when","explanation":"An unbroken record of who had it and why."},{"id":"verify_hash","label":"Re-verify the hash before presenting the evidence","explanation":"Confirms nothing changed across the entire chain."}],"task":"Order the chain-of-custody steps."}'::jsonb, '{"correctOrderIds":["collect","hash","log_custody","verify_hash"]}'::jsonb),

  ('mission-w68-05-o1-c1', 'mission-w68-05-o1', 1, 'multiple_choice', 'What contractual clause should have been included from the start to prevent this supplier evidence dispute?', '{"question":"What contractual clause should have been included from the start to prevent this supplier evidence dispute?","options":[{"id":"a","text":"A marketing exclusivity clause"},{"id":"b","text":"A right-to-audit clause, giving the organization or an independent third party the contractual right to verify the supplier''s security controls directly"},{"id":"c","text":"A clause requiring the supplier to use a specific font in their reports"},{"id":"d","text":"No clause is necessary -- questionnaires are always sufficient"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w68-06-o1-c1', 'mission-w68-06-o1', 1, 'multiple_choice', 'This incident involves unencrypted customer data (notification required) that also briefly transited a jurisdiction with no data-transfer agreement in place. What''s the correct coordinated response?', '{"question":"This incident involves unencrypted customer data (notification required) that also briefly transited a jurisdiction with no data-transfer agreement in place. What''s the correct coordinated response?","options":[{"id":"a","text":"Notify only, and ignore the jurisdiction issue since it wasn''t the main incident"},{"id":"b","text":"Notify affected regulators and individuals within the required timeframe, and separately address the jurisdiction gap with counsel -- both are real, independent obligations that need their own response"},{"id":"c","text":"Address the jurisdiction issue only, since it happened first"},{"id":"d","text":"Wait for both issues to resolve themselves before doing anything"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w68-06-o2-c1', 'mission-w68-06-o2', 1, 'multiple_choice', 'While notifying regulators and addressing the jurisdiction gap, how should the technical evidence supporting the incident timeline be handled?', '{"question":"While notifying regulators and addressing the jurisdiction gap, how should the technical evidence supporting the incident timeline be handled?","options":[{"id":"a","text":"Set it aside until the legal issues are fully resolved"},{"id":"b","text":"Maintain the same chain-of-custody discipline throughout -- hashed at collection, access logged, re-verified before use -- since this evidence will support both the regulatory filing and any later legal proceeding"},{"id":"c","text":"Delete it once the notification is sent, since it''s no longer needed"},{"id":"d","text":"Hand it directly to the affected customers with no controls"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w68-06-o3-c1', 'mission-w68-06-o3', 1, 'boss_encounter', 'Confirm the coordinated notification response and the preserved evidence chain together.', '{"stages":[{"objectiveRef":"mission-w68-06-o1","label":"The coordinated response"},{"objectiveRef":"mission-w68-06-o2","label":"The preserved evidence chain"}],"task":"Confirm the coordinated notification response and the preserved evidence chain together."}'::jsonb, '{"requiredObjectiveIds":["mission-w68-06-o1","mission-w68-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w68-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w68-02-o1-c1', 'orientation', 'Most breach-notification frameworks care about whether the exposed data was actually usable by an attacker.', 15, 1),
  ('mission-w68-02-o1-c1', 'solution', 'Properly encrypted data with uncompromised keys generally isn''t considered a reportable breach under most frameworks -- though jurisdiction-specific confirmation with counsel is still required. Option b.', 25, 2),

  ('mission-w68-03-o1-c1', 'orientation', 'Ask which flow has actual legal paperwork behind it versus which one doesn''t.', 15, 1),
  ('mission-w68-03-o1-c1', 'solution', 'Flow B has no data-transfer agreement or documented safeguard at all -- Flow A is properly covered by a signed agreement.', 25, 2),

  ('mission-w68-04-o1-c1', 'orientation', 'Prove the evidence hasn''t changed, both right after collection and right before it''s used.', 15, 1),
  ('mission-w68-04-o1-c1', 'solution', 'Collect with a documented method, hash immediately, log every access, then re-verify the hash before presentation -- each step proves integrity at a different point in the chain.', 25, 2),

  ('mission-w68-05-o1-c1', 'orientation', 'Ask what would have let the organization independently verify the supplier''s claims instead of just trusting them.', 15, 1),
  ('mission-w68-05-o1-c1', 'solution', 'A right-to-audit clause gives contractual power to actually verify controls, rather than relying on a questionnaire the supplier can simply stop supporting. Option b.', 25, 2),

  ('mission-w68-06-o1-c1', 'orientation', 'These are two separate legal obligations, triggered by two separate facts -- treat them as such.', 15, 1),
  ('mission-w68-06-o1-c1', 'solution', 'Notification and jurisdiction handling are independent obligations that both need a real, timely response -- addressing only one and ignoring the other leaves genuine exposure. Option b.', 25, 2),

  ('mission-w68-06-o2-c1', 'orientation', 'This evidence has to survive scrutiny from more than one audience -- regulators now, possibly a court later.', 15, 1),
  ('mission-w68-06-o2-c1', 'solution', 'Maintaining the same chain-of-custody discipline throughout keeps the evidence usable for both the regulatory filing and any future legal proceeding. Option b.', 25, 2),

  ('mission-w68-06-o3-c1', 'orientation', 'You''ve already handled the notification and preserved the evidence -- combine them.', 20, 1),
  ('mission-w68-06-o3-c1', 'solution', 'Regulators and affected individuals are notified on time, the jurisdiction gap is separately addressed with counsel, and the same disciplined chain of custody supports both the regulatory filing and any future proceeding.', 35, 2);
