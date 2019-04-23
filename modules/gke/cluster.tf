resource "google_container_cluster" "gke" {
  name               = "${var.gke_cluster_name}"
  location           = "${var.gcloud_region}"
  initial_node_count = "${var.gke_cluster_initial_node_count}"

  remove_default_node_pool = true

  enable_legacy_abac = true

  master_auth {
    username = "${var.k8s_username}"
    password = "${var.k8s_password}"
  }

  addons_config {
    http_load_balancing {
      disabled = true
    }

    horizontal_pod_autoscaling {
      disabled = true
    }
  }
}
