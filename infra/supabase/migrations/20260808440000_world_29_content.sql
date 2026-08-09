-- world-29 ("API Security: API Hydra") mission content, generated from
-- docs/12-world-story-bible.md. Continues directly from World 28's
-- discovery of the /sentinel/evaluate endpoint. Mission 1 is
-- cross-world-gated on world-28's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-29a', 'world-29', 'api-hydra', '29A - API Hydra', 'One identity trusted by several modern services -- many heads growing from a single compromised token.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-29a-1', 'campaign-29a', 'foundations', 'Foundations', 'REST, GraphQL and webhook authorization, learned through failures that differ from classic injection.', 1),
  ('operation-29a-2', 'campaign-29a', 'investigation', 'Investigation', 'Inventory every service that trusts one identity, and close the chain while preserving real integrations.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w29-01', 'world-29', 'campaign-29a', 'operation-29a-1', 'many-heads', 'Many Heads', '/sentinel/evaluate isn''t one integration. At least four different services trust calls signed with the same identity.', 'intro', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w28-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w29-02', 'world-29', 'campaign-29a', 'operation-29a-1', 'this-caller-this-object', 'This Caller, This Object', 'Object-level authorization means checking that this caller owns this specific object -- not just that they''re logged in at all.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w29-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"bola-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w29-03', 'world-29', 'campaign-29a', 'operation-29a-1', 'a-valid-token-wrong-function', 'A Valid Token, Wrong Function', 'The caller is real, the token is valid -- the server just never checks whether their role should be allowed to call this specific function.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w29-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"bfla-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w29-04', 'world-29', 'campaign-29a', 'operation-29a-2', 'ask-for-any-shape', 'Ask for Any Shape', 'GraphQL lets a client ask for exactly the shape of data it wants. That''s also exactly the problem, if the server doesn''t limit what''s allowed to be asked for.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w29-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"graphql-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w29-05', 'world-29', 'campaign-29a', 'operation-29a-2', 'prove-it-came-from-you', 'Prove It Came From You', 'A webhook receiver has to prove the request actually came from who it claims to be from. Trusting any POST body that shows up is how you get spoofed.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w29-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"webhook-verification-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w29-06', 'world-29', 'campaign-29a', 'operation-29a-2', 'api-hydra-boss', 'API Hydra', 'Inventory every service that trusts a call signed with the sentinel identity, then close the chain without breaking a single legitimate integration.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w29-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"api-hydra-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["api-hydra"],"skillXp":{"web_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w29-01', 1, 'zayn', 'Traced /sentinel/evaluate outward. It''s not one integration -- at least four different services trust calls signed with the same identity.'),
  ('mission-w29-01', 2, 'byte', 'One compromised identity, many heads. That''s not a metaphor, that''s literally how this is architected.'),
  ('mission-w29-01', 3, 'zayn', 'REST, GraphQL, webhooks, API gateways. Different shapes, same underlying question: does this API actually verify who''s asking, and what they''re allowed to ask for?'),
  ('mission-w29-01', 4, 'byte', 'Let''s map every head before we try to cut one off.'),
  ('mission-w29-02', 1, 'zayn', 'Object-level authorization means checking that this caller owns this specific object -- not just that they''re logged in at all.'),
  ('mission-w29-03', 1, 'byte', 'Function-level authorization is a different failure. The caller is real, the token is valid -- the server just never checks whether their role should be allowed to call this specific function.'),
  ('mission-w29-04', 1, 'zayn', 'GraphQL lets a client ask for exactly the shape of data it wants. That''s also exactly the problem, if the server doesn''t limit what shapes are allowed to be asked for.'),
  ('mission-w29-05', 1, 'byte', 'A webhook receiver has to prove the request actually came from who it claims to be from. Trusting the body of any POST that shows up is how you get spoofed.'),
  ('mission-w29-06', 1, 'zayn', 'Inventory every service that trusts a call signed with the sentinel identity. All of them. That''s the hydra.'),
  ('mission-w29-06', 2, 'byte', '...Four services confirmed: Nexus Market''s role endpoint, a billing integration, a partner logistics API, and an internal alerting webhook. All trusting the same token.'),
  ('mission-w29-06', 3, 'zayn', 'One identity, four heads, all needing to be closed without breaking whatever legitimate integration actually depends on each one.'),
  ('mission-w29-06', 4, 'byte', 'Pulled the orchestrator''s own account record to see what we''re dealing with. It doesn''t store a password at all. Never did.'),
  ('mission-w29-06', 5, 'zayn', 'No password to steal, no password to crack. Just tokens, and whichever service identity was willing to trust them.'),
  ('mission-w29-06', 6, 'byte', 'That changes how we think about credentials completely. Passwords are only one model. This whole incident ran on a completely different one.'),
  ('mission-w29-06', 7, 'zayn', 'Which is exactly the comparison we need to make next -- passwords versus tokens versus service identity, and why one survives compromise so much better than the others.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w29-01-o1', 'mission-w29-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to map every service trusting this identity.'),
  ('mission-w29-02-o1', 'mission-w29-02', 1, 'Confirm the object-level authorization break', 'Identify the evidence confirming a broken object-level authorization vulnerability.'),
  ('mission-w29-03-o1', 'mission-w29-03', 1, 'Name the function-level authorization failure', 'Identify the vulnerability class behind a role-mismatched but token-valid request.'),
  ('mission-w29-04-o1', 'mission-w29-04', 1, 'Spot GraphQL over-exposure', 'Identify which GraphQL results show the API exposing more than it should.'),
  ('mission-w29-05-o1', 'mission-w29-05', 1, 'Classify webhook verification', 'Sort each webhook receiver as verifying the sender or trusting any sender.'),
  ('mission-w29-06-o1', 'mission-w29-06', 1, 'Inventory every trusting service', 'Identify every service that trusts a call signed with the sentinel identity.'),
  ('mission-w29-06-o2', 'mission-w29-06', 2, 'Choose the correct fix', 'Select the fix that closes the chain while preserving legitimate integrations.'),
  ('mission-w29-06-o3', 'mission-w29-06', 3, 'Close the hydra', 'Confirm the full inventory and the fix together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w29-01-o1-c1', 'mission-w29-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"zayn","text":"One identity, several heads. Ready to map all of them?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w29-02-o1-c1', 'mission-w29-02-o1', 1, 'investigation', 'Which evidence confirms a broken object-level authorization vulnerability?', '{"evidence":[{"id":"o1","label":"GET /api/v2/invoices/8834","detail":"Returns invoice 8834, belonging to the authenticated caller''s own account"},{"id":"o2","label":"GET /api/v2/invoices/8835","detail":"Returns invoice 8835, belonging to a completely different customer -- same token, no ownership check performed"},{"id":"o3","label":"API server source comment","detail":"\"TODO: verify invoice.customer_id matches session.customer_id -- ticket filed 2023, never completed\""}],"question":"Which evidence confirms a broken object-level authorization vulnerability?"}'::jsonb, '{"requiredEvidenceIds":["o2","o3"]}'::jsonb),

  ('mission-w29-03-o1-c1', 'mission-w29-03-o1', 1, 'multiple_choice', 'A standard customer-role API token is used to call POST /api/v2/admin/users/promote. The server accepts the request and promotes the account. What failure does this show?', '{"question":"A standard customer-role API token is used to call POST /api/v2/admin/users/promote. The server accepts the request and promotes the account. What failure does this show?","options":[{"id":"a","text":"SQL injection"},{"id":"b","text":"Broken function-level authorization -- the server validated the token was real but never checked whether a customer-role caller should be allowed to call an admin-only function"},{"id":"c","text":"A CSRF vulnerability"},{"id":"d","text":"A rate-limiting failure"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w29-04-o1-c1', 'mission-w29-04-o1', 1, 'investigation', 'Which results show the GraphQL API exposing more than it should?', '{"evidence":[{"id":"g1","label":"GraphQL introspection query result","detail":"Reveals a mutation named adminResetAllSessions that was never documented in the public API reference"},{"id":"g2","label":"A nested query requesting user, orders, items, supplier, internalCostPrice","detail":"Returns internal supplier cost data never meant to be exposed to storefront clients, several relationships deep"},{"id":"g3","label":"A standard query requesting product name and price","detail":"Returns exactly the public catalog data expected, nothing more"}],"question":"Which results show the GraphQL API exposing more than it should?"}'::jsonb, '{"requiredEvidenceIds":["g1","g2"]}'::jsonb),

  ('mission-w29-05-o1-c1', 'mission-w29-05-o1', 1, 'drag_and_drop', 'Sort each webhook receiver as verifying the sender or trusting any sender.', '{"items":[{"id":"w1","text":"Webhook receiver verifies an HMAC signature header against a shared secret before processing the payload"},{"id":"w2","text":"Webhook receiver processes any POST body that arrives at the endpoint, with no verification at all"},{"id":"w3","text":"Webhook receiver checks the source IP against an allowlist AND verifies the signature"},{"id":"w4","text":"Webhook receiver only checks that the Content-Type header says application/json"}],"targets":[{"id":"trustworthy","label":"Verifies the sender"},{"id":"spoofable","label":"Trusts any sender"}]}'::jsonb, '{"correctMapping":{"w1":"trustworthy","w2":"spoofable","w3":"trustworthy","w4":"spoofable"}}'::jsonb),

  ('mission-w29-06-o1-c1', 'mission-w29-06-o1', 1, 'investigation', 'Which services trust a call signed with the sentinel identity''s token?', '{"evidence":[{"id":"s1","label":"Nexus Market role-management endpoint","detail":"Accepts sentinel-signed tokens without additional verification"},{"id":"s2","label":"Billing integration service","detail":"Accepts the same token format, no service-specific scope check"},{"id":"s3","label":"Partner logistics API","detail":"Accepts the same token format, no service-specific scope check"},{"id":"s4","label":"Internal alerting webhook","detail":"Accepts the same token format, triggers internal notifications on request"},{"id":"s5","label":"Public marketing newsletter API","detail":"Uses a completely separate authentication system, unaffected"}],"question":"Which services trust a call signed with the sentinel identity''s token?"}'::jsonb, '{"requiredEvidenceIds":["s1","s2","s3","s4"]}'::jsonb),

  ('mission-w29-06-o2-c1', 'mission-w29-06-o2', 1, 'multiple_choice', 'What''s the correct fix that closes this cross-service chain while preserving each legitimate integration?', '{"question":"What''s the correct fix that closes this cross-service chain while preserving each legitimate integration?","options":[{"id":"a","text":"Delete the sentinel identity entirely with no replacement"},{"id":"b","text":"Issue narrowly scoped, per-service tokens instead of one universal identity trusted everywhere, and require each service to verify the scope matches its own function"},{"id":"c","text":"Just rotate the existing universal token"},{"id":"d","text":"Disable all four integrations permanently"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w29-06-o3-c1', 'mission-w29-06-o3', 1, 'boss_encounter', 'Confirm the full inventory and the fix together.', '{"stages":[{"objectiveRef":"mission-w29-06-o1","label":"Every trusting service"},{"objectiveRef":"mission-w29-06-o2","label":"The fix"}],"task":"Confirm the full inventory and the fix together."}'::jsonb, '{"requiredObjectiveIds":["mission-w29-06-o1","mission-w29-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w29-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w29-02-o1-c1', 'orientation', 'One request behaves correctly. One doesn''t. Something in the code explains why.', 15, 1),
  ('mission-w29-02-o1-c1', 'concept', 'A missing ownership check means any valid token can request any object ID, not just ones the caller actually owns.', 25, 2),
  ('mission-w29-02-o1-c1', 'solution', 'The unauthorized invoice access (o2) combined with the source comment admitting the check was never implemented (o3) together confirm the vulnerability.', 35, 3),

  ('mission-w29-03-o1-c1', 'orientation', 'The token itself isn''t the problem here -- what it''s being allowed to do is.', 15, 1),
  ('mission-w29-03-o1-c1', 'concept', 'Authentication (is this token real) and function-level authorization (should this role call this function) are two separate checks -- this failure is specifically the second one.', 25, 2),
  ('mission-w29-03-o1-c1', 'solution', 'The token is genuinely valid, but the server never checked whether a customer role should be allowed to call an admin-only function. Option b.', 35, 3),

  ('mission-w29-04-o1-c1', 'orientation', 'One of these three results is exactly what a normal storefront client would ask for.', 15, 1),
  ('mission-w29-04-o1-c1', 'concept', 'Introspection reveals the full schema, including things never meant to be documented publicly. Deeply nested queries can reach data several relationships away from where the client should ever look.', 25, 2),
  ('mission-w29-04-o1-c1', 'solution', 'The undocumented admin mutation (g1) and the deeply nested query reaching internal cost data (g2) both show over-exposure -- the basic product query (g3) is exactly what''s expected.', 35, 3),

  ('mission-w29-05-o1-c1', 'orientation', 'Two of these four receivers actually check who sent the request. Two just accept whatever arrives.', 15, 1),
  ('mission-w29-05-o1-c1', 'solution', 'Signature verification (w1) and signature-plus-IP-allowlist (w3) both actually verify the sender. Accepting any body (w2) and only checking a spoofable header (w4) both trust any sender.', 25, 2),

  ('mission-w29-06-o1-c1', 'orientation', 'Four of these five services share the same authentication mechanism. One doesn''t.', 15, 1),
  ('mission-w29-06-o1-c1', 'concept', 'Every service accepting the sentinel-signed token format without its own scope check is part of the same exposure, regardless of what the service actually does.', 25, 2),
  ('mission-w29-06-o1-c1', 'tool_direction', 'Check which services rely on a separate authentication system entirely -- that one is unaffected.', 35, 3),
  ('mission-w29-06-o1-c1', 'solution', 'The role endpoint, billing integration, partner logistics API and alerting webhook (s1-s4) all trust the same token format -- the newsletter API (s5) uses a separate system and is unaffected.', 45, 4),

  ('mission-w29-06-o2-c1', 'orientation', 'The fix needs to keep every legitimate integration working while making sure no single stolen token reaches all of them again.', 15, 1),
  ('mission-w29-06-o2-c1', 'solution', 'Per-service scoped tokens, verified against each service''s own function, close every head without breaking any of the real integrations. Option b.', 25, 2),

  ('mission-w29-06-o3-c1', 'orientation', 'You''ve already inventoried the heads and chosen the fix -- combine them.', 20, 1),
  ('mission-w29-06-o3-c1', 'concept', 'The closure needs to name every trusting service and the scoping fix that closes all of them at once.', 30, 2),
  ('mission-w29-06-o3-c1', 'tool_direction', 'List the four trusting services first, then the per-service scoping fix.', 40, 3),
  ('mission-w29-06-o3-c1', 'near_solution', 'Four services trust the universal sentinel token: the role endpoint, billing, partner logistics, and alerting. Fix: replace it with narrowly scoped, per-service tokens.', 50, 4),
  ('mission-w29-06-o3-c1', 'solution', 'Four services -- the Nexus Market role endpoint, the billing integration, the partner logistics API, and the internal alerting webhook -- all trust the same universal sentinel-signed token. Closing the hydra means replacing it with narrowly scoped, per-service tokens, each verified against that service''s own function, so no single stolen credential ever reaches all four again.', 65, 5);
