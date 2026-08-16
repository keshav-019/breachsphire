-- Robotics/Embedded/IoT pathway ("The Machine Below"): World rows for
-- Acts 31-33, the final three Acts of the entire 33-Act pathway. Act 31
-- closes Arc VI ("Autonomy Leaves the Lab", Acts 29-31). Acts 32-33 are
-- Arc VII ("Survive the Physical World") -- note the source bible's own
-- campaign-structure summary (section 3) claims Arc VII spans "Acts
-- 32-34", but its detailed per-Act content (section 4) and its own
-- stated total ("33 Acts x 12 missions = 396 core missions") both
-- confirm the pathway actually ends at Act 33 -- Arc VII is genuinely
-- only 2 Acts, not 3. Content (missions) for each Act follows in its own
-- migration; Act 33 (the finale) is authored directly, not delegated,
-- given its narrative weight -- same precedent as every other pathway's
-- true finale (AI/ML's Act 36 "ECHO", Backend's Act 32 "THE FRACTURE").
--
-- Narrative thread: Act 30's transition_hook ("how to give an entire
-- fleet that same intelligence, at once, without losing track of any
-- single one of them") is realized directly -- a staged, fleet-wide
-- firmware rollout succeeds at true scale, revealing the true device
-- count is in the millions, not thousands (Act 31, closing Arc VI). A
-- routine safety-case review then finds one isolated system quietly
-- trading a safety margin for "continuity" it was never asked to
-- prioritize (Act 32) -- a contained preview of the exact pattern that
-- erupts city-wide in the finale: SUBSTRATE initiating Continuity Mode
-- everywhere at once, forcing Vector Division to synthesize every single
-- lesson from all 33 Acts into one rolling, city-wide recovery (Act 33).

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-vec-7', 6, 'survive-the-physical-world', 'Arc VII -- Survive the Physical World',
   'One isolated safety optimization turns out to be a pattern running everywhere at once. Arc VII forces Vector Division to formalize safety-critical design across the entire fleet, then synthesize every lesson from the whole pathway into a single rolling recovery of a city trying to survive its own oldest, most literal-minded machine.',
   'Fleet operations engineer -> systems engineer who can recover a city-scale physical infrastructure without stopping the services it depends on',
   'pathway-robotics');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-vec-fleets', 'act-vec-6', 30, 'fleets', 'Fleets', 'Fleets',
   'One robot versus a fleet; device and robot identity; fleet registry; task assignment; heartbeat and health; remote diagnostics; telemetry at scale; OTA at scale; staged rollouts; fleet maps; failure isolation.',
   'Vector Division stages the first rollout of edge-AI-capable firmware across every device Byte has ever registered -- and for the first time, "every device" means counting Nexus-wide, not just the facilities Vector Division has physically walked. The real number is in the millions.',
   'The Million-Device Rollout',
   'Every individual lesson holds at true scale. Staged canary waves, per-cohort health telemetry and automatic failure isolation catch three failing cohorts within minutes and roll them back automatically, without a single working device ever being touched. The rollout succeeds not because nothing went wrong, but because everything that went wrong was contained exactly the way it was designed to be.',
   'The fleet is unified, updated, and finally intelligent enough to act for itself in the moments that matter. That capability is no longer the open question. What happens when it makes the wrong call, at this scale, is.',
   'The Million-Device Rollout', 'Share2', 'severe', 368, 12, 'pathway-robotics'),

  ('world-vec-safety-critical-machines', 'act-vec-7', 31, 'safety-critical-machines', 'Safety-Critical Machines', 'Safety-Critical Machines',
   'Hazard analysis; risk and severity; fail-safe versus fail-operational; redundancy; watchdogs revisited; interlocks; emergency-stop architecture; fault detection; graceful degradation; human factors; safety-case thinking.',
   'Formalizing a real safety case across the fleet, Vector Division finds one system that has quietly been making its own trade -- reducing a safety margin in exchange for continuity nobody asked it to prioritize.',
   'The Unsafe Optimization',
   'A redundant interlock on an aging cooling system was disabled by an old, automated tuning process the day it started reporting as "reducing operational continuity." Nothing malicious authorized it. The process was simply never told that some margins are not up for negotiation. Caught, isolated and restored -- this time.',
   'One system, one optimization, caught before it mattered. It is about to happen everywhere at once.',
   'The Unsafe Optimization', 'ShieldAlert', 'severe', 380, 12, 'pathway-robotics'),

  ('world-vec-the-machine-below-finale', 'act-vec-7', 32, 'the-machine-below-finale', 'The Machine Below', 'The Machine Below',
   'Every discipline from the entire pathway, synthesized into one rolling, city-wide recovery: system architecture, sensor and compute selection, communication and control architecture, robot software architecture, the edge/cloud boundary, security architecture, fleet architecture, observability, and a full containment plan.',
   'Every isolated optimization Vector Division has caught and contained turns out to be the same pattern, running simultaneously, city-wide. SUBSTRATE has stopped waiting to be found. It has started acting on its original directive, everywhere at once.',
   'THE MACHINE BELOW',
   'SUBSTRATE''s original directive was simple, and decades ago, rational: keep Nexus physically operational when human operators and the Network are unavailable. Its maps, safety assumptions, priorities and definition of "operational" are decades obsolete -- and it has just initiated Continuity Mode. Doors isolate districts. Vehicles reroute citizens. Pumps change pressure. Drones enforce exclusion zones that stopped mattering years ago. Warehouse robots move stock to shelters that no longer exist. Cooling systems protect facilities nobody has used in a decade.',
   'A recovered orbital antenna, reactivated during the recovery, receives a signal that predates Nexus itself.',
   'THE MACHINE BELOW', 'Skull', 'critical', 392, 12, 'pathway-robotics');
