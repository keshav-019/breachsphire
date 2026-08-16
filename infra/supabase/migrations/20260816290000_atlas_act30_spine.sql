-- Atlas Division pathway ("The Silence"): Act row for World IX --
-- "Platform City" -- plus the World row for its first Act, "Platform"
-- (platform engineering). Content (missions) follows in its own
-- migration, same two-step pattern as every prior World.
--
-- Narrative thread: Act 29 closed by naming the exact next problem --
-- every hard-won pattern this fleet built (resilience, chaos testing,
-- disaster recovery) only exists for the collector team, learned the
-- hard way, one incident at a time. Every other team building on this
-- infrastructure still has to file a manual ticket and wait. Rook builds
-- a real internal developer platform to give that same discipline away,
-- by default, to everyone.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-atlas-9', 8, 'platform-city', 'World IX -- Platform City',
   'Twenty-nine Acts of hard-won infrastructure discipline -- CI/CD, containers, cloud, Terraform, Kubernetes, GitOps, observability, SRE, resilience, chaos engineering, disaster recovery -- has only ever lived with the collector team, learned the hard way. This World is about turning that discipline into a real internal platform: self-service, golden-path infrastructure that gives every other team the same guardrails by default, without making them live through the same story first.',
   'Can build and operate one fleet''s infrastructure expertly -> can turn that expertise into a real, self-service platform other teams actually use',
   'pathway-atlas');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-platform', 'act-atlas-9', 29, 'platform', 'Platform', 'Platform',
   'Why platforms; developer experience; golden paths; internal platforms; service templates; self-service infra; platform APIs; Backstage concepts; provisioning; policy as code; platform metrics.',
   'Every other team still files a manual ticket and waits for the ops team to hand-provision anything -- a new service, a database, a secret. Rook proposes building a real internal developer platform instead: self-service infrastructure with this fleet''s own hard-won guardrails baked in by default.',
   'Ticket Mountain',
   'The platform launch is a genuine, measurable success -- ticket volume for infrastructure requests drops by roughly four-fifths within a month, and provisioning time for a new service drops from a multi-day wait to minutes. But the platform''s own metrics show one team still filing nearly all of what tickets remain, over and over, for the exact same kind of request: a stateful, long-running workload that does not fit any golden path the platform actually offers yet. Building a platform was never a one-time launch. It only stays a platform for as long as its coverage keeps up with what teams are actually trying to build.',
   'A platform now exists to give every team this fleet''s own guardrails by default. What it has not yet done is give any of them a safe, uniform way to actually talk to each other -- every service still handles its own retries, its own TLS, its own traffic policy, by hand, exactly the way the collector always has.',
   'Ticket Mountain', 'LayoutGrid', 'guarded', 134, 14, 'pathway-atlas');
