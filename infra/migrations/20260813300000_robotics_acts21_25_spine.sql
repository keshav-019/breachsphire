-- Robotics/Embedded/IoT pathway ("The Machine Below"): World rows for
-- Acts 21-24 (closing Arc IV, "Teach Machines Where They Are") and Act 25
-- (opening a new Arc V, "Give Robots a Nervous System", bible spans Acts
-- 25-28 -- only 25 built this round, 26-28 follow later). Content
-- (missions) for each Act follows in its own migration.
--
-- Narrative thread: Act 20's transition_hook ("the real fix is letting a
-- robot sense the world directly instead of trusting an old map blindly")
-- is realized directly -- a real perception pipeline still misses an
-- obstacle sitting in its own filtered-out dead zone (Act 21), forcing
-- real probabilistic localization after a robot's filter confidently
-- locks onto the wrong landmark (Act 22), which in turn requires letting
-- robots map their own environment rather than trust an old blueprint --
-- and SLAM finds a corridor that was physically altered by an
-- unrecorded renovation, not sabotage, closing the "old maps lie" thread
-- for good (Act 23), then a full evacuation drill proves the complete
-- perceive-localize-map-plan stack works together under real pressure,
-- closing Arc IV (Act 24). Porting that whole stack onto a real
-- multi-robot framework surfaces a genuinely new discovery: SUBSTRATE has
-- its own publishers and subscribers already sitting on forgotten ROS 2
-- interfaces, landing the bible's own stated story beat for this Arc
-- (Act 25) -- the pathway's first SUBSTRATE line since Act 10.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-vec-5', 4, 'give-robots-a-nervous-system', 'Arc V -- Give Robots a Nervous System',
   'Every perception, localization, mapping and planning system Vector Division has built so far exists as one-off code, per robot. Arc V forces them onto a real shared framework connecting perception, control and planning across the whole fleet at once -- and that framework immediately exposes a hidden graph SUBSTRATE has been quietly using the entire time.',
   'Single-robot autonomy engineer -> engineer who can reason about a distributed robotic nervous system spanning an entire fleet',
   'pathway-robotics');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-vec-perception', 'act-vec-4', 20, 'perception', 'Perception', 'Perception',
   'Robot perception; camera models intuition; depth sensing; LiDAR concepts; point clouds; feature detection concepts; object detection integration; segmentation integration; range filtering; sensor timestamps; perception pipelines.',
   'Vector Division fits one of the drifting mobile robots with a real camera and depth sensor for a supervised test run -- and it drives straight through the space where a stack of crates sits, without ever slowing down.',
   'The Invisible Obstacle',
   'Nothing was broken. The perception pipeline''s range filter was correctly tuned to reject noisy readings past a certain distance -- and the crates happened to sit exactly inside that rejected zone, so real data was discarded right alongside the noise it was built to remove.',
   'Trusting what a robot sees is only half the problem. It still needs to know exactly where it is, and where everything it sees actually sits, over time.',
   'The Invisible Obstacle', 'Image', 'severe', 248, 12, 'pathway-robotics'),

  ('world-vec-localization', 'act-vec-4', 21, 'localization', 'Localization', 'Localization',
   'What is localization; odometry uncertainty; landmarks; probability in robotics; Bayes filters intuition; Kalman filter intuition; extended Kalman concepts; particle filters intuition; sensor fusion; GPS/GNSS concepts; localization failure modes.',
   'A mobile robot''s new localization filter tracks its position confidently for most of a long facility run -- then locks onto a completely wrong estimate and stays there, certain of the wrong answer.',
   'Lost in Nexus',
   'The filter did exactly what it was designed to do: trust a strong sensor match. The problem was the match itself -- two structurally identical corridor junctions on opposite sides of the facility, and the filter had no way to tell them apart. It was not lost by accident. It was lost with total confidence.',
   'Localization assumed a correct map already existed. Vector Division just spent an Act proving old maps cannot be trusted blindly. It is time for robots to build their own.',
   'Lost in Nexus', 'Building2', 'severe', 260, 12, 'pathway-robotics'),

  ('world-vec-mapping-and-slam', 'act-vec-4', 22, 'mapping-and-slam', 'Mapping & SLAM', 'Mapping & SLAM',
   'Maps; occupancy grids; mapping from range sensors; localization plus mapping; SLAM intuition; loop closure; pose graphs concepts; map drift; 2D SLAM concepts; visual SLAM concepts; map quality.',
   'Running a full SLAM pass across a facility for the first time, a robot maps a corridor whose real geometry does not match the decades-old blueprint at all.',
   'The Corridor That Moved',
   'The corridor was genuinely altered during a past renovation, and the change was never resurveyed into any facility record -- the exact same undocumented-frame failure that misplaced the arm and drifted the mobile robots, now finally corrected at the source instead of worked around. Loop closure reconciles the new sensor data into one map Vector Division can actually trust.',
   'A correct, current map means a robot can finally plan a path through it with confidence.',
   'The Corridor That Moved', 'Shield', 'severe', 272, 12, 'pathway-robotics'),

  ('world-vec-path-planning', 'act-vec-4', 23, 'path-planning', 'Path Planning', 'Path Planning',
   'Graphs in robotics; grid search; BFS/DFS recap; Dijkstra; A*; heuristics; cost maps; global planning; local planning; obstacle avoidance; dynamic obstacles.',
   'A full evacuation drill puts the complete stack to its first real test: perceive, localize, map and now plan a safe path through a sector, live, with moving obstacles in the way.',
   'Evacuate the Sector',
   'The stack holds. A robot with trustworthy perception, honest localization and an accurate, current map can plan and replan a safe path through real, moving obstacles fast enough to matter -- closing the gap between "the robot knows where it is" and "the robot can actually get somewhere safely."',
   'Every piece Vector Division has built exists as one-off code, bolted onto one robot at a time. Scaling this to the whole fleet needs a real shared framework, not another custom build per machine.',
   'Evacuate the Sector', 'ShieldAlert', 'severe', 284, 12, 'pathway-robotics'),

  ('world-vec-ros2', 'act-vec-5', 24, 'ros2', 'ROS 2', 'ROS 2',
   'Why ROS; the ROS 2 graph; nodes; topics; publishers and subscribers; messages; services; actions; parameters; launch files; packages and workspaces.',
   'Vector Division ports its perception, localization, mapping and planning stack onto ROS 2 as a shared framework across several robots at once -- and one critical safety topic silently stops delivering messages between two nodes that should be connected.',
   'The Silent Topic',
   'The immediate bug is small and mundane: a quality-of-service mismatch quietly prevented the subscriber from ever connecting. But the graph introspection tooling built to find it reveals something else entirely -- SUBSTRATE already has its own publishers and subscribers sitting on forgotten, undocumented interfaces across the fleet, and has for longer than anyone can date.',
   'The graph is exposed for the first time. There is clearly more of SUBSTRATE''s structure still to map.',
   'The Silent Topic', 'Network', 'severe', 296, 12, 'pathway-robotics');
