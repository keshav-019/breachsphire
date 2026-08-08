-- world-15 ("Programming for Security: Automate or Die") mission content,
-- generated from docs/12-world-story-bible.md. Zayn teaches Python as an
-- operational necessity -- reading and fixing broken scripts, parsing JSON,
-- matching indicator patterns with regex, and assembling the pieces of a
-- working CLI tool -- rather than as classroom exercises. Mission 1 is
-- cross-world-gated on world-14's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-15a', 'world-15', 'automate-or-die', '15A - Automate or Die', 'Guardian analysts are drowning in thousands of near-identical artifacts from the spreading incident. Python turns repetitive analysis into a force multiplier.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-15a-1', 'campaign-15a', 'foundations', 'Foundations', 'Reading, fixing and running small Python scripts as investigative tools, not classroom exercises.', 1),
  ('operation-15a-2', 'campaign-15a', 'investigation', 'Investigation', 'JSON, regex and HTTP as the connective tissue of a working indicator-extraction tool.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w15-01', 'world-15', 'campaign-15a', 'operation-15a-1', 'automate-or-die', 'Automate or Die', 'Cipher''s checksum is still an open question, but thousands of near-identical PowerShell artifacts do not have hours to spare. Zayn hands you Python.', 'intro', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w14-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w15-02', 'world-15', 'campaign-15a', 'operation-15a-1', 'broken-script-repair', 'Broken Script Repair', 'A script meant to count alerts per host will not even run. Read it like evidence, not like homework.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w15-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"python-syntax-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w15-03', 'world-15', 'campaign-15a', 'operation-15a-1', 'parse-the-bundle', 'Parse the Bundle', 'The evidence bundle arrives as JSON. Pull the right values out without guessing at the structure.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w15-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"python-json-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 3),
  ('mission-w15-04', 'world-15', 'campaign-15a', 'operation-15a-2', 'pattern-match', 'Pattern Match', 'SX indicators follow a pattern. A regular expression either matches all of it, or quietly misses half.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w15-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"python-regex-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 4),
  ('mission-w15-05', 'world-15', 'campaign-15a', 'operation-15a-2', 'build-the-tool', 'Build the Tool', 'Requests, sockets, arguments, JSON -- put the right piece in the right place and the tool actually runs.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w15-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"python-cli-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 5),
  ('mission-w15-06', 'world-15', 'campaign-15a', 'operation-15a-2', 'signal-harvester-boss', 'Signal Harvester', 'Build the tool, run it against the full bundle, and find out what the indicators are actually pointing at.', 'boss', ARRAY['zayn', 'byte'], '{"requiredMissionIds":["mission-w15-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"signal-harvester-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["signal-harvester"],"skillXp":{"programming":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w15-01', 1, 'zayn', 'Cipher''s checksum still matches the retired SENTINEL project, and that is still an open question. But right now we have thousands of near-identical PowerShell artifacts piling up faster than any analyst can read them by hand.'),
  ('mission-w15-01', 2, 'zayn', 'That is not a training problem, it is a workflow problem. You are going to learn Python -- not because it looks good on a resume, but because it is the only way we keep up with this incident.'),
  ('mission-w15-01', 3, 'byte', 'Every script you write here does something a human was doing manually five minutes ago. Force multiplier, not a coding exercise.'),
  ('mission-w15-01', 4, 'zayn', 'Ready to stop reading logs one line at a time?'),
  ('mission-w15-02', 1, 'zayn', 'This script is supposed to count ALERT lines per host. It does not run at all. Read it like evidence -- find what breaks before you fix anything.'),
  ('mission-w15-03', 1, 'zayn', 'The evidence bundle comes back as JSON now, not plain text. Pull the indicator values out without assuming the shape of the file.'),
  ('mission-w15-04', 1, 'zayn', 'SX indicators follow a fixed pattern. A regex that is almost right will quietly drop half of them, and you will never know it happened.'),
  ('mission-w15-05', 1, 'zayn', 'A working tool is not one clever line. It is arguments, a request, maybe a raw socket, and something to parse what comes back -- each piece doing exactly one job.'),
  ('mission-w15-06', 1, 'zayn', 'Signal Harvester needs to pull every SX indicator out of this bundle. Build it, run it, and tell me what comes back.'),
  ('mission-w15-06', 2, 'zayn', 'Undercounting. Whatever it missed, find it before we report a number to Luna.'),
  ('mission-w15-06', 3, 'byte', 'Fixed pattern is pulling in indicators the first pass never touched -- hex characters, not just digits.'),
  ('mission-w15-06', 4, 'zayn', 'Look at what is left. The same handful of infrastructure keeps reappearing under these indicators, but the registration details change every single time we check.'),
  ('mission-w15-06', 5, 'byte', 'It is reconfiguring faster than any of us can track it by hand. Sometimes it is a matter of hours.'),
  ('mission-w15-06', 6, 'zayn', 'Then we stop chasing it one query at a time. We need something that watches continuously -- shell-level automation, scheduled collection, real data transformation. Python got us this far. Now we go lower and faster.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w15-01-o1', 'mission-w15-01', 1, 'Acknowledge the briefing', 'Confirm you are ready to treat scripts as tools, not exercises.'),
  ('mission-w15-02-o1', 'mission-w15-02', 1, 'Find the broken line', 'Identify the line that stops this script from running at all.'),
  ('mission-w15-03-o1', 'mission-w15-03', 1, 'Extract every indicator value', 'Pick the code that correctly pulls every indicator value out of the bundle.'),
  ('mission-w15-04-o1', 'mission-w15-04', 1, 'Pick the matching pattern', 'Choose the regular expression that matches every SX indicator in this format.'),
  ('mission-w15-05-o1', 'mission-w15-05', 1, 'Assemble the tool', 'Match each code fragment to the job it actually does.'),
  ('mission-w15-06-o1', 'mission-w15-06', 1, 'Find the undercount bug', 'Identify why Signal Harvester is missing indicators in the evidence bundle.'),
  ('mission-w15-06-o2', 'mission-w15-06', 2, 'Pick the corrected pattern', 'Choose the regex that recovers every indicator, including the ones the first pass missed.'),
  ('mission-w15-06-o3', 'mission-w15-06', 3, 'Confirm the fix', 'Confirm the bug and the corrected pattern together as the finished tool.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w15-01-o1-c1', 'mission-w15-01-o1', 1, 'story_dialogue', 'Confirm you are ready to continue.', '{"lines":[{"characterId":"zayn","text":"Manual analysis cannot keep up with this incident. Ready to start writing tools instead of reading logs by hand?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w15-02-o1-c1', 'mission-w15-02-o1', 1, 'investigation', 'Which line causes Python to raise a SyntaxError before this script can even run?', '{"evidence":[{"id":"ev1","label":"def count_alerts(path):","detail":"Function definition -- opens the file argument for processing"},{"id":"ev2","label":"with open(path) as f:","detail":"Context manager opens the file safely and closes it automatically when the block ends"},{"id":"ev3","label":"host = line.split()[0]","detail":"Splits each line on whitespace and takes the first token as the hostname"},{"id":"ev4","label":"if \"ALERT\" in line","detail":"Checks whether the literal text ALERT appears anywhere in the line -- notice what is missing at the end of this line"},{"id":"ev5","label":"counts[host] = counts.get(host, 0) + 1","detail":"Increments the per-host counter, defaulting to zero the first time a host is seen"}],"question":"Which line causes Python to raise a SyntaxError before this script can even run?"}'::jsonb, '{"requiredEvidenceIds":["ev4"]}'::jsonb),

  ('mission-w15-03-o1-c1', 'mission-w15-03-o1', 1, 'multiple_choice', 'Which snippet correctly extracts the value of every indicator, regardless of type?', '{"question":"A JSON evidence bundle looks like: {\"host\": \"mnt07\", \"indicators\": [{\"type\": \"domain\", \"value\": \"sx-relay.example\"}, {\"type\": \"hash\", \"value\": \"9f8a1c2b\"}]}. Which snippet correctly extracts the value of every indicator, regardless of type?","options":[{"id":"a","text":"data[\"value\"]"},{"id":"b","text":"[item[\"value\"] for item in data[\"indicators\"]]"},{"id":"c","text":"data.indicators.value"},{"id":"d","text":"json.dumps(data[\"indicators\"][\"value\"])"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w15-04-o1-c1', 'mission-w15-04-o1', 1, 'multiple_choice', 'Which regular expression matches every indicator in that exact format?', '{"question":"SX indicators are written as SX- followed by four hex characters, a hyphen, then four more hex characters, for example SX-7f3a-92c1. Which regular expression matches every indicator in that exact format?","options":[{"id":"a","text":"SX-.*"},{"id":"b","text":"SX-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}"},{"id":"c","text":"SX-[0-9]{4}-[0-9]{4}"},{"id":"d","text":"SX\\d{4}\\d{4}"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w15-05-o1-c1', 'mission-w15-05-o1', 1, 'drag_and_drop', 'Match each code fragment to the job it actually does.', '{"items":[{"id":"d1","text":"argparse.ArgumentParser().parse_args()"},{"id":"d2","text":"requests.get(url, timeout=5)"},{"id":"d3","text":"socket.create_connection((host, port))"},{"id":"d4","text":"json.loads(response.text)"}],"targets":[{"id":"cliargs","label":"Parse command-line arguments"},{"id":"http","label":"Make an HTTP request"},{"id":"socket","label":"Open a raw TCP connection"},{"id":"jsonparse","label":"Parse a JSON response body"}]}'::jsonb, '{"correctMapping":{"d1":"cliargs","d2":"http","d3":"socket","d4":"jsonparse"}}'::jsonb),

  ('mission-w15-06-o1-c1', 'mission-w15-06-o1', 1, 'investigation', 'Which pieces of evidence together explain why Signal Harvester is under-counting indicators in this bundle?', '{"evidence":[{"id":"ev1","label":"pattern = r\"SX-[0-9]{4}-[0-9]{4}\"","detail":"Only matches indicators built entirely from decimal digits"},{"id":"ev2","label":"SX-7f3a-92c1 (present in the evidence bundle)","detail":"Contains hex letters a through f -- this indicator will not match the pattern above"},{"id":"ev3","label":"SX-4471-5518 (present in the evidence bundle)","detail":"Built entirely from decimal digits -- this indicator matches the pattern above without any trouble"},{"id":"ev4","label":"matches = re.findall(pattern, text)","detail":"Collects every substring in text that matches pattern, nothing more and nothing less"}],"question":"Which pieces of evidence together explain why Signal Harvester is under-counting indicators in this bundle?"}'::jsonb, '{"requiredEvidenceIds":["ev1","ev2"]}'::jsonb),

  ('mission-w15-06-o2-c1', 'mission-w15-06-o2', 1, 'multiple_choice', 'Which corrected pattern captures every SX indicator in the bundle, including ones built from hex letters?', '{"question":"Which corrected pattern captures every SX indicator in the bundle, including ones built from hex letters?","options":[{"id":"a","text":"SX-[0-9]{4}-[0-9]{4}"},{"id":"b","text":"SX-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}"},{"id":"c","text":"SX-.{4}-.{4}"},{"id":"d","text":"SX_[0-9a-f]{4}_[0-9a-f]{4}"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-w15-06-o3-c1', 'mission-w15-06-o3', 1, 'boss_encounter', 'Confirm the bug and the fix that lets Signal Harvester recover every SX indicator in the bundle.', '{"stages":[{"objectiveRef":"mission-w15-06-o1","label":"The undercount bug"},{"objectiveRef":"mission-w15-06-o2","label":"The corrected pattern"}],"task":"Confirm the bug and the fix that lets Signal Harvester recover every SX indicator in the bundle."}'::jsonb, '{"requiredObjectiveIds":["mission-w15-06-o1","mission-w15-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w15-01-o1-c1', 'orientation', 'There is nothing to solve here -- just confirm you are ready to continue.', 0, 1),

  ('mission-w15-02-o1-c1', 'orientation', 'Four of these five lines are completely ordinary Python -- one of them is missing something Python requires.', 15, 1),
  ('mission-w15-02-o1-c1', 'concept', 'Every if, for, while, def and with statement in Python needs a colon at the end of its header line.', 25, 2),
  ('mission-w15-02-o1-c1', 'tool_direction', 'Read each line as if you were the Python interpreter, checking syntax before anything actually executes.', 35, 3),
  ('mission-w15-02-o1-c1', 'solution', 'The if "ALERT" in line line is missing its trailing colon -- Python raises a SyntaxError there before the script ever runs, regardless of what the rest of the logic does.', 45, 4),

  ('mission-w15-03-o1-c1', 'orientation', 'The top-level object only has one key besides host -- everything else is nested one level deeper.', 10, 1),
  ('mission-w15-03-o1-c1', 'concept', 'indicators is a list of objects, so you need to loop over it (or use a list comprehension) to pull one field out of every entry.', 20, 2),
  ('mission-w15-03-o1-c1', 'solution', '[item["value"] for item in data["indicators"]] loops over every entry in the list and pulls out its value -- the other options either grab the wrong key or use attribute access on a dict, which does not work.', 30, 3),

  ('mission-w15-04-o1-c1', 'orientation', 'Rule out the options that are either far too loose or use the wrong character class entirely.', 15, 1),
  ('mission-w15-04-o1-c1', 'concept', '[0-9a-fA-F] matches a single hex digit in either case; {4} repeats that exactly four times.', 25, 2),
  ('mission-w15-04-o1-c1', 'tool_direction', 'Test each option against SX-7f3a-92c1 specifically -- the letters in that example rule out anything restricted to plain digits.', 35, 3),
  ('mission-w15-04-o1-c1', 'solution', 'SX-[0-9a-fA-F]{4}-[0-9a-fA-F]{4} matches exactly the intended format including hex letters -- SX-.* is far too loose, and the digit-only and \\d options both miss letters a through f.', 45, 4),

  ('mission-w15-05-o1-c1', 'orientation', 'Each fragment does exactly one job -- match it to the library or module it comes from.', 10, 1),
  ('mission-w15-05-o1-c1', 'concept', 'argparse reads the command line, requests speaks HTTP, socket works at the raw TCP level, and json turns text into Python data.', 20, 2),
  ('mission-w15-05-o1-c1', 'solution', 'argparse parses arguments, requests.get makes the HTTP call, socket.create_connection opens a raw TCP connection, and json.loads parses the JSON response body.', 30, 3),

  ('mission-w15-06-o1-c1', 'orientation', 'Two of these four items are the pattern itself and one indicator it should have matched but did not.', 15, 1),
  ('mission-w15-06-o1-c1', 'concept', 'A character class like [0-9] only ever matches digits -- it will silently skip anything with a letter in it, no error raised.', 25, 2),
  ('mission-w15-06-o1-c1', 'tool_direction', 'Compare the pattern in ev1 directly against the two sample indicators in ev2 and ev3.', 35, 3),
  ('mission-w15-06-o1-c1', 'solution', 'ev1''s pattern only matches decimal digits, and ev2''s indicator (SX-7f3a-92c1) contains hex letters that pattern will never match -- that combination is exactly why the count comes in low. ev3 and ev4 are unaffected supporting context.', 45, 4),

  ('mission-w15-06-o2-c1', 'orientation', 'The fix needs to widen the character class without loosening the format itself.', 15, 1),
  ('mission-w15-06-o2-c1', 'concept', '[0-9a-fA-F] covers every hex digit in both cases without matching characters that are not part of a valid indicator.', 25, 2),
  ('mission-w15-06-o2-c1', 'solution', 'SX-[0-9a-fA-F]{4}-[0-9a-fA-F]{4} recovers every indicator including hex letters, without the false-positive risk of a wildcard like SX-.{4}-.{4}.', 35, 3),

  ('mission-w15-06-o3-c1', 'orientation', 'You already have both pieces -- the bug and the fix. Combine them.', 20, 1),
  ('mission-w15-06-o3-c1', 'concept', 'The finished report needs to state what was wrong and what replaced it.', 30, 2),
  ('mission-w15-06-o3-c1', 'tool_direction', 'State the narrow decimal-only pattern first, then the corrected hex-aware pattern that replaced it.', 40, 3),
  ('mission-w15-06-o3-c1', 'near_solution', 'The bug: a decimal-only character class. The fix: [0-9a-fA-F] in both groups.', 50, 4),
  ('mission-w15-06-o3-c1', 'solution', 'Signal Harvester under-counted because its pattern only matched decimal digits; replacing both character classes with [0-9a-fA-F] recovers every SX indicator in the bundle, hex letters included.', 65, 5);
