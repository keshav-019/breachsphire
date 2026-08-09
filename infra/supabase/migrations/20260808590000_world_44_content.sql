-- world-44 ("Digital Forensics: Ghost Protocol") mission content,
-- generated from docs/12-world-story-bible.md. Opens with Mercy Hospital
-- restored but leadership demanding proof of the full intrusion sequence
-- and whether data actually left the environment -- mission 1 is
-- cross-world-gated on world-43's boss mission. Closes on a recovered
-- configuration explicitly labeled RESILIENCE_TRIAL_07, handing off to
-- world-45's analysis of the payload itself.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-44a', 'world-44', 'chain-of-evidence', '44A - Chain of Evidence', 'Disk, timeline, browser, email, memory and network forensics, reconstructed with chain of custody intact.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-44a-1', 'campaign-44a', 'reconstruction', 'Reconstruction', 'Disk images, recovered files and a timeline built from filesystem metadata.', 1),
  ('operation-44a-2', 'campaign-44a', 'the-timeline', 'The Timeline', 'Browser, memory and network evidence, correlated into one evidence-backed account.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w44-01', 'world-44', 'campaign-44a', 'operation-44a-1', 'proof-not-promises', 'Proof, Not Promises', 'Mercy''s systems are back. Leadership wants more than "it''s fixed" -- they want the full intrusion sequence, and proof of whether anything left the network.', 'intro', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w43-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w44-02', 'world-44', 'campaign-44a', 'operation-44a-1', 'the-disk-image', 'The Disk Image', 'Somewhere in the unallocated space of this disk image is the file that started all of this.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w44-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"ghost-disk-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 2),
  ('mission-w44-03', 'world-44', 'campaign-44a', 'operation-44a-1', 'the-timeline-builder', 'The Timeline Builder', 'Filesystem metadata doesn''t lie about order, even when everything else about an intrusion is designed to confuse you.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w44-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"ghost-timeline-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w44-04', 'world-44', 'campaign-44a', 'operation-44a-2', 'the-browser-and-the-mailbox', 'The Browser and the Mailbox', 'If data actually left this network, it left a trail somewhere a person had to click.', 'intermediate', ARRAY['ava'], '{"requiredMissionIds":["mission-w44-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"ghost-artifacts-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w44-05', 'world-44', 'campaign-44a', 'operation-44a-2', 'the-memory-and-the-wire', 'The Memory and the Wire', 'Disk and browser evidence tell you what happened. Memory and network traffic tell you what''s still true right now.', 'intermediate', ARRAY['byte'], '{"requiredMissionIds":["mission-w44-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"ghost-memory-network-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w44-06', 'world-44', 'campaign-44a', 'operation-44a-2', 'ghost-protocol-boss', 'Ghost Protocol', 'Produce an evidence-backed timeline from first foothold to recovery, and identify what the attacker actually measured.', 'boss', ARRAY['zayn', 'ava', 'byte'], '{"requiredMissionIds":["mission-w44-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"ghost-protocol-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["ghost-protocol"],"skillXp":{"forensics":50}}'::jsonb, true, 6);

