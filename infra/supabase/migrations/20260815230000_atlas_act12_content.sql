-- Atlas Division pathway ("The Silence") Act 12 -- "AWS Sector"
-- content, under world-atlas-aws-sector (already inserted separately).
-- 1 campaign, 2 operations, 12 missions (11 lessons + boss), continuing
-- World IV "Cloudreach" (Acts 10-13).
--
-- Same terminal-engine constraint as Acts 4-11 -- every AWS resource
-- here is static seeded Terraform-style text read via `cat`. Missions
-- 1-11 are declared infrastructure-as-code on the reused
-- `atlas-devbox-01` host; the boss adds a new `atlas-aws-live-01` host
-- for the actual deployed-resource inventory, so the declared-versus-
-- actual gap is a genuine two-host contrast, same technique as Act 4's
-- GitOps manifest and Act 10's DNS/load-balancer gap.
--
-- Narrative thread: missions 1-8 are direct, explicit callbacks --
-- each AWS service is introduced as literally the same resource from
-- Act 10 or Act 11, now given its real provider name (the ALB and
-- Route 53 missions specifically pay off Act 10's fix, now showing
-- both regions correctly registered; the IAM mission pays off Act 11's
-- fix, showing the scoped workload-identity role that replaced
-- svc-eu-west-bootstrap). Missions 9-11 introduce CloudWatch, SQS/SNS
-- and Lambda as a new automated safety net specifically built to catch
-- Act 10-style problems in the future -- and the boss reveals that
-- safety net has the exact same "declared, never finished" flaw it was
-- built to catch.

insert into public.campaigns (id, world_id, slug, title, description, sort_order) values
  ('campaign-atlas-aws-sector', 'world-atlas-aws-sector', 'aws-sector', '4C - AWS Sector', 'Map everything learned in The Cloud Opens and Identity Plane onto real AWS services -- VPC, EC2, S3, RDS, ALB/NLB, Route 53, CloudFront, IAM, CloudWatch, SQS/SNS and Lambda -- while Vey formally names the result Region One and finds one piece that was never actually finished.', 3);

insert into public.operations (id, campaign_id, slug, title, description, sort_order) values
  ('operation-atlas-aws-sector-1', 'campaign-atlas-aws-sector', 'the-same-region-real-names', 'The Same Region, Real Names', 'VPC, EC2, S3, RDS, ALB/NLB, Route 53 and CloudFront.', 1),
  ('operation-atlas-aws-sector-2', 'campaign-atlas-aws-sector', 'a-safety-net-with-a-hole-in-it', 'A Safety Net With a Hole In It', 'IAM, CloudWatch, SQS/SNS and Lambda.', 2);

