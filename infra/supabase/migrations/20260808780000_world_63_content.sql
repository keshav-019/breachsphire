-- world-63 ("Product Security: Secure by Design") mission content,
-- generated from docs/12-world-story-bible.md. Closes Act 8 "Zero Day".
-- Mission 1 is cross-world-gated on world-62's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-63a', 'world-63', 'secure-by-design', '63A - Secure by Design', 'A product team, before a single line of code exists, trying to prevent the next Sentinel-compatible failure instead of finding it afterward.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-63a-1', 'campaign-63a', 'foundations', 'Foundations', 'Threat modelling, architecture review and dependency risk, learned as a proactive discipline.', 1),
  ('operation-63a-2', 'campaign-63a', 'investigation', 'Investigation', 'Approve, revise, or reject a new product architecture, and justify the security requirements before launch.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w63-01', 'world-63', 'campaign-63a', 'operation-63a-1', 'before-the-code-exists', 'Before the Code Exists', 'Luna is asking you to join a product team before a single line of code has been written. This time, the job is to prevent the next Sentinel-compatible failure, not investigate it after the fact.', 'intro', ARRAY['luna', 'ava'], '{"requiredMissionIds":["mission-w62-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w63-02', 'world-63', 'campaign-63a', 'operation-63a-1', 'naming-the-threats-before-they-exist', 'Naming the Threats Before They Exist', 'A threat model asks what could go wrong before anything has actually gone wrong. Every proposed feature gets sorted into categories of failure.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w63-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"threat-modeling-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w63-03', 'world-63', 'campaign-63a', 'operation-63a-1', 'a-boundary-that-was-never-drawn', 'A Boundary That Was Never Drawn', 'An architecture diagram, missing exactly one trust boundary. Everything downstream of that gap inherits the risk.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w63-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"architecture-review-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w63-04', 'world-63', 'campaign-63a', 'operation-63a-2', 'a-dependency-request-worth-questioning', 'A Dependency Request Worth Questioning', 'A team wants to add a new third-party dependency. After everything this year, that request gets a real evaluation.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w63-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"dependency-risk-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w63-05', 'world-63', 'campaign-63a', 'operation-63a-2', 'the-gate-before-launch', 'The Gate Before Launch', 'A release checklist stands between this product and its launch date. Some items on it are not optional, no matter the deadline.', 'intermediate', ARRAY['luna'], '{"requiredMissionIds":["mission-w63-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"release-gate-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w63-06', 'world-63', 'campaign-63a', 'operation-63a-2', 'secure-by-design-boss', 'Secure by Design', 'Approve, revise, or reject this new product architecture, and justify the security requirements you''re attaching to it before launch.', 'boss', ARRAY['luna', 'zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w63-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"secure-by-design-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["secure-by-design"],"skillXp":{"web_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w63-01', 1, 'luna', 'Join a product team before a single line of code has been written. This time, prevent the next Sentinel-compatible failure. Don''t investigate it afterward.'),
  ('mission-w63-01', 2, 'ava', 'Everything you''ve learned all year -- request smuggling, poisoned dependencies, memory corruption -- none of it started as an emergency. It started as a decision nobody questioned.'),
  ('mission-w63-02', 1, 'zayn', 'A threat model asks what could go wrong before anything has actually gone wrong. Sort every proposed feature into what kind of failure it could invite.'),
  ('mission-w63-03', 1, 'byte', 'An architecture diagram, missing exactly one trust boundary. Everything downstream of that gap inherits whatever risk lives on the other side of it.'),
  ('mission-w63-04', 1, 'ava', 'A team wants a new third-party dependency added. After everything this year, that request earns a real evaluation, not a rubber stamp.'),
  ('mission-w63-05', 1, 'luna', 'A release checklist stands between this product and its launch date. Some items on it are not optional, no matter how close that date is.'),
  ('mission-w63-06', 1, 'luna', 'Approve it, revise it, or reject it. Whatever you decide, justify the security requirements in terms the product team can actually act on.'),
  ('mission-w63-06', 2, 'zayn', '...Decision made: revise, not reject. The core design is sound. Two specific gaps need closing before this ships.'),
  ('mission-w63-06', 3, 'byte', 'Missing trust boundary on the ingestion path, and no dependency review gate in the build pipeline. Both fixable before launch, neither fixable after an incident.'),
  ('mission-w63-06', 4, 'ava', 'That''s the whole point of this world. You caught both before either one became a headline.'),
  ('mission-w63-06', 5, 'luna', 'Here''s what this exercise should make clear. Look back at every incident this year. How many of them were really about a missing patch, and how many were about a decision nobody ever revisited?'),
  ('mission-w63-06', 6, 'byte', 'Most of them trace back further than the technical failure. To a choice that was never written down, or a boundary nobody was assigned to own.'),
  ('mission-w63-06', 7, 'luna', 'Technical failures and governance failures. You''re about to spend an entire act learning the second kind.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w63-01-o1', 'mission-w63-01', 1, 'Acknowledge the briefing', 'Confirm you understand this world is about prevention, not investigation.'),
  ('mission-w63-02-o1', 'mission-w63-02', 1, 'Categorize the threats', 'Sort each proposed feature risk into its correct threat category.'),
  ('mission-w63-03-o1', 'mission-w63-03', 1, 'Find the missing trust boundary', 'Identify where the architecture diagram is missing a trust boundary.'),
  ('mission-w63-04-o1', 'mission-w63-04', 1, 'Evaluate the dependency request', 'Choose the correct evaluation outcome for the proposed dependency.'),
  ('mission-w63-05-o1', 'mission-w63-05', 1, 'Identify the non-negotiable gate item', 'Determine which release checklist item cannot be waived regardless of deadline.'),
  ('mission-w63-06-o1', 'mission-w63-06', 1, 'Decide on the architecture', 'Choose whether to approve, revise, or reject the proposed architecture.'),
  ('mission-w63-06-o2', 'mission-w63-06', 2, 'Justify the requirements', 'Select the security requirements that must accompany the decision.'),
  ('mission-w63-06-o3', 'mission-w63-06', 3, 'Confirm the decision', 'Confirm the architecture decision and its justified requirements together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w63-01-o1-c1', 'mission-w63-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"luna","text":"Prevention, not investigation, this time. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w63-02-o1-c1', 'mission-w63-02-o1', 1, 'drag_and_drop', 'Sort each proposed feature risk into its correct threat category.', '{"items":[{"id":"t1","text":"A user could log in as someone else by guessing a predictable session token"},{"id":"t2","text":"A user could modify another user''s order after checkout without authorization"},{"id":"t3","text":"A user could deny placing an order after it shipped, with no audit trail proving otherwise"},{"id":"t4","text":"A user could flood the checkout endpoint and prevent other users from placing orders"}],"targets":[{"id":"spoofing","label":"Spoofing"},{"id":"tampering","label":"Tampering"},{"id":"repudiation","label":"Repudiation"},{"id":"dos","label":"Denial of Service"}]}'::jsonb, '{"correctMapping":{"t1":"spoofing","t2":"tampering","t3":"repudiation","t4":"dos"}}'::jsonb),

  ('mission-w63-03-o1-c1', 'mission-w63-03-o1', 1, 'interactive_diagram', 'Where is this architecture diagram missing a trust boundary?', '{"hotspots":[{"id":"client","label":"Public client application","explanation":"Untrusted by definition -- correctly treated as outside the trust boundary."},{"id":"api_gateway","label":"API gateway, validates authentication","explanation":"Correctly positioned as the trust boundary between public and internal."},{"id":"internal_service","label":"Internal ingestion service, accepts data directly from a third-party partner feed with no validation before processing","explanation":"A second external input with no trust boundary drawn around it at all -- the gap."},{"id":"database","label":"Database, only reachable from internal services","explanation":"Correctly isolated from direct external access."}],"task":"Which component sits outside any drawn trust boundary despite accepting external input?"}'::jsonb, '{"correctOrderIds":["internal_service"]}'::jsonb),

  ('mission-w63-04-o1-c1', 'mission-w63-04-o1', 1, 'multiple_choice', 'A team wants to add a new third-party dependency with 40 weekly downloads, published two weeks ago, with no provenance attestation available. What''s the correct evaluation outcome?', '{"question":"A team wants to add a new third-party dependency with 40 weekly downloads, published two weeks ago, with no provenance attestation available. What''s the correct evaluation outcome?","options":[{"id":"a","text":"Approve immediately -- new packages are usually fine"},{"id":"b","text":"Reject or require justification and a security review before approval -- low adoption, no track record, and no provenance are exactly the pattern from this year''s supply-chain incident"},{"id":"c","text":"Approve, but only tell the security team after it''s already in production"},{"id":"d","text":"Approve automatically since it passed a basic license check"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w63-05-o1-c1', 'mission-w63-05-o1', 1, 'browser_simulation', 'Which release checklist item cannot be waived regardless of the launch deadline?', '{"screen":"release-gate-checklist","items":[{"id":"i1","label":"Marketing copy final review","waivable":true},{"id":"i2","label":"Threat model reviewed and open findings triaged","waivable":false},{"id":"i3","label":"Optional UI animation polish","waivable":true},{"id":"i4","label":"Non-critical performance benchmark on a rarely used endpoint","waivable":true}],"question":"Which item is non-negotiable?"}'::jsonb, '{"correctOptionId":"i2"}'::jsonb),

  ('mission-w63-06-o1-c1', 'mission-w63-06-o1', 1, 'multiple_choice', 'The core architecture is sound, but has one missing trust boundary and one missing dependency-review gate, both fixable before launch. What''s the correct decision?', '{"question":"The core architecture is sound, but has one missing trust boundary and one missing dependency-review gate, both fixable before launch. What''s the correct decision?","options":[{"id":"a","text":"Reject outright -- start over from scratch"},{"id":"b","text":"Revise -- approve the core design, but require the two specific gaps closed before launch"},{"id":"c","text":"Approve unconditionally -- minor issues can be patched after launch"},{"id":"d","text":"Delay the decision indefinitely with no clear requirements"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w63-06-o2-c1', 'mission-w63-06-o2', 1, 'drag_and_drop', 'Select every requirement that belongs in the justification for this decision.', '{"items":[{"id":"r1","text":"Add a trust boundary and input validation around the third-party ingestion path"},{"id":"r2","text":"Add a dependency-review gate to the build pipeline before any new package is approved"},{"id":"r3","text":"Rewrite the entire product in a different language"},{"id":"r4","text":"Add marketing approval as a security gate"}],"targets":[{"id":"required","label":"Required before launch"},{"id":"not_required","label":"Not required / out of scope"}]}'::jsonb, '{"correctMapping":{"r1":"required","r2":"required","r3":"not_required","r4":"not_required"}}'::jsonb),

  ('mission-w63-06-o3-c1', 'mission-w63-06-o3', 1, 'boss_encounter', 'Confirm the architecture decision and its justified requirements together.', '{"stages":[{"objectiveRef":"mission-w63-06-o1","label":"The decision"},{"objectiveRef":"mission-w63-06-o2","label":"The justified requirements"}],"task":"Confirm the architecture decision and its justified requirements together."}'::jsonb, '{"requiredObjectiveIds":["mission-w63-06-o1","mission-w63-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w63-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w63-02-o1-c1', 'orientation', 'STRIDE: Spoofing, Tampering, Repudiation, Information disclosure, Denial of service, Elevation of privilege -- ask which category each scenario matches.', 15, 1),
  ('mission-w63-02-o1-c1', 'solution', 'Impersonation is spoofing, unauthorized modification is tampering, denying an action with no audit trail is repudiation, and flooding a service is denial of service.', 25, 2),

  ('mission-w63-03-o1-c1', 'orientation', 'Trust boundaries belong wherever external, untrusted input enters the system -- check every entry point, not just the obvious client-facing one.', 15, 1),
  ('mission-w63-03-o1-c1', 'solution', 'The internal ingestion service accepts data directly from an external partner feed with no trust boundary or validation drawn around it -- a second, overlooked entry point.', 25, 2),

  ('mission-w63-04-o1-c1', 'orientation', 'Compare this request against the exact pattern from the supply-chain incident earlier this year.', 15, 1),
  ('mission-w63-04-o1-c1', 'solution', 'Low download count, brand-new publish date, and no provenance are the same red flags from the poisoned-dependency incident -- this needs a real security review, not automatic approval. Option b.', 25, 2),

  ('mission-w63-05-o1-c1', 'orientation', 'Ask which item, if skipped, could let a known risk ship silently.', 15, 1),
  ('mission-w63-05-o1-c1', 'solution', 'An unreviewed threat model with untriaged findings is the one item that directly risks shipping a known, unaddressed security gap -- everything else is cosmetic or non-critical.', 25, 2),

  ('mission-w63-06-o1-c1', 'orientation', 'A sound core design with fixable, specific gaps doesn''t call for starting over or ignoring the gaps.', 15, 1),
  ('mission-w63-06-o1-c1', 'solution', 'Revising -- approving the core design while requiring the two specific gaps closed -- matches the actual risk level. Rejecting is disproportionate; approving unconditionally ignores known gaps.', 25, 2),

  ('mission-w63-06-o2-c1', 'orientation', 'Each requirement should map directly to one of the two gaps you actually found.', 15, 1),
  ('mission-w63-06-o2-c1', 'solution', 'A trust boundary on the ingestion path and a dependency-review gate in the pipeline map directly to the two findings -- a full rewrite or a marketing gate would be disproportionate and out of scope.', 25, 2),

  ('mission-w63-06-o3-c1', 'orientation', 'You''ve already made the decision and selected the requirements -- combine them.', 20, 1),
  ('mission-w63-06-o3-c1', 'solution', 'The correct decision is to revise: approve the sound core design, but require a trust boundary around the third-party ingestion path and a dependency-review gate in the build pipeline before launch.', 35, 2);
