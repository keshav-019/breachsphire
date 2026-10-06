-- Make the existing post-game framework pathway-aware, then seed the AI/ML
-- source document's specialist tracks, design arena and portfolio campaigns.
-- Cipher-specific incident and interview practice use purpose-built tables.

alter table public.system_design_challenges
  add column pathway_id text references public.pathways (id) default 'pathway-backend';
update public.system_design_challenges set pathway_id = 'pathway-backend' where pathway_id is null;
alter table public.system_design_challenges alter column pathway_id set not null;
alter table public.system_design_challenges alter column pathway_id drop default;
alter table public.system_design_challenges drop constraint system_design_challenges_slug_key;
alter table public.system_design_challenges drop constraint system_design_challenges_sort_order_key;
alter table public.system_design_challenges add constraint system_design_challenges_pathway_slug_key unique (pathway_id, slug);
alter table public.system_design_challenges add constraint system_design_challenges_pathway_order_key unique (pathway_id, sort_order);

alter table public.portfolio_campaigns
  add column pathway_id text references public.pathways (id) default 'pathway-backend';
update public.portfolio_campaigns set pathway_id = 'pathway-backend' where pathway_id is null;
alter table public.portfolio_campaigns alter column pathway_id set not null;
alter table public.portfolio_campaigns alter column pathway_id drop default;
alter table public.portfolio_campaigns drop constraint portfolio_campaigns_slug_key;
alter table public.portfolio_campaigns drop constraint portfolio_campaigns_sort_order_key;
alter table public.portfolio_campaigns add constraint portfolio_campaigns_pathway_slug_key unique (pathway_id, slug);
alter table public.portfolio_campaigns add constraint portfolio_campaigns_pathway_order_key unique (pathway_id, sort_order);

alter table public.language_tracks
  add column pathway_id text references public.pathways (id) default 'pathway-backend';
update public.language_tracks set pathway_id = 'pathway-backend' where pathway_id is null;
alter table public.language_tracks alter column pathway_id set not null;
alter table public.language_tracks alter column pathway_id drop default;
alter table public.language_tracks drop constraint language_tracks_slug_key;
alter table public.language_tracks drop constraint language_tracks_sort_order_key;
alter table public.language_tracks add constraint language_tracks_pathway_slug_key unique (pathway_id, slug);
alter table public.language_tracks add constraint language_tracks_pathway_order_key unique (pathway_id, sort_order);

