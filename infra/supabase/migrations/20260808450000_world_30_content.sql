-- world-30 ("Authentication & Password Security: The Password Vault")
-- mission content, generated from docs/12-world-story-bible.md. Closes
-- Act 4's technical-controls thread and hands off into the human layer.
-- Mission 1 is cross-world-gated on world-29's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-30a', 'world-30', 'the-password-vault', '30A - The Password Vault', 'A credential dump surfaces, tied to this whole campaign. Most of the accounts in it aren''t actually at risk -- storage design decides that, not luck.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-30a-1', 'campaign-30a', 'foundations', 'Foundations', 'Hashing, salting and MFA, learned as the reasons some designs survive compromise and others don''t.', 1),
  ('operation-30a-2', 'campaign-30a', 'investigation', 'Investigation', 'Determine what''s recoverable, what''s reused, and what control would have contained the damage.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w30-01', 'world-30', 'campaign-30a', 'operation-30a-1', 'not-every-hash', 'Not Every Hash', 'A credential dump just surfaced, tied to this whole campaign. Thousands of hashes. Most of them don''t actually put anyone at risk.', 'intro', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w29-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w30-02', 'world-30', 'campaign-30a', 'operation-30a-1', 'four-seconds-or-years', 'Four Seconds or Years', 'Not all hashes are equal. Some take a data center years to crack. Some take a laptop about four seconds.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w30-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"hash-identification-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w30-03', 'world-30', 'campaign-30a', 'operation-30a-1', 'why-salt-matters', 'Why Salt Matters', 'A salt doesn''t make a weak hash strong. It makes precomputed attacks useless, because every password now hashes differently even when it''s identical.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w30-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"salting-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w30-04', 'world-30', 'campaign-30a', 'operation-30a-2', 'read-the-pattern', 'Read the Pattern', 'One password against a thousand accounts looks completely different in the logs than a thousand passwords against one account.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w30-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"spray-detection-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w30-05', 'world-30', 'campaign-30a', 'operation-30a-2', 'not-all-mfa-is-equal', 'Not All MFA Is Equal', 'A code you can be tricked into reading over the phone isn''t the same category of protection as a hardware key that simply can''t be phished.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w30-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"mfa-classification-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w30-06', 'world-30', 'campaign-30a', 'operation-30a-2', 'vault-breach-boss', 'Vault Breach', 'Which credentials are actually recoverable, which are reused somewhere dangerous, and which control would have stopped this cold?', 'boss', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w30-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"vault-breach-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["vault-breach"],"skillXp":{"pentesting":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w30-01', 1, 'ava', 'A credential dump just surfaced, tied to this whole campaign. Thousands of hashes. Most of them don''t actually put anyone at risk.'),
  ('mission-w30-01', 2, 'byte', 'That''s the whole lesson of this world. Not every leaked hash is a leaked password. Storage design decides that, not luck.'),
  ('mission-w30-01', 3, 'ava', 'Hashing, salting, MFA, spraying, stuffing, offline cracking. Let''s figure out exactly which of these accounts are actually exposed.'),
  ('mission-w30-01', 4, 'byte', 'And which authentication designs made sure the rest weren''t.'),
  ('mission-w30-02', 1, 'byte', 'Not all hashes are equal. Some take a data center years to crack. Some take a laptop about four seconds.'),
  ('mission-w30-03', 1, 'ava', 'A salt doesn''t make a weak hash strong. It makes precomputed attacks like rainbow tables useless, because every password now hashes differently even if it''s identical to another user''s.'),
  ('mission-w30-04', 1, 'byte', 'One password against a thousand accounts looks completely different in the logs than a thousand passwords against one account. Read the pattern, not just the failure count.'),
  ('mission-w30-05', 1, 'ava', 'Not all MFA is equal either. A code you can be tricked into reading over the phone isn''t the same category of protection as a hardware key that simply can''t be phished.'),
  ('mission-w30-06', 1, 'ava', 'Go through this dump properly. Which credentials are actually recoverable, which are reused somewhere dangerous, and which controls would have stopped this cold.'),
  ('mission-w30-06', 2, 'byte', '...One password did crack. Weak hash, no salt, six characters. It belongs to an account named j.reyes.'),
  ('mission-w30-06', 3, 'ava', 'j.reyes. That name again -- disabled for over three years, tied to the closed laboratory.'),
  ('mission-w30-06', 4, 'byte', 'Disabled for humans. But that exact password still authenticates as an active service principal on two other systems. Someone reused it after the person left.'),
  ('mission-w30-06', 5, 'ava', 'A password that should have died with the account survived because it got reused somewhere nobody was watching.'),
  ('mission-w30-06', 6, 'byte', 'MFA on that service principal would have stopped this instantly, even with the password cracked. It never had any.'),
  ('mission-w30-06', 7, 'ava', 'Technical controls only go so far. Whoever''s behind this used a name, a habit, an old shortcut -- human things, not just technical ones. That''s where we look next.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w30-01-o1', 'mission-w30-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to separate real exposure from harmless noise.'),
  ('mission-w30-02-o1', 'mission-w30-02', 1, 'Identify effectively-cracked credentials', 'Determine which stored credentials are already exposed or trivially crackable.'),
  ('mission-w30-03-o1', 'mission-w30-03', 1, 'Explain what a salt actually defeats', 'Explain what changes when a per-user salt is added to identical passwords.'),
  ('mission-w30-04-o1', 'mission-w30-04', 1, 'Identify password spraying', 'Identify the login pattern that specifically shows password spraying.'),
  ('mission-w30-05-o1', 'mission-w30-05', 1, 'Classify MFA methods', 'Sort each MFA method as weaker or stronger against phishing and interception.'),
  ('mission-w30-06-o1', 'mission-w30-06', 1, 'Find the recoverable, reused credential', 'Identify the evidence showing a credential is both recoverable and dangerously reused.'),
  ('mission-w30-06-o2', 'mission-w30-06', 2, 'Choose the control that would have contained it', 'Select the control that would have stopped this even after the password was cracked.'),
  ('mission-w30-06-o3', 'mission-w30-06', 3, 'Close the vault', 'Confirm the exposed credential and the containing control together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w30-01-o1-c1', 'mission-w30-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"ava","text":"Thousands of hashes. Most aren''t actually a problem. Ready to find out which ones are?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w30-02-o1-c1', 'mission-w30-02-o1', 1, 'investigation', 'Which of these stored credentials are already exposed or effectively already crackable?', '{"evidence":[{"id":"h1","label":"5f4dcc3b5aa765d61d8327deb882cf99","detail":"32 hex characters, no salt field -- matches known MD5 output, crackable in seconds on ordinary hardware"},{"id":"h2","label":"$2b$12$KIXQ7z3F8h2vN9pR4sT1XeYbW6cL8mZ0oQ1aB2cD3eF4gH5iJ6kL","detail":"bcrypt format, includes a per-hash salt and a cost factor of 12 -- not practically crackable with available resources"},{"id":"h3","label":"password123","detail":"Stored in plaintext, no hashing applied at all"}],"question":"Which of these stored credentials are already exposed or effectively already crackable?"}'::jsonb, '{"requiredEvidenceIds":["h1","h3"]}'::jsonb),

  ('mission-w30-03-o1-c1', 'mission-w30-03-o1', 1, 'multiple_choice', 'Two users both chose the password "Summer2024!". Without a salt, their hashes would be identical, trivially confirming password reuse. With a properly implemented per-user salt, what changes?', '{"question":"Two users both chose the password \"Summer2024!\". Without a salt, their hashes would be identical, trivially confirming password reuse. With a properly implemented per-user salt, what changes?","options":[{"id":"a","text":"Nothing -- salting is purely cosmetic"},{"id":"b","text":"Each user''s hash comes out completely different despite the identical password, defeating rainbow-table lookups and hiding the reuse from anyone who only has the hash dump"},{"id":"c","text":"The password becomes uncrackable no matter what"},{"id":"d","text":"Salting only matters for MFA, not passwords"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w30-04-o1-c1', 'mission-w30-04-o1', 1, 'investigation', 'Which pattern is password spraying specifically -- one or a few passwords tried broadly, designed to stay under per-account lockout thresholds?', '{"evidence":[{"id":"p1","label":"Login pattern A","detail":"A single account, thousands of different password attempts, over a short window"},{"id":"p2","label":"Login pattern B","detail":"Thousands of different accounts, each tried with exactly one of three common passwords"},{"id":"p3","label":"Login pattern C","detail":"Hundreds of accounts, each tried with a username/password pair matching a previously leaked breach dump"}],"question":"Which pattern is password spraying specifically?"}'::jsonb, '{"requiredEvidenceIds":["p2"]}'::jsonb),

  ('mission-w30-05-o1-c1', 'mission-w30-05-o1', 1, 'drag_and_drop', 'Sort each MFA method as weaker or stronger against phishing and interception.', '{"items":[{"id":"mfa1","text":"SMS-delivered one-time code"},{"id":"mfa2","text":"Phishing-resistant hardware security key (FIDO2/WebAuthn)"},{"id":"mfa3","text":"Authenticator app push notification, approved with a single tap, no number matching"},{"id":"mfa4","text":"Authenticator app with number matching required"}],"targets":[{"id":"weak","label":"Weaker (phishable or interceptable)"},{"id":"strong","label":"Stronger (phishing-resistant)"}]}'::jsonb, '{"correctMapping":{"mfa1":"weak","mfa2":"strong","mfa3":"weak","mfa4":"strong"}}'::jsonb),

  ('mission-w30-06-o1-c1', 'mission-w30-06-o1', 1, 'investigation', 'Which evidence shows this specific credential is both recoverable and dangerously reused?', '{"evidence":[{"id":"v1","label":"Hash for account shop-admin","detail":"bcrypt, cost 12, unique salt -- not practically crackable with available resources"},{"id":"v2","label":"Hash for account j.reyes","detail":"Unsalted MD5, six-character password -- cracked in under a second during controlled testing"},{"id":"v3","label":"Cracked password from j.reyes, checked against other systems","detail":"The exact same password currently authenticates an active service principal on two other systems"},{"id":"v4","label":"MFA configuration on those two other systems","detail":"None configured -- password alone is sufficient to authenticate"}],"question":"Which evidence shows this specific credential is both recoverable and dangerously reused?"}'::jsonb, '{"requiredEvidenceIds":["v2","v3"]}'::jsonb),

  ('mission-w30-06-o2-c1', 'mission-w30-06-o2', 1, 'multiple_choice', 'Given the cracked j.reyes password is confirmed active elsewhere with no MFA, what control would have contained the damage even after the password was cracked?', '{"question":"Given the cracked j.reyes password is confirmed active elsewhere with no MFA, what control would have contained the damage even after the password was cracked?","options":[{"id":"a","text":"A longer password policy alone"},{"id":"b","text":"MFA on the service principals accepting that credential -- a cracked password alone would no longer be sufficient to authenticate"},{"id":"c","text":"Changing the hash algorithm after the fact"},{"id":"d","text":"Nothing could have prevented this"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w30-06-o3-c1', 'mission-w30-06-o3', 1, 'boss_encounter', 'Confirm the exposed credential and the containing control together.', '{"stages":[{"objectiveRef":"mission-w30-06-o1","label":"The exposed, reused credential"},{"objectiveRef":"mission-w30-06-o2","label":"The containing control"}],"task":"Confirm the exposed credential and the containing control together."}'::jsonb, '{"requiredObjectiveIds":["mission-w30-06-o1","mission-w30-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w30-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w30-02-o1-c1', 'orientation', 'One of these three entries requires no cracking effort at all. Another falls to well-known fast attacks.', 15, 1),
  ('mission-w30-02-o1-c1', 'concept', 'Plaintext storage means the password is already exposed, no cracking required. Unsalted MD5 is fast enough on modern hardware to be treated the same way in practice.', 25, 2),
  ('mission-w30-02-o1-c1', 'solution', 'The plaintext password (h3) is already exposed, and the unsalted MD5 hash (h1) is crackable in seconds -- the bcrypt hash (h2) is the one that actually resists recovery.', 35, 3),

  ('mission-w30-03-o1-c1', 'orientation', 'Think about what an attacker with only the hash dump, no salts revealed separately, could tell about these two users.', 15, 1),
  ('mission-w30-03-o1-c1', 'solution', 'A salt makes identical passwords hash to different values, defeating precomputed rainbow-table attacks and hiding password reuse from anyone with only the hash dump. Option b.', 25, 2),

  ('mission-w30-04-o1-c1', 'orientation', 'Spraying specifically tries to stay under the radar of per-account lockouts -- that shapes what the pattern looks like.', 15, 1),
  ('mission-w30-04-o1-c1', 'concept', 'One account with many passwords is brute force. Many accounts each tried once with real leaked credentials is credential stuffing. Many accounts tried with only a few common passwords is spraying.', 25, 2),
  ('mission-w30-04-o1-c1', 'solution', 'Pattern B -- a few common passwords spread across thousands of accounts -- is password spraying specifically, designed to avoid triggering any single account''s lockout.', 35, 3),

  ('mission-w30-05-o1-c1', 'orientation', 'Ask whether each method could be tricked out of a user over the phone or a fake login page, or whether it''s bound to the real site cryptographically.', 15, 1),
  ('mission-w30-05-o1-c1', 'solution', 'SMS codes and no-number-matching push approvals (mfa1, mfa3) can both be socially engineered or MFA-fatigued into approval. Hardware keys and number-matching push (mfa2, mfa4) resist exactly that kind of trickery.', 25, 2),

  ('mission-w30-06-o1-c1', 'orientation', 'Two of these four items describe the same account; the other two describe an unrelated, well-protected one.', 15, 1),
  ('mission-w30-06-o1-c1', 'concept', 'A crackable hash only becomes dangerous when the recovered password is confirmed to still work somewhere else.', 25, 2),
  ('mission-w30-06-o1-c1', 'tool_direction', 'Check j.reyes''s hash strength, then check where else that recovered password authenticates.', 35, 3),
  ('mission-w30-06-o1-c1', 'solution', 'j.reyes''s hash (v2) was trivially cracked, and the recovered password (v3) is confirmed still active on two other systems -- that combination is what makes this credential dangerous.', 45, 4),

  ('mission-w30-06-o2-c1', 'orientation', 'The password is already cracked in this scenario -- the control that matters is whatever stops a cracked password from being enough on its own.', 15, 1),
  ('mission-w30-06-o2-c1', 'solution', 'MFA on the accepting service principals would have required more than the password alone, containing the damage even after cracking. Option b.', 25, 2),

  ('mission-w30-06-o3-c1', 'orientation', 'You''ve already found the exposed credential and the missing control -- combine them.', 20, 1),
  ('mission-w30-06-o3-c1', 'concept', 'The closure needs to name the specific credential, where it''s reused, and exactly what control was missing.', 30, 2),
  ('mission-w30-06-o3-c1', 'tool_direction', 'State the cracked credential and its reuse first, then the missing MFA control.', 40, 3),
  ('mission-w30-06-o3-c1', 'near_solution', 'j.reyes''s password was crackable and still authenticates two service principals with no MFA configured.', 50, 4),
  ('mission-w30-06-o3-c1', 'solution', 'j.reyes''s unsalted, weak-hash password was trivially recovered, and the exact same password still authenticates two active service principals that have no MFA configured. MFA on those principals would have contained the damage completely, even with the password already cracked.', 65, 5);
