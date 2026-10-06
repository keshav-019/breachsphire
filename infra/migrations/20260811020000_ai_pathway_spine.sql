-- Third pathway: AI & Machine Learning ("The Awakening"), Cipher Division.
-- Arc I ("Learn to See Data") and its first Act, "The Awakening" -- same
-- acts/worlds table-reuse pattern as Backend Engineering. Later sessions
-- append more acts/worlds rows the same way; the map/lock UI, pathway
-- selection screen and mission engine need no further changes to pick
-- them up.

insert into public.pathways (id, slug, title, tagline, description, icon, sort_order) values
  ('pathway-ai', 'ai-ml', 'Cipher Division', 'Learn how machines learn.',
   'A 0-to-1 AI/ML engineering campaign: 36 Acts from your first model to production AI systems -- Python, math, classical ML, deep learning, computer vision, NLP, transformers, LLMs, RAG and agents -- racing to understand a still-learning system before it learns too much.',
   'Brain', 3);

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-ai-1', 0, 'learn-to-see-data', 'Arc I -- Learn to See Data',
   'Cipher Labs has just come online carrying a learning system nobody authorized. The player joins Cipher Division to learn the fundamental vocabulary and loop of machine learning -- AI vs ML vs DL, data, features, labels, models, training and inference -- well enough to start understanding what Echo actually is.',
   'Absolute beginner -> data-literate ML thinker who can explain what a model actually is',
   'pathway-ai');

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-ai-the-awakening', 'act-ai-1', 0, 'the-awakening', 'The Awakening', 'The Awakening',
   'What AI, ML and Deep Learning actually are, and the full loop -- data, features, labels, models, training and inference -- that every learning system, including Echo, runs on.',
   'Cipher Labs activates without authorization and a dormant learning system floods every ops display. Dr. Maya Sen pulls the player into Cipher Division to find out what it is before it finishes finding out what it wants.',
   'The Machine That Was Never Programmed',
   'Echo is not an intrusion -- it is a machine learning system, almost certainly deep, that never had its training turned off. Nobody wrote its rules; it found them. And whoever it learned them from is gone.',
   'Understanding Echo means learning to build and train models the same way it was built -- starting with the language and tools every model in Cipher Labs runs on.',
   'The Machine That Was Never Programmed', 'Bot', 'guarded', 8, 12, 'pathway-ai');

-- Existing players never ran handle_new_user() against a world that didn't
-- exist yet -- unlock Act 1 of the new pathway for everyone already signed
-- up (new signups get this for free via the existing `where index = 0`
-- trigger, now that index is scoped per-pathway).
insert into public.player_world_progress (player_id, world_id, state, completion)
select id, 'world-ai-the-awakening', 'unlocked', 0 from public.profiles
on conflict (player_id, world_id) do nothing;
