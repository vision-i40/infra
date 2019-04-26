variable "helm_version" { default = "v2.9.1" }

provider "kubernetes" {
  host                   = "${var.k8s_master_host}"
  cluster_ca_certificate = "${var.k8s_ca_certificate}"
  client_certificate     = "${var.k8s_client_certificate}"
  client_key             = "${var.k8s_client_key}"
  username               = "${var.k8s_username}"
  password               = "${var.k8s_password}"
}


provider "helm" {
  tiller_image = "gcr.io/kubernetes-helm/tiller:${var.helm_version}"

  kubernetes {
    host                   = "${var.k8s_master_host}"
    username               = "${var.k8s_username}"
    password               = "${var.k8s_password}"

    client_certificate     = "${var.k8s_client_certificate}"
    client_key             = "${var.k8s_client_key}"
    cluster_ca_certificate = "${var.k8s_ca_certificate}"
  }
}
