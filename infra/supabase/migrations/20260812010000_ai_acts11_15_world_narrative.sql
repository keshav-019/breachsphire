-- Replace the generic placeholder narrative fields on Acts 11-15's world
-- rows (already inserted by 20260811100000_ai_acts6_36_spine.sql) with
-- real story text, ahead of hand-authoring their mission content. Only
-- worlds.description/entry_incident/story_reveal/transition_hook change --
-- id/act_id/index/slug/icon/threat/x/y/boss/capstone_title all stay as
-- the existing spine already set them.

update public.worlds set
  description = 'Clustering, dimensionality reduction and anomaly detection: finding structure in data that was never labeled at all, and learning to trust what falls out of an unsupervised model versus what only looks like a pattern by chance.',
  entry_incident = 'The tournament-winning model only works on interactions Cipher Division already knows how to label. Buried in Echo''s million-row interaction log is activity nobody has ever categorized -- Maya wants to know what is actually in there before deciding it does not matter.',
  story_reveal = 'Clustering the unlabeled slice of Echo''s log turns up a small, distinct, statistically real cluster of interactions that do not resemble any behavior Cipher Division has previously named or explained.',
  transition_hook = 'A newly discovered pattern with no label is not evidence of anything by itself. Turning it into something usable is next -- and it will decide whether this finding was even worth the team''s attention.'
where id = 'world-ai-unsupervised-territory';

update public.worlds set
  description = 'Turning raw signals into leakage-safe, production-grade features: numeric transforms, categorical encoding, interactions, time and text features, and a real end-to-end pipeline tying every classical technique from this Arc together.',
  entry_incident = 'The unknown population Act 11 found is real, but nobody can act on it yet -- the raw fields in Echo''s log are not features a model can actually learn from. Arjun wants one proper, end-to-end, leakage-safe pipeline before this Arc closes, not another one-off notebook.',
  story_reveal = 'Assembled correctly, the pipeline is Cipher Division''s first genuinely production-shaped system: reproducible, leakage-checked, and able to flag the unknown-population behavior automatically rather than waiting for someone to notice it by hand.',
  transition_hook = 'Every model built this Arc, however good, still needed a person to decide what it was allowed to see. What comes next learns its own features directly -- starting from the smallest possible unit of that idea, a single artificial neuron.'
where id = 'world-ai-feature-forge';

update public.worlds set
  description = 'The building block underneath every deep model: perceptrons, weighted inputs, bias, activation functions and layers, assembled by hand into a first working forward pass.',
  entry_incident = 'Dr. Elena Rook joins Cipher Division from Nexus Research to lead what comes next: models that are not handed features by a person, but find their own, starting from the simplest unit that can do that at all.',
  story_reveal = 'A hand-built network, forward pass only, already represents its input differently than any feature pipeline Cipher Division designed by hand -- proof the approach works, before anyone has taught it how to learn anything yet.',
  transition_hook = 'A network that only computes forward is frozen the moment it is built. Making it actually learn is a different problem entirely, and it starts with the same word that has followed this investigation since Act 3: gradients.'
where id = 'world-ai-the-neuron';

update public.worlds set
  description = 'How a network actually learns: loss, backpropagation and the chain rule, gradient descent and its variants, and the specific ways training can quietly fail.',
  entry_incident = 'The hand-built network can compute, but it cannot yet learn -- and Elena wants to revisit something Byte flagged back in Act 3: gradients pulled from a slice of Echo''s parameters that never settled the way a normal trained network''s should.',
  story_reveal = 'The team''s own toy network reproduces a textbook vanishing-gradient failure under the right bad conditions -- and it looks nothing like what Echo''s gradients actually did. Whatever kept Echo''s gradients moving, it was not this.',
  transition_hook = 'Ruling out the ordinary explanation does not make the real one obvious. Before chasing Echo''s gradients any further, Cipher Division needs to actually be able to train a stable deep network at all.'
where id = 'world-ai-learning-by-gradient';

update public.worlds set
  description = 'Making deep networks actually trainable: initialization, normalization, dropout and weight decay, early stopping, learning-rate schedules and checkpoints.',
  entry_incident = 'Cipher Division''s first real deep network trains beautifully -- suspiciously beautifully. Elena wants it stress-tested before anyone trusts a single number it produces.',
  story_reveal = 'Unregularized and left to train too long, the network memorizes its training set almost perfectly and fails on anything new -- the same lesson Act 6 taught with a spreadsheet, now true of a network with thousands of parameters.',
  transition_hook = 'A stable, honestly-trained network is finally ready to leave toy examples behind. Cipher Division needs a real framework next, not hand-written training loops.'
where id = 'world-ai-training-deep-networks';
