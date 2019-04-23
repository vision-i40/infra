data "terraform_remote_state" "k8s_cluster" {
    backend = "gcs"
    config {
        bucket  = "vision-staging-terraform-states"
        prefix  = "common-staging.tfstate"
        project = "vision-i40"
    }
}
