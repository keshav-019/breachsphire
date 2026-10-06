-- AI/ML pathway's cast: Dr. Maya Sen (Director, Cipher Division -- mentor
-- role), Arjun Vale (Data Engineer), Dr. Elena Rook (Research Scientist)
-- and Noah Kim (ML Platform Engineer) reserved now even though the first
-- three only speak starting later Acts, same as `fracture` was reserved
-- ahead of Backend Engineering's Act 32. `byte` is reused unchanged as
-- this pathway's AI companion. `echo` is the antagonist.

alter table public.dialogue_lines drop constraint dialogue_lines_character_id_check;

alter table public.dialogue_lines add constraint dialogue_lines_character_id_check
  check (character_id in
    ('ava', 'zayn', 'luna', 'byte', 'cipher', 'sentinel_x', 'system', 'mira', 'forge', 'fracture',
     'maya', 'arjun', 'elena', 'noah', 'echo'));
