-- Phase 2.4e: world-4 mission content, generated from
-- docs/12-world-story-bible.md. Mission 1 is cross-world-gated on
-- the previous world's boss mission where applicable.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-4a', 'world-4', 'address-unknown', '4A - Address Unknown', 'Dozens of suspicious addresses, unclear which are local, public, temporary, or even valid.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-4a-1', 'campaign-4a', 'foundations', 'Foundations', 'IPv4/IPv6 classification and subnetting, learned by rebuilding the incident map.', 1),
  ('operation-4a-2', 'campaign-4a', 'investigation', 'Investigation', 'Find the hidden subnet and its real boundaries.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w4-01', 'world-4', 'campaign-4a', 'operation-4a-1', 'address-unknown', 'Address Unknown', 'Switchshade produced dozens of addresses tied to the incident -- half of them don''t make sense yet.', 'intro', ARRAY['zayn'], '{"requiredMissionIds":["mission-w3-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w4-02', 'world-4', 'campaign-4a', 'operation-4a-1', 'public-private-or-impossible', 'Public, Private, or Impossible', 'Some addresses are private, some public, and at least one shouldn''t be routable anywhere.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w4-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"address-classify-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w4-03', 'world-4', 'campaign-4a', 'operation-4a-1', 'carve-the-subnet', 'Carve the Subnet', 'Everything downstream depends on getting this arithmetic right.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w4-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"subnet-builder-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w4-04', 'world-4', 'campaign-4a', 'operation-4a-2', 'same-subnet-or-not', 'Same Subnet or Not', 'Two hosts can only talk directly if they''re on the same subnet -- otherwise everything goes through a gateway first.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w4-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"subnet-membership-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w4-05', 'world-4', 'campaign-4a', 'operation-4a-2', 'compressing-ipv6', 'Compressing IPv6', 'One of the flagged systems logs its own address in IPv6 -- don''t let the notation fool you.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w4-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"ipv6-compress-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w4-06', 'world-4', 'campaign-4a', 'operation-4a-2', 'the-vanishing-range', 'The Vanishing Range', 'Somewhere in this mess is a subnet that shouldn''t exist on paper. Find its actual boundaries.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w4-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"vanishing-range-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["vanishing-range"],"skillXp":{"networking":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w4-01', 1, 'zayn', 'Switchshade gave us dozens of addresses tied to the incident. Half of them don''t make sense yet -- we don''t even know which are real, local, or possible.'),
  ('mission-w4-01', 2, 'zayn', 'Addressing isn''t memorization. It''s spatial reasoning: who can talk directly, who needs a gateway, and what shouldn''t exist on the internet at all.'),
  ('mission-w4-02', 1, 'zayn', 'Some of these addresses are private, some are public, and at least one of them shouldn''t be routable anywhere. Sort them before you trust any of them.'),
  ('mission-w4-03', 1, 'zayn', 'Everything downstream depends on getting this arithmetic right. One subnet, one calculation.'),
  ('mission-w4-04', 1, 'zayn', 'Two hosts can only talk directly if they''re on the same subnet. Otherwise, everything goes through a gateway first. Sort these pairs.'),
  ('mission-w4-05', 1, 'zayn', 'One of the flagged systems logs its own address in IPv6. Don''t let the notation fool you.'),
  ('mission-w4-06', 1, 'zayn', 'Somewhere in this mess is a subnet that shouldn''t exist on paper. Find its actual boundaries.'),
  ('mission-w4-06', 2, 'zayn', 'Confirmed. 10.66.66.0/24 -- and it''s not on any current network diagram.'),
  ('mission-w4-06', 3, 'byte', 'I checked archived Guardian documentation. That exact range was used for a decommissioned simulation environment. Years ago.'),
  ('mission-w4-06', 4, 'zayn', 'So either someone resurrected retired infrastructure, or someone copied its addressing on purpose to blend in. Either way, we need to know where traffic from that range actually goes. That means routing.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w4-01-o1', 'mission-w4-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to sort the addresses.'),
  ('mission-w4-02-o1', 'mission-w4-02', 1, 'Classify the addresses', 'Identify the addresses that are technically impossible as real remote traffic sources.'),
  ('mission-w4-03-o1', 'mission-w4-03', 1, 'Compute the range', 'Determine the last usable host address in a given CIDR block.'),
  ('mission-w4-04-o1', 'mission-w4-04', 1, 'Sort the host pairs', 'Determine which host pairs share a subnet and which need a gateway.'),
  ('mission-w4-05-o1', 'mission-w4-05', 1, 'Pick the correct compression', 'Identify the correctly compressed form of a full IPv6 address.'),
  ('mission-w4-06-o1', 'mission-w4-06', 1, 'Find the anomalous addresses', 'Identify the addresses belonging to the hidden staging subnet.'),
  ('mission-w4-06-o2', 'mission-w4-06', 2, 'Produce the boundaries', 'State the hidden subnet''s network and broadcast addresses.'),
  ('mission-w4-06-o3', 'mission-w4-06', 3, 'Report the range', 'Report the hidden subnet''s exact boundaries.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w4-01-o1-c1', 'mission-w4-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"zayn","text":"Every address on this list is a real question waiting to be answered. Ready?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),
  ('mission-w4-02-o1-c1', 'mission-w4-02-o1', 1, 'investigation', 'Which addresses are technically impossible or invalid as real remote traffic sources?', '{"evidence":[{"id":"ip1","label":"10.20.4.15","detail":"Seen inside the hospital network"},{"id":"ip2","label":"172.16.50.8","detail":"Seen inside a different Guardian-monitored network"},{"id":"ip3","label":"8.8.8.8","detail":"A well-known public DNS resolver"},{"id":"ip4","label":"127.0.0.1","detail":"Appears in a log as a claimed remote source address"},{"id":"ip5","label":"198.51.100.23","detail":"Appears in an external capture -- a documentation-range address that should never appear in live traffic"}],"question":"Which addresses are technically impossible or invalid as real remote traffic sources?"}'::jsonb, '{"requiredEvidenceIds":["ip4","ip5"]}'::jsonb),
  ('mission-w4-03-o1-c1', 'mission-w4-03-o1', 1, 'multiple_choice', 'For the network 192.168.4.0/26, what is the last usable host address?', '{"question":"For the network 192.168.4.0/26, what is the last usable host address?","options":[{"id":"a","text":"192.168.4.62"},{"id":"b","text":"192.168.4.63"},{"id":"c","text":"192.168.4.254"},{"id":"d","text":"192.168.4.31"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-w4-04-o1-c1', 'mission-w4-04-o1', 1, 'drag_and_drop', 'Sort each pair by whether they can talk directly or need a gateway.', '{"items":[{"id":"pair1","text":"10.0.5.10/24 and 10.0.5.200/24"},{"id":"pair2","text":"10.0.5.10/24 and 10.0.6.10/24"},{"id":"pair3","text":"192.168.1.5/25 and 192.168.1.130/25"},{"id":"pair4","text":"172.16.0.5/16 and 172.16.99.5/16"}],"targets":[{"id":"direct","label":"Can talk directly"},{"id":"gateway","label":"Needs a gateway"}]}'::jsonb, '{"correctMapping":{"pair1":"direct","pair2":"gateway","pair3":"gateway","pair4":"direct"}}'::jsonb),
  ('mission-w4-05-o1-c1', 'mission-w4-05-o1', 1, 'multiple_choice', 'Which is the correctly compressed form of 2001:0db8:0000:0000:0000:0000:0000:0001?', '{"question":"Which is the correctly compressed form of 2001:0db8:0000:0000:0000:0000:0000:0001?","options":[{"id":"a","text":"2001:db8::1"},{"id":"b","text":"2001:db8:0:0:0:0:0:1"},{"id":"c","text":"2001::db8::1"},{"id":"d","text":"2001:0db8::0001"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-w4-06-o1-c1', 'mission-w4-06-o1', 1, 'investigation', 'Which addresses belong to the actual hidden staging subnet?', '{"evidence":[{"id":"r1","label":"10.66.66.4","detail":"Appears in three separate incident captures over two weeks"},{"id":"r2","label":"10.66.66.19","detail":"Appears once, alongside r1, same capture window"},{"id":"r3","label":"10.20.4.15","detail":"The known hospital workstation address -- unrelated range"},{"id":"r4","label":"10.66.67.4","detail":"Similar-looking address, but a different /24 entirely, never appears alongside the others"}],"question":"Which addresses belong to the actual hidden staging subnet?"}'::jsonb, '{"requiredEvidenceIds":["r1","r2"]}'::jsonb),
  ('mission-w4-06-o2-c1', 'mission-w4-06-o2', 1, 'multiple_choice', 'Given the observed addresses (10.66.66.4 and 10.66.66.19, both within a /24), what are the network''s boundaries?', '{"question":"Given the observed addresses (10.66.66.4 and 10.66.66.19, both within a /24), what are the network''s boundaries?","options":[{"id":"a","text":"Network 10.66.66.0, broadcast 10.66.66.255"},{"id":"b","text":"Network 10.66.0.0, broadcast 10.66.255.255"},{"id":"c","text":"Network 10.66.66.0, broadcast 10.66.67.255"},{"id":"d","text":"Network 10.66.66.4, broadcast 10.66.66.19"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-w4-06-o3-c1', 'mission-w4-06-o3', 1, 'boss_encounter', 'Report the hidden subnet''s exact range.', '{"stages":[{"objectiveRef":"mission-w4-06-o1","label":"The anomalous addresses"},{"objectiveRef":"mission-w4-06-o2","label":"The network boundaries"}],"task":"Report the hidden subnet''s exact range."}'::jsonb, '{"requiredObjectiveIds":["mission-w4-06-o1","mission-w4-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w4-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),
  ('mission-w4-02-o1-c1', 'orientation', 'Two of these five addresses could never legitimately appear as the source of real remote traffic, for very different reasons.', 10, 1),
  ('mission-w4-02-o1-c1', 'concept', 'One is reserved purely for a machine talking to itself; another is reserved purely for documentation and examples.', 20, 2),
  ('mission-w4-02-o1-c1', 'solution', '127.0.0.1 (loopback) can never be a real remote source, and 198.51.100.23 is a documentation/example-range address that should never appear in live traffic -- both point to fabricated or misconfigured evidence.', 30, 3),
  ('mission-w4-03-o1-c1', 'orientation', 'A /26 gives you 64 total addresses in the block -- work out where that block ends.', 10, 1),
  ('mission-w4-03-o1-c1', 'concept', 'The very last address in any block is always reserved as the broadcast address, never usable by a host.', 20, 2),
  ('mission-w4-03-o1-c1', 'tool_direction', '192.168.4.0/26 spans .0 through .63 -- identify the network address and the broadcast address at each end.', 30, 3),
  ('mission-w4-03-o1-c1', 'solution', 'The block runs .0 (network) through .63 (broadcast), so the last usable host address is .62.', 40, 4),
  ('mission-w4-04-o1-c1', 'orientation', 'For each pair, work out the actual subnet boundary from the prefix length, not just eyeballing the address.', 10, 1),
  ('mission-w4-04-o1-c1', 'concept', 'A /25 splits a /24 block exactly in half -- check which half each address actually falls in.', 20, 2),
  ('mission-w4-04-o1-c1', 'solution', 'pair1 and pair4 share the same subnet under their prefix; pair2 (different /24) and pair3 (opposite halves of a /25 split) each need a gateway.', 30, 3),
  ('mission-w4-05-o1-c1', 'orientation', 'Leading zeros within each group can be dropped, and one -- only one -- run of all-zero groups can be collapsed.', 10, 1),
  ('mission-w4-05-o1-c1', 'concept', 'Using :: more than once in the same address makes it ambiguous, which is why it''s invalid.', 20, 2),
  ('mission-w4-05-o1-c1', 'solution', '2001:db8::1 correctly drops the leading zeros and collapses the single run of all-zero groups with :: exactly once.', 30, 3),
  ('mission-w4-06-o1-c1', 'orientation', 'A similar-looking address isn''t necessarily part of the same subnet -- check the actual prefix boundaries.', 15, 1),
  ('mission-w4-06-o1-c1', 'concept', 'Look for addresses that both share a /24 and actually co-occur in the same evidence.', 25, 2),
  ('mission-w4-06-o1-c1', 'tool_direction', 'Compare the third octet of each candidate address carefully.', 35, 3),
  ('mission-w4-06-o1-c1', 'solution', 'r1 and r2 both fall inside 10.66.66.0/24 and co-occur across the same incident captures -- r3 is unrelated, and r4 is a similar-looking but different /24 that never appears alongside them.', 45, 4),
  ('mission-w4-06-o2-c1', 'orientation', 'A /24 always spans exactly 256 addresses with the last octet as the host portion.', 15, 1),
  ('mission-w4-06-o2-c1', 'solution', '10.66.66.0/24 runs from network address 10.66.66.0 to broadcast address 10.66.66.255.', 25, 2),
  ('mission-w4-06-o3-c1', 'orientation', 'You''ve already gathered everything you need -- state the range as a single CIDR block.', 20, 1),
  ('mission-w4-06-o3-c1', 'concept', 'The report needs the exact subnet, not just the individual addresses that revealed it.', 30, 2),
  ('mission-w4-06-o3-c1', 'tool_direction', 'Combine the addresses you confirmed with the boundaries you calculated.', 40, 3),
  ('mission-w4-06-o3-c1', 'near_solution', '10.66.66.4 and 10.66.66.19 both sit inside one specific /24 block.', 50, 4),
  ('mission-w4-06-o3-c1', 'solution', 'The hidden staging subnet is 10.66.66.0/24, evidenced by 10.66.66.4 and 10.66.66.19 co-occurring across the incident captures.', 60, 5);
