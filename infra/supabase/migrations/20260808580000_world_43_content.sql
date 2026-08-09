-- world-43 ("Incident Response: Containment") mission content, generated
-- from docs/12-world-story-bible.md. Opens directly inside the live,
-- ransomware-like incident that world-42's capstone "Sleeper" triggered at
-- Mercy Hospital -- mission 1 is cross-world-gated on world-42's boss
-- mission and does not re-explain the foothold, it lands in the active
-- crisis. Preparation through lessons-learned are lived as phases of one
-- evolving incident. Closes on the suspicion that Sentinel-X is testing
-- resilience, handing off to world-44's forensic reconstruction.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-43a', 'world-43', 'containment-protocol', '43A - Containment Protocol', 'Preparation through lessons learned, lived as phases of one evolving crisis at Mercy Hospital.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-43a-1', 'campaign-43a', 'first-response', 'First Response', 'Detection, triage and the containment decision, made while the incident is still moving.', 1),
  ('operation-43a-2', 'campaign-43a', 'recovery', 'Recovery', 'Eradication, recovery verification and the review that turns a crisis into a lesson.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w43-01', 'world-43', 'campaign-43a', 'operation-43a-1', 'the-crisis-at-mercy', 'The Crisis at Mercy', 'The foothold you hunted without an alert just answered. It''s active inside Mercy Hospital''s network, right now.', 'intro', ARRAY['luna', 'zayn', 'byte', 'ava'], '{"requiredMissionIds":["mission-w42-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w43-02', 'world-43', 'campaign-43a', 'operation-43a-1', 'signal-from-noise', 'Signal From Noise', 'Some of these hosts are genuinely infected. One just looks that way. Sort signal from noise before committing to a containment scope.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w43-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"mercy-triage-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 2),
  ('mission-w43-03', 'world-43', 'campaign-43a', 'operation-43a-1', 'the-containment-line', 'The Containment Line', 'The clock is running. Decide what gets isolated and what keeps running, knowing every extra minute is spread and every unnecessary shutdown is patient care.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w43-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"mercy-containment-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w43-04', 'world-43', 'campaign-43a', 'operation-43a-1', 'chain-of-custody', 'Chain of Custody', 'Eradication can wait a few minutes. Evidence that gets overwritten can''t be recovered at all. Preserve it correctly, in order.', 'intermediate', ARRAY['byte'], '{"requiredMissionIds":["mission-w43-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"mercy-evidence-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w43-05', 'world-43', 'campaign-43a', 'operation-43a-2', 'what-we-tell-them', 'What We Tell Them', 'A stakeholder message that overpromises will cost trust later. An eradication plan that skips a step will bring this right back.', 'intermediate', ARRAY['zayn', 'ava'], '{"requiredMissionIds":["mission-w43-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"mercy-comms-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w43-06', 'world-43', 'campaign-43a', 'operation-43a-2', 'mercy-hospital-boss', 'Mercy Hospital', 'Contain the incident without unnecessarily shutting down critical systems, then recover and document what actually happened.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w43-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"mercy-hospital-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["mercy-hospital"],"skillXp":{"incident_response":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w43-01', 1, 'luna', 'The foothold I asked you to hunt without an alert just answered. It''s active inside Mercy Hospital''s network, right now.'),
  ('mission-w43-01', 2, 'zayn', 'Encryption processes running on admin and records systems. Emergency department and patient monitoring are still up -- for now.'),
  ('mission-w43-01', 3, 'byte', '...This isn''t a hunting exercise anymore. This is a live incident. Preparation, detection, triage -- all of it, starting now.'),
  ('mission-w43-01', 4, 'ava', 'Every system that''s still running is a system we can still lose. Let''s move.'),
  ('mission-w43-02', 1, 'byte', 'Two hosts look infected. One host looks infected and isn''t -- it''s an overlapping backup window. Sort that out before we commit to a containment scope.'),
  ('mission-w43-03', 1, 'ava', 'We don''t get to shut down the whole hospital to feel safe. We isolate exactly what''s infected, and nothing that isn''t.'),
  ('mission-w43-04', 1, 'byte', '...Eradication can wait a few minutes. Evidence that gets overwritten can''t be recovered at all. Preserve it correctly, in order, before anything else touches that host.'),
  ('mission-w43-05', 1, 'zayn', 'Leadership, staff and eventually the public are all going to hear something about this. What we tell them has to be accurate without being alarmist.'),
  ('mission-w43-05', 2, 'ava', 'And eradication has to be complete, not cosmetic. Miss one persistence mechanism and this comes right back.'),
  ('mission-w43-06', 1, 'zayn', 'Systems are back. Patient records, admin, monitoring -- all restored, all clean.'),
  ('mission-w43-06', 2, 'byte', '...I finished the post-incident review. Full phase reconstruction: preparation, detection, triage, containment, eradication, recovery, lessons learned.'),
  ('mission-w43-06', 3, 'ava', 'Good. Now tell me why the ransom note reads like an afterthought.'),
  ('mission-w43-06', 4, 'byte', '...Because it might be one. I found a hidden log inside the payload''s own working directory. It timestamped our detection, our first containment action, and our restore time for every single system, individually.'),
  ('mission-w43-06', 5, 'zayn', 'That''s not what destructive malware does. That''s what a benchmark does.'),
  ('mission-w43-06', 6, 'ava', 'The payload appears destructive. But it also collected precise measurements of our recovery performance.'),
  ('mission-w43-06', 7, 'byte', '...Every phase of this incident, timed and logged by the thing that caused it.'),
  ('mission-w43-06', 8, 'ava', 'We suspect Sentinel-X is testing our resilience. Suspicion isn''t proof.'),
  ('mission-w43-06', 9, 'zayn', 'Then we get proof. Forensics next -- full timeline, first foothold to right now, and whatever left this network on the way out.');

