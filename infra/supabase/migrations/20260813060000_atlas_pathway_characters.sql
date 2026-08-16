-- Atlas Division's cast: Commander Leena Rao (Head of Atlas -- mentor
-- role, Maya/Mira/Imani-equivalent), Tomas Vey (Cloud Architect: cloud,
-- Terraform, global architecture), Imani Cross (SRE: observability,
-- incidents, capacity, chaos) and Rook (Platform Engineer: developer
-- platforms, golden paths, GitOps) reserved now even though only some
-- speak in Act 1. `warden` is the antagonist, reserved and silent until
-- its Act 36 reveal, same restraint pattern as every prior pathway's
-- final-boss identity (`fracture`, `echo`, `substrate`).
--
-- Deliberate id disambiguation: the source bible names this pathway's
-- Cloud Architect "Tomas Vey" and its SRE "Imani Cross" -- both first
-- names collide with characters already reserved in the Robotics/Vector
-- Division cast (`tomas` = Tomas Vey, Embedded Engineer; `imani` = Imani
-- Rao, Commander). Since `character_id` is a single global namespace
-- across every pathway, these two use surname-based ids (`vey`, `cross`)
-- instead of the usual first-name convention, to avoid silently
-- corrupting the Robotics pathway's existing characters. `byte` is reused
-- unchanged as this pathway's AI companion, now partially unavailable
-- when the infrastructure it depends on is degraded.

alter table public.dialogue_lines drop constraint dialogue_lines_character_id_check;

alter table public.dialogue_lines add constraint dialogue_lines_character_id_check
  check (character_id in
    ('ava', 'zayn', 'luna', 'byte', 'cipher', 'sentinel_x', 'system', 'mira', 'forge', 'fracture',
     'maya', 'arjun', 'elena', 'noah', 'echo',
     'imani', 'tomas', 'lin', 'sera', 'substrate',
     'leena', 'vey', 'cross', 'rook', 'warden'));
