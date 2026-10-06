-- Atlas Division pathway ("The Silence") Act 2 -- "The Network Beneath"
-- content, under world-atlas-the-network-beneath (already inserted
-- separately). 1 campaign, 2 operations, 12 missions (11 lessons +
-- boss), following the same pattern as Act 1. Mixes conceptual
-- challenge types (packets/CIDR/subnets/NAT/TLS/proxies are not
-- commands to run, they are things to reason about) with hands-on
-- terminal_simulation missions wherever the engine genuinely supports
-- it -- confirmed via direct source read of commands.ts before writing:
-- `dig`/`nslookup` query `dnsRecords`, `ss`/`netstat` list
-- `connections`, `nmap` scans `scanTargets`, all dynamically seedable
-- (see subsystems.ts). There is no `ping`/`route`/`traceroute` command
-- in this engine at all -- routing is instead taught by having the
-- player `cat` a seeded routes.conf file (the same "read a config file"
-- trick Act 1 used repeatedly), not a dedicated routing command.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-the-network-beneath', 'world-atlas-the-network-beneath', 'the-network-beneath', '1B - The Network Beneath', 'Learn the vocabulary of production networking -- packets, IP and CIDR, subnets, routing, NAT, DNS, TCP failure modes, TLS, proxies and firewalls -- while Tomas Vey traces one connection that refuses to complete.', 2);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-the-network-beneath-1', 'campaign-atlas-the-network-beneath', 'addressing-the-network', 'Addressing the Network', 'Packets, IP and CIDR, subnets, routing and NAT.', 1),
  ('operation-atlas-the-network-beneath-2', 'campaign-atlas-the-network-beneath', 'the-connection-that-would-not-complete', 'The Connection That Would Not Complete', 'DNS, TCP failure modes, TLS, proxies, reverse proxies and firewalls.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-the-network-beneath-01', 'world-atlas-the-network-beneath', 'campaign-atlas-the-network-beneath', 'operation-atlas-the-network-beneath-1', 'packets', 'Packets', 'Every certificate is renewed, every disk cleared, every stuck process gone -- and Atlas Division''s own dashboard still cannot reach a metrics collector that came online days ago. Tomas Vey, Cloud Architect, takes over from here.', 'beginner', ARRAY['vey','leena'], null, null, '{"type":"simulation","simulationId":"packets-sim"}'::jsonb, '{"xp":130,"credits":20}'::jsonb, false, 1),
  ('mission-atlas-the-network-beneath-02', 'world-atlas-the-network-beneath', 'campaign-atlas-the-network-beneath', 'operation-atlas-the-network-beneath-1', 'ip-and-cidr', 'IP and CIDR', 'An IP address alone tells you where a host is. CIDR notation tells you how many neighbors it has.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-network-beneath-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"ip-cidr-sim"}'::jsonb, '{"xp":130,"credits":20}'::jsonb, false, 2),
  ('mission-atlas-the-network-beneath-03', 'world-atlas-the-network-beneath', 'campaign-atlas-the-network-beneath', 'operation-atlas-the-network-beneath-1', 'subnets', 'Subnets', 'A subnet is a boundary, not a suggestion. Two addresses can be numerically close and still belong to entirely different networks.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-network-beneath-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"subnets-sim"}'::jsonb, '{"xp":140,"credits":25}'::jsonb, false, 3),
  ('mission-atlas-the-network-beneath-04', 'world-atlas-the-network-beneath', 'campaign-atlas-the-network-beneath', 'operation-atlas-the-network-beneath-1', 'routing', 'Routing', 'A packet does not know how to get anywhere on its own. Every hop along the way has to be told, explicitly, what comes next.', 'beginner', ARRAY['vey','byte'], '{"requiredMissionIds":["mission-atlas-the-network-beneath-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"routing-sim"}'::jsonb, '{"xp":140,"credits":25}'::jsonb, false, 4),
  ('mission-atlas-the-network-beneath-05', 'world-atlas-the-network-beneath', 'campaign-atlas-the-network-beneath', 'operation-atlas-the-network-beneath-1', 'nat', 'NAT', 'Most hosts on this network do not have an address the outside world can reach directly, and that is by design, not by accident.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-network-beneath-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"nat-sim"}'::jsonb, '{"xp":150,"credits":25}'::jsonb, false, 5),
  ('mission-atlas-the-network-beneath-06', 'world-atlas-the-network-beneath', 'campaign-atlas-the-network-beneath', 'operation-atlas-the-network-beneath-2', 'dns', 'DNS', 'Nobody connects to an IP address by memory. They connect to a name, and trust something else to translate it correctly.', 'beginner', ARRAY['vey','byte'], '{"requiredMissionIds":["mission-atlas-the-network-beneath-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"dns-sim"}'::jsonb, '{"xp":150,"credits":30}'::jsonb, false, 6),
  ('mission-atlas-the-network-beneath-07', 'world-atlas-the-network-beneath', 'campaign-atlas-the-network-beneath', 'operation-atlas-the-network-beneath-2', 'tcp-failure-modes', 'TCP Failure Modes', 'A connection that never finishes connecting fails differently than one that connects and then drops. The dashboard''s stuck connection is telling Tomas exactly which one this is, if he reads it correctly.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-network-beneath-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"tcp-failure-modes-sim"}'::jsonb, '{"xp":160,"credits":30}'::jsonb, false, 7),
  ('mission-atlas-the-network-beneath-08', 'world-atlas-the-network-beneath', 'campaign-atlas-the-network-beneath', 'operation-atlas-the-network-beneath-2', 'tls', 'TLS', 'A handshake that fails on a certificate looks identical to a handshake that never reaches the server at all, right up until you know exactly where to look.', 'beginner', ARRAY['vey','byte'], '{"requiredMissionIds":["mission-atlas-the-network-beneath-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"tls-sim"}'::jsonb, '{"xp":160,"credits":30}'::jsonb, false, 8),
  ('mission-atlas-the-network-beneath-09', 'world-atlas-the-network-beneath', 'campaign-atlas-the-network-beneath', 'operation-atlas-the-network-beneath-2', 'proxies', 'Proxies', 'A proxy stands in for the client, not the server -- and everything on the other end only ever sees the proxy, never the original requester.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-network-beneath-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"proxies-sim"}'::jsonb, '{"xp":170,"credits":30}'::jsonb, false, 9),
  ('mission-atlas-the-network-beneath-10', 'world-atlas-the-network-beneath', 'campaign-atlas-the-network-beneath', 'operation-atlas-the-network-beneath-2', 'reverse-proxies', 'Reverse Proxies', 'A reverse proxy does the opposite job -- standing in for the server, so nothing on the outside ever has to know how many real servers are actually back there.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-the-network-beneath-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"reverse-proxies-sim"}'::jsonb, '{"xp":170,"credits":35}'::jsonb, false, 10),
  ('mission-atlas-the-network-beneath-11', 'world-atlas-the-network-beneath', 'campaign-atlas-the-network-beneath', 'operation-atlas-the-network-beneath-2', 'firewalls-and-security-groups', 'Firewalls and Security Groups', 'A firewall rule does not expire on its own. It just keeps enforcing exactly what it was told, for as long as nobody tells it the network changed.', 'beginner', ARRAY['vey','leena'], '{"requiredMissionIds":["mission-atlas-the-network-beneath-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"firewalls-security-groups-sim"}'::jsonb, '{"xp":180,"credits":35}'::jsonb, false, 11),
  ('mission-atlas-the-network-beneath-12', 'world-atlas-the-network-beneath', 'campaign-atlas-the-network-beneath', 'operation-atlas-the-network-beneath-2', 'route-to-nowhere', 'Route to Nowhere', 'Everything this Act taught, turned on one connection: not to force it through, to finally explain why it was never going to complete on its own.', 'boss', ARRAY['vey','leena','byte'], '{"requiredMissionIds":["mission-atlas-the-network-beneath-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"route-to-nowhere-boss-sim"}'::jsonb, '{"xp":420,"credits":90,"badgeIds":["route-to-nowhere"],"skillXp":{"cloud_devops_fundamentals":60}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-the-network-beneath-01', 1, 'leena', 'The certificate is renewed. The disk is clear. The stuck process is gone. Our own monitoring dashboard still cannot reach the metrics collector we brought online three days ago.'),
  ('mission-atlas-the-network-beneath-01', 2, 'vey', 'Tomas Vey, Cloud Architect. Everything Leena just listed was a host problem. This is not a host problem. Something between the dashboard and the collector is not carrying traffic the way either side expects.'),
  ('mission-atlas-the-network-beneath-01', 3, 'vey', 'A packet is the actual unit that moves: a header carrying addressing and control information, wrapped around whatever payload the application actually cares about. Nothing crosses this network without one.'),
  ('mission-atlas-the-network-beneath-01', 4, 'vey', 'We are not going to guess where this breaks. We are going to trace it, layer by layer, the same discipline Leena had you use on one host.'),

  ('mission-atlas-the-network-beneath-02', 1, 'vey', 'An IP address says where a host is. CIDR notation, the slash number, says how many addresses share that network with it. A /24 has 256 addresses. A /27 has 32, thirty of them usable.'),

  ('mission-atlas-the-network-beneath-03', 1, 'vey', 'A subnet is a hard boundary carved out of a larger address range. Two addresses can look numerically close and still sit on completely different subnets, unable to reach each other directly.'),

  ('mission-atlas-the-network-beneath-04', 1, 'vey', 'A packet does not know its own path. Every router along the way keeps a table: for this destination network, send it out this direction, to this next hop. Miss an entry and the packet has nowhere correct to go.'),
  ('mission-atlas-the-network-beneath-04', 2, 'byte', 'I pulled the routing table off the dashboard host itself. It has entries. Whether they are the right entries is the actual question.'),

  ('mission-atlas-the-network-beneath-05', 1, 'vey', 'Most hosts on this network use private addresses that mean nothing outside it. NAT translates between that private address and a public one at the edge, so the rest of the internet never needs to know the internal layout at all.'),

  ('mission-atlas-the-network-beneath-06', 1, 'vey', 'Nobody connects to a raw IP address from memory. They connect to a name -- metrics-collector.atlas.internal -- and trust DNS to hand back the right address. If DNS lies, or is simply wrong, everything built on top of it inherits that mistake.'),

  ('mission-atlas-the-network-beneath-07', 1, 'vey', 'A connection that establishes and then drops fails differently than one that never establishes at all. The state a connection is stuck in tells you which failure you are actually looking at, before you ever ask why.'),

  ('mission-atlas-the-network-beneath-08', 1, 'vey', 'A TLS handshake failing on an expired certificate and a TLS handshake that never reaches a server look identical from a distance. The difference only shows up once you know exactly which stage the handshake actually stopped at.'),

  ('mission-atlas-the-network-beneath-09', 1, 'vey', 'A forward proxy sits in front of the client. Everything the client requests goes out through it, and anything on the other end only ever sees the proxy, never the original requester.'),

  ('mission-atlas-the-network-beneath-10', 1, 'vey', 'A reverse proxy sits in front of the server side instead. The outside world only ever talks to it, never to whichever real backend actually answers -- which is exactly why it can quietly reroute traffic without anyone downstream noticing.'),

  ('mission-atlas-the-network-beneath-11', 1, 'leena', 'A firewall or security group rule does not decay. It does not know the network changed underneath it. It just keeps enforcing exactly what it was told, forever, until someone tells it otherwise.'),
  ('mission-atlas-the-network-beneath-11', 2, 'vey', 'Which means an old rule is not automatically a safe rule. It is only ever as correct as the network it was written for.'),

  ('mission-atlas-the-network-beneath-12', 1, 'vey', 'Everything this Act taught you, on one connection. Not to force it through. To explain, completely, why it was never going to complete on its own.'),
  ('mission-atlas-the-network-beneath-12', 2, 'leena', 'Start from the name. Walk it forward exactly the way Tomas taught you.'),
  ('mission-atlas-the-network-beneath-12', 3, 'byte', 'I have DNS, the port scan and the firewall rule set all pulled up. Whatever this is, it is in front of you right now.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-the-network-beneath-01-o1', 'mission-atlas-the-network-beneath-01', 1, 'Define a packet', 'Choose the accurate definition of a packet.'),
  ('mission-atlas-the-network-beneath-01-o2', 'mission-atlas-the-network-beneath-01', 2, 'Match header to payload', 'Sort each piece of information into header or payload.'),

  ('mission-atlas-the-network-beneath-02-o1', 'mission-atlas-the-network-beneath-02', 1, 'Read CIDR notation', 'Choose the correct number of usable host addresses for a given CIDR block.'),

  ('mission-atlas-the-network-beneath-03-o1', 'mission-atlas-the-network-beneath-03', 1, 'Sort addresses by subnet', 'Sort each address into whether it belongs to the given subnet or not.'),

  ('mission-atlas-the-network-beneath-04-o1', 'mission-atlas-the-network-beneath-04', 1, 'Read the routing table', 'Read the dashboard host''s routing table and submit its verification code.'),
  ('mission-atlas-the-network-beneath-04-o2', 'mission-atlas-the-network-beneath-04', 2, 'Identify the correct next hop', 'Given the routing table, identify the correct next hop for a specific destination network.'),

  ('mission-atlas-the-network-beneath-05-o1', 'mission-atlas-the-network-beneath-05', 1, 'Explain NAT''s purpose', 'Choose the accurate explanation of why NAT is used.'),

  ('mission-atlas-the-network-beneath-06-o1', 'mission-atlas-the-network-beneath-06', 1, 'Query DNS', 'Use the terminal to resolve a practice hostname and submit the code found in its record.'),

  ('mission-atlas-the-network-beneath-07-o1', 'mission-atlas-the-network-beneath-07', 1, 'Find the stuck connection', 'Use the terminal to identify which connection never completed its handshake, and submit its local port.'),

  ('mission-atlas-the-network-beneath-08-o1', 'mission-atlas-the-network-beneath-08', 1, 'Order the handshake', 'Order the stages of a TLS handshake from first to last.'),

  ('mission-atlas-the-network-beneath-09-o1', 'mission-atlas-the-network-beneath-09', 1, 'Define a forward proxy', 'Choose the accurate description of what a forward proxy does.'),

  ('mission-atlas-the-network-beneath-10-o1', 'mission-atlas-the-network-beneath-10', 1, 'Tell forward from reverse', 'Choose the accurate distinction between a forward proxy and a reverse proxy.'),

  ('mission-atlas-the-network-beneath-11-o1', 'mission-atlas-the-network-beneath-11', 1, 'Read the security group rules', 'Read the security group rule set and submit its verification code.'),
  ('mission-atlas-the-network-beneath-11-o2', 'mission-atlas-the-network-beneath-11', 2, 'Identify the allowed source', 'Given the rule set, identify which source CIDR is actually allowed to reach the metrics collector.'),

  ('mission-atlas-the-network-beneath-12-o1', 'mission-atlas-the-network-beneath-12', 1, 'Confirm DNS resolves correctly', 'Resolve metrics-collector.atlas.internal and submit the address it returns.'),
  ('mission-atlas-the-network-beneath-12-o2', 'mission-atlas-the-network-beneath-12', 2, 'Confirm the port is open', 'Scan the resolved address and submit the service code found on its listening port.'),
  ('mission-atlas-the-network-beneath-12-o3', 'mission-atlas-the-network-beneath-12', 3, 'Identify the actual blocker', 'Find the evidence that identifies the actual cause blocking the connection.'),
  ('mission-atlas-the-network-beneath-12-o4', 'mission-atlas-the-network-beneath-12', 4, 'State the diagnosis', 'Having confirmed all three, explain why the connection was never going to complete on its own.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-the-network-beneath-01-o1-c1', 'mission-atlas-the-network-beneath-01-o1', 1, 'multiple_choice', 'A packet is best described as...', '{"question":"A packet is best described as...","options":[{"id":"a","text":"A header carrying addressing and control information, wrapped around whatever payload the application actually cares about"},{"id":"b","text":"A synonym for a whole file transfer"},{"id":"c","text":"Only ever used for DNS traffic"},{"id":"d","text":"A physical piece of network hardware"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-atlas-the-network-beneath-01-o2-c1', 'mission-atlas-the-network-beneath-01-o2', 1, 'drag_and_drop', 'Sort each piece of information into header or payload.', '{"items":[{"id":"i1","text":"Source and destination IP address"},{"id":"i2","text":"The actual application data being sent"},{"id":"i3","text":"Source and destination port number"},{"id":"i4","text":"The body of an HTTP response"}],"targets":[{"id":"header","label":"Header"},{"id":"payload","label":"Payload"}]}'::jsonb, '{"correctMapping":{"i1":"header","i2":"payload","i3":"header","i4":"payload"}}'::jsonb),

  ('mission-atlas-the-network-beneath-02-o1-c1', 'mission-atlas-the-network-beneath-02-o1', 1, 'multiple_choice', 'How many usable host addresses does a /27 block provide?', '{"question":"How many usable host addresses does a /27 block provide?","options":[{"id":"a","text":"256"},{"id":"b","text":"30"},{"id":"c","text":"14"},{"id":"d","text":"62"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-atlas-the-network-beneath-03-o1-c1', 'mission-atlas-the-network-beneath-03-o1', 1, 'drag_and_drop', 'Sort each address into whether it belongs to the 10.20.4.0/24 subnet.', '{"items":[{"id":"i1","text":"10.20.4.17"},{"id":"i2","text":"10.20.12.47"},{"id":"i3","text":"10.20.4.254"},{"id":"i4","text":"10.20.5.1"}],"targets":[{"id":"in","label":"In 10.20.4.0/24"},{"id":"out","label":"Not in 10.20.4.0/24"}]}'::jsonb, '{"correctMapping":{"i1":"in","i2":"out","i3":"in","i4":"out"}}'::jsonb),

  ('mission-atlas-the-network-beneath-04-o1-c1', 'mission-atlas-the-network-beneath-04-o1', 1, 'terminal_simulation', 'Read the dashboard host''s routing table and submit its verification code.', '{"instructions":"Read /etc/atlas/routes.conf and submit the verification code with: submit CODE","hostname":"atlas-dashboard-02","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-dashboard-02\n"},"/home/recruit":{"type":"dir"},"/etc/atlas/routes.conf":{"type":"file","content":"10.20.4.0/24 via 10.20.0.1 dev eth0\n10.20.12.0/24 via 10.20.0.2 dev eth1\n0.0.0.0/0 via 10.20.0.254 dev eth0\n# verification RT-3312\n"}}}'::jsonb, '{"requiredFlag":"RT-3312"}'::jsonb),
  ('mission-atlas-the-network-beneath-04-o2-c1', 'mission-atlas-the-network-beneath-04-o2', 1, 'multiple_choice', 'Given the routing table (10.20.4.0/24 via 10.20.0.1, 10.20.12.0/24 via 10.20.0.2, 0.0.0.0/0 via 10.20.0.254), what is the correct next hop for traffic to 10.20.12.0/24?', '{"question":"Given the routing table (10.20.4.0/24 via 10.20.0.1, 10.20.12.0/24 via 10.20.0.2, 0.0.0.0/0 via 10.20.0.254), what is the correct next hop for traffic to 10.20.12.0/24?","options":[{"id":"a","text":"10.20.0.1"},{"id":"b","text":"10.20.0.2"},{"id":"c","text":"10.20.0.254"},{"id":"d","text":"There is no route for this network"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-atlas-the-network-beneath-05-o1-c1', 'mission-atlas-the-network-beneath-05-o1', 1, 'multiple_choice', 'NAT exists to...', '{"question":"NAT exists to...","options":[{"id":"a","text":"Translate between private, internal-only addresses and a public address at the network edge, so internal layout never has to be exposed"},{"id":"b","text":"Encrypt traffic between two hosts"},{"id":"c","text":"Assign hostnames to IP addresses"},{"id":"d","text":"Block all outbound traffic by default"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-network-beneath-06-o1-c1', 'mission-atlas-the-network-beneath-06-o1', 1, 'terminal_simulation', 'Resolve greenlight.atlas.internal and submit the code in its record.', '{"instructions":"Query DNS for greenlight.atlas.internal and submit the code in its TXT record with: submit CODE","hostname":"atlas-dashboard-02","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-dashboard-02\n"},"/home/recruit":{"type":"dir"}},"dnsRecords":[{"domain":"greenlight.atlas.internal","records":[{"type":"A","value":"10.20.0.9"},{"type":"TXT","value":"verification=DNS-5567"}]}]}'::jsonb, '{"requiredFlag":"DNS-5567"}'::jsonb),

  ('mission-atlas-the-network-beneath-07-o1-c1', 'mission-atlas-the-network-beneath-07-o1', 1, 'terminal_simulation', 'List the dashboard''s connections and identify which one never completed its handshake. Submit its local port.', '{"instructions":"List active connections and find the one stuck without ever completing a handshake. Submit its local port with: submit PORT","hostname":"atlas-dashboard-02","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-dashboard-02\n"},"/home/recruit":{"type":"dir"}},"connections":[{"proto":"tcp","localAddress":"10.20.0.9","localPort":51422,"state":"ESTABLISHED","process":"atlas-dashboard"},{"proto":"tcp","localAddress":"10.20.0.9","localPort":51500,"state":"SYN-SENT","process":"atlas-dashboard"},{"proto":"tcp","localAddress":"10.20.0.9","localPort":51288,"state":"TIME-WAIT","process":"atlas-dashboard"}]}'::jsonb, '{"requiredFlag":"51500"}'::jsonb),

  ('mission-atlas-the-network-beneath-08-o1-c1', 'mission-atlas-the-network-beneath-08-o1', 1, 'interactive_diagram', 'Order the stages of a TLS handshake from first to last.', '{"diagramId":"tls-handshake","hotspots":[{"id":"hello","label":"Client Hello","explanation":"The client proposes supported protocol versions and cipher suites."},{"id":"servercert","label":"Server presents certificate","explanation":"The server responds with its certificate for the client to validate."},{"id":"validate","label":"Client validates the certificate","explanation":"The client checks the certificate is trusted, current and matches the hostname."},{"id":"keys","label":"Session keys are exchanged","explanation":"Both sides derive the symmetric keys used for the rest of the session."},{"id":"encrypted","label":"Encrypted application data flows","explanation":"Only after this point does actual application traffic move."}],"task":"Order the handshake stages from first to last."}'::jsonb, '{"correctOrderIds":["hello","servercert","validate","keys","encrypted"]}'::jsonb),

  ('mission-atlas-the-network-beneath-09-o1-c1', 'mission-atlas-the-network-beneath-09-o1', 1, 'multiple_choice', 'A forward proxy...', '{"question":"A forward proxy...","options":[{"id":"a","text":"Sits in front of the client, so anything on the other end only ever sees the proxy, never the original requester"},{"id":"b","text":"Sits in front of a group of backend servers, hiding how many there are"},{"id":"c","text":"Only exists inside a browser"},{"id":"d","text":"Is a synonym for a firewall"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-network-beneath-10-o1-c1', 'mission-atlas-the-network-beneath-10-o1', 1, 'multiple_choice', 'The difference between a forward proxy and a reverse proxy is...', '{"question":"The difference between a forward proxy and a reverse proxy is...","options":[{"id":"a","text":"A forward proxy represents the client to the outside world; a reverse proxy represents the server to the outside world"},{"id":"b","text":"There is no real difference, the names are interchangeable"},{"id":"c","text":"A reverse proxy is only used for DNS"},{"id":"d","text":"A forward proxy always encrypts traffic and a reverse proxy never does"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-network-beneath-11-o1-c1', 'mission-atlas-the-network-beneath-11-o1', 1, 'terminal_simulation', 'Read the security group rules protecting the metrics collector and submit the verification code.', '{"instructions":"Read /etc/atlas/security-groups.conf and submit the verification code with: submit CODE","hostname":"atlas-dashboard-02","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-dashboard-02\n"},"/home/recruit":{"type":"dir"},"/etc/atlas/security-groups.conf":{"type":"file","content":"ALLOW tcp/9090 FROM 10.20.4.0/24 TO metrics-collector  # legacy rule, pre-resubnet\nALLOW tcp/22 FROM 10.20.0.0/16 TO any\nDENY all FROM any TO any  # default deny\n# verification FW-7734\n"}}}'::jsonb, '{"requiredFlag":"FW-7734"}'::jsonb),
  ('mission-atlas-the-network-beneath-11-o2-c1', 'mission-atlas-the-network-beneath-11-o2', 1, 'multiple_choice', 'Given the rule "ALLOW tcp/9090 FROM 10.20.4.0/24 TO metrics-collector", which source CIDR is actually allowed to reach the collector on port 9090?', '{"question":"Given the rule \"ALLOW tcp/9090 FROM 10.20.4.0/24 TO metrics-collector\", which source CIDR is actually allowed to reach the collector on port 9090?","options":[{"id":"a","text":"10.20.4.0/24"},{"id":"b","text":"10.20.12.0/24"},{"id":"c","text":"Any source, the rule allows all traffic"},{"id":"d","text":"No source is allowed"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-atlas-the-network-beneath-12-o1-c1', 'mission-atlas-the-network-beneath-12-o1', 1, 'terminal_simulation', 'Resolve metrics-collector.atlas.internal and submit the address it returns.', '{"instructions":"Query DNS for metrics-collector.atlas.internal and submit the resolved address with: submit ADDRESS","hostname":"atlas-dashboard-02","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-dashboard-02\n"},"/home/recruit":{"type":"dir"}},"dnsRecords":[{"domain":"metrics-collector.atlas.internal","records":[{"type":"A","value":"10.20.12.47"}]}]}'::jsonb, '{"requiredFlag":"10.20.12.47"}'::jsonb),
  ('mission-atlas-the-network-beneath-12-o2-c1', 'mission-atlas-the-network-beneath-12-o2', 1, 'terminal_simulation', 'Scan the resolved address and submit the service code found on its listening port.', '{"instructions":"Scan 10.20.12.47 and submit the service code from its listening port''s banner with: submit CODE","hostname":"atlas-dashboard-02","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-dashboard-02\n"},"/home/recruit":{"type":"dir"}},"scanTargets":[{"host":"10.20.12.47","ports":[{"port":9090,"proto":"tcp","state":"open","service":"atlas-metrics","banner":"READY CODE=SVC-4402"}]}]}'::jsonb, '{"requiredFlag":"SVC-4402"}'::jsonb),
  ('mission-atlas-the-network-beneath-12-o3-c1', 'mission-atlas-the-network-beneath-12-o3', 1, 'investigation', 'Which evidence identifies the actual cause blocking the connection?', '{"evidence":[{"id":"e1","label":"DNS record","detail":"metrics-collector.atlas.internal resolves cleanly to 10.20.12.47"},{"id":"e2","label":"Port scan","detail":"10.20.12.47 has port 9090 open and listening, service responding normally"},{"id":"e3","label":"Security group rule","detail":"The only rule permitting port 9090 traffic to the collector allows source CIDR 10.20.4.0/24 -- the pre-resubnet range. The dashboard now lives on 10.20.0.0/16 but outside that specific /24, and the collector itself sits on 10.20.12.0/24, also outside the allowed range"},{"id":"e4","label":"Facilities note","detail":"The collector host was racked in a different building than the dashboard"}],"question":"Which evidence identifies the actual cause blocking the connection?"}'::jsonb, '{"requiredEvidenceIds":["e3"]}'::jsonb),
  ('mission-atlas-the-network-beneath-12-o4-c1', 'mission-atlas-the-network-beneath-12-o4', 1, 'boss_encounter', 'Having confirmed DNS, the open port, and the actual blocker, explain why the connection was never going to complete on its own.', '{"stages":[{"objectiveRef":"mission-atlas-the-network-beneath-12-o1","label":"Confirm DNS resolves correctly"},{"objectiveRef":"mission-atlas-the-network-beneath-12-o2","label":"Confirm the port is open"},{"objectiveRef":"mission-atlas-the-network-beneath-12-o3","label":"Identify the actual blocker"}],"task":"State the diagnosis in one sentence: DNS resolves correctly and the collector''s port is open and listening -- the firewall rule denying the traffic is not new and not malicious, it was written for the subnet CIDR that existed before Atlas Division''s own resubnetting, and the new collector''s address falls just outside it. Nobody attacked the connection. Somebody just never updated a rule for a network that no longer exists."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-the-network-beneath-12-o1","mission-atlas-the-network-beneath-12-o2","mission-atlas-the-network-beneath-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-the-network-beneath-01-o1-c1', 'orientation', 'Think about what actually crosses the wire, not the whole application.', 10, 1),
  ('mission-atlas-the-network-beneath-01-o1-c1', 'solution', 'A packet is a header of addressing/control info wrapped around whatever payload the application cares about.', 20, 2),
  ('mission-atlas-the-network-beneath-01-o2-c1', 'orientation', 'Ask whether it is about delivering the data, or is the data itself.', 10, 1),
  ('mission-atlas-the-network-beneath-01-o2-c1', 'solution', 'Header: IPs, ports. Payload: application data, HTTP response body.', 20, 2),

  ('mission-atlas-the-network-beneath-02-o1-c1', 'orientation', 'A /27 leaves 5 host bits: 2^5 = 32 addresses, minus network and broadcast.', 10, 1),
  ('mission-atlas-the-network-beneath-02-o1-c1', 'solution', '32 total addresses, 30 usable for hosts.', 20, 2),

  ('mission-atlas-the-network-beneath-03-o1-c1', 'orientation', 'Compare the first three octets against 10.20.4.', 10, 1),
  ('mission-atlas-the-network-beneath-03-o1-c1', 'solution', 'In: 10.20.4.17, 10.20.4.254. Not in: 10.20.12.47, 10.20.5.1.', 20, 2),

  ('mission-atlas-the-network-beneath-04-o1-c1', 'orientation', 'Try: cat /etc/atlas/routes.conf', 10, 1),
  ('mission-atlas-the-network-beneath-04-o1-c1', 'solution', 'The file ends with verification RT-3312. submit RT-3312', 20, 2),
  ('mission-atlas-the-network-beneath-04-o2-c1', 'orientation', 'Match the destination network to its own specific route entry, not the default.', 10, 1),
  ('mission-atlas-the-network-beneath-04-o2-c1', 'solution', '10.20.12.0/24 routes via 10.20.0.2.', 20, 2),

  ('mission-atlas-the-network-beneath-05-o1-c1', 'orientation', 'Think about what happens to internal addressing once traffic crosses the edge.', 10, 1),
  ('mission-atlas-the-network-beneath-05-o1-c1', 'solution', 'NAT translates private addresses to a public one at the edge, hiding internal layout entirely.', 20, 2),

  ('mission-atlas-the-network-beneath-06-o1-c1', 'orientation', 'Try: dig greenlight.atlas.internal', 10, 1),
  ('mission-atlas-the-network-beneath-06-o1-c1', 'solution', 'The TXT record reads verification=DNS-5567. submit DNS-5567', 20, 2),

  ('mission-atlas-the-network-beneath-07-o1-c1', 'orientation', 'Try: ss -- look for a state that means the handshake is still in progress.', 10, 1),
  ('mission-atlas-the-network-beneath-07-o1-c1', 'solution', 'SYN-SENT on port 51500 means the handshake never completed. submit 51500', 20, 2),

  ('mission-atlas-the-network-beneath-08-o1-c1', 'orientation', 'Nothing encrypted can flow before both sides agree on keys, and no keys can be trusted before the certificate is validated.', 10, 1),
  ('mission-atlas-the-network-beneath-08-o1-c1', 'solution', 'Client Hello, server presents certificate, client validates it, keys exchanged, encrypted data flows.', 20, 2),

  ('mission-atlas-the-network-beneath-09-o1-c1', 'orientation', 'Ask which side of the connection it represents.', 10, 1),
  ('mission-atlas-the-network-beneath-09-o1-c1', 'solution', 'A forward proxy sits in front of the client, representing it to everything downstream.', 20, 2),

  ('mission-atlas-the-network-beneath-10-o1-c1', 'orientation', 'One represents the requester. The other represents the responder.', 10, 1),
  ('mission-atlas-the-network-beneath-10-o1-c1', 'solution', 'Forward proxy represents the client; reverse proxy represents the server.', 20, 2),

  ('mission-atlas-the-network-beneath-11-o1-c1', 'orientation', 'Try: cat /etc/atlas/security-groups.conf', 10, 1),
  ('mission-atlas-the-network-beneath-11-o1-c1', 'solution', 'The file ends with verification FW-7734. submit FW-7734', 20, 2),
  ('mission-atlas-the-network-beneath-11-o2-c1', 'orientation', 'Read the rule''s FROM clause directly.', 10, 1),
  ('mission-atlas-the-network-beneath-11-o2-c1', 'solution', 'The rule only allows source 10.20.4.0/24 to reach port 9090.', 20, 2),

  ('mission-atlas-the-network-beneath-12-o1-c1', 'orientation', 'Try: dig metrics-collector.atlas.internal', 10, 1),
  ('mission-atlas-the-network-beneath-12-o1-c1', 'solution', 'It resolves to 10.20.12.47. submit 10.20.12.47', 20, 2),
  ('mission-atlas-the-network-beneath-12-o2-c1', 'orientation', 'Try: nmap 10.20.12.47', 10, 1),
  ('mission-atlas-the-network-beneath-12-o2-c1', 'solution', 'Port 9090 is open, banner reads CODE=SVC-4402. submit SVC-4402', 20, 2),
  ('mission-atlas-the-network-beneath-12-o3-c1', 'orientation', 'DNS and the port are both fine -- the blocker has to be something else entirely.', 10, 1),
  ('mission-atlas-the-network-beneath-12-o3-c1', 'solution', 'e3: the only permitting rule is scoped to the pre-resubnet CIDR, which excludes both the dashboard''s and the collector''s current addresses.', 20, 2),
  ('mission-atlas-the-network-beneath-12-o4-c1', 'orientation', 'Combine what DNS, the port scan and the rule each proved into one sentence.', 15, 1),
  ('mission-atlas-the-network-beneath-12-o4-c1', 'solution', 'DNS resolves correctly, the port is open, and the firewall rule was simply written for a subnet that no longer exists -- nobody attacked the connection, somebody just never updated a rule for a network that changed.', 25, 2);
