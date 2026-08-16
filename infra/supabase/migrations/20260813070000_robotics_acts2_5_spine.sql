-- Robotics/Embedded/IoT pathway ("The Machine Below"): World rows for
-- Acts 2-5, all still under Arc I ("Electricity Becomes Computation",
-- act-vec-1, which the bible states spans Acts 1-5) -- no new Arc row
-- needed. Content (missions) for each Act follows in its own migration.
--
-- Narrative thread across these four Acts: Vector Division does not
-- chase four separate incidents -- it takes the ONE controller board
-- recovered from Act 1's door and studies it at progressively deeper
-- layers (circuit -> binary/registers -> the microcontroller chip ->
-- the actual firmware), until Act 4 discovers a second, still-live door
-- with the identical board design, and Act 5 closes Arc I with the
-- player able to read and repair a controller like this one without
-- treating it as a black box -- setting up Act 6 (RTOS/real-time).

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-vec-electric-language', 'act-vec-1', 1, 'electric-language', 'Electric Language', 'Electric Language',
   'Voltage, current, resistance and power; analog vs digital; logic levels; pull-up/pull-down; breadboards and circuits; an LED and resistor lab; buttons, switches and debouncing; multimeter workflow.',
   'Tomas Vey claims the door''s recovered controller board for Vector Division''s bench. Before anyone can read a single line of its firmware, the board has to be understood as a physical circuit -- voltages, currents, and the electrical assumptions the whole rest of it was built on.',
   'The Silent Circuit',
   'The board is not exotic hardware. It is ordinary, decades-old electronics, wired with completely standard assumptions -- which is exactly why it still works after all this time, and exactly why nobody thought to keep watching it.',
   'Understanding the board electrically is not enough to read what it actually knows. The next step is learning to read it the way a machine does -- in binary.',
   'The Silent Circuit', 'Activity', 'guarded', 20, 12, 'pathway-robotics'),

  ('world-vec-binary-machines', 'act-vec-1', 2, 'binary-machines', 'Binary Machines', 'Binary Machines',
   'Binary and hexadecimal; bits, bytes and words; Boolean logic and truth tables; bitwise operations; registers and memory-mapped I/O intuition; endianness; signed integers and fixed-width overflow.',
   'With the board''s circuits mapped, Tomas Vey pulls a raw register dump from its memory -- rows of binary and hex that mean nothing without the vocabulary to read them.',
   '0xDEAD',
   'Buried in the dump is a repeating status value: 0xDEAD. Not a fault code -- a placeholder the original engineers left behind, meaning roughly "not finished configuring this," never revisited before the board was sealed into the wall for decades.',
   'A placeholder from thirty years ago is a curiosity on a dead board. It becomes a genuine threat the moment Vector Division finds a live one.',
   '0xDEAD', 'Binary', 'guarded', 32, 12, 'pathway-robotics'),

  ('world-vec-the-microcontroller', 'act-vec-1', 3, 'the-microcontroller', 'The Microcontroller', 'The Microcontroller',
   'MCU vs CPU vs SoC; microcontroller anatomy; GPIO; digital input and output; ADC; PWM; timers; interrupts; watchdogs; firmware lifecycle.',
   'A second door at a different Nexus facility begins showing the exact same electrical and register signature as the recovered board -- except this one is still installed, still powered, and still connected to a working motor.',
   'The Frozen Controller',
   'The chip at the heart of both boards is a genuine microcontroller: a complete small computer with its own memory, timers and I/O, built to run one program forever. It froze not because it was attacked, but because a watchdog -- the one safeguard built to catch it hanging -- was itself configured wrong from the day it was installed.',
   'Vector Division can now explain why the controller froze. Explaining is not the same as fixing it. That takes reading and writing the actual firmware.',
   'The Frozen Controller', 'Layers', 'elevated', 44, 12, 'pathway-robotics'),

  ('world-vec-firmware-forge', 'act-vec-1', 4, 'firmware-forge', 'Firmware Forge', 'Firmware Forge',
   'C/C++ for embedded systems; compilation and linking; headers and translation units; pointers for hardware; structs and enums; volatile; const correctness; static allocation; stack vs heap; memory constraints; defensive firmware.',
   'Byte and Tomas Vey pull the full firmware image off both boards to finally read the actual code SUBSTRATE-era engineers wrote -- and to find out whether it can be safely touched at all.',
   'The Memory Leak in 64 KB',
   'The firmware runs clean for years at a time before behaving strangely -- not from age, and not from any external interference. A genuine memory leak, present since the day it was written, slowly consumes the same 64 kilobytes every controller like this one was ever given. It was always going to fail eventually. The only open question was always going to be when.',
   'The player now has enough firmware knowledge to repair a controller like this one without treating it as a black box. The next question is no longer what one board does -- it is how fast a whole one has to react at all.',
   'The Memory Leak in 64 KB', 'Terminal', 'elevated', 56, 12, 'pathway-robotics');
