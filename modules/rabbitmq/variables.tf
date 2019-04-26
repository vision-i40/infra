variable "k8s_master_host" {}
variable "k8s_ca_certificate" {}
variable "k8s_client_certificate" {}
variable "k8s_client_key" {}
variable "k8s_username" {}
variable "k8s_password" {}
variable "k8s_namespace" {}

variable "rabbitmq_username" {}
variable "rabbitmq_password" {}
variable "erlang_cookie" {}
variable "replicas_count" { default = 3 }
variable "pvc_storage_class" {}
variable "rabbitmq_disk_size" {}
