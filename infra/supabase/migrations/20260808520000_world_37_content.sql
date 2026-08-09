-- world-37 ("Entra ID / Hybrid Identity: Cloud Identities") mission
-- content, generated from docs/12-world-story-bible.md. Mission 1 is
-- cross-world-gated on world-36's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-37a', 'world-37', 'cloud-identities', '37A - Cloud Identities', 'The synchronization account has a matching identity in an actual cloud tenant. Hybrid identity means one compromise doesn''t stay contained to one side.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-37a-1', 'campaign-37a', 'foundations', 'Foundations', 'Tenants, service principals, consent and conditional access, learned by tracing identity across a boundary.', 1),
  ('operation-37a-2', 'campaign-37a', 'investigation', 'Investigation', 'Close the excess access without breaking legitimate synchronization.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w37-01', 'world-37', 'campaign-37a', 'operation-37a-1', 'across-the-boundary', 'Across the Boundary', 'That synchronization account has a matching identity in an actual cloud tenant, and that tenant hosts services we haven''t even looked at yet.', 'intro', ARRAY['byte', 'luna'], '{"requiredMissionIds":["mission-w36-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w37-02', 'world-37', 'campaign-37a', 'operation-37a-1', 'four-different-things', 'Four Different Things', 'A tenant, an app registration, a service principal and a managed identity are four different things that get blurred together constantly.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w37-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"entra-structure-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w37-03', 'world-37', 'campaign-37a', 'operation-37a-1', 'consent-isnt-binary', 'Consent Isn''t Binary', 'An app can be granted exactly the permission it needs, or something far broader that nobody actually reads before clicking approve.', 'beginner', ARRAY['luna'], '{"requiredMissionIds":["mission-w37-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"consent-grant-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w37-04', 'world-37', 'campaign-37a', 'operation-37a-2', 'only-as-strong-as-what-it-misses', 'Only as Strong as What It Misses', 'A conditional access policy is only as strong as what it doesn''t cover.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w37-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"conditional-access-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w37-05', 'world-37', 'campaign-37a', 'operation-37a-2', 'what-actually-crosses', 'What Actually Crosses', 'Federation and sync both extend trust across a boundary. The difference is what actually crosses it.', 'beginner', ARRAY['luna'], '{"requiredMissionIds":["mission-w37-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"hybrid-flow-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w37-06', 'world-37', 'campaign-37a', 'operation-37a-2', 'split-identity-boss', 'Split Identity', 'Trace exactly what the sync account can reach on the cloud side, then close the excess access without breaking the actual synchronization job.', 'boss', ARRAY['byte', 'luna'], '{"requiredMissionIds":["mission-w37-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"split-identity-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["split-identity"],"skillXp":{"cloud_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w37-01', 1, 'byte', 'That synchronization account isn''t just an AD object anymore. It has a matching identity in an actual cloud tenant, and that tenant hosts services we haven''t even looked at yet.'),
  ('mission-w37-01', 2, 'luna', 'Hybrid identity means one compromise doesn''t stay contained to one side. On-prem and cloud trust each other by design -- that''s the entire point of synchronization.'),
  ('mission-w37-01', 3, 'byte', 'Tenants, app registrations, service principals, managed identities, conditional access. New vocabulary, same underlying question: what does this identity actually reach?'),
  ('mission-w37-01', 4, 'luna', 'Let''s trace it across the boundary.'),
  ('mission-w37-02', 1, 'byte', 'A tenant is the cloud directory itself. An app registration defines an application''s identity. A service principal is that application actually operating inside a specific tenant. A managed identity is Azure handling all of that automatically for its own resources.'),
  ('mission-w37-03', 1, 'luna', 'Consent isn''t binary. An app can be granted exactly the permission it needs, or something far broader that nobody actually reads before clicking approve.'),
  ('mission-w37-04', 1, 'byte', 'A conditional access policy is only as strong as what it doesn''t cover. A legacy protocol that ignores modern authentication entirely can walk right past an MFA requirement.'),
  ('mission-w37-05', 1, 'luna', 'Federation and sync both extend trust across a boundary. The difference is what actually crosses it -- a redirect to prove identity, or a continuously synchronized copy of it.'),
  ('mission-w37-06', 1, 'byte', 'Trace exactly what the sync account can reach on the cloud side, then close the excess access without breaking the actual synchronization job.'),
  ('mission-w37-06', 2, 'luna', '...Found it. The sync account holds Global Administrator in the tenant. It only ever needed directory synchronization permissions.'),
  ('mission-w37-06', 3, 'byte', 'That''s not hybrid identity working as designed. That''s someone granting far more than the job required, at some point, and nobody ever walking it back.'),
  ('mission-w37-06', 4, 'luna', 'Scoped it down to exactly what synchronization needs. Retested -- sync still runs perfectly. The excess access is gone.'),
  ('mission-w37-06', 5, 'byte', 'While I was in there, I found something else. A cloud application in this tenant has network access to a private connector -- in a completely different region than anything else we''ve looked at.'),
  ('mission-w37-06', 6, 'luna', 'A private connector means it reaches into a network that isn''t publicly exposed at all. That''s not incidental. Someone built a deliberate path out there.'),
  ('mission-w37-06', 7, 'byte', 'We can''t just read our way into a private network. We''re going to have to actually understand tunneling and routing to follow it.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w37-01-o1', 'mission-w37-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to trace identity across the cloud boundary.'),
  ('mission-w37-02-o1', 'mission-w37-02', 1, 'Match each Entra concept', 'Sort each description to the correct Entra ID concept.'),
  ('mission-w37-03-o1', 'mission-w37-03', 1, 'Find the over-consented app', 'Identify the evidence showing an app holding more access than it needs.'),
  ('mission-w37-04-o1', 'mission-w37-04', 1, 'Explain the conditional access gap', 'Determine the risk created by excluding legacy authentication from an MFA policy.'),
  ('mission-w37-05-o1', 'mission-w37-05', 1, 'Order the hybrid sync flow', 'Order the steps of a hybrid identity sync and access flow.'),
  ('mission-w37-06-o1', 'mission-w37-06', 1, 'Confirm the over-privileged account', 'Identify the evidence showing the sync account is over-privileged in the tenant.'),
  ('mission-w37-06-o2', 'mission-w37-06', 2, 'Choose the correct fix', 'Select the fix that closes the excess access while keeping sync operational.'),
  ('mission-w37-06-o3', 'mission-w37-06', 3, 'Close the split', 'Confirm the over-privileged account and its fix together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w37-01-o1-c1', 'mission-w37-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"byte","text":"One boundary, two sides, one identity. Ready to trace it?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w37-02-o1-c1', 'mission-w37-02-o1', 1, 'drag_and_drop', 'Sort each description to the correct Entra ID concept.', '{"items":[{"id":"i1","text":"The cloud directory itself, containing all users, groups and registered applications for an organization"},{"id":"i2","text":"Defines an application''s identity and required permissions, shared across every tenant that installs it"},{"id":"i3","text":"The application actually operating inside one specific tenant, holding that tenant''s granted permissions"},{"id":"i4","text":"An identity Azure automatically creates and rotates credentials for, tied to a specific cloud resource"}],"targets":[{"id":"tenant","label":"Tenant"},{"id":"app_reg","label":"App Registration"},{"id":"service_principal","label":"Service Principal"},{"id":"managed_identity","label":"Managed Identity"}]}'::jsonb, '{"correctMapping":{"i1":"tenant","i2":"app_reg","i3":"service_principal","i4":"managed_identity"}}'::jsonb),

  ('mission-w37-03-o1-c1', 'mission-w37-03-o1', 1, 'investigation', 'Which evidence shows an application holding far more access than it actually requested or needs?', '{"evidence":[{"id":"c1","label":"App \"ReportViewer\" consent grant","detail":"Requested Mail.Read (read-only access to a single mailbox); granted exactly that"},{"id":"c2","label":"App \"LegacySyncTool\" consent grant","detail":"Requested Mail.Read; was granted Mail.ReadWrite.All (full read/write access to every mailbox in the tenant) during admin consent"},{"id":"c3","label":"Admin consent audit log for LegacySyncTool","detail":"Approved in a single click during a bulk consent review, no documented justification for the broader scope"}],"question":"Which evidence shows an application holding far more access than it actually requested or needs?"}'::jsonb, '{"requiredEvidenceIds":["c2","c3"]}'::jsonb),

  ('mission-w37-04-o1-c1', 'mission-w37-04-o1', 1, 'multiple_choice', 'A conditional access policy requires MFA for all sign-ins to the tenant, except it excludes legacy authentication protocols for compatibility with one old application. What risk does this create?', '{"question":"A conditional access policy requires MFA for all sign-ins to the tenant, except it excludes legacy authentication protocols for compatibility with one old application. What risk does this create?","options":[{"id":"a","text":"None, legacy protocols are inherently secure"},{"id":"b","text":"Legacy authentication protocols don''t support modern MFA prompts at all, so any account still reachable through them can be accessed with just a username and password, completely bypassing the MFA requirement"},{"id":"c","text":"It only affects the one old application, nothing else"},{"id":"d","text":"Legacy protocols are automatically blocked regardless of policy"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w37-05-o1-c1', 'mission-w37-05-o1', 1, 'interactive_diagram', 'Order these steps of a hybrid identity sync and access flow.', '{"hotspots":[{"id":"onprem_change","label":"A user or group changes in the on-prem Active Directory","explanation":"The starting point -- on-prem AD remains the authoritative source in this hybrid setup."},{"id":"sync_agent","label":"The synchronization agent detects the change and pushes it to the cloud directory","explanation":"Runs on a schedule, continuously keeping the cloud copy aligned with on-prem."},{"id":"cloud_directory","label":"The cloud directory (tenant) updates its matching object","explanation":"Now reflects the on-prem change, available to every cloud service in the tenant."},{"id":"conditional_access","label":"A sign-in attempt is evaluated against conditional access policy","explanation":"Checks conditions like MFA, device compliance and location before granting access."},{"id":"resource_access","label":"Access is granted to the actual cloud resource","explanation":"The final step -- the identity now has hands-on access to whatever it was requesting."}],"task":"Order these steps of a hybrid identity sync and access flow."}'::jsonb, '{"correctOrderIds":["onprem_change","sync_agent","cloud_directory","conditional_access","resource_access"]}'::jsonb),

  ('mission-w37-06-o1-c1', 'mission-w37-06-o1', 1, 'investigation', 'Which evidence together shows the sync account is over-privileged in the cloud tenant?', '{"evidence":[{"id":"g1","label":"Sync account''s cloud role assignment","detail":"Global Administrator -- the highest privilege role available in the tenant"},{"id":"g2","label":"Directory synchronization documentation","detail":"States the sync account only requires the dedicated \"Directory Synchronization Accounts\" role to function"},{"id":"g3","label":"Role assignment history","detail":"Global Administrator was granted during initial tenant setup years ago and never reviewed since"},{"id":"g4","label":"An unrelated, correctly scoped service principal","detail":"Holds only the specific permissions its function requires"}],"question":"Which evidence together shows the sync account is over-privileged in the cloud tenant?"}'::jsonb, '{"requiredEvidenceIds":["g1","g2","g3"]}'::jsonb),

  ('mission-w37-06-o2-c1', 'mission-w37-06-o2', 1, 'multiple_choice', 'What''s the correct fix that closes the excess access while keeping synchronization operational?', '{"question":"What''s the correct fix that closes the excess access while keeping synchronization operational?","options":[{"id":"a","text":"Delete the sync account entirely"},{"id":"b","text":"Reassign the sync account to the dedicated Directory Synchronization Accounts role instead of Global Administrator, then verify synchronization still functions correctly"},{"id":"c","text":"Leave Global Administrator in place since removing roles is risky"},{"id":"d","text":"Disable hybrid identity entirely"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w37-06-o3-c1', 'mission-w37-06-o3', 1, 'boss_encounter', 'Confirm the over-privileged account and its fix together.', '{"stages":[{"objectiveRef":"mission-w37-06-o1","label":"The over-privileged account"},{"objectiveRef":"mission-w37-06-o2","label":"The fix"}],"task":"Confirm the over-privileged account and its fix together."}'::jsonb, '{"requiredObjectiveIds":["mission-w37-06-o1","mission-w37-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w37-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w37-02-o1-c1', 'orientation', 'Ask whether each thing is a directory, a definition, an instance, or an automatically managed identity.', 15, 1),
  ('mission-w37-02-o1-c1', 'solution', 'Tenant holds everything, app registration defines an app''s identity, service principal is that app instantiated in one tenant, and managed identity is Azure-managed automatically.', 25, 2),

  ('mission-w37-03-o1-c1', 'orientation', 'Compare what each app actually requested against what it was actually granted.', 15, 1),
  ('mission-w37-03-o1-c1', 'concept', 'A grant that''s broader than the request, approved without documented justification, is exactly how excess access accumulates unnoticed.', 25, 2),
  ('mission-w37-03-o1-c1', 'solution', 'LegacySyncTool requested read-only mail access but was granted full read/write to every mailbox (c2), approved in a single undocumented click (c3) -- ReportViewer''s grant matches its request exactly.', 35, 3),

  ('mission-w37-04-o1-c1', 'orientation', 'Ask whether the excluded protocol can even present an MFA prompt in the first place.', 15, 1),
  ('mission-w37-04-o1-c1', 'solution', 'Legacy protocols predate modern MFA entirely -- excluding them from the policy means username and password alone is still sufficient through that path. Option b.', 25, 2),

  ('mission-w37-05-o1-c1', 'orientation', 'The change starts on-prem and has to travel through several steps before a resource is actually reached.', 15, 1),
  ('mission-w37-05-o1-c1', 'concept', 'Sync pushes the change to the cloud directory first; only afterward does an actual sign-in get evaluated and granted access.', 25, 2),
  ('mission-w37-05-o1-c1', 'solution', 'On-prem change -> sync agent pushes it -> cloud directory updates -> conditional access evaluates a sign-in -> resource access granted.', 35, 3),

  ('mission-w37-06-o1-c1', 'orientation', 'One of these four items describes an unrelated, correctly configured identity.', 15, 1),
  ('mission-w37-06-o1-c1', 'concept', 'Over-privilege needs three things: the excessive grant itself, proof it wasn''t actually necessary, and how long it''s gone unreviewed.', 25, 2),
  ('mission-w37-06-o1-c1', 'tool_direction', 'Compare the sync account''s actual role against the documented minimum requirement.', 35, 3),
  ('mission-w37-06-o1-c1', 'solution', 'Global Administrator (g1) far exceeds the documented minimum requirement (g2), and it''s gone unreviewed since initial setup (g3) -- together, confirmed over-privilege.', 45, 4),

  ('mission-w37-06-o2-c1', 'orientation', 'The fix needs to match the account''s actual job, not remove its ability to do that job.', 15, 1),
  ('mission-w37-06-o2-c1', 'solution', 'Reassigning to the dedicated synchronization role removes the excess privilege while keeping the account fully able to do its actual job. Option b.', 25, 2),

  ('mission-w37-06-o3-c1', 'orientation', 'You''ve already confirmed the over-privilege and chosen the fix -- combine them.', 20, 1),
  ('mission-w37-06-o3-c1', 'concept', 'The closure needs to name the excess role and the correctly scoped replacement.', 30, 2),
  ('mission-w37-06-o3-c1', 'tool_direction', 'State the Global Administrator finding first, then the reassignment to the sync-specific role.', 40, 3),
  ('mission-w37-06-o3-c1', 'near_solution', 'Sync account held unreviewed Global Administrator access; reassigned to the dedicated Directory Synchronization Accounts role, sync still functions.', 50, 4),
  ('mission-w37-06-o3-c1', 'solution', 'The synchronization account held Global Administrator in the cloud tenant -- granted at initial setup and never reviewed since, far beyond the dedicated Directory Synchronization Accounts role it actually needs. Reassigning it to that dedicated role closes the excess access while synchronization continues to function exactly as before.', 65, 5);
