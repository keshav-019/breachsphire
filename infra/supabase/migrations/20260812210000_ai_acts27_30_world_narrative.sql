-- Replace the generic placeholder narrative fields on Acts 27-30's world
-- rows (already inserted by 20260811100000_ai_acts6_36_spine.sql) with
-- real story text, ahead of hand-authoring their mission content. Only
-- worlds.description/entry_incident/story_reveal/transition_hook change --
-- id/act_id/index/slug/icon/threat/x/y/boss/capstone_title all stay as
-- the existing spine already set them.

update public.worlds set
  description = 'Real engineering discipline around a language model: message roles and system instructions, structured JSON outputs and schema validation, tool calling, streaming, and handling retries, rate limits and timeouts like any other production system.',
  entry_incident = 'A model this confident, even when it is wrong, is not something Cipher Division can run on instinct. Every output this tool ever produces now needs structure, validation and a way to fail safely -- starting with how it is even allowed to respond.',
  story_reveal = 'Stress-tested under real failure conditions -- malformed output, a stalled connection, a tool call with bad arguments -- the assistant only becomes trustworthy once every one of those failures has an engineered, tested response, not a hope that it will not happen.',
  transition_hook = 'A reliable assistant that still knows nothing beyond its training is not enough. Cipher Division needs it to actually look things up.'
where id = 'world-ai-building-with-llms';

update public.worlds set
  description = 'Dense embeddings, query versus document representations, chunking strategy, metadata, vector stores and retrievers -- building the index that lets a model actually look something up instead of guessing.',
  entry_incident = 'A reliable assistant that still knows nothing beyond its training is not enough. Cipher Division builds a real vector index over its own investigation archive -- every log, every finding, every piece of evidence gathered since Act 1.',
  story_reveal = 'A real, relevant record sits in the archive the whole time, and the retriever never finds it -- not because the document is gone, but because it was chunked and embedded in a way that buried the one detail that made it match.',
  transition_hook = 'Finding documents is not the same as answering questions with them. Retrieval is only half the system Cipher Division actually needs.'
where id = 'world-ai-embeddings-vector-search';

update public.worlds set
  description = 'The full retrieval-augmented generation pipeline: ingestion, grounding and citations, retrieval failure, query rewriting, multi-query and decomposition, reranking and hybrid search.',
  entry_incident = 'Retrieval alone just finds documents. Cipher Division needs the assistant to actually answer questions about its own investigation, grounded in what it retrieves, with a citation for every claim.',
  story_reveal = 'Even with real retrieval wired in, the assistant answers one question confidently from memory instead of from what it actually retrieved -- proving a citation on the page is not proof the model used the source behind it.',
  transition_hook = 'A RAG system that can be fooled into ignoring its own sources needs harder defenses than the basics. The failure modes get uglier from here.'
where id = 'world-ai-rag';

update public.worlds set
  description = 'Hardening retrieval against the real world: parent/child retrieval, contextual compression, retrieval grading and evidence checking, conflicting sources, malicious retrieved content, agentic and hybrid RAG.',
  entry_incident = 'Building retrieval grading strong enough to catch a hallucinating model means checking every retrieved document against what else Cipher Division already knows to be true -- and that check was never run on the archive itself before now.',
  story_reveal = 'The evidence-checking pass does not just catch a bad retrieval. It catches archive records that do not match their own checksums and timestamps -- a small number of documents, altered after the fact, inside Cipher Division''s own systems.',
  transition_hook = 'A poisoned archive means Cipher Division cannot fully trust its own memory anymore. Finding out what changed is one problem. Finding out what is still touching these records is another -- and it means the next tool needs to do more than retrieve. It needs to act.'
where id = 'world-ai-advanced-rag';
