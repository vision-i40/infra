resource "kubernetes_service" "rabbitmq_management_service" {
  metadata {
    name = "rabbitmq-management-service"
    labels {
      service = "rabbitmq"
    }
  }

  spec {
    port {
      name = "management-http"
      protocol    = "TCP"
      port        = 15672
      target_port = 15672
    }

    selector {
      app = "rabbitmq"
      release = "rabbitmq"
    }

    type = "ClusterIP"
  }
}
