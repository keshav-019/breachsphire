-- Atlas Division pathway ("The Silence"): World row for Act 2, "The
-- Network Beneath", still under act-atlas-1 ("World I -- The Basement",
-- which the bible states spans Acts 1-3: Linux, Networking, Servers) --
-- no new Arc row needed. Content (missions) follows in its own
-- migration.
--
-- Narrative thread: Act 1 closed with all three causes of the silence
-- resolved (the shared expired certificate, the growing disk, the
-- correctly-killed process). One connection still refuses to complete --
-- Atlas Division's own monitoring dashboard cannot reach a metrics
-- collector that came online only days ago -- proving the story was
-- never fully finished at the Linux-host layer. Tomas Vey, Cloud
-- Architect, makes his speaking debut here, exactly matching his
-- doc-stated specialty (networking, cloud, Terraform, global
-- architecture).

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-the-network-beneath', 'act-atlas-1', 1, 'the-network-beneath', 'The Network Beneath', 'The Network Beneath',
   'Packets; IP and CIDR; subnets; routing; NAT; DNS; TCP failure modes; TLS; proxies; reverse proxies; firewalls and security groups.',
   'Every certificate is renewed, every disk is cleared, every stuck process is gone -- and one specific connection still refuses to complete. Atlas Division''s own monitoring dashboard cannot reach a metrics collector that came online only days ago.',
   'Route to Nowhere',
   'DNS resolves correctly. The collector''s port is open and listening. The firewall rule denying the traffic is not new and not malicious -- it was written for the subnet CIDR that existed before Atlas Division''s own resubnetting, and the new collector''s address falls just outside it. Nobody attacked the connection. Somebody just never updated a rule for a network that no longer exists.',
   'One connection, understood completely, end to end. The next question is what happens when the servers on either end of connections like this one are themselves the problem.',
   'Route to Nowhere', 'Network', 'elevated', 20, 12, 'pathway-atlas');
