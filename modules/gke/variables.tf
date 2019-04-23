variable "credentials_file" {}
variable "gcloud_project_id" {}
variable "gcloud_region" {}
variable "gke_cluster_name" {}

variable "gke_cluster_initial_node_count" {
  default = 1
}

variable "k8s_password" {}
variable "k8s_username" {}
