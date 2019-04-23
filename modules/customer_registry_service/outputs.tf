output "service_address" {
  value = "${kubernetes_service.customer_registry_service_service.spec.0.cluster_ip}"
}
