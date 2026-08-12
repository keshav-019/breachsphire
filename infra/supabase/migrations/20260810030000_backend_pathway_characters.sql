-- Backend Engineering pathway's cast: Mira Voss (Chief Architect, mentor
-- role) and Forge (ops-assistant AI), same narrative role as Ava/Byte.
-- `fracture` reserved now for the antagonist's later voice lines so this
-- constraint doesn't need touching again for Act 32's finale.

alter table public.dialogue_lines drop constraint dialogue_lines_character_id_check;

alter table public.dialogue_lines add constraint dialogue_lines_character_id_check
  check (character_id in
    ('ava', 'zayn', 'luna', 'byte', 'cipher', 'sentinel_x', 'system', 'mira', 'forge', 'fracture'));
