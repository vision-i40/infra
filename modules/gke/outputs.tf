output "client_certificate" {
  value = "${base64decode(google_container_cluster.gke.master_auth.0.client_certificate)}"
  sensitive = true
}

output "client_key" {
  value = "${base64decode(google_container_cluster.gke.master_auth.0.client_key)}"
  sensitive = true
}

output "cluster_ca_certificate" {
  value = "${base64decode(google_container_cluster.gke.master_auth.0.cluster_ca_certificate)}"
  sensitive = true
}

output "endpoint" {
  value = "${google_container_cluster.gke.endpoint}"
}
