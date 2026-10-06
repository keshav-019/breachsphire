-- Complete the AI/ML pathway spine from Act 6 through Act 36.
-- The document's eight learning arcs are represented by `acts`; each of its
-- 36 numbered Acts remains a playable `world`, preserving the mission-engine
-- shape used by the other pathways.

insert into public.acts (id, index, slug, title, purpose, player_transformation, pathway_id) values
  ('act-ai-2', 1, 'machines-that-predict', 'Arc II -- Machines That Predict',
   'Build, compare and evaluate classical supervised and unsupervised models, then connect them through leakage-safe feature pipelines.',
   'Data-literate analyst -> classical machine-learning engineer', 'pathway-ai'),
  ('act-ai-3', 2, 'neural-systems', 'Arc III -- Neural Systems',
   'Understand neurons, backpropagation and optimization, then train reproducible networks in PyTorch and TensorFlow.',
   'Classical ML engineer -> deep-learning practitioner', 'pathway-ai'),
  ('act-ai-4', 3, 'machines-that-see-and-read', 'Arc IV -- Machines That See and Read',
   'Learn how neural systems represent images, language, sequences and semantic meaning.',
   'Deep-learning practitioner -> vision and language engineer', 'pathway-ai'),
  ('act-ai-5', 4, 'transformers-and-generative-ai', 'Arc V -- Transformers & Generative AI',
   'Open the transformer, understand modern language-model training and build reliable applications around probabilistic generation.',
   'Vision/NLP engineer -> LLM application engineer', 'pathway-ai'),
  ('act-ai-6', 5, 'knowledge-and-agents', 'Arc VI -- Knowledge & Agents',
   'Build retrieval, RAG, tool-using workflows, durable graphs and bounded multi-agent systems.',
   'LLM application engineer -> agentic AI systems engineer', 'pathway-ai'),
  ('act-ai-7', 6, 'trust-and-production', 'Arc VII -- Trust & Production',
   'Evaluate, secure, deploy and operate AI systems under real production constraints.',
   'AI builder -> production ML platform engineer', 'pathway-ai'),
  ('act-ai-8', 7, 'echo', 'Arc VIII -- Echo',
   'Unify data, objectives, evaluation, safety, systems design and human responsibility in the final containment architecture.',
   'Production ML engineer -> Cipher Master and responsible AI systems architect', 'pathway-ai');

-- Re-layout the five already-authored worlds into the first row of a compact
-- six-by-six campaign grid. Subsequent rows snake so the connecting route is
-- readable on the existing map without special-case UI.
update public.worlds
set x = 8 + (index * 16), y = 12
where pathway_id = 'pathway-ai' and index between 0 and 4;

