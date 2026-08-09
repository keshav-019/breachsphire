-- world-65 ("Risk Management: Risk Ledger") mission content, generated from
-- docs/12-world-story-bible.md. Continues Act 9 "Command". Mission 1 is
-- cross-world-gated on world-64's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-65a', 'world-65', 'risk-ledger', '65A - Risk Ledger', 'Executives cannot fund every control technical teams request. Every decision here is a real tradeoff, not a checklist item.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-65a-1', 'campaign-65a', 'foundations', 'Foundations', 'Threat, vulnerability, likelihood, impact, and inherent versus residual risk, learned through real budget tradeoffs.', 1),
  ('operation-65a-2', 'campaign-65a', 'investigation', 'Investigation', 'Present a prioritized risk treatment plan for the inherited Sentinel assets.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w65-01', 'world-65', 'campaign-65a', 'operation-65a-1', 'not-an-unlimited-budget', 'Not an Unlimited Budget', 'Every control the technical teams want costs something. Leadership cannot fund all of it. Risk management is how you decide what actually matters most.', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w64-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w65-02', 'world-65', 'campaign-65a', 'operation-65a-1', 'the-four-words-everyone-mixes-up', 'The Four Words Everyone Mixes Up', 'Threat, vulnerability, likelihood, impact. Four distinct concepts, constantly used interchangeably by people who should know better.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w65-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"risk-components-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w65-03', 'world-65', 'campaign-65a', 'operation-65a-1', 'what-is-left-after-the-control', 'What Is Left After the Control', 'A control never eliminates risk completely. What remains after it''s applied is the number that actually matters for the next decision.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w65-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"residual-risk-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w65-04', 'world-65', 'campaign-65a', 'operation-65a-1', 'a-number-versus-a-color', 'A Number Versus a Color', 'One scenario, scored two ways -- a red/yellow/green heat map, and a dollar-figure estimate. Both are legitimate. They answer different questions.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w65-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"risk-scoring-methods-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w65-05', 'world-65', 'campaign-65a', 'operation-65a-2', 'four-ways-to-respond', 'Four Ways to Respond', 'Accept it, mitigate it, transfer it, or avoid it entirely. Every identified risk gets one of these four responses, deliberately chosen.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w65-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"risk-response-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w65-06', 'world-65', 'campaign-65a', 'operation-65a-2', 'risk-ledger-boss', 'Risk Ledger', 'Present a prioritized risk treatment plan for the inherited Sentinel assets, under a fixed budget that can''t cover everything.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w65-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"risk-ledger-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["risk-ledger"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w65-01', 1, 'luna', 'Every control the technical teams want costs money and time. We cannot fund all of it. Risk management is how we decide what actually matters most.'),
  ('mission-w65-01', 2, 'ava', 'This isn''t about finding more vulnerabilities. It''s about deciding, with real tradeoffs, which ones deserve the budget first.'),
  ('mission-w65-02', 1, 'zayn', 'Threat, vulnerability, likelihood, impact. Four distinct concepts. Mixing them up is how risk conversations go in circles.'),
  ('mission-w65-03', 1, 'byte', 'A control never eliminates risk completely. What''s left after it''s applied -- the residual risk -- is the number that actually matters for the next decision.'),
  ('mission-w65-04', 1, 'ava', 'One scenario, scored two ways. A red/yellow/green heat map, and a dollar-figure estimate. Both legitimate. They answer different questions for different audiences.'),
  ('mission-w65-05', 1, 'luna', 'Accept it, mitigate it, transfer it, or avoid it entirely. Every risk on this ledger gets one of these four responses, deliberately chosen -- never left undecided.'),
  ('mission-w65-06', 1, 'luna', 'Present the treatment plan for the assets we inherited from that legacy system. Budget is fixed. Prioritize.'),
  ('mission-w65-06', 2, 'zayn', '...Plan built. Highest-risk items funded first, lower-priority items formally accepted with documented rationale, not just ignored.'),
  ('mission-w65-06', 3, 'ava', 'That distinction matters. "Accepted with rationale" and "nobody got around to it" look identical on a spreadsheet and mean completely different things.'),
  ('mission-w65-06', 4, 'byte', 'While building this ledger, I found something in the inherited system''s old records. Project SENTINEL was never formally closed.'),
  ('mission-w65-06', 5, 'luna', 'Never closed. Meaning its risk was never formally assigned to anyone either.'),
  ('mission-w65-06', 6, 'byte', 'Correct. It looks like it was simply transferred between organizations, quietly, without ever being reviewed.'),
  ('mission-w65-06', 7, 'luna', 'An unreviewed, unowned risk, still active after all this time. That''s not a technical failure. That''s a governance failure.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w65-01-o1', 'mission-w65-01', 1, 'Acknowledge the briefing', 'Confirm you understand this world runs under real budget constraints.'),
  ('mission-w65-02-o1', 'mission-w65-02', 1, 'Match the risk components', 'Match threat, vulnerability, likelihood and impact to their correct definitions.'),
  ('mission-w65-03-o1', 'mission-w65-03', 1, 'Calculate residual risk', 'Determine what residual risk remains after a specific control is applied.'),
  ('mission-w65-04-o1', 'mission-w65-04', 1, 'Choose the right scoring method', 'Determine which risk-scoring method fits a given audience and decision.'),
  ('mission-w65-05-o1', 'mission-w65-05', 1, 'Match each risk to its response', 'Assign each risk scenario the correct response: accept, mitigate, transfer, or avoid.'),
  ('mission-w65-06-o1', 'mission-w65-06', 1, 'Prioritize the risk ledger', 'Rank the inherited risks by priority given a fixed budget.'),
  ('mission-w65-06-o2', 'mission-w65-06', 2, 'Choose the treatment for each risk', 'Assign the correct treatment to each risk given the funded budget.'),
  ('mission-w65-06-o3', 'mission-w65-06', 3, 'Confirm the treatment plan', 'Confirm the prioritized ranking and the treatment assignments together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w65-01-o1-c1', 'mission-w65-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"luna","text":"Real tradeoffs, real budget. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w65-02-o1-c1', 'mission-w65-02-o1', 1, 'drag_and_drop', 'Match each term to its correct definition.', '{"items":[{"id":"c1","text":"Threat"},{"id":"c2","text":"Vulnerability"},{"id":"c3","text":"Likelihood"},{"id":"c4","text":"Impact"}],"targets":[{"id":"d1","label":"A potential cause of an unwanted incident (e.g. an attacker, a natural disaster)"},{"id":"d2","label":"A weakness that could be exploited (e.g. an unpatched system)"},{"id":"d3","label":"How probable it is that the threat exploits the vulnerability"},{"id":"d4","label":"The consequence if the incident actually occurs"}]}'::jsonb, '{"correctMapping":{"c1":"d1","c2":"d2","c3":"d3","c4":"d4"}}'::jsonb),

  ('mission-w65-03-o1-c1', 'mission-w65-03-o1', 1, 'multiple_choice', 'A vulnerability has inherent risk rated "high." A compensating control reduces the likelihood of exploitation but doesn''t eliminate the vulnerability. What''s the residual risk?', '{"question":"A vulnerability has inherent risk rated \"high.\" A compensating control reduces the likelihood of exploitation but doesn''t eliminate the vulnerability. What''s the residual risk?","options":[{"id":"a","text":"Zero -- any control eliminates all risk"},{"id":"b","text":"Still nonzero, but lower than the inherent risk -- the vulnerability still exists, but is now harder to exploit"},{"id":"c","text":"Higher than the inherent risk -- controls always add risk"},{"id":"d","text":"Impossible to know without more information, so it should be ignored"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w65-04-o1-c1', 'mission-w65-04-o1', 1, 'investigation', 'Which scoring method fits presenting this risk to the board for a funding decision?', '{"evidence":[{"id":"m1","label":"Qualitative heat map","detail":"Shows the risk as \"high\" on a red/yellow/green scale -- fast to communicate, easy to compare across many risks at a glance"},{"id":"m2","label":"Quantitative estimate","detail":"Shows the risk as an estimated $2.4M annual loss exposure -- directly comparable to the cost of the proposed control"},{"id":"m3","label":"Both, together, in a board presentation about approving a specific $400K control budget"},{"id":"m4","label":"Neither -- present nothing"}],"question":"Which approach best supports a board funding decision?"}'::jsonb, '{"requiredEvidenceIds":["m3"]}'::jsonb),

  ('mission-w65-05-o1-c1', 'mission-w65-05-o1', 1, 'drag_and_drop', 'Assign each risk scenario its correct response.', '{"items":[{"id":"r1","text":"A low-impact, low-likelihood risk that would cost more to fix than it could ever cost if it occurred"},{"id":"r2","text":"A high-impact vulnerability in a system the organization plans to keep operating"},{"id":"r3","text":"A risk best covered by cyber insurance rather than an internal control"},{"id":"r4","text":"A risky legacy feature with low business value that can simply be shut down"}],"targets":[{"id":"accept","label":"Accept"},{"id":"mitigate","label":"Mitigate"},{"id":"transfer","label":"Transfer"},{"id":"avoid","label":"Avoid"}]}'::jsonb, '{"correctMapping":{"r1":"accept","r2":"mitigate","r3":"transfer","r4":"avoid"}}'::jsonb),

  ('mission-w65-06-o1-c1', 'mission-w65-06-o1', 1, 'interactive_diagram', 'Rank these three inherited risks by priority given limited budget.', '{"hotspots":[{"id":"risk_high","label":"Unpatched remote-access gateway on the inherited legacy system -- high likelihood, high impact","explanation":"Highest priority -- both dimensions are severe."},{"id":"risk_med","label":"Outdated encryption on an internal-only reporting tool -- low likelihood, medium impact","explanation":"Moderate priority -- limited exposure reduces urgency."},{"id":"risk_low","label":"Missing MFA on a decommissioned test environment scheduled for shutdown next month","explanation":"Lowest priority -- the asset is already being retired."}],"task":"Rank from highest to lowest priority."}'::jsonb, '{"correctOrderIds":["risk_high","risk_med","risk_low"]}'::jsonb),

  ('mission-w65-06-o2-c1', 'mission-w65-06-o2', 1, 'drag_and_drop', 'The budget covers full mitigation for only the top-ranked risk. Assign the correct treatment to each.', '{"items":[{"id":"t1","text":"Unpatched remote-access gateway (highest priority)"},{"id":"t2","text":"Outdated encryption on internal reporting tool (moderate priority)"},{"id":"t3","text":"Missing MFA on a system being decommissioned next month"}],"targets":[{"id":"mitigate_now","label":"Mitigate now (funded)"},{"id":"accept_documented","label":"Accept, with documented rationale"}]}'::jsonb, '{"correctMapping":{"t1":"mitigate_now","t2":"accept_documented","t3":"accept_documented"}}'::jsonb),

  ('mission-w65-06-o3-c1', 'mission-w65-06-o3', 1, 'boss_encounter', 'Confirm the prioritized ranking and the treatment assignments together.', '{"stages":[{"objectiveRef":"mission-w65-06-o1","label":"The priority ranking"},{"objectiveRef":"mission-w65-06-o2","label":"The treatment plan"}],"task":"Confirm the prioritized ranking and the treatment assignments together."}'::jsonb, '{"requiredObjectiveIds":["mission-w65-06-o1","mission-w65-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w65-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w65-02-o1-c1', 'orientation', 'Threat is who or what could cause harm; vulnerability is the weakness; likelihood and impact describe the "how probable" and "how bad."', 15, 1),
  ('mission-w65-02-o1-c1', 'solution', 'Threat = potential cause, vulnerability = exploitable weakness, likelihood = probability, impact = consequence.', 25, 2),

  ('mission-w65-03-o1-c1', 'orientation', 'A control that reduces likelihood doesn''t make the vulnerability disappear.', 15, 1),
  ('mission-w65-03-o1-c1', 'solution', 'Residual risk is lower than inherent risk but still nonzero -- the vulnerability still exists, just harder to exploit. Option b.', 25, 2),

  ('mission-w65-04-o1-c1', 'orientation', 'A board approving a specific budget needs both a quick comparison and a dollar figure to weigh against the cost.', 15, 1),
  ('mission-w65-04-o1-c1', 'solution', 'Presenting both the heat map and the dollar estimate together (m3) gives the board fast comparison and a direct cost-benefit figure -- either alone is less useful for a funding decision.', 25, 2),

  ('mission-w65-05-o1-c1', 'orientation', 'Ask: is this worth fixing, worth insuring, or worth just not doing at all?', 15, 1),
  ('mission-w65-05-o1-c1', 'solution', 'Low-cost-to-accept risks get accepted, high-impact risks on systems you''re keeping get mitigated, insurable risks get transferred, and low-value risky features get avoided by shutting them down.', 25, 2),

  ('mission-w65-06-o1-c1', 'orientation', 'Combine likelihood and impact together, not just one or the other.', 15, 1),
  ('mission-w65-06-o1-c1', 'solution', 'High-likelihood, high-impact ranks first; low-likelihood, medium-impact ranks second; a risk on an asset already being retired ranks last regardless of severity.', 25, 2),

  ('mission-w65-06-o2-c1', 'orientation', 'Only the top-ranked risk gets the funded mitigation -- everything else needs a documented, deliberate decision, not silence.', 15, 1),
  ('mission-w65-06-o2-c1', 'solution', 'The gateway gets funded mitigation now; the other two get formally accepted with documented rationale -- not ignored, just consciously deprioritized given the budget.', 25, 2),

  ('mission-w65-06-o3-c1', 'orientation', 'You''ve already ranked the risks and assigned treatments -- combine them.', 20, 1),
  ('mission-w65-06-o3-c1', 'solution', 'The gateway ranks highest and gets funded mitigation; the encryption and MFA gaps rank lower and are formally accepted with documented rationale under the fixed budget.', 35, 2);