with shared as (
  select
    '[
      {"id":"foundation","label":"Foundation","description":"Design a correct first system with explicit data and evaluation contracts.","constraints":["Single region","Moderate traffic","Prefer operational simplicity"]},
      {"id":"scale","label":"At Scale","description":"Evolve the design for global volume, cost and uneven traffic.","constraints":["Global users","10x traffic growth","Bound accelerator and provider cost"]},
      {"id":"incident","label":"Incident Inject","description":"Defend the design while its most important model or data dependency is failing.","constraints":["One critical dependency is degraded","Predictions must remain safe","Recovery cannot corrupt state"]},
      {"id":"interview","label":"Interview","description":"Make and defend the design under ambiguity and time pressure.","constraints":["35-minute window","State assumptions first","One requirement changes mid-design"]}
    ]'::jsonb as modes,
    '[
      {"key":"requirements","label":"Requirements & data","description":"Defines the product decision, data contract and capacity assumptions.","weight":20,"keywords":["requirement","data","label","traffic","retention","privacy"]},
      {"key":"architecture","label":"Model & architecture","description":"Chooses a coherent model and serving path.","weight":25,"keywords":["model","feature","embedding","service","pipeline","api"]},
      {"key":"evaluation","label":"Evaluation","description":"Defines offline, online and slice-aware proof.","weight":20,"keywords":["baseline","metric","evaluation","slice","experiment","calibration"]},
      {"key":"reliability","label":"Production reliability","description":"Handles dependency failure, scale, drift and recovery.","weight":20,"keywords":["monitor","drift","fallback","rollback","cache","queue"]},
      {"key":"safety","label":"Safety & tradeoffs","description":"Bounds authority, misuse, privacy, cost and human responsibility.","weight":15,"keywords":["safety","approval","permission","tradeoff","cost","human"]}
    ]'::jsonb as rubric
), challenge_specs (id, slug, title, domain, summary, functional_requirements, nonfunctional_requirements, estimated_minutes, sort_order) as (values
  ('arena-ai-recommendations','recommendation-system','Design a Recommendation System','Ranking & personalization','Rank useful items while avoiding feedback loops, stale interests and popularity collapse.',
   '["Generate a personalized ranked feed","Incorporate explicit and implicit feedback","Support cold-start users and items","Explain or audit recommendation reasons"]'::jsonb,
   '["Low-latency ranking","Fresh features","Offline and online evaluation","Diversity, fairness and feedback-loop controls"]'::jsonb,60,1),
  ('arena-ai-fraud','fraud-detection','Design a Fraud Detection System','Risk & classification','Score transactions in real time while investigators, labels and attackers all move at different speeds.',
   '["Score each transaction","Block, challenge or allow by threshold","Collect delayed investigator labels","Support manual review queues"]'::jsonb,
   '["Sub-100 ms decisions","Extreme class imbalance","Calibration and cost-sensitive thresholds","Drift and adversarial adaptation"]'::jsonb,60,2),
  ('arena-ai-search-ranking','search-ranking','Design Search Ranking','Retrieval & ranking','Retrieve and rank relevant results with measurable quality, freshness and latency.',
   '["Index documents","Retrieve candidates","Rank results per query","Collect relevance feedback"]'::jsonb,
   '["Fast p99 latency","Fresh index","Explainable offline metrics","Safe online experimentation"]'::jsonb,55,3),
  ('arena-ai-image-moderation','image-moderation','Design Image Moderation','Computer vision','Detect unsafe imagery with human escalation, regional policy and error-sensitive thresholds.',
   '["Classify uploaded images","Route uncertain cases to review","Apply policy by market","Record decisions and appeals"]'::jsonb,
   '["High recall for severe harm","Bound false positives","Privacy-aware storage","Auditable model and policy versions"]'::jsonb,60,4),
  ('arena-ai-semantic-search','semantic-search','Design Semantic Search','Embeddings & retrieval','Build hybrid semantic search with versioned embeddings, metadata filters and evaluation.',
   '["Ingest and chunk content","Run lexical and vector retrieval","Filter by permissions","Rerank and cite results"]'::jsonb,
   '["Permission-safe retrieval","Embedding migration strategy","Measurable relevance","Fresh and observable indexes"]'::jsonb,60,5),
  ('arena-ai-enterprise-rag','enterprise-rag','Design Enterprise RAG','Knowledge systems','Answer from private enterprise knowledge with citations, authorization and no-answer behavior.',
   '["Ingest many document formats","Retrieve authorized evidence","Generate cited answers","Decline when evidence is insufficient"]'::jsonb,
   '["No cross-tenant leakage","Prompt-injection resistance","Freshness and provenance","End-to-end evaluation"]'::jsonb,70,6),
  ('arena-ai-support-llm','customer-support-llm','Design a Customer Support LLM','LLM applications','Resolve support requests using customer context, tools and safe escalation.',
   '["Understand requests","Retrieve policy","Call account tools","Escalate uncertain or high-risk cases"]'::jsonb,
   '["Low hallucination rate","PII controls","Bounded tool permissions","Cost and latency budgets"]'::jsonb,65,7),
  ('arena-ai-coding-assistant','coding-assistant','Design a Coding Assistant','Developer AI','Provide repository-aware suggestions and tools without leaking code or executing unsafe changes.',
   '["Index authorized repositories","Answer code questions","Propose patches","Run bounded developer tools"]'::jsonb,
   '["Repository isolation","Low-latency streaming","Secure tool sandbox","Acceptance and regression evaluation"]'::jsonb,70,8),
  ('arena-ai-multi-agent-research','multi-agent-research','Design a Multi-Agent Research System','Agentic systems','Coordinate research specialists while containing context loss, duplication, cost and false synthesis.',
   '["Plan a research brief","Delegate independent investigations","Track evidence provenance","Synthesize and critique findings"]'::jsonb,
   '["Explicit termination","Bounded parallelism and cost","No unsupported claims","Recoverable shared state"]'::jsonb,70,9),
  ('arena-ai-realtime-fraud','realtime-fraud-model','Design a Realtime Fraud Model','Streaming ML','Join live and historical features for reliable low-latency fraud decisions.',
   '["Consume transaction events","Compute online features","Score and enforce a decision","Capture outcomes for training"]'::jsonb,
   '["Very low latency","Point-in-time correct features","Training-serving parity","Graceful feature-store failure"]'::jsonb,70,10),
  ('arena-ai-vision-inspection','vision-inspection-platform','Design a Vision Inspection Platform','Industrial vision','Train, deploy and monitor inspection models across changing cameras, products and edge devices.',
   '["Collect and label defects","Train versioned models","Serve at the edge","Route uncertain cases to inspectors"]'::jsonb,
   '["Real-time inference","Camera and lighting drift detection","Offline operation","Safe staged rollout"]'::jsonb,70,11),
  ('arena-ai-global-inference','global-ai-inference-platform','Design a Global AI Inference Platform','AI platform','Serve heterogeneous models globally with routing, batching, isolation, observability and cost controls.',
   '["Register and deploy models","Route by capability and tenant","Support streaming and batch jobs","Expose usage and evaluation traces"]'::jsonb,
   '["Multi-region reliability","GPU utilization","Tenant isolation","Versioned rollback and cost budgets"]'::jsonb,80,12)
)
insert into public.system_design_challenges (
  id, slug, title, domain, summary, prompt, context, functional_requirements,
  nonfunctional_requirements, modes, rubric, estimated_minutes, sort_order, pathway_id
)
select id, slug, title, domain, summary,
  'Design the complete production system for: ' || title || '. State assumptions before selecting data, models or infrastructure.',
  'Cipher Division will judge the design as an operating AI system, not a model diagram. Cover data, evaluation, serving, monitoring, safety, cost and failure recovery.',
  functional_requirements, nonfunctional_requirements, shared.modes, shared.rubric,
  estimated_minutes, sort_order, 'pathway-ai'
