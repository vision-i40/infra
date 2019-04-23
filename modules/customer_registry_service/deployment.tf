resource "kubernetes_service" "customer_registry_service_service" {
  metadata {
    name = "customer-registry-service-service-${var.environment}"
    labels {
      service = "customer-registry-service"
    }
  }

  spec {
    port {
      name = "api-https"
      protocol    = "TCP"
      port        = 443
      target_port = 443
    }

    port {
      name = "api-http"
      protocol    = "TCP"
      port        = 80
      target_port = 8888
    }

    selector {
      environment = "${var.environment}"
      service = "customer-registry-service"
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "customer_registry_service" {
  metadata {
    name = "customer-registry-service-${var.environment}"
    labels {
      service = "customer-registry-service"
      environment = "${var.environment}"
    }
  }

  spec {
    replicas = "${var.replicas}"

    selector {
      match_labels {
        service = "customer-registry-service"
        environment = "${var.environment}"
      }
    }

    template {
      metadata {
        labels {
          service = "customer-registry-service"
          environment = "${var.environment}"
        }
      }

      spec {
        container {
          image = "${var.default_container}"
          name  = "customer-registry-service"

          port {
            name = "api-https"
            container_port = 443
          }

          port {
            name = "api-http"
            container_port = 8888
          }

          env_from {
            config_map_ref {
              name = "customer-registry-service-config"
            }
          }

          env_from {
            secret_ref {
              name = "customer-registry-service-secrets"
            }
          }

          liveness_probe {
            http_get {
              scheme = "HTTP"
              path = "/health"
              port = 8888
            }
            timeout_seconds = 5
            success_threshold = 1
            failure_threshold = 5
            period_seconds = 30
            initial_delay_seconds = 45
          }

          readiness_probe {
            http_get {
              scheme = "HTTP"
              path = "/health"
              port = 8888
            }
            timeout_seconds = 5
            success_threshold = 1
            failure_threshold = 5
            period_seconds = 30
            initial_delay_seconds = 30
          }

          resources{
            limits{
              cpu    = "100m"
              memory = "1024Mi"
            }

            requests{
              cpu    = "25m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}
