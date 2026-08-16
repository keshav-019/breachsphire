-- Robotics/Embedded/IoT pathway ("The Machine Below"): World rows for
-- Acts 11-13 (closing Arc II, "Firmware Controls Reality") and Acts 14-15
-- (opening a new Arc III, "Connect the Physical World", bible spans Acts
-- 14-17 -- only 14-15 built this round, 16-17 follow later). Content
-- (missions) for each Act follows in its own migration.
--
-- Narrative thread: Act 10's transition_hook ("it is finally time for a
-- real RTOS") is realized directly -- Vector Division ports the door fix
-- and the reactor arm's retuned loop onto shared RTOS firmware and hits a
-- textbook priority inversion (Act 11), then discovers their flash
-- storage has been silently wearing out for years (Act 12), forcing a
-- real safe-update pipeline before Byte's facility-wide sweep finds far
-- more matching controllers than anyone expected (Act 13, closes Arc II).
-- That count -- "far higher than anyone expected, almost all... with no
-- way to reach or be reached" -- opens Arc III: give those devices real
-- identity and connectivity (Act 14), then build the actual telemetry
-- pipeline to see them all at once, landing the bible's own stated story
-- beat for this stretch: "Thousands of disconnected devices reveal that
-- the crisis is a fleet problem, not a single-machine problem" (Act 15).

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-vec-3', 2, 'connect-the-physical-world', 'Arc III -- Connect the Physical World',
   'Byte''s facility-wide sweep, promised at the end of Arc II, finds far more embedded controllers matching the door''s signature than anyone expected -- almost all of them unreachable by design. Arc III forces Vector Division to give these devices real identity and connectivity, then build the actual telemetry pipeline to see the whole fleet at once, revealing that Nexus''s crisis was never about one door.',
   'Single-device firmware engineer -> fleet-aware infrastructure engineer who can provision, connect and monitor thousands of devices at once',
   'pathway-robotics');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-vec-the-rtos', 'act-vec-2', 10, 'the-rtos', 'The RTOS', 'The RTOS',
   'Why an RTOS; tasks; scheduler; priorities; queues; semaphores; mutexes; event groups; timers; task notifications; deadlocks.',
   'Vector Division starts porting the reactor arm''s stabilized control loop, the door''s fix, and their own telemetry logging onto one shared RTOS-based firmware -- and the very first multi-task build occasionally stalls the control loop exactly when a low-priority logging task refuses to let go of a shared resource.',
   'Priority Inversion',
   'A low-priority logging task holds a mutex the high-priority control task needs. A separate, unrelated medium-priority task keeps preempting the low-priority holder before it can finish and release the lock -- so the high-priority task waits far longer than its own priority should ever allow, not because of anything it did wrong itself.',
   'Multiple tasks now run reliably, in the right order, under real scheduling guarantees. The next question is what any of them can actually remember after the power cuts out.',
   'Priority Inversion', 'Boxes', 'elevated', 128, 12, 'pathway-robotics'),

  ('world-vec-memory-and-storage', 'act-vec-2', 11, 'memory-and-storage', 'Memory & Storage', 'Memory & Storage',
   'Flash; RAM; EEPROM concepts; nonvolatile storage; filesystem concepts; wear and endurance; ring buffers; persistent configuration; logging on constrained devices; boot state; crash dumps.',
   'With the RTOS running reliably, Vector Division tries to make the reactor arm''s freshly retuned gains and the door''s calibration data survive a power cycle -- and one board simply refuses to remember anything after its next reset.',
   'Flash Exhaustion',
   'The flash sector used for persistent configuration had been rewritten far more times than its rated write-erase cycle ever allowed -- the same old firmware habit of writing on every pass, this time to nonvolatile memory instead of the heap, quietly consuming the sector''s finite lifespan for years until it produced hard, permanent bit failures.',
   'Firmware that finally remembers correctly is still firmware sitting on a bench. Getting it onto every live device safely means building a real boot and update path, not hand-flashing one board at a time.',
   'Flash Exhaustion', 'Database', 'elevated', 140, 12, 'pathway-robotics'),

  ('world-vec-boot-and-update', 'act-vec-2', 12, 'boot-and-update', 'Boot & Update', 'Boot & Update',
   'Reset sequence; bootloaders; firmware images; checksums; signed firmware concepts; OTA updates; A/B partitions; rollback; recovery mode; version compatibility; safe migrations.',
   'Vector Division has more than two devices to update now -- Byte''s ongoing facility sweep is turning up more of them every day. Their first attempt to push the new RTOS firmware to several at once leaves multiple boards completely unresponsive.',
   'The Bricked Fleet',
   'The update had no A/B partitioning and no verified rollback path -- a failed write left several boards without any valid firmware image at all, recoverable only through a physical connection. The fix is a real OTA pipeline: two partitions, checksummed images, and a bootloader that only ever switches to a new image after confirming it is genuinely valid.',
   'Firmware can now be updated safely at any scale Vector Division can reach. The uncomfortable question Byte has been building toward all Arc is how many devices that scale actually needs to cover.',
   'The Bricked Fleet', 'Share2', 'severe', 152, 12, 'pathway-robotics'),

  ('world-vec-connected-things', 'act-vec-3', 13, 'connected-things', 'Connected Things', 'Connected Things',
   'IoT architecture; device identity; provisioning; Wi-Fi concepts; Bluetooth/BLE concepts; BLE services and characteristics; MQTT; topics and QoS; HTTP on devices; CoAP concepts; connectivity trade-offs.',
   'Byte''s facility-wide sweep, promised at the end of Arc II, finishes counting -- and the number of embedded controllers matching the door''s signature is far higher than anyone expected, almost all of them with no way to reach or be reached by anything at all.',
   'Ten Thousand Offline Devices',
   'Most of these controllers were never given a real device identity or a connectivity plan of any kind -- they were installed once, decades ago, and simply left running. The count is not evidence of an attack spreading. It is evidence of how much of Nexus was quietly built this way from the start.',
   'Identity and a radio are not the same as a working pipeline. Reaching one device is not the same as seeing all of them at once.',
   'Ten Thousand Offline Devices', 'Radio', 'severe', 164, 12, 'pathway-robotics'),

  ('world-vec-edge-to-cloud', 'act-vec-3', 14, 'edge-to-cloud', 'Edge to Cloud', 'Edge to Cloud',
   'Telemetry pipelines; device shadow/twin concepts; command channels; cloud ingestion; time-series data; device registries; fleet management; rules engines; edge buffering; offline-first behavior; store-and-forward.',
   'Vector Division builds the first real fleet-wide telemetry pipeline for the newly provisioned devices -- and during its first full test, one facility''s uplink drops out entirely.',
   'The Broken Uplink',
   'The uplink itself was a minor, ordinary failure, recovered cleanly because the edge firmware buffered and forwarded what it collected while disconnected. The real discovery is what finally appears once every device reports in at once: not one door, not one arm, but thousands of matching controllers across Nexus, all quietly running the same decades-old assumptions. Thousands of disconnected devices reveal that the crisis was never a single-machine problem. It was always a fleet problem.',
   'A fleet this size, all reachable at once, is also a fleet this size all attackable at once if Vector Division does not secure it first.',
   'The Broken Uplink', 'Cloud', 'severe', 176, 12, 'pathway-robotics');
