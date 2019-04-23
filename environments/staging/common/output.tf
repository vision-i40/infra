output "client_certificate" {
  value = "${module.gke_cluster.client_certificate}"
}

output "client_key" {
  value = "${module.gke_cluster.client_key}"
}

output "cluster_ca_certificate" {
  value = "${module.gke_cluster.cluster_ca_certificate}"
}

output "endpoint" {
  value = "${module.gke_cluster.endpoint}"
}

output "zone_name" {
  value = "${module.vision40_com_br_zone.zone_name}"
}

output "zone_dns" {
  value = "${module.vision40_com_br_zone.zone_dns}"
}
