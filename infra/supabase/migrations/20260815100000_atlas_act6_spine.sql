-- Atlas Division pathway ("The Silence"): World row for Act 6, "The
-- Pipeline", still under act-atlas-2 ("World II -- The Factory", which
-- spans Acts 4-7: Git, Build, CI, CD) -- no new Act row needed. Content
-- (missions) follows in its own migration.
--
-- Narrative thread: Act 5 diagnosed exactly why v12.1.0 never became a
-- release -- the pre-push hook that should trigger a build was never
-- wired up. This Act is where Rook actually wires it, and the pipeline
-- finally runs for real for the first time. It does not go green: the
-- security-check stage catches something no human review or local build
-- ever would have -- a real credential hardcoded into the same fix that
-- was supposed to resolve everything.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-the-pipeline', 'act-atlas-2', 5, 'the-pipeline', 'The Pipeline', 'The Pipeline',
   'Why CI exists; pipeline anatomy; runners; build, lint and test stages; security checks; artifacts; dependency caching; parallel jobs; pipeline secrets.',
   'The dead pre-push hook is a five-minute fix. Rook wires it up, pushes the v12.1.0 tag again, and for the first time in this Act''s entire story, a real pipeline actually starts running against the fix everyone has already confirmed is correct.',
   'Red Build',
   'The pipeline is not wrong to fail. Its security-check stage finds a live authentication token hardcoded directly into the same commit that fixed the image config -- valid, unrevoked, and invisible to every human check that already happened: the developer''s own local test, Rook''s own PR review, even the merge to main. Nobody was careless. This is exactly the check none of those steps were ever capable of running.',
   'The pipeline just proved its entire reason for existing. Before v12.1.0 can go anywhere near production, that token has to be revoked -- and only then does this fix actually get to ship.',
   'Red Build', 'GitPullRequest', 'guarded', 44, 28, 'pathway-atlas');
