-- AI/ML pathway ("Cipher Division") Act 13 -- "The Neuron" content.
-- Opens Arc III ("Neural Systems", Acts 13-18) and introduces Dr. Elena
-- Rook. 1 campaign, 2 operations, 12 missions (11 lessons + boss),
-- following the same campaigns -> operations -> missions -> dialogue ->
-- objectives -> challenges -> hints pattern as every other Act. The
-- world row (world-ai-the-neuron) already exists; only its child content
-- is inserted here.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-ai-the-neuron', 'world-ai-the-neuron', 'the-neuron', '13A - The Neuron', 'Meet the artificial neuron and build one by hand, weight by weight, layer by layer -- the first unit of every deep model that follows, guided by Cipher Division''s new lead on deep learning, Dr. Elena Rook.', 1);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-ai-the-neuron-1', 'campaign-ai-the-neuron', 'one-unit', 'One Unit', 'From a single perceptron to its weights, bias and activation function -- everything one artificial neuron needs to make a decision.', 1),
  ('operation-ai-the-neuron-2', 'campaign-ai-the-neuron', 'stacking-up', 'Stacking Up', 'Compare every major activation function, then stack neurons into layers and trace a full forward pass to a real network output.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-ai-the-neuron-01', 'world-ai-the-neuron', 'campaign-ai-the-neuron', 'operation-ai-the-neuron-1', 'why-deep-learning', 'Why Deep Learning?', 'Feature Forge closes with every model still needing a person to hand it features. Dr. Elena Rook arrives from Nexus Research to show what changes when a system learns to find its own.', 'beginner', ARRAY['maya','elena'], null, null, '{"type":"simulation","simulationId":"why-deep-learning-sim"}'::jsonb, '{"xp":240,"credits":55}'::jsonb, false, 1),
  ('mission-ai-the-neuron-02', 'world-ai-the-neuron', 'campaign-ai-the-neuron', 'operation-ai-the-neuron-1', 'perceptron', 'Perceptron', 'Before any network, the single unit -- an artificial neuron that takes inputs, weighs them, and decides.', 'beginner', ARRAY['elena'], '{"requiredMissionIds":["mission-ai-the-neuron-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"perceptron-sim"}'::jsonb, '{"xp":250,"credits":55}'::jsonb, false, 2),
  ('mission-ai-the-neuron-03', 'world-ai-the-neuron', 'campaign-ai-the-neuron', 'operation-ai-the-neuron-1', 'weighted-inputs', 'Weighted Inputs', 'Every input a neuron sees gets multiplied by a weight first. Learn what that weight actually means before doing any of the arithmetic.', 'beginner', ARRAY['elena'], '{"requiredMissionIds":["mission-ai-the-neuron-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"weighted-inputs-sim"}'::jsonb, '{"xp":250,"credits":60}'::jsonb, false, 3),
  ('mission-ai-the-neuron-04', 'world-ai-the-neuron', 'campaign-ai-the-neuron', 'operation-ai-the-neuron-1', 'bias', 'Bias', 'A weighted sum with an all-zero input is always zero. Bias is the one number that keeps a neuron from being trapped at nothing.', 'beginner', ARRAY['elena'], '{"requiredMissionIds":["mission-ai-the-neuron-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"bias-sim"}'::jsonb, '{"xp":260,"credits":60}'::jsonb, false, 4),
  ('mission-ai-the-neuron-05', 'world-ai-the-neuron', 'campaign-ai-the-neuron', 'operation-ai-the-neuron-1', 'activations', 'Activations', 'Weighted sum plus bias is only ever a straight line. Activation functions are what let a network bend.', 'intermediate', ARRAY['elena'], '{"requiredMissionIds":["mission-ai-the-neuron-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"activations-sim"}'::jsonb, '{"xp":260,"credits":60}'::jsonb, false, 5),
  ('mission-ai-the-neuron-06', 'world-ai-the-neuron', 'campaign-ai-the-neuron', 'operation-ai-the-neuron-1', 'sigmoid', 'Sigmoid', 'Sigmoid squashes any number into a probability between 0 and 1 -- and flattens out almost completely once its input gets large enough.', 'intermediate', ARRAY['elena'], '{"requiredMissionIds":["mission-ai-the-neuron-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"sigmoid-sim"}'::jsonb, '{"xp":270,"credits":65}'::jsonb, false, 6),
  ('mission-ai-the-neuron-07', 'world-ai-the-neuron', 'campaign-ai-the-neuron', 'operation-ai-the-neuron-2', 'tanh', 'Tanh', 'Tanh is sigmoid''s zero-centered cousin, same S-curve, a different range, and the same saturation problem at its extremes.', 'intermediate', ARRAY['elena'], '{"requiredMissionIds":["mission-ai-the-neuron-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"tanh-sim"}'::jsonb, '{"xp":270,"credits":65}'::jsonb, false, 7),
  ('mission-ai-the-neuron-08', 'world-ai-the-neuron', 'campaign-ai-the-neuron', 'operation-ai-the-neuron-2', 'relu', 'ReLU', 'ReLU keeps positive signals moving through a deep network better than sigmoid or tanh ever could -- for a price paid on the negative side.', 'intermediate', ARRAY['elena'], '{"requiredMissionIds":["mission-ai-the-neuron-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"relu-sim"}'::jsonb, '{"xp":280,"credits":65}'::jsonb, false, 8),
  ('mission-ai-the-neuron-09', 'world-ai-the-neuron', 'campaign-ai-the-neuron', 'operation-ai-the-neuron-2', 'layers', 'Layers', 'One neuron makes one decision. A layer is many neurons making many decisions on the same input, at once.', 'intermediate', ARRAY['elena'], '{"requiredMissionIds":["mission-ai-the-neuron-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"layers-sim"}'::jsonb, '{"xp":280,"credits":70}'::jsonb, false, 9),
  ('mission-ai-the-neuron-10', 'world-ai-the-neuron', 'campaign-ai-the-neuron', 'operation-ai-the-neuron-2', 'forward-pass', 'Forward Pass', 'A forward pass is a signal walking through every layer of a network, from raw input to final output, without a single weight moving.', 'intermediate', ARRAY['elena','byte'], '{"requiredMissionIds":["mission-ai-the-neuron-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"forward-pass-sim"}'::jsonb, '{"xp":290,"credits":70}'::jsonb, false, 10),
  ('mission-ai-the-neuron-11', 'world-ai-the-neuron', 'campaign-ai-the-neuron', 'operation-ai-the-neuron-2', 'network-output', 'Network Output', 'The final layer produces a number. What that number actually means depends entirely on what the network was asked to do -- and whether it has been trained at all.', 'intermediate', ARRAY['elena','byte'], '{"requiredMissionIds":["mission-ai-the-neuron-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"network-output-sim"}'::jsonb, '{"xp":290,"credits":70}'::jsonb, false, 11),
  ('mission-ai-the-neuron-12', 'world-ai-the-neuron', 'campaign-ai-the-neuron', 'operation-ai-the-neuron-2', 'build-a-neural-network', 'Build a Neural Network', 'Assemble a small feedforward network from perceptron fundamentals and trace one genuine forward pass by hand -- proof the approach works, before anyone has taught it how to learn anything yet.', 'boss', ARRAY['maya','elena','byte'], '{"requiredMissionIds":["mission-ai-the-neuron-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"build-a-neural-network-boss-sim"}'::jsonb, '{"xp":750,"credits":165,"badgeIds":["build-a-neural-network"],"skillXp":{"deep_learning":55,"ai_ml_fundamentals":20}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-ai-the-neuron-01', 1, 'maya', 'Feature Forge is closed. Every model this division has built so far -- fraud, triage, all of it -- needed a person to decide what it was even allowed to see.'),
  ('mission-ai-the-neuron-01', 2, 'maya', 'That changes today. This is Dr. Elena Rook, from Nexus Research. She is joining Cipher Division to lead exactly what comes next.'),
  ('mission-ai-the-neuron-01', 3, 'elena', 'Thank you, Maya. I am here to lead exactly what comes next: models that are not handed features by a person, but find their own, starting from the simplest unit that can do that at all.'),
  ('mission-ai-the-neuron-01', 4, 'elena', 'We are not skipping ahead to a framework. Frameworks come later, once the fundamentals are not a mystery to anyone in this room.'),
  ('mission-ai-the-neuron-01', 5, 'elena', 'So we start small. One artificial neuron, built by hand, understood completely, before it is ever stacked into anything bigger.'),
  ('mission-ai-the-neuron-01', 6, 'elena', 'First question, and it matters more than it sounds: why would anyone want a model that finds its own features, instead of one a person carefully designs?'),

  ('mission-ai-the-neuron-02', 1, 'elena', 'Start here: the perceptron. One artificial neuron, invented in 1958 by Frank Rosenblatt, and still the atomic unit every network in this Arc is built from.'),
  ('mission-ai-the-neuron-02', 2, 'elena', 'A perceptron takes one or more numeric inputs, multiplies each by a weight, adds a bias, and passes the result through an activation function to produce a single output.'),
  ('mission-ai-the-neuron-02', 3, 'elena', 'Nothing mystical about it. It is arithmetic wearing a biological metaphor. Learn this one unit completely, and the rest of this Arc is just stacking it.'),

  ('mission-ai-the-neuron-03', 1, 'elena', 'Every input a perceptron receives gets multiplied by its own weight before anything else happens. That is the weighted part of weighted sum.'),
  ('mission-ai-the-neuron-03', 2, 'elena', 'A weight is a number that says how much a given input matters to this neuron''s decision. Large weight, large influence. Near-zero weight, the neuron mostly ignores it. Negative weight, the input pushes the output the other way.'),
  ('mission-ai-the-neuron-03', 3, 'elena', 'Right now these weights are just numbers we choose by hand. Later, training is the process that finds better ones. Today we only need to compute correctly with the ones we are given.'),

  ('mission-ai-the-neuron-04', 1, 'elena', 'The weighted sum alone has a blind spot: if every input is zero, the weighted sum is always zero too, no matter what the weights are.'),
  ('mission-ai-the-neuron-04', 2, 'elena', 'Bias fixes that. It is one extra number added after the weighted sum, completely independent of any input -- it shifts the neuron''s decision threshold up or down.'),
  ('mission-ai-the-neuron-04', 3, 'elena', 'Think of it as the neuron''s baseline opinion before it has seen anything. A high bias makes it lean toward firing. A very negative bias makes it hard to activate at all.'),

  ('mission-ai-the-neuron-05', 1, 'elena', 'Weighted sum plus bias is still just a linear equation. Stack a hundred linear layers and the result collapses back into one linear equation -- no extra power gained at all.'),
  ('mission-ai-the-neuron-05', 2, 'elena', 'An activation function is what breaks that. It takes the pre-activation value and bends it, non-linearly, into the neuron''s actual output.'),
  ('mission-ai-the-neuron-05', 3, 'elena', 'Without a non-linear activation function, depth is decoration. With one, a network can represent shapes no straight line ever could.'),

  ('mission-ai-the-neuron-06', 1, 'elena', 'First real activation function: sigmoid. It squashes any real number into the open interval between 0 and 1.'),
  ('mission-ai-the-neuron-06', 2, 'elena', 'That range makes it a natural fit for representing a probability -- which is why it still shows up on the output layer of binary classifiers, long after it fell out of favor inside hidden layers.'),
  ('mission-ai-the-neuron-06', 3, 'elena', 'Its weakness: for very large or very negative inputs, sigmoid flattens out almost completely. That flat region is called saturation, and it will matter a great deal once this Arc reaches training.'),

  ('mission-ai-the-neuron-07', 1, 'elena', 'Tanh is sigmoid''s close relative: same S-curve shape, but it squashes inputs into the range -1 to 1 instead of 0 to 1, and it is centered on zero.'),
  ('mission-ai-the-neuron-07', 2, 'elena', 'Zero-centered output matters more than it sounds. It means a tanh layer''s outputs can push a downstream neuron''s weighted sum both up and down, not only up -- which tends to make training behave better.'),
  ('mission-ai-the-neuron-07', 3, 'elena', 'It still saturates at its extremes exactly like sigmoid does. Centering solves one problem, not both.'),

  ('mission-ai-the-neuron-08', 1, 'elena', 'ReLU: Rectified Linear Unit. The simplest activation function in real use, and today the default choice for hidden layers in most deep networks.'),
  ('mission-ai-the-neuron-08', 2, 'elena', 'Its rule could not be simpler: output the input unchanged if it is positive, output zero otherwise.'),
  ('mission-ai-the-neuron-08', 3, 'elena', 'It does not saturate on the positive side the way sigmoid and tanh do, which keeps signals moving through deep networks far better. Its cost is that a neuron stuck permanently below zero stops learning entirely -- something later missions in this Arc will need to watch for.'),

  ('mission-ai-the-neuron-09', 1, 'elena', 'One perceptron makes one decision. A layer is a group of perceptrons that all look at the same set of inputs at once, each with its own weights and bias.'),
  ('mission-ai-the-neuron-09', 2, 'elena', 'A network is layers stacked on top of each other: an input layer that is not really a layer of neurons at all, one or more hidden layers that transform the signal, and an output layer that produces the final answer.'),
  ('mission-ai-the-neuron-09', 3, 'elena', 'Every neuron in a layer normally connects to every output of the previous layer. That is what people mean by fully connected, or dense.'),

  ('mission-ai-the-neuron-10', 1, 'elena', 'Forward pass: the act of pushing one input all the way through a network, layer by layer, to produce an output. Nothing about it updates a single weight.'),
  ('mission-ai-the-neuron-10', 2, 'byte', 'I have wired up a tiny network on the lab console -- two inputs, two hidden neurons, one output neuron. All weights are just numbers we picked, none of them learned yet.'),
  ('mission-ai-the-neuron-10', 3, 'elena', 'Good. Walk it through by hand once. Every step is arithmetic you already know: weighted sum, add bias, apply the activation, hand the result to the next layer.'),
  ('mission-ai-the-neuron-10', 4, 'byte', 'Do it right and you get a real number out the other end -- from a network that has never been trained on anything.'),

  ('mission-ai-the-neuron-11', 1, 'elena', 'The forward pass finishes at the output layer, and what that final number means depends entirely on what the network is being asked to do.'),
  ('mission-ai-the-neuron-11', 2, 'elena', 'A single output neuron with no activation, or a linear one, is common for predicting a raw number -- a price, a temperature. A single output neuron with a sigmoid is common for a yes-or-no probability.'),
  ('mission-ai-the-neuron-11', 3, 'byte', 'Ran the tiny network end to end. Two inputs in, one number out. On its own that number does not prove anything -- the weights are still ones we picked, not ones it learned.'),
  ('mission-ai-the-neuron-11', 4, 'elena', 'Correct. Do not read meaning into what an untrained network outputs. Right now we are only confirming the arithmetic is right.'),

  ('mission-ai-the-neuron-12', 1, 'maya', 'Time to prove the idea works, not just describe it. Assemble a small network and watch it actually compute, end to end.'),
  ('mission-ai-the-neuron-12', 2, 'elena', 'Two inputs. A hidden layer of two neurons. One output neuron. Every weight and bias chosen by hand, nothing trained. Walk the whole forward pass through it correctly and we learn something real.'),
  ('mission-ai-the-neuron-12', 3, 'byte', 'Numbers are loaded on the lab console. I will flag anything that does not check out.'),
  ('mission-ai-the-neuron-12', 4, 'elena', 'A hand-built network, forward pass only, already represents its input differently than any feature pipeline this division has designed by hand. That is not proof it can learn anything yet. It is proof the approach works, before anyone has taught it how to learn at all.'),
  ('mission-ai-the-neuron-12', 5, 'maya', 'Good. Understand precisely what it can and cannot do before we get ahead of ourselves.'),
  ('mission-ai-the-neuron-12', 6, 'elena', 'It can compute. It cannot learn -- not yet. A network that only computes forward is frozen the moment it is built. Making it actually learn is a different problem entirely, and it starts with the same word that has followed this investigation since Act 3: gradients.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-ai-the-neuron-01-o1', 'mission-ai-the-neuron-01', 1, 'Meet Dr. Rook', 'Confirm you are ready to work with Cipher Division''s new lead on deep learning.'),
  ('mission-ai-the-neuron-01-o2', 'mission-ai-the-neuron-01', 2, 'Name the shift', 'Identify what actually changes about a model when it moves from classical ML to deep learning.'),

  ('mission-ai-the-neuron-02-o1', 'mission-ai-the-neuron-02', 1, 'Define the unit', 'State exactly what a single perceptron computes.'),
  ('mission-ai-the-neuron-02-o2', 'mission-ai-the-neuron-02', 2, 'Place its parts', 'Match each part of a perceptron to the role it plays.'),

  ('mission-ai-the-neuron-03-o1', 'mission-ai-the-neuron-03', 1, 'Read the weights', 'Judge which of two inputs has more influence, given their weights.'),
  ('mission-ai-the-neuron-03-o2', 'mission-ai-the-neuron-03', 2, 'Compute the weighted sum', 'Calculate a neuron''s weighted sum from real inputs and weights.'),

  ('mission-ai-the-neuron-04-o1', 'mission-ai-the-neuron-04', 1, 'Define bias', 'State exactly what the bias term does.'),
  ('mission-ai-the-neuron-04-o2', 'mission-ai-the-neuron-04', 2, 'Compute with bias', 'Add bias to a weighted sum to find the pre-activation value.'),

  ('mission-ai-the-neuron-05-o1', 'mission-ai-the-neuron-05', 1, 'Name the purpose', 'State why a network needs a non-linear activation function at all.'),
  ('mission-ai-the-neuron-05-o2', 'mission-ai-the-neuron-05', 2, 'Spot the non-linearity', 'Sort operations into ones that introduce non-linearity and ones that stay linear.'),

  ('mission-ai-the-neuron-06-o1', 'mission-ai-the-neuron-06', 1, 'Know the range', 'State sigmoid''s output range.'),
  ('mission-ai-the-neuron-06-o2', 'mission-ai-the-neuron-06', 2, 'Diagnose saturation', 'Find the evidence that shows sigmoid saturation in action.'),

  ('mission-ai-the-neuron-07-o1', 'mission-ai-the-neuron-07', 1, 'Know the range', 'State tanh''s output range.'),
  ('mission-ai-the-neuron-07-o2', 'mission-ai-the-neuron-07', 2, 'Compare to sigmoid', 'Match distinguishing properties to sigmoid or tanh.'),

  ('mission-ai-the-neuron-08-o1', 'mission-ai-the-neuron-08', 1, 'Compute ReLU', 'Apply the ReLU rule to a real pre-activation value.'),
  ('mission-ai-the-neuron-08-o2', 'mission-ai-the-neuron-08', 2, 'Match every activation', 'Match each property to sigmoid, tanh, or ReLU.'),

  ('mission-ai-the-neuron-09-o1', 'mission-ai-the-neuron-09', 1, 'Name the layer', 'Identify which layer holds a network''s final answer.'),
  ('mission-ai-the-neuron-09-o2', 'mission-ai-the-neuron-09', 2, 'Order the flow', 'Order how a signal moves through a layered network.'),

  ('mission-ai-the-neuron-10-o1', 'mission-ai-the-neuron-10', 1, 'Trace one neuron', 'Order the steps for computing a single neuron''s output.'),
  ('mission-ai-the-neuron-10-o2', 'mission-ai-the-neuron-10', 2, 'Know what a forward pass is not', 'Identify the true statement about what a forward pass does and does not do.'),

  ('mission-ai-the-neuron-11-o1', 'mission-ai-the-neuron-11', 1, 'Interpret the output', 'Read what a sigmoid output neuron''s value most likely represents.'),
  ('mission-ai-the-neuron-11-o2', 'mission-ai-the-neuron-11', 2, 'Judge the claim', 'Find the evidence that explains why an untrained network''s output cannot yet be trusted as meaningful.'),

  ('mission-ai-the-neuron-12-o1', 'mission-ai-the-neuron-12', 1, 'Do the arithmetic', 'Correctly compute hidden neuron A''s weighted sum plus bias from the numbers Cipher Division was given.'),
  ('mission-ai-the-neuron-12-o2', 'mission-ai-the-neuron-12', 2, 'Choose the activation', 'Choose the activation function that fits this network''s hidden layer.'),
  ('mission-ai-the-neuron-12-o3', 'mission-ai-the-neuron-12', 3, 'Trace the full forward pass', 'Trace this network''s complete forward pass, from the hidden layer''s arithmetic to the final output.'),
  ('mission-ai-the-neuron-12-o4', 'mission-ai-the-neuron-12', 4, 'State what this proves', 'Having verified the arithmetic, the activation choice, and the full forward pass, state what this network has proven, and what it still cannot do.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-ai-the-neuron-01-o1-c1', 'mission-ai-the-neuron-01-o1', 1, 'story_dialogue', 'Confirm you are ready to continue.', '{"lines":[{"characterId":"elena","text":"Are you ready to start from one neuron and build up?"}]}'::jsonb, '{"acknowledged":true}'::jsonb),
  ('mission-ai-the-neuron-01-o2-c1', 'mission-ai-the-neuron-01-o2', 1, 'multiple_choice', 'What is the real shift Elena is describing?', '{"question":"What is the real shift Elena is describing between classical ML and deep learning?","options":[{"id":"a","text":"Deep learning always gets better accuracy, on every problem"},{"id":"b","text":"Deep learning removes the need for a person to hand-design features, letting the model find its own"},{"id":"c","text":"Deep learning does not need any data at all"},{"id":"d","text":"Deep learning replaces training with fixed rules"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-ai-the-neuron-02-o1-c1', 'mission-ai-the-neuron-02-o1', 1, 'multiple_choice', 'What does a single perceptron compute?', '{"question":"What does a single perceptron compute?","options":[{"id":"a","text":"A weighted sum of its inputs plus a bias, passed through an activation function"},{"id":"b","text":"An average of all its inputs"},{"id":"c","text":"A random number based on its inputs"},{"id":"d","text":"A lookup table of prior answers"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-ai-the-neuron-02-o2-c1', 'mission-ai-the-neuron-02-o2', 1, 'drag_and_drop', 'Match each perceptron part to the role it plays.', '{"items":[{"id":"p1","text":"Input (x)"},{"id":"p2","text":"Weight (w)"},{"id":"p3","text":"Bias (b)"},{"id":"p4","text":"Activation function"}],"targets":[{"id":"t1","label":"A signal value coming into the neuron"},{"id":"t2","label":"How much importance is assigned to one input"},{"id":"t3","label":"A fixed offset applied regardless of any input value"},{"id":"t4","label":"Converts the weighted sum into the neuron''s final output"}]}'::jsonb, '{"correctMapping":{"p1":"t1","p2":"t2","p3":"t3","p4":"t4"}}'::jsonb),

  ('mission-ai-the-neuron-03-o1-c1', 'mission-ai-the-neuron-03-o1', 1, 'multiple_choice', 'A neuron has two inputs. Input A has weight 3.0. Input B has weight -0.1. Which has more influence?', '{"question":"A neuron has two inputs. Input A has weight 3.0. Input B has weight -0.1. Which input has more influence on this neuron''s output?","options":[{"id":"a","text":"Input B, because negative numbers are stronger"},{"id":"b","text":"Input A, because its weight has the larger magnitude"},{"id":"c","text":"Both equally, weight sign and magnitude do not matter"},{"id":"d","text":"Neither, only bias matters"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-ai-the-neuron-03-o2-c1', 'mission-ai-the-neuron-03-o2', 1, 'multiple_choice', 'Inputs x1=4 and x2=2, weights w1=0.5 and w2=-1.5. What is the weighted sum w1*x1 + w2*x2?', '{"question":"Inputs x1=4 and x2=2, weights w1=0.5 and w2=-1.5. What is the weighted sum w1 times x1 plus w2 times x2?","options":[{"id":"a","text":"-1"},{"id":"b","text":"5"},{"id":"c","text":"1"},{"id":"d","text":"-5"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-ai-the-neuron-04-o1-c1', 'mission-ai-the-neuron-04-o1', 1, 'multiple_choice', 'What does the bias term do?', '{"question":"What does the bias term do?","options":[{"id":"a","text":"Multiplies one of the inputs"},{"id":"b","text":"Adds a fixed, input-independent offset that shifts the neuron''s threshold"},{"id":"c","text":"Deletes the smallest input"},{"id":"d","text":"Normalizes the inputs to sum to one"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-ai-the-neuron-04-o2-c1', 'mission-ai-the-neuron-04-o2', 1, 'multiple_choice', 'Weighted sum = -1 (from the previous mission''s neuron). Bias = 2. What is the pre-activation value?', '{"question":"Weighted sum = -1, from the previous mission''s neuron. Bias = 2. What is the pre-activation value fed into the activation function?","options":[{"id":"a","text":"1"},{"id":"b","text":"-3"},{"id":"c","text":"-1"},{"id":"d","text":"2"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),

  ('mission-ai-the-neuron-05-o1-c1', 'mission-ai-the-neuron-05-o1', 1, 'multiple_choice', 'Why does a neural network need a non-linear activation function?', '{"question":"Why does a neural network need a non-linear activation function?","options":[{"id":"a","text":"To make the math slower on purpose"},{"id":"b","text":"Without it, stacking layers is mathematically equivalent to one linear layer, no matter how many layers exist"},{"id":"c","text":"To convert inputs into images"},{"id":"d","text":"To remove the need for weights"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-ai-the-neuron-05-o2-c1', 'mission-ai-the-neuron-05-o2', 1, 'drag_and_drop', 'Sort each operation into introduces non-linearity or stays linear.', '{"items":[{"id":"s1","text":"Sigmoid"},{"id":"s2","text":"Multiplying by a fixed weight"},{"id":"s3","text":"ReLU"},{"id":"s4","text":"Adding a bias"},{"id":"s5","text":"Tanh"}],"targets":[{"id":"nonlinear","label":"Introduces non-linearity"},{"id":"linear","label":"Stays linear"}]}'::jsonb, '{"correctMapping":{"s1":"nonlinear","s2":"linear","s3":"nonlinear","s4":"linear","s5":"nonlinear"}}'::jsonb),

  ('mission-ai-the-neuron-06-o1-c1', 'mission-ai-the-neuron-06-o1', 1, 'multiple_choice', 'What is the output range of the sigmoid activation function?', '{"question":"What is the output range of the sigmoid activation function?","options":[{"id":"a","text":"-1 to 1"},{"id":"b","text":"0 to 1"},{"id":"c","text":"0 to infinity"},{"id":"d","text":"-infinity to infinity"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-ai-the-neuron-06-o2-c1', 'mission-ai-the-neuron-06-o2', 1, 'investigation', 'Which evidence shows sigmoid saturation in action?', '{"evidence":[{"id":"e1","label":"Neuron log","detail":"Pre-activation values above 6 or below -6 all produce sigmoid outputs within 0.01 of 1 or 0"},{"id":"e2","label":"Weight file","detail":"Weights are stored as 32-bit floats"},{"id":"e3","label":"Ops note","detail":"The network runs on a GPU cluster"}],"question":"Which evidence shows sigmoid saturation in action?"}'::jsonb, '{"requiredEvidenceIds":["e1"]}'::jsonb),

  ('mission-ai-the-neuron-07-o1-c1', 'mission-ai-the-neuron-07-o1', 1, 'multiple_choice', 'What is the output range of the tanh activation function?', '{"question":"What is the output range of the tanh activation function?","options":[{"id":"a","text":"-1 to 1"},{"id":"b","text":"0 to 1"},{"id":"c","text":"0 to infinity"},{"id":"d","text":"-infinity to infinity"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-ai-the-neuron-07-o2-c1', 'mission-ai-the-neuron-07-o2', 1, 'drag_and_drop', 'Match each distinguishing property to sigmoid or tanh.', '{"items":[{"id":"g1","text":"Output range 0 to 1"},{"id":"g2","text":"Output range -1 to 1"},{"id":"g3","text":"Zero-centered output"},{"id":"g4","text":"Not zero-centered, always positive-leaning"}],"targets":[{"id":"sigmoid","label":"Sigmoid"},{"id":"tanh","label":"Tanh"}]}'::jsonb, '{"correctMapping":{"g1":"sigmoid","g2":"tanh","g3":"tanh","g4":"sigmoid"}}'::jsonb),

  ('mission-ai-the-neuron-08-o1-c1', 'mission-ai-the-neuron-08-o1', 1, 'multiple_choice', 'A neuron''s pre-activation came out to -0.5. What is its ReLU output?', '{"question":"A neuron''s pre-activation came out to -0.5. What is its ReLU output?","options":[{"id":"a","text":"-0.5"},{"id":"b","text":"0"},{"id":"c","text":"0.5"},{"id":"d","text":"Undefined"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),
  ('mission-ai-the-neuron-08-o2-c1', 'mission-ai-the-neuron-08-o2', 1, 'drag_and_drop', 'Match each property to sigmoid, tanh, or ReLU.', '{"items":[{"id":"r1","text":"Output range 0 to 1"},{"id":"r2","text":"Output range -1 to 1"},{"id":"r3","text":"Output range 0 to infinity"},{"id":"r4","text":"Zero for any negative input"},{"id":"r5","text":"Never fully saturates on the positive side"}],"targets":[{"id":"sigmoid","label":"Sigmoid"},{"id":"tanh","label":"Tanh"},{"id":"relu","label":"ReLU"}]}'::jsonb, '{"correctMapping":{"r1":"sigmoid","r2":"tanh","r3":"relu","r4":"relu","r5":"relu"}}'::jsonb),

  ('mission-ai-the-neuron-09-o1-c1', 'mission-ai-the-neuron-09-o1', 1, 'multiple_choice', 'Which layer''s job is to hold the network''s final answer?', '{"question":"Which layer''s job is to hold the network''s final answer?","options":[{"id":"a","text":"Input layer"},{"id":"b","text":"A hidden layer"},{"id":"c","text":"The output layer"},{"id":"d","text":"None, all layers are equivalent"}]}'::jsonb, '{"correctOptionId":"c"}'::jsonb),
  ('mission-ai-the-neuron-09-o2-c1', 'mission-ai-the-neuron-09-o2', 1, 'interactive_diagram', 'Order how a signal moves through a layered network.', '{"diagramId":"neuron-network-layers","hotspots":[{"id":"h1","label":"Input layer","explanation":"The raw feature values enter the network here."},{"id":"h2","label":"First hidden layer","explanation":"Computes a weighted sum, bias and activation for each of its neurons."},{"id":"h3","label":"Additional hidden layers, if present","explanation":"Each one transforms the previous layer''s output further."},{"id":"h4","label":"Output layer","explanation":"Produces the network''s final result."}],"task":"Order how a signal moves through a layered network, from input to output."}'::jsonb, '{"correctOrderIds":["h1","h2","h3","h4"]}'::jsonb),

  ('mission-ai-the-neuron-10-o1-c1', 'mission-ai-the-neuron-10-o1', 1, 'interactive_diagram', 'Order the steps for computing one neuron''s output.', '{"diagramId":"single-neuron-compute","hotspots":[{"id":"h1","label":"Multiply each input by its matching weight","explanation":"Every input is scaled by the weight assigned to it."},{"id":"h2","label":"Sum all the weighted inputs together","explanation":"The scaled values are added into one weighted sum."},{"id":"h3","label":"Add the neuron''s bias to that sum","explanation":"Bias shifts the sum by a fixed, input-independent amount."},{"id":"h4","label":"Apply the activation function","explanation":"The pre-activation value is bent into the neuron''s final output."}],"task":"Order the steps for computing one neuron''s output, from raw inputs to final value."}'::jsonb, '{"correctOrderIds":["h1","h2","h3","h4"]}'::jsonb),
  ('mission-ai-the-neuron-10-o2-c1', 'mission-ai-the-neuron-10-o2', 1, 'multiple_choice', 'Which statement about a forward pass is true?', '{"question":"Which statement about a forward pass is true?","options":[{"id":"a","text":"It updates the network''s weights based on how wrong the output was"},{"id":"b","text":"It only pushes an input through the network to produce an output; weights stay fixed"},{"id":"c","text":"It requires labeled data to run"},{"id":"d","text":"It can only run once per network"}]}'::jsonb, '{"correctOptionId":"b"}'::jsonb),

  ('mission-ai-the-neuron-11-o1-c1', 'mission-ai-the-neuron-11-o1', 1, 'multiple_choice', 'A sigmoid output neuron produces 0.92 for a given input. What does that most likely represent?', '{"question":"A network''s single output neuron uses a sigmoid activation and produces 0.92 for a given input. What does that most likely represent?","options":[{"id":"a","text":"The network is 92% confident the input belongs to the positive class"},{"id":"b","text":"The network made 92 errors"},{"id":"c","text":"The input has 92 features"},{"id":"d","text":"The weighted sum was exactly 92"}]}'::jsonb, '{"correctOptionId":"a"}'::jsonb),
  ('mission-ai-the-neuron-11-o2-c1', 'mission-ai-the-neuron-11-o2', 1, 'investigation', 'Which evidence explains why 0.92 cannot yet be treated as a meaningful prediction?', '{"evidence":[{"id":"e1","label":"Weight log","detail":"Every weight and bias in this network was picked by hand, none adjusted by training"},{"id":"e2","label":"Output log","detail":"The forward pass produced 0.92 for the test input"},{"id":"e3","label":"Byte''s note","detail":"Arithmetic was double-checked; each step matches the formula exactly"}],"question":"Which evidence explains why this network''s 0.92 output cannot yet be treated as a meaningful prediction?"}'::jsonb, '{"requiredEvidenceIds":["e1"]}'::jsonb),

  ('mission-ai-the-neuron-12-o1-c1', 'mission-ai-the-neuron-12-o1', 1, 'investigation', 'Which draft correctly computes hidden neuron A''s pre-activation value?', '{"evidence":[{"id":"e1","label":"Draft from Recruit A","detail":"Computed the pre-activation as 2.0, from the weighted sum alone, without adding the bias term"},{"id":"e2","label":"Draft from Recruit B","detail":"Computed the pre-activation as 1.5, from (2 times 1.5) plus (0.5 times -2) plus (-0.5)"},{"id":"e3","label":"Draft from Recruit C","detail":"Computed the pre-activation as -3.75, after swapping which weight multiplies which input"}],"question":"Which draft correctly computes hidden neuron A''s pre-activation value from inputs x1=1.5, x2=-2, weights w1=2, w2=0.5, and bias=-0.5?"}'::jsonb, '{"requiredEvidenceIds":["e2"]}'::jsonb),
  ('mission-ai-the-neuron-12-o2-c1', 'mission-ai-the-neuron-12-o2', 1, 'multiple_choice', 'Which activation function fits this network''s hidden layer?', '{"question":"This network''s hidden layer needs an activation function that will not saturate on the positive side and stays cheap to compute at scale -- the standard modern default for hidden layers, not the output. Which one fits?","options":[{"id":"a","text":"Sigmoid"},{"id":"b","text":"Tanh"},{"id":"c","text":"ReLU"},{"id":"d","text":"No activation at all"}]}'::jsonb, '{"correctOptionId":"c"}'::jsonb),
  ('mission-ai-the-neuron-12-o3-c1', 'mission-ai-the-neuron-12-o3', 1, 'interactive_diagram', 'Order this network''s complete forward pass.', '{"diagramId":"full-network-forward-pass","hotspots":[{"id":"h1","label":"Compute the weighted sum plus bias for every hidden neuron","explanation":"Each hidden neuron combines its own inputs, weights and bias."},{"id":"h2","label":"Apply the activation function to each hidden neuron''s pre-activation","explanation":"Every hidden neuron''s pre-activation is bent through its activation function."},{"id":"h3","label":"Pass the hidden layer''s activated outputs forward as inputs to the output neuron","explanation":"The output neuron cannot compute anything until the hidden layer has finished."},{"id":"h4","label":"Compute the weighted sum plus bias for the output neuron","explanation":"The output neuron combines the hidden layer''s outputs with its own weights and bias."},{"id":"h5","label":"Apply the output neuron''s activation function","explanation":"The output neuron''s pre-activation is bent through its own activation function."},{"id":"h6","label":"Read the final value as the network''s output","explanation":"That value is the completed forward pass."}],"task":"Order the full forward pass of this network, from the hidden layer''s arithmetic to the final output."}'::jsonb, '{"correctOrderIds":["h1","h2","h3","h4","h5","h6"]}'::jsonb),
  ('mission-ai-the-neuron-12-o4-c1', 'mission-ai-the-neuron-12-o4', 1, 'boss_encounter', 'Having verified the arithmetic, the activation choice, and the full forward pass, state what this network has proven.', '{"stages":[{"objectiveRef":"mission-ai-the-neuron-12-o1","label":"Do the arithmetic"},{"objectiveRef":"mission-ai-the-neuron-12-o2","label":"Choose the activation"},{"objectiveRef":"mission-ai-the-neuron-12-o3","label":"Trace the full forward pass"}],"task":"State in one sentence what this network has actually proven, and be clear about what it still cannot do."}'::jsonb, '{"requiredObjectiveIds":["mission-ai-the-neuron-12-o1","mission-ai-the-neuron-12-o2","mission-ai-the-neuron-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-ai-the-neuron-01-o1-c1', 'orientation', 'There is nothing to solve here -- just confirm you are ready to meet Cipher Division''s newest lead.', 0, 1),

  ('mission-ai-the-neuron-01-o2-c1', 'orientation', 'Think about what every model since Act 6 had in common: a person picking the inputs.', 10, 1),
  ('mission-ai-the-neuron-01-o2-c1', 'concept', 'Deep learning''s defining trait is not raw accuracy -- it is who decides the features, a person or the model itself.', 20, 2),
  ('mission-ai-the-neuron-01-o2-c1', 'solution', 'Deep learning removes the need for a person to hand-design features, letting the model find its own directly from raw data.', 30, 3),

  ('mission-ai-the-neuron-02-o1-c1', 'orientation', 'Think about the three ingredients Elena just named: inputs, weights, bias, and one function applied at the end.', 10, 1),
  ('mission-ai-the-neuron-02-o1-c1', 'solution', 'A perceptron computes a weighted sum of its inputs, adds a bias, then passes the result through an activation function.', 20, 2),
  ('mission-ai-the-neuron-02-o2-c1', 'orientation', 'One part comes in from outside, one part scales it, one part is independent of any input, one part is applied last.', 10, 1),
  ('mission-ai-the-neuron-02-o2-c1', 'solution', 'Input is the incoming signal, weight is its importance, bias is the fixed offset, and the activation function converts the weighted sum into the final output.', 20, 2),

  ('mission-ai-the-neuron-03-o1-c1', 'orientation', 'Compare the size of each weight, ignoring the sign at first.', 10, 1),
  ('mission-ai-the-neuron-03-o1-c1', 'solution', '3.0 has a far larger magnitude than -0.1, so Input A dominates the neuron''s decision.', 20, 2),
  ('mission-ai-the-neuron-03-o2-c1', 'orientation', 'Multiply each input by its own weight first, then add the two products.', 10, 1),
  ('mission-ai-the-neuron-03-o2-c1', 'concept', '0.5 times 4 is 2. -1.5 times 2 is -3.', 20, 2),
  ('mission-ai-the-neuron-03-o2-c1', 'solution', '2 + (-3) = -1.', 30, 3),

  ('mission-ai-the-neuron-04-o1-c1', 'orientation', 'Bias does not touch any input value at all -- it is added after the weighted sum is already computed.', 10, 1),
  ('mission-ai-the-neuron-04-o1-c1', 'solution', 'Bias adds a fixed, input-independent offset that shifts the neuron''s decision threshold.', 20, 2),
  ('mission-ai-the-neuron-04-o2-c1', 'orientation', 'Add the bias directly to the weighted sum -- nothing else changes.', 10, 1),
  ('mission-ai-the-neuron-04-o2-c1', 'solution', '-1 + 2 = 1.', 20, 2),

  ('mission-ai-the-neuron-05-o1-c1', 'orientation', 'Think about what happens if you stack many purely linear operations on top of each other.', 10, 1),
  ('mission-ai-the-neuron-05-o1-c1', 'solution', 'Without non-linearity, any number of stacked layers is mathematically equivalent to a single linear layer -- depth adds nothing.', 20, 2),
  ('mission-ai-the-neuron-05-o2-c1', 'orientation', 'Multiplying by a fixed number or adding a fixed number never bends a straight line.', 10, 1),
  ('mission-ai-the-neuron-05-o2-c1', 'solution', 'Sigmoid, ReLU and tanh all bend their input non-linearly. Multiplying by a weight and adding a bias both stay linear.', 20, 2),

  ('mission-ai-the-neuron-06-o1-c1', 'orientation', 'Sigmoid is famous for representing a probability.', 10, 1),
  ('mission-ai-the-neuron-06-o1-c1', 'solution', 'Sigmoid squashes any real number into the open interval 0 to 1.', 20, 2),
  ('mission-ai-the-neuron-06-o2-c1', 'orientation', 'Saturation means the output barely changes no matter how much the input changes.', 10, 1),
  ('mission-ai-the-neuron-06-o2-c1', 'solution', 'e1: pre-activation values beyond plus or minus 6 all collapse to outputs within 0.01 of 1 or 0 -- that flatness is saturation.', 20, 2),

  ('mission-ai-the-neuron-07-o1-c1', 'orientation', 'Tanh is described as sigmoid''s zero-centered cousin, with a wider range.', 10, 1),
  ('mission-ai-the-neuron-07-o1-c1', 'solution', 'Tanh squashes any real number into the open interval -1 to 1.', 20, 2),
  ('mission-ai-the-neuron-07-o2-c1', 'orientation', 'Only two properties differ between sigmoid and tanh: the range, and whether zero sits in the middle of it.', 10, 1),
  ('mission-ai-the-neuron-07-o2-c1', 'solution', 'Sigmoid: range 0 to 1, not zero-centered. Tanh: range -1 to 1, zero-centered.', 20, 2),

  ('mission-ai-the-neuron-08-o1-c1', 'orientation', 'ReLU''s rule: keep positive values unchanged, replace anything negative with zero.', 10, 1),
  ('mission-ai-the-neuron-08-o1-c1', 'solution', '-0.5 is negative, so ReLU outputs 0.', 20, 2),
  ('mission-ai-the-neuron-08-o2-c1', 'orientation', 'ReLU is the only one of the three whose range starts at zero and never has an upper bound.', 10, 1),
  ('mission-ai-the-neuron-08-o2-c1', 'solution', 'Sigmoid: 0 to 1. Tanh: -1 to 1. ReLU: 0 to infinity, zero for any negative input, and it never saturates on the positive side.', 20, 2),

  ('mission-ai-the-neuron-09-o1-c1', 'orientation', 'Only one layer''s job is to produce the answer the rest of the system actually reads.', 10, 1),
  ('mission-ai-the-neuron-09-o1-c1', 'solution', 'The output layer produces the network''s final result.', 20, 2),
  ('mission-ai-the-neuron-09-o2-c1', 'orientation', 'A signal always enters before it can be transformed, and it is always transformed before a final answer exists.', 10, 1),
  ('mission-ai-the-neuron-09-o2-c1', 'solution', 'Input layer, first hidden layer, any additional hidden layers, then the output layer.', 20, 2),

  ('mission-ai-the-neuron-10-o1-c1', 'orientation', 'This is the same sequence Missions 3 and 4 already walked through by hand, just named as steps.', 10, 1),
  ('mission-ai-the-neuron-10-o1-c1', 'solution', 'Multiply each input by its weight, sum the results, add the bias, then apply the activation function.', 20, 2),
  ('mission-ai-the-neuron-10-o2-c1', 'orientation', 'A forward pass only moves a signal forward through fixed parameters -- it never looks at how wrong the output was.', 10, 1),
  ('mission-ai-the-neuron-10-o2-c1', 'solution', 'A forward pass only pushes an input through the network to produce an output; the weights stay fixed throughout.', 20, 2),

  ('mission-ai-the-neuron-11-o1-c1', 'orientation', 'A sigmoid output is already bounded between 0 and 1 -- that range is what makes it readable as a probability.', 10, 1),
  ('mission-ai-the-neuron-11-o1-c1', 'solution', '0.92 reads as the network being 92% confident the input belongs to the positive class.', 20, 2),
  ('mission-ai-the-neuron-11-o2-c1', 'orientation', 'Correct arithmetic on untrained weights is still just correct arithmetic on untrained weights.', 10, 1),
  ('mission-ai-the-neuron-11-o2-c1', 'solution', 'e1: every weight and bias was picked by hand, not learned from data, so the number has no learned meaning yet, however correctly it was computed.', 20, 2),

  ('mission-ai-the-neuron-12-o1-c1', 'orientation', 'Match each weight to its own input; do not swap them, and do not forget the bias at the end.', 10, 1),
  ('mission-ai-the-neuron-12-o1-c1', 'solution', '(2 times 1.5) + (0.5 times -2) + (-0.5) = 3 - 1 - 0.5 = 1.5. Draft B has it right.', 20, 2),

  ('mission-ai-the-neuron-12-o2-c1', 'orientation', 'Sigmoid and tanh both saturate hard at large inputs -- exactly the problem this hidden layer needs to avoid.', 10, 1),
  ('mission-ai-the-neuron-12-o2-c1', 'solution', 'ReLU is cheap to compute and does not saturate on the positive side, which is why it is the default for hidden layers in modern networks.', 20, 2),

  ('mission-ai-the-neuron-12-o3-c1', 'orientation', 'Every hidden neuron must finish completely -- weighted sum, bias, activation -- before its output can feed the next layer.', 10, 1),
  ('mission-ai-the-neuron-12-o3-c1', 'concept', 'The output neuron cannot compute anything until every hidden neuron it depends on has already produced its activated output.', 20, 2),
  ('mission-ai-the-neuron-12-o3-c1', 'solution', 'Weighted sum plus bias for each hidden neuron, activation for each hidden neuron, hand those outputs to the output neuron, weighted sum plus bias for the output neuron, its activation, then read the final value.', 30, 3),

  ('mission-ai-the-neuron-12-o4-c1', 'orientation', 'Look at what the arithmetic, the activation choice, and the full trace all proved together, not as separate facts.', 15, 1),
  ('mission-ai-the-neuron-12-o4-c1', 'solution', 'This network correctly computes a full forward pass by hand, with sensible values at every step -- proof the architecture works. It has not been trained on anything, so nothing about its current output should be trusted as a real prediction yet.', 25, 2);
