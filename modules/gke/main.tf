provider "google" {
  credentials = "${file("${var.credentials_file}")}"
  project     = "${var.gcloud_project_id}"
  region      = "${var.gcloud_region}"
}
