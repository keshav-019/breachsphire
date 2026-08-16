-- Atlas Division pathway ("The Silence"): Act row for World II -- "The
-- Factory" (Acts 4-7 of the doc: Git, Build, CI, CD) -- plus the World
-- row for its first Act, "Source of Truth" (Git & releases). Content
-- (missions) follows in its own migration, same two-step pattern as
-- every prior World.
--
-- Narrative thread: Act 3's transition_hook ("an undersized image should
-- never have reached production in the first place... that question
-- starts further upstream, with how Atlas Division actually builds and
-- ships anything at all") is picked up directly. Rook, Platform
-- Engineer, makes their speaking debut here -- their doc-stated
-- specialty is "developer platforms, golden paths, GitOps," an exact
-- match for a world about git as the source of truth for what actually
-- gets built and shipped.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-atlas-2', 1, 'the-factory', 'World II -- The Factory',
   'The dying collector traced back to a machine image that should never have reached production raises a harder question: how does anything Atlas Division builds actually get from a change to a running system? The player learns git as the source of truth, how builds turn commits into artifacts, how CI proves a change is safe, and how CD actually ships it -- while Rook uncovers that the fix for the undersized image was merged, tagged and reviewed weeks ago, and never once became a real release.',
   'Can operate one host confidently -> understands the entire path from a git commit to a running production system',
   'pathway-atlas');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-source-of-truth', 'act-atlas-2', 3, 'source-of-truth', 'Source of Truth', 'Source of Truth',
   'Git as the source of truth for production: internals intuition, branches, merge versus rebase, tags, pull requests, protected branches, review, semantic versioning, release artifacts, git hooks and a first look at GitOps.',
   'The collector''s image manifest is a dead end on its own -- built once, never resized, never revisited. Rook pulls up the repository that is supposed to define what "resized" even means, to find out whether anyone actually fixed this before, and if so, where that fix went.',
   'The Missing Release',
   'Someone did fix this. Weeks ago, a pull request resizing the image config was reviewed, approved and merged to main, then tagged v12.1.0 -- exactly the fix the collector needed. But git recording a fix and production running that fix are two different things, and nobody ever turned that tagged commit into an actual release artifact. The truth was always in the repository. It just never left it.',
   'Git proves the fix exists. It says nothing about how a tagged commit is supposed to become a running system -- and that gap is exactly where this fix disappeared.',
   'The Missing Release', 'GitBranch', 'guarded', 32, 20, 'pathway-atlas');
