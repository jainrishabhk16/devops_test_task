locals {
  cluster_name = "${var.project_name}-${var.environment}-eks"
  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}