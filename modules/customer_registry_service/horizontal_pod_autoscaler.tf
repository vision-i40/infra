resource "kubernetes_horizontal_pod_autoscaler" "customer_registry_service_service" {
  metadata {
    name = "customer-registry-service"
  }

  spec {
    min_replicas = "${var.min_replicas}"
    max_replicas = "${var.max_replicas}"
    scale_target_ref {
      kind = "Deployment"
      name = "customer-registry-service"
    }
  }
}
