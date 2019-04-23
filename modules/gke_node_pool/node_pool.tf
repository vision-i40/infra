resource "google_container_node_pool" "node_pool" {
  name       = "${var.node_pool_name}"
  location   = "${var.gcloud_region}"
  cluster    = "${var.cluster_name}"
  node_count = "${var.initial_node_count}"

  node_config {
    preemptible  = "${var.preemptible}"
    machine_type = "${var.machine_type}"
    disk_size_gb = "${var.disk_size_gb}"

    oauth_scopes = [
      "compute-rw",
      "storage-ro",
      "logging-write",
      "monitoring",
    ]

    labels = {
      name     = "${var.node_pool_name}"
      nodepool = "${var.node_pool_name}"
    }
  }

  autoscaling {
    min_node_count = "${var.min_node_count}"
    max_node_count = "${var.max_node_count}"
  }
}
