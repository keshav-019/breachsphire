-- Fifth pathway: Cloud, DevOps, SRE & Platform Engineering ("The
-- Silence"), Atlas Division. This migration only prepares the pathway's
-- spine -- the pathway row and its first World/Act -- so the pathway is
-- selectable and structurally ready. Act 1 content (missions) is not yet
-- authored; that follows in a later migration, same two-step pattern as
-- every prior pathway (spine first, content after).
--
-- Source bible's own top-level grouping is called "WORLD" (e.g. "WORLD I
-- -- THE BASEMENT" contains Acts 1-3), one level above its "ACT"s -- the
-- same role prior bibles called "Arc". Mapped identically to
-- [[breachsphire-pathway-architecture]]'s established convention: doc's
-- World/Arc = DB `acts` row, doc's Act = DB `worlds` row, doc's numbered
-- mission = DB `missions` row.

insert into public.pathways (id, slug, title, tagline, description, icon, sort_order) values
  ('pathway-atlas', 'cloud-devops-sre', 'Atlas Division', 'Availability is not a feature. It is a promise.',
   'A 0-to-1 cloud, DevOps, SRE and platform engineering campaign: 36 Acts from a single Linux host to global multi-region infrastructure -- networking, Docker, cloud, Terraform, Kubernetes, GitOps, observability, incident response, chaos engineering, disaster recovery, platform engineering and FinOps -- racing to keep Nexus''s invisible infrastructure alive after every telemetry signal goes dark at once.',
   'Cloud', 5);

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-atlas-1', 0, 'the-basement', 'World I -- The Basement',
   'At 03:17 Nexus Standard Time, telemetry dies, CI runners disconnect, registries vanish and DNS records expire -- Byte stays conscious but loses visibility entirely. The player joins Atlas Division to learn the Linux, networking and production-host fundamentals underneath every other Nexus system, well enough to start restoring sight to a division that can currently only think, not see.',
   'Absolute beginner -> an Atlas Initiate who can operate a production Linux host with real confidence',
   'pathway-atlas');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-the-last-green-light', 'act-atlas-1', 0, 'the-last-green-light', 'The Last Green Light', 'The Last Green Light',
   'Linux foundations for production infrastructure: the mental model of a running system, processes and services, users/groups/permissions, the filesystem hierarchy, signals, systemd, journald, SSH, shell automation and resource inspection.',
   'At 03:17 Nexus Standard Time, every dashboard Byte relies on goes dark within the same minute -- telemetry, CI runners, registries, DNS. Commander Leena Rao pulls the player into Atlas Division, the group responsible for the infrastructure underneath every other Nexus division, to find the last host still reporting green before it goes dark too.',
   'The Last Green Light',
   'Nothing was attacked. Every system that vanished did so through its own normal, correctly-configured failure path -- a certificate that was always going to expire, a disk that was always going to fill, a process that was always going to be killed. The silence is not an intrusion. It is what production looks like when nobody is watching every layer at once.',
   'One host, understood completely, is the only foundation solid enough to start restoring Atlas Division''s sight. Everything after this begins with the machine underneath the machine.',
   'The Last Green Light', 'Terminal', 'guarded', 8, 12, 'pathway-atlas');

-- Same signup-trigger trick as every prior pathway addition: back-fill the
-- new pathway's first World as unlocked for everyone already signed up
-- (new signups already get this for free via the existing unfiltered
-- `where index = 0` trigger).
insert into public.player_world_progress (player_id, world_id, state, completion)
select id, 'world-atlas-the-last-green-light', 'unlocked', 0 from public.profiles
on conflict (player_id, world_id) do nothing;
