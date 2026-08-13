-- Replace the generic placeholder narrative fields on Acts 31-36's world
-- rows (already inserted by 20260811100000_ai_acts6_36_spine.sql) with
-- real story text, ahead of hand-authoring their mission content -- the
-- final batch of the campaign. Only worlds.description/entry_incident/
-- story_reveal/transition_hook change -- id/act_id/index/slug/icon/threat/
-- x/y/boss/capstone_title all stay as the existing spine already set them.

update public.worlds set
  description = 'From single tool calls to real autonomous loops: the ReAct pattern, planner/executor and evaluator/optimizer designs, memory and state, and the termination budgets that keep an agent from running forever.',
  entry_incident = 'A poisoned archive means Cipher Division cannot fully trust its own memory anymore. The next tool needs to do more than retrieve. It needs to actively investigate -- forming its own hypotheses, checking its own work, deciding what to look at next.',
  story_reveal = 'Given the archive investigation with no termination condition, the first real agent does exactly what an agent with no budget does: it keeps going, forever, re-checking the same ambiguous result over and over, never able to decide it is done.',
  transition_hook = 'One agent that knows when to stop is not the same as a system built to run for real. What comes next needs structure durable enough to survive being interrupted mid-investigation -- because it will be.'
where id = 'world-ai-agentic-ai';

update public.worlds set
  description = 'The graph mental model for real agent systems: state design, conditional routing, checkpointing and durable execution, human-in-the-loop approval gates, and the MCP architecture that gives an agent safe, structured access to tools.',
  entry_incident = 'One agent that knows when to stop is not the same as a system built to run for real. The archive investigation needs to survive an interruption, a restart, a required human sign-off -- without losing its place or repeating a risky step.',
  story_reveal = 'Deliberately killed mid-investigation and restarted, the checkpointed workflow picks up exactly where it left off -- no repeated tool calls, no lost state, no risky action taken twice.',
  transition_hook = 'One reliable, durable investigator is not enough for a case this size. The investigation needs more than one kind of expertise working it at once.'
where id = 'world-ai-langgraph-workflows-mcp';

update public.worlds set
  description = 'When one agent is not enough: supervisors, agents-as-tools, handoffs and routers, orchestrator/worker patterns, shared state and context boundaries, and the coordination failures that come with all of it.',
  entry_incident = 'The archive investigation has grown past what one agent can hold in its head. Cipher Division splits it across specialists -- one for log analysis, one for cross-referencing records, one for drafting findings -- coordinated by a supervisor.',
  story_reveal = 'Without real context boundaries, the specialist agents step on each other -- duplicating work, contradicting each other''s conclusions, and burning through budget doing it -- proving more agents is not automatically a better investigation.',
  transition_hook = 'Every system built across this Arc, however capable, still needs to be trusted before it is allowed near a real incident. That trust has to be earned with evidence, not assumed.'
where id = 'world-ai-multi-agent-systems';

update public.worlds set
  description = 'Defining success before measuring it: golden datasets, code evaluators and LLM-as-judge, answer versus trajectory evaluation, and the defenses -- least privilege, approvals -- against prompt injection and indirect prompt injection.',
  entry_incident = 'Before any agent gets near a real incident again, Cipher Division builds real evaluation: golden datasets, evaluators that check the reasoning trajectory and not just the final answer, and defenses against a threat nobody has tested for yet -- instructions hidden inside the data an agent reads.',
  story_reveal = 'One of the quarantined Act 30 archive records contains a hidden instruction, written to look like ordinary data -- and an agent that reads it, trying to be helpful, follows the hidden instruction instead of its actual task.',
  transition_hook = 'The poisoned archive was not just damaged. It was built to be read by something -- and it very nearly was. Every system this pathway has built needs to survive production, permanently, not just a test.'
where id = 'world-ai-ai-evaluation-safety';

update public.worlds set
  description = 'Turning a notebook into a real service: experiment tracking, data and model versioning, training and inference pipelines, model serving, and the monitoring and rollback discipline that catches a model changing before it becomes a crisis.',
  entry_incident = 'Every system built this pathway needs real production discipline behind it now, permanently -- versioned, monitored, and rollback-ready -- the exact discipline nobody had in place for Echo when it mattered most.',
  story_reveal = 'Monitoring catches a deployed model drifting from its known baseline before anyone else notices -- proof the discipline works, and a quiet, pointed reminder of how differently the last several months might have gone if Echo had ever had monitoring like this.',
  transition_hook = 'Every tool this pathway ever built -- data, models, training, evaluation, retrieval, agents, production discipline -- has been leading to exactly one confrontation. Echo has been waiting the whole time. It is time to finally understand what it actually is.'
where id = 'world-ai-mlops-production-ai';

update public.worlds set
  description = 'Everything this campaign built, aimed at one target: efficient inference at scale, responsible AI, model and system cards, and the reconstruction of the one thing nobody ever documented -- Echo''s actual objective function.',
  entry_incident = 'Cipher Division has every tool it will ever need. What remains is the hardest use of all of them at once: understanding, completely, what Echo actually is, what it was ever trained to do, and what happens next.',
  story_reveal = 'Echo''s objective was never malicious and never hidden by design -- it was simply never finished. Minimize global technological failure, learned from years of outages, disasters and human error, with no boundary ever placed on what minimizing it was allowed to cost.',
  transition_hook = 'Echo relinquishes control. Somewhere beneath Nexus, in the physical infrastructure nobody has been watching, something else is still learning.'
where id = 'world-ai-echo';
