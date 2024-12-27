locals {
  cluster_name = "${var.project_name}-${var.environment}-eks"
  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# eks.tf
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = local.cluster_name
  cluster_version = "1.28"

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    monitoring = {
      min_size     = var.min_size     #2
      max_size     = var.max_size     #4
      desired_size = var.desired_size #2

      instance_types = var.instance_types # ["t3.large"]
      capacity_type  = var.capacity_type  # "ON_DEMAND"

      block_device_mappings = {
        xvda = {
          device_name = var.device_name #"/dev/xvda"
          ebs = {
            volume_size           = var.volume_size #50
            volume_type           = var.volume_type #"gp3"
            encrypted             = var.encrypted
            delete_on_termination = var.delete_on_termination
          }
        }
      }
    }
  }

  # Enable IRSA
  enable_irsa = true

  # Fargate Profile
  fargate_profiles = {
    monitoring = {
      name = var.fargate_profiles_name
      selectors = [
        {
          namespace = var.fargate_profiles_namespace
        }
      ]
      subnet_ids = var.private_subnets
    }
  }

  tags = local.tags
}