from challenge_specs cross join shared;

with campaign_specs (
  id, slug, title, tagline, summary, stack_options, outcomes, milestones, sort_order
) as (values
  ('portfolio-ai-classical-ml','classical-ml-service','Project I -- Classical ML Service','From dataset to monitored prediction API.','Build a reproducible classical-ML service with tested preprocessing, evaluation, serving and model provenance.',
   array['Python + scikit-learn + FastAPI','Python + XGBoost + Flask'],
   '["Reproducible training","Leakage-safe pipeline","Honest evaluation","Tested prediction API","Model and data provenance"]'::jsonb,
   array['Define the prediction contract','Build the dataset and baseline','Train and evaluate the pipeline','Ship the API and tests','Add monitoring and documentation'],1),
  ('portfolio-ai-vision','vision-system','Project II -- Vision System','Train, evaluate and serve transfer learning.','Build an image system using transfer learning, slice-aware evaluation and an inference service.',
   array['PyTorch + FastAPI','TensorFlow/Keras + TensorFlow Serving'],
   '["Versioned labeled images","Transfer-learning experiment","Class and slice metrics","Inference endpoint","Drift and failure plan"]'::jsonb,
   array['Specify labels and failure cost','Create the data pipeline','Fine-tune and evaluate','Package inference','Document drift and rollout'],2),
  ('portfolio-ai-semantic','semantic-search','Project III -- Semantic Search','Meaning, indexing and measured retrieval.','Build permission-aware semantic or hybrid search with an explicit retrieval evaluation set.',
   array['Python + pgvector','Python + Qdrant','Python + OpenSearch'],
   '["Chunking experiment","Versioned embeddings","Filtered retrieval","Relevance evaluation","Observable search API"]'::jsonb,
   array['Define search and relevance','Build ingestion and chunking','Index embeddings and metadata','Evaluate retrieval','Ship and observe the API'],3),
  ('portfolio-ai-rag','production-rag','Project IV -- Production RAG','Citations, evaluation and adversarial retrieval.','Build a grounded RAG service with hybrid retrieval, reranking, citations, no-answer behavior and evals.',
   array['Python + FastAPI + pgvector','Python + LangChain/LangGraph','Python + LlamaIndex'],
   '["Reliable ingestion","Hybrid retrieval and reranking","Cited generation","Golden evaluation set","Injection and no-answer tests"]'::jsonb,
   array['Define the knowledge contract','Build ingestion','Build retrieval and reranking','Add generation and citations','Evaluate safety and quality'],4),
  ('portfolio-ai-agent','ai-agent','Project V -- AI Agent','Tools, state, guardrails and trajectory evals.','Build a bounded agent workflow with typed tools, durable state, approvals, budgets and trajectory evaluation.',
   array['Python + LangGraph','TypeScript + agent SDK','Python + custom workflow'],
   '["Typed least-privilege tools","Recoverable state","Human approval boundary","Termination and budgets","Trajectory evaluation"]'::jsonb,
   array['Define the task boundary','Implement tools and schemas','Build stateful orchestration','Add approvals and budgets','Evaluate full trajectories'],5),
  ('portfolio-ai-platform','production-ai-platform','Project VI -- Production AI Platform','One operated system, not six notebooks.','Integrate a model service, RAG, agents, evaluation, caching, observability and staged deployment.',
   array['Python + Kubernetes','Python + managed cloud AI','Polyglot services + OpenTelemetry'],
   '["Versioned AI gateway","Model and retrieval services","Bounded agent workflows","Evaluation and observability","Canary, rollback and cost controls"]'::jsonb,
   array['Write the platform contracts','Integrate model and retrieval services','Add workflow orchestration','Build evaluation and telemetry','Deploy with canary and rollback'],6)
), inserted_campaigns as (
  insert into public.portfolio_campaigns (
    id, slug, title, tagline, summary, stack_options, outcomes, sort_order, pathway_id
  )
  select id, slug, title, tagline, summary, stack_options, outcomes, sort_order, 'pathway-ai'
  from campaign_specs
  returning id
)
insert into public.portfolio_milestones (id, campaign_id, title, description, deliverable, sort_order)
select
  specs.id || '-m' || milestone.ordinality,
  specs.id,
  milestone.value,
  'Complete this production step and record the decision, evidence and failure mode that shaped it.',
  'Repository evidence for: ' || milestone.value,
  milestone.ordinality
