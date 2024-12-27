project_name = "devops_test_task"
aws_region   = "us-east-1"
environment  = "dev"
vpc_cidr     = ["10.1.0.0/0"]


waf_scope                          = "REGIONAL"
rule_name                          = "AWSManagedRulesCommonRuleSet"
managed_rule_group_statement_name  = "AWSManagedRulesCommonRuleSet"
vendor_name                        = "AWS"
rule_cloudwatch_metrics_enabled    = true
rule_sampled_requests_enabled      = true
rule_visibility_config_metric_name = "AWSManagedRulesCommonRuleSetMetric"
waf_cloudwatch_metrics_enabled     = true
waf_visibility_metric_name         = "WAFMainMetrics"
waf_sampled_requests_enabled       = true


load_balancer_type     = "application"
http_target_group_name = "http-target-group"
target_group_port      = 80
target_group_protocol  = "HTTP"
alb_listener_port      = 80
alb_listener_protocol  = "HTTP"

ingress_cidr_block = ["0.0.0.0/0"]
ingress_from_port  = 80
ingress_to_port    = 80
inrgess_protocol   = "tcp"

capacity_type         = "ON_DEMAND"
instance_types        = ["t3.large"]
min_size              = 2
max_size              = 4
desired_size          = 2
delete_on_termination = true
volume_size           = 50
volume_type           = "gp3"
encrypted             = true

fargate_profiles_name      = "monitoring"
fargate_profiles_namespace = "monitoring"

private_subnets = ["0.0.0.0/0"]
public_subnets  = ["0.0.0.0/0"]

