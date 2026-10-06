-- Robotics/Embedded/IoT pathway ("The Machine Below"): Arc II ("Firmware
-- Controls Reality", bible spans Acts 6-13) plus World rows for Acts
-- 6-10 (this round covers 5 of Arc II's 8 Acts; 11-13 follow later).
-- Content (missions) for each Act follows in its own migration.
--
-- Narrative thread across these five Acts: Vector Division's first real
-- firmware fix for Act 4's frozen door misses its deadline (Act 6),
-- forcing them to properly characterize the maintenance bus itself to
-- deploy anything at all (Act 7), which finally gives them trustworthy
-- two-way sensor data off the live door (Act 8), which they use to test
-- its actuators directly and find a genuine emergency-stop design flaw
-- (Act 9) -- and then a SECOND, live, ongoing incident breaks: a robotic
-- arm at a Nexus reactor facility begins oscillating, the bible's own
-- Arc story beat ("SUBSTRATE begins manipulating closed-loop systems,
-- turning small sensor errors into dangerous physical motion") realized
-- not as sabotage but as decades-old control tuning nobody revisited as
-- the physical hardware aged (Act 10).

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-vec-2', 1, 'firmware-controls-reality', 'Arc II -- Firmware Controls Reality',
   'Vector Division can now read a controller''s circuits, registers and firmware. Arc II forces them to make that controller behave correctly in real time, talk over the physical buses it actually uses, trust its sensors, drive its actuators safely, and control a closed loop without turning a small error into dangerous motion -- as a second, live incident proves those are no longer academic concerns.',
   'Firmware reader -> engineer who can deploy a real-time fix to a live physical system without causing a worse failure',
   'pathway-robotics');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-vec-time-is-a-requirement', 'act-vec-2', 5, 'time-is-a-requirement', 'Time Is a Requirement', 'Time Is a Requirement',
   'Polling vs interrupts; interrupt service routines; latency and jitter; timer scheduling; finite state machines; cooperative scheduling; preemption concepts; critical sections; atomic operations; priority inversion; real-time thinking.',
   'Vector Division writes its first real firmware fix for Act 4''s frozen door -- and discovers correct code is not enough if it does not finish in time to matter.',
   'Missed Deadline',
   'The fix itself was logically correct. It ran inside an interrupt handler that occasionally blocked waiting on a slow sensor read, and once, at exactly the wrong moment, that block lasted long enough for the door''s own safety timeout to fire first. The bug was never in what the code computed. It was in when.',
   'A fix that works on the bench is not a fix that can be trusted on a live system. Deploying it means finally learning to speak the maintenance bus''s own language, not just read it.',
   'Missed Deadline', 'Workflow', 'elevated', 68, 12, 'pathway-robotics'),

  ('world-vec-serial-roads', 'act-vec-2', 6, 'serial-roads', 'Serial Roads', 'Serial Roads',
   'Why devices communicate; UART; baud rate and framing; I2C; addresses and pull-ups; SPI; chip select; CAN bus concepts; RS-485 concepts; protocol selection; logic-analyzer thinking.',
   'Before Vector Division can push the fix to the live door, they have to identify exactly which bus protocol the maintenance line runs on -- the same line Act 1 could only read, never speak on.',
   'The Bus Is Silent',
   'The maintenance bus is RS-485: a simple, decades-old differential serial standard, chosen because it survives long cable runs and electrical noise inside a building far better than anything more modern. Vector Division''s first attempt to write to it gets no response at all -- not because the bus is broken, but because RS-485 is half-duplex, and their first write collided with the board''s own scheduled status report.',
   'Two-way communication finally works. Which means, for the first time, Vector Division can ask the live door''s sensors what they actually see, instead of only what the firmware claims.',
   'The Bus Is Silent', 'Network', 'elevated', 80, 12, 'pathway-robotics'),

  ('world-vec-sensors', 'act-vec-2', 7, 'sensors', 'Sensors', 'Sensors',
   'Sensor fundamentals; temperature, light and distance sensors; IMU concepts; accelerometer; gyroscope; magnetometer; calibration; noise and filtering; sensor fusion intuition.',
   'With two-way communication finally working, Vector Division pulls a full sensor sweep off the live door -- and one reading does not match physical reality at all.',
   'The Lying Sensor',
   'The sensor was never malicious and never broken. It is a real proximity sensor that was never recalibrated after decades of thermal drift, reporting a plausible-looking but wrong distance with total, unearned confidence -- the same danger as a confidently wrong answer from any other kind of system.',
   'A sensor that can be trusted, once calibrated and filtered, is only half the loop. The other half is whatever the door does in response -- its actuators.',
   'The Lying Sensor', 'Radar', 'elevated', 92, 12, 'pathway-robotics'),

  ('world-vec-actuators', 'act-vec-2', 8, 'actuators', 'Actuators', 'Actuators',
   'Actuator fundamentals; DC motors; motor drivers; PWM speed control; servo motors; stepper motors; relays; solenoids; encoders; closed-loop motion; emergency stops.',
   'With trustworthy sensor data in hand, Vector Division tests the live door''s motor directly on the bench -- and it does not stop when the emergency stop is triggered.',
   'Runaway Motor',
   'The emergency-stop line was wired to cut the motor driver''s logic-level enable signal, not the motor''s actual power rail -- a design that worked perfectly for thirty years because the enable signal never once failed on its own, until a single stuck bit made it fail exactly the way nobody had planned for.',
   'Reacting to a runaway motor is not the same as controlling one precisely. That question becomes urgent the moment a second, live incident breaks: a robotic arm at a Nexus reactor facility has started oscillating instead of holding still.',
   'Runaway Motor', 'Crosshair', 'elevated', 104, 12, 'pathway-robotics'),

  ('world-vec-control', 'act-vec-2', 9, 'control', 'Control', 'Control',
   'Open vs closed loop; feedback; setpoints; error signals; proportional, integral and derivative control; PID intuition; tuning; overshoot and oscillation; control-loop sampling.',
   'A robotic arm at a Nexus reactor cooling facility begins oscillating instead of holding its commanded position -- a live incident, not a recovered artifact, and every second it continues is a second closer to real damage.',
   'The Oscillating Reactor Arm',
   'Nothing reprogrammed the arm''s control loop. Its proportional gain was tuned correctly three decades ago, for bearings that were new. Those bearings have worn down every year since, changing how the arm actually responds to a correction -- until a sensor error small enough to have always been harmless started producing motion large enough to be dangerous. SUBSTRATE did not attack the loop. It simply never stopped trusting a tuning that the physical machine had quietly outgrown.',
   'Vector Division can now stabilize one control loop by hand. The next question is how to keep dozens of them stable, correctly, all at once, without a human retuning each one forever -- which means it is finally time for a real RTOS.',
   'The Oscillating Reactor Arm', 'TrendingUp', 'severe', 116, 12, 'pathway-robotics');
