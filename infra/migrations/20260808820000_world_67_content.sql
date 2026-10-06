-- world-67 ("Security Program Management: Program Zero") mission content,
-- generated from docs/12-world-story-bible.md. Continues Act 9 "Command".
-- Mission 1 is cross-world-gated on world-66's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-67a', 'world-67', 'program-zero', '67A - Program Zero', 'The board approved the strategy. The organization still doesn''t have the people, process, or budget to actually execute it.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-67a-1', 'campaign-67a', 'foundations', 'Foundations', 'Roadmaps, staffing, budgeting and metrics, presented as a multi-quarter strategy simulation.', 1),
  ('operation-67a-2', 'campaign-67a', 'investigation', 'Investigation', 'Build a 12-month program that materially reduces Sentinel-related risk under fixed budget and staffing.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w67-01', 'world-67', 'campaign-67a', 'operation-67a-1', 'approved-doesnt-mean-staffed', 'Approved Doesn''t Mean Staffed', 'The board approved the strategy. That''s a starting line, not a finish line -- the organization still needs people, process and budget to actually execute it.', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w66-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w67-02', 'world-67', 'campaign-67a', 'operation-67a-1', 'what-has-to-happen-before-what', 'What Has to Happen Before What', 'A 12-month roadmap isn''t a wish list. Some initiatives are prerequisites for others, whether or not the calendar agrees.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w67-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"roadmap-sequencing-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w67-03', 'world-67', 'campaign-67a', 'operation-67a-1', 'three-open-roles-eight-priorities', 'Three Open Roles, Eight Priorities', 'Limited headcount, more priorities than people to cover them. Every staffing decision is really a prioritization decision in disguise.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w67-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"staffing-allocation-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w67-04', 'world-67', 'campaign-67a', 'operation-67a-1', 'a-metric-that-actually-means-something', 'A Metric That Actually Means Something', 'A dashboard full of numbers means nothing if none of them would actually change a decision. Real metrics either predict a problem or confirm progress.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w67-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"kpi-kri-design-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w67-05', 'world-67', 'campaign-67a', 'operation-67a-2', 'a-vendor-that-wont-show-its-work', 'A Vendor That Won''t Show Its Work', 'A key supplier keeps passing the annual security questionnaire, but has stopped providing the underlying evidence anyone can actually verify.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w67-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"supplier-management-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w67-06', 'world-67', 'campaign-67a', 'operation-67a-2', 'program-zero-boss', 'Program Zero', 'Build a 12-month program that materially reduces Sentinel-related risk, under the fixed budget and staffing this organization actually has.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w67-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"program-zero-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["program-zero"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w67-01', 1, 'luna', 'The board approved the strategy. That''s a starting line, not a finish line. This organization still doesn''t have the people, process or budget to actually execute it.'),
  ('mission-w67-01', 2, 'ava', 'A 12-month program, fixed budget, fixed headcount. This is where strategy either becomes real or stays a slide deck.'),
  ('mission-w67-02', 1, 'zayn', 'A roadmap isn''t a wish list. Some initiatives are hard prerequisites for others -- you can''t build detection maturity metrics before you''ve built the detections to measure.'),
  ('mission-w67-03', 1, 'byte', 'Three open roles, eight competing priorities. Every staffing decision here is really a prioritization decision wearing a job requisition.'),
  ('mission-w67-04', 1, 'ava', 'A dashboard full of numbers means nothing if none of them would actually change a decision. A real metric either predicts a problem coming or confirms real progress.'),
  ('mission-w67-05', 1, 'luna', 'A key supplier keeps passing the annual questionnaire, but has quietly stopped providing the evidence behind it. A checkbox isn''t proof.'),
  ('mission-w67-06', 1, 'luna', 'Build the 12-month program. Sequenced, staffed, funded, and measured. It has to materially reduce our Sentinel-related risk with what we actually have.'),
  ('mission-w67-06', 2, 'zayn', '...Program built. Sequenced correctly, staffed within headcount, funded within budget, and every initiative tied to a metric that would actually move if it worked.'),
  ('mission-w67-06', 3, 'ava', 'That''s a real program, not a strategy document nobody executes.'),
  ('mission-w67-06', 4, 'byte', 'One open item from this program touches that supplier issue directly. They''ve now formally refused to provide the evidence we requested.'),
  ('mission-w67-06', 5, 'luna', 'Refused, not delayed?'),
  ('mission-w67-06', 6, 'byte', 'Refused. Citing their own confidentiality obligations to other customers.'),
  ('mission-w67-06', 7, 'luna', 'Then this just became a legal question as much as a technical one. Time to bring in people who actually understand where that line sits.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w67-01-o1', 'mission-w67-01', 1, 'Acknowledge the briefing', 'Confirm you understand this world runs under fixed budget and staffing.'),
  ('mission-w67-02-o1', 'mission-w67-02', 1, 'Sequence the roadmap', 'Order the initiatives so each prerequisite comes before what depends on it.'),
  ('mission-w67-03-o1', 'mission-w67-03', 1, 'Allocate limited headcount', 'Choose the staffing allocation that covers the highest-priority gaps first.'),
  ('mission-w67-04-o1', 'mission-w67-04', 1, 'Choose the real metric', 'Identify which proposed metric would actually inform a decision versus which is a vanity number.'),
  ('mission-w67-05-o1', 'mission-w67-05', 1, 'Decide how to handle the vendor gap', 'Choose the correct response to a vendor that stopped providing verifiable evidence.'),
  ('mission-w67-06-o1', 'mission-w67-06', 1, 'Sequence the 12-month program', 'Order the program''s initiatives across the year according to their real dependencies.'),
  ('mission-w67-06-o2', 'mission-w67-06', 2, 'Fit the program to budget and staffing', 'Choose the program scope that fits within the fixed budget and headcount.'),
  ('mission-w67-06-o3', 'mission-w67-06', 3, 'Confirm the program', 'Confirm the sequencing and the resourcing together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w67-01-o1-c1', 'mission-w67-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"luna","text":"Strategy meets budget and headcount. Ready to build the real thing?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w67-02-o1-c1', 'mission-w67-02-o1', 1, 'interactive_diagram', 'Order these initiatives so each prerequisite comes before what depends on it.', '{"hotspots":[{"id":"init_visibility","label":"Deploy centralized logging and detection coverage across critical systems","explanation":"A prerequisite -- nothing downstream can be measured without this data existing first."},{"id":"init_detect_metrics","label":"Build detection-coverage and mean-time-to-detect metrics","explanation":"Requires the logging and detection from the previous step to already exist."},{"id":"init_tabletop","label":"Run incident response tabletop exercises using real detection data","explanation":"Needs both the detections and their metrics to be meaningful, not hypothetical."}],"task":"Order the initiatives by dependency."}'::jsonb, '{"correctOrderIds":["init_visibility","init_detect_metrics","init_tabletop"]}'::jsonb),

  ('mission-w67-03-o1-c1', 'mission-w67-03-o1', 1, 'multiple_choice', 'Three open security roles. Which allocation covers the highest-priority gaps first, given the program''s top risk is unmonitored critical infrastructure?', '{"question":"Three open security roles. Which allocation covers the highest-priority gaps first, given the program''s top risk is unmonitored critical infrastructure?","options":[{"id":"a","text":"Three roles focused entirely on marketing-facing website security"},{"id":"b","text":"One detection engineer, one incident responder, one security architect focused on the critical infrastructure gap -- directly matched to the program''s top risk"},{"id":"c","text":"Three generalist roles with no specific mandate"},{"id":"d","text":"Leave all three roles unfilled to save budget"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w67-04-o1-c1', 'mission-w67-04-o1', 1, 'investigation', 'Which of these two proposed metrics would actually inform a decision?', '{"evidence":[{"id":"metric1","label":"Metric A: \"Number of security awareness emails sent this quarter\"","detail":"Measures activity, not outcome -- doesn''t indicate whether anyone changed behavior or whether risk went down"},{"id":"metric2","label":"Metric B: \"Mean time to detect a confirmed intrusion, tracked quarter over quarter\"","detail":"Directly reflects whether detection capability is actually improving, and would trigger a real response if it got worse"}],"question":"Which metric is the meaningful one?"}'::jsonb, '{"requiredEvidenceIds":["metric2"]}'::jsonb),

  ('mission-w67-05-o1-c1', 'mission-w67-05-o1', 1, 'multiple_choice', 'A critical supplier stops providing verifiable evidence behind their security questionnaire answers, citing confidentiality to other customers. What''s the correct response?', '{"question":"A critical supplier stops providing verifiable evidence behind their security questionnaire answers, citing confidentiality to other customers. What''s the correct response?","options":[{"id":"a","text":"Accept the questionnaire answers at face value and move on"},{"id":"b","text":"Escalate formally -- request a third-party audit report or contractual right-to-audit clause, and involve legal if the supplier continues to refuse verifiable evidence for a critical relationship"},{"id":"c","text":"Immediately terminate the contract with no further discussion"},{"id":"d","text":"Ignore the gap since the supplier has been reliable in the past"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w67-06-o1-c1', 'mission-w67-06-o1', 1, 'interactive_diagram', 'Sequence the 12-month program by real dependency, quarter by quarter.', '{"hotspots":[{"id":"q1","label":"Q1: Deploy logging/detection coverage and fill the critical-infrastructure roles","explanation":"Foundational -- nothing else in the program can be measured or staffed correctly without this."},{"id":"q2","label":"Q2: Build detection and response metrics on top of the new coverage","explanation":"Depends entirely on Q1''s data existing."},{"id":"q3","label":"Q3: Run tabletop exercises and formalize the supplier evidence-review process","explanation":"Uses the metrics from Q2 to make the exercises realistic."},{"id":"q4","label":"Q4: Report measured risk reduction to the board using a full year of real metrics","explanation":"Only possible once a full cycle of real data exists."}],"task":"Order the program by quarter and dependency."}'::jsonb, '{"correctOrderIds":["q1","q2","q3","q4"]}'::jsonb),

  ('mission-w67-06-o2-c1', 'mission-w67-06-o2', 1, 'multiple_choice', 'The fixed budget covers three new hires and one major tooling purchase, not both a large tooling suite and a full team expansion. What''s the correct scope decision?', '{"question":"The fixed budget covers three new hires and one major tooling purchase, not both a large tooling suite and a full team expansion. What''s the correct scope decision?","options":[{"id":"a","text":"Buy the largest available tooling suite and skip hiring entirely"},{"id":"b","text":"Hire the three roles matched to the top risk, and choose the single tooling purchase that most directly supports what those roles need to do their job"},{"id":"c","text":"Split the budget evenly with no connection between hires and tooling"},{"id":"d","text":"Request more budget and delay the entire program a year"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w67-06-o3-c1', 'mission-w67-06-o3', 1, 'boss_encounter', 'Confirm the program sequencing and the resourcing plan together.', '{"stages":[{"objectiveRef":"mission-w67-06-o1","label":"The program sequencing"},{"objectiveRef":"mission-w67-06-o2","label":"The resourcing plan"}],"task":"Confirm the program sequencing and the resourcing plan together."}'::jsonb, '{"requiredObjectiveIds":["mission-w67-06-o1","mission-w67-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w67-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w67-02-o1-c1', 'orientation', 'Ask what data or capability each initiative actually needs to exist before it can produce anything meaningful.', 15, 1),
  ('mission-w67-02-o1-c1', 'solution', 'Logging and detection has to exist before metrics can measure it, and metrics have to exist before a tabletop exercise can use real data instead of guesses.', 25, 2),

  ('mission-w67-03-o1-c1', 'orientation', 'Match the roles directly to the program''s stated top risk, not to a generic notion of "more security."', 15, 1),
  ('mission-w67-03-o1-c1', 'solution', 'Roles matched directly to the unmonitored critical infrastructure gap -- detection, response, and architecture -- address the actual top risk. Option b.', 25, 2),

  ('mission-w67-04-o1-c1', 'orientation', 'Ask whether the metric would actually change what anyone does, or just fill a slide.', 15, 1),
  ('mission-w67-04-o1-c1', 'solution', 'Mean time to detect (metric2) reflects real capability and would trigger action if it worsened -- emails sent (metric1) is a vanity activity count.', 25, 2),

  ('mission-w67-05-o1-c1', 'orientation', 'A questionnaire answer without verifiable evidence is a claim, not proof.', 15, 1),
  ('mission-w67-05-o1-c1', 'solution', 'Formally escalating for a third-party audit or right-to-audit clause, involving legal if needed, is proportionate for a critical relationship -- accepting the claim or terminating outright are both extremes. Option b.', 25, 2),

  ('mission-w67-06-o1-c1', 'orientation', 'Apply the same dependency logic from the roadmap-sequencing mission, now across a full year.', 15, 1),
  ('mission-w67-06-o1-c1', 'solution', 'Foundational coverage and staffing in Q1, metrics built on that data in Q2, exercises and supplier process using those metrics in Q3, and a board report using a full year of real data in Q4.', 25, 2),

  ('mission-w67-06-o2-c1', 'orientation', 'Connect the tooling purchase directly to what the newly hired roles actually need, not to what sounds impressive.', 15, 1),
  ('mission-w67-06-o2-c1', 'solution', 'Hiring the three roles matched to the top risk, and buying the one tool that directly supports their work, uses the fixed budget coherently. Option b.', 25, 2),

  ('mission-w67-06-o3-c1', 'orientation', 'You''ve already sequenced the program and fit it to budget -- combine them.', 20, 1),
  ('mission-w67-06-o3-c1', 'solution', 'The program builds foundational coverage and staffing in Q1, metrics in Q2, exercises and supplier process in Q3, and a board report in Q4 -- all funded by three risk-matched hires and one directly supporting tooling purchase, within the fixed budget.', 35, 2);
