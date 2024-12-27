variable "environment" {
  default = "dev"
}

variable "namespace_metadata_name" {
  default = "monitoring"
}

variable "deployment_app_name" {
  default = "node-statsd"
}
variable "app_image_name" {
  default = "test_task:latest" # we can pass the ECR URL
}

variable "cpu_resource_limit" {
  default = "200m"
}

variable "memory_resource_limit" {
  default = "256Mi"
}

variable "cpu_resource_request" {
  default = "100m"
}

variable "memory_resource_request" {
  default = "128Mi"
}

# graphite
variable "graphite_name" {
  default = "graphite"

}

variable "graphite_image_name" {
  default = "graphiteapp/graphite-statsd:latest"
}

variable "graphite_cpu_resource_limit" {
  default = "1000m"
}

variable "graphite_memory_resource_limit" {
  default = "1Gi"
}

variable "graphite_cpu_resource_request" {
  default = "500m"
}

variable "graphite_memory_resource_request" {
  default = "512Mi"
}

variable "graphite_volume_mount_name" {
  default = "graphite-storage"
}

variable "graphite_volume_mount_path" {
  default = "/opt/graphite/storage"
}

# storage
variable "graphite_volume_name" {
  default = "graphite-storage"
}
variable "access_modes" {
  type    = list(string)
  default = ["ReadWriteOnce"]
}

variable "storage_request" {
  default = "20Gi"
}

variable "storage_class_name" {
  default = "gp2"
  type    = string
}
