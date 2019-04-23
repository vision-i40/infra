data "terraform_remote_state" "common_state" {
    backend = "gcs"
    config {
        bucket  = "vision-staging-terraform-states"
        prefix  = "common-staging.tfstate"
        project = "vision-i40"
    }
}
