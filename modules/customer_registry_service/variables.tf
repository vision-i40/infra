variable "default_container" { default = "" }

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

variable "mongodb_database_name" {}
variable "mongo_connection_string" {}
variable "mongodb_is_ssl_enabled" {}
variable "secret_key" {}
variable "encryption_salt" {}
