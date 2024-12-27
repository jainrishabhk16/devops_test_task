module "vpc" {
  source                               = "../../modules/vpc"
  aws_region                           = var.aws_region
  project_name                         = var.project_name
  vpc_name                             = "${var.project_name}-${var.environment}-vpc"
  vpc_cidr                             = var.vpc_cidr
  availability_zones                   = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets                      = [for i in range(3) : cidrsubnet(var.vpc_cidr, 4, i)]
  public_subnets                       = [for i in range(3) : cidrsubnet(var.vpc_cidr, 4, i + 3)]
  enable_nat_gateway                   = true
  single_nat_gateway                   = false
  one_nat_gateway_per_az               = true
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  public_subnet_tags                   = { "kubernetes.io/role/elb" = 1 }
  private_subnet_tags                  = { "kubernetes.io/role/internal-elb" = 1 }
  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}




module "waf" {
  source                             = "../../modules/waf"
  project_name                       = var.project_name
  scope                              = var.waf_scope
  rule_name                          = var.rule_name
  managed_rule_group_statement_name  = var.managed_rule_group_statement_name
  vendor_name                        = var.vendor_name
  rule_cloudwatch_metrics_enabled    = var.rule_cloudwatch_metrics_enabled
  rule_visibility_config_metric_name = var.rule_visibility_config_metric_name
  rule_sampled_requests_enabled      = var.rule_sampled_requests_enabled
  waf_cloudwatch_metrics_enabled     = var.waf_cloudwatch_metrics_enabled
  waf_visibility_metric_name         = var.waf_visibility_metric_name
  waf_sampled_requests_enabled       = var.waf_sampled_requests_enabled
}

module "load_balancer" {
  source             = "../../modules/load_balancer"
  project_name       = var.project_name
  load_balancer_type = var.load_balancer_type

  #   security_groups = var.alb_security_group_id # NEED TO GET THIS FROM OUTPUT VARIABLES

  http_target_group_name = var.http_target_group_name
  target_group_port      = var.target_group_port
  target_group_protocol  = var.target_group_protocol

  #   vpc_id = var.vpc_id # NEED TO GET THIS FROM OUTPUT VARIABLES

  #   target_type = var.target_group_type

  alb_listener_port     = var.alb_listener_port
  alb_listener_protocol = var.alb_listener_protocol

  public_subnets = module.vpc.public_subnets
  vpc_id         = module.vpc.vpc_id
  lb_id          = module.security_groups.alb_security_group_id

}

module "eks" {
  source         = "../../modules/eks"
  project_name   = var.project_name
  aws_region     = var.aws_region
  capacity_type  = var.capacity_type
  instance_types = var.instance_types
  min_size       = var.min_size
  max_size       = var.max_size
  desired_size   = var.desired_size

  volume_size                = var.volume_size
  volume_type                = var.volume_type
  encrypted                  = var.encrypted
  delete_on_termination      = var.delete_on_termination
  fargate_profiles_name      = var.fargate_profiles_name
  fargate_profiles_namespace = var.fargate_profiles_namespace
  vpc_id                     = module.vpc.vpc_id
  private_subnets            = module.vpc.private_subnets

}

module "security_groups" {
  source             = "../../modules/security_groups"
  ingress_cidr_block = var.ingress_cidr_block
  ingress_from_port  = var.ingress_from_port
  ingress_to_port    = var.ingress_to_port
  inrgess_protocol   = var.inrgess_protocol
  vpc_id             = module.vpc.vpc_id

}

module "kubernetes" {
  source                  = "../../modules/kubernetes"
  namespace_metadata_name = var.namespace_metadata_name
  environment             = var.environment
  deployment_app_name     = var.deployment_app_name
  app_image_name          = var.app_image_name
  cpu_resource_limit      = var.cpu_resource_limit
  memory_resource_limit   = var.memory_resource_limit
  cpu_resource_request    = var.cpu_resource_request
  memory_resource_request = var.memory_resource_request

  graphite_name                    = var.graphite_name
  graphite_cpu_resource_limit      = var.graphite_cpu_resource_limit
  graphite_memory_resource_limit   = var.graphite_memory_resource_limit
  graphite_cpu_resource_request    = var.graphite_cpu_resource_request
  graphite_memory_resource_request = var.graphite_memory_resource_request

  graphite_volume_mount_name = var.graphite_volume_mount_name
  graphite_volume_mount_path = var.graphite_volume_mount_path

  graphite_volume_name = var.graphite_volume_name
  access_modes         = var.access_modes
  storage_request      = var.storage_request
  storage_class_name   = var.storage_class_name

}
