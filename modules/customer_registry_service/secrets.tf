resource "kubernetes_secret" "customer_registry_service_service" {
  metadata {
    name = "customer-registry-service-secrets"
  }

  data {
    ENCRYPTION_SALT         = "${var.encryption_salt}"
    SECRET_KEY              = "${var.secret_key}"
    MONGO_CONNECTION_STRING = "${var.mongo_connection_string}"
  }
}