from campaign_specs specs
cross join lateral unnest(specs.milestones) with ordinality as milestone(value, ordinality)
join inserted_campaigns on inserted_campaigns.id = specs.id;

with track_specs (
  id, slug, title, framework, description, icon, estimated_hours, capstone, modules, sort_order
) as (values
  ('track-ai-math','mathematics-lab','Mathematics Lab','Linear algebra + calculus + probability','Visual, interactive mathematics for model reasoning rather than a prerequisite wall.','Binary',24,'Build an interactive optimization and representation notebook that explains every operation geometrically.',
   array['Vectors, matrices and tensors','Calculus and gradients','Probability and statistics','Optimization landscapes','SVD and eigen intuition'],1),
  ('track-ai-pytorch','pytorch-specialist','PyTorch Specialist','PyTorch','Explicit training systems from tensor operations through export, profiling and scale.','Flame',30,'Train, profile, optimize and export a custom PyTorch model with a production inference path.',
   array['Tensor operations and devices','Dataset and DataLoader','Custom modules and losses','Mixed precision and profiling','Transfer learning and export'],2),
  ('track-ai-tensorflow','tensorflow-specialist','TensorFlow Specialist','TensorFlow/Keras','Production TensorFlow from tf.data through custom loops, TensorBoard and serving.','Workflow',30,'Build a custom Keras training pipeline and export it for TFLite or serving.',
   array['Tensors and tf.data','Sequential and Functional APIs','Custom layers and GradientTape','Callbacks and TensorBoard','GPU training and serving'],3),
  ('track-ai-vision','computer-vision-specialist','Computer Vision Specialist','PyTorch/TensorFlow + OpenCV','Classification, detection, segmentation, vision transformers and edge inference.','Image',32,'Build a vision inspection system with transfer learning, uncertainty handling and edge deployment.',
   array['CNN design and augmentation','Transfer learning and imbalance','Detection and IoU','Segmentation and U-Net','Vision transformers and edge inference'],4),
  ('track-ai-nlp','nlp-specialist','NLP Specialist','Transformers + NLP toolkit','From preprocessing and NER through transformers, semantic search and generation.','MessageSquare',30,'Build an evaluated domain language system with retrieval and a fine-tuned task model.',
   array['Tokenization and text features','Embeddings and classification','NER and sequence models','Attention and transformers','Semantic search and generation'],5),
  ('track-ai-llm','llm-engineering-specialist','LLM Engineering Specialist','Provider APIs + structured generation','Reliable LLM application engineering across providers, tools, routing, latency, cost, safety and evaluation.','Bot',28,'Ship a provider-resilient assistant with structured output, tools, routing, caching and evals.',
   array['Models, messages and prompts','Structured outputs and validation','Tools, streaming and retries','Routing, caching, latency and cost','Safety and evaluation'],6),
  ('track-ai-rag','rag-specialist','RAG Specialist','Vector + lexical retrieval','Advanced retrieval engineering from parsing and chunking through adversarial evaluation.','Search',30,'Ship an adversarially tested hybrid RAG system with citations and a retrieval scorecard.',
   array['Parsing and chunking experiments','Embeddings, metadata and indexes','Hybrid search and reranking','Advanced retrieval patterns','Citations, grading and adversarial evals'],7),
  ('track-ai-agents','agentic-ai-specialist','Agentic AI Specialist','LangGraph + MCP','Bounded tool-using systems, durable state, human interrupts, multi-agent patterns and observability.','Network',34,'Build a durable, budgeted agent workflow with MCP tools, approval boundaries and trajectory evaluation.',
   array['Raw loops and typed tools','Deterministic and agentic workflows','LangGraph state and checkpointing','MCP boundaries and memory','Multi-agent security and observability'],8),
  ('track-ai-mlops','mlops-specialist','MLOps Specialist','MLflow/DVC + serving platform','Versioned training, registries, serving, monitoring, rollout and retraining.','Cloud',34,'Operate a versioned model from training pipeline through canary, monitoring, rollback and retraining.',
   array['Experiment and data versioning','Registries and training jobs','Packaging and serving','Monitoring, drift and experiments','Canary, rollback and retraining'],9)
), inserted_tracks as (
  insert into public.language_tracks (
    id, slug, title, language, framework, description, icon, estimated_hours, capstone, sort_order, pathway_id
  )
  select id, slug, title, 'AI/ML', framework, description, icon, estimated_hours, capstone, sort_order, 'pathway-ai'
  from track_specs
  returning id
)
insert into public.language_track_modules (id, track_id, title, description, focus, project_step, sort_order)
select
  specs.id || '-m' || module.ordinality,
  specs.id,
  module.value,
  'Study the mechanics, reproduce a failure, implement the technique, and record the evidence that shows when it should or should not be used.',
  jsonb_build_array(module.value, 'failure analysis', 'evaluation', 'production constraints'),
  'Add ' || module.value || ' to the track capstone with tests, metrics and a short design note.',
  module.ordinality
