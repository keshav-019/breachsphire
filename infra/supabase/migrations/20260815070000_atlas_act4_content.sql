-- Atlas Division pathway ("The Silence") Act 4 -- "Source of Truth"
-- content, under world-atlas-source-of-truth (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), opening World II "The Factory" (Acts 4-7: Git, Build, CI, CD).
--
-- The terminal engine (apps/web/src/lib/terminal/commands.ts) has no
-- git-specific commands at all -- confirmed by source read, same
-- constraint noted for this Act back when the Atlas spine was first
-- planned. Every git artifact in this Act (branch list, tags, PR
-- record, review log, changelog, release manifest, hook script, GitOps
-- manifest) is instead seeded as static filesystem content for the
-- player to `cat`/`grep`, reusing the exact "read a seeded config file"
-- trick already used throughout Acts 1-3 for SSH config, routing
-- tables, firewall rules, machine images and bootstrap scripts. Purely
-- conceptual topics (git internals intuition, merge vs rebase,
-- protected branches) stay multiple_choice, matching the established
-- per-topic mix-ratio discipline from Act 2 rather than forcing every
-- topic into a terminal simulation it does not naturally have.
--
-- Narrative thread: Rook (Platform Engineer, debut) traces the
-- undersized image from Act 3 back through git and finds the fix
-- already exists there -- branched, reviewed, approved, merged, tagged
-- v12.1.0 -- but never turned into an actual release artifact, and the
-- GitOps manifest confirms production is still running the old tag.
-- Lands the world's story_reveal verbatim in the boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-source-of-truth', 'world-atlas-source-of-truth', 'source-of-truth', '2A - Source of Truth', 'Learn git as the source of truth for production -- internals intuition, branches, merge versus rebase, tags, pull requests, protected branches, review, semantic versioning, release artifacts, git hooks and GitOps -- while Rook traces the collector''s undersized image back through the repository that was always supposed to define it.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-source-of-truth-1', 'campaign-atlas-source-of-truth', 'what-git-actually-records', 'What Git Actually Records', 'Git internals intuition, branches, merge versus rebase, tags, pull requests and protected branches.', 1),
  ('operation-atlas-source-of-truth-2', 'campaign-atlas-source-of-truth', 'where-the-fix-went', 'Where the Fix Went', 'Review, semantic versioning, release artifacts, git hooks and GitOps preview.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-source-of-truth-01', 'world-atlas-source-of-truth', 'campaign-atlas-source-of-truth', 'operation-atlas-source-of-truth-1', 'git-internals-intuition', 'Git Internals Intuition', 'The collector''s memory limit is patched manually, for now. If nobody catches the next undersized image before production does, Atlas Division is right back here. Rook, Platform Engineer, takes over from here.', 'beginner', ARRAY['cross','leena','rook'], null, null, '{"type":"simulation","simulationId":"git-internals-intuition-sim"}'::jsonb, '{"xp":190,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-source-of-truth-02', 'world-atlas-source-of-truth', 'campaign-atlas-source-of-truth', 'operation-atlas-source-of-truth-1', 'branches', 'Branches', 'Every fix starts on a branch before it ever reaches main. If a fix for the image config exists at all, it started somewhere.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-source-of-truth-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"branches-sim"}'::jsonb, '{"xp":190,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-source-of-truth-03', 'world-atlas-source-of-truth', 'campaign-atlas-source-of-truth', 'operation-atlas-source-of-truth-1', 'merge-vs-rebase', 'Merge vs Rebase', 'The branch history shows a merge, not a rebase -- and that distinction changes how the fix''s history should be read.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-source-of-truth-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"merge-vs-rebase-sim"}'::jsonb, '{"xp":200,"credits":35}'::jsonb, false, 3),
  ('mission-atlas-source-of-truth-04', 'world-atlas-source-of-truth', 'campaign-atlas-source-of-truth', 'operation-atlas-source-of-truth-1', 'tags', 'Tags', 'A branch merging to main is not yet a release. Somewhere, if this really was fixed, that exact commit should have been tagged.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-source-of-truth-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"tags-sim"}'::jsonb, '{"xp":200,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-source-of-truth-05', 'world-atlas-source-of-truth', 'campaign-atlas-source-of-truth', 'operation-atlas-source-of-truth-1', 'pull-requests', 'Pull Requests', 'v12.1.0 exists. Now confirm it did not just land on main quietly -- find the pull request that actually proposed it.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-source-of-truth-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"pull-requests-sim"}'::jsonb, '{"xp":210,"credits":40}'::jsonb, false, 5),
  ('mission-atlas-source-of-truth-06', 'world-atlas-source-of-truth', 'campaign-atlas-source-of-truth', 'operation-atlas-source-of-truth-1', 'protected-branches', 'Protected Branches', 'PR #4471 could not have reached main by itself. Main is protected -- understand what that actually required before it was allowed to merge.', 'beginner', ARRAY['rook','leena'], '{"requiredMissionIds":["mission-atlas-source-of-truth-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"protected-branches-sim"}'::jsonb, '{"xp":210,"credits":40}'::jsonb, false, 6),
  ('mission-atlas-source-of-truth-07', 'world-atlas-source-of-truth', 'campaign-atlas-source-of-truth', 'operation-atlas-source-of-truth-2', 'review', 'Review', 'Protection requires an approval. Confirm this PR actually got one, and from whom.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-source-of-truth-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"review-sim"}'::jsonb, '{"xp":220,"credits":40}'::jsonb, false, 7),
  ('mission-atlas-source-of-truth-08', 'world-atlas-source-of-truth', 'campaign-atlas-source-of-truth', 'operation-atlas-source-of-truth-2', 'semantic-versioning', 'Semantic Versioning', 'v12.0.0-test became v12.1.0, not v13.0.0. Confirm the changelog agrees with that being the right kind of change.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-source-of-truth-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"semantic-versioning-sim"}'::jsonb, '{"xp":220,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-source-of-truth-09', 'world-atlas-source-of-truth', 'campaign-atlas-source-of-truth', 'operation-atlas-source-of-truth-2', 'release-artifacts', 'Release Artifacts', 'Branched, reviewed, approved, merged, tagged. Every step checks out. Now confirm what actually got built and deployed from tag v12.1.0.', 'beginner', ARRAY['rook','byte'], '{"requiredMissionIds":["mission-atlas-source-of-truth-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"release-artifacts-sim"}'::jsonb, '{"xp":230,"credits":45}'::jsonb, false, 9),
  ('mission-atlas-source-of-truth-10', 'world-atlas-source-of-truth', 'campaign-atlas-source-of-truth', 'operation-atlas-source-of-truth-2', 'git-hooks', 'Git Hooks', 'Something is supposed to notice when a tag like this lands and turn it into a build. Check whether that something actually exists.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-source-of-truth-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"git-hooks-sim"}'::jsonb, '{"xp":230,"credits":45}'::jsonb, false, 10),
  ('mission-atlas-source-of-truth-11', 'world-atlas-source-of-truth', 'campaign-atlas-source-of-truth', 'operation-atlas-source-of-truth-2', 'gitops-preview', 'GitOps Preview', 'Rook''s own team keeps a declarative record of what should be running everywhere. Check what it says about the collector right now.', 'beginner', ARRAY['rook'], '{"requiredMissionIds":["mission-atlas-source-of-truth-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"gitops-preview-sim"}'::jsonb, '{"xp":240,"credits":45}'::jsonb, false, 11),
  ('mission-atlas-source-of-truth-12', 'world-atlas-source-of-truth', 'campaign-atlas-source-of-truth', 'operation-atlas-source-of-truth-2', 'the-missing-release', 'The Missing Release', 'Everything this Act taught, turned on one fix: not to write it again, to finally explain how a change can be entirely correct in git and still never reach production.', 'boss', ARRAY['rook','leena','byte'], '{"requiredMissionIds":["mission-atlas-source-of-truth-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"missing-release-boss-sim"}'::jsonb, '{"xp":460,"credits":100,"badgeIds":["the-missing-release"],"skillXp":{"cloud_devops_fundamentals":70}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-source-of-truth-01', 1, 'cross', 'The collector''s memory limit is fixed for now -- manually, by hand, on that one host. If nobody catches the next undersized image before it reaches production, we are right back where we started.'),
  ('mission-atlas-source-of-truth-01', 2, 'leena', 'That is not a hosting problem anymore. That is a source-of-truth problem. Rook.'),
  ('mission-atlas-source-of-truth-01', 3, 'rook', 'Rook, Platform Engineer. Every image, every config, every fix Atlas Division ships is supposed to start in exactly one place: git. If something got fixed and still never shipped, git is where that story is actually written down.'),
  ('mission-atlas-source-of-truth-01', 4, 'rook', 'A commit is not a diff. It is a full, content-addressed snapshot of the entire project at that moment -- git just stores it efficiently against what came before. Get that right and branches, merges and tags all stop being magic.'),

  ('mission-atlas-source-of-truth-02', 1, 'rook', 'A branch is nothing more than a movable pointer to a commit. Every fix starts life on one, separate from main, before anyone decides it is ready to go anywhere else.'),

  ('mission-atlas-source-of-truth-03', 1, 'rook', 'A merge creates a new commit joining two histories together, side by side, exactly as they happened. A rebase replays one branch''s commits onto a new base instead -- a straighter history, but every one of those commits gets a new hash. Which one happened here changes how you should read what you are looking at.'),

  ('mission-atlas-source-of-truth-04', 1, 'rook', 'A branch merging to main is not a release. A tag is a fixed, permanent pointer to one exact commit -- if this was ever actually released, there should be a tag marking precisely where.'),

  ('mission-atlas-source-of-truth-05', 1, 'rook', 'v12.1.0 exists. That confirms someone tagged a fix. It does not confirm anyone reviewed it, or that it reached main honestly -- that story lives in the pull request, not the tag.'),

  ('mission-atlas-source-of-truth-06', 1, 'rook', 'This PR did not just land on main by someone pushing directly to it. Main is protected -- required checks, required approvals, no direct pushes allowed at all. Confirm what that protection actually demanded here.'),
  ('mission-atlas-source-of-truth-06', 2, 'leena', 'Protection is not bureaucracy. It is the only thing standing between "someone thought this was fine" and "someone confirmed this was fine."'),

  ('mission-atlas-source-of-truth-07', 1, 'rook', 'A protected branch requires an approval before it merges. Confirm this PR actually got one -- and that whoever gave it actually looked.'),

  ('mission-atlas-source-of-truth-08', 1, 'rook', 'v12.0.0-test became v12.1.0, not v13.0.0. A minor version bump means new, backward-compatible behavior -- nothing broken, nothing removed. Confirm the changelog actually agrees with that being the right call.'),

  ('mission-atlas-source-of-truth-09', 1, 'rook', 'Branched, reviewed, approved, merged, tagged. Every single step checks out. So confirm the part none of that actually guarantees on its own: what got built and deployed from that tag.'),
  ('mission-atlas-source-of-truth-09', 2, 'byte', 'I am cross-referencing the release history against every tag that has ever been created for this repository. This is going to matter.'),

  ('mission-atlas-source-of-truth-10', 1, 'rook', 'Somewhere, something is supposed to notice a tag like v12.1.0 landing and turn it into a build automatically -- that is what a hook is for. Confirm whether this repository''s actually does that, or just claims to.'),

  ('mission-atlas-source-of-truth-11', 1, 'rook', 'My own team keeps a declarative record of what should be running everywhere, and what actually is. If this fix truly never shipped, that gap should be sitting right there in plain text.'),

  ('mission-atlas-source-of-truth-12', 1, 'rook', 'Everything this Act taught you, on one fix. Not to write it again -- to finally explain how a change can be entirely correct in git, reviewed, approved, tagged, and still never once reach production.'),
  ('mission-atlas-source-of-truth-12', 2, 'byte', 'I have the tag history, the GitOps desired-state record and the actual release history all pulled up. Nothing here was ever rejected. Nothing here was ever wrong.'),
  ('mission-atlas-source-of-truth-12', 3, 'rook', 'Correct in git and running in production are two different claims. Find exactly where this fix stopped being both.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-source-of-truth-01-o1', 'mission-atlas-source-of-truth-01', 1, 'Define what a commit actually is', 'Choose the accurate description of what a git commit records.'),

  ('mission-atlas-source-of-truth-02-o1', 'mission-atlas-source-of-truth-02', 1, 'Read the branch list', 'List the repository''s branches and submit the verification code.'),

  ('mission-atlas-source-of-truth-03-o1', 'mission-atlas-source-of-truth-03', 1, 'Tell merge from rebase', 'Choose the accurate distinction between a merge and a rebase.'),

  ('mission-atlas-source-of-truth-04-o1', 'mission-atlas-source-of-truth-04', 1, 'Read the tag list', 'List the repository''s tags and submit the verification code for the fix release.'),

  ('mission-atlas-source-of-truth-05-o1', 'mission-atlas-source-of-truth-05', 1, 'Read the pull request record', 'Read the pull request that proposed the fix and submit its verification code.'),

  ('mission-atlas-source-of-truth-06-o1', 'mission-atlas-source-of-truth-06', 1, 'Explain branch protection', 'Choose the accurate description of what a protected branch actually enforces.'),

  ('mission-atlas-source-of-truth-07-o1', 'mission-atlas-source-of-truth-07', 1, 'Read the review record', 'Read the review record for the pull request and submit its verification code.'),

  ('mission-atlas-source-of-truth-08-o1', 'mission-atlas-source-of-truth-08', 1, 'Read the changelog', 'Read the changelog entry for v12.1.0 and submit its verification code.'),

  ('mission-atlas-source-of-truth-09-o1', 'mission-atlas-source-of-truth-09', 1, 'Find what actually shipped', 'Read the release history and submit the artifact actually deployed to the collector.'),

  ('mission-atlas-source-of-truth-10-o1', 'mission-atlas-source-of-truth-10', 1, 'Inspect the git hook', 'Read the repository''s pre-push hook and submit its verification code.'),

  ('mission-atlas-source-of-truth-11-o1', 'mission-atlas-source-of-truth-11', 1, 'Read the GitOps manifest', 'Read the GitOps desired-state manifest for the collector and submit its verification code.'),

  ('mission-atlas-source-of-truth-12-o1', 'mission-atlas-source-of-truth-12', 1, 'Confirm the fix was tagged', 'List the repository''s tags and submit the verification code for the fix release.'),
  ('mission-atlas-source-of-truth-12-o2', 'mission-atlas-source-of-truth-12', 2, 'Confirm the desired-versus-actual gap', 'Read the GitOps manifest and submit its verification code.'),
  ('mission-atlas-source-of-truth-12-o3', 'mission-atlas-source-of-truth-12', 3, 'Identify the root cause', 'Find the evidence that explains why a fully merged, tagged fix never reached production.'),
  ('mission-atlas-source-of-truth-12-o4', 'mission-atlas-source-of-truth-12', 4, 'State the diagnosis', 'Having confirmed all three, explain how the fix stopped being real between git and production.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-source-of-truth-01-o1-c1', 'mission-atlas-source-of-truth-01-o1', 1, 'multiple_choice', 'A git commit fundamentally records...', '{"question":"A git commit fundamentally records...","options":[{"id":"a","text":"A full, content-addressed snapshot of the entire project at that moment, stored efficiently against prior snapshots"},{"id":"b","text":"Only the lines that changed since the last commit, like a diff"},{"id":"c","text":"A copy of the remote server''s state at push time"},{"id":"d","text":"A lock on the files it touches until the next commit"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-source-of-truth-02-o1-c1', 'mission-atlas-source-of-truth-02-o1', 1, 'terminal_simulation', 'List the repository''s branches and submit the verification code.', '{"instructions":"Read /repo/branches.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/branches.txt":{"type":"file","content":"* main                    a1b2c3d  merged: fix/image-resize\n  fix/image-resize        a1b2c3d  Resize test-tier image config for production readiness\n  feature/gitops-preview  9f1e02c  WIP: GitOps desired-state preview\n# verification BRANCH-3301\n"}}}'::jsonb, '{"requiredFlag":"BRANCH-3301"}'::jsonb),

  ('mission-atlas-source-of-truth-03-o1-c1', 'mission-atlas-source-of-truth-03-o1', 1, 'multiple_choice', 'A merge and a rebase differ in that...', '{"question":"A merge and a rebase differ in that...","options":[{"id":"a","text":"A merge joins two histories with a new merge commit, preserving both as they happened; a rebase replays one branch''s commits onto a new base, producing a straighter history with new commit hashes"},{"id":"b","text":"They are identical, just different commands"},{"id":"c","text":"A rebase always deletes the original commits with no trace"},{"id":"d","text":"A merge can only be done on the main branch"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-source-of-truth-04-o1-c1', 'mission-atlas-source-of-truth-04-o1', 1, 'terminal_simulation', 'List the repository''s tags and submit the verification code for the fix release.', '{"instructions":"Read /repo/tags.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/tags.txt":{"type":"file","content":"v11.4.0       (previous stable image config)\nv12.0.0-test  (original test-tier build, still deployed)\nv12.1.0       a1b2c3d  Resize test-tier image config: cpu_limit 1->2, memory_limit_mb 512->2048\n# verification TAG-7742\n"}}}'::jsonb, '{"requiredFlag":"TAG-7742"}'::jsonb),

  ('mission-atlas-source-of-truth-05-o1-c1', 'mission-atlas-source-of-truth-05-o1', 1, 'terminal_simulation', 'Read the pull request that proposed the fix and submit its verification code.', '{"instructions":"Read /repo/pr-4471.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/pr-4471.txt":{"type":"file","content":"PR #4471: Resize test-tier image config for production readiness\nbranch: fix/image-resize -> main\nstatus: MERGED\nopened: 2026-07-20  merged: 2026-07-22\n# verification PR-4471\n"}}}'::jsonb, '{"requiredFlag":"PR-4471"}'::jsonb),

  ('mission-atlas-source-of-truth-06-o1-c1', 'mission-atlas-source-of-truth-06-o1', 1, 'multiple_choice', 'A protected branch actually enforces...', '{"question":"A protected branch actually enforces...","options":[{"id":"a","text":"Rules like required status checks and required reviewer approval, blocking any merge that has not satisfied them -- including direct pushes"},{"id":"b","text":"That only the repository owner can ever read the branch"},{"id":"c","text":"That the branch can never be deleted, but anything can still be pushed to it directly"},{"id":"d","text":"Automatic encryption of the branch''s commit history"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-source-of-truth-07-o1-c1', 'mission-atlas-source-of-truth-07-o1', 1, 'terminal_simulation', 'Read the review record for the pull request and submit its verification code.', '{"instructions":"Read /repo/review-4471.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/review-4471.txt":{"type":"file","content":"PR #4471 review:\nreviewer: rook\ndecision: APPROVED\ncomment: \"Confirmed sizing matches prod baseline. Approved.\"\nrequired_approvals: 1  received_approvals: 1\n# verification REVIEW-5561\n"}}}'::jsonb, '{"requiredFlag":"REVIEW-5561"}'::jsonb),

  ('mission-atlas-source-of-truth-08-o1-c1', 'mission-atlas-source-of-truth-08-o1', 1, 'terminal_simulation', 'Read the changelog entry for v12.1.0 and submit its verification code.', '{"instructions":"Read /repo/CHANGELOG.md and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/CHANGELOG.md":{"type":"file","content":"## v12.1.0 - 2026-07-22\n- Resized default image tier config (cpu_limit 1->2, memory_limit_mb 512->2048)\n- Backward compatible: existing deployments unaffected until rebuilt\n# verification SEMVER-2201\n"}}}'::jsonb, '{"requiredFlag":"SEMVER-2201"}'::jsonb),

  ('mission-atlas-source-of-truth-09-o1-c1', 'mission-atlas-source-of-truth-09-o1', 1, 'terminal_simulation', 'Read the release history and submit the artifact actually deployed to the collector.', '{"instructions":"Read /repo/releases.txt and submit the artifact filename actually deployed with: submit FILENAME","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/releases.txt":{"type":"file","content":"release artifacts built:\n  v11.4.0       -> atlas-image-v11.4.0.tar.gz        built 2026-05-01\n  v12.0.0-test  -> atlas-image-v12.0.0-test.tar.gz    built 2026-06-10  [currently deployed: metrics-collector-01]\n  v12.1.0       -> (no artifact found -- no build ever ran for this tag)\n"}}}'::jsonb, '{"requiredFlag":"atlas-image-v12.0.0-test.tar.gz"}'::jsonb),

  ('mission-atlas-source-of-truth-10-o1-c1', 'mission-atlas-source-of-truth-10-o1', 1, 'terminal_simulation', 'Read the repository''s pre-push hook and submit its verification code.', '{"instructions":"Read /repo/.git-hooks/pre-push and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/.git-hooks/pre-push":{"type":"file","content":"#!/bin/bash\n# pre-push hook: should trigger a build on push of a new tag\n# TODO: never wired up to the build pipeline\necho \"pre-push: no action configured\"\n# verification HOOK-4419\n"}}}'::jsonb, '{"requiredFlag":"HOOK-4419"}'::jsonb),

  ('mission-atlas-source-of-truth-11-o1-c1', 'mission-atlas-source-of-truth-11-o1', 1, 'terminal_simulation', 'Read the GitOps desired-state manifest for the collector and submit its verification code.', '{"instructions":"Read /repo/gitops/collector-image.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/gitops/collector-image.yaml":{"type":"file","content":"apiVersion: atlas.internal/v1\nkind: ImageBinding\nmetadata:\n  host: metrics-collector-01\nspec:\n  desiredImageTag: v12.1.0\nstatus:\n  actualImageTag: v12.0.0-test\n  synced: false\n# verification GITOPS-9981\n"}}}'::jsonb, '{"requiredFlag":"GITOPS-9981"}'::jsonb),

  ('mission-atlas-source-of-truth-12-o1-c1', 'mission-atlas-source-of-truth-12-o1', 1, 'terminal_simulation', 'List the repository''s tags and submit the verification code for the fix release.', '{"instructions":"Read /repo/tags.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/tags.txt":{"type":"file","content":"v11.4.0       (previous stable image config)\nv12.0.0-test  (original test-tier build, still deployed)\nv12.1.0       a1b2c3d  Resize test-tier image config: cpu_limit 1->2, memory_limit_mb 512->2048\n# verification TAG-7742\n"}}}'::jsonb, '{"requiredFlag":"TAG-7742"}'::jsonb),
  ('mission-atlas-source-of-truth-12-o2-c1', 'mission-atlas-source-of-truth-12-o2', 1, 'terminal_simulation', 'Read the GitOps manifest and submit its verification code.', '{"instructions":"Read /repo/gitops/collector-image.yaml and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/gitops/collector-image.yaml":{"type":"file","content":"apiVersion: atlas.internal/v1\nkind: ImageBinding\nmetadata:\n  host: metrics-collector-01\nspec:\n  desiredImageTag: v12.1.0\nstatus:\n  actualImageTag: v12.0.0-test\n  synced: false\n# verification GITOPS-9981\n"}}}'::jsonb, '{"requiredFlag":"GITOPS-9981"}'::jsonb),
  ('mission-atlas-source-of-truth-12-o3-c1', 'mission-atlas-source-of-truth-12-o3', 1, 'investigation', 'Which evidence explains why a fully merged, tagged fix never reached production?', '{"evidence":[{"id":"e1","label":"Pull request and review record","detail":"PR #4471 was reviewed, approved by Rook, and merged to main on 2026-07-22"},{"id":"e2","label":"Release history","detail":"No build artifact was ever produced for tag v12.1.0 -- metrics-collector-01 is still running the artifact built for v12.0.0-test"},{"id":"e3","label":"GitOps manifest","detail":"desiredImageTag is v12.1.0, actualImageTag is v12.0.0-test, synced: false"},{"id":"e4","label":"Branch protection settings","detail":"Main requires one approval and passing status checks before merge, and PR #4471 satisfied both"}],"question":"Which evidence explains why a fully merged, tagged fix never reached production?"}'::jsonb, '{"requiredEvidenceIds":["e2"]}'::jsonb),
  ('mission-atlas-source-of-truth-12-o4-c1', 'mission-atlas-source-of-truth-12-o4', 1, 'boss_encounter', 'Having confirmed the tag, the GitOps gap and the root cause, explain how the fix stopped being real between git and production.', '{"stages":[{"objectiveRef":"mission-atlas-source-of-truth-12-o1","label":"Confirm the fix was tagged"},{"objectiveRef":"mission-atlas-source-of-truth-12-o2","label":"Confirm the desired-versus-actual gap"},{"objectiveRef":"mission-atlas-source-of-truth-12-o3","label":"Identify the root cause"}],"task":"State the diagnosis in one sentence: the fix for the undersized image was branched, reviewed, approved, merged and tagged v12.1.0 exactly as it should have been -- but no pipeline ever turned that tagged commit into a real release artifact, so production kept running the old one, and git recording a fix is not the same thing as production running it."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-source-of-truth-12-o1","mission-atlas-source-of-truth-12-o2","mission-atlas-source-of-truth-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-source-of-truth-01-o1-c1', 'orientation', 'Think about whether git stores changes or whole states.', 10, 1),
  ('mission-atlas-source-of-truth-01-o1-c1', 'solution', 'A commit is a full, content-addressed snapshot, stored efficiently against prior snapshots.', 20, 2),

  ('mission-atlas-source-of-truth-02-o1-c1', 'orientation', 'Try: cat /repo/branches.txt', 10, 1),
  ('mission-atlas-source-of-truth-02-o1-c1', 'solution', 'The file ends with verification BRANCH-3301. submit BRANCH-3301', 20, 2),

  ('mission-atlas-source-of-truth-03-o1-c1', 'orientation', 'Ask whether history is preserved as it happened, or rewritten onto a new base.', 10, 1),
  ('mission-atlas-source-of-truth-03-o1-c1', 'solution', 'Merge preserves both histories with a new merge commit; rebase replays commits onto a new base with new hashes.', 20, 2),

  ('mission-atlas-source-of-truth-04-o1-c1', 'orientation', 'Try: cat /repo/tags.txt', 10, 1),
  ('mission-atlas-source-of-truth-04-o1-c1', 'solution', 'v12.1.0 is the fix tag, verification TAG-7742. submit TAG-7742', 20, 2),

  ('mission-atlas-source-of-truth-05-o1-c1', 'orientation', 'Try: cat /repo/pr-4471.txt', 10, 1),
  ('mission-atlas-source-of-truth-05-o1-c1', 'solution', 'The record ends with verification PR-4471. submit PR-4471', 20, 2),

  ('mission-atlas-source-of-truth-06-o1-c1', 'orientation', 'Think about what protection actually blocks, not just what it labels.', 10, 1),
  ('mission-atlas-source-of-truth-06-o1-c1', 'solution', 'It enforces required checks and required approvals, blocking unreviewed merges and direct pushes.', 20, 2),

  ('mission-atlas-source-of-truth-07-o1-c1', 'orientation', 'Try: cat /repo/review-4471.txt', 10, 1),
  ('mission-atlas-source-of-truth-07-o1-c1', 'solution', 'The record ends with verification REVIEW-5561. submit REVIEW-5561', 20, 2),

  ('mission-atlas-source-of-truth-08-o1-c1', 'orientation', 'Try: cat /repo/CHANGELOG.md', 10, 1),
  ('mission-atlas-source-of-truth-08-o1-c1', 'solution', 'The entry ends with verification SEMVER-2201. submit SEMVER-2201', 20, 2),

  ('mission-atlas-source-of-truth-09-o1-c1', 'orientation', 'Try: cat /repo/releases.txt -- look for what is marked as currently deployed.', 10, 1),
  ('mission-atlas-source-of-truth-09-o1-c1', 'solution', 'v12.1.0 has no build at all. submit atlas-image-v12.0.0-test.tar.gz', 20, 2),

  ('mission-atlas-source-of-truth-10-o1-c1', 'orientation', 'Try: cat /repo/.git-hooks/pre-push', 10, 1),
  ('mission-atlas-source-of-truth-10-o1-c1', 'solution', 'The hook is a stub, never wired up, verification HOOK-4419. submit HOOK-4419', 20, 2),

  ('mission-atlas-source-of-truth-11-o1-c1', 'orientation', 'Try: cat /repo/gitops/collector-image.yaml', 10, 1),
  ('mission-atlas-source-of-truth-11-o1-c1', 'solution', 'desiredImageTag and actualImageTag do not match, synced is false, verification GITOPS-9981. submit GITOPS-9981', 20, 2),

  ('mission-atlas-source-of-truth-12-o1-c1', 'orientation', 'Try: cat /repo/tags.txt', 10, 1),
  ('mission-atlas-source-of-truth-12-o1-c1', 'solution', 'v12.1.0 is the fix tag, verification TAG-7742. submit TAG-7742', 20, 2),
  ('mission-atlas-source-of-truth-12-o2-c1', 'orientation', 'Try: cat /repo/gitops/collector-image.yaml', 10, 1),
  ('mission-atlas-source-of-truth-12-o2-c1', 'solution', 'synced is false, verification GITOPS-9981. submit GITOPS-9981', 20, 2),
  ('mission-atlas-source-of-truth-12-o3-c1', 'orientation', 'Every step of the process passed. Look for the one thing that never happened at all.', 10, 1),
  ('mission-atlas-source-of-truth-12-o3-c1', 'solution', 'e2: no build artifact was ever produced for v12.1.0 -- that is where the fix stopped being real.', 20, 2),
  ('mission-atlas-source-of-truth-12-o4-c1', 'orientation', 'Combine the tag, the GitOps gap and the missing build into one sentence.', 15, 1),
  ('mission-atlas-source-of-truth-12-o4-c1', 'solution', 'The fix was branched, reviewed, approved, merged and tagged v12.1.0 exactly as it should have been -- but no pipeline ever turned that tag into a real release artifact, so production kept running the old one.', 25, 2);
