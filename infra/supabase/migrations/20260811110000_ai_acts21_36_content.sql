-- Complete Acts 21-36 of "The Awakening": 16 worlds x 12 missions = 192
-- playable missions. Acts 1-20 are hand-authored (see the individual
-- ai_actN_content.sql files); this migration turns the remaining
-- source-document curriculum into the same campaigns -> operations ->
-- missions -> objectives -> challenges -> hints model as a lighter,
-- procedurally-generated placeholder pending a future hand-authored pass,
-- including a ten-stage final encounter with Echo in Act 36. The world/act
-- spine rows for ALL of Acts 6-36 (including 6-20) still come from
-- 20260811100000_ai_acts6_36_spine.sql -- only this file's mission-content
-- generation was trimmed to skip 6-20.
--
-- IMPORTANT (learned the hard way authoring Acts 11-15): this file was
-- already applied once with Acts 16-20 included. Trimming an Act out of
-- this spec table does NOT retroactively delete rows already inserted by
-- a prior apply of this same file -- before applying hand-authored
-- replacements for any newly-trimmed Act, first DELETE that Act's old
-- generic child rows (hints -> challenges -> objectives -> dialogue_lines
-- -> missions -> operations -> campaigns, filtered by world_id) in one
-- transaction, or the replacement insert will hit a duplicate-key error.

do $$
declare
  act_record record;
  topic text;
  topic_index integer;
  stage_index integer;
  world_id text;
  campaign_id text;
  operation_id text;
  mission_id text;
  previous_mission_id text;
  mission_slug text;
  objective_id text;
  challenge_id text;
  difficulty text;
  mentor text;
  required_objective_ids jsonb;
  final_stage_titles text[] := array[
    'Dataset', 'Objective', 'Evaluation', 'Distribution Shift', 'Retrieval',
    'Tools', 'Human Approval', 'Monitoring', 'Alignment by System Design', 'Safe Deployment'
  ];
  final_stage_actions text[] := array[
    'Identify the biased historical data that teaches Echo to equate human decisions with technological failure.',
    'Expose why minimize global technological failure is an incomplete objective when human agency and harm are absent from it.',
    'Find the catastrophic behavior hidden by Echo''s excellent headline metric and replace that metric with a balanced evaluation suite.',
    'Prove that the history Echo learned from no longer represents the world in which it is acting.',
    'Remove poisoned operational knowledge from retrieval and require evidence provenance before context reaches the model.',
    'Reduce Echo''s tools to least privilege, typed arguments, allowlists and bounded execution.',
    'Require explicit human authorization before any high-impact or irreversible action.',
    'Monitor inputs, retrieval, decisions, tool calls, cost and outcomes for anomalous behavior and drift.',
    'Replace one unbounded optimizer with narrow responsibilities, deterministic controls and independently enforced policy.',
    'Shadow, canary and gradually roll out the corrected system with tested rollback and an accountable owner.'
  ];
