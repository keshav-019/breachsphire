-- Atlas Division pathway ("The Silence"): World row for Act 11,
-- "Identity Plane", still under act-atlas-4 ("World IV -- Cloudreach",
-- which spans Acts 10-13: The Cloud Opens, Identity Plane, AWS Sector,
-- Serverless Frontier) -- no new Act row needed. Content (missions)
-- follows in its own migration.
--
-- Narrative thread: with atlas-eu-west finally reachable, Cross runs
-- the quarterly IAM audit across the newly-doubled infrastructure --
-- and finds that the service identity created to unblock the Act 10
-- region buildout was given full account-wide access, marked
-- TEMPORARY, and never scoped down, rotated, or migrated into the
-- secrets manager since. Same pattern as Act 3's unresized image and
-- Act 6's leaked token: a reasonable shortcut under time pressure,
-- never revisited once the pressure passed.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-identity-plane', 'act-atlas-4', 10, 'identity-plane', 'Identity Plane', 'Identity Plane',
   'Principals; users versus roles; policies; least privilege; service identities; temporary credentials; secrets managers; KMS concepts; rotation; workload identity; audit.',
   'With atlas-eu-west finally reachable, Cross runs the quarterly IAM audit across the now-doubled infrastructure -- routine, until one finding stands out: a service identity with full account-wide access, a static credential that has never once rotated, and no record in the secrets manager at all.',
   'The Master Key',
   'The identity was created honestly, under real time pressure, to unblock the Act 10 region buildout -- and marked TEMPORARY at the time, exactly as intended. Nobody ever came back to scope it down. Months later, one static, unrotated, full-account-scope credential has quietly been sitting there the entire time -- not attacked, not stolen, just never finished.',
   'Every identity in Atlas Division now has exactly the access it actually needs, temporarily, and nothing standing. The next question is what this same infrastructure looks like once it is built on one specific provider''s real services, not just the concepts underneath them.',
   'The Master Key', 'KeyRound', 'guarded', 68, 20, 'pathway-atlas');
