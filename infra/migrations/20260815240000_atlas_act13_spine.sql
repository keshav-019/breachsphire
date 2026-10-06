-- Atlas Division pathway ("The Silence"): World row for Act 13,
-- "Serverless Frontier", closing act-atlas-4 ("World IV -- Cloudreach",
-- Acts 10-13: The Cloud Opens, Identity Plane, AWS Sector, Serverless
-- Frontier). Content (missions) follows in its own migration.
--
-- Narrative thread: Act 12's undeployed `region_guard_remediate`
-- Lambda finally goes live for real. Its first real invocation storm
-- is not an attack -- it is the intersection of two decisions that were
-- each individually correct: Act 11's least-privilege IAM role
-- (scoped exactly to what was understood at the time) never actually
-- included the permissions this specific remediation needs, and a
-- default retry policy with no maximum attempts and no dead-letter
-- queue turned that one permission gap into thousands of failed
-- invocations within the hour.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-serverless-frontier', 'act-atlas-4', 12, 'serverless-frontier', 'Serverless Frontier', 'Serverless Frontier',
   'Functions; cold starts; triggers; API gateways; queues; event buses; object events; statelessness; concurrency; retries and dead-letter queues; cost.',
   'The Act 12 fix lands for real: `region_guard_remediate` is deployed, its trigger applied, live for the first time in this whole story. Within the hour, its invocation count has climbed past four thousand and is still climbing.',
   'Invocation Storm',
   'Every single invocation has failed with the exact same error: the role is not authorized to update Route 53 or the load balancer. The Act 11 role was scoped correctly for everything anyone understood it would need -- nobody had actually finished specifying what remediation itself required. With no maximum retry count and no dead-letter queue configured, that one missing permission did not fail once. It failed, and retried, and failed again, thousands of times, entirely on its own.',
   'Every resource in Region One is now real, correctly scoped, and genuinely resilient to its own failures. Every one of those resources has also been written by hand, as text files pretending to be Terraform -- the next question is what happens once this becomes real, version-controlled infrastructure as code.',
   'Invocation Storm', 'Zap', 'elevated', 68, 36, 'pathway-atlas');
