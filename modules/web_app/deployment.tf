resource "kubernetes_service" "web_app_service" {
  metadata {
    name = "web-app-${var.environment}"
    labels {
      service = "web-app"
    }
  }

  spec {
    port {
      name = "api-https"
      protocol    = "TCP"
      port        = 443
      target_port = "${var.https_container_port}"
    }

    port {
      name = "api-http"
      protocol    = "TCP"
      port        = 80
      target_port = "${var.http_container_port}"
    }

    selector {
      environment = "${var.environment}"
      service = "web-app"
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "web_app" {
  metadata {
    name = "web-app-${var.environment}"
    labels {
      service = "web-app"
      environment = "${var.environment}"
    }
  }

  spec {
    replicas = "${var.replicas}"

    selector {
      match_labels {
        service = "web-app"
        environment = "${var.environment}"
      }
    }

    template {
      metadata {
        labels {
          service = "web-app"
          environment = "${var.environment}"
        }
      }

      spec {
        container {
          image = "${var.default_container}"
          name  = "web-app"

          port {
            name = "api-https"
            container_port = "${var.https_container_port}"
          }

          port {
            name = "api-http"
            container_port = "${var.http_container_port}"
          }

          liveness_probe {
            http_get {
              scheme = "HTTP"
              path = "/login"
              port = "${var.http_container_port}"
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
              path = "/login"
              port = "${var.http_container_port}"
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
