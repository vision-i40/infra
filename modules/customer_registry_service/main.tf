provider "kubernetes" {
  host                   = "${var.k8s_master_host}"
  cluster_ca_certificate = "${var.k8s_ca_certificate}"
  client_certificate     = "${var.k8s_client_certificate}"
  client_key             = "${var.k8s_client_key}"
  username               = "${var.k8s_username}"
  password               = "${var.k8s_password}"
}