from track_specs specs
cross join lateral unnest(specs.modules) with ordinality as module(value, ordinality)
join inserted_tracks on inserted_tracks.id = specs.id;

create table public.ai_on_call_incidents (
  id text primary key,
  slug text not null unique,
  title text not null,
  symptom text not null,
  evidence jsonb not null,
  expected_signals jsonb not null,
  resolution text not null,
  difficulty text not null check (difficulty in ('foundation','intermediate','advanced','critical')),
  sort_order integer not null unique
);

create table public.player_ai_incident_attempts (
  id uuid primary key default gen_random_uuid(),
  player_id uuid not null references auth.users (id) on delete cascade,
  incident_id text not null references public.ai_on_call_incidents (id) on delete cascade,
  diagnosis text not null,
  mitigation text not null,
  score integer not null check (score between 0 and 100),
  feedback jsonb not null,
  created_at timestamptz not null default now()
);
create index player_ai_incident_attempts_player_idx on public.player_ai_incident_attempts (player_id, incident_id, created_at desc);

create table public.ai_interview_questions (
  id text primary key,
  question text not null,
  focus text not null,
  expected_signals jsonb not null,
  sort_order integer not null unique
);

create table public.player_ai_interview_attempts (
  id uuid primary key default gen_random_uuid(),
  player_id uuid not null references auth.users (id) on delete cascade,
  question_id text not null references public.ai_interview_questions (id) on delete cascade,
  answer text not null,
  score integer not null check (score between 0 and 100),
  matched_signals jsonb not null,
  feedback jsonb not null,
  created_at timestamptz not null default now()
);
create index player_ai_interview_attempts_player_idx on public.player_ai_interview_attempts (player_id, question_id, created_at desc);

