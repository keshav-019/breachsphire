-- world-62 ("Advanced Application Security: Edge Cases") mission content,
-- generated from docs/12-world-story-bible.md. Continues Act 8 "Zero Day".
-- Mission 1 is cross-world-gated on world-61's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-62a', 'world-62', 'edge-cases', '62A - Edge Cases', 'Small application flaws, each scored low risk on its own, combined into chains no individual scanner finding ever explains.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-62a-1', 'campaign-62a', 'foundations', 'Foundations', 'Request smuggling, race conditions, deserialization and OAuth/SSO chains, learned as composition problems.', 1),
  ('operation-62a-2', 'campaign-62a', 'investigation', 'Investigation', 'Discover a multi-step chain no single finding explains, then break it at multiple layers.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w62-01', 'world-62', 'campaign-62a', 'operation-62a-1', 'nothing-here-scores-high', 'Nothing Here Scores High', 'Every scanner finding on this application is individually low severity. Sentinel-X isn''t exploiting any one of them. It''s exploiting the combination.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w61-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w62-02', 'world-62', 'campaign-62a', 'operation-62a-1', 'two-servers-disagreeing-about-where-a-request-ends', 'Two Servers Disagreeing About Where a Request Ends', 'A front-end proxy and a back-end server, parsing the same request boundary two different ways. That disagreement is a smuggled second request, hidden inside the first.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w62-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"request-smuggling-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w62-03', 'world-62', 'campaign-62a', 'operation-62a-1', 'the-gap-between-check-and-use', 'The Gap Between Check and Use', 'A coupon gets validated, then redeemed, as two separate steps. Fire both at once, many times, and the gap between them is where the bug lives.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w62-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"race-condition-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w62-04', 'world-62', 'campaign-62a', 'operation-62a-2', 'data-that-turns-into-behavior', 'Data That Turns Into Behavior', 'Deserializing untrusted data shouldn''t be able to change what code runs. This endpoint lets it.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w62-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"deserialization-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w62-05', 'world-62', 'campaign-62a', 'operation-62a-2', 'a-redirect-thats-trusted-too-much', 'A Redirect That''s Trusted Too Much', 'An OAuth flow that doesn''t strictly validate its redirect URI hands an attacker a way to walk off with someone else''s token.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w62-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"oauth-chain-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w62-06', 'world-62', 'campaign-62a', 'operation-62a-2', 'edge-cases-boss', 'Edge Cases', 'Discover the multi-step chain that no single scanner finding explains, and break it at every layer it depends on.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w62-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"edge-cases-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["edge-cases"],"skillXp":{"web_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w62-01', 1, 'ava', 'Every scanner finding on this application scores individually low. Sentinel-X isn''t exploiting any one of them -- it''s exploiting the combination.'),
  ('mission-w62-01', 2, 'byte', 'That means the usual approach -- fix the highest-severity finding first -- doesn''t apply here. We have to think in chains, not in isolated bugs.'),
  ('mission-w62-02', 1, 'zayn', 'A front-end proxy and the back-end server, parsing the same request boundary two different ways. That mismatch smuggles a second, hidden request inside the first.'),
  ('mission-w62-03', 1, 'byte', 'Validate, then redeem -- two separate steps. Fire both at once, many times over, and the gap between them is exactly where the bug lives.'),
  ('mission-w62-04', 1, 'zayn', 'Deserializing untrusted data shouldn''t be able to change what code actually runs. This endpoint lets it.'),
  ('mission-w62-05', 1, 'ava', 'An OAuth flow that doesn''t strictly validate its redirect URI hands an attacker a way to walk off with someone else''s token.'),
  ('mission-w62-06', 1, 'zayn', 'Individually, none of these findings would even get triaged as urgent. Chain them. Show exactly how they connect.'),
  ('mission-w62-06', 2, 'byte', '...Chain confirmed. The smuggled request races the coupon redemption to plant a malicious deserialized object, which the OAuth flow''s loose redirect validation then exfiltrates as a token.'),
  ('mission-w62-06', 3, 'ava', 'Break it at every layer, not just the easiest one to patch.'),
  ('mission-w62-06', 4, 'zayn', 'Done. Strict request parsing on both proxy and server, redemption made atomic, deserialization restricted to safe types, redirect URI strictly allow-listed.'),
  ('mission-w62-06', 5, 'byte', 'The deeper question is why this chain worked at all. None of these individual flaws are exotic.'),
  ('mission-w62-06', 6, 'ava', 'Because nobody designing this system ever assumed they''d be combined. That assumption was never written down, and it was never true.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w62-01-o1', 'mission-w62-01', 1, 'Acknowledge the briefing', 'Confirm you understand this requires thinking in chains, not isolated findings.'),
  ('mission-w62-02-o1', 'mission-w62-02', 1, 'Identify the smuggled request', 'Determine what a front-end/back-end parsing mismatch on request boundaries enables.'),
  ('mission-w62-03-o1', 'mission-w62-03', 1, 'Find the race window', 'Identify which sequence of requests exploits the gap between validation and redemption.'),
  ('mission-w62-04-o1', 'mission-w62-04', 1, 'Find the unsafe deserialization', 'Identify the line that deserializes untrusted data into an arbitrary type.'),
  ('mission-w62-05-o1', 'mission-w62-05', 1, 'Find the redirect URI gap', 'Identify which redirect URI validation is exploitable.'),
  ('mission-w62-06-o1', 'mission-w62-06', 1, 'Reconstruct the full chain', 'Order the complete chain from smuggled request to stolen token.'),
  ('mission-w62-06-o2', 'mission-w62-06', 2, 'Break every layer', 'Choose the fix set that closes every layer of the chain.'),
  ('mission-w62-06-o3', 'mission-w62-06', 3, 'Confirm the chain break', 'Confirm the full chain and the layered fixes together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w62-01-o1-c1', 'mission-w62-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"ava","text":"No single finding here is the story. The chain is. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w62-02-o1-c1', 'mission-w62-02-o1', 1, 'interactive_diagram', 'What does a front-end/back-end disagreement on request boundaries enable?', '{"hotspots":[{"id":"proxy_view","label":"Front-end proxy reads the Content-Length header and treats the request as ending there","explanation":"The proxy''s view of where the request stops."},{"id":"backend_view","label":"Back-end server reads the Transfer-Encoding header instead and treats the request as ending somewhere else","explanation":"A different, conflicting view of the same request stream."},{"id":"smuggled","label":"The leftover bytes the proxy didn''t forward as part of request 1 get interpreted by the back end as the start of request 2","explanation":"A hidden, smuggled request the proxy never inspected."}],"task":"Order the mismatch that produces a smuggled request."}'::jsonb, '{"correctOrderIds":["proxy_view","backend_view","smuggled"]}'::jsonb),

  ('mission-w62-03-o1-c1', 'mission-w62-03-o1', 1, 'investigation', 'Which request pattern exploits the gap between coupon validation and redemption?', '{"evidence":[{"id":"pattern1","label":"Pattern A","detail":"A single request: validate, then redeem, sequentially -- redemption correctly checked against the coupon''s remaining balance"},{"id":"pattern2","label":"Pattern B","detail":"20 identical redemption requests fired simultaneously, all passing validation before any single one updates the redeemed balance -- coupon redeemed 20 times from a balance of 1"}],"question":"Which pattern exploits the race window?"}'::jsonb, '{"requiredEvidenceIds":["pattern2"]}'::jsonb),

  ('mission-w62-04-o1-c1', 'mission-w62-04-o1', 1, 'code_debugging', 'Which line deserializes untrusted data into an arbitrary type?', '{"language":"java","code":"byte[] payload = request.getBody();\nObjectInputStream ois = new ObjectInputStream(new ByteArrayInputStream(payload));\nObject data = ois.readObject();\nprocessUserPreferences((UserPreferences) data);", "question":"Which line is the unsafe deserialization?"}'::jsonb, '{"requiredLineIds":["Object data = ois.readObject();"]}'::jsonb),

  ('mission-w62-05-o1-c1', 'mission-w62-05-o1', 1, 'multiple_choice', 'The OAuth authorization server validates redirect_uri using a simple prefix match against "https://app.example.com". Which redirect URI would incorrectly pass this check?', '{"question":"The OAuth authorization server validates redirect_uri using a simple prefix match against \"https://app.example.com\". Which redirect URI would incorrectly pass this check?","options":[{"id":"a","text":"https://app.example.com/callback"},{"id":"b","text":"https://app.example.com.attacker.net/steal"},{"id":"c","text":"https://otherapp.example.com/callback"},{"id":"d","text":"https://example.com/callback"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w62-06-o1-c1', 'mission-w62-06-o1', 1, 'interactive_diagram', 'Order the complete chain from smuggled request to stolen token.', '{"hotspots":[{"id":"smuggle","label":"A smuggled second request is hidden inside a legitimate one via the proxy/server parsing mismatch","explanation":"The entry point -- invisible to the proxy''s own inspection."},{"id":"race","label":"The smuggled request races the coupon redemption flow, planting a serialized object as the coupon''s metadata field","explanation":"Uses the race window to inject something that shouldn''t be reachable."},{"id":"deserialize","label":"That planted object gets deserialized when a later request reads the coupon metadata, executing attacker-controlled logic","explanation":"Turns planted data into actual behavior."},{"id":"oauth_exfil","label":"That logic completes an OAuth flow using a lookalike redirect URI that passes the loose prefix check, exfiltrating a valid token","explanation":"The final step -- turns code execution into a stolen credential."}],"task":"Order the full chain from smuggled request to stolen token."}'::jsonb, '{"correctOrderIds":["smuggle","race","deserialize","oauth_exfil"]}'::jsonb),

  ('mission-w62-06-o2-c1', 'mission-w62-06-o2', 1, 'drag_and_drop', 'Match each fix to the layer of the chain it breaks.', '{"items":[{"id":"f1","text":"Normalize request parsing identically on proxy and back end (reject ambiguous Content-Length/Transfer-Encoding combinations)"},{"id":"f2","text":"Make coupon validation and redemption a single atomic operation"},{"id":"f3","text":"Restrict deserialization to an explicit allow-list of safe types"},{"id":"f4","text":"Replace prefix-match redirect URI validation with exact allow-list matching"}],"targets":[{"id":"smuggle_fix","label":"The smuggled request"},{"id":"race_fix","label":"The race window"},{"id":"deserialize_fix","label":"The unsafe deserialization"},{"id":"oauth_fix","label":"The redirect URI gap"}]}'::jsonb, '{"correctMapping":{"f1":"smuggle_fix","f2":"race_fix","f3":"deserialize_fix","f4":"oauth_fix"}}'::jsonb),

  ('mission-w62-06-o3-c1', 'mission-w62-06-o3', 1, 'boss_encounter', 'Confirm the full chain and the layered fixes together.', '{"stages":[{"objectiveRef":"mission-w62-06-o1","label":"The full chain"},{"objectiveRef":"mission-w62-06-o2","label":"The fix for each layer"}],"task":"Confirm the full chain and the layered fixes together."}'::jsonb, '{"requiredObjectiveIds":["mission-w62-06-o1","mission-w62-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w62-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w62-02-o1-c1', 'orientation', 'Ask what happens to the bytes each side thinks belong to a different request.', 15, 1),
  ('mission-w62-02-o1-c1', 'solution', 'The proxy trusts Content-Length, the back end trusts Transfer-Encoding -- the leftover bytes from that disagreement get parsed by the back end as an entirely new, smuggled request.', 25, 2),

  ('mission-w62-03-o1-c1', 'orientation', 'A race needs concurrent requests hitting the same unprotected gap, not a single sequential one.', 15, 1),
  ('mission-w62-03-o1-c1', 'solution', 'Firing many redemption requests simultaneously (pattern B) exploits the gap between check and use -- a single sequential validate-then-redeem (pattern A) is safe.', 25, 2),

  ('mission-w62-04-o1-c1', 'orientation', 'Ask which line lets the attacker control what type of object actually gets constructed.', 15, 1),
  ('mission-w62-04-o1-c1', 'solution', 'readObject() deserializes whatever type the attacker''s payload specifies, before any type-safety check happens -- that''s the unsafe step.', 25, 2),

  ('mission-w62-05-o1-c1', 'orientation', 'A prefix match only checks that the string starts correctly -- it says nothing about the full domain.', 15, 1),
  ('mission-w62-05-o1-c1', 'solution', '"https://app.example.com.attacker.net/steal" starts with "https://app.example.com" as a literal string, passing a naive prefix check while actually pointing to an attacker-controlled domain. Option b.', 25, 2),

  ('mission-w62-06-o1-c1', 'orientation', 'Start from the step that requires no prior access at all.', 15, 1),
  ('mission-w62-06-o1-c1', 'concept', 'Each finding enables the next: smuggling hides a request, the race plants malicious data, deserialization turns that data into behavior, and the OAuth gap turns that behavior into a stolen token.', 25, 2),
  ('mission-w62-06-o1-c1', 'solution', 'Smuggled request -> races the redemption flow to plant a serialized object -> deserialization executes it -> a lookalike redirect URI exfiltrates a token via OAuth.', 35, 3),

  ('mission-w62-06-o2-c1', 'orientation', 'Match each fix to the specific layer it closes, not to "more security" in general.', 15, 1),
  ('mission-w62-06-o2-c1', 'solution', 'Consistent request parsing closes the smuggling layer, atomic redemption closes the race, an allow-list closes deserialization, and exact-match redirect validation closes the OAuth gap.', 25, 2),

  ('mission-w62-06-o3-c1', 'orientation', 'You''ve already reconstructed the chain and matched the fixes -- combine them.', 20, 1),
  ('mission-w62-06-o3-c1', 'solution', 'The chain runs from a smuggled request, through a race-planted deserialization gadget, to a stolen OAuth token via a lookalike redirect URI -- each layer now closed by consistent parsing, atomic redemption, restricted deserialization, and exact-match redirect validation.', 35, 2);
