-- world-22 ("Identity & Access Management: Who Are You?") mission content,
-- generated from docs/12-world-story-bible.md. Continues directly from
-- World 21's closing question ("who is still authenticated as who, and
-- why"). Mission 1 is cross-world-gated on world-21's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-22a', 'world-22', 'who-are-you', '22A - Who Are You?', 'Accounts tied to a retired laboratory still authenticate across modern systems. Follow one identity across every one of them.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-22a-1', 'campaign-22a', 'foundations', 'Foundations', 'Authentication versus authorization, federation and tokens, learned by tracing one identity, not defending one system.', 1),
  ('operation-22a-2', 'campaign-22a', 'investigation', 'Investigation', 'Find the identity path that survived every organizational change, and close it.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w22-01', 'world-22', 'campaign-22a', 'operation-22a-1', 'a-familiar-name', 'A Familiar Name', 'Accounts tied to the same retired laboratory are still authenticating today, across systems that have nothing to do with it.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w21-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w22-02', 'world-22', 'campaign-22a', 'operation-22a-1', 'two-different-questions', 'Two Different Questions', 'Who you are and what you''re allowed to do are two different questions. Confusing them is how privilege creeps.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w22-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"authn-authz-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w22-03', 'world-22', 'campaign-22a', 'operation-22a-1', 'the-handshake', 'The Handshake', 'Federation means proving your identity once and having other systems trust that proof. Every step is a place trust can be misplaced.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w22-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"federation-flow-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w22-04', 'world-22', 'campaign-22a', 'operation-22a-2', 'read-the-claim', 'Read the Claim', 'A token isn''t a password. It''s a claim. Read exactly what it claims -- not what you assume it says.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w22-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"token-inspection-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w22-05', 'world-22', 'campaign-22a', 'operation-22a-2', 'role-or-attribute', 'Role or Attribute', 'RBAC asks what role you hold. ABAC asks what''s true about you right now. Neither forgives being sloppy about defaults.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w22-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"rbac-abac-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w22-06', 'world-22', 'campaign-22a', 'operation-22a-2', 'the-orphaned-identity-boss', 'The Orphaned Identity', 'Find the identity path that survived every organizational change since the lab closed, and close it -- without breaking anything still needed.', 'boss', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w22-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"orphaned-identity-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["orphaned-identity"],"skillXp":{"pentesting":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w22-01', 1, 'ava', 'The signing key traced back to a real laboratory. Now we''re seeing accounts tied to that same lab still authenticating -- today, across systems that have nothing to do with it.'),
  ('mission-w22-01', 2, 'byte', 'Follow one identity far enough and it tells you more about an organization''s mistakes than any single system does.'),
  ('mission-w22-01', 3, 'ava', 'Authentication, authorization, federation -- today we''re not defending a system. We''re tracing an identity. Or something still using one.'),
  ('mission-w22-01', 4, 'byte', 'Let''s find out exactly who -- or what -- these accounts actually are now.'),
  ('mission-w22-02', 1, 'ava', 'Two different questions get conflated constantly: who are you, and what are you allowed to do. Confusing them is how privilege creeps.'),
  ('mission-w22-03', 1, 'byte', 'Federation means proving your identity once and having other systems trust that proof. Every step in that handshake is a place trust can be misplaced.'),
  ('mission-w22-04', 1, 'ava', 'A token isn''t a password. It''s a claim. Read exactly what it claims -- not what you assume it says.'),
  ('mission-w22-05', 1, 'byte', 'RBAC asks what role you hold. ABAC asks what''s true about you right now. Neither one forgives being sloppy about defaults.'),
  ('mission-w22-06', 1, 'ava', 'Find the identity path that survived every organizational change since the lab closed, and close it -- without breaking anything that''s actually still needed.'),
  ('mission-w22-06', 2, 'byte', '...Ava. This one isn''t a leftover human account. It''s a service principal. sentinel-orchestrator.'),
  ('mission-w22-06', 3, 'ava', 'A service identity, still active, with machine-to-machine privileges. Nobody re-certified it because nobody remembered it existed.'),
  ('mission-w22-06', 4, 'byte', 'It authenticates other things. That''s not a stale account sitting idle -- that''s infrastructure.'),
  ('mission-w22-06', 5, 'ava', 'Then the real question isn''t who sentinel-orchestrator is. It''s why our architecture ever let one identity reach this far in the first place. Time to look at the whole design, not just the accounts.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w22-01-o1', 'mission-w22-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to trace an identity instead of defending a system.'),
  ('mission-w22-02-o1', 'mission-w22-02', 1, 'Distinguish authentication from authorization', 'Explain what a mismatch between login failure and continued access actually shows.'),
  ('mission-w22-03-o1', 'mission-w22-03', 1, 'Order the federation handshake', 'Order the steps of a federated login handshake as they actually occur.'),
  ('mission-w22-04-o1', 'mission-w22-04', 1, 'Spot the over-privileged token', 'Identify the evidence showing a token grants far more access than the service should need.'),
  ('mission-w22-05-o1', 'mission-w22-05', 1, 'Classify each access scenario', 'Sort each scenario as reasonable RBAC, reasonable ABAC, or a lifecycle failure.'),
  ('mission-w22-06-o1', 'mission-w22-06', 1, 'Find the identity that survived', 'Identify the evidence showing an identity path that survived the lab''s closure.'),
  ('mission-w22-06-o2', 'mission-w22-06', 2, 'Choose the correct remediation', 'Select the remediation that closes the path without breaking real dependencies.'),
  ('mission-w22-06-o3', 'mission-w22-06', 3, 'Close the investigation', 'Confirm the surviving identity and its remediation together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w22-01-o1-c1', 'mission-w22-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"ava","text":"Ready to trace an identity instead of defending a system?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w22-02-o1-c1', 'mission-w22-02-o1', 1, 'multiple_choice', 'A disabled human account can no longer log into the SSO portal. But a service still accepts an API token issued to that same account years ago and never revoked. What does this show?', '{"question":"A disabled human account can no longer log into the SSO portal. But a service still accepts an API token issued to that same account years ago and never revoked. What does this show?","options":[{"id":"a","text":"Authentication and authorization are the same thing, so this must be one bug"},{"id":"b","text":"Authentication (proving who you are at login) and authorization (what a previously issued credential still permits) are separate -- revoking one doesn''t automatically revoke the other"},{"id":"c","text":"API tokens can''t be tied to human accounts"},{"id":"d","text":"The account was never actually disabled"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w22-03-o1-c1', 'mission-w22-03-o1', 1, 'interactive_diagram', 'Order the steps of this federated login handshake as they actually occur.', '{"hotspots":[{"id":"redirect","label":"User is redirected to the identity provider''s login page","explanation":"The relying application never sees the user''s actual password -- it hands off authentication entirely."},{"id":"authenticate","label":"User authenticates directly with the identity provider","explanation":"Credentials are verified only by the party that issued them."},{"id":"consent","label":"Identity provider issues an authorization code back to the application","explanation":"A short-lived, single-use code -- not the actual access token yet."},{"id":"exchange","label":"Application exchanges the code for an access token, server-to-server","explanation":"This step never touches the user''s browser, keeping the token off any redirect URL."}],"task":"Order the steps of this federated login handshake as they actually occur."}'::jsonb, '{"correctOrderIds":["redirect","authenticate","consent","exchange"]}'::jsonb),

  ('mission-w22-04-o1-c1', 'mission-w22-04-o1', 1, 'investigation', 'Which evidence shows this token grants far more access than the service it belongs to should ever need?', '{"evidence":[{"id":"t1","label":"Decoded JWT header","detail":"{\"alg\":\"RS256\",\"typ\":\"JWT\"}"},{"id":"t2","label":"Decoded JWT payload","detail":"{\"sub\":\"svc-legacy-sync\",\"scope\":\"read:inventory write:inventory admin:all\",\"aud\":\"nexus-market-api\"}"},{"id":"t3","label":"Service documentation for svc-legacy-sync","detail":"\"Read-only inventory sync job, scheduled nightly\""},{"id":"t4","label":"Token issuance log","detail":"Token minted three years ago, never rotated, expiry set nearly 30 years in the future"}],"question":"Which evidence shows this token grants far more access than the service it belongs to should ever need?"}'::jsonb, '{"requiredEvidenceIds":["t2","t3"]}'::jsonb),

  ('mission-w22-05-o1-c1', 'mission-w22-05-o1', 1, 'drag_and_drop', 'Sort each scenario as reasonable RBAC, reasonable ABAC, or a lifecycle failure.', '{"items":[{"id":"r1","text":"A support engineer role that can view customer records but not export them"},{"id":"r2","text":"A finance role granted access only during business hours from a corporate-managed device"},{"id":"r3","text":"A one-off admin grant given for a migration project, never removed afterward"},{"id":"r4","text":"A contractor account still active six months after the contract ended"}],"targets":[{"id":"good_rbac","label":"Reasonable role-based design"},{"id":"good_abac","label":"Reasonable attribute-based design"},{"id":"lifecycle_failure","label":"Identity-lifecycle failure"}]}'::jsonb, '{"correctMapping":{"r1":"good_rbac","r2":"good_abac","r3":"lifecycle_failure","r4":"lifecycle_failure"}}'::jsonb),

  ('mission-w22-06-o1-c1', 'mission-w22-06-o1', 1, 'investigation', 'Which evidence together shows an identity path that survived the lab''s closure and is still active today?', '{"evidence":[{"id":"p1","label":"Organizational directory","detail":"The Guardian-adjacent laboratory was marked closed in HR records four years ago"},{"id":"p2","label":"Directory query for lab-linked principals","detail":"Every human account from the lab is disabled -- except one service principal, sentinel-orchestrator, still marked active"},{"id":"p3","label":"Authentication activity for sentinel-orchestrator","detail":"It has requested and received service credentials as recently as this week"},{"id":"p4","label":"Badge access records","detail":"No physical badge activity for the lab''s building in over three years -- unrelated to a service account''s digital access"}],"question":"Which evidence together shows an identity path that survived the lab''s closure and is still active today?"}'::jsonb, '{"requiredEvidenceIds":["p2","p3"]}'::jsonb),

  ('mission-w22-06-o2-c1', 'mission-w22-06-o2', 1, 'multiple_choice', 'What''s the correct remediation for sentinel-orchestrator?', '{"question":"What''s the correct remediation for sentinel-orchestrator?","options":[{"id":"a","text":"Leave it alone -- it''s clearly load-bearing infrastructure"},{"id":"b","text":"Immediately delete it without notice"},{"id":"c","text":"Inventory everything it authenticates, then re-certify, scope down, or replace it under a properly owned identity before deprovisioning the old one"},{"id":"d","text":"Just rotate its password"}]}'::jsonb, '{"correctOptionId":"c"}'::jsonb),

  ('mission-w22-06-o3-c1', 'mission-w22-06-o3', 1, 'boss_encounter', 'Confirm the surviving identity and its remediation together.', '{"stages":[{"objectiveRef":"mission-w22-06-o1","label":"The identity that survived"},{"objectiveRef":"mission-w22-06-o2","label":"The remediation"}],"task":"Confirm the surviving identity and its remediation together."}'::jsonb, '{"requiredObjectiveIds":["mission-w22-06-o1","mission-w22-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w22-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w22-02-o1-c1', 'orientation', 'Login failing is about proving identity. A token still working is about what was already granted.', 10, 1),
  ('mission-w22-02-o1-c1', 'solution', 'Disabling login (authentication) doesn''t automatically revoke previously issued permissions (authorization) -- they''re separate systems that both need to be updated. Option b.', 20, 2),

  ('mission-w22-03-o1-c1', 'orientation', 'The user''s browser is only involved in the first half of this handshake.', 15, 1),
  ('mission-w22-03-o1-c1', 'concept', 'The authorization code is deliberately short-lived and useless on its own -- it has to be exchanged for a real token in a separate, server-to-server step.', 25, 2),
  ('mission-w22-03-o1-c1', 'solution', 'redirect -> authenticate -> consent (code issued) -> exchange (code traded for a token, server-to-server).', 35, 3),

  ('mission-w22-04-o1-c1', 'orientation', 'Compare what the token actually claims against what the service is documented to do.', 15, 1),
  ('mission-w22-04-o1-c1', 'concept', 'A read-only nightly job has no legitimate reason to hold a write or admin scope.', 25, 2),
  ('mission-w22-04-o1-c1', 'solution', 'The payload''s admin:all scope (t2) directly contradicts the documented read-only purpose of the service (t3) -- that mismatch is the over-privilege.', 35, 3),

  ('mission-w22-05-o1-c1', 'orientation', 'Two of these are ongoing, intentional access designs. Two are grants that were never cleaned up.', 15, 1),
  ('mission-w22-05-o1-c1', 'solution', 'r1 is role-based (defined by job function), r2 is attribute-based (defined by conditions like time and device), r3 and r4 are both lifecycle failures -- access that outlived its purpose.', 25, 2),

  ('mission-w22-06-o1-c1', 'orientation', 'Look for the one principal that didn''t get disabled along with everything else from the lab.', 15, 1),
  ('mission-w22-06-o1-c1', 'concept', 'Being marked active and actually being used are two different confirmations -- you need both.', 25, 2),
  ('mission-w22-06-o1-c1', 'tool_direction', 'Check the directory status and recent authentication activity together.', 35, 3),
  ('mission-w22-06-o1-c1', 'solution', 'sentinel-orchestrator is the one lab-linked principal still marked active (p2), and it has authenticated as recently as this week (p3) -- together they confirm a live, surviving identity path.', 45, 4),

  ('mission-w22-06-o2-c1', 'orientation', 'Deleting it blind risks breaking whatever depends on it. Ignoring it leaves the exposure open.', 15, 1),
  ('mission-w22-06-o2-c1', 'solution', 'The responsible path is inventory first, then re-certify or replace under proper ownership, then deprovision the old identity -- not an immediate blind deletion or doing nothing. Option c.', 25, 2),

  ('mission-w22-06-o3-c1', 'orientation', 'You''ve already found both halves -- combine the identity with its fix.', 20, 1),
  ('mission-w22-06-o3-c1', 'concept', 'The closure needs to name the surviving identity and the remediation path, not just flag that a problem exists.', 30, 2),
  ('mission-w22-06-o3-c1', 'tool_direction', 'State which principal survived and how it authenticates, then the inventory-first remediation.', 40, 3),
  ('mission-w22-06-o3-c1', 'near_solution', 'sentinel-orchestrator, still authenticating as a service principal; remediate by inventorying its dependencies, then re-certifying or replacing it under proper ownership before deprovisioning.', 50, 4),
  ('mission-w22-06-o3-c1', 'solution', 'sentinel-orchestrator is a service principal from the closed laboratory that was never re-certified and is still authenticating with machine-to-machine privileges. Close it by inventorying everything it authenticates, then re-certifying, scoping down, or replacing it under a properly owned identity before deprovisioning the old one.', 65, 5);
