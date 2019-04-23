resource "google_dns_record_set" "frontend" {
  name = "${var.subdomain}.${var.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = "${var.zone_name}"

  rrdatas = ["${kubernetes_service.customer_registry_service_service.load_balancer_ingress.0.ip}"]
}
