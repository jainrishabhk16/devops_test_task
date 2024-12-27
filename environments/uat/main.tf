module "vpc" {
  source = "./modules/vpc"

  vpc_name                           = "${var.project_name}-${var.environment}-vpc"
  vpc_cidr                           = var.vpc_cidr
  availability_zones                 = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets                    = [for i in range(3) : cidrsubnet(var.vpc_cidr, 4, i)]
  public_subnets                     = [for i in range(3) : cidrsubnet(var.vpc_cidr, 4, i + 3)]
  enable_nat_gateway                 = true
  single_nat_gateway                 = false
  one_nat_gateway_per_az             = true
  enable_dns_hostnames               = true
  enable_dns_support                 = true
  enable_flow_log                    = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role = true
  public_subnet_tags                 = { "kubernetes.io/role/elb" = 1 }
  private_subnet_tags                = { "kubernetes.io/role/internal-elb" = 1 }
  tags                               = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}




module "waf"{
  source = "./modules/waf"
  
  # name = var.waf_main_name
  # description = var.main_description
  # scope = var.waf_scope


}

module "load_balancer" {
  source = "./modules/load_balancer"

}

module "eks" {
  source = "./modules/eks"
}