insert into public.missions (
  id, world_id, campaign_id, operation_id, slug, title, description, difficulty,
  character_ids, prerequisites, required_skills, lab, rewards, is_boss, sort_order
) values
  ('mission-atlas-aws-sector-01', 'world-atlas-aws-sector', 'campaign-atlas-aws-sector', 'operation-atlas-aws-sector-1', 'vpc', 'VPC', 'Every concept from the last two Acts has a real name on the provider Atlas Division actually runs on. Vey starts with the network.', 'beginner', ARRAY['leena','vey'], null, null, '{"type":"simulation","simulationId":"vpc-sim"}'::jsonb, '{"xp":230,"credits":35}'::jsonb, false, 1),
  ('mission-atlas-aws-sector-02', 'world-atlas-aws-sector', 'campaign-atlas-aws-sector', 'operation-atlas-aws-sector-1', 'ec2', 'EC2', 'Confirm the compute fleet from Act 10 now has a real name.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-aws-sector-01"]}'::jsonb, null, '{"type":"simulation","simulationId":"ec2-sim"}'::jsonb, '{"xp":230,"credits":35}'::jsonb, false, 2),
  ('mission-atlas-aws-sector-03', 'world-atlas-aws-sector', 'campaign-atlas-aws-sector', 'operation-atlas-aws-sector-1', 's3', 'S3', 'Confirm the artifact bucket from Act 5 and Act 10 now has a real name.', 'beginner', ARRAY['vey','rook'], '{"requiredMissionIds":["mission-atlas-aws-sector-02"]}'::jsonb, null, '{"type":"simulation","simulationId":"s3-sim"}'::jsonb, '{"xp":240,"credits":40}'::jsonb, false, 3),
  ('mission-atlas-aws-sector-04', 'world-atlas-aws-sector', 'campaign-atlas-aws-sector', 'operation-atlas-aws-sector-1', 'rds', 'RDS', 'Confirm the database replica from Act 10 now has a real name.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-aws-sector-03"]}'::jsonb, null, '{"type":"simulation","simulationId":"rds-sim"}'::jsonb, '{"xp":240,"credits":40}'::jsonb, false, 4),
  ('mission-atlas-aws-sector-05', 'world-atlas-aws-sector', 'campaign-atlas-aws-sector', 'operation-atlas-aws-sector-1', 'alb-nlb', 'ALB/NLB', 'Confirm the load balancer from Act 10 -- and confirm it now actually includes the targets it was always missing.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-aws-sector-04"]}'::jsonb, null, '{"type":"simulation","simulationId":"alb-nlb-sim"}'::jsonb, '{"xp":250,"credits":45}'::jsonb, false, 5),
  ('mission-atlas-aws-sector-06', 'world-atlas-aws-sector', 'campaign-atlas-aws-sector', 'operation-atlas-aws-sector-1', 'route-53', 'Route 53', 'Confirm DNS itself now resolves toward both regions, not just one.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-aws-sector-05"]}'::jsonb, null, '{"type":"simulation","simulationId":"route-53-sim"}'::jsonb, '{"xp":250,"credits":45}'::jsonb, false, 6),
  ('mission-atlas-aws-sector-07', 'world-atlas-aws-sector', 'campaign-atlas-aws-sector', 'operation-atlas-aws-sector-1', 'cloudfront', 'CloudFront', 'Confirm the CDN now fails over between regions instead of pointing at just one.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-aws-sector-06"]}'::jsonb, null, '{"type":"simulation","simulationId":"cloudfront-sim"}'::jsonb, '{"xp":250,"credits":45}'::jsonb, false, 7),
  ('mission-atlas-aws-sector-08', 'world-atlas-aws-sector', 'campaign-atlas-aws-sector', 'operation-atlas-aws-sector-2', 'iam-aws', 'IAM', 'Confirm the identity that replaced svc-eu-west-bootstrap is actually scoped the way Act 11 demanded.', 'beginner', ARRAY['vey','cross'], '{"requiredMissionIds":["mission-atlas-aws-sector-07"]}'::jsonb, null, '{"type":"simulation","simulationId":"iam-aws-sim"}'::jsonb, '{"xp":260,"credits":45}'::jsonb, false, 8),
  ('mission-atlas-aws-sector-09', 'world-atlas-aws-sector', 'campaign-atlas-aws-sector', 'operation-atlas-aws-sector-2', 'cloudwatch', 'CloudWatch', 'Confirm the alarm built specifically to catch the next Act 10 before it happens.', 'beginner', ARRAY['cross'], '{"requiredMissionIds":["mission-atlas-aws-sector-08"]}'::jsonb, null, '{"type":"simulation","simulationId":"cloudwatch-sim"}'::jsonb, '{"xp":260,"credits":50}'::jsonb, false, 9),
  ('mission-atlas-aws-sector-10', 'world-atlas-aws-sector', 'campaign-atlas-aws-sector', 'operation-atlas-aws-sector-2', 'sqs-sns', 'SQS/SNS', 'Confirm what the alarm is actually wired to notify.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-aws-sector-09"]}'::jsonb, null, '{"type":"simulation","simulationId":"sqs-sns-sim"}'::jsonb, '{"xp":260,"credits":50}'::jsonb, false, 10),
  ('mission-atlas-aws-sector-11', 'world-atlas-aws-sector', 'campaign-atlas-aws-sector', 'operation-atlas-aws-sector-2', 'lambda', 'Lambda', 'Confirm what the notification is actually supposed to trigger.', 'beginner', ARRAY['vey'], '{"requiredMissionIds":["mission-atlas-aws-sector-10"]}'::jsonb, null, '{"type":"simulation","simulationId":"lambda-sim"}'::jsonb, '{"xp":270,"credits":50}'::jsonb, false, 11),
  ('mission-atlas-aws-sector-12', 'world-atlas-aws-sector', 'campaign-atlas-aws-sector', 'operation-atlas-aws-sector-2', 'region-one', 'Region One', 'Everything this Act taught, turned on one safety net: not to assume it works because it is written down, to finally confirm whether the system built to catch this exact mistake ever actually went live.', 'boss', ARRAY['vey','cross','rook','leena'], '{"requiredMissionIds":["mission-atlas-aws-sector-11"]}'::jsonb, null, '{"type":"simulation","simulationId":"region-one-boss-sim"}'::jsonb, '{"xp":520,"credits":120,"badgeIds":["region-one"],"skillXp":{"cloud_devops_fundamentals":90}}'::jsonb, true, 12);

