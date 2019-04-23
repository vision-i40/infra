variable "gcloud_project_id" {
  default = "vision-i40"
}

variable "region" {}
variable "environment" {}
variable "k8s_username" {}
variable "k8s_password" {}
variable "k8s_namespace" {}

variable "replicas" {}
variable "min_replicas" {}
variable "max_replicas" {}

variable "default_container" {}

variable "mongodb_database_name" {}
variable "mongo_connection_string" {}
variable "mongodb_is_ssl_enabled" {}
variable "secret_key" {}
variable "encryption_salt" {}

terraform {
  backend "gcs" {
    bucket  = "vision-staging-terraform-states"
    prefix  = "services-staging.tfstate"
    project = "vision-i40"
  }
}

provider "google" {
  credentials = "${file("../credentials/account.json")}"
  project     = "${var.gcloud_project_id}"
  region      = "${var.region}"
}

module "customer_registry_service" {
  source                    = "./../../../modules/customer_registry_service"
  default_container         = "${var.default_container}"
  environment               = "${var.environment}"

  k8s_master_host           = "${data.terraform_remote_state.k8s_cluster.endpoint}"
  k8s_ca_certificate        = "${data.terraform_remote_state.k8s_cluster.cluster_ca_certificate}"
  k8s_client_certificate    = "${data.terraform_remote_state.k8s_cluster.client_certificate}"
  k8s_client_key            = "${data.terraform_remote_state.k8s_cluster.client_key}"
  k8s_username              = "${var.k8s_username}"
  k8s_password              = "${var.k8s_password}"
  k8s_namespace             = "${var.k8s_namespace}"

  replicas                  = "${var.replicas}"
  min_replicas              = "${var.min_replicas}"
  max_replicas              = "${var.max_replicas}"

  mongodb_database_name     = "${var.mongodb_database_name}"
  mongo_connection_string   = "${var.mongo_connection_string}"
  mongodb_is_ssl_enabled    = "${var.mongodb_is_ssl_enabled}"
  secret_key                = "${var.secret_key}"
  encryption_salt           = "${var.encryption_salt}"
}
