-- Backend Engineering ("The Fracture") -- fix stale Arc-number references.
-- Acts 19-25's mission/campaign content was authored before the Act
-- renumbering in 20260810320000, which repurposed act-be-4 from
-- "Arc IV -- Protect & Prove" to "Arc IV -- Stream" and act-be-5 from
-- "Arc V -- Scale" to "Arc V -- Protect & Prove", and added act-be-6
-- (Arc VI -- Scale) and act-be-7 (Arc VII -- Operate). The narrative text
-- below was written under the old numbering and still referenced the
-- pre-renumbering Arc labels; this migration brings it in line with the
-- corrected structure. No id/index/act_id changes here -- text only.

update public.campaigns set
  description = 'An external security review finds ordinary security debt on a public API -- unvalidated input, permissive CORS, no rate limiting. Arc V opens with fixing it, and with a discovery in the server logs that Mira can''t stop thinking about.'
where id = 'campaign-be19';

update public.missions set
  description = 'Arc V opens with a question Forge has never had to ask out loud: not "does this work," but "what happens if someone tries to make it fail on purpose." A routine external security review is about to answer for us if we don''t ask first.'
where id = 'mission-be19-01';

update public.dialogue_lines set
  text = 'Arc IV proved every piece works in isolation. Arc V asks whether any of it survives contact with real conditions -- starting with a question we''ve mostly skipped: what happens when someone tries to make this fail on purpose, not by accident.'
where mission_id = 'mission-be19-01' and sort_order = 1 and character_id = 'mira';

update public.dialogue_lines set
  text = 'Arc V keeps testing whether what Forge built survives real conditions. This time it isn''t an attacker -- it''s a resident trying to upload a twenty-gigabyte encrypted case archive to the public records portal, and it fails at ninety-four percent, every attempt, with nothing useful in the logs.'
where mission_id = 'mission-be20-01' and sort_order = 1 and character_id = 'mira';

update public.dialogue_lines set
  text = 'Then that''s next. Arc VI starts exactly there.'
where mission_id = 'mission-be21-12' and sort_order = 13 and character_id = 'mira';

update public.campaigns set
  description = 'Leadership just asked a question Forge could not yet answer: how would anyone know something started going wrong, not after a citizen complains, but before. This Act builds the eyes -- logs, metrics, traces, dashboards, alerts and error budgets -- and opens Arc VII by finally pointing all of it at the pattern it has been tracking since Act 2.'
where id = 'campaign-be25';

update public.dialogue_lines set
  text = 'Then we look at it, on purpose, from now on. Arc VII begins here -- Forge can finally watch itself instead of finding out sideways. What comes next has to survive that scale for real: deployment, the cloud it actually runs on, the containers it ships in. That is where we start.'
where mission_id = 'mission-be25-12' and sort_order = 12 and character_id = 'mira';
