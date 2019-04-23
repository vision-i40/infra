variable "gcloud_project_id" {
  default = "vision-i40"
}

variable "environment" {}

variable "credentials_file" {
  default = "../../../credentials/account.json"
}

variable "region" {}
variable "cluster_name" {}
variable "k8s_namespace" {}
variable "k8s_username" {}
variable "k8s_password" {}

variable "np_services_machine_type" {}
variable "np_services_disk_size_gb" {}
variable "np_services_preemptible" {}
variable "np_services_initial_node_count" {}
variable "np_services_min_node_count" {}
variable "np_services_max_node_count" {}

terraform {
  backend "gcs" {
    bucket  = "vision-staging-terraform-states"
    prefix  = "common-staging.tfstate"
    project = "vision-i40"
  }
}

provider "google" {
  credentials = "${file("../credentials/account.json")}"
  project     = "${var.gcloud_project_id}"
  region      = "${var.region}"
}

provider "kubernetes" {
  host                   = "${module.gke_cluster.endpoint}"
  cluster_ca_certificate = "${module.gke_cluster.cluster_ca_certificate}"
  client_certificate     = "${module.gke_cluster.client_certificate}"
  client_key             = "${module.gke_cluster.client_key}"
  username               = "${var.k8s_username}"
  password               = "${var.k8s_password}"
}

module "gke_cluster" {
  source            = "./../../../modules/gke"
  gke_cluster_name  = "${var.cluster_name}"
  gcloud_project_id = "${var.gcloud_project_id}"
  gcloud_region     = "${var.region}"
  credentials_file  = "${var.credentials_file}"
  k8s_username      = "${var.k8s_username}"
  k8s_password      = "${var.k8s_password}"
}

module "gke_services_node_pools" {
  source             = "./../../../modules/gke_node_pool"
  node_pool_name     = "services"
  gcloud_region      = "${var.region}"
  gcloud_project_id  = "${var.gcloud_project_id}"
  credentials_file   = "${var.credentials_file}"
  cluster_name       = "${var.cluster_name}"
  preemptible        = "${var.np_services_preemptible}"
  initial_node_count = "${var.np_services_initial_node_count}"
  disk_size_gb       = "${var.np_services_disk_size_gb}"
  machine_type       = "${var.np_services_machine_type}"
  min_node_count     = "${var.np_services_min_node_count}"
  max_node_count     = "${var.np_services_max_node_count}"
}
