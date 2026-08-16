-- Robotics/Embedded/IoT pathway ("The Machine Below"): World rows for
-- Acts 26-28 (closing Arc V, "Give Robots a Nervous System") and Acts
-- 29-30 (opening a new Arc VI, "Autonomy Leaves the Lab", bible spans
-- Acts 29-31 -- only 29-30 built this round, 31 follows later). Content
-- (missions) for each Act follows in its own migration.
--
-- Narrative thread: Act 25's transition_hook ("there is clearly more of
-- SUBSTRATE's structure still to map") continues in the background while
-- Vector Division's own ordinary engineering keeps surfacing: deeper ROS
-- 2 tooling exposes a TF2 extrapolation bug in their own robot, unrelated
-- to SUBSTRATE (Act 26), forcing them to build a real simulation
-- environment to test scenarios safely -- which itself reveals a sim-to
-- -real gap from unvalidated physics assumptions (Act 27), which in turn
-- builds enough trust to hand a robot its first fully autonomous mission
-- -- which it correctly refuses, closing Arc V on a design validation
-- rather than a failure (Act 28). Ground autonomy earns its first
-- aerial test with a small inspection drone that loses GPS mid-flight,
-- opening Arc VI (Act 29), and finally a remote robot has to make an
-- urgent, correct decision completely offline, merging AI and robotics
-- under real power/latency/connectivity/safety constraints -- the
-- bible's own stated story beat for this stretch (Act 30).

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-vec-6', 5, 'autonomy-leaves-the-lab', 'Arc VI -- Autonomy Leaves the Lab',
   'Every autonomy system Vector Division has built so far runs on the ground, tethered to reliable connectivity. Arc VI forces that autonomy into the air, where refusing to act is not always survivable, and onto constrained edge hardware that has to think correctly with no uplink at all.',
   'Ground autonomy engineer -> engineer who can trust autonomous decisions made in the air and completely offline',
   'pathway-robotics');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-vec-ros2-advanced', 'act-vec-5', 25, 'ros2-advanced', 'ROS 2 Advanced', 'ROS 2 Advanced',
   'DDS concepts; QoS; TF2 transforms; URDF; robot state publisher; rosbag; lifecycle nodes concepts; composition concepts; executors concepts; navigation stack overview; debugging ROS graphs.',
   'Vector Division builds deeper introspection tools -- TF2, rosbag, lifecycle nodes -- to keep mapping SUBSTRATE''s structure on the graph, and in the middle of that work, one of Vector Division''s own robots throws a violent position glitch mid-move, unrelated to anything SUBSTRATE is doing.',
   'Transform Extrapolation',
   'A static transform publisher on the robot itself has an irregular, delayed publish rate. When the navigation stack asks TF2 for a transform at the exact moment it needs one, the buffer has nothing recent enough and extrapolates beyond its trusted window -- producing a confident, physically impossible jump. SUBSTRATE''s own nodes were investigated and ruled out. This is an ordinary timing bug in Vector Division''s own code.',
   'The robot itself is not the problem tonight. The real problem is trusting a system that has only ever been tested against ideal conditions -- which means it is time to start breaking things safely, on purpose, before reality does it without warning.',
   'Transform Extrapolation', 'Bug', 'severe', 308, 12, 'pathway-robotics'),

  ('world-vec-simulation', 'act-vec-5', 26, 'simulation', 'Simulation', 'Simulation',
   'Why simulate; robot models; Gazebo concepts; worlds; sensors in simulation; physics parameters; noise models; simulation time; scenario testing; synthetic data; hardware-in-the-loop concepts.',
   'Vector Division builds a real simulation environment to test scenarios before ever running them on hardware -- and the very first scenario that passes cleanly in simulation fails immediately on the real robot.',
   'Simulation Lied',
   'The simulation was never malicious, and nothing in it was technically wrong. Its physics parameters were left at convenient defaults that nobody validated against the real floor surface and the real sensor noise the robot experiences constantly -- so it modeled a version of reality that was close enough to look trustworthy and different enough to be dangerous.',
   'Simulation is only useful once it can be trusted. The next step is trusting an autonomous decision-making stack enough to let it act without a human confirming every single move.',
   'Simulation Lied', 'GraduationCap', 'severe', 320, 12, 'pathway-robotics'),

  ('world-vec-autonomy', 'act-vec-5', 27, 'autonomy', 'Autonomy', 'Autonomy',
   'Autonomy stack; mission planning; behavior trees; state machines; recovery behaviors; goal selection; Navigation2 concepts; docking concepts; fleet coordination concepts; human override; autonomy boundaries.',
   'Given its first fully autonomous mission -- navigate a sector alone, with no operator confirming each step -- the robot immediately refuses to start, and at first nobody can tell whether that is a bug or exactly correct behavior.',
   'The Robot Refuses the Mission',
   'It is exactly correct behavior. The mission would require crossing into a zone without validated map or localization confidence, and the autonomy stack''s own boundaries correctly refuse to guess rather than act on uncertainty it cannot resolve. The safest autonomous system is not the one that always finishes the mission. It is the one that knows what it does not know.',
   'A ground robot refusing a mission safely is one kind of trust. The next real test is autonomy that has to work in the air, where refusing to act is not always survivable.',
   'The Robot Refuses the Mission', 'Workflow', 'severe', 332, 12, 'pathway-robotics'),

  ('world-vec-drones', 'act-vec-6', 28, 'drones', 'Drones', 'Drones',
   'Flight fundamentals; frames and axes; IMU in flight; ESC and motor concepts; flight controller; attitude control; altitude control; position control; PX4/ArduPilot concepts; telemetry; failsafes.',
   'Vector Division brings its first aerial platform online, a small inspection drone, and during an early test flight it loses GPS lock in mid-air.',
   'Loss of GPS',
   'A ground robot that loses its position estimate can simply stop and wait. A drone cannot -- stopping is not a safe state in the air. The drone''s failsafe stack correctly took over: holding attitude, using its IMU and barometer instead of GPS, and executing a controlled descent instead of free-falling or guessing its way home.',
   'Flying is one new axis of constraint. Making a small edge device actually think for itself, under real power, latency and connectivity limits, is the next.',
   'Loss of GPS', 'Radio', 'severe', 344, 12, 'pathway-robotics'),

  ('world-vec-edge-ai-tinyml', 'act-vec-6', 29, 'edge-ai-tinyml', 'Edge AI & TinyML', 'Edge AI & TinyML',
   'Why edge AI; inference on devices; model size constraints; quantization; pruning concepts; TinyML pipeline; audio classification; vision at the edge; accelerators concepts; latency and power trade-offs; cloud versus edge inference.',
   'A remote facility robot loses its uplink at the exact moment it needs to classify something in its path -- obstacle or debris, urgent or ignorable -- with no time to wait for connectivity to return.',
   'Intelligence Without Internet',
   'Because Vector Division had already built a properly quantized, pruned model that runs entirely on the device itself, the robot makes the correct call in milliseconds, completely offline. Intelligence has to run wherever the decision actually needs to happen, not wherever it was most convenient to develop.',
   'One trustworthy edge device is solved. The next question is how to give an entire fleet that same intelligence, at once, without losing track of any single one of them.',
   'Intelligence Without Internet', 'Terminal', 'severe', 356, 12, 'pathway-robotics');
