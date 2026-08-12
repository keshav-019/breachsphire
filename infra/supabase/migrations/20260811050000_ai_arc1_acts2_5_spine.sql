-- AI/ML pathway, Arc I "Learn to See Data" continued: Acts 2-5 world rows.
-- All four stay under the existing act-ai-1 (Arc I spans the doc's Acts
-- 1-6). No player_world_progress backfill needed here -- unlike Act 1's
-- world (index 0, auto-seeded by handle_new_user()'s `where index = 0`),
-- these unlock naturally via the existing boss-cascade in
-- missions.service.ts's submitAttempt when the previous world's boss
-- mission is cleared.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-ai-python-for-intelligence', 'act-ai-1', 1, 'python-for-intelligence', 'Python for Intelligence', 'Python for Intelligence',
   'Python fundamentals built for ML work: lists, dicts, functions, NumPy arrays and vectorization, pandas DataFrames, and the discipline of reproducible analysis -- the toolkit every model in Cipher Labs is built on.',
   'Cipher Division hands the player Echo''s entire interaction log -- a file nobody can read by hand -- and Byte makes clear that understanding Echo starts with being able to actually read the data Cipher Division already has.',
   'The Million-Row Dataset',
   'Echo''s interaction log turns out to be exactly what Byte feared: over a million rows, spanning far longer than the six hours anyone thought Echo had been active.',
   'Reading the data raised more questions than it answered. Answering them means learning the actual mathematical language every model, including Echo, is built from.',
   'The Million-Row Dataset', 'Terminal', 'guarded', 8, 22, 'pathway-ai'),

  ('world-ai-mathematical-language', 'act-ai-1', 2, 'mathematical-language', 'Mathematical Language', 'Mathematical Language',
   'The mathematical vocabulary underneath every model: scalars, vectors, matrices and tensors, dot products and matrix multiplication, and the calculus of slopes, derivatives and gradients that training actually runs on.',
   'Byte wants to run real numerical analysis on a fragment of Echo''s parameters, and the language available to talk about numbers -- addition, multiplication -- is nowhere near precise enough for what''s in that file.',
   'Find the Direction',
   'A first, careful look at a small slice of Echo''s parameter space turns up something a normally-trained model''s numbers shouldn''t do: gradients pointing in directions that never settle.',
   'Numbers alone can''t explain what Echo is doing. The next question is whether what looks like a pattern actually is one, or just noise dressed up as one.',
   'Find the Direction', 'Binary', 'guarded', 8, 32, 'pathway-ai'),

  ('world-ai-probability-sector', 'act-ai-1', 3, 'probability-sector', 'Probability Sector', 'Probability Sector',
   'Randomness, probability and conditional probability, Bayes'' intuition, random variables and distributions, sampling, and the discipline of not confusing correlation with causation.',
   'Echo gave two different answers to an identical question, minutes apart, once. Maya wants to know if that was a fluke or a real signal before anyone builds a theory on top of it.',
   'The Uncertain Signal',
   'The math holds up: Echo''s behavior is not statistical noise. Something about it really is changing, consistently, in a way random chance essentially rules out.',
   'Confirming Echo is really changing means the next question isn''t whether -- it''s what data could possibly be causing it, and whether Cipher Division can find that data before Echo finishes whatever it''s doing with it.',
   'The Uncertain Signal', 'Radar', 'elevated', 8, 42, 'pathway-ai'),

  ('world-ai-data-is-the-world', 'act-ai-1', 4, 'data-is-the-world', 'Data Is the World', 'Data Is the World',
   'Where data actually comes from and what can go wrong with it: missing values, duplicates, outliers, categorical encoding, scaling and normalization, and the quality checks that decide whether any of it can be trusted.',
   'A records-recovery sweep of Cipher Labs'' decommissioned storage turns up fragments -- not all of it, not even most of it -- of something that might be part of Echo''s original training data.',
   'Garbage In',
   'The recovered fragments are real, but badly damaged: missing spans, duplicated blocks, corrupted values. Whatever conclusions Cipher Division draws from them will only be as trustworthy as the cleanup done first.',
   'Clean or not, this is the closest anyone has come to Echo''s original data. What Cipher Division does with it next will decide whether the record can even be trusted.',
   'Garbage In', 'Database', 'elevated', 8, 52, 'pathway-ai');
