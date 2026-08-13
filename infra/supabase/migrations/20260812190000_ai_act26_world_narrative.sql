-- Replace the generic placeholder narrative fields on Act 26's world row
-- (already inserted by 20260811100000_ai_acts6_36_spine.sql) with real
-- story text, ahead of hand-authoring its mission content. Only
-- worlds.description/entry_incident/story_reveal/transition_hook change --
-- id/act_id/index/slug/icon/threat/x/y/boss/capstone_title all stay as
-- the existing spine already set them.

update public.worlds set
  description = 'What a large language model actually is: next-token prediction at scale, tokenizers and context windows, pretraining and instruction tuning, and the sampling choices -- temperature, top-k, top-p -- that decide how it generates.',
  entry_incident = 'Now that the right shape exists for every job, Cipher Division scales its decoder-only transformer all the way up -- into something that can hold a real conversation, not just classify a label.',
  story_reveal = 'Asked to explain the connection Act 23 found, the new model produces a fluent, detailed, entirely confident account -- and none of the specific reasons it gives are backed by anything in the real evidence trail.',
  transition_hook = 'A model this confident, even when it is wrong, is not something Cipher Division can run on instinct. Every output this tool ever produces now needs structure, validation and a way to fail safely -- starting with how it is even allowed to respond.'
where id = 'world-ai-large-language-models';
