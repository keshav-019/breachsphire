-- world-21 ("Cryptography: The Keymaker") mission content, generated from
-- docs/12-world-story-bible.md. Closes the identity/trust thread opened by
-- World 20 ("can we even trust what looks legitimate?"). Mission 1 is
-- cross-world-gated on world-20's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-21a', 'world-21', 'the-keymaker', '21A - The Keymaker', 'A signed update tied to the incident is completely valid -- and completely malicious. Find out what a signature actually proves.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-21a-1', 'campaign-21a', 'foundations', 'Foundations', 'Hashing, certificates and signatures, learned as the difference between "unaltered" and "safe."', 1),
  ('operation-21a-2', 'campaign-21a', 'investigation', 'Investigation', 'How a legitimate signature ended up on a malicious file, and how to stop it happening again.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w21-01', 'world-21', 'campaign-21a', 'operation-21a-1', 'a-valid-lie', 'A Valid Lie', 'This update package has a valid signature. It is also malicious. Both of those things are true at once.', 'intro', ARRAY['byte', 'ava'], '{"requiredMissionIds":["mission-w20-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w21-02', 'world-21', 'campaign-21a', 'operation-21a-1', 'what-a-hash-proves', 'What a Hash Proves', 'A hash tells you a file wasn''t altered since the hash was taken. It says nothing about whether the file was safe to begin with.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w21-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"hash-comparison-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w21-03', 'world-21', 'campaign-21a', 'operation-21a-1', 'the-chain-of-trust', 'The Chain of Trust', 'Trust in a certificate doesn''t come from the certificate itself. It comes from the chain behind it, all the way to a root you already trust.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w21-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"cert-chain-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w21-04', 'world-21', 'campaign-21a', 'operation-21a-2', 'a-key-that-shouldnt-work', 'A Key That Shouldn''t Work', 'The signature on this update is completely valid. That should worry you more, not less.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w21-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"signature-verification-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w21-05', 'world-21', 'campaign-21a', 'operation-21a-2', 'where-keys-live', 'Where Keys Live', 'A signing key is only as safe as the worst place it''s ever been stored.', 'beginner', ARRAY['ava'], '{"requiredMissionIds":["mission-w21-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"key-management-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w21-06', 'world-21', 'campaign-21a', 'operation-21a-2', 'the-keymaker-boss', 'The Keymaker', 'Figure out exactly how a malicious package got a valid signature, then design a process where this can''t happen again.', 'boss', ARRAY['ava', 'byte'], '{"requiredMissionIds":["mission-w21-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"keymaker-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["the-keymaker"],"skillXp":{"cryptography":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w21-01', 1, 'byte', 'Ava was right to worry. This update package has a valid signature. It''s still malicious.'),
  ('mission-w21-01', 2, 'ava', 'That''s exactly why crypto matters. A checkmark doesn''t mean "safe" -- it means something very specific, and we need to know exactly what.'),
  ('mission-w21-01', 3, 'byte', 'Hashing, encryption, signatures, certificates. Not abstract math -- this is literally how "verified" gets faked.'),
  ('mission-w21-01', 4, 'ava', 'Let''s find out what authenticity can actually prove here, and what it can''t.'),
  ('mission-w21-02', 1, 'byte', 'A hash tells you a file wasn''t altered since the hash was taken. It says nothing about whether the file was safe to begin with.'),
  ('mission-w21-03', 1, 'ava', 'Trust in a certificate doesn''t come from the certificate itself. It comes from the chain behind it, all the way to a root you already trust.'),
  ('mission-w21-04', 1, 'byte', 'The signature on this update is completely valid. That should worry you more, not less.'),
  ('mission-w21-05', 1, 'ava', 'A signing key is only as safe as the worst place it''s ever been stored.'),
  ('mission-w21-06', 1, 'ava', 'Figure out exactly how a malicious package got a valid signature, then design a process where this can''t happen again.'),
  ('mission-w21-06', 2, 'byte', '...Got it. The signing key wasn''t stolen through some clever exploit. It was sitting in a build server''s environment variable, in plaintext, for over a year.'),
  ('mission-w21-06', 3, 'ava', 'And the certificate behind it traces back to an actual laboratory. Not a shell company -- Guardian-adjacent, tied to Project SENTINEL documentation.'),
  ('mission-w21-06', 4, 'byte', 'Whatever SENTINEL was, it had legitimate cryptographic infrastructure. Someone with insider access, or insider knowledge, used it.'),
  ('mission-w21-06', 5, 'ava', 'If SENTINEL had real infrastructure, it had real people and real accounts. Some of those credentials might still work somewhere. Identity is the next question -- who is still authenticated as who, and why.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w21-01-o1', 'mission-w21-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to question what "verified" actually means.'),
  ('mission-w21-02-o1', 'mission-w21-02', 1, 'Understand what a hash comparison proves', 'Determine why a matching hash alone can''t clear this file.'),
  ('mission-w21-03-o1', 'mission-w21-03', 1, 'Order the chain of trust', 'Order the elements of a certificate chain from foundation to specific proof.'),
  ('mission-w21-04-o1', 'mission-w21-04', 1, 'Explain the valid-but-malicious signature', 'Determine how a legitimately signed file can still be malicious.'),
  ('mission-w21-05-o1', 'mission-w21-05', 1, 'Classify key-management practices', 'Sort each practice as safe or risky.'),
  ('mission-w21-06-o1', 'mission-w21-06', 1, 'Find how the package passed trust checks', 'Identify the evidence explaining how the malicious package got a valid signature.'),
  ('mission-w21-06-o2', 'mission-w21-06', 2, 'Design a safer signing process', 'Choose the change that would have actually prevented this failure.'),
  ('mission-w21-06-o3', 'mission-w21-06', 3, 'Close the investigation', 'Confirm the cause and the fix together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w21-01-o1-c1', 'mission-w21-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"byte","text":"Ready to find out what a checkmark actually means?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w21-02-o1-c1', 'mission-w21-02-o1', 1, 'multiple_choice', 'The hash of the file you downloaded exactly matches the hash published on the vendor''s own site. What does this actually tell you?', '{"question":"The hash of the file you downloaded exactly matches the hash published on the vendor''s own site. What does this actually tell you?","options":[{"id":"a","text":"The file is safe to run"},{"id":"b","text":"The file wasn''t altered after the vendor published it -- but if the vendor''s own published version was already compromised, the hash would match anyway"},{"id":"c","text":"Hashes can''t be trusted at all and should be ignored"},{"id":"d","text":"The vendor''s site must be fake"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w21-03-o1-c1', 'mission-w21-03-o1', 1, 'interactive_diagram', 'Order these from the foundation of trust to the specific proof on this file.', '{"hotspots":[{"id":"root_ca","label":"Root CA certificate","explanation":"Self-signed, and trusted only because it ships pre-installed in operating systems and browsers -- the actual foundation of the whole chain."},{"id":"intermediate_ca","label":"Intermediate CA certificate","explanation":"Issued and signed by the root CA. Exists so the root''s private key almost never has to be used directly."},{"id":"leaf_cert","label":"Leaf (end-entity) certificate","explanation":"Issued and signed by the intermediate CA. Belongs to the actual publisher -- this is the identity being vouched for."},{"id":"the_signature","label":"This file''s signature","explanation":"Created using the leaf certificate''s private key. The most specific, most easily misused link in the chain."}],"task":"Order these from the foundation of trust to the specific proof on this file."}'::jsonb, '{"correctOrderIds":["root_ca","intermediate_ca","leaf_cert","the_signature"]}'::jsonb),

  ('mission-w21-04-o1-c1', 'mission-w21-04-o1', 1, 'multiple_choice', 'This update''s signature verifies successfully against a legitimate, non-expired, non-revoked certificate that chains to a trusted root. How could the file still be malicious?', '{"question":"This update''s signature verifies successfully against a legitimate, non-expired, non-revoked certificate that chains to a trusted root. How could the file still be malicious?","options":[{"id":"a","text":"It can''t be -- a valid signature guarantees the file is safe"},{"id":"b","text":"The private key behind that legitimate certificate was itself compromised, so anyone holding the stolen key can produce valid signatures"},{"id":"c","text":"Signatures only apply to encrypted files, not executables"},{"id":"d","text":"The certificate must actually be forged, since attackers can''t obtain real ones"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w21-05-o1-c1', 'mission-w21-05-o1', 1, 'drag_and_drop', 'Sort each key-management practice as safe or risky.', '{"items":[{"id":"i1","text":"Signing key stored in a hardware security module (HSM), never exported"},{"id":"i2","text":"Signing key stored in a plaintext environment variable on a build server"},{"id":"i3","text":"Every release requires two separate engineers to authorize signing"},{"id":"i4","text":"Any engineer with build-server access can trigger a signed release alone"}],"targets":[{"id":"safe","label":"Safe practice"},{"id":"risky","label":"Risky practice"}]}'::jsonb, '{"correctMapping":{"i1":"safe","i2":"risky","i3":"safe","i4":"risky"}}'::jsonb),

  ('mission-w21-06-o1-c1', 'mission-w21-06-o1', 1, 'investigation', 'Which two pieces of evidence explain how a malicious package got a legitimately valid signature?', '{"evidence":[{"id":"e1","label":"Build server environment dump","detail":"Signing private key present as a plaintext CI/CD environment variable, unrotated for 14 months"},{"id":"e2","label":"Release pipeline logs","detail":"A single engineer credential triggered the signing step -- no second approval required"},{"id":"e3","label":"Certificate validity check","detail":"The certificate itself was never revoked or expired -- it''s the legitimate cert, just misused"},{"id":"e4","label":"Antivirus scan of the package","detail":"Came back clean; the malicious payload was designed to evade static signatures"}],"question":"Which two pieces of evidence explain how a malicious package got a legitimately valid signature?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2"]}'::jsonb),

  ('mission-w21-06-o2-c1', 'mission-w21-06-o2', 1, 'multiple_choice', 'Which change would have actually prevented this specific failure?', '{"question":"Which change would have actually prevented this specific failure?","options":[{"id":"a","text":"Scan packages with a second antivirus vendor"},{"id":"b","text":"Move the signing key into an HSM and require two-person authorization for every release"},{"id":"c","text":"Publish the hash on a second website"},{"id":"d","text":"Increase the certificate''s validity period"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w21-06-o3-c1', 'mission-w21-06-o3', 1, 'boss_encounter', 'Confirm the cause and the fix together.', '{"stages":[{"objectiveRef":"mission-w21-06-o1","label":"How trust checks were passed"},{"objectiveRef":"mission-w21-06-o2","label":"The safer signing process"}],"task":"Confirm the cause and the fix together."}'::jsonb, '{"requiredObjectiveIds":["mission-w21-06-o1","mission-w21-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w21-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w21-02-o1-c1', 'orientation', 'Ask what a hash actually measures -- integrity since publication, not intent at publication.', 10, 1),
  ('mission-w21-02-o1-c1', 'solution', 'A hash proves the file matches what was published -- it says nothing about whether the published version was already compromised. Option b.', 20, 2),

  ('mission-w21-03-o1-c1', 'orientation', 'Ask which certificate signs which -- the answer chains backward from the file to something you already trust.', 15, 1),
  ('mission-w21-03-o1-c1', 'concept', 'Roots are trusted by installation, not by being vouched for by anything else -- everything else in the chain is vouched for by the link above it.', 25, 2),
  ('mission-w21-03-o1-c1', 'solution', 'root_ca (trusted by installation) -> intermediate_ca (signed by the root) -> leaf_cert (signed by the intermediate, belongs to the publisher) -> the_signature (made with the leaf''s private key).', 35, 3),

  ('mission-w21-04-o1-c1', 'orientation', 'A signature check verifies who signed something, not whether that signer''s key is still exclusively theirs.', 15, 1),
  ('mission-w21-04-o1-c1', 'concept', 'If a private key leaks, every signature made with it looks completely legitimate to anyone verifying it -- there is no way to tell a stolen-key signature from a real one by looking at the signature alone.', 25, 2),
  ('mission-w21-04-o1-c1', 'solution', 'The certificate is genuinely legitimate -- but its private key was compromised, so the attacker could produce valid signatures with it. Option b.', 35, 3),

  ('mission-w21-05-o1-c1', 'orientation', 'Two of these four practices concentrate risk in a single point of failure; two of them don''t.', 15, 1),
  ('mission-w21-05-o1-c1', 'solution', 'HSM storage (i1) and two-person authorization (i3) are safe; plaintext storage (i2) and single-engineer release authority (i4) are both risky.', 25, 2),

  ('mission-w21-06-o1-c1', 'orientation', 'Two of these four items directly explain the mechanism. Two describe the certificate''s own legitimacy or an unrelated scan result.', 15, 1),
  ('mission-w21-06-o1-c1', 'concept', 'A valid certificate plus an unprotected key plus no second approval is exactly the combination needed to sign anything undetected.', 25, 2),
  ('mission-w21-06-o1-c1', 'tool_direction', 'Look for where the key actually lived, and who was required to approve a release.', 35, 3),
  ('mission-w21-06-o1-c1', 'solution', 'The plaintext, unrotated key on the build server (e1) combined with no second-approval requirement (e2) explains the mechanism -- e3 confirms the cert itself wasn''t forged, and e4 is an unrelated scan result.', 45, 4),

  ('mission-w21-06-o2-c1', 'orientation', 'The fix needs to address both where the key lives and who can trigger a release with it.', 15, 1),
  ('mission-w21-06-o2-c1', 'solution', 'An HSM removes the key from anywhere it could leak, and two-person authorization means one compromised credential alone can''t trigger a signed release. Option b.', 25, 2),

  ('mission-w21-06-o3-c1', 'orientation', 'You''ve already worked out both halves -- combine the cause with the fix.', 20, 1),
  ('mission-w21-06-o3-c1', 'concept', 'The report needs to state exactly how the trust check was bypassed and exactly what would close that gap.', 30, 2),
  ('mission-w21-06-o3-c1', 'tool_direction', 'State the key exposure and missing approval first, then the HSM/two-person fix.', 40, 3),
  ('mission-w21-06-o3-c1', 'near_solution', 'Cause: plaintext signing key on the build server, no second approval required. Fix: HSM-backed key storage plus two-person release authorization.', 50, 4),
  ('mission-w21-06-o3-c1', 'solution', 'The malicious package passed trust checks because the signing key sat in plaintext on the build server for 14 months with no second approval required to trigger a release. Moving the key into an HSM and requiring two-person authorization for every signing event closes both gaps at once.', 65, 5);
