-- Backend Engineering ("The Fracture") Act 9 -- "Relational Data" content.
-- Opens Arc II ("Data"). 1 campaign, 2 operations, 12 missions.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-be9', 'world-be-9', 'relational-data', '9A - Relational Data', 'The civic registry has been quietly diverging from reality for months. Learn what a relational database actually promises, then find out where that promise broke.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-be9-1', 'campaign-be9', 'first-principles', 'First Principles', 'Why databases exist, PostgreSQL, tables, schemas, keys and constraints.', 1),
  ('operation-be9-2', 'campaign-be9', 'reading-and-writing', 'Reading and Writing', 'SELECT, INSERT, UPDATE, DELETE, joins -- then the registry itself.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-be9-01', 'world-be-9', 'campaign-be9', 'operation-be9-1', 'why-databases-exist', 'Why Databases Exist', 'Every backend eventually needs to remember something after the process restarts. That''s the entire reason a database exists.', 'beginner', ARRAY['mira'], null, null, '{"type":"simulation","simulationId":"why-databases-sim"}'::jsonb, '{"xp":140,"credits":25}'::jsonb, false, 1),
  ('mission-be9-02', 'world-be-9', 'campaign-be9', 'operation-be9-1', 'postgresql-introduction', 'PostgreSQL Introduction', 'A relational database stores data in tables of rows and columns, and gives you a real query language to ask questions of it.', 'beginner', ARRAY['forge'], '{"requiredMissionIds":["mission-be9-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"postgresql-intro-sim"}'::jsonb, '{"xp":145,"credits":25}'::jsonb, false, 2),
  ('mission-be9-03', 'world-be-9', 'campaign-be9', 'operation-be9-1', 'tables-and-schemas', 'Tables and Schemas', 'A schema is the shape: which tables exist, which columns each has, and what type each column holds. Get the shape wrong and every query inherits the mistake.', 'beginner', ARRAY['mira'], '{"requiredMissionIds":["mission-be9-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"tables-schemas-sim"}'::jsonb, '{"xp":145,"credits":25}'::jsonb, false, 3),
  ('mission-be9-04', 'world-be-9', 'campaign-be9', 'operation-be9-1', 'primary-keys', 'Primary Keys', 'Every table needs one column that uniquely identifies each row. No two rows can ever share one, and it can never be null.', 'beginner', ARRAY['forge'], '{"requiredMissionIds":["mission-be9-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"primary-keys-sim"}'::jsonb, '{"xp":150,"credits":28}'::jsonb, false, 4),
  ('mission-be9-05', 'world-be-9', 'campaign-be9', 'operation-be9-1', 'foreign-keys', 'Foreign Keys', 'A foreign key is how one table points at a specific row in another -- and a constraint the database enforces so that pointer can never dangle.', 'beginner', ARRAY['mira'], '{"requiredMissionIds":["mission-be9-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"foreign-keys-sim"}'::jsonb, '{"xp":150,"credits":28}'::jsonb, false, 5),
  ('mission-be9-06', 'world-be-9', 'campaign-be9', 'operation-be9-1', 'constraints', 'Constraints', 'NOT NULL, UNIQUE, CHECK -- each one is a rule the database enforces for you, so bad data never gets written in the first place.', 'beginner', ARRAY['forge'], '{"requiredMissionIds":["mission-be9-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"constraints-sim"}'::jsonb, '{"xp":155,"credits":28}'::jsonb, false, 6),
  ('mission-be9-07', 'world-be-9', 'campaign-be9', 'operation-be9-2', 'select', 'SELECT', 'SELECT is how you ask the database a question. Every clause narrows or shapes the answer.', 'intermediate', ARRAY['mira'], '{"requiredMissionIds":["mission-be9-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"select-sim"}'::jsonb, '{"xp":160,"credits":28}'::jsonb, false, 7),
  ('mission-be9-08', 'world-be-9', 'campaign-be9', 'operation-be9-2', 'insert', 'INSERT', 'Writing a new row: the columns you''re setting, and the values, in the same order. A NOT NULL column with no default and no value gets the whole insert refused.', 'intermediate', ARRAY['forge'], '{"requiredMissionIds":["mission-be9-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"insert-sim"}'::jsonb, '{"xp":160,"credits":28}'::jsonb, false, 8),
  ('mission-be9-09', 'world-be-9', 'campaign-be9', 'operation-be9-2', 'update', 'UPDATE', 'UPDATE changes existing rows. Always pair it with a WHERE clause specific enough to hit only what you mean.', 'intermediate', ARRAY['mira'], '{"requiredMissionIds":["mission-be9-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"update-sim"}'::jsonb, '{"xp":165,"credits":30}'::jsonb, false, 9),
  ('mission-be9-10', 'world-be-9', 'campaign-be9', 'operation-be9-2', 'delete', 'DELETE', 'The same danger as UPDATE, with a worse failure mode: no WHERE clause means every row in the table is gone, with no undo without a backup.', 'intermediate', ARRAY['forge'], '{"requiredMissionIds":["mission-be9-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"delete-sim"}'::jsonb, '{"xp":165,"credits":30}'::jsonb, false, 10),
  ('mission-be9-11', 'world-be-9', 'campaign-be9', 'operation-be9-2', 'joins', 'Joins', 'Real questions span tables. A JOIN combines rows from two tables based on a matching key -- get the join condition wrong and you get answers that look plausible and are completely wrong.', 'intermediate', ARRAY['mira'], '{"requiredMissionIds":["mission-be9-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"joins-sim"}'::jsonb, '{"xp":175,"credits":32}'::jsonb, false, 11),
  ('mission-be9-12', 'world-be-9', 'campaign-be9', 'operation-be9-2', 'the-civic-registry', 'The Civic Registry', 'Two rows, one real citizen, and a source-system tag that differs by exactly two invisible characters. Find the fix -- not just for these two rows, but for the rule that should have stopped it.', 'boss', ARRAY['mira','forge'], '{"requiredMissionIds":["mission-be9-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"civic-registry-boss-sim"}'::jsonb, '{"xp":440,"credits":95,"badgeIds":["civic-registry"],"skillXp":{"databases":30}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-be9-01', 1, 'mira', 'Data Systems. Different problem than what you''ve been solving. Every backend eventually needs to remember something after the process restarts -- that''s the entire reason a database exists.'),
  ('mission-be9-01', 2, 'mira', 'The city''s civic registry has been quietly diverging from reality for months. Before we fix it, you need to understand what a database actually promises that a plain file or an in-memory object never could.'),
  ('mission-be9-02', 1, 'forge', 'Forge Division runs PostgreSQL: a relational database that stores data in tables of rows and columns, and gives you a real query language to ask questions of it instead of writing loops.'),
  ('mission-be9-03', 1, 'mira', 'A schema is the shape: which tables exist, which columns each has, and what type each column holds. Get the shape wrong and every query built on top inherits the mistake.'),
  ('mission-be9-04', 1, 'forge', 'Every table needs one column, or set of columns, that uniquely identifies each row -- the primary key. No two rows can ever share one, and it can never be null.'),
  ('mission-be9-05', 1, 'mira', 'A foreign key is how one table points at a specific row in another -- an address row pointing back at the citizen_id it belongs to. It''s also a constraint: the database refuses to let that pointer dangle.'),
  ('mission-be9-06', 1, 'forge', 'Primary keys and foreign keys are both constraints. There are more: NOT NULL, UNIQUE, CHECK. Each one is a rule the database enforces for you, so bad data never gets written in the first place.'),
  ('mission-be9-07', 1, 'mira', 'Now we read. SELECT is how you ask the database a question. Every clause narrows or shapes the answer.'),
  ('mission-be9-08', 1, 'forge', 'Writing a new row: INSERT INTO, the columns you''re setting, and the values. Miss a NOT NULL column with no default and the database refuses the whole insert -- which is the constraint doing its job.'),
  ('mission-be9-09', 1, 'mira', 'UPDATE changes existing rows. Always pair it with a WHERE clause specific enough to hit only what you mean -- an UPDATE with no WHERE touches every row in the table.'),
  ('mission-be9-10', 1, 'forge', 'DELETE has the exact same danger as UPDATE, with a worse failure mode: no WHERE clause means every row in the table is gone, and there''s no undo without a backup.'),
  ('mission-be9-11', 1, 'mira', 'Real questions span tables. A JOIN combines rows from two tables based on a matching key -- citizens to their addresses, orders to their line items. Get the join condition wrong and you get answers that look plausible and are completely wrong.'),
  ('mission-be9-12', 1, 'mira', 'The civic registry problem, for real this time. Two rows, same person, and nobody can agree which one is the truth.'),
  ('mission-be9-12', 2, 'forge', 'I pulled both records. Identical except one field -- a source-system tag. One says "field-office", the other says "field-office//". The trailing pair is invisible in every report anyone''s actually looked at.'),
  ('mission-be9-12', 3, 'forge', 'There''s a unique constraint on national_id. It didn''t catch this because the two rows have different national_id values too -- someone re-typed it wrong on the second entry. The tag drift is just the piece nobody''s explained yet.'),
  ('mission-be9-12', 4, 'mira', 'Find the fix. Not just for these two rows -- the rule that should have stopped this from ever landing in the table.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-be9-01-o1', 'mission-be9-01', 1, 'Find what breaks', 'Identify what happens to in-memory-only data when the process restarts.'),
  ('mission-be9-02-o1', 'mission-be9-02', 1, 'Define relational', 'Explain what actually makes a database relational.'),
  ('mission-be9-03-o1', 'mission-be9-03', 1, 'Match the types', 'Match each column to the type of value it should hold.'),
  ('mission-be9-04-o1', 'mission-be9-04', 1, 'Break the key', 'Identify what breaks when a primary key isn''t actually unique in reality.'),
  ('mission-be9-05-o1', 'mission-be9-05', 1, 'Explain the dangling pointer', 'Find the evidence that explains how an orphaned foreign key reference was possible.'),
  ('mission-be9-06-o1', 'mission-be9-06', 1, 'Match the constraint', 'Match each rule to the constraint type that enforces it.'),
  ('mission-be9-07-o1', 'mission-be9-07', 1, 'Find the filter', 'Identify the clause that filters rows before ordering happens.'),
  ('mission-be9-08-o1', 'mission-be9-08', 1, 'Find the values', 'Identify the line supplying the actual inserted values.'),
  ('mission-be9-09-o1', 'mission-be9-09', 1, 'Find the safeguard', 'Identify the clause that keeps an UPDATE from touching every row.'),
  ('mission-be9-10-o1', 'mission-be9-10', 1, 'Choose the safe query', 'Pick the statement that removes exactly one row, safely.'),
  ('mission-be9-11-o1', 'mission-be9-11', 1, 'Find the join condition', 'Identify the line that determines which rows from each table get paired.'),
  ('mission-be9-12-o1', 'mission-be9-12', 1, 'Read the conflicting rows', 'Find the evidence proving both rows describe the same real person.'),
  ('mission-be9-12-o2', 'mission-be9-12', 2, 'Diagnose the missing safeguard', 'Explain why the UNIQUE constraint on national_id didn''t catch this duplicate.'),
  ('mission-be9-12-o3', 'mission-be9-12', 3, 'Find the real fix', 'Choose the structural fix that prevents this class of duplicate going forward.'),
  ('mission-be9-12-o4', 'mission-be9-12', 4, 'Close the case', 'Summarize what actually let two rows for the same citizen coexist.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-be9-01-o1-c1', 'mission-be9-01-o1', 1, 'multiple_choice', 'A backend keeps citizen records in a JavaScript array in memory. What breaks first when the server restarts?', '{"question":"A backend keeps citizen records in a JavaScript array in memory. What breaks first when the server restarts?","options":[{"id":"a","text":"Nothing, arrays persist automatically"},{"id":"b","text":"Every record that existed only in memory is gone"},{"id":"c","text":"Only the most recent record is lost"},{"id":"d","text":"The array converts itself to a file automatically"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-be9-02-o1-c1', 'mission-be9-02-o1', 1, 'multiple_choice', 'What makes a database "relational"?', '{"question":"What makes a database \"relational\"?","options":[{"id":"a","text":"It stores data in relations (tables), and can define relationships between them via keys"},{"id":"b","text":"It requires a family of related servers"},{"id":"c","text":"It only works with related data types like numbers"},{"id":"d","text":"It automatically relates every table to every other table"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-be9-03-o1-c1', 'mission-be9-03-o1', 1, 'drag_and_drop', 'Match each column to the type of value it should hold.', '{"items":[{"id":"c1","text":"citizen_id"},{"id":"c2","text":"full_name"},{"id":"c3","text":"date_of_birth"},{"id":"c4","text":"is_active"}],"targets":[{"id":"t1","label":"integer / uuid"},{"id":"t2","label":"text"},{"id":"t3","label":"date"},{"id":"t4","label":"boolean"}]}'::jsonb, '{"correctMapping":{"c1":"t1","c2":"t2","c3":"t3","c4":"t4"}}'::jsonb),

  ('mission-be9-04-o1-c1', 'mission-be9-04-o1', 1, 'multiple_choice', 'A citizens table uses full_name as its primary key. What breaks first?', '{"question":"A citizens table uses full_name as its primary key. What breaks first?","options":[{"id":"a","text":"Nothing, names are always unique"},{"id":"b","text":"Two citizens who happen to share a name can''t both have a row"},{"id":"c","text":"It makes queries faster"},{"id":"d","text":"PostgreSQL doesn''t allow text primary keys"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-be9-05-o1-c1', 'mission-be9-05-o1', 1, 'investigation', 'Which evidence explains how an orphaned address row like this was even possible?', '{"evidence":[{"id":"ev1","label":"addresses table","detail":"Contains citizen_id = 4471, but no row with that id exists in citizens"},{"id":"ev2","label":"citizens table","detail":"Has 3,204 rows, ids 1 through 3,204 with no gaps"},{"id":"ev3","label":"Migration log","detail":"A foreign key constraint on addresses.citizen_id was never added"}],"question":"Which evidence explains how an orphaned address row like this was even possible?"}'::jsonb, '{"requiredEvidenceIds":["ev3"]}'::jsonb),

  ('mission-be9-06-o1-c1', 'mission-be9-06-o1', 1, 'drag_and_drop', 'Match each rule to the constraint type that enforces it.', '{"items":[{"id":"k1","text":"email column can never be empty"},{"id":"k2","text":"national_id column must be unique across all citizens"},{"id":"k3","text":"age column must be >= 0"}],"targets":[{"id":"t1","label":"NOT NULL"},{"id":"t2","label":"UNIQUE"},{"id":"t3","label":"CHECK"}]}'::jsonb, '{"correctMapping":{"k1":"t1","k2":"t2","k3":"t3"}}'::jsonb),

  ('mission-be9-07-o1-c1', 'mission-be9-07-o1', 1, 'code_debugging', 'Which line filters out inactive citizens before any ordering happens?', '{"language":"sql","code":"SELECT full_name, date_of_birth\nFROM citizens\nWHERE is_active = true\nORDER BY date_of_birth DESC\nLIMIT 10;","question":"Which line filters out inactive citizens before any ordering happens?"}'::jsonb, '{"requiredLineIds":["WHERE is_active = true"]}'::jsonb),

  ('mission-be9-08-o1-c1', 'mission-be9-08-o1', 1, 'code_debugging', 'Which line supplies the actual values being inserted, in the same order as the column list above it?', '{"language":"sql","code":"INSERT INTO citizens (full_name, date_of_birth, is_active)\nVALUES (''''Dana Okafor'''', ''''1994-03-11'''', true);","question":"Which line supplies the actual values being inserted, in the same order as the column list above it?"}'::jsonb, '{"requiredLineIds":["VALUES (''''Dana Okafor'''', ''''1994-03-11'''', true);"]}'::jsonb),

  ('mission-be9-09-o1-c1', 'mission-be9-09-o1', 1, 'code_debugging', 'Which line, if it were missing entirely, would cause this UPDATE to deactivate every citizen in the table?', '{"language":"sql","code":"UPDATE citizens\nSET is_active = false\nWHERE citizen_id = 4471;","question":"Which line, if it were missing entirely, would cause this UPDATE to deactivate every citizen in the table?"}'::jsonb, '{"requiredLineIds":["WHERE citizen_id = 4471;"]}'::jsonb),

  ('mission-be9-10-o1-c1', 'mission-be9-10-o1', 1, 'multiple_choice', 'You need to remove exactly one citizen record. Which statement does that, safely?', '{"question":"You need to remove exactly one citizen record. Which statement does that, safely?","options":[{"id":"a","text":"DELETE FROM citizens;"},{"id":"b","text":"DELETE FROM citizens WHERE citizen_id = 4471;"},{"id":"c","text":"TRUNCATE citizens;"},{"id":"d","text":"DROP TABLE citizens;"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-be9-11-o1-c1', 'mission-be9-11-o1', 1, 'code_debugging', 'Which line is the join condition that determines which rows from each table actually get paired together?', '{"language":"sql","code":"SELECT citizens.full_name, addresses.city\nFROM citizens\nJOIN addresses ON citizens.citizen_id = addresses.citizen_id;","question":"Which line is the join condition that determines which rows from each table actually get paired together?"}'::jsonb, '{"requiredLineIds":["JOIN addresses ON citizens.citizen_id = addresses.citizen_id;"]}'::jsonb),

  ('mission-be9-12-o1-c1', 'mission-be9-12-o1', 1, 'investigation', 'Which evidence proves these are the same real person despite no key matching exactly?', '{"evidence":[{"id":"ev1","label":"Row A","detail":"national_id: 88213004, source_tag: ''''field-office''''"},{"id":"ev2","label":"Row B","detail":"national_id: 88213040, source_tag: ''''field-office//''''"},{"id":"ev3","label":"Intake log","detail":"A single citizen intake event, one timestamp, two rows written 400ms apart"}],"question":"Which evidence proves these are the same real person despite no shared key matching exactly?"}'::jsonb, '{"requiredEvidenceIds":["ev3"]}'::jsonb),
  ('mission-be9-12-o2-c1', 'mission-be9-12-o2', 1, 'multiple_choice', 'national_id has a UNIQUE constraint, but it didn''t stop this duplicate. Why not?', '{"question":"national_id has a UNIQUE constraint, but it didn''t stop this duplicate. Why not?","options":[{"id":"a","text":"UNIQUE constraints don''t work in PostgreSQL"},{"id":"b","text":"The two rows have different (both wrong) national_id values, so the constraint sees no conflict"},{"id":"c","text":"The constraint only checks the first five digits"},{"id":"d","text":"UNIQUE constraints are only enforced once a day"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-be9-12-o3-c1', 'mission-be9-12-o3', 1, 'multiple_choice', 'What''s the actual structural fix that prevents this class of duplicate going forward?', '{"question":"What''s the actual structural fix that prevents this class of duplicate going forward?","options":[{"id":"a","text":"Manually re-run a lookup query every week"},{"id":"b","text":"Add a periodic reconciliation job matching likely-duplicate citizens on normalized name plus date of birth, since a raw uniqueness constraint can''t catch typo''d or drifted key fields"},{"id":"c","text":"Delete one of the two rows and hope it doesn''t happen again"},{"id":"d","text":"Increase the national_id column length"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-be9-12-o4-c1', 'mission-be9-12-o4', 1, 'boss_encounter', 'Having found the duplicate, the missing safeguard, and the real fix, summarize what let two rows for the same citizen coexist.', '{"stages":[{"objectiveRef":"mission-be9-12-o1","label":"Read the conflicting rows"},{"objectiveRef":"mission-be9-12-o2","label":"Diagnose the missing safeguard"},{"objectiveRef":"mission-be9-12-o3","label":"Find the real fix"}],"task":"Having found the duplicate, the missing safeguard, and the real fix, summarize what actually let two rows for the same citizen coexist: a uniqueness constraint on a field that was itself entered wrong, with no reconciliation process to catch drift a strict key comparison would always miss."}'::jsonb, '{"requiredObjectiveIds":["mission-be9-12-o1","mission-be9-12-o2","mission-be9-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-be9-01-o1-c1', 'orientation', 'Memory only exists while the process is running.', 10, 1),
  ('mission-be9-01-o1-c1', 'solution', 'Anything that was never written somewhere durable disappears the instant the process restarts.', 20, 2),

  ('mission-be9-02-o1-c1', 'orientation', 'The word predates the modern meaning of "relationship" -- it comes from set theory''s term for a table.', 10, 1),
  ('mission-be9-02-o1-c1', 'solution', 'A relation is the formal term for a table; relational databases let you define real relationships between tables via keys.', 20, 2),

  ('mission-be9-03-o1-c1', 'orientation', 'Match each column name to the kind of value it would actually hold.', 10, 1),
  ('mission-be9-03-o1-c1', 'solution', 'citizen_id -> integer/uuid, full_name -> text, date_of_birth -> date, is_active -> boolean.', 20, 2),

  ('mission-be9-04-o1-c1', 'orientation', 'Ask what happens the moment two real people share the exact same value in that column.', 10, 1),
  ('mission-be9-04-o1-c1', 'solution', 'Full names aren''t guaranteed unique in reality -- two same-named citizens can''t coexist as rows if the name itself is the primary key.', 20, 2),

  ('mission-be9-05-o1-c1', 'orientation', 'A dangling pointer like this should have been physically impossible with the right constraint in place.', 10, 1),
  ('mission-be9-05-o1-c1', 'solution', 'ev3 -- without a foreign key constraint, nothing stopped an address from referencing a citizen_id that doesn''t exist.', 20, 2),

  ('mission-be9-06-o1-c1', 'orientation', 'Match each rule to the constraint type built specifically to enforce it.', 10, 1),
  ('mission-be9-06-o1-c1', 'solution', 'NOT NULL stops empty, UNIQUE stops duplicates, CHECK enforces an arbitrary rule like a value range.', 20, 2),

  ('mission-be9-07-o1-c1', 'orientation', 'Filtering and ordering are two different clauses, in a fixed order.', 10, 1),
  ('mission-be9-07-o1-c1', 'solution', 'WHERE is_active = true is the filter; ORDER BY and LIMIT only apply to what''s left after it.', 20, 2),

  ('mission-be9-08-o1-c1', 'orientation', 'Column list and value list line up position by position.', 10, 1),
  ('mission-be9-08-o1-c1', 'solution', 'VALUES supplies the data in the same order the column list named -- full_name, then date_of_birth, then is_active.', 20, 2),

  ('mission-be9-09-o1-c1', 'orientation', 'UPDATE without this clause has no way to know it should only touch one row.', 10, 1),
  ('mission-be9-09-o1-c1', 'solution', 'WHERE citizen_id = 4471; is what scopes the update to a single row -- remove it and every row matches.', 20, 2),

  ('mission-be9-10-o1-c1', 'orientation', 'Three of these four remove far more than one row.', 10, 1),
  ('mission-be9-10-o1-c1', 'solution', 'Only DELETE FROM citizens WHERE citizen_id = 4471; is scoped to the one row you actually mean.', 20, 2),

  ('mission-be9-11-o1-c1', 'orientation', 'Without this line, the database wouldn''t know which address belongs to which citizen.', 10, 1),
  ('mission-be9-11-o1-c1', 'solution', 'The ON clause is the join condition -- it''s what pairs a citizens row with the correct addresses row.', 20, 2),

  ('mission-be9-12-o1-c1', 'orientation', 'The two rows'' key fields disagree -- look for what they share instead.', 10, 1),
  ('mission-be9-12-o1-c1', 'solution', 'One intake event, two rows written 400ms apart -- that timing is what ties them to the same real person.', 20, 2),
  ('mission-be9-12-o2-c1', 'orientation', 'A UNIQUE constraint only ever compares the value that''s actually stored, not the value that should have been.', 10, 1),
  ('mission-be9-12-o2-c1', 'solution', 'Both national_id values are wrong in different ways, so from the constraint''s point of view they''re two legitimately different keys.', 20, 2),
  ('mission-be9-12-o3-c1', 'orientation', 'A constraint can only compare exact stored values -- it can never know two different-looking values describe the same person.', 10, 1),
  ('mission-be9-12-o3-c1', 'solution', 'A periodic reconciliation job comparing normalized name and date of birth catches what a strict uniqueness constraint structurally cannot.', 20, 2),
  ('mission-be9-12-o4-c1', 'orientation', 'Connect the missing safeguard to the fix -- one explains why the bug happened, the other explains how to actually stop it.', 15, 1),
  ('mission-be9-12-o4-c1', 'solution', 'A key that was itself entered wrong defeated the uniqueness constraint built to prevent exactly this -- only a reconciliation process that doesn''t rely on exact key matches can catch it going forward.', 25, 2);
