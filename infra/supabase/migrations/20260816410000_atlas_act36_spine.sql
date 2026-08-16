-- Atlas Division pathway ("The Silence"): World row for Act 36, "Atlas
-- Falls" -- the campaign finale -- still under act-atlas-10 ("World X
-- -- Atlas"). Content (missions) follows in its own migration.
--
-- This is the pathway's final Act. Every one of the eleven non-boss
-- missions is itself a stage of one continuous incident, not an
-- isolated concept lesson -- matching the finale scale already used for
-- the AI/ML pathway's "ECHO" and the Robotics pathway's "THE MACHINE
-- BELOW." Narrative thread: a genuine supply-chain compromise, the same
-- mechanism as Act 32's "Trusted Poison," succeeds specifically because
-- one legacy pipeline was never migrated onto the Act 32 policy gate.
-- Everything else this pathway built -- mesh mTLS, disaster recovery,
-- regional isolation, credential rotation, safe automation -- performs
-- exactly as designed, and what could have been another 03:17 becomes a
-- fully contained, fully understood, fully recovered incident in under
-- an hour instead.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-atlas-falls', 'act-atlas-10', 35, 'atlas-falls', 'Atlas Falls', 'Atlas Falls',
   'First Alarm; Pipeline Compromise; Registry Failure; Cluster Saturation; Telemetry Blackout; Database Failover; Queue Backlog; Credential Revocation; Region Isolation; Global Traffic Shift; Recover Atlas.',
   'A genuine supply-chain compromise reaches production through the one legacy pipeline that was never migrated onto Act 32''s policy gate, and every system this pathway has ever built is about to be tested together, for real, at once.',
   'The Silence',
   'The compromise is real, and it very nearly worked -- a tampered dependency, a validly signed but maliciously built image, a saturated cluster, and telemetry itself briefly going dark, the same silence this entire pathway opened with, thirty-five Acts ago. But this time, mTLS held every lateral connection the compromise tried to make, regional isolation contained the blast radius to one region out of three, disaster recovery met its RPO and RTO exactly as designed, and credential revocation cut off every access path within minutes. The single real gap -- one pipeline, never migrated -- is found, named, and finally closed. Total time from First Alarm to full, verified recovery: fifty-two minutes. Not the multi-day unknown that 03:17 once was. Understood, contained, and over, because thirty-five Acts of discipline were actually there to catch it.',
   'Atlas Division does not end here because there is nothing left to break. It ends here because, for the first time, everything this pathway ever built held, together, all at once, exactly when it mattered.',
   'The Silence', 'ShieldCheck', 'critical', 170, 26, 'pathway-atlas');
