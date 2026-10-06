-- world-66 ("Governance: The Boardroom") mission content, generated from
-- docs/12-world-story-bible.md. Continues Act 9 "Command". Mission 1 is
-- cross-world-gated on world-65's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-66a', 'world-66', 'the-boardroom', '66A - The Boardroom', 'A board-level simulation, where every leader in the room has conflicting incentives, legal duties, and operational constraints of their own.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-66a-1', 'campaign-66a', 'foundations', 'Foundations', 'Policies, standards, accountability and frameworks, learned as decision systems, not paperwork.', 1),
  ('operation-66a-2', 'campaign-66a', 'investigation', 'Investigation', 'Obtain approval for a defensible security strategy while explaining risk in business language.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w66-01', 'world-66', 'campaign-66a', 'operation-66a-1', 'a-room-full-of-different-priorities', 'A Room Full of Different Priorities', 'The board isn''t hostile to security. Each person in this room simply has a different, legitimate priority pulling against every other one.', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w65-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w66-02', 'world-66', 'campaign-66a', 'operation-66a-1', 'not-the-same-document', 'Not the Same Document', 'A policy states intent. A standard sets a specific bar. A procedure spells out the exact steps. Confusing these three is how governance quietly stops working.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w66-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"policy-standard-procedure-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w66-03', 'world-66', 'campaign-66a', 'operation-66a-1', 'who-actually-signs-off', 'Who Actually Signs Off', 'For any given security decision, exactly one role should be accountable. Not the people who did the work -- the person who owns the outcome.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w66-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"accountability-mapping-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w66-04', 'world-66', 'campaign-66a', 'operation-66a-1', 'frameworks-that-say-the-same-thing-differently', 'Frameworks That Say the Same Thing Differently', 'Two different security frameworks, describing largely the same underlying controls in different language and different structure.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w66-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"framework-alignment-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w66-05', 'world-66', 'campaign-66a', 'operation-66a-2', 'finding-the-position-everyone-can-live-with', 'Finding the Position Everyone Can Live With', 'Legal wants zero exposure. Engineering wants shipping speed. Finance wants a number, not a feeling. Build a strategy all three can actually stand behind.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w66-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"board-dialogue-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w66-06', 'world-66', 'campaign-66a', 'operation-66a-2', 'the-boardroom-boss', 'The Boardroom', 'Obtain approval for a defensible security strategy from this board, explaining every element of risk in language a business leader can act on.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w66-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"the-boardroom-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["the-boardroom"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w66-01', 1, 'luna', 'The board isn''t hostile to security. Each person in that room has a different, legitimate priority pulling against every other one. Your job is a strategy all of them can actually approve.'),
  ('mission-w66-01', 2, 'ava', 'This world trades terminals for briefings. The skill doesn''t change -- you''re still translating a technical reality into a decision someone else has to make.'),
  ('mission-w66-02', 1, 'zayn', 'A policy states intent -- "we will protect customer data." A standard sets a specific bar -- "encryption must meet this specification." A procedure spells out the exact steps to meet it. Confuse the three, and governance quietly stops working.'),
  ('mission-w66-03', 1, 'byte', 'For any given decision, exactly one role should be accountable for it. Not everyone who touched the work -- the person who actually owns the outcome.'),
  ('mission-w66-04', 1, 'ava', 'Two frameworks, largely describing the same underlying controls, in completely different language and structure. Learn to translate between them.'),
  ('mission-w66-05', 1, 'luna', 'Legal wants zero exposure. Engineering wants shipping speed. Finance wants a number, not a feeling. Build a position all three can actually live with.'),
  ('mission-w66-06', 1, 'luna', 'Present the strategy. Every risk explained in terms this board can act on, not terms that only make sense to us.'),
  ('mission-w66-06', 2, 'zayn', '...Strategy approved. Funded, scoped, and every stakeholder in that room signed off on it for their own reasons.'),
  ('mission-w66-06', 3, 'ava', 'That''s the actual skill. Not just being right -- being persuasive to people who don''t share your technical vocabulary.'),
  ('mission-w66-06', 4, 'byte', 'While preparing that briefing, I pulled the board''s archived meeting minutes going back years, looking for precedent.'),
  ('mission-w66-06', 5, 'byte', 'Found something. Years ago, senior leadership approved something called "autonomous resilience testing," with what the minutes themselves describe as insufficient safeguards.'),
  ('mission-w66-06', 6, 'luna', 'That decision predates everyone currently in this room.'),
  ('mission-w66-06', 7, 'ava', 'Predates them, but nobody ever reversed it, either. Now we have to actually build a program that can execute a strategy this board can trust.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w66-01-o1', 'mission-w66-01', 1, 'Acknowledge the briefing', 'Confirm you understand this world is about translating risk for decision-makers.'),
  ('mission-w66-02-o1', 'mission-w66-02', 1, 'Classify governance documents', 'Match each document to whether it''s a policy, standard, or procedure.'),
  ('mission-w66-03-o1', 'mission-w66-03', 1, 'Identify the accountable role', 'Choose the single role accountable for a given security decision.'),
  ('mission-w66-04-o1', 'mission-w66-04', 1, 'Map controls across frameworks', 'Match a control described in one framework to its equivalent in another.'),
  ('mission-w66-05-o1', 'mission-w66-05', 1, 'Find the position all stakeholders can accept', 'Choose the strategy element that satisfies legal, engineering, and finance simultaneously.'),
  ('mission-w66-06-o1', 'mission-w66-06', 1, 'Frame the risk for the board', 'Choose the framing that explains the security strategy in business-actionable terms.'),
  ('mission-w66-06-o2', 'mission-w66-06', 2, 'Secure stakeholder approval', 'Select the version of the strategy that satisfies every board stakeholder''s stated constraint.'),
  ('mission-w66-06-o3', 'mission-w66-06', 3, 'Confirm the approval', 'Confirm the business framing and the approved strategy together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w66-01-o1-c1', 'mission-w66-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"luna","text":"Terminals to briefings, same underlying skill. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w66-02-o1-c1', 'mission-w66-02-o1', 1, 'drag_and_drop', 'Match each document to its correct type.', '{"items":[{"id":"g1","text":"\"The organization will protect customer data from unauthorized access.\""},{"id":"g2","text":"\"All data at rest must be encrypted using AES-256 or stronger.\""},{"id":"g3","text":"\"Step 1: open the key management console. Step 2: generate a new key with these exact parameters...\""}],"targets":[{"id":"policy","label":"Policy"},{"id":"standard","label":"Standard"},{"id":"procedure","label":"Procedure"}]}'::jsonb, '{"correctMapping":{"g1":"policy","g2":"standard","g3":"procedure"}}'::jsonb),

  ('mission-w66-03-o1-c1', 'mission-w66-03-o1', 1, 'multiple_choice', 'Who should be accountable for approving the organization''s overall risk appetite?', '{"question":"Who should be accountable for approving the organization''s overall risk appetite?","options":[{"id":"a","text":"Whichever engineer happens to be on call that week"},{"id":"b","text":"The board or executive leadership -- risk appetite is a strategic decision that sets the boundaries everyone else operates within"},{"id":"c","text":"No one -- risk appetite is implicit and doesn''t need explicit ownership"},{"id":"d","text":"An external vendor"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w66-04-o1-c1', 'mission-w66-04-o1', 1, 'investigation', 'Which control in Framework B is equivalent to "Identify" in the NIST CSF?', '{"evidence":[{"id":"fw1","label":"ISO 27001 Annex A: Asset Management (A.5.9-A.5.14)","detail":"Covers inventorying and classifying assets and understanding the environment -- the same underlying goal as NIST CSF''s Identify function"},{"id":"fw2","label":"ISO 27001 Annex A: Incident Management (A.5.24-A.5.28)","detail":"Covers detecting and responding to incidents -- aligns more with NIST CSF''s Detect and Respond functions"}],"question":"Which ISO control area maps to NIST CSF''s Identify function?"}'::jsonb, '{"requiredEvidenceIds":["fw1"]}'::jsonb),

  ('mission-w66-05-o1-c1', 'mission-w66-05-o1', 1, 'multiple_choice', 'Legal wants a hard blocking gate before every release. Engineering says that would miss every deadline. Finance wants predictable costs. What strategy element satisfies all three?', '{"question":"Legal wants a hard blocking gate before every release. Engineering says that would miss every deadline. Finance wants predictable costs. What strategy element satisfies all three?","options":[{"id":"a","text":"No review process at all, to keep engineering happy"},{"id":"b","text":"A risk-tiered review: automated, fast checks for low-risk changes, a scheduled deeper review only for high-risk changes -- bounded cost, predictable timeline, and real gates where they matter most"},{"id":"c","text":"A mandatory manual review on every single change, regardless of risk"},{"id":"d","text":"Let each team decide for itself with no consistent process"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w66-06-o1-c1', 'mission-w66-06-o1', 1, 'multiple_choice', 'How should the risk-tiered review strategy be framed for the board?', '{"question":"How should the risk-tiered review strategy be framed for the board?","options":[{"id":"a","text":"In terms of specific CVE numbers and technical implementation details"},{"id":"b","text":"In terms of reduced business risk, predictable cost, and maintained delivery speed -- the outcomes the board is actually accountable for"},{"id":"c","text":"As a purely technical decision the board doesn''t need to understand"},{"id":"d","text":"By avoiding any mention of cost"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w66-06-o2-c1', 'mission-w66-06-o2', 1, 'drag_and_drop', 'Confirm which stakeholder concern the final strategy actually addresses.', '{"items":[{"id":"concern1","text":"Legal: real gates where risk is highest"},{"id":"concern2","text":"Engineering: predictable, bounded review time"},{"id":"concern3","text":"Finance: fixed, forecastable cost"}],"targets":[{"id":"addressed","label":"Addressed by the risk-tiered strategy"}]}'::jsonb, '{"correctMapping":{"concern1":"addressed","concern2":"addressed","concern3":"addressed"}}'::jsonb),

  ('mission-w66-06-o3-c1', 'mission-w66-06-o3', 1, 'boss_encounter', 'Confirm the business framing and the approved strategy together.', '{"stages":[{"objectiveRef":"mission-w66-06-o1","label":"The business framing"},{"objectiveRef":"mission-w66-06-o2","label":"Stakeholder concerns addressed"}],"task":"Confirm the business framing and the approved strategy together."}'::jsonb, '{"requiredObjectiveIds":["mission-w66-06-o1","mission-w66-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w66-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w66-02-o1-c1', 'orientation', 'Policy is "why," standard is "how good," procedure is "exactly how."', 15, 1),
  ('mission-w66-02-o1-c1', 'solution', 'The intent statement is the policy, the specific requirement is the standard, and the step-by-step instructions are the procedure.', 25, 2),

  ('mission-w66-03-o1-c1', 'orientation', 'Ask who has the authority and the responsibility to actually set organization-wide boundaries.', 15, 1),
  ('mission-w66-03-o1-c1', 'solution', 'Risk appetite is a strategic boundary that everyone else operates within -- that has to sit with the board or executive leadership. Option b.', 25, 2),

  ('mission-w66-04-o1-c1', 'orientation', 'NIST CSF''s Identify function is about knowing your assets and environment before anything else.', 15, 1),
  ('mission-w66-04-o1-c1', 'solution', 'Asset Management (fw1) covers the same underlying goal as Identify -- knowing what you have before you can protect it. Incident Management (fw2) aligns with Detect/Respond instead.', 25, 2),

  ('mission-w66-05-o1-c1', 'orientation', 'A good compromise usually scales the process to the actual risk, rather than applying one blanket rule to everything.', 15, 1),
  ('mission-w66-05-o1-c1', 'solution', 'Risk-tiered review gives legal real gates on high-risk changes, gives engineering predictable timelines on low-risk ones, and gives finance a bounded, forecastable cost. Option b.', 25, 2),

  ('mission-w66-06-o1-c1', 'orientation', 'A board is accountable for business outcomes, not technical implementation.', 15, 1),
  ('mission-w66-06-o1-c1', 'solution', 'Framing around reduced business risk, predictable cost, and maintained delivery speed speaks directly to what the board is actually responsible for. Option b.', 25, 2),

  ('mission-w66-06-o2-c1', 'orientation', 'Check the strategy against each stakeholder''s original concern individually.', 15, 1),
  ('mission-w66-06-o2-c1', 'solution', 'The risk-tiered strategy gives legal real gates, engineering predictable time, and finance a fixed cost -- all three concerns are genuinely addressed, not just placated.', 25, 2),

  ('mission-w66-06-o3-c1', 'orientation', 'You''ve already framed the business case and confirmed every concern is addressed -- combine them.', 20, 1),
  ('mission-w66-06-o3-c1', 'solution', 'Framed around reduced risk, predictable cost and maintained speed, the risk-tiered review strategy genuinely satisfies legal''s need for real gates, engineering''s need for predictable time, and finance''s need for a fixed budget -- earning board approval on its actual merits.', 35, 2);