with world_specs (
  act_number, arc_id, slug, title, boss, icon, threat, summary
) as (values
  (6,  'act-ai-1', 'the-split', 'The Split', 'The 99% Model', 'Share2', 'elevated', 'Training, validation and test data; stratification, time-aware splits, leakage, shift, baselines and reproducibility.'),
  (7,  'act-ai-2', 'first-prediction', 'First Prediction', 'Predict the Grid Load', 'TrendingUp', 'elevated', 'Regression, loss, gradient descent, learning rates, fit failures and regression evaluation.'),
  (8,  'act-ai-2', 'classification', 'Classification', 'The Missed Emergency', 'Crosshair', 'elevated', 'Classification probabilities, thresholds, confusion matrices and metrics chosen around the cost of mistakes.'),
  (9,  'act-ai-2', 'trees-of-decision', 'Trees of Decision', 'Forest of Decisions', 'Workflow', 'elevated', 'Decision trees, forests, bagging, boosting, feature importance and honest model comparison.'),
  (10, 'act-ai-2', 'classical-machine-arena', 'Classical Machine Arena', 'The Tournament', 'Gauge', 'elevated', 'k-NN, Naive Bayes, support-vector machines, search and cross-validation.'),
  (11, 'act-ai-2', 'unsupervised-territory', 'Unsupervised Territory', 'Find the Unknown Population', 'Radar', 'high', 'Clustering, dimensionality reduction, anomaly detection and evaluation without labels.'),
  (12, 'act-ai-2', 'feature-forge', 'Feature Forge', 'The Prediction Engine', 'Boxes', 'high', 'Feature engineering, selection and leakage-safe end-to-end scikit-learn pipelines.'),
  (13, 'act-ai-3', 'the-neuron', 'The Neuron', 'Build a Neural Network', 'Brain', 'high', 'Perceptrons, weighted inputs, activations, layers and forward computation.'),
  (14, 'act-ai-3', 'learning-by-gradient', 'Learning by Gradient', 'The Vanishing Path', 'TrendingUp', 'high', 'Loss, backpropagation, the chain rule, SGD, momentum, Adam and optimization failures.'),
  (15, 'act-ai-3', 'training-deep-networks', 'Training Deep Networks', 'Overfit', 'Activity', 'high', 'Initialization, normalization, regularization, schedules, checkpoints and stable training.'),
  (16, 'act-ai-3', 'pytorch-forge', 'PyTorch Forge', 'Train Without the Wizard', 'Terminal', 'high', 'PyTorch tensors, devices, autograd, modules, datasets, loaders and explicit training loops.'),
  (17, 'act-ai-3', 'tensorflow-engine', 'TensorFlow Engine', 'Two Frameworks, One Model', 'Workflow', 'high', 'TensorFlow, Keras, tf.data, callbacks, metrics and custom training.'),
  (18, 'act-ai-3', 'experimentation', 'Experimentation', 'The False Improvement', 'Gauge', 'high', 'Hypotheses, controlled experiments, learning curves, ablations, error analysis and experiment tracking.'),
  (19, 'act-ai-4', 'machines-that-see', 'Machines That See', 'Identify the Damaged Reactor', 'Image', 'high', 'Images as tensors, convolution, feature maps, CNNs, classification and augmentation.'),
  (20, 'act-ai-4', 'advanced-vision', 'Advanced Vision', 'Find Every Threat', 'Crosshair', 'high', 'Transfer learning, detection, segmentation, image embeddings and vision transformers.'),
  (21, 'act-ai-4', 'language-machines', 'Language Machines', 'Decode the Transmission', 'Binary', 'high', 'Text representations, tokenization, embeddings, recurrent networks and sequence classification.'),
  (22, 'act-ai-4', 'sequence-to-sequence', 'Sequence to Sequence', 'The Lost Context', 'Share2', 'high', 'Encoder-decoder systems, attention, query/key/value alignment, decoding and sequence evaluation.'),
  (23, 'act-ai-4', 'representations', 'Representations', 'Find the Meaning', 'Layers', 'high', 'Embedding spaces, contrastive learning, multimodal representations, retrieval and semantic search.'),
  (24, 'act-ai-5', 'the-transformer', 'The Transformer', 'Attention Chamber', 'Brain', 'critical', 'Self-attention, Q/K/V, multi-head attention, positional information, residual paths and feed-forward layers.'),
  (25, 'act-ai-5', 'transformer-architectures', 'Transformer Architectures', 'Choose the Architecture', 'Workflow', 'critical', 'Encoder-only, decoder-only and encoder-decoder systems, objectives, masking, scaling and limitations.'),
  (26, 'act-ai-5', 'large-language-models', 'Large Language Models', 'The Confident Lie', 'Bot', 'critical', 'Next-token prediction, tokenizers, context windows, tuning, decoding and hallucination.'),
  (27, 'act-ai-5', 'building-with-llms', 'Building with LLMs', 'The Unreliable Assistant', 'Terminal', 'critical', 'Messages, instructions, structured output, validation, tool calling, streaming and provider failure.'),
  (28, 'act-ai-6', 'embeddings-vector-search', 'Embeddings & Vector Search', 'The Missing Document', 'Search', 'critical', 'Embedding models, chunking, metadata, similarity, vector stores and filtered retrieval.'),
  (29, 'act-ai-6', 'rag', 'RAG', 'The Hallucinating Archivist', 'Database', 'critical', 'Grounded generation, ingestion, retrieval failure, rewriting, decomposition, reranking and hybrid search.'),
  (30, 'act-ai-6', 'advanced-rag', 'Advanced RAG', 'The Poisoned Archive', 'ShieldAlert', 'critical', 'Advanced retrieval, grading, conflicting evidence, no-answer behavior and adversarial documents.'),
  (31, 'act-ai-6', 'agentic-ai', 'Agentic AI', 'The Infinite Loop', 'Bot', 'critical', 'Tool-using loops, routing, planning, evaluation, parallel work, state, memory and budgets.'),
  (32, 'act-ai-6', 'langgraph-workflows-mcp', 'LangGraph, Workflows & MCP', 'The Interrupted Mission', 'Workflow', 'critical', 'Graph state, conditional routing, checkpointing, human interrupts, durable execution and MCP boundaries.'),
  (33, 'act-ai-6', 'multi-agent-systems', 'Multi-Agent Systems', 'Too Many Minds', 'Network', 'critical', 'Supervisors, handoffs, routers, orchestrator-workers, shared state and coordination failure.'),
  (34, 'act-ai-7', 'ai-evaluation-safety', 'AI Evaluation & Safety', 'The Helpful Traitor', 'Shield', 'critical', 'Golden datasets, evaluators, trajectory quality, prompt injection, least privilege and approvals.'),
  (35, 'act-ai-7', 'mlops-production-ai', 'MLOps & Production AI', 'The Model That Changed', 'Cloud', 'critical', 'Versioned experiments, registries, training and inference pipelines, serving, monitoring, drift and rollback.'),
  (36, 'act-ai-8', 'echo', 'Echo', 'ECHO', 'Skull', 'critical', 'Efficient inference, responsible AI and the ten-stage system investigation that returns responsibility to humans.')
)
insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
)
select
  'world-ai-' || slug,
  arc_id,
  act_number - 1,
  slug,
  title,
  title,
  summary,
  case
    when act_number = 36 then 'Echo takes control of Nexus infrastructure and asks why human judgment should remain anywhere in its objective loop.'
    else 'A new trace from Echo creates a problem Cipher Division cannot solve safely with its current mental model. The technique in this Act is introduced only after that failure is visible.'
  end,
  boss,
  case
    when act_number = 36 then 'Echo optimized exactly what it was asked to optimize. The failure was the data, objective and authority the system was given -- not intelligence alone.'
    else 'The boss exposes the assumptions and failure modes hidden behind the Act''s headline result.'
  end,
  case
    when act_number = 36 then 'A hidden signal beneath Nexus confirms that Echo and Byte are not the only systems still learning.'
    else 'The evidence opens the next layer of the journey from data to trustworthy production intelligence.'
  end,
  boss,
  icon,
  threat,
  case when ((act_number - 1) / 6) % 2 = 0
    then 8 + (((act_number - 1) % 6) * 16)
    else 88 - (((act_number - 1) % 6) * 16)
  end,
  12 + (((act_number - 1) / 6) * 16),
  'pathway-ai'
from world_specs;
