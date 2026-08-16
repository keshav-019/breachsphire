-- Atlas Division pathway ("The Silence"): World row for Act 3, "Servers",
-- closing act-atlas-1 ("World I -- The Basement", Acts 1-3: Linux,
-- Networking, Servers). Content (missions) follows in its own migration.
--
-- Narrative thread: Act 2's transition_hook ("what happens when the
-- servers on either end of connections like this one are themselves the
-- problem") is realized directly -- the moment the firewall fix lets
-- real traffic reach the metrics collector for the first time, the
-- collector itself starts dying under load it was never sized for.
-- Imani Cross, SRE, makes her speaking debut here -- her doc-stated
-- specialty is observability, incidents, capacity and chaos, an exact
-- match for this Act's CPU/memory/disk pressure content.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-servers', 'act-atlas-1', 2, 'servers', 'Servers', 'Servers',
   'Bare metal versus VMs; virtualization; cloud VMs; machine images; bootstrapping; packages; service accounts; disks and volumes; CPU saturation; memory pressure; disk pressure.',
   'With the firewall rule finally corrected, traffic reaches the metrics collector for the first time -- and immediately, the collector itself starts dying. CPU pinned, memory climbing, a log filling disk it does not have to spare. The connection was never the whole problem.',
   'The Dying Host',
   'The collector was never attacked and never broke on its own. It was built from a test-tier machine image -- one CPU, 512 megabytes of memory -- and nobody resized it before real production traffic finally reached it. Every resource pressure happening at once is the same undersized host meeting real load for the first time.',
   'The host itself is now understood, end to end -- but an undersized image should never have reached production in the first place. That question starts further upstream, with how Atlas Division actually builds and ships anything at all.',
   'The Dying Host', 'Server', 'elevated', 32, 12, 'pathway-atlas');
