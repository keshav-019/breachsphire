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