insert into public.dialogue_lines (mission_id, sort_order, character_id, text) values
  ('mission-atlas-aws-sector-01', 1, 'leena', 'Every concept from the last two Acts has a real name on the provider Atlas Division actually runs on. Vey is mapping atlas-eu-west onto real AWS primitives, one service at a time.'),
  ('mission-atlas-aws-sector-01', 2, 'vey', 'Tomas Vey. This is the exact same virtual network from Act 10 -- CIDR block, subnets, all of it -- just written as what it actually is: a VPC.'),

  ('mission-atlas-aws-sector-02', 1, 'vey', 'The compute instances from Act 10 have a real name too. Confirm it.'),

  ('mission-atlas-aws-sector-03', 1, 'rook', 'This bucket is the same artifact repository work from Act 5, now living in the same region as everything else. Confirm it is still replicating correctly.'),
  ('mission-atlas-aws-sector-03', 2, 'vey', 'It is. Object storage was never a generic concept -- it was always going to be an S3 bucket, specifically.'),

  ('mission-atlas-aws-sector-04', 1, 'vey', 'The managed database replica from Act 10 has a real name too. Confirm it.'),

  ('mission-atlas-aws-sector-05', 1, 'vey', 'This is the load balancer that never had eu-west targets registered. Confirm whether that is still true.'),

  ('mission-atlas-aws-sector-06', 1, 'vey', 'And this is the DNS record that only ever pointed toward one region. Confirm whether that is still true either.'),

  ('mission-atlas-aws-sector-07', 1, 'vey', 'The CDN origin was hardcoded to one region before. Confirm it can actually fail over now.'),

  ('mission-atlas-aws-sector-08', 1, 'cross', 'Imani Cross. svc-eu-west-bootstrap does not exist anymore. Confirm exactly what replaced it, and that it is actually scoped the way Act 11 demanded.'),

  ('mission-atlas-aws-sector-09', 1, 'cross', 'Nobody should have to notice the next Act 10 by accident, the way I noticed the last one. Confirm the alarm built specifically to catch it automatically.'),

  ('mission-atlas-aws-sector-10', 1, 'vey', 'An alarm firing has to actually notify something. Confirm what this one is wired to.'),

  ('mission-atlas-aws-sector-11', 1, 'vey', 'A notification by itself does not fix anything. Confirm what is actually supposed to act on it.'),

  ('mission-atlas-aws-sector-12', 1, 'leena', 'Everything this Act taught you, on one safety net. Not to assume it works because it is written down -- to finally confirm whether the system built to catch this exact mistake ever actually went live.'),
  ('mission-atlas-aws-sector-12', 2, 'byte', 'I have the declared Lambda definition and the actual deployed function inventory for this region both pulled up together.'),
  ('mission-atlas-aws-sector-12', 3, 'rook', 'Declared in code and actually running are two different claims. I have said that before, in a different Act, about a different resource.'),
  ('mission-atlas-aws-sector-12', 4, 'vey', 'Find out whether it happened again, here, to the one thing that was supposed to stop it from happening again.');

