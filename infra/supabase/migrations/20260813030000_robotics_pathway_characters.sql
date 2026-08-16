-- Robotics/Embedded/IoT pathway's cast: Commander Imani Rao (Vector
-- Division lead -- mentor role, Maya/Mira-equivalent), Tomas Vey (Embedded
-- Engineer: electronics, firmware, RTOS, buses, bootloaders), Dr. Lin
-- Ortega (Roboticist: kinematics, localization, mapping, planning, ROS 2)
-- and Sera Holt (Safety Engineer) reserved now even though Tomas and Lin
-- don't speak until later Acts (Tomas from Act 2 electronics onward, Lin
-- from Act 18 robot geometry onward) -- same restraint pattern as `elena`/
-- `noah` in the AI/ML pathway. `byte` is reused unchanged as this
-- pathway's AI companion, now gaining sensor/actuator access for the
-- first time per the story bible. `substrate` is the antagonist, speaking
-- in industrial diagnostic-message style only.

alter table public.dialogue_lines drop constraint dialogue_lines_character_id_check;

alter table public.dialogue_lines add constraint dialogue_lines_character_id_check
  check (character_id in
    ('ava', 'zayn', 'luna', 'byte', 'cipher', 'sentinel_x', 'system', 'mira', 'forge', 'fracture',
     'maya', 'arjun', 'elena', 'noah', 'echo',
     'imani', 'tomas', 'lin', 'sera', 'substrate'));
