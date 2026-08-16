-- Robotics/Embedded/IoT pathway ("The Machine Below"): World rows for
-- Acts 16-17 (closing Arc III, "Connect the Physical World") and Acts
-- 18-20 (opening a new Arc IV, "Teach Machines Where They Are", bible
-- spans Acts 18-24 -- only 18-20 built this round, 21-24 follow later).
-- Content (missions) for each Act follows in its own migration.
--
-- Narrative thread: Act 15's transition_hook ("a fleet this size, all
-- reachable at once, is also a fleet this size all attackable at once")
-- is realized directly -- the security audit Sera has pushed for since
-- Act 9 finds one device is an unauthorized, unsigned replacement board,
-- installed in good faith by a maintenance technician decades ago with no
-- process to catch it (Act 16), then a Linux-based aggregation gateway
-- fails to reboot after a routine update, closing Arc III (Act 17). The
-- fleet audit then turns up something genuinely new: mobile and
-- articulated robots, not just fixed controllers -- introducing Dr. Lin
-- Ortega and robot geometry (Act 18), kinematics and reachable workspace
-- (Act 19), and finally the bible's own stated story beat for this
-- stretch: several fleet "malfunctions" are actually coordinate-frame
-- errors against ancient, never-updated facility maps (Act 20).

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-vec-4', 3, 'teach-machines-where-they-are', 'Arc IV -- Teach Machines Where They Are',
   'The fleet audit turns up something the pathway has not needed yet: robots with actual joints and mobile bases, not just fixed controllers. Arc IV brings in Dr. Lin Ortega to teach Vector Division the math of where a robot actually is and how it actually moves -- coordinate frames, kinematics, and the realization that several fleet-wide "malfunctions" were never malfunctions at all.',
   'Firmware and fleet engineer -> engineer who can reason precisely about where a physical robot is and how it moves through space',
   'pathway-robotics');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-vec-embedded-security', 'act-vec-3', 15, 'embedded-security', 'Embedded Security', 'Embedded Security',
   'Threat model for devices; secure boot; firmware signing; device secrets; hardware root-of-trust concepts; TLS on constrained devices; certificate provisioning; key rotation; debug-port risks; physical attacks awareness; secure update pipeline.',
   'With the fleet finally visible, Vector Division starts the security audit Sera has been asking for since Act 9 -- and one device fails its very first check: its firmware does not match any signature Vector Division has ever issued.',
   'The Counterfeit Controller',
   'The board itself is a generic, off-the-shelf replacement part, installed by a maintenance technician decades ago after the original failed, running unofficial firmware close enough to normal behavior that nothing ever flagged it. Nobody attacked this device. Nobody enforced a process that could have caught an unsigned, unauthorized replacement in the first place.',
   'Most of the fleet is bare-metal firmware Vector Division can now secure end to end. A handful of facility gateways run something different -- embedded Linux -- and that needs its own review.',
   'The Counterfeit Controller', 'KeyRound', 'severe', 188, 12, 'pathway-robotics'),

  ('world-vec-linux-at-the-edge', 'act-vec-3', 16, 'linux-at-the-edge', 'Linux at the Edge', 'Linux at the Edge',
   'Embedded Linux vs MCU; boot process overview; kernel/user space; processes and threads; device files; GPIO interfaces concepts; serial interfaces; systemd concepts; cross compilation; root filesystems; logging and services.',
   'One of the fleet''s aggregation gateways -- running embedded Linux, not bare-metal firmware -- fails to come back up after what should have been a routine kernel update.',
   'The Gateway That Would Not Boot',
   'The update was cross-compiled against the wrong target architecture and paired with a root filesystem that never matched it -- the kernel could start, but userspace had nothing valid to hand control to. A boot process that looks identical to a microcontroller''s from the outside hides an entirely different set of places it can fail.',
   'The fleet is connected and secured end to end now, from bare-metal controllers to Linux gateways. The audit that got Vector Division here also turned up something new: some of these are not fixed controllers at all. Some of them move.',
   'The Gateway That Would Not Boot', 'Server', 'severe', 200, 12, 'pathway-robotics'),

  ('world-vec-robot-geometry', 'act-vec-4', 17, 'robot-geometry', 'Robot Geometry', 'Robot Geometry',
   'Coordinate frames; 2D and 3D vectors; rotation intuition; translation; transformation matrices; homogeneous coordinates; robot frames; forward kinematics; degrees of freedom; workspace.',
   'The fleet audit turns up a warehouse handling arm whose logged "position" has never once matched where anyone can actually find it standing. Commander Rao brings in someone who can answer "where is a robot," precisely: Dr. Lin Ortega.',
   'Where Is the Arm?',
   'The arm''s logged coordinates were always correct -- for its own base''s coordinate frame. The facility''s floor-plan documentation used a different, undocumented reference frame from decades ago, so every position report was internally consistent and externally meaningless, with no transform ever recorded between the two.',
   'Knowing where a joint is right now is not the same as knowing how to command it to a new position. That takes kinematics.',
   'Where Is the Arm?', 'Globe', 'elevated', 212, 12, 'pathway-robotics'),

  ('world-vec-kinematics', 'act-vec-4', 18, 'kinematics', 'Kinematics', 'Kinematics',
   'Links and joints; revolute and prismatic joints; forward kinematics practice; inverse kinematics intuition; Jacobian intuition; singularities; joint limits; trajectory points; interpolation; velocity constraints; motion profiles.',
   'With the arm''s true position finally known, Vector Division tries to command it to a specific maintenance position -- and the arm correctly refuses, though at first nobody can explain why.',
   'The Unreachable Target',
   'The requested position lies outside the arm''s actual reachable workspace once its real joint limits are accounted for. The original planning software assumed idealized, unlimited joints that were never physically true of the hardware bolted to the floor.',
   'A single arm''s geometry is complicated enough sitting still. A robot that also has to navigate an entire floor while it moves is the next real problem.',
   'The Unreachable Target', 'Fingerprint', 'elevated', 224, 12, 'pathway-robotics'),

  ('world-vec-mobile-robots', 'act-vec-4', 19, 'mobile-robots', 'Mobile Robots', 'Mobile Robots',
   'Differential drive; wheel encoders; odometry; kinematic model; velocity commands; skid and slip; Ackermann steering concepts; holonomic drive concepts; coordinate transforms; dead reckoning; motion calibration.',
   'A warehouse mobile robot has been reported "malfunctioning" for months, drifting off its assigned path a little more every week -- and it is not the only one on the list.',
   'The Robot That Drifts',
   'Several of the fleet''s reported malfunctions are not malfunctions at all. They are ordinary dead-reckoning drift accumulating against maps and coordinate frames that were never updated as facilities were renovated over the decades -- the same undocumented-frame problem from the arm, now recognized as a pattern across the entire fleet.',
   'Better odometry math only goes so far toward fixing drift. The real fix is letting a robot sense the world directly instead of trusting an old map blindly.',
   'The Robot That Drifts', 'Search', 'severe', 236, 12, 'pathway-robotics');