insert into public.objectives (id, mission_id, sort_order, title, description) values
  ('mission-atlas-aws-sector-01-o1', 'mission-atlas-aws-sector-01', 1, 'Read the VPC definition', 'Read the VPC definition and submit the verification code.'),

  ('mission-atlas-aws-sector-02-o1', 'mission-atlas-aws-sector-02', 1, 'Read the EC2 inventory', 'Read the EC2 instance definitions and submit the verification code.'),

  ('mission-atlas-aws-sector-03-o1', 'mission-atlas-aws-sector-03', 1, 'Read the S3 bucket definition', 'Read the S3 bucket definition and submit the verification code.'),

  ('mission-atlas-aws-sector-04-o1', 'mission-atlas-aws-sector-04', 1, 'Read the RDS definition', 'Read the RDS instance definition and submit the verification code.'),

  ('mission-atlas-aws-sector-05-o1', 'mission-atlas-aws-sector-05', 1, 'Read the load balancer targets', 'Read the ALB target group and submit the verification code.'),

  ('mission-atlas-aws-sector-06-o1', 'mission-atlas-aws-sector-06', 1, 'Read the Route 53 records', 'Read the Route 53 records and submit the verification code.'),

  ('mission-atlas-aws-sector-07-o1', 'mission-atlas-aws-sector-07', 1, 'Read the CloudFront distribution', 'Read the CloudFront distribution and submit the verification code.'),

  ('mission-atlas-aws-sector-08-o1', 'mission-atlas-aws-sector-08', 1, 'Read the IAM role', 'Read the IAM role definition and submit the verification code.'),

  ('mission-atlas-aws-sector-09-o1', 'mission-atlas-aws-sector-09', 1, 'Read the CloudWatch alarm', 'Read the CloudWatch alarm definition and submit the verification code.'),

  ('mission-atlas-aws-sector-10-o1', 'mission-atlas-aws-sector-10', 1, 'Read the SNS/SQS wiring', 'Read the SNS topic and subscription and submit the verification code.'),

  ('mission-atlas-aws-sector-11-o1', 'mission-atlas-aws-sector-11', 1, 'Read the Lambda definition', 'Read the declared Lambda function and submit the verification code.'),

  ('mission-atlas-aws-sector-12-o1', 'mission-atlas-aws-sector-12', 1, 'Confirm the Lambda is declared', 'Read the declared Lambda function and submit the verification code.'),
  ('mission-atlas-aws-sector-12-o2', 'mission-atlas-aws-sector-12', 2, 'Confirm what is actually deployed', 'Read the live Lambda inventory and submit the verification code.'),
  ('mission-atlas-aws-sector-12-o3', 'mission-atlas-aws-sector-12', 3, 'Identify what actually explains the gap', 'Find the evidence that explains why the alarm has no working remediation.'),
  ('mission-atlas-aws-sector-12-o4', 'mission-atlas-aws-sector-12', 4, 'State the diagnosis', 'Having confirmed all three, explain what actually has to happen next.');

