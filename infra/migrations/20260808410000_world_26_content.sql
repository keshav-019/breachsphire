-- world-26 ("OSINT & Reconnaissance: Open Secrets") mission content,
-- generated from docs/12-world-story-bible.md. Uses the terminal engine's
-- whois/dig commands (apps/web/src/lib/terminal/) for the DNS-flavored
-- missions. Mission 1 is cross-world-gated on world-25's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-26a', 'world-26', 'open-secrets', '26A - Open Secrets', 'Given only a company name, reconstruct its exposed footprint without sending a single intrusive packet.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-26a-1', 'campaign-26a', 'foundations', 'Foundations', 'WHOIS, DNS, certificate transparency and metadata, learned as passive intelligence collection.', 1),
  ('operation-26a-2', 'campaign-26a', 'investigation', 'Investigation', 'Search the public repository and build a verified footprint, start to finish.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w26-01', 'world-26', 'campaign-26a', 'operation-26a-1', 'one-input', 'One Input', 'Luna gave us one thing: a company name. Find out what an outsider could already know before we ever send a single packet.', 'intro', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w25-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w26-02', 'world-26', 'campaign-26a', 'operation-26a-1', 'whois-and-dns', 'WHOIS and DNS', 'WHOIS tells you who registered a domain and when. DNS tells you what it actually points to right now. Neither requires touching the target.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w26-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"whois-dns-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w26-03', 'world-26', 'campaign-26a', 'operation-26a-1', 'certificates-remember', 'Certificates Remember', 'Certificate transparency logs record every certificate ever issued for a domain, forever. Old subdomains nobody remembers still show up.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w26-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"cert-transparency-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w26-04', 'world-26', 'campaign-26a', 'operation-26a-2', 'what-documents-leak', 'What Documents Leak', 'Documents leak more than their content. Author names, software versions, internal paths -- all sitting quietly in metadata nobody checks.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w26-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"metadata-inspection-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w26-05', 'world-26', 'campaign-26a', 'operation-26a-2', 'reading-a-repository', 'Reading a Repository', 'A public code repository is a gift, if you know how to read it. Comments and hardcoded values are visible to everyone, whether developers remember that or not.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w26-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"repo-review-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w26-06', 'world-26', 'campaign-26a', 'operation-26a-2', 'shadow-map-boss', 'Shadow Map', 'Search the repository thoroughly. Somewhere in there is the most consequential thing we''ll find in this whole exercise.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w26-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"shadow-map-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["shadow-map"],"skillXp":{"pentesting":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w26-01', 1, 'zayn', 'Luna gave us one input: a company name. SkyPort Logistics. No IPs, no hostnames, nothing else. Find out what an outsider could learn before we ever send a single packet at them.'),
  ('mission-w26-01', 2, 'byte', 'That''s the whole point of this exercise. Real attackers do this too, and it''s completely passive -- nothing here touches their systems directly.'),
  ('mission-w26-01', 3, 'zayn', 'WHOIS, DNS, certificate transparency, public repositories, leaked metadata. All public. All fair game. All revealing.'),
  ('mission-w26-01', 4, 'byte', 'Let''s build the map.'),
  ('mission-w26-02', 1, 'byte', 'WHOIS tells you who registered a domain and when. DNS tells you what that domain actually points to right now. Neither one requires touching the target at all.'),
  ('mission-w26-03', 1, 'zayn', 'Certificate transparency logs record every certificate ever issued for a domain, forever. Old subdomains nobody remembers still show up in that history.'),
  ('mission-w26-04', 1, 'byte', 'Documents leak more than their content. Author names, software versions, internal file paths -- all sitting quietly in the metadata nobody checks.'),
  ('mission-w26-05', 1, 'zayn', 'A public code repository is a gift, if you know how to read it. Comments, hardcoded values, leftover references -- developers forget these are visible to everyone.'),
  ('mission-w26-06', 1, 'zayn', 'Search that repository thoroughly. Somewhere in there is the most consequential thing we''ll find in this whole exercise.'),
  ('mission-w26-06', 2, 'byte', '...Found something. A comment, deep in a config file, mostly redacted. "SENTINEL compatibility mode" -- everything else blacked out.'),
  ('mission-w26-06', 3, 'zayn', 'SENTINEL. Again. Sitting in a public repository the whole time, for anyone who knew to look.'),
  ('mission-w26-06', 4, 'byte', 'This changes the shape of the map. It''s not just "what does SkyPort Logistics expose." It''s "what does SkyPort Logistics expose that ties directly back to Project SENTINEL."'),
  ('mission-w26-06', 5, 'zayn', 'That''s the most consequential relationship in this entire footprint. Everything else is just infrastructure. This is the thread.'),
  ('mission-w26-06', 6, 'zayn', 'This map gives us a list of live systems. Time to actually scan them and find out what''s really running.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w26-01-o1', 'mission-w26-01', 1, 'Acknowledge the briefing', 'Confirm you''re ready to collect intelligence without touching a single target.'),
  ('mission-w26-02-o1', 'mission-w26-02', 1, 'Query WHOIS and DNS', 'Find the company''s mail server hostname using whois and dig.'),
  ('mission-w26-03-o1', 'mission-w26-03', 1, 'Find the forgotten subdomain', 'Identify the subdomain that matters most for attack-surface mapping.'),
  ('mission-w26-04-o1', 'mission-w26-04', 1, 'Spot the metadata leak', 'Identify which document''s metadata leaks internal infrastructure details.'),
  ('mission-w26-05-o1', 'mission-w26-05', 1, 'Find the internal hostname', 'Search the mirrored repository for an internal hostname that shouldn''t be public.'),
  ('mission-w26-06-o1', 'mission-w26-06', 1, 'Find the redacted reference', 'Search the repository thoroughly and submit the redacted comment you find.'),
  ('mission-w26-06-o2', 'mission-w26-06', 2, 'Identify the most consequential finding', 'Choose the single most consequential exposed relationship in this footprint.'),
  ('mission-w26-06-o3', 'mission-w26-06', 3, 'Confirm the shadow map', 'Confirm the redacted reference and its significance together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w26-01-o1-c1', 'mission-w26-01-o1', 1, 'story_dialogue', 'Confirm you''re ready to continue.', '{"lines":[{"characterId":"zayn","text":"One company name, nothing else. Ready to see what''s already public?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w26-02-o1-c1', 'mission-w26-02-o1', 1, 'terminal_simulation', 'Run whois and dig against the company''s domain, and submit the mail server hostname you find.', '{"instructions":"Start with the basics. Run whois and dig against skyport-logistics.example. Submit the mail server hostname you find in its DNS records.","hostname":"recon-ws01","user":"recruit","whoisRecords":[{"domain":"skyport-logistics.example","lines":["Registrant Organization: SkyPort Logistics Inc.","Registered: 2011-04-02","Registrar: Example Registrar LLC","Name Servers: ns1.skyport-logistics.example, ns2.skyport-logistics.example"]}],"dnsRecords":[{"domain":"skyport-logistics.example","records":[{"type":"A","value":"203.0.113.10"},{"type":"MX","value":"mail.skyport-logistics.example"},{"type":"TXT","value":"v=spf1 include:_spf.example.com ~all"}]}]}'::jsonb, '{"requiredFlag":"mail.skyport-logistics.example"}'::jsonb),

  ('mission-w26-03-o1-c1', 'mission-w26-03-o1', 1, 'investigation', 'Which subdomain is the kind of forgotten, unmaintained system that matters most for attack-surface mapping?', '{"evidence":[{"id":"c1","label":"admin.skyport-logistics.example","detail":"Certificate issued 3 weeks ago, currently active"},{"id":"c2","label":"shop.skyport-logistics.example","detail":"Certificate issued 6 months ago, currently active -- standard e-commerce storefront"},{"id":"c3","label":"mnt-relay-legacy.skyport-logistics.example","detail":"Certificate issued four years ago, never renewed since -- no longer resolves in current DNS but still appears in certificate transparency history"},{"id":"c4","label":"www.skyport-logistics.example","detail":"Certificate issued last month, currently active -- standard marketing site"}],"question":"Which subdomain is the kind of forgotten, unmaintained system that matters most for attack-surface mapping?"}'::jsonb, '{"requiredEvidenceIds":["c3"]}'::jsonb),

  ('mission-w26-04-o1-c1', 'mission-w26-04-o1', 1, 'investigation', 'Which document''s metadata leaks internal infrastructure details?', '{"evidence":[{"id":"m1","label":"Public PDF: \"SkyPort Logistics Q3 Facilities Report\"","detail":"Document metadata -- Author: j.reyes, Producer: Internal-Reporting-Tool v2.3.1 (build: mnt-ctl-image), Created on host: skyport-mnt07"},{"id":"m2","label":"Public marketing brochure PDF","detail":"Document metadata -- Author: Marketing Dept, Producer: Adobe Acrobat, no internal references"}],"question":"Which document''s metadata leaks internal infrastructure details?"}'::jsonb, '{"requiredEvidenceIds":["m1"]}'::jsonb),

  ('mission-w26-05-o1-c1', 'mission-w26-05-o1', 1, 'terminal_simulation', 'Search this mirrored public repository for an internal hostname that shouldn''t be visible outside the company.', '{"instructions":"Search this mirrored public repository for any internal hostnames that shouldn''t be visible outside the company.","hostname":"recon-ws01","user":"recruit","filesystem":{"/home/recruit/repo-mirror/README.md":{"type":"file","content":"SkyPort Logistics -- internal tooling monorepo (public mirror, sanitized)\n"},"/home/recruit/repo-mirror/services/telemetry-sync/config.example.yaml":{"type":"file","content":"# example config, real values injected at deploy time\nservice: telemetry-sync\nendpoint: https://internal.skyport-logistics.example/api/v1/telemetry\n"},"/home/recruit/repo-mirror/services/telemetry-sync/README.md":{"type":"file","content":"Telemetry sync agent. See ops runbook for the internal endpoint host.\n"},"/home/recruit/repo-mirror/scripts/deploy.sh":{"type":"file","content":"#!/bin/sh\n# deploys to internal.skyport-logistics.example -- do not point this at prod directly\n"}}}'::jsonb, '{"requiredFlag":"internal.skyport-logistics.example"}'::jsonb),

  ('mission-w26-06-o1-c1', 'mission-w26-06-o1', 1, 'terminal_simulation', 'Search the entire repository, not just the obvious service, and submit the redacted comment you find.', '{"instructions":"Search the entire repository, not just the obvious service. Somewhere in here is the most consequential thing you''ll find in this exercise.","hostname":"recon-ws01","user":"recruit","filesystem":{"/home/recruit/repo-mirror/services/telemetry-sync/config.example.yaml":{"type":"file","content":"# example config, real values injected at deploy time\nservice: telemetry-sync\nendpoint: https://internal.skyport-logistics.example/api/v1/telemetry\n"},"/home/recruit/repo-mirror/services/legacy-bridge/notes.md":{"type":"file","content":"# legacy-bridge\n\nDeprecated. Left running for backward compatibility.\n\n<!-- SENTINEL compatibility mode: [REDACTED] -->\n"}}}'::jsonb, '{"requiredFlag":"SENTINEL compatibility mode"}'::jsonb),

  ('mission-w26-06-o2-c1', 'mission-w26-06-o2', 1, 'multiple_choice', 'Which exposed relationship is the most consequential finding from this footprint?', '{"question":"Which exposed relationship is the most consequential finding from this footprint?","options":[{"id":"a","text":"The marketing site''s certificate renewal date"},{"id":"b","text":"The redacted \"SENTINEL compatibility mode\" reference in the legacy-bridge repository, tying this company''s public exposure directly to Project SENTINEL"},{"id":"c","text":"The Q3 facilities report being publicly downloadable"},{"id":"d","text":"The shop subdomain running standard e-commerce software"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w26-06-o3-c1', 'mission-w26-06-o3', 1, 'boss_encounter', 'Confirm the redacted reference and its significance together.', '{"stages":[{"objectiveRef":"mission-w26-06-o1","label":"The redacted reference"},{"objectiveRef":"mission-w26-06-o2","label":"Its significance"}],"task":"Confirm the redacted reference and its significance together."}'::jsonb, '{"requiredObjectiveIds":["mission-w26-06-o1","mission-w26-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w26-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''re ready to continue.', 0, 1),

  ('mission-w26-02-o1-c1', 'orientation', 'whois tells you about the domain registration. dig tells you about its actual DNS records.', 10, 1),
  ('mission-w26-02-o1-c1', 'tool_direction', 'Try whois skyport-logistics.example, then dig skyport-logistics.example.', 20, 2),
  ('mission-w26-02-o1-c1', 'solution', 'dig skyport-logistics.example shows an MX record pointing to mail.skyport-logistics.example. Submit mail.skyport-logistics.example.', 30, 3),

  ('mission-w26-03-o1-c1', 'orientation', 'Three of these four subdomains are actively maintained, recently issued certificates.', 15, 1),
  ('mission-w26-03-o1-c1', 'concept', 'A certificate that stopped renewing years ago but still appears in transparency history usually means the system behind it was forgotten, not decommissioned properly.', 25, 2),
  ('mission-w26-03-o1-c1', 'solution', 'mnt-relay-legacy (c3) hasn''t been renewed in four years and no longer resolves -- a forgotten system is exactly the kind of thing attack-surface mapping needs to catch.', 35, 3),

  ('mission-w26-04-o1-c1', 'orientation', 'Compare the Producer and Author fields between the two documents.', 10, 1),
  ('mission-w26-04-o1-c1', 'solution', 'The facilities report''s metadata (m1) names an internal build tool and a real internal hostname -- the marketing brochure (m2) has nothing internal in it at all.', 20, 2),

  ('mission-w26-05-o1-c1', 'orientation', 'Config files and deploy scripts are common places for hardcoded internal values to leak.', 15, 1),
  ('mission-w26-05-o1-c1', 'tool_direction', 'Try grep -r "internal" across the whole repo-mirror directory.', 25, 2),
  ('mission-w26-05-o1-c1', 'solution', 'Both the example config and the deploy script reference internal.skyport-logistics.example directly. Submit internal.skyport-logistics.example.', 35, 3),

  ('mission-w26-06-o1-c1', 'orientation', 'The obvious service (telemetry-sync) isn''t where this one is hiding.', 15, 1),
  ('mission-w26-06-o1-c1', 'concept', 'Deprecated, "kept for backward compatibility" services are exactly where forgotten references tend to survive.', 25, 2),
  ('mission-w26-06-o1-c1', 'tool_direction', 'Check the legacy-bridge service specifically, and read its notes file in full.', 35, 3),
  ('mission-w26-06-o1-c1', 'solution', 'legacy-bridge/notes.md contains a redacted HTML comment reading "SENTINEL compatibility mode: [REDACTED]". Submit SENTINEL compatibility mode.', 45, 4),

  ('mission-w26-06-o2-c1', 'orientation', 'Weigh routine exposure against exposure that connects directly to the larger investigation.', 15, 1),
  ('mission-w26-06-o2-c1', 'solution', 'The SENTINEL reference is the one finding that ties this company''s public footprint directly into the ongoing investigation -- everything else is routine infrastructure exposure. Option b.', 25, 2),

  ('mission-w26-06-o3-c1', 'orientation', 'You''ve already found both halves -- combine the reference with why it matters.', 20, 1),
  ('mission-w26-06-o3-c1', 'concept', 'The closure needs to state exactly what was found and why it outweighs everything else in the footprint.', 30, 2),
  ('mission-w26-06-o3-c1', 'tool_direction', 'State the redacted comment first, then its connection to Project SENTINEL.', 40, 3),
  ('mission-w26-06-o3-c1', 'near_solution', '"SENTINEL compatibility mode," redacted, buried in a deprecated service''s notes file -- the most consequential finding in the entire footprint.', 50, 4),
  ('mission-w26-06-o3-c1', 'solution', 'A redacted comment reading "SENTINEL compatibility mode" sits inside the deprecated legacy-bridge service''s public documentation -- the single finding in this entire footprint that ties SkyPort Logistics directly to Project SENTINEL, outweighing every routine infrastructure exposure found elsewhere.', 60, 5);
