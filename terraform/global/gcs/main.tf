terraform {
  required_version = "0.11.8"

  backend "gcs" {
    bucket = "harbinger-212217-state"
    prefix = "global/s3"
  }
}

provider "google" {
  version = "1.18.0"

  project = "harbinger-212217"
  region  = "us-east1"
}

resource "google_storage_bucket" "state_storage" {
  name = "harbinger-212217-state"
}
