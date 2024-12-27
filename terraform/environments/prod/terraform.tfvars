project_name = "devops-test-task"
aws_region   = "us-east-1"
environment  = "dev"
vpc_cidr     = "10.1.0.0/16"


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



namespace_metadata_name = "monitoring"
deployment_app_name = "node-statsd"
app_image_name = "test_task:latest"

cpu_resource_limit = "200m"
memory_resource_limit = "256Mi"

cpu_resource_request = "100m"
memory_resource_request = "128Mi"
graphite_name = "graphite"
graphite_image_name = "graphiteapp/graphite-statsd:latest"

graphite_cpu_resource_limit = "1000m"
graphite_memory_resource_limit = "1Gi"
graphite_cpu_resource_request = "500m"
graphite_memory_resource_request = "512Mi"
graphite_volume_mount_name = "graphite-storage"
graphite_volume_mount_path = "/opt/graphite/storage"
graphite_volume_name = "graphite-storage"
access_modes = ["ReadWriteOnce"]

storage_request = "20Gi"
storage_class_name = "gp2"