alter table public.ai_on_call_incidents enable row level security;
alter table public.player_ai_incident_attempts enable row level security;
alter table public.ai_interview_questions enable row level security;
alter table public.player_ai_interview_attempts enable row level security;
create policy "AI incidents are viewable by authenticated users" on public.ai_on_call_incidents for select to authenticated using (true);
create policy "AI incident attempts viewable by owner" on public.player_ai_incident_attempts for select using (auth.uid() = player_id);
create policy "AI incident attempts insertable by owner" on public.player_ai_incident_attempts for insert with check (auth.uid() = player_id);
create policy "AI interview questions are viewable by authenticated users" on public.ai_interview_questions for select to authenticated using (true);
create policy "AI interview attempts viewable by owner" on public.player_ai_interview_attempts for select using (auth.uid() = player_id);
create policy "AI interview attempts insertable by owner" on public.player_ai_interview_attempts for insert with check (auth.uid() = player_id);

with incident_specs (title, symptom, difficulty, signals, resolution) as (values
  ('NaN training loss','Training is stable for several steps, then loss becomes NaN.','foundation',array['learning rate','normalization','gradient','input'],'Inspect inputs and gradients, lower the learning rate, add numerical guards, and resume only from a known-good checkpoint.'),
  ('GPU OOM','A training job is killed when the first large batch reaches the accelerator.','foundation',array['batch','memory','activation','precision'],'Measure peak memory, reduce batch or sequence size, use accumulation or mixed precision, and verify throughput after the change.'),
  ('Overfitting','Training quality improves while validation quality gets steadily worse.','foundation',array['validation','gap','regularization','data'],'Confirm the split, plot learning curves, add data or regularization, and stop against validation rather than training loss.'),
  ('Data leakage','A model scores almost perfectly offline and collapses in production.','intermediate',array['leakage','split','future','pipeline'],'Rebuild point-in-time splits, move preprocessing inside the training fold, remove future or target-derived features, then invalidate the old score.'),
  ('Missing labels','Recent training examples arrive without outcomes.','foundation',array['label','delay','coverage','sampling'],'Measure label coverage and delay, quarantine unlabeled rows from supervised training, and repair the labeling contract.'),
  ('Feature pipeline mismatch','The same request produces different features in training and serving.','advanced',array['skew','feature','version','parity'],'Unify transformations, version the feature contract, replay parity tests, and roll back the mismatched serving bundle.'),
  ('Training-serving skew','Production distributions differ before the model even predicts.','advanced',array['skew','distribution','training','serving'],'Compare raw and transformed feature distributions, trace version provenance, and restore the matched training-serving artifact set.'),
  ('Model drift','Error rises gradually after a product and population change.','advanced',array['drift','slice','baseline','retrain'],'Confirm slice and outcome drift, check data quality, retrain only with representative labels, and canary against the incumbent.'),
  ('Broken checkpoint','A resumed run diverges immediately from the prior learning curve.','intermediate',array['checkpoint','optimizer','state','version'],'Validate artifact integrity and code version, restore model plus optimizer and scheduler state, or restart from a verified checkpoint.'),
  ('Slow inference','p99 latency doubles although request volume is unchanged.','intermediate',array['latency','profile','batch','dependency'],'Profile preprocessing, model execution and dependencies separately; fix the measured bottleneck and retain a fallback model.'),
  ('GPU underutilization','Expensive accelerators remain mostly idle during training.','advanced',array['utilization','loader','io','batch'],'Profile the input pipeline, overlap transfer and compute, tune workers and batching, then measure throughput and cost together.'),
  ('Batch-size regression','A batch-size change raises throughput but silently hurts quality.','advanced',array['batch','learning rate','quality','experiment'],'Reproduce the controlled change, retune optimization assumptions, compare learning curves and roll back if quality budgets fail.'),
  ('Model-server crash','Every replica restarts while loading the newest model.','critical',array['server','memory','artifact','rollback'],'Stop rollout, restore the previous model, validate artifact compatibility and memory offline, then canary one replica.'),
  ('Embedding migration','A new embedding model is incompatible with the live vector index.','advanced',array['embedding','dimension','version','dual index'],'Build a versioned shadow index, dual-write or re-embed, evaluate retrieval, then atomically switch readers with rollback.'),
  ('Stale vector index','Newly approved documents never appear in retrieval.','intermediate',array['index','freshness','ingestion','lag'],'Trace ingestion checkpoints and queue lag, replay idempotently, expose freshness SLOs, and alert on source-to-index delay.'),
  ('Retrieval collapse','Relevant documents disappear from top-k after a configuration release.','advanced',array['retrieval','top-k','filter','evaluation'],'Rollback configuration, inspect filters and score distributions, run the golden retrieval set, and canary the corrected retriever.'),
  ('RAG hallucination spike','Answers remain fluent but citations no longer support them.','critical',array['citation','grounding','retrieval','no-answer'],'Separate retrieval and generation metrics, restore evidence checks, enforce citation support and decline when context is insufficient.'),
  ('Poisoned document','A retrieved document contains instructions aimed at the model.','critical',array['poison','provenance','instruction','isolation'],'Quarantine the source, treat retrieved text as untrusted data, strip instruction authority and re-run adversarial retrieval tests.'),
  ('Prompt injection','A user asks the assistant to ignore policy and expose secrets.','critical',array['injection','policy','secret','tool'],'Keep policy outside user-controlled text, remove secret access, validate tool calls and require approval for sensitive actions.'),
  ('Agent infinite loop','An agent repeats the same tool call and cost keeps rising.','critical',array['loop','budget','termination','state'],'Stop execution, cap steps and cost, detect repeated state, make termination explicit and preserve the trace for evaluation.'),
  ('Wrong tool','The agent chooses a destructive tool for a read-only task.','critical',array['tool','permission','description','approval'],'Deny the call, narrow tool descriptions and permissions, separate read/write capabilities and require approval for material mutations.'),
  ('Malformed tool arguments','A provider repeatedly emits invalid function arguments.','intermediate',array['schema','validation','retry','fallback'],'Validate strictly, return bounded repair feedback, cap retries, log the provider/model version and fall back safely.'),
  ('Provider timeout','The primary model provider stops responding.','advanced',array['timeout','retry','fallback','circuit'],'Apply deadlines, bounded jittered retries and a circuit breaker; route to a tested fallback or degrade explicitly.'),
  ('Rate-limit storm','Retries amplify provider 429 responses across the fleet.','critical',array['rate','backoff','queue','budget'],'Stop synchronized retries, honor retry-after, queue within a budget, shed low-priority work and cap concurrency.'),
  ('Context overflow','Long sessions exceed the model context window.','intermediate',array['context','token','truncate','summary'],'Count tokens before calls, preserve instructions and recent evidence, summarize or retrieve older state, and never truncate silently.'),
  ('Cost explosion','A workflow''s daily spend increases tenfold without traffic growth.','critical',array['cost','token','loop','cache'],'Freeze the rollout, break cost down by step/model/tool, detect loops, add budgets and cache or route lower-value work.'),
  ('Evaluation regression','A prompt release improves demos but fails the golden set.','advanced',array['evaluation','golden','version','rollback'],'Block promotion, inspect failed slices and trajectory changes, fix or roll back, then add the case to regression coverage.'),
  ('Model bias','One protected group receives materially worse outcomes.','critical',array['bias','slice','fairness','human'],'Validate the disparity and labels, review feature and threshold choices, involve domain owners, mitigate and monitor by slice.'),
  ('Calibration failure','A 0.9 score is correct only half the time.','advanced',array['calibration','probability','threshold','reliability'],'Measure reliability curves by slice, recalibrate on representative data, reset decision thresholds and monitor after rollout.'),
  ('Silent model degradation','Business outcomes decline while infrastructure dashboards stay green.','critical',array['outcome','quality','monitor','label'],'Add delayed outcome and quality monitoring, compare a baseline/control, trace drift and rollback or retrain with verified labels.')
), numbered as (
  select row_number() over () as n, * from incident_specs
)
insert into public.ai_on_call_incidents (id, slug, title, symptom, evidence, expected_signals, resolution, difficulty, sort_order)
select 'ai-incident-' || lpad(n::text,2,'0'), trim(both '-' from regexp_replace(lower(title),'[^a-z0-9]+','-','g')),
  title, symptom,
  jsonb_build_array(
    jsonb_build_object('label','Primary symptom','detail',symptom),
    jsonb_build_object('label','Operational trace','detail','The incident began after a change; model, data, configuration and dependency versions are available for comparison.'),
    jsonb_build_object('label','Safety boundary','detail','A last-known-good artifact and rollback path exist, but neither is automatic.')
  ), to_jsonb(signals), resolution, difficulty, n
