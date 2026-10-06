-- Replace the generic placeholder narrative fields on Acts 16-20's world
-- rows (already inserted by 20260811100000_ai_acts6_36_spine.sql) with
-- real story text, ahead of hand-authoring their mission content. Only
-- worlds.description/entry_incident/story_reveal/transition_hook change --
-- id/act_id/index/slug/icon/threat/x/y/boss/capstone_title all stay as
-- the existing spine already set them.

update public.worlds set
  description = 'Real tensors, autograd, nn.Module, Dataset/DataLoader and a hand-written training loop -- moving from toy hand-built networks to a production framework without losing the understanding underneath it.',
  entry_incident = 'A stable, honestly-trained network is finally ready to leave toy examples behind. Elena wants the next model built in a real framework -- and built by hand, one primitive at a time, so nobody in the room ever has to trust a hidden default again.',
  story_reveal = 'Byte''s one-line training-wizard shortcut trains a model that looks fine at a glance and is quietly wrong -- it never switches the network out of training mode for validation, so every validation score it reported has been lying the whole time.',
  transition_hook = 'Knowing PyTorch this well raises an obvious question: is it even the right framework for what Cipher Division needs to ship. There is another one, and the answer might not be a technical one at all.'
where id = 'world-ai-pytorch-forge';

update public.worlds set
  description = 'The other major deep learning framework: Keras, the Sequential and Functional APIs, tf.data, callbacks and checkpoints, and the practical tradeoffs that actually decide which framework a production team should use.',
  entry_incident = 'Noah Kim, ML Platform Engineer, joins the room with a question nobody in Cipher Division has bothered to ask yet: which framework are we actually going to run in production, and why.',
  story_reveal = 'Retrained in TensorFlow under an equally fair comparison, the model lands at the same performance as its PyTorch twin -- proof the framework was never the variable that mattered for this decision.',
  transition_hook = 'Two frameworks, two equally good models, and Cipher Division still has not asked the harder question: whether either one was actually trained and evaluated the right way, or just trained twice the same wrong way.'
where id = 'world-ai-tensorflow-engine';

update public.worlds set
  description = 'Turning ad hoc modeling into a real discipline: hypotheses, baselines, controlled experiments, hyperparameter tuning, learning curves, ablations, error analysis and experiment tracking.',
  entry_incident = 'A new model variant just beat every baseline this Arc has built, by a wide margin, on the first try. Maya wants to know why before anyone updates a single production system.',
  story_reveal = 'The improvement does not survive a controlled ablation -- it came from an easier evaluation set and a lucky random seed, not from anything the new variant actually does better.',
  transition_hook = 'A real experimentation discipline is finally in place. Everything built through this Arc has been numbers and structured data. Cipher Labs runs on cameras too, and nobody has taught a model to read one yet.'
where id = 'world-ai-experimentation';

update public.worlds set
  description = 'Images as tensors, convolution, kernels, feature maps, pooling and CNNs -- learning to read a camera feed with the same rigor applied to every other kind of data this pathway has covered.',
  entry_incident = 'Cooling-system camera feeds across Cipher Labs have been flagging inconsistently since Echo''s power draw first spiked back in Act 1. Nobody has ever taught a model to actually look at them.',
  story_reveal = 'A properly trained CNN spots a genuine reactor housing fracture in the camera feed that every manual inspection this month missed -- the kind of damage a busy human reviewer skims right past.',
  transition_hook = 'One classifier answering yes or no is not enough for a facility this size. Cipher Labs needs to know exactly where every problem is, not just whether one exists somewhere in the frame.'
where id = 'world-ai-machines-that-see';

update public.worlds set
  description = 'Transfer learning and fine-tuning from pretrained models, object detection and bounding boxes, segmentation, image embeddings and vision transformers -- finding and localizing every instance of a problem, not just naming one.',
  entry_incident = 'The reactor-damage classifier works, but it only ever answers yes or no for a whole image. Cipher Labs needs to know where every hazard is across a full camera feed, not just whether one exists somewhere in it.',
  story_reveal = 'A fine-tuned detection model finds every genuine hazard across a full inspection sweep, correctly localized -- and confirms the original single reactor fracture was not an isolated incident.',
  transition_hook = 'Vision solved how Cipher Labs watches its own infrastructure. Echo does not just watch the world through cameras. It talks. The next question is how a machine reads language the same way it just learned to read an image.'
where id = 'world-ai-advanced-vision';
