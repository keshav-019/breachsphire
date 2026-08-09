-- world-31 ("Social Engineering: Human Layer") mission content, generated
-- from docs/12-world-story-bible.md. Opens the human-layer thread that
-- closes World 30's technical-controls arc. Mission 1 is cross-world-gated
-- on world-30's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-31a', 'world-31', 'human-layer', '31A - Human Layer', 'Attackers impersonate Guardian support staff, trying to reactivate a disabled identity through people instead of code.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-31a-1', 'campaign-31a', 'foundations', 'Foundations', 'Phishing, vishing, MFA fatigue and helpdesk abuse, learned from both the attacker and defender side.', 1),
  ('operation-31a-2', 'campaign-31a', 'investigation', 'Investigation', 'Stop a coordinated multi-channel attempt without blocking anyone who actually needs help.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w31-01', 'world-31', 'campaign-31a', 'operation-31a-1', 'through-people-not-code', 'Through People, Not Code', 'Someone''s calling our helpdesk claiming to be Guardian support staff, trying to get a disabled identity reactivated.', 'intro', ARRAY['ava', 'luna'], '{"requiredMissionIds":["mission-w30-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w31-02', 'world-31', 'campaign-31a', 'operation-31a-1', 'a-believable-reason', 'A Believable Reason', 'A pretexting email doesn''t need malware. It just needs a believable reason for you to do something you shouldn''t.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w31-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"pretexting-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w31-03', 'world-31', 'campaign-31a', 'operation-31a-1', 'never-read-the-code', 'Never Read the Code', 'A real IT department will never ask you to read your MFA code out loud. That single rule stops most of this category cold.', 'beginner', ARRAY['luna'], '{"requiredMissionIds":["mission-w31-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"vishing-mfa-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w31-04', 'world-31', 'campaign-31a', 'operation-31a-2', 'the-instinct-to-help', 'The Instinct to Help', 'A helpdesk''s job is to help quickly. That instinct is exactly what a patient attacker relies on.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w31-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"helpdesk-decision-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w31-05', 'world-31', 'campaign-31a', 'operation-31a-2', 'a-convincing-voice', 'A Convincing Voice', 'A convincing voice isn''t verification. Verification is a known, pre-agreed channel -- nothing else counts.', 'beginner', ARRAY['luna'], '{"requiredMissionIds":["mission-w31-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"deepfake-voice-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w31-06', 'world-31', 'campaign-31a', 'operation-31a-2', 'trust-no-voice-boss', 'Trust No Voice', 'Stop a coordinated multi-channel social-engineering attempt without blocking legitimate emergency support.', 'boss', ARRAY['ava', 'luna'], '{"requiredMissionIds":["mission-w31-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"trust-no-voice-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["trust-no-voice"],"skillXp":{"pentesting":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w31-01', 1, 'ava', 'Someone''s calling our helpdesk claiming to be Guardian support staff, trying to get the j.reyes identity reactivated. Through people this time, not code.'),
  ('mission-w31-01', 2, 'luna', 'Every technical control we''ve built assumes the person on the other end is being honest about who they are. That assumption is the actual attack surface today.'),
  ('mission-w31-01', 3, 'ava', 'Phishing, pretexting, vishing, MFA fatigue -- I need you thinking like both sides. What would convince you, and what should never convince anyone.'),
  ('mission-w31-01', 4, 'luna', 'And afterward, we design the policy that closes it. Let''s begin.'),
  ('mission-w31-02', 1, 'ava', 'A pretexting email doesn''t need malware. It just needs a believable reason for you to do something you shouldn''t.'),
  ('mission-w31-03', 1, 'luna', 'A real IT department will never ask you to read your MFA code out loud. That single rule stops most of this category cold.'),
  ('mission-w31-04', 1, 'ava', 'A helpdesk''s job is to help quickly. That instinct is exactly what a patient attacker relies on.'),
  ('mission-w31-05', 1, 'luna', 'A convincing voice isn''t verification. Verification is a known, pre-agreed channel -- nothing else counts.'),
  ('mission-w31-06', 1, 'ava', 'This isn''t one attempt. Email, then a call, then a chat message, all within an hour, all converging on the same request. Stop it without blocking someone who actually needs emergency support.'),
  ('mission-w31-06', 2, 'luna', '...Ava. Look at the phrasing in the chat transcript.'),
  ('mission-w31-06', 3, 'ava', '"Confirm under protocol Sentinel-Blue." That''s not a real Guardian protocol. Except... it almost is.'),
  ('mission-w31-06', 4, 'luna', 'It''s close enough to something real that it had to come from someone who''d actually heard internal phrasing. That doesn''t happen by guessing.'),
  ('mission-w31-06', 5, 'ava', 'Someone leaked language that should have stayed inside this organization. That''s not a technical breach. That''s a person.'),
  ('mission-w31-06', 6, 'luna', 'Multi-channel attempt stopped, legitimate emergency line still open. But now we have to ask who talks, and who''s listening. Time to look at what''s actually moving across our own network.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w31-01-o1', 'mission-w31-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to think like both the attacker and the defender.'),
  ('mission-w31-02-o1', 'mission-w31-02', 1, 'Spot the pretexting attempt', 'Identify the elements confirming this is a pretexting/phishing attempt.'),
  ('mission-w31-03-o1', 'mission-w31-03', 1, 'Handle an MFA-code request', 'Choose the correct response to a caller requesting your MFA code.'),
  ('mission-w31-04-o1', 'mission-w31-04', 1, 'Sort helpdesk requests', 'Classify each helpdesk scenario as safe to proceed or needing further verification.'),
  ('mission-w31-05-o1', 'mission-w31-05', 1, 'Evaluate a convincing voice message', 'Determine what an authentic-sounding voice alone actually proves.'),
  ('mission-w31-06-o1', 'mission-w31-06', 1, 'Identify the coordinated attempt', 'Identify the events that form the coordinated multi-channel attempt.'),
  ('mission-w31-06-o2', 'mission-w31-06', 2, 'Choose the correct response', 'Select the response that stops the attempt without blocking legitimate support.'),
  ('mission-w31-06-o3', 'mission-w31-06', 3, 'Close the incident', 'Confirm the coordinated attempt and the response together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w31-01-o1-c1', 'mission-w31-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"ava","text":"People, not code, this time. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w31-02-o1-c1', 'mission-w31-02-o1', 1, 'investigation', 'Which elements confirm this is a pretexting/phishing attempt?', '{"evidence":[{"id":"e1","label":"Email from \"IT-Support@guardian-secops.com\"","detail":"Domain is one character off from the real guardian-secops.example domain; creates urgency about an \"account lockout in 10 minutes\""},{"id":"e2","label":"Email signature","detail":"Matches a real employee''s name and title exactly, copied from a public conference bio page"},{"id":"e3","label":"The email''s request","detail":"Asks the recipient to click a link and \"re-verify\" their password on a page that looks identical to the real login"},{"id":"e4","label":"A routine internal newsletter","detail":"Sent from the correct internal domain, no urgency, no credential request"}],"question":"Which elements confirm this is a pretexting/phishing attempt?"}'::jsonb, '{"requiredEvidenceIds":["e1","e3"]}'::jsonb),

  ('mission-w31-03-o1-c1', 'mission-w31-03-o1', 1, 'multiple_choice', 'A caller claiming to be from IT says your account is locked and asks you to read them the 6-digit code that just appeared on your phone. What''s the correct response?', '{"question":"A caller claiming to be from IT says your account is locked and asks you to read them the 6-digit code that just appeared on your phone. What''s the correct response?","options":[{"id":"a","text":"Read the code -- IT probably needs it to help"},{"id":"b","text":"Refuse, hang up, and independently contact IT through the official helpdesk number to verify"},{"id":"c","text":"Read only the first three digits as a compromise"},{"id":"d","text":"Ask them to text you back instead"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w31-04-o1-c1', 'mission-w31-04-o1', 1, 'drag_and_drop', 'Classify each helpdesk scenario as safe to proceed or needing further verification.', '{"items":[{"id":"h1","text":"Caller requests a password reset and correctly answers the pre-registered security questions"},{"id":"h2","text":"Caller is \"in a huge hurry\" and asks to skip identity verification \"just this once\""},{"id":"h3","text":"Caller''s phone number matches the number on file, and they answer a callback verification"},{"id":"h4","text":"Caller claims to be a senior executive and gets upset when asked to verify identity"}],"targets":[{"id":"proceed","label":"Safe to proceed"},{"id":"escalate","label":"Escalate / verify further"}]}'::jsonb, '{"correctMapping":{"h1":"proceed","h2":"escalate","h3":"proceed","h4":"escalate"}}'::jsonb),

  ('mission-w31-05-o1-c1', 'mission-w31-05-o1', 1, 'multiple_choice', 'A voicemail sounds exactly like a known executive, urgently requesting a sensitive account change. What does an authentic-sounding voice alone actually prove?', '{"question":"A voicemail sounds exactly like a known executive, urgently requesting a sensitive account change. What does an authentic-sounding voice alone actually prove?","options":[{"id":"a","text":"That the request is legitimate"},{"id":"b","text":"Nothing on its own -- voice can be convincingly faked, so the pre-agreed callback verification must still happen regardless of how convincing the message sounds"},{"id":"c","text":"That it''s safe to proceed immediately given the urgency"},{"id":"d","text":"That the request came from a secure channel"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w31-06-o1-c1', 'mission-w31-06-o1', 1, 'investigation', 'Which three events form the coordinated multi-channel attempt?', '{"evidence":[{"id":"c1","label":"Email received 9:02am","detail":"Impersonation attempt requesting identity reactivation, spoofed domain"},{"id":"c2","label":"Helpdesk call received 9:31am","detail":"Same request, different channel, caller unable to complete callback verification"},{"id":"c3","label":"Support chat message received 9:47am","detail":"Same request again, this time including the phrase \"confirm under protocol Sentinel-Blue\""},{"id":"c4","label":"Unrelated legitimate emergency call, 9:50am","detail":"A different caller, genuine facilities emergency, completes callback verification successfully"}],"question":"Which three events form the coordinated multi-channel attempt?"}'::jsonb, '{"requiredEvidenceIds":["c1","c2","c3"]}'::jsonb),

  ('mission-w31-06-o2-c1', 'mission-w31-06-o2', 1, 'multiple_choice', 'How do you stop this coordinated attempt without blocking the legitimate emergency call that came in around the same time?', '{"question":"How do you stop this coordinated attempt without blocking the legitimate emergency call that came in around the same time?","options":[{"id":"a","text":"Shut down the entire helpdesk line until things calm down"},{"id":"b","text":"Deny the reactivation request across all three channels since none passed callback verification, while continuing to process the unrelated call that did verify successfully"},{"id":"c","text":"Grant the request since it came through three different channels, showing persistence"},{"id":"d","text":"Ignore all calls for the rest of the day"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w31-06-o3-c1', 'mission-w31-06-o3', 1, 'boss_encounter', 'Confirm the coordinated attempt and the response together.', '{"stages":[{"objectiveRef":"mission-w31-06-o1","label":"The coordinated attempt"},{"objectiveRef":"mission-w31-06-o2","label":"The response"}],"task":"Confirm the coordinated attempt and the response together."}'::jsonb, '{"requiredObjectiveIds":["mission-w31-06-o1","mission-w31-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w31-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w31-02-o1-c1', 'orientation', 'Two of these four items are completely ordinary email traffic.', 15, 1),
  ('mission-w31-02-o1-c1', 'concept', 'A near-identical domain and a request to re-enter credentials on a lookalike page are both classic phishing tells -- a copied signature alone isn''t.', 25, 2),
  ('mission-w31-02-o1-c1', 'solution', 'The spoofed domain (e1) and the credential-harvesting link (e3) together confirm this is phishing -- the newsletter is unrelated, and a copied signature alone doesn''t prove anything either way.', 35, 3),

  ('mission-w31-03-o1-c1', 'orientation', 'Ask what a legitimate IT process would actually need from you over the phone.', 10, 1),
  ('mission-w31-03-o1-c1', 'solution', 'Legitimate IT never needs your MFA code read aloud -- refuse and verify independently through the official channel. Option b.', 20, 2),

  ('mission-w31-04-o1-c1', 'orientation', 'Two of these four callers pass a real verification step. Two are trying to avoid one entirely.', 15, 1),
  ('mission-w31-04-o1-c1', 'solution', 'Correct security answers (h1) and a successful callback (h3) both pass real verification. Pressure to skip verification (h2) and hostility toward being verified (h4) are both red flags regardless of the caller''s claimed identity.', 25, 2),

  ('mission-w31-05-o1-c1', 'orientation', 'Ask what''s actually being checked here -- how something sounds, or who it came from.', 15, 1),
  ('mission-w31-05-o1-c1', 'solution', 'A convincing voice proves nothing on its own -- the policy''s callback verification exists specifically because voice alone can be faked. Option b.', 25, 2),

  ('mission-w31-06-o1-c1', 'orientation', 'One of these four events is unrelated -- a different caller, a different situation, that actually verified successfully.', 15, 1),
  ('mission-w31-06-o1-c1', 'concept', 'The same request, repeated across three different channels within under an hour, is the signature of a coordinated attempt.', 25, 2),
  ('mission-w31-06-o1-c1', 'solution', 'The email, call, and chat message (c1, c2, c3) all request the same reactivation within the same hour -- the legitimate emergency call (c4) is unrelated and already verified.', 35, 3),

  ('mission-w31-06-o2-c1', 'orientation', 'The fix needs to treat the coordinated request consistently across every channel it appeared on, without touching unrelated legitimate traffic.', 15, 1),
  ('mission-w31-06-o2-c1', 'solution', 'None of the three channels passed callback verification, so the request is denied everywhere it appeared -- the separately verified emergency call proceeds normally. Option b.', 25, 2),

  ('mission-w31-06-o3-c1', 'orientation', 'You''ve already identified both halves -- combine the coordinated attempt with the response.', 20, 1),
  ('mission-w31-06-o3-c1', 'concept', 'The closure needs to name all three channels and confirm the legitimate call was left untouched.', 30, 2),
  ('mission-w31-06-o3-c1', 'tool_direction', 'State the three-channel pattern first, then the selective denial.', 40, 3),
  ('mission-w31-06-o3-c1', 'near_solution', 'Email, call, and chat, all within an hour, all failing callback verification; the unrelated emergency call passed verification and proceeded.', 50, 4),
  ('mission-w31-06-o3-c1', 'solution', 'The same reactivation request arrived by email, phone, and chat within under an hour, and none of the three passed callback verification -- all three were denied, while the unrelated, independently verified emergency call was allowed to proceed without interruption.', 65, 5);