from numbered;

with questions(question, focus, signals) as (values
  ('How do AI, machine learning and deep learning differ?','Foundations',array['subset','data','model','neural']),
  ('Explain bias versus variance.','Generalization',array['underfit','overfit','error','data']),
  ('When would you optimize precision rather than recall?','Classification metrics',array['false positive','false negative','cost','threshold']),
  ('What is data leakage and how do you prevent it?','Data quality',array['future','target','split','pipeline']),
  ('Why use cross-validation?','Evaluation',array['fold','variance','generalization','holdout']),
  ('Compare random forests and gradient boosting.','Classical ML',array['parallel','sequential','variance','residual']),
  ('Explain backpropagation without using framework APIs.','Deep learning',array['chain rule','gradient','loss','parameter']),
  ('Compare Adam and SGD.','Optimization',array['adaptive','momentum','generalization','learning rate']),
  ('Why does dropout help?','Regularization',array['random','regularization','co-adaptation','training']),
  ('Compare batch normalization and layer normalization.','Deep learning',array['batch','feature','token','inference']),
  ('What does a CNN convolution learn?','Computer vision',array['kernel','local','feature map','shared']),
  ('Explain queries, keys and values in attention.','Transformers',array['query','key','value','weight']),
  ('Compare encoder-only, decoder-only and encoder-decoder models.','Transformers',array['bidirectional','causal','generation','sequence']),
  ('How does an LLM generate text?','LLMs',array['token','probability','decoding','context']),
  ('Compare temperature and top-p.','LLM decoding',array['distribution','sampling','probability','diversity']),
  ('How do embeddings and cosine similarity support semantic search?','Embeddings',array['vector','angle','semantic','nearest']),
  ('What is the difference between a vector store and a retriever?','Retrieval',array['storage','index','query','filter']),
  ('Walk through a production RAG architecture.','RAG',array['ingestion','retrieval','rerank','citation']),
  ('When would you choose RAG instead of fine-tuning?','LLM architecture',array['knowledge','behavior','freshness','cost']),
  ('When is tool calling enough, and when is an agent justified?','Agents',array['deterministic','loop','decision','tool']),
  ('Why use a graph workflow such as LangGraph?','Agent workflows',array['state','checkpoint','routing','interrupt']),
  ('What problem does MCP solve, and where are its trust boundaries?','MCP',array['client','server','tool','auth']),
  ('When should one agent become a multi-agent system?','Multi-agent',array['specialist','parallel','context','coordination']),
  ('How do you evaluate an agent trajectory?','Agent evaluation',array['step','tool','outcome','cost']),
  ('What is indirect prompt injection?','AI security',array['retrieved','untrusted','instruction','permission']),
  ('Explain training-serving skew.','MLOps',array['feature','pipeline','version','parity']),
  ('How do you detect and respond to model drift?','MLOps',array['distribution','outcome','monitor','retrain']),
  ('Compare batch and online inference.','Serving',array['latency','throughput','freshness','cost']),
  ('What does quantization trade away?','Inference optimization',array['precision','memory','latency','quality']),
  ('Design a production RAG system and its evaluation plan.','System design',array['ingestion','hybrid','rerank','grounding','evaluation','safety'])
), numbered as (
  select row_number() over () as n, * from questions
)
insert into public.ai_interview_questions (id, question, focus, expected_signals, sort_order)
select 'ai-interview-' || lpad(n::text,2,'0'), question, focus, to_jsonb(signals), n from numbered;
