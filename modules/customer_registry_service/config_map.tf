resource "kubernetes_config_map" "customer_registry_service" {
  metadata {
    name = "customer-registry-service-config"
  }

  data {
    MONGO_DATABASE_NAME = "${var.mongodb_database_name}"
    MONGO_SSL_ENABLED   = "${var.mongodb_is_ssl_enabled}"
  }
}
