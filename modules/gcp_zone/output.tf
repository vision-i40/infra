output "zone_name" {
  value = "${google_dns_managed_zone.zone.name}"
}

output "zone_dns" {
  value = "${google_dns_managed_zone.zone.dns_name}"
}
