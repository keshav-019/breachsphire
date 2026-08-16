-- Fourth pathway: Robotics, Embedded Systems & IoT ("The Machine Below"),
-- Vector Division. Arc I ("Electricity Becomes Computation") and its first
-- Act, "The Machine Below" -- same acts/worlds table-reuse pattern as every
-- other pathway (doc's Arc = DB `acts` row, doc's Act = DB `worlds` row,
-- doc's mission = DB `missions` row). Slug-based ids from the very first
-- Act, per the lesson learned from Backend Engineering's numeric-id drift
-- bug (see AI/ML pathway's own migrations for the same convention).

insert into public.pathways (id, slug, title, tagline, description, icon, sort_order) values
  ('pathway-robotics', 'robotics-iot', 'Vector Division', 'Software can crash. Machines can crash into people.',
   'A 0-to-1 robotics, embedded systems and IoT campaign: 33 Acts from a single circuit to autonomous robot fleets -- electronics, firmware, RTOS, sensors, actuators, control theory, embedded security, ROS 2, SLAM, planning and safety-critical design -- racing to understand a buried automation layer before its obsolete objectives turn a city into a hazard.',
   'Zap', 4);

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-vec-1', 0, 'electricity-becomes-computation', 'Arc I -- Electricity Becomes Computation',
   'A door in Nexus seals itself with people inside while every software log insists nothing happened. The player joins Vector Division to learn the fundamental vocabulary of physical computing -- robotics vs automation vs embedded systems, sensors, actuators, controllers, the sense-think-act loop, real-time constraints and safety -- well enough to prove the anomaly is physical, not digital.',
   'Absolute beginner -> a Vector Initiate who can read a physical control system well enough to know why it is not a hack',
   'pathway-robotics');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-vec-the-machine-below', 'act-vec-1', 0, 'the-machine-below', 'The Machine Below', 'The Machine Below',
   'The fundamental vocabulary of physical computing -- robotics vs automation vs embedded systems, sensors, actuators, controllers, the sense-think-act loop, real-time constraints, fail-safe design, block diagrams, signals, telemetry and hardware/software boundaries -- learned by diagnosing one door that moved with no digital trace.',
   'A maintenance corridor door in the Meridian Transit hub seals itself with two technicians inside. Every network log, API call and software dashboard insists the door never moved. Commander Imani Rao pulls the player into Vector Division to find out what actually controls a door like that.',
   'The Door That Moved Alone',
   'The door was never reachable from the modern software stack at all. It answers to a separate, decades-old physical control layer wired directly into its motor over a maintenance bus nobody has monitored in years -- a layer Vector Division starts calling SUBSTRATE, as a working name for whatever is still running down there.',
   'One door proves the anomaly is physical, not digital. To find every other machine SUBSTRATE can still reach, Vector Division needs to understand electricity itself -- starting with a single circuit.',
   'The Door That Moved Alone', 'Gauge', 'guarded', 8, 12, 'pathway-robotics');

-- Existing players never ran handle_new_user() against a world that didn't
-- exist yet -- unlock Act 1 of the new pathway for everyone already signed
-- up (new signups get this for free via the existing `where index = 0`
-- trigger, unfiltered by pathway, so it naturally seeds every pathway's
-- first World).
insert into public.player_world_progress (player_id, world_id, state, completion)
select id, 'world-vec-the-machine-below', 'unlocked', 0 from public.profiles
on conflict (player_id, world_id) do nothing;
