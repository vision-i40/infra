resource "kubernetes_horizontal_pod_autoscaler" "web_app" {
  metadata {
    name = "web-app"
  }

  spec {
    min_replicas = "${var.min_replicas}"
    max_replicas = "${var.max_replicas}"
    scale_target_ref {
      kind = "Deployment"
      name = "web-app"
    }
  }
}
