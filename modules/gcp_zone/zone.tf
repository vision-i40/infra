resource "google_dns_managed_zone" "zone" {
  name = "${var.zone_name}"
  dns_name = "${var.dns_name}"

  labels = {
    zone = "${replace(var.zone_name, "-", "")}"
  }
}
