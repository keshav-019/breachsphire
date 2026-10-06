-- Atlas Division pathway ("The Silence"): World row for Act 12, "AWS
-- Sector", still under act-atlas-4 ("World IV -- Cloudreach", which
-- spans Acts 10-13: The Cloud Opens, Identity Plane, AWS Sector,
-- Serverless Frontier) -- no new Act row needed. Content (missions)
-- follows in its own migration.
--
-- The doc's first provider-specific Act -- everything taught generically
-- in Acts 10-11 (virtual networks, compute, storage, databases, load
-- balancers, DNS, CDN, IAM) gets its real AWS service name here, as
-- Vey formally maps Atlas Division's second region onto real AWS
-- primitives and names it "Region One" -- the template every future
-- region will be built from.

insert into public.worlds (
  id, act_id, index, slug, name, short, description, entry_incident,
  capstone_title, story_reveal, transition_hook, boss, icon, threat, x, y, pathway_id
) values
  ('world-atlas-aws-sector', 'act-atlas-4', 11, 'aws-sector', 'AWS Sector', 'AWS Sector',
   'VPC; EC2; S3; RDS; ALB/NLB; Route 53; CloudFront; IAM; CloudWatch; SQS/SNS; Lambda.',
   'Every concept from The Cloud Opens and Identity Plane has a real name on the provider Atlas Division actually runs on. Vey starts mapping atlas-eu-west onto real AWS primitives one service at a time, formally naming the result Region One -- the template every future region gets built from.',
   'Region One',
   'Every mapped service checks out -- the VPC, EC2 fleet, S3 replication, RDS replica, ALB targets, Route 53 weighting and CloudFront failover are all genuinely correct. The one piece that is not is the automated safety net built specifically to catch problems like Act 10''s: a CloudWatch alarm and SNS topic exist and are wired correctly, but the Lambda function they are supposed to trigger was declared in code and never actually deployed. The exact system meant to catch "declared but never finished" was itself declared and never finished.',
   'Region One is real, correct, and finally has a working safety net behind it. Everything since Act 10 has assumed servers running around the clock -- the next question is what changes once nothing has to run until the moment it is actually needed.',
   'Region One', 'Cloud', 'guarded', 68, 28, 'pathway-atlas');
