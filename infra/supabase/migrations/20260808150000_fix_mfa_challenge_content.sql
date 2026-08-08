-- Phase 3 content fix, found while building the client that consumes it:
-- mission-w0-07-o2-c1 ("Turn it on" -- MFA enrollment) requires
-- completionConditions.requiredActionId = 'mfa-enrolled', but the client
-- never sees completionConditions (Phase 2.5, deliberately -- that's the
-- answer key) and the original content never told the client what action
-- id to submit. Every other World 0 challenge's answer is constructible
-- from ids already visible in `content`; this was the one exception.
-- Not editing the Phase 2.4 migration in place -- same reasoning as the
-- earlier profiles.rank default fix.

update public.challenges
set content = content || '{"actionId":"mfa-enrolled"}'::jsonb
where id = 'mission-w0-07-o2-c1';
