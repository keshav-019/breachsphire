-- Atlas Division pathway ("The Silence") Act 11 -- "Identity Plane"
-- content, under world-atlas-identity-plane (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), continuing World IV "Cloudreach" (Acts 10-13).
--
-- Same terminal-engine constraint as Acts 4-10 -- every IAM artifact
-- here (policy document, service identity listing, credential audit,
-- secrets manager status, rotation log, audit report) is static seeded
-- text read via `cat`. Two hosts: the reused `atlas-devbox-01` for
-- repo/IaC-side IAM definitions, plus a new `atlas-audit-01` for the
-- audit system's own findings and credential/rotation history. Purely
-- conceptual topics with no natural artifact (principals, users vs
-- roles, least privilege, KMS concepts, workload identity) stay
-- multiple_choice.
--
-- Narrative thread: Cross's quarterly IAM audit finds a service
-- identity (`svc-eu-west-bootstrap`) created during Act 10's region
-- buildout with a full account-wide policy, a static never-rotated
-- credential, and no presence in the secrets manager Act 6 already
-- established -- marked TEMPORARY at creation, never revisited. Same
-- "shortcut under time pressure, never finished" pattern as Act 3 and
-- Act 6, this time in identity and access management rather than
-- infrastructure sizing or a leaked token.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-identity-plane', 'world-atlas-identity-plane', 'identity-plane', '4B - Identity Plane', 'Learn IAM and secrets from first principles -- principals, users versus roles, policies, least privilege, service identities, temporary credentials, secrets managers, KMS concepts, rotation, workload identity and audit -- while Cross traces one service identity that was always meant to be temporary.', 2);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-identity-plane-1', 'campaign-atlas-identity-plane', 'who-is-actually-allowed', 'Who Is Actually Allowed', 'Principals, users versus roles, policies, least privilege, service identities and temporary credentials.', 1),
  ('operation-atlas-identity-plane-2', 'campaign-atlas-identity-plane', 'proving-it-never-got-finished', 'Proving It Never Got Finished', 'Secrets managers, KMS concepts, rotation, workload identity and audit.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-identity-plane-01', 'world-atlas-identity-plane', 'campaign-atlas-identity-plane', 'operation-atlas-identity-plane-1', 'principals', 'Principals', 'With atlas-eu-west finally reachable, Cross runs the quarterly IAM audit -- routine, until one finding stands out.', 'beginner', ARRAY['leena','cross'], null, null, '{"type":"simulation","simulationId":"principals-sim"}'::jsonb, '{"xp":220,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-identity-plane-02', 'world-atlas-identity-plane', 'campaign-atlas-identity-plane', 'operation-atlas-identity-plane-1', 'users-vs-roles', 'Users vs Roles', 'Confirm exactly what kind of identity is actually behind this finding.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-identity-plane-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"users-vs-roles-sim"}'::jsonb, '{"xp":220,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-identity-plane-03', 'world-atlas-identity-plane', 'campaign-atlas-identity-plane', 'operation-atlas-identity-plane-1', 'policies', 'Policies', 'Confirm exactly what this identity is actually allowed to do.', 'beginner', ARRAY['cross','vey'], '{"requiredMissionIds":["mission-atlas-identity-plane-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"policies-sim"}'::jsonb, '{"xp":230,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-identity-plane-04', 'world-atlas-identity-plane', 'campaign-atlas-identity-plane', 'operation-atlas-identity-plane-1', 'least-privilege', 'Least Privilege', 'Understand exactly why a policy this broad should never have been left standing.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-identity-plane-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"least-privilege-sim"}'::jsonb, '{"xp":230,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-identity-plane-05', 'world-atlas-identity-plane', 'campaign-atlas-identity-plane', 'operation-atlas-identity-plane-1', 'service-identities', 'Service Identities', 'Confirm how this identity actually compares to every other service identity Atlas Division runs.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-identity-plane-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"service-identities-sim"}'::jsonb, '{"xp":240,"credits":40}'::jsonb, false, 5),
  ('mission-atlas-identity-plane-06', 'world-atlas-identity-plane', 'campaign-atlas-identity-plane', 'operation-atlas-identity-plane-1', 'temporary-credentials', 'Temporary Credentials', 'Confirm whether this identity actually issues short-lived credentials the way it should.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-identity-plane-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"temporary-credentials-sim"}'::jsonb, '{"xp":240,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-identity-plane-07', 'world-atlas-identity-plane', 'campaign-atlas-identity-plane', 'operation-atlas-identity-plane-2', 'secrets-managers', 'Secrets Managers', 'Confirm whether this credential is even tracked by the same secrets manager everything else already uses.', 'beginner', ARRAY['cross','rook'], '{"requiredMissionIds":["mission-atlas-identity-plane-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"secrets-managers-iam-sim"}'::jsonb, '{"xp":250,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-identity-plane-08', 'world-atlas-identity-plane', 'campaign-atlas-identity-plane', 'operation-atlas-identity-plane-2', 'kms-concepts', 'KMS Concepts', 'Understand what actually protects a secret at rest, separately from who is allowed to ask for it.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-identity-plane-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"kms-concepts-sim"}'::jsonb, '{"xp":250,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-identity-plane-09', 'world-atlas-identity-plane', 'campaign-atlas-identity-plane', 'operation-atlas-identity-plane-2', 'rotation', 'Rotation', 'Confirm exactly how many times this credential has actually rotated since it was created.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-identity-plane-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"rotation-sim"}'::jsonb, '{"xp":260,"credits":45}'::jsonb, false, 9),
  ('mission-atlas-identity-plane-10', 'world-atlas-identity-plane', 'campaign-atlas-identity-plane', 'operation-atlas-identity-plane-2', 'workload-identity', 'Workload Identity', 'Understand what this identity should have used from the very beginning instead of a standing key.', 'beginner', ARRAY['cross','vey'], '{"requiredMissionIds":["mission-atlas-identity-plane-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"workload-identity-sim"}'::jsonb, '{"xp":260,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-identity-plane-11', 'world-atlas-identity-plane', 'campaign-atlas-identity-plane', 'operation-atlas-identity-plane-2', 'audit', 'Audit', 'Confirm exactly what the audit finding itself actually says.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-identity-plane-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"audit-sim"}'::jsonb, '{"xp":270,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-identity-plane-12', 'world-atlas-identity-plane', 'campaign-atlas-identity-plane', 'operation-atlas-identity-plane-2', 'the-master-key', 'The Master Key', 'Everything this Act taught, turned on one identity: not to delete it quietly, to finally explain how a temporary shortcut became a standing, unrotated master key for months.', 'boss', ARRAY['cross','vey','leena','byte'], '{"requiredMissionIds":["mission-atlas-identity-plane-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"master-key-boss-sim"}'::jsonb, '{"xp":510,"credits":115,"badgeIds":["the-master-key"],"skillXp":{"cloud_devops_fundamentals":90}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-identity-plane-01', 1, 'leena', 'With atlas-eu-west finally reachable, Cross is running the quarterly IAM audit across the whole, now-doubled infrastructure. Routine, until one finding stood out.'),
  ('mission-atlas-identity-plane-01', 2, 'cross', 'Imani Cross. Every policy, every credential, is granted to some principal -- a user, a role, a service identity, anything that can actually authenticate and be granted access. Before judging this finding, confirm exactly what kind of principal it even is.'),

  ('mission-atlas-identity-plane-02', 1, 'cross', 'A user is tied to one specific person, with their own long-lived credentials. A role is not owned by anyone -- it is meant to be assumed temporarily, by whoever or whatever actually needs it, for exactly as long as they need it.'),

  ('mission-atlas-identity-plane-03', 1, 'vey', 'I remember creating this one. Confirm exactly what it is actually allowed to do before assuming anything about why.'),

  ('mission-atlas-identity-plane-04', 1, 'cross', 'Least privilege means granting exactly what a task needs and nothing more -- so that if this identity is ever compromised, the damage is bounded by what it was actually allowed to touch. A policy this broad has no bound at all.'),

  ('mission-atlas-identity-plane-05', 1, 'cross', 'Compare it against every other service identity in this fleet. If it looks nothing like the rest, that is worth understanding on its own.'),

  ('mission-atlas-identity-plane-06', 1, 'cross', 'Most identities here issue credentials that expire on their own, automatically, within the hour. Confirm whether this one actually does the same.'),

  ('mission-atlas-identity-plane-07', 1, 'rook', 'Act 6 already fixed this once, for one leaked token -- every real secret is supposed to live in the secrets manager, never as a literal value anywhere. Confirm whether this credential was ever actually migrated there.'),

  ('mission-atlas-identity-plane-08', 1, 'cross', 'A secrets manager stores the secret. A KMS key is what actually encrypts it at rest -- a separate layer, with its own separate access control, so having one secured does not automatically mean the other is too.'),

  ('mission-atlas-identity-plane-09', 1, 'cross', 'A credential that is never rotated is a credential that, if it were ever exposed once, would still be exposed today. Confirm exactly how many times this one has actually rotated.'),

  ('mission-atlas-identity-plane-10', 1, 'vey', 'This never needed a standing key in the first place. Workload identity lets a running service assume an identity dynamically, through the platform itself, for exactly as long as it is running -- no static credential ever has to exist at all.'),

  ('mission-atlas-identity-plane-11', 1, 'cross', 'Confirm what the audit finding itself actually documents, in its own words, before this goes any further.'),

  ('mission-atlas-identity-plane-12', 1, 'leena', 'Everything this Act taught you, on one identity. Not to quietly delete it -- to finally explain how a temporary shortcut became a standing, unrotated master key for months.'),
  ('mission-atlas-identity-plane-12', 2, 'byte', 'I have the policy, the credential history and the audit finding all pulled up together. Nothing about this was ever an attack.'),
  ('mission-atlas-identity-plane-12', 3, 'vey', 'It was created honestly, under real pressure, marked temporary exactly as it should have been. Nobody ever came back to finish it.'),
  ('mission-atlas-identity-plane-12', 4, 'cross', 'Find what actually explains that, and say plainly what has to replace it.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-identity-plane-01-o1', 'mission-atlas-identity-plane-01', 1, 'Define a principal', 'Choose the accurate description of what a principal actually is.'),

  ('mission-atlas-identity-plane-02-o1', 'mission-atlas-identity-plane-02', 1, 'Tell users from roles', 'Choose the accurate distinction between a user and a role.'),

  ('mission-atlas-identity-plane-03-o1', 'mission-atlas-identity-plane-03', 1, 'Read the policy document', 'Read the attached policy and submit the verification code.'),

  ('mission-atlas-identity-plane-04-o1', 'mission-atlas-identity-plane-04', 1, 'Explain least privilege', 'Choose the accurate description of what least privilege actually means.'),

  ('mission-atlas-identity-plane-05-o1', 'mission-atlas-identity-plane-05', 1, 'Compare service identities', 'Read the service identity listing and submit the verification code.'),

  ('mission-atlas-identity-plane-06-o1', 'mission-atlas-identity-plane-06', 1, 'Check the credential type', 'Read the credential audit and submit the verification code.'),

  ('mission-atlas-identity-plane-07-o1', 'mission-atlas-identity-plane-07', 1, 'Check the secrets manager', 'Read the secrets manager status and submit the verification code.'),

  ('mission-atlas-identity-plane-08-o1', 'mission-atlas-identity-plane-08', 1, 'Explain KMS concepts', 'Choose the accurate description of what a KMS key actually protects.'),

  ('mission-atlas-identity-plane-09-o1', 'mission-atlas-identity-plane-09', 1, 'Check the rotation history', 'Read the rotation log and submit the verification code.'),

  ('mission-atlas-identity-plane-10-o1', 'mission-atlas-identity-plane-10', 1, 'Explain workload identity', 'Choose the accurate description of what workload identity actually provides.'),

  ('mission-atlas-identity-plane-11-o1', 'mission-atlas-identity-plane-11', 1, 'Read the audit finding', 'Read the audit report and submit the verification code.'),

  ('mission-atlas-identity-plane-12-o1', 'mission-atlas-identity-plane-12', 1, 'Confirm the policy scope', 'Read the attached policy and submit the verification code.'),
  ('mission-atlas-identity-plane-12-o2', 'mission-atlas-identity-plane-12', 2, 'Confirm the rotation history', 'Read the rotation log and submit the verification code.'),
  ('mission-atlas-identity-plane-12-o3', 'mission-atlas-identity-plane-12', 3, 'Identify what actually explains this', 'Find the evidence that explains how this identity ended up this way.'),
  ('mission-atlas-identity-plane-12-o4', 'mission-atlas-identity-plane-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to replace this identity.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-identity-plane-01-o1-c1', 'mission-atlas-identity-plane-01-o1', 1, 'multiple_choice', 'A principal is best described as...', '{"question":"A principal is best described as...","options":[{"id":"a","text":"Any identity -- a user, a role, or a service identity -- that can authenticate and be granted permissions in a policy"},{"id":"b","text":"Only a human user, never a service or automated process"},{"id":"c","text":"A synonym for a physical server"},{"id":"d","text":"A type of encryption key"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-identity-plane-02-o1-c1', 'mission-atlas-identity-plane-02-o1', 1, 'multiple_choice', 'A user and a role differ in that...', '{"question":"A user and a role differ in that...","options":[{"id":"a","text":"A user is tied to one specific person with their own long-lived credentials; a role is not owned by anyone and is meant to be assumed temporarily by whoever needs it"},{"id":"b","text":"They are identical, just different naming conventions"},{"id":"c","text":"Roles can never be assumed by automated services, only people"},{"id":"d","text":"A user always has more permissions than any role"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-identity-plane-03-o1-c1', 'mission-atlas-identity-plane-03-o1', 1, 'terminal_simulation', 'Read the attached policy and submit the verification code.', '{"instructions":"Read /repo/infra/iam/policies.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/iam/policies.txt":{"type":"file","content":"policy: eu-west-bootstrap-admin\n  effect: Allow\n  action: \"*\"\n  resource: \"*\"\n  attached-to: svc-eu-west-bootstrap\n  note: created during Act 10 region buildout, marked TEMPORARY, never revisited\n# verification POLICY-3312\n"}}}'::jsonb, '{"requiredFlag":"POLICY-3312"}'::jsonb),

  ('mission-atlas-identity-plane-04-o1-c1', 'mission-atlas-identity-plane-04-o1', 1, 'multiple_choice', 'Least privilege means...', '{"question":"Least privilege means...","options":[{"id":"a","text":"Granting a principal exactly the permissions its task actually needs, and nothing more, so any compromise stays bounded"},{"id":"b","text":"Granting the minimum number of principals access, regardless of how broad each one''s permissions are"},{"id":"c","text":"Always granting full administrative access, since revoking it later is easy"},{"id":"d","text":"A synonym for multi-factor authentication"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-identity-plane-05-o1-c1', 'mission-atlas-identity-plane-05-o1', 1, 'terminal_simulation', 'Read the service identity listing and submit the verification code.', '{"instructions":"Read /repo/infra/iam/service-identities.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/iam/service-identities.txt":{"type":"file","content":"svc-metrics-collector   policy=metrics-read-write        credential=temporary (STS, 1h)\nsvc-atlas-ci-runner     policy=ci-pipeline-scoped        credential=temporary (STS, 1h)\nsvc-eu-west-bootstrap   policy=eu-west-bootstrap-admin   credential=static key, created 2026-08-05\n# verification SVCID-6602\n"}}}'::jsonb, '{"requiredFlag":"SVCID-6602"}'::jsonb),

  ('mission-atlas-identity-plane-06-o1-c1', 'mission-atlas-identity-plane-06-o1', 1, 'terminal_simulation', 'Read the credential audit and submit the verification code.', '{"instructions":"Read /var/atlas-audit/credentials-audit.txt and submit the verification code with: submit CODE","hostname":"atlas-audit-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-audit-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-audit/credentials-audit.txt":{"type":"file","content":"credential audit:\n  svc-metrics-collector: temporary, auto-expires 1h, reissued automatically\n  svc-atlas-ci-runner: temporary, auto-expires 1h, reissued automatically\n  svc-eu-west-bootstrap: STATIC key, no expiry, issued once on 2026-08-05\n# verification CREDAUDIT-7714\n"}}}'::jsonb, '{"requiredFlag":"CREDAUDIT-7714"}'::jsonb),

  ('mission-atlas-identity-plane-07-o1-c1', 'mission-atlas-identity-plane-07-o1', 1, 'terminal_simulation', 'Read the secrets manager status and submit the verification code.', '{"instructions":"Read /var/atlas-audit/secrets-manager-status.txt and submit the verification code with: submit CODE","hostname":"atlas-audit-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-audit-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-audit/secrets-manager-status.txt":{"type":"file","content":"secrets tracked by the Atlas secrets manager: ATLAS_AUTH_TOKEN, atlas-release-signing-key, atlas-metrics-agent-db-password\nsvc-eu-west-bootstrap static key: NOT present in the secrets manager -- stored directly as a plaintext variable in the bootstrap config\n# verification SECRETSMGR-4471\n"}}}'::jsonb, '{"requiredFlag":"SECRETSMGR-4471"}'::jsonb),

  ('mission-atlas-identity-plane-08-o1-c1', 'mission-atlas-identity-plane-08-o1', 1, 'multiple_choice', 'A KMS key''s actual job is to...', '{"question":"A KMS key''s actual job is to...","options":[{"id":"a","text":"Encrypt data such as secrets at rest, with its own separate access control layer independent of who can request the secret itself"},{"id":"b","text":"Replace the need for any IAM policy entirely"},{"id":"c","text":"Automatically rotate every credential in the system"},{"id":"d","text":"Serve as a synonym for a service identity"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-identity-plane-09-o1-c1', 'mission-atlas-identity-plane-09-o1', 1, 'terminal_simulation', 'Read the rotation log and submit the verification code.', '{"instructions":"Read /var/atlas-audit/rotation-log.txt and submit the verification code with: submit CODE","hostname":"atlas-audit-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-audit-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-audit/rotation-log.txt":{"type":"file","content":"rotation history (last 90 days):\n  svc-metrics-collector token: rotated automatically every 1h (2160 rotations)\n  svc-atlas-ci-runner token: rotated automatically every 1h (2160 rotations)\n  svc-eu-west-bootstrap key: 0 rotations since creation on 2026-08-05\n# verification ROTATE-8802\n"}}}'::jsonb, '{"requiredFlag":"ROTATE-8802"}'::jsonb),

  ('mission-atlas-identity-plane-10-o1-c1', 'mission-atlas-identity-plane-10-o1', 1, 'multiple_choice', 'Workload identity is best described as...', '{"question":"Workload identity is best described as...","options":[{"id":"a","text":"Letting a running service assume an identity dynamically through the platform itself for exactly as long as it runs, so no static standing credential ever has to exist"},{"id":"b","text":"A synonym for a static API key"},{"id":"c","text":"Assigning every workload the same shared root credential for simplicity"},{"id":"d","text":"A feature that only applies to human user logins"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-identity-plane-11-o1-c1', 'mission-atlas-identity-plane-11-o1', 1, 'terminal_simulation', 'Read the audit report and submit the verification code.', '{"instructions":"Read /var/atlas-audit/audit-report.txt and submit the verification code with: submit CODE","hostname":"atlas-audit-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-audit-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-audit/audit-report.txt":{"type":"file","content":"Atlas Division quarterly IAM audit -- finding AUD-2291\nidentity: svc-eu-west-bootstrap\nissue: full-account-scope policy (action=*, resource=*), static credential, zero rotations, not tracked in the secrets manager\ncreated: 2026-08-05, during the eu-west region buildout, marked TEMPORARY\nstatus: still active\n# verification AUDIT-2291\n"}}}'::jsonb, '{"requiredFlag":"AUDIT-2291"}'::jsonb),

  ('mission-atlas-identity-plane-12-o1-c1', 'mission-atlas-identity-plane-12-o1', 1, 'terminal_simulation', 'Read the attached policy and submit the verification code.', '{"instructions":"Read /repo/infra/iam/policies.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/iam/policies.txt":{"type":"file","content":"policy: eu-west-bootstrap-admin\n  effect: Allow\n  action: \"*\"\n  resource: \"*\"\n  attached-to: svc-eu-west-bootstrap\n  note: created during Act 10 region buildout, marked TEMPORARY, never revisited\n# verification POLICY-3312\n"}}}'::jsonb, '{"requiredFlag":"POLICY-3312"}'::jsonb),
  ('mission-atlas-identity-plane-12-o2-c1', 'mission-atlas-identity-plane-12-o2', 1, 'terminal_simulation', 'Read the rotation log and submit the verification code.', '{"instructions":"Read /var/atlas-audit/rotation-log.txt and submit the verification code with: submit CODE","hostname":"atlas-audit-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-audit-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-audit/rotation-log.txt":{"type":"file","content":"rotation history (last 90 days):\n  svc-metrics-collector token: rotated automatically every 1h (2160 rotations)\n  svc-atlas-ci-runner token: rotated automatically every 1h (2160 rotations)\n  svc-eu-west-bootstrap key: 0 rotations since creation on 2026-08-05\n# verification ROTATE-8802\n"}}}'::jsonb, '{"requiredFlag":"ROTATE-8802"}'::jsonb),
  ('mission-atlas-identity-plane-12-o3-c1', 'mission-atlas-identity-plane-12-o3', 1, 'investigation', 'Which evidence explains how this identity ended up this way?', '{"evidence":[{"id":"e1","label":"Attached policy","detail":"eu-west-bootstrap-admin grants unrestricted action=* on resource=*, marked TEMPORARY at creation and never revisited"},{"id":"e2","label":"Rotation log","detail":"The static credential has never rotated once since it was created on 2026-08-05"},{"id":"e3","label":"Service identity listing","detail":"Every other service identity in the fleet uses scoped policies and temporary, auto-expiring credentials"},{"id":"e4","label":"KMS notes","detail":"The KMS key protecting secrets at rest has its own independent access control layer"}],"question":"Which evidence explains how this identity ended up this way?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2"]}'::jsonb),
  ('mission-atlas-identity-plane-12-o4-c1', 'mission-atlas-identity-plane-12-o4', 1, 'boss_encounter', 'Having confirmed the policy scope, the rotation history, and what actually explains this, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-identity-plane-12-o1","label":"Confirm the policy scope"},{"objectiveRef":"mission-atlas-identity-plane-12-o2","label":"Confirm the rotation history"},{"objectiveRef":"mission-atlas-identity-plane-12-o3","label":"Identify what actually explains this"}],"task":"State the diagnosis in one sentence: svc-eu-west-bootstrap was created honestly, under real time pressure, with a deliberately broad policy marked TEMPORARY to unblock the Act 10 region buildout -- and nobody ever came back to scope it down, rotate its static credential, or move it into the secrets manager, so a shortcut that was always meant to be finished became a standing master key, and it needs to be replaced with a properly scoped role using workload identity, not patched in place."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-identity-plane-12-o1","mission-atlas-identity-plane-12-o2","mission-atlas-identity-plane-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-identity-plane-01-o1-c1', 'orientation', 'Think about who or what a policy is actually granted to.', 10, 1),
  ('mission-atlas-identity-plane-01-o1-c1', 'solution', 'A principal is any identity, human or service, that can authenticate and hold permissions.', 20, 2),

  ('mission-atlas-identity-plane-02-o1-c1', 'orientation', 'Think about ownership versus something meant to be assumed temporarily.', 10, 1),
  ('mission-atlas-identity-plane-02-o1-c1', 'solution', 'A user belongs to one person; a role is assumed temporarily by whoever needs it.', 20, 2),

  ('mission-atlas-identity-plane-03-o1-c1', 'orientation', 'Try: cat /repo/infra/iam/policies.txt', 10, 1),
  ('mission-atlas-identity-plane-03-o1-c1', 'solution', 'The policy allows action * on resource *, verification POLICY-3312. submit POLICY-3312', 20, 2),

  ('mission-atlas-identity-plane-04-o1-c1', 'orientation', 'Think about bounding the damage a compromise could actually do.', 10, 1),
  ('mission-atlas-identity-plane-04-o1-c1', 'solution', 'Grant only what a task actually needs, nothing more.', 20, 2),

  ('mission-atlas-identity-plane-05-o1-c1', 'orientation', 'Try: cat /repo/infra/iam/service-identities.txt', 10, 1),
  ('mission-atlas-identity-plane-05-o1-c1', 'solution', 'svc-eu-west-bootstrap is the outlier, verification SVCID-6602. submit SVCID-6602', 20, 2),

  ('mission-atlas-identity-plane-06-o1-c1', 'orientation', 'Try: cat /var/atlas-audit/credentials-audit.txt', 10, 1),
  ('mission-atlas-identity-plane-06-o1-c1', 'solution', 'It uses a static key, not a temporary one, verification CREDAUDIT-7714. submit CREDAUDIT-7714', 20, 2),

  ('mission-atlas-identity-plane-07-o1-c1', 'orientation', 'Try: cat /var/atlas-audit/secrets-manager-status.txt', 10, 1),
  ('mission-atlas-identity-plane-07-o1-c1', 'solution', 'It is not tracked at all, verification SECRETSMGR-4471. submit SECRETSMGR-4471', 20, 2),

  ('mission-atlas-identity-plane-08-o1-c1', 'orientation', 'Think about encrypting data versus deciding who can ask for it.', 10, 1),
  ('mission-atlas-identity-plane-08-o1-c1', 'solution', 'KMS encrypts data at rest, with its own separate access control layer.', 20, 2),

  ('mission-atlas-identity-plane-09-o1-c1', 'orientation', 'Try: cat /var/atlas-audit/rotation-log.txt', 10, 1),
  ('mission-atlas-identity-plane-09-o1-c1', 'solution', 'Zero rotations since creation, verification ROTATE-8802. submit ROTATE-8802', 20, 2),

  ('mission-atlas-identity-plane-10-o1-c1', 'orientation', 'Think about identity assumed dynamically versus a key that just sits there.', 10, 1),
  ('mission-atlas-identity-plane-10-o1-c1', 'solution', 'Workload identity lets a service assume identity dynamically, with no standing credential.', 20, 2),

  ('mission-atlas-identity-plane-11-o1-c1', 'orientation', 'Try: cat /var/atlas-audit/audit-report.txt', 10, 1),
  ('mission-atlas-identity-plane-11-o1-c1', 'solution', 'Finding AUD-2291, verification AUDIT-2291. submit AUDIT-2291', 20, 2),

  ('mission-atlas-identity-plane-12-o1-c1', 'orientation', 'Try: cat /repo/infra/iam/policies.txt', 10, 1),
  ('mission-atlas-identity-plane-12-o1-c1', 'solution', 'verification POLICY-3312. submit POLICY-3312', 20, 2),
  ('mission-atlas-identity-plane-12-o2-c1', 'orientation', 'Try: cat /var/atlas-audit/rotation-log.txt', 10, 1),
  ('mission-atlas-identity-plane-12-o2-c1', 'solution', 'verification ROTATE-8802. submit ROTATE-8802', 20, 2),
  ('mission-atlas-identity-plane-12-o3-c1', 'orientation', 'Every other identity looks normal and is irrelevant to this specific finding. Look for what is actually wrong with this one identity itself.', 10, 1),
  ('mission-atlas-identity-plane-12-o3-c1', 'solution', 'e1 and e2: an unrestricted policy that was never scoped down, paired with a credential that never once rotated.', 20, 2),
  ('mission-atlas-identity-plane-12-o4-c1', 'orientation', 'Combine the broad policy, the zero rotations, and what should replace it into one sentence.', 15, 1),
  ('mission-atlas-identity-plane-12-o4-c1', 'solution', 'A temporary, full-access identity created to unblock the region buildout was never scoped down or rotated -- it needs a properly scoped role using workload identity, not a patch.', 25, 2);
