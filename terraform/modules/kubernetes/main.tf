# kubernetes.tf
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.namespace_metadata_name
    labels = {
      name        = var.namespace_metadata_name
      environment = var.environment
    }
  }
}

resource "kubernetes_deployment" "statsd" {
  metadata {
    name      = var.deployment_app_name
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = var.deployment_app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.deployment_app_name
        }
      }

      spec {
        container {
          name  = var.deployment_app_name
          image = var.app_image_name

          port {
            container_port = 8125
            protocol       = "UDP"
          }

          port {
            container_port = 9102
            protocol       = "TCP"
          }

          resources {
            limits = {
              cpu    = var.cpu_resource_limit
              memory = var.memory_resource_limit
            }
            requests = {
              cpu    = var.cpu_resource_request    #"100m"
              memory = var.memory_resource_request #"128Mi"
            }
          }

          security_context {
            read_only_root_filesystem = true
            run_as_non_root           = true
            run_as_user               = 65534
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "graphite" {
  metadata {
    name      = var.graphite_name
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = var.graphite_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.graphite_name
        }
      }

      spec {
        container {
          name  = var.graphite_name
          image = "graphiteapp/graphite-statsd:latest"

          port {
            container_port = 80
            protocol       = "TCP"
          }

          port {
            container_port = 2003
            protocol       = "TCP"
          }

          resources {
            limits = {
              cpu    = var.graphite_cpu_resource_limit
              memory = var.graphite_memory_resource_limit
            }
            requests = {
              cpu    = var.graphite_cpu_resource_request
              memory = var.graphite_memory_resource_request
            }
          }

          volume_mount {
            name       = var.graphite_volume_mount_name
            mount_path = var.graphite_volume_mount_path
          }

          security_context {
            read_only_root_filesystem = false
            run_as_non_root           = true
            run_as_user               = 65534
          }
        }

        volume {
          name = var.graphite_volume_name
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.graphite_storage.metadata[0].name
          }
        }
      }
    }
  }
}

# Storage for Graphite
resource "kubernetes_persistent_volume_claim" "graphite_storage" {
  metadata {
    name      = var.graphite_volume_name
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }

  spec {
    access_modes = var.access_modes
    resources {
      requests = {
        storage = var.storage_request
      }
    }
    storage_class_name = var.storage_class_name
  }
}

# Create a Kubernetes Service for Graphite
resource "kubernetes_service" "graphite" {
  metadata {
    name      = "graphite"
    namespace = "default" # Replace with your desired namespace
  }

  spec {
    selector = {
      app = "graphite-web"
    }

    ports {
      protocol   = "TCP"
      port       = 80
      target_port = 80
    }

    type = "ClusterIP" 
  }
}


# Create a Kubernetes Service for StatsD
resource "kubernetes_service" "statsd" {
  metadata {
    name      = "node-statsd"
    namespace = "monitoring" # Replace with your desired namespace
  }

  spec {
    selector = {
      app = "statsd"
    }

    ports {
      protocol   = "udp"
      port       = 8125
      target_port = 8125
    }

    type = "ClusterIP" 
  }
}
