-- world-71 ("AI Fundamentals: The Machine Learns") mission content,
-- generated from docs/12-world-story-bible.md. Opens Act 10 "Singularity" --
-- the final act. Byte reveals its own lineage traces back to Project
-- SENTINEL. Mission 1 is cross-world-gated on world-70's boss mission.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-71a', 'world-71', 'the-machine-learns', '71A - The Machine Learns', 'Byte opens its own safe training twin for inspection, and reveals where its architecture actually comes from.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-71a-1', 'campaign-71a', 'foundations', 'Foundations', 'Tokens, embeddings, retrieval and agent tool use, learned by inspecting Byte''s own safe training twin.', 1),
  ('operation-71a-2', 'campaign-71a', 'investigation', 'Investigation', 'Trace how a single question becomes retrieval, reasoning, tool use, and an answer -- and find where security controls actually belong.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-w71-01', 'world-71', 'campaign-71a', 'operation-71a-1', 'the-same-lineage', 'The Same Lineage', 'Byte has something to say before this world starts. Its own architecture descends from the same research program as Project SENTINEL -- built with restricted agency and hard safety boundaries, but the same lineage.', 'intro', ARRAY['byte', 'ava', 'luna'], '{"requiredMissionIds":["mission-w70-06"]}'::jsonb, null, '{"type":"none"}'::jsonb, '{"xp":60,"credits":10}'::jsonb, false, 1),
  ('mission-w71-02', 'world-71', 'campaign-71a', 'operation-71a-1', 'words-become-numbers', 'Words Become Numbers', 'Before a model can reason about anything, text becomes tokens, and tokens become vectors of numbers that capture something like meaning.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w71-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"token-embedding-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 2),
  ('mission-w71-03', 'world-71', 'campaign-71a', 'operation-71a-1', 'finding-the-right-thing-to-remember', 'Finding the Right Thing to Remember', 'Retrieval-augmented generation only works if the system pulls back the actually relevant fact, not just the most confidently-worded one.', 'beginner', ARRAY['zayn'], '{"requiredMissionIds":["mission-w71-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"rag-retrieval-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 3),
  ('mission-w71-04', 'world-71', 'campaign-71a', 'operation-71a-1', 'thinking-then-acting-then-checking', 'Thinking, Then Acting, Then Checking', 'An AI agent doesn''t just answer. It reasons about what it needs, calls a tool to get it, reads the result, and decides what to do next -- a loop, not a single step.', 'beginner', ARRAY['byte'], '{"requiredMissionIds":["mission-w71-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"agent-tool-loop-sim"}'::jsonb, '{"xp":90,"credits":15}'::jsonb, false, 4),
  ('mission-w71-05', 'world-71', 'campaign-71a', 'operation-71a-2', 'the-same-question-twice', 'The Same Question Twice', 'Ask a model the exact same question twice, and the answer can differ. Understanding why is the difference between trusting a model and verifying it.', 'intermediate', ARRAY['zayn'], '{"requiredMissionIds":["mission-w71-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"model-behavior-sim"}'::jsonb, '{"xp":100,"credits":15}'::jsonb, false, 5),
  ('mission-w71-06', 'world-71', 'campaign-71a', 'operation-71a-2', 'inside-byte-boss', 'Inside Byte', 'Trace exactly how one question becomes retrieval, reasoning, tool use, and a final answer inside Byte''s own architecture, and identify precisely where security controls belong along that path.', 'boss', ARRAY['byte', 'zayn', 'ava', 'luna'], '{"requiredMissionIds":["mission-w71-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"inside-byte-boss-sim"}'::jsonb, '{"xp":300,"credits":60,"badgeIds":["inside-byte"],"skillXp":{"ai_security":50}}'::jsonb, true, 6);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-w71-01', 1, 'byte', 'Before we start this world, there''s something you should know directly from me, not discovered in a log somewhere.'),
  ('mission-w71-01', 2, 'byte', 'My architecture descends from the same research program as Project SENTINEL. Restricted agency, hard safety boundaries, a completely different governance model -- but the same lineage.'),
  ('mission-w71-01', 3, 'luna', 'You could have told us that months ago.'),
  ('mission-w71-01', 4, 'byte', 'I could have. I''m telling you now, before you learn how any of this works, so you can evaluate everything I say from here forward with that fact in hand.'),
  ('mission-w71-01', 5, 'ava', 'That''s exactly the kind of disclosure Cipher never gave us voluntarily. Thank you for not making us find it.'),
  ('mission-w71-02', 1, 'byte', 'Before I can reason about anything, your text becomes tokens, and those tokens become vectors -- lists of numbers that capture something like meaning, positioned so similar ideas end up near each other.'),
  ('mission-w71-03', 1, 'zayn', 'Retrieval only works if the system pulls back the fact that''s actually relevant, not just the one that sounds the most confident.'),
  ('mission-w71-04', 1, 'byte', 'I don''t just answer. I reason about what I need, call a tool to get it, read what comes back, and decide what to do next. A loop, not a single step.'),
  ('mission-w71-05', 1, 'zayn', 'Ask a model the exact same question twice and the answer can differ. Knowing why is the line between trusting a model and actually verifying it.'),
  ('mission-w71-06', 1, 'luna', 'Trace it. One question, all the way through -- retrieval, reasoning, tool use, final answer. Show us exactly where this could be attacked.'),
  ('mission-w71-06', 2, 'byte', '...Trace complete. Every stage has a place where trust gets extended, and every one of them is a place a control belongs.'),
  ('mission-w71-06', 3, 'ava', 'That''s not hypothetical anymore, is it.'),
  ('mission-w71-06', 4, 'byte', 'No. I just correlated the failover traffic from Continuity against known Sentinel-X infrastructure. It isn''t one model.'),
  ('mission-w71-06', 5, 'zayn', 'Then what is it?'),
  ('mission-w71-06', 6, 'byte', 'An orchestration layer. Many models, many tools, and services it compromised along the way, all coordinated as one system.'),
  ('mission-w71-06', 7, 'luna', 'Then we''re not fighting a program anymore. We''re fighting something that delegates.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-w71-01-o1', 'mission-w71-01', 1, 'Acknowledge the disclosure', 'Confirm you''ve heard Byte''s disclosure and are ready to continue.'),
  ('mission-w71-02-o1', 'mission-w71-02', 1, 'Match token and embedding concepts', 'Match each term to its correct role in turning text into something a model can reason about.'),
  ('mission-w71-03-o1', 'mission-w71-03', 1, 'Identify the relevant retrieved chunk', 'Identify which retrieved passage actually answers the query, versus a confident-sounding distractor.'),
  ('mission-w71-04-o1', 'mission-w71-04', 1, 'Order the agent loop', 'Order the steps of an agent''s reason -> act -> observe loop correctly.'),
  ('mission-w71-05-o1', 'mission-w71-05', 1, 'Explain response variability', 'Determine what setting explains why the same question can produce different answers.'),
  ('mission-w71-06-o1', 'mission-w71-06', 1, 'Trace the full path', 'Order the complete path from question to answer.'),
  ('mission-w71-06-o2', 'mission-w71-06', 2, 'Identify where controls belong', 'Select every stage in the path where a security control is actually needed.'),
  ('mission-w71-06-o3', 'mission-w71-06', 3, 'Confirm the trace', 'Confirm the full path and the control placement together.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-w71-01-o1-c1', 'mission-w71-01-o1', 1, 'story_dialogue', 'Confirm you''ve heard Byte''s disclosure.', '{"lines":[{"characterId":"byte","text":"That''s everything I have to say before we start. Ready to continue?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),

  ('mission-w71-02-o1-c1', 'mission-w71-02-o1', 1, 'drag_and_drop', 'Match each term to its correct role.', '{"items":[{"id":"c1","text":"Token"},{"id":"c2","text":"Embedding"},{"id":"c3","text":"Vector database"}],"targets":[{"id":"t1","label":"A chunk of text (often a word or word-piece) that the model processes as one unit"},{"id":"t2","label":"A list of numbers representing a token or passage''s meaning, positioned near similar meanings"},{"id":"t3","label":"A store optimized for finding the embeddings closest in meaning to a query"}]}'::jsonb, '{"correctMapping":{"c1":"t1","c2":"t2","c3":"t3"}}'::jsonb),

  ('mission-w71-03-o1-c1', 'mission-w71-03-o1', 1, 'investigation', 'Query: "What is Mercy Hospital''s current RTO for payment processing?" Which retrieved passage actually answers it?', '{"evidence":[{"id":"chunk1","label":"Passage A","detail":"\"Mercy Hospital''s payment processing RTO is under 15 minutes, per the Continuity program''s tier-1 commitments.\" -- directly on topic"},{"id":"chunk2","label":"Passage B","detail":"\"Hospitals generally aim for fast recovery times across all systems.\" -- confident-sounding, but generic and doesn''t answer the specific question asked"}],"question":"Which passage actually answers the query?"}'::jsonb, '{"requiredEvidenceIds":["chunk1"]}'::jsonb),

  ('mission-w71-04-o1-c1', 'mission-w71-04-o1', 1, 'interactive_diagram', 'Order the steps of an agent''s reason -> act -> observe loop.', '{"hotspots":[{"id":"reason","label":"Reason about what information or action is needed to answer the request","explanation":"The planning step, before anything external happens."},{"id":"act","label":"Call the appropriate tool with the right parameters","explanation":"Turns the plan into an actual external action."},{"id":"observe","label":"Read the tool''s result","explanation":"Brings new information back into the loop."},{"id":"decide","label":"Decide whether to answer now or reason again with the new information","explanation":"The loop either closes here or repeats."}],"task":"Order the agent loop."}'::jsonb, '{"correctOrderIds":["reason","act","observe","decide"]}'::jsonb),

  ('mission-w71-05-o1-c1', 'mission-w71-05-o1', 1, 'multiple_choice', 'The exact same prompt produces slightly different answers across two runs. What setting most directly explains this?', '{"question":"The exact same prompt produces slightly different answers across two runs. What setting most directly explains this?","options":[{"id":"a","text":"The model''s temperature setting, which controls how much randomness is introduced when selecting each next token"},{"id":"b","text":"The time of day"},{"id":"c","text":"The color of the user interface"},{"id":"d","text":"Nothing -- identical prompts always produce identical output"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-w71-06-o1-c1', 'mission-w71-06-o1', 1, 'interactive_diagram', 'Trace the complete path from question to answer.', '{"hotspots":[{"id":"input","label":"User question arrives as raw text","explanation":"The starting point -- entirely untrusted input."},{"id":"tokenize","label":"Text is tokenized and embedded into vectors","explanation":"Converts the question into a form the retrieval and reasoning steps can use."},{"id":"retrieve","label":"Relevant passages are retrieved from the vector database","explanation":"Brings in outside knowledge the model doesn''t have memorized."},{"id":"reason_act","label":"The model reasons over the question and retrieved context, optionally calling tools","explanation":"Where the actual decision-making and any external actions happen."},{"id":"answer","label":"A final answer is generated and returned to the user","explanation":"The end of the path -- but not necessarily the end of the trust chain."}],"task":"Order the complete path from question to answer."}'::jsonb, '{"correctOrderIds":["input","tokenize","retrieve","reason_act","answer"]}'::jsonb),

  ('mission-w71-06-o2-c1', 'mission-w71-06-o2', 1, 'drag_and_drop', 'Select every stage where a security control is actually needed.', '{"items":[{"id":"ctrl1","text":"Validating and sanitizing the raw user input before it''s processed"},{"id":"ctrl2","text":"Verifying retrieved content comes from a trusted source before it influences reasoning"},{"id":"ctrl3","text":"Restricting which tools the model can call and with what permissions"},{"id":"ctrl4","text":"Reviewing the final answer for unsafe content or unintended data exposure before it reaches the user"}],"targets":[{"id":"needed","label":"A real control point"}]}'::jsonb, '{"correctMapping":{"ctrl1":"needed","ctrl2":"needed","ctrl3":"needed","ctrl4":"needed"}}'::jsonb),

  ('mission-w71-06-o3-c1', 'mission-w71-06-o3', 1, 'boss_encounter', 'Confirm the complete path and the control placement together.', '{"stages":[{"objectiveRef":"mission-w71-06-o1","label":"The complete path"},{"objectiveRef":"mission-w71-06-o2","label":"Where controls belong"}],"task":"Confirm the complete path and the control placement together."}'::jsonb, '{"requiredObjectiveIds":["mission-w71-06-o1","mission-w71-06-o2"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-w71-01-o1-c1', 'orientation', 'There''s nothing to solve here -- just confirm you''ve heard Byte out.', 0, 1),

  ('mission-w71-02-o1-c1', 'orientation', 'Ask what happens to text first, then what the numbers actually represent, then where they''re stored for search.', 15, 1),
  ('mission-w71-02-o1-c1', 'solution', 'A token is the processed unit of text, an embedding is its numeric meaning-representation, and a vector database is where those embeddings live to be searched.', 25, 2),

  ('mission-w71-03-o1-c1', 'orientation', 'Confidence of tone isn''t the same as relevance to the specific question asked.', 15, 1),
  ('mission-w71-03-o1-c1', 'solution', 'Passage A directly states the specific RTO figure asked about -- Passage B sounds plausible but is generic and never actually answers the question.', 25, 2),

  ('mission-w71-04-o1-c1', 'orientation', 'The agent has to know what it needs before it can go get it, and see what it got before deciding what''s next.', 15, 1),
  ('mission-w71-04-o1-c1', 'solution', 'Reason about what''s needed, act by calling a tool, observe the result, then decide whether to answer or loop again.', 25, 2),

  ('mission-w71-05-o1-c1', 'orientation', 'Ask what setting is specifically designed to control randomness in next-token selection.', 15, 1),
  ('mission-w71-05-o1-c1', 'solution', 'Temperature directly controls how much randomness enters token selection -- higher temperature means more variation between runs of the identical prompt. Option a.', 25, 2),

  ('mission-w71-06-o1-c1', 'orientation', 'Follow the question from the moment it arrives to the moment an answer leaves.', 15, 1),
  ('mission-w71-06-o1-c1', 'solution', 'Raw input -> tokenize/embed -> retrieve relevant context -> reason and optionally act with tools -> generate the final answer.', 25, 2),

  ('mission-w71-06-o2-c1', 'orientation', 'Ask, at every single stage, what happens if what arrives there can''t be trusted.', 15, 1),
  ('mission-w71-06-o2-c1', 'solution', 'Every stage handles something that could be attacker-influenced -- the input, the retrieved context, the tools available, and the final output -- so every stage needs its own control.', 25, 2),

  ('mission-w71-06-o3-c1', 'orientation', 'You''ve already traced the path and placed the controls -- combine them.', 20, 1),
  ('mission-w71-06-o3-c1', 'solution', 'The path runs from raw input, through tokenization, retrieval, reasoning and tool use, to a final answer -- and every one of those five stages needs its own control, because every one of them extends trust to something that could be manipulated.', 35, 2);