insert into public.challenges (id, objective_id, sort_order, type, prompt, content, completion_conditions) values
  ('mission-atlas-aws-sector-01-o1-c1', 'mission-atlas-aws-sector-01-o1', 1, 'terminal_simulation', 'Read the VPC definition and submit the verification code.', '{"instructions":"Read /repo/infra/aws/vpc.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/vpc.txt":{"type":"file","content":"resource \"aws_vpc\" \"atlas_eu_west\" { cidr_block = \"10.40.0.0/16\" }\nresource \"aws_subnet\" \"eu_west_1a\" { cidr_block = \"10.40.1.0/24\" }\nresource \"aws_subnet\" \"eu_west_1b\" { cidr_block = \"10.40.2.0/24\" }\n# this is the exact virtual network from Act 10, now specified as a real AWS VPC\n# verification VPC-3312\n"}}}'::jsonb, '{"requiredFlag":"VPC-3312"}'::jsonb),

  ('mission-atlas-aws-sector-02-o1-c1', 'mission-atlas-aws-sector-02-o1', 1, 'terminal_simulation', 'Read the EC2 instance definitions and submit the verification code.', '{"instructions":"Read /repo/infra/aws/ec2.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/ec2.txt":{"type":"file","content":"resource \"aws_instance\" \"collector_eu_west_01\" { instance_type = \"t3.medium\" availability_zone = \"eu-west-1a\" }\nresource \"aws_instance\" \"collector_eu_west_02\" { instance_type = \"t3.medium\" availability_zone = \"eu-west-1b\" }\n# the same compute instances from Act 10, now specified as real EC2 instances\n# verification EC2-6602\n"}}}'::jsonb, '{"requiredFlag":"EC2-6602"}'::jsonb),

  ('mission-atlas-aws-sector-03-o1-c1', 'mission-atlas-aws-sector-03-o1', 1, 'terminal_simulation', 'Read the S3 bucket definition and submit the verification code.', '{"instructions":"Read /repo/infra/aws/s3.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/s3.txt":{"type":"file","content":"resource \"aws_s3_bucket\" \"atlas_eu_west_artifacts\" { bucket = \"atlas-eu-west-artifacts\" }\nreplication_configuration { source = \"atlas-us-east-artifacts\" }\n# the same object storage bucket from Act 10, now specified as a real S3 bucket\n# verification S3-7714\n"}}}'::jsonb, '{"requiredFlag":"S3-7714"}'::jsonb),

  ('mission-atlas-aws-sector-04-o1-c1', 'mission-atlas-aws-sector-04-o1', 1, 'terminal_simulation', 'Read the RDS instance definition and submit the verification code.', '{"instructions":"Read /repo/infra/aws/rds.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/rds.txt":{"type":"file","content":"resource \"aws_db_instance\" \"eu_west_replica\" { engine = \"postgres\" engine_version = \"15\" replicate_source_db = \"atlas_us_east_db_primary\" }\nstatus: available, replication-lag=0.4s\n# the same managed database from Act 10, now specified as a real RDS read replica\n# verification RDS-4471\n"}}}'::jsonb, '{"requiredFlag":"RDS-4471"}'::jsonb),

  ('mission-atlas-aws-sector-05-o1-c1', 'mission-atlas-aws-sector-05-o1', 1, 'terminal_simulation', 'Read the ALB target group and submit the verification code.', '{"instructions":"Read /repo/infra/aws/alb.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/alb.txt":{"type":"file","content":"resource \"aws_lb_target_group\" \"atlas_global\" {\n  targets = [\"us-east-collector-01\", \"us-east-collector-02\", \"eu-west-collector-01\", \"eu-west-collector-02\"]\n}\n# eu-west targets are finally registered -- the Act 10 fix, made real\n# verification ALB-8802\n"}}}'::jsonb, '{"requiredFlag":"ALB-8802"}'::jsonb),

  ('mission-atlas-aws-sector-06-o1-c1', 'mission-atlas-aws-sector-06-o1', 1, 'terminal_simulation', 'Read the Route 53 records and submit the verification code.', '{"instructions":"Read /repo/infra/aws/route53.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/route53.txt":{"type":"file","content":"resource \"aws_route53_record\" \"collector_us\" { type = \"A\" set_identifier = \"us-east\" weight = 50 }\nresource \"aws_route53_record\" \"collector_eu\" { type = \"A\" set_identifier = \"eu-west\" weight = 50 }\n# both regions finally resolve -- the Act 10 DNS fix, made real\n# verification ROUTE53-2291\n"}}}'::jsonb, '{"requiredFlag":"ROUTE53-2291"}'::jsonb),

  ('mission-atlas-aws-sector-07-o1-c1', 'mission-atlas-aws-sector-07-o1', 1, 'terminal_simulation', 'Read the CloudFront distribution and submit the verification code.', '{"instructions":"Read /repo/infra/aws/cloudfront.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/cloudfront.txt":{"type":"file","content":"resource \"aws_cloudfront_distribution\" \"atlas_edge\" {\n  origin { domain_name = \"us-east.atlas.internal\" origin_id = \"us-east\" }\n  origin { domain_name = \"eu-west.atlas.internal\" origin_id = \"eu-west\" }\n  origin_group { failover_criteria { status_codes = [500, 502, 503, 504] } }\n}\n# verification CLOUDFRONT-9012\n"}}}'::jsonb, '{"requiredFlag":"CLOUDFRONT-9012"}'::jsonb),

  ('mission-atlas-aws-sector-08-o1-c1', 'mission-atlas-aws-sector-08-o1', 1, 'terminal_simulation', 'Read the IAM role definition and submit the verification code.', '{"instructions":"Read /repo/infra/aws/iam-role.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/iam-role.txt":{"type":"file","content":"resource \"aws_iam_role\" \"eu_west_bootstrap_v2\" { assume_role_policy = \"workload-identity-federation\" }\nresource \"aws_iam_role_policy\" \"eu_west_bootstrap_v2\" {\n  policy = jsonencode({ Statement = [{ Effect=\"Allow\", Action=[\"ec2:Describe*\",\"s3:GetObject\"], Resource=\"specific-scoped-arns\" }] })\n}\n# this replaces svc-eu-west-bootstrap entirely -- scoped, no static key, workload identity only\n# verification IAM-5541\n"}}}'::jsonb, '{"requiredFlag":"IAM-5541"}'::jsonb),

  ('mission-atlas-aws-sector-09-o1-c1', 'mission-atlas-aws-sector-09-o1', 1, 'terminal_simulation', 'Read the CloudWatch alarm definition and submit the verification code.', '{"instructions":"Read /repo/infra/aws/cloudwatch-alarms.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/cloudwatch-alarms.txt":{"type":"file","content":"resource \"aws_cloudwatch_metric_alarm\" \"unrouted_region_guard\" {\n  alarm_description = \"fires if any healthy region reports zero received traffic for 15 minutes\"\n  alarm_actions = [\"sns:atlas-region-guard-topic\"]\n}\n# verification CWALARM-3390\n"}}}'::jsonb, '{"requiredFlag":"CWALARM-3390"}'::jsonb),

  ('mission-atlas-aws-sector-10-o1-c1', 'mission-atlas-aws-sector-10-o1', 1, 'terminal_simulation', 'Read the SNS topic and subscription and submit the verification code.', '{"instructions":"Read /repo/infra/aws/sqs-sns.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/sqs-sns.txt":{"type":"file","content":"resource \"aws_sns_topic\" \"atlas_region_guard_topic\" {}\nresource \"aws_sns_topic_subscription\" \"region_guard_lambda\" {\n  topic_arn = aws_sns_topic.atlas_region_guard_topic.arn\n  protocol  = \"lambda\"\n  endpoint  = aws_lambda_function.region_guard_remediate.arn\n}\n# verification SNS-4471\n"}}}'::jsonb, '{"requiredFlag":"SNS-4471"}'::jsonb),

  ('mission-atlas-aws-sector-11-o1-c1', 'mission-atlas-aws-sector-11-o1', 1, 'terminal_simulation', 'Read the declared Lambda function and submit the verification code.', '{"instructions":"Read /repo/infra/aws/lambda.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/lambda.txt":{"type":"file","content":"resource \"aws_lambda_function\" \"region_guard_remediate\" {\n  function_name = \"atlas-region-guard-remediate\"\n  runtime = \"go1.x\"\n}\n# auto-remediates region-routing gaps like the one found in Act 10\n# verification LAMBDA-8814\n"}}}'::jsonb, '{"requiredFlag":"LAMBDA-8814"}'::jsonb),

  ('mission-atlas-aws-sector-12-o1-c1', 'mission-atlas-aws-sector-12-o1', 1, 'terminal_simulation', 'Read the declared Lambda function and submit the verification code.', '{"instructions":"Read /repo/infra/aws/lambda.txt and submit the verification code with: submit CODE","hostname":"atlas-devbox-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-devbox-01\n"},"/home/recruit":{"type":"dir"},"/repo/infra/aws/lambda.txt":{"type":"file","content":"resource \"aws_lambda_function\" \"region_guard_remediate\" {\n  function_name = \"atlas-region-guard-remediate\"\n  runtime = \"go1.x\"\n}\n# auto-remediates region-routing gaps like the one found in Act 10\n# verification LAMBDA-8814\n"}}}'::jsonb, '{"requiredFlag":"LAMBDA-8814"}'::jsonb),
  ('mission-atlas-aws-sector-12-o2-c1', 'mission-atlas-aws-sector-12-o2', 1, 'terminal_simulation', 'Read the live Lambda inventory and submit the verification code.', '{"instructions":"Read /var/atlas-aws-live/lambda-inventory.txt and submit the verification code with: submit CODE","hostname":"atlas-aws-live-01","user":"recruit","filesystem":{"/etc/hostname":{"type":"file","content":"atlas-aws-live-01\n"},"/home/recruit":{"type":"dir"},"/var/atlas-aws-live/lambda-inventory.txt":{"type":"file","content":"deployed Lambda functions in atlas-eu-west:\n  (none named atlas-region-guard-remediate)\n0 invocations in the last 90 days -- the function was never actually deployed\n# verification LAMBDALIVE-0000\n"}}}'::jsonb, '{"requiredFlag":"LAMBDALIVE-0000"}'::jsonb),
  ('mission-atlas-aws-sector-12-o3-c1', 'mission-atlas-aws-sector-12-o3', 1, 'investigation', 'Which evidence explains why the alarm has no working remediation?', '{"evidence":[{"id":"e1","label":"Declared Lambda function","detail":"aws_lambda_function.region_guard_remediate is fully defined in the infrastructure code"},{"id":"e2","label":"Live Lambda inventory","detail":"No function named atlas-region-guard-remediate has ever actually been deployed to atlas-eu-west"},{"id":"e3","label":"ALB target group","detail":"All four collector instances, both regions, are correctly registered as targets"},{"id":"e4","label":"Route 53 records","detail":"Both regions resolve correctly with even weighting"}],"question":"Which evidence explains why the alarm has no working remediation?"}'::jsonb, '{"requiredEvidenceIds":["e1","e2"]}'::jsonb),
  ('mission-atlas-aws-sector-12-o4-c1', 'mission-atlas-aws-sector-12-o4', 1, 'boss_encounter', 'Having confirmed the declared Lambda, what is actually deployed, and what explains the gap, state the diagnosis.', '{"stages":[{"objectiveRef":"mission-atlas-aws-sector-12-o1","label":"Confirm the Lambda is declared"},{"objectiveRef":"mission-atlas-aws-sector-12-o2","label":"Confirm what is actually deployed"},{"objectiveRef":"mission-atlas-aws-sector-12-o3","label":"Identify what actually explains the gap"}],"task":"State the diagnosis in one sentence: Region One itself is genuinely correct end to end -- VPC, EC2, S3, RDS, ALB, Route 53, CloudFront and IAM all check out -- but the one system built specifically to catch the next Act 10-style gap automatically was itself declared in code and never actually deployed, and it has to be applied for real before this safety net means anything."}'::jsonb, '{"requiredObjectiveIds":["mission-atlas-aws-sector-12-o1","mission-atlas-aws-sector-12-o2","mission-atlas-aws-sector-12-o3"],"allCorrect":true}'::jsonb);

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order) values
  ('mission-atlas-aws-sector-01-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/vpc.txt', 10, 1),
  ('mission-atlas-aws-sector-01-o1-c1', 'solution', 'The CIDR block matches Act 10 exactly, verification VPC-3312. submit VPC-3312', 20, 2),

  ('mission-atlas-aws-sector-02-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/ec2.txt', 10, 1),
  ('mission-atlas-aws-sector-02-o1-c1', 'solution', 'Two instances, one per zone, verification EC2-6602. submit EC2-6602', 20, 2),

  ('mission-atlas-aws-sector-03-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/s3.txt', 10, 1),
  ('mission-atlas-aws-sector-03-o1-c1', 'solution', 'Replication is configured, verification S3-7714. submit S3-7714', 20, 2),

  ('mission-atlas-aws-sector-04-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/rds.txt', 10, 1),
  ('mission-atlas-aws-sector-04-o1-c1', 'solution', 'It is a healthy postgres read replica, verification RDS-4471. submit RDS-4471', 20, 2),

  ('mission-atlas-aws-sector-05-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/alb.txt', 10, 1),
  ('mission-atlas-aws-sector-05-o1-c1', 'solution', 'All four instances are now registered, verification ALB-8802. submit ALB-8802', 20, 2),

  ('mission-atlas-aws-sector-06-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/route53.txt', 10, 1),
  ('mission-atlas-aws-sector-06-o1-c1', 'solution', 'Both regions have weighted records, verification ROUTE53-2291. submit ROUTE53-2291', 20, 2),

  ('mission-atlas-aws-sector-07-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/cloudfront.txt', 10, 1),
  ('mission-atlas-aws-sector-07-o1-c1', 'solution', 'Two origins with failover, verification CLOUDFRONT-9012. submit CLOUDFRONT-9012', 20, 2),

  ('mission-atlas-aws-sector-08-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/iam-role.txt', 10, 1),
  ('mission-atlas-aws-sector-08-o1-c1', 'solution', 'Scoped actions, workload identity, no static key, verification IAM-5541. submit IAM-5541', 20, 2),

  ('mission-atlas-aws-sector-09-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/cloudwatch-alarms.txt', 10, 1),
  ('mission-atlas-aws-sector-09-o1-c1', 'solution', 'It fires on zero traffic for 15 minutes, verification CWALARM-3390. submit CWALARM-3390', 20, 2),

  ('mission-atlas-aws-sector-10-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/sqs-sns.txt', 10, 1),
  ('mission-atlas-aws-sector-10-o1-c1', 'solution', 'The topic subscribes a Lambda endpoint, verification SNS-4471. submit SNS-4471', 20, 2),

  ('mission-atlas-aws-sector-11-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/lambda.txt', 10, 1),
  ('mission-atlas-aws-sector-11-o1-c1', 'solution', 'The function is fully declared, verification LAMBDA-8814. submit LAMBDA-8814', 20, 2),

  ('mission-atlas-aws-sector-12-o1-c1', 'orientation', 'Try: cat /repo/infra/aws/lambda.txt', 10, 1),
  ('mission-atlas-aws-sector-12-o1-c1', 'solution', 'verification LAMBDA-8814. submit LAMBDA-8814', 20, 2),
  ('mission-atlas-aws-sector-12-o2-c1', 'orientation', 'Try: cat /var/atlas-aws-live/lambda-inventory.txt', 10, 1),
  ('mission-atlas-aws-sector-12-o2-c1', 'solution', 'Zero matching functions deployed, verification LAMBDALIVE-0000. submit LAMBDALIVE-0000', 20, 2),
  ('mission-atlas-aws-sector-12-o3-c1', 'orientation', 'The ALB and Route 53 are both fine and irrelevant to this specific gap. Look for what is declared but was never applied.', 10, 1),
  ('mission-atlas-aws-sector-12-o3-c1', 'solution', 'e1 and e2: the function is fully declared in code but was never actually deployed.', 20, 2),
  ('mission-atlas-aws-sector-12-o4-c1', 'orientation', 'Combine the declared function, the missing deployment, and what has to happen next into one sentence.', 15, 1),
  ('mission-atlas-aws-sector-12-o4-c1', 'solution', 'Region One is genuinely correct end to end, but the safety net built to catch the next Act 10 was itself only ever declared, never deployed -- it has to actually be applied.', 25, 2);
