variable "credentials_file" {}
variable "gcloud_project_id" {}
variable "gcloud_region" {}

variable "default_container" {}

variable "environment" {}
variable "k8s_master_host" {}
variable "k8s_ca_certificate" {}
variable "k8s_client_certificate" {}
variable "k8s_client_key" {}
variable "k8s_username" {}
variable "k8s_password" {}
variable "k8s_namespace" { default = "default" }

variable "replicas" {}
variable "min_replicas" {}
variable "max_replicas" {}

variable "subdomain" {}
variable "dns_name" {}
variable "zone_name" {}

variable "http_container_port" { default = 3000}
variable "https_container_port" { default = 443}
