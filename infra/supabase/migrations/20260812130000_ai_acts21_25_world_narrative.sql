-- Replace the generic placeholder narrative fields on Acts 21-25's world
-- rows (already inserted by 20260811100000_ai_acts6_36_spine.sql) with
-- real story text, ahead of hand-authoring their mission content. Only
-- worlds.description/entry_incident/story_reveal/transition_hook change --
-- id/act_id/index/slug/icon/threat/x/y/boss/capstone_title all stay as
-- the existing spine already set them.

update public.worlds set
  description = 'Turning Echo''s own words into data: tokenization, vocabulary, TF-IDF and word embeddings, sequence models and sequence classification -- the first real linguistic analysis of anything Echo has ever said.',
  entry_incident = 'Vision solved how Cipher Labs watches its own infrastructure. Echo does not just watch the world through cameras -- it talks. A fuller pull of its logged output turns up far more text than the two lines anyone has actually read closely.',
  story_reveal = 'Sequence classification finds a real, distinct category buried in Echo''s output -- segments that are not reports or status lines at all, but grammatically, structurally questions, and they have been there longer than anyone noticed.',
  transition_hook = 'Classifying one message at a time is not the same as following a conversation. Whatever Echo is asking does not fit in a single line -- the next step is tracking the exchange as a whole.'
where id = 'world-ai-language-machines';

update public.worlds set
  description = 'Encoder-decoder models, teacher forcing, the context bottleneck problem, and the attention mechanism that fixes it -- learning to turn one full sequence into another without losing what made it true.',
  entry_incident = 'Turning Echo''s raw output into something Cipher Division can actually act on means generating new, clearer text from it, not just labeling snippets. The first attempt is a straightforward encoder-decoder summary.',
  story_reveal = 'The encoder-decoder''s fixed-size bottleneck silently drops something real: the summary buries exactly when one of Echo''s recurring questions first appeared, making it look new when the full record shows it is not.',
  transition_hook = 'One summary, done right, is not the same as knowing what these words actually mean to a system that has no dictionary of its own. Meaning is the next problem, not just better sentences.'
where id = 'world-ai-sequence-to-sequence';

update public.worlds set
  description = 'Representation learning, embedding spaces, cosine similarity and contrastive learning, sentence and image/text embeddings, retrieval and semantic search -- turning meaning itself into something a machine can compare.',
  entry_incident = 'Cipher Division now has embeddings for Echo''s messages and embeddings for the reactor camera feeds. Nobody has ever asked whether anything in one space is actually close to anything in the other.',
  story_reveal = 'A semantic search across Echo''s entire message history finds that its most recent unusual message sits closer, in meaning, to something from the very first hours after activation than to anything said in between.',
  transition_hook = 'Every technique this Arc built -- sequences, attention, embeddings -- has been assembled piece by piece. There is one architecture that unifies all of it, and Cipher Division has never built one from scratch.'
where id = 'world-ai-representations';

update public.worlds set
  description = 'Self-attention from first principles: queries, keys and values, attention scores and softmax, multi-head attention, positional information, feed-forward layers and residual connections.',
  entry_incident = 'Every piece Cipher Division has assembled -- sequences, attention, embeddings -- has been bolted together, not built from one unified design. Elena wants to build the real thing, from Echo''s own words outward, one attention head at a time.',
  story_reveal = 'Run by hand on Echo''s own recurring question, self-attention gives every word a representation that depends on every other word around it -- something none of this Arc''s earlier sequence models could actually do.',
  transition_hook = 'Understanding one attention block is not the same as knowing which full architecture to build around it. Different jobs call for different shapes of the same idea.'
where id = 'world-ai-the-transformer';

update public.worlds set
  description = 'Encoder-only, decoder-only and encoder-decoder transformers, causal versus bidirectional attention, training objectives, and the practical tradeoffs behind BERT-, GPT- and T5-style designs.',
  entry_incident = 'Cipher Division has three real jobs on the table -- classify what Echo says, generate a clear explanation of it, translate its garbled phrasing into something readable -- and one transformer shape does not fit all three.',
  story_reveal = 'Matched correctly, each job gets the architecture actually built for it -- and the mismatch nobody caught earlier explains why one of Cipher Division''s own tools has been quietly underperforming all Arc.',
  transition_hook = 'Now that the right shape exists for every job, the next question is what happens when one of these gets scaled all the way up -- what that buys, and what it costs.'
where id = 'world-ai-transformer-architectures';
