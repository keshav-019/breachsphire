-- Atlas Division pathway ("The Silence"): World row for Act 5, "The
-- Artifact Factory", still under act-atlas-2 ("World II -- The
-- Factory", which spans Acts 4-7: Git, Build, CI, CD) -- no new Act row
-- needed. Content (missions) follows in its own migration.
--
-- Narrative thread: Act 4 closed on the gap between git recording a fix
-- and production running it -- v12.1.0 was tagged, reviewed and merged,
-- but no pipeline ever turned it into a release artifact. Rook continues
-- leading (Platform Engineer, build/release firmly inside their doc-
-- stated "developer platforms, golden paths, GitOps" domain), now
-- tracing that exact gap: how a tagged commit is supposed to become a
-- built, reproducible, verifiable artifact at all.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-artifact-factory', 'act-atlas-2', 4, 'artifact-factory', 'The Artifact Factory', 'The Artifact Factory',
   'Build pipelines; dependencies; lockfiles; reproducible builds; artifact repositories; registries; checksums; SBOM concepts; signing; build cache; promotion instead of rebuilding.',
   'Git proved the fix exists. It said nothing about how a tagged commit becomes a running system. Rook starts at the other end of that gap -- not the repository, but the factory floor: whatever is supposed to turn a tag into a built, verifiable artifact, and why it never touched v12.1.0.',
   'Works on My Machine',
   'The developer who fixed the image config did build and test it -- on their own machine, by hand, and it worked. But that build was never reproducible, never checksummed, never signed, and never touched the actual artifact pipeline at all, because the one thing supposed to trigger that pipeline -- the pre-push hook -- was the same stub Rook already found doing nothing. A correct fix, proven once on one laptop, is not a release. It is exactly the gap this Act was built to close.',
   'One artifact, built the same way every time by the same trusted pipeline, is finally real. The next question is what actually proves that pipeline itself can be trusted before anything it builds ships anywhere.',
   'Works on My Machine', 'Package', 'guarded', 44, 20, 'pathway-atlas');