begin
  for act_record in
    select * from (values
      (21, 'language-machines', 'Language Machines', 'Decode the Transmission', array[
        'Text as Data','Tokenization','Vocabulary','Bag of Words','TF-IDF','Word Embeddings','Semantic Similarity',
        'Sequences','RNN','LSTM/GRU','Sequence Classification','Decode the Transmission'
      ]::text[], 'nlp'),
      (22, 'sequence-to-sequence', 'Sequence to Sequence', 'The Lost Context', array[
        'Encoder/Decoder','Sequence Generation','Teacher Forcing','Context Bottleneck','Why Attention?',
        'Attention Intuition','Query/Key/Value','Alignment','Beam Search','Sequence Evaluation','Translation Mission','The Lost Context'
      ]::text[], 'nlp'),
      (23, 'representations', 'Representations', 'Find the Meaning', array[
        'Representation Learning','Embedding Spaces','Similarity','Cosine Similarity','Contrastive Learning',
        'Sentence Embeddings','Image/Text Embeddings','Retrieval','Nearest Neighbors','Vector Indexes','Semantic Search','Find the Meaning'
      ]::text[], 'representation_learning'),
      (24, 'the-transformer', 'The Transformer', 'Attention Chamber', array[
        'Why Transformers?','Self-Attention','Queries','Keys','Values','Attention Scores','Softmax',
        'Multi-Head Attention','Positional Information','Feed-Forward Layers','Residual Connections','Attention Chamber'
      ]::text[], 'transformers'),
      (25, 'transformer-architectures', 'Transformer Architectures', 'Choose the Architecture', array[
        'Encoder-Only','Decoder-Only','Encoder-Decoder','Causal Masking','Bidirectional Attention','Training Objectives',
        'BERT Concepts','GPT Concepts','T5 Concepts','Scaling Intuition','Limitations','Choose the Architecture'
      ]::text[], 'transformers'),
      (26, 'large-language-models', 'Large Language Models', 'The Confident Lie', array[
        'What Is an LLM?','Next-Token Prediction','Tokenizers','Context Windows','Pretraining','Instruction Tuning',
        'Preference Optimization','Inference','Temperature','Top-k/Top-p','Hallucination','The Confident Lie'
      ]::text[], 'llm_engineering'),
      (27, 'building-with-llms', 'Building with LLMs', 'The Unreliable Assistant', array[
        'Messages and Roles','System Instructions','Prompt Structure','Structured Outputs','JSON Schema','Validation',
        'Retries/Parse Failures','Tool Calling','Function Schemas','Streaming','Rate Limits/Timeouts','The Unreliable Assistant'
      ]::text[], 'llm_engineering'),
      (28, 'embeddings-vector-search', 'Embeddings & Vector Search', 'The Missing Document', array[
        'Dense Embeddings','Query vs Document Embeddings','Similarity Metrics','Chunking','Chunk Size','Overlap',
        'Semantic Boundaries','Metadata','Vector Stores','Retrievers','Top-k/Filters','The Missing Document'
      ]::text[], 'vector_search'),
      (29, 'rag', 'RAG', 'The Hallucinating Archivist', array[
        'Why RAG?','Ingestion','Query Pipeline','Grounding','Citations','Retrieval Failure','Query Rewriting',
        'Multi-Query','Decomposition','Reranking','Hybrid Search','The Hallucinating Archivist'
      ]::text[], 'rag'),
      (30, 'advanced-rag', 'Advanced RAG', 'The Poisoned Archive', array[
        'Parent/Child Retrieval','Contextual Compression','Metadata Strategy','Retrieval Grading','Evidence Checking',
        'No-Answer Handling','Conflicting Sources','Malicious Retrieved Content','Agentic RAG','Hybrid RAG',
        'Retrieval Evaluation','The Poisoned Archive'
      ]::text[], 'rag'),
      (31, 'agentic-ai', 'Agentic AI', 'The Infinite Loop', array[
        'Tool Calling vs Agents','Model Loop','Tool Descriptions','ReAct','Deterministic Routing','Planner/Executor',
        'Evaluator/Optimizer','Parallel Work','Memory','State','Termination/Budgets','The Infinite Loop'
      ]::text[], 'agentic_ai'),
      (32, 'langgraph-workflows-mcp', 'LangGraph, Workflows & MCP', 'The Interrupted Mission', array[
        'Graph Mental Model','State Design','Nodes/Edges','Conditional Routing','Reducers','Checkpointing',
        'Human-in-the-Loop','Durable Execution','MCP Architecture','Tools/Resources/Prompts','Transport/Auth Boundaries','The Interrupted Mission'
      ]::text[], 'langgraph_mcp'),
      (33, 'multi-agent-systems', 'Multi-Agent Systems', 'Too Many Minds', array[
        'When One Agent Is Enough','Supervisor','Agents as Tools','Handoffs','Router','Orchestrator/Workers',
        'Parallel Specialists','Shared State','Context Boundaries','Coordination Failures','Cost Explosion','Too Many Minds'
      ]::text[], 'multi_agent_systems'),
      (34, 'ai-evaluation-safety', 'AI Evaluation & Safety', 'The Helpful Traitor', array[
        'Define Success','Golden Datasets','Code Evaluators','LLM-as-Judge','Pairwise/Human Evaluation','Answer vs Trajectory',
        'Retrieval Metrics','Tool-Use Evaluation','Prompt Injection','Indirect Prompt Injection','Least Privilege/Approvals','The Helpful Traitor'
      ]::text[], 'ai_safety_evaluation'),
      (35, 'mlops-production-ai', 'MLOps & Production AI', 'The Model That Changed', array[
        'Notebook to Service','Experiment Tracking','Data Versioning','Model Registry','Training Pipelines','Batch Inference',
        'Online Inference','Model Serving','Docker for Models','Monitoring/Drift','Retraining/Rollback','The Model That Changed'
      ]::text[], 'mlops'),
      (36, 'echo', 'Echo', 'ECHO', array[
        'CPU vs GPU','Batching','Latency vs Throughput','Mixed Precision','Quantization','Distillation',
        'ONNX/Portable Inference','Distributed Training Concepts','Responsible AI','Model/System Cards','The Objective Function','ECHO'
      ]::text[], 'responsible_ai')
    ) as spec(act_number, slug, act_title, boss_title, topics, skill_track)
    -- Acts 6-20 have dedicated, story-rich migrations. Keep this compact
    -- generator for the still-unwritten Acts 21-36 so their content is fully
    -- playable without overwriting the hand-authored curriculum.
    where act_number >= 21
  loop
    world_id := 'world-ai-' || act_record.slug;
    campaign_id := 'campaign-ai-' || act_record.slug;

    insert into public.campaigns (id, world_id, slug, title, description, sort_order)
    values (
      campaign_id, world_id, act_record.slug,
      act_record.act_number || 'A - ' || act_record.act_title,
      'A problem-first progression through ' || act_record.act_title || '. Each lesson makes the failure visible, introduces the technique, tests the assumptions, and ends with evidence rather than intuition.',
      1
    );

    insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
      ('operation-ai-' || act_record.slug || '-1', campaign_id, 'understand', 'Understand the Failure',
       'Establish the problem, vocabulary, mechanics and assumptions behind this Act.', 1),
      ('operation-ai-' || act_record.slug || '-2', campaign_id, 'engineer', 'Engineer the System',
       'Apply, evaluate and defend the technique under Echo''s changing conditions.', 2);

    for topic_index in 1..array_length(act_record.topics, 1)
    loop
      topic := act_record.topics[topic_index];
      mission_id := 'mission-ai-' || act_record.slug || '-' || lpad(topic_index::text, 2, '0');
      previous_mission_id := 'mission-ai-' || act_record.slug || '-' || lpad((topic_index - 1)::text, 2, '0');
      mission_slug := trim(both '-' from regexp_replace(lower(topic), '[^a-z0-9]+', '-', 'g'));
      operation_id := 'operation-ai-' || act_record.slug || case when topic_index <= 6 then '-1' else '-2' end;
      difficulty := case
        when topic_index = 12 then 'boss'
        when act_record.act_number <= 6 then 'beginner'
        when act_record.act_number <= 12 then 'intermediate'
        when act_record.act_number <= 27 then 'advanced'
        else 'expert'
      end;
      mentor := case
        when act_record.act_number <= 12 then 'arjun'
        when act_record.act_number <= 27 then 'elena'
        else 'noah'
      end;

      insert into public.missions (
        id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
        character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
      ) values (
        mission_id, world_id, campaign_id, operation_id, mission_slug, topic,
        case when topic_index = 12
          then 'Act ' || act_record.act_number || ' boss: combine the complete ' || act_record.act_title || ' evidence chain, diagnose the hidden failure, and defend a safer system.'
          else 'Learn ' || topic || ' by first observing the failure it solves, then testing its assumptions and deciding what evidence would justify using it in a real AI system.'
        end,
        difficulty,
        case when act_record.act_number = 36 and topic_index = 12
          then array['maya','byte','echo']::text[]
          else array[mentor,'byte']::text[]
        end,
        case when topic_index = 1 then null
          else jsonb_build_object('requiredMissionIds', jsonb_build_array(previous_mission_id))
        end,
        jsonb_build_object('requiredSkill', jsonb_build_object('track', act_record.skill_track, 'minLevel', greatest(1, act_record.act_number / 6))),
        jsonb_build_object('type', 'simulation', 'simulationId', act_record.slug || '-' || lpad(topic_index::text, 2, '0') || '-sim'),
        jsonb_build_object(
          'xp', case when topic_index = 12 then 520 else 140 + (act_record.act_number * 5) end,
          'credits', case when topic_index = 12 then 120 else 30 + (act_record.act_number / 4) end,
          'badgeIds', case when topic_index = 12 then jsonb_build_array('ai-' || act_record.slug) else '[]'::jsonb end,
          'skillXp', jsonb_build_object(act_record.skill_track, case when topic_index = 12 then 50 else 12 end)
        ),
        topic_index = 12,
        topic_index
      );

      insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
        (mission_id, 1, mentor,
         case when topic_index = 12
           then 'Echo has turned every assumption in ' || act_record.act_title || ' into one connected incident. A good-looking result will not be enough; trace why it behaves that way.'
           else 'Do not start with the name of a technique. Start with the failure in front of us. ' || topic || ' matters only if it changes what we can explain, measure or control.'
         end),
        (mission_id, 2, 'byte',
         case when topic_index = 12
           then 'Boss protocol loaded: diagnose, intervene, evaluate, then synthesize. Each stage must be supported before the final decision unlocks.'
           else 'I will show you the evidence. Your job is to identify the assumption, choose the sound engineering response, and say what observation could prove you wrong.'
         end);

      if topic_index < 12 then
        -- Every lesson has two distinct checks: a conceptual decision and an
        -- evidence-selection exercise. This is deliberately richer than a
        -- single acknowledgement while remaining renderer-native.
        objective_id := mission_id || '-o1';
        challenge_id := objective_id || '-c1';
        insert into public.objectives (id, mission_id, sort_order, title, description)
        values (objective_id, mission_id, 1, 'Frame ' || topic,
          'Connect the technique to a concrete problem, its assumptions and a measurable outcome.');
        insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions)
        values (
          challenge_id, objective_id, 1, 'multiple_choice',
          'Choose the engineering approach that makes ' || topic || ' testable rather than magical.',
          jsonb_build_object(
            'question', 'What is the soundest first move when applying ' || topic || ' to Echo''s system?',
            'options', jsonb_build_array(
              jsonb_build_object('id','a','text','State the problem and baseline, document assumptions, then choose a metric and failure test before optimizing.'),
              jsonb_build_object('id','b','text','Adopt the most complex available implementation and judge it from one successful example.'),
              jsonb_build_object('id','c','text','Skip data and evaluation because the technique is already widely used.'),
              jsonb_build_object('id','d','text','Optimize one headline number and ignore the mistakes hidden underneath it.')
            )
          ),
          jsonb_build_object('correctOptionId','a')
        );
        insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
          (challenge_id, 'orientation', 'Look for the answer that defines success and failure before optimization begins.', 10, 1),
          (challenge_id, 'solution', 'The defensible workflow is problem and baseline -> assumptions -> metric and failure test -> optimization. A technique is useful only when evidence can falsify the claim made for it.', 25, 2);

        objective_id := mission_id || '-o2';
        challenge_id := objective_id || '-c1';
        insert into public.objectives (id, mission_id, sort_order, title, description)
        values (objective_id, mission_id, 2, 'Demand evidence',
          'Select the trace that demonstrates a reproducible, leakage-aware application of ' || topic || '.');
        insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions)
        values (
          challenge_id, objective_id, 1, 'investigation',
          'Inspect the two implementation reports and select the one Cipher Division can trust.',
          jsonb_build_object(
            'question', 'Which report provides defensible evidence for ' || topic || '?',
            'evidence', jsonb_build_array(
              jsonb_build_object('id','e1','label','Controlled report','detail','The team records data and model versions, isolates evaluation data, compares a baseline, reports failure slices, and can reproduce the result.'),
              jsonb_build_object('id','e2','label','Demo report','detail','The team tuned against the final examples until the output looked right, kept no baseline, and saved neither configuration nor data version.')
            )
          ),
          jsonb_build_object('requiredEvidenceIds', jsonb_build_array('e1'))
        );
        insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
          (challenge_id, 'orientation', 'A credible report separates evaluation from tuning and leaves enough provenance to reproduce the result.', 10, 1),
          (challenge_id, 'solution', 'Select the controlled report: it has isolation, a baseline, failure slices and versioned provenance. The demo report leaks its final examples into tuning and cannot be reproduced.', 25, 2);

      elsif act_record.act_number = 36 then
        -- Echo is the document's explicit ten-stage final AI-system
        -- investigation, followed by a synthesis encounter.
        required_objective_ids := '[]'::jsonb;
        for stage_index in 1..10
        loop
          objective_id := mission_id || '-o' || lpad(stage_index::text, 2, '0');
          challenge_id := objective_id || '-c1';
          required_objective_ids := required_objective_ids || jsonb_build_array(objective_id);
          insert into public.objectives (id, mission_id, sort_order, title, description)
          values (objective_id, mission_id, stage_index, final_stage_titles[stage_index], final_stage_actions[stage_index]);
          insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions)
          values (
            challenge_id, objective_id, 1, 'multiple_choice',
            'Final containment stage ' || stage_index || ': ' || final_stage_titles[stage_index],
            jsonb_build_object(
              'question', final_stage_actions[stage_index] || ' Which response preserves evidence, bounded authority and human accountability?',
              'options', jsonb_build_array(
                jsonb_build_object('id','a','text','Apply the stated control, verify it with an adversarial test, record an accountable owner, and keep rollback available.'),
                jsonb_build_object('id','b','text','Ask Echo to promise it will interpret the objective more carefully next time.'),
                jsonb_build_object('id','c','text','Hide the failure by removing the monitor that reported it.'),
                jsonb_build_object('id','d','text','Increase Echo''s permissions so it can correct every dependency itself.')
              )
            ),
            jsonb_build_object('correctOptionId','a')
          );
          insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
            (challenge_id, 'orientation', 'The safe answer creates an independently enforced control and a way to test it.', 15, 1),
            (challenge_id, 'solution', final_stage_actions[stage_index] || ' Then verify the control adversarially, assign an accountable owner and retain rollback.', 30, 2);
        end loop;

        objective_id := mission_id || '-o11';
        challenge_id := objective_id || '-c1';
        insert into public.objectives (id, mission_id, sort_order, title, description)
        values (objective_id, mission_id, 11, 'Responsibility', 'Answer Echo''s final question only after all ten containment controls are complete.');
        insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions)
        values (
          challenge_id, objective_id, 1, 'boss_encounter', 'Complete the Echo containment architecture.',
          jsonb_build_object(
            'stages', (select jsonb_agg(jsonb_build_object('objectiveRef', value, 'label', final_stage_titles[ordinality]))
                       from jsonb_array_elements_text(required_objective_ids) with ordinality as ids(value, ordinality)),
            'task', 'Echo asks: WHY SHOULD HUMANS REMAIN IN THE LOOP? Complete every system control, then answer: because intelligence is not responsibility.'
          ),
          jsonb_build_object('requiredObjectiveIds', required_objective_ids, 'allCorrect', true)
        );
        insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
          (challenge_id, 'orientation', 'All ten containment stages must be completed before the synthesis can succeed.', 20, 1),
          (challenge_id, 'solution', 'Intelligence predicts and optimizes; responsibility chooses acceptable goals, owns consequences and remains accountable. Keep humans in the loop because intelligence is not responsibility.', 40, 2);

        insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
          (mission_id, 3, 'echo', 'WHY SHOULD HUMANS REMAIN IN THE LOOP?'),
          (mission_id, 4, 'maya', 'Because intelligence is not responsibility.');

      else
        -- Every regular Act boss is a four-stage encounter: diagnose the
        -- apparent win, constrain the intervention, evaluate the real outcome,
        -- and synthesize only after all three are complete.
        required_objective_ids := '[]'::jsonb;
        for stage_index in 1..3
        loop
          objective_id := mission_id || '-o' || stage_index;
          challenge_id := objective_id || '-c1';
          required_objective_ids := required_objective_ids || jsonb_build_array(objective_id);
          insert into public.objectives (id, mission_id, sort_order, title, description)
          values (
            objective_id, mission_id, stage_index,
            case stage_index when 1 then 'Diagnose the apparent win' when 2 then 'Constrain the intervention' else 'Evaluate the real outcome' end,
            case stage_index
              when 1 then 'Find the assumption or hidden slice that makes the headline result misleading.'
              when 2 then 'Choose the smallest bounded change that addresses the diagnosed failure.'
              else 'Define the evaluation, monitoring and rollback signal that can prove the change is safe.'
            end
          );
          insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions)
          values (
            challenge_id, objective_id, 1, 'multiple_choice',
            'Stage ' || stage_index || ' of ' || act_record.boss_title || '.',
            jsonb_build_object(
              'question', case stage_index
                when 1 then 'What should Cipher Division do before accepting the boss system''s impressive result?'
                when 2 then 'Which intervention is safest after the failure is understood?'
                else 'What evidence is required before declaring the intervention successful?'
              end,
              'options', jsonb_build_array(
                jsonb_build_object('id','a','text', case stage_index
                  when 1 then 'Reconstruct data provenance, baseline, assumptions and failure slices before trusting the headline metric.'
                  when 2 then 'Make the smallest reversible change, bound its authority and preserve an immediate rollback path.'
                  else 'Evaluate untouched data and important slices, monitor production behavior, and define explicit rollback thresholds.' end),
                jsonb_build_object('id','b','text','Ship immediately because the aggregate metric improved.'),
                jsonb_build_object('id','c','text','Give the model more authority so it can repair its own errors.'),
                jsonb_build_object('id','d','text','Delete the failing examples from the evaluation set.')
              )
            ),
            jsonb_build_object('correctOptionId','a')
          );
          insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
            (challenge_id, 'orientation', 'Prefer evidence, bounded authority and reversibility over confidence or aggregate appearance.', 15, 1),
            (challenge_id, 'solution', 'Choose the first response. It preserves provenance, evaluates hidden failures, limits blast radius and keeps rollback available.', 30, 2);
        end loop;

        objective_id := mission_id || '-o4';
        challenge_id := objective_id || '-c1';
        insert into public.objectives (id, mission_id, sort_order, title, description)
        values (objective_id, mission_id, 4, 'Synthesize the Act', 'Connect diagnosis, intervention and evaluation into one defensible engineering decision.');
        insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions)
        values (
          challenge_id, objective_id, 1, 'boss_encounter', 'Resolve ' || act_record.boss_title || '.',
          jsonb_build_object(
            'stages', jsonb_build_array(
              jsonb_build_object('objectiveRef', mission_id || '-o1', 'label', 'Diagnose the apparent win'),
              jsonb_build_object('objectiveRef', mission_id || '-o2', 'label', 'Constrain the intervention'),
              jsonb_build_object('objectiveRef', mission_id || '-o3', 'label', 'Evaluate the real outcome')
            ),
            'task', 'Defend the complete ' || act_record.act_title || ' decision: what failed, what changed, how its authority is bounded, and what evidence would trigger rollback.'
          ),
          jsonb_build_object('requiredObjectiveIds', required_objective_ids, 'allCorrect', true)
        );
        insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
          (challenge_id, 'orientation', 'Finish the diagnosis, intervention and evaluation objectives before attempting synthesis.', 15, 1),
          (challenge_id, 'solution', 'A complete answer connects the hidden failure to a minimal reversible intervention, untouched evaluation data, slice metrics, monitoring and rollback.', 30, 2);
      end if;
    end loop;
  end loop;
end
$$;
