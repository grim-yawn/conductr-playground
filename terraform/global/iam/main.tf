terraform {
  required_version = "0.11.8"

  backend "gcs" {
    bucket = "harbinger-212217-state"
    prefix = "global/iam"
  }
}

provider "google" {
  version = "1.18.0"

  project = "harbinger-212217"
  region  = "us-east1"
}

resource "google_service_account" "ansible" {
  account_id   = "ansible-dynamic-inventory"
  display_name = "Service account for ansible dynamic inventory"
}

resource "google_service_account_key" "ansible" {
  service_account_id = "${google_service_account.ansible.name}"
}

resource "google_project_iam_binding" "ansible" {
  role = "roles/compute.viewer"

  members = [
    "serviceAccount:${google_service_account.ansible.email}",
  ]
}
