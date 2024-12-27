# outputs.tf
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "min_size" {
  value = var.min_size
}

output "max_size" {
  value = var.max_size
}

output "desired_size" {
  value = var.desired_size

}
