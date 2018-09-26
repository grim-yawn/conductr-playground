terraform {
  required_version = "0.11.8"

  backend "gcs" {
    bucket = "harbinger-212217-state"
    prefix = "stage"
  }
}

provider "google" {
  version = "1.18.0"

  project = "harbinger-212217"
  region  = "us-east1"
  zone    = "us-east1-b"
}

resource "google_compute_instance" "conductr" {
  count = 3

  name = "conductr-node-${count.index}"

  labels = {
    environment = "stage"
    conductr    = "${count.index == 0 ? "seed": "node"}"
  }

  tags = ["stage", "conductr"]

  machine_type = "${var.conductr_machine_type}"

  boot_disk {
    initialize_params {
      image = "${var.conductr_base_image}"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.ssh_public_key_file)}"
  }

  allow_stopping_for_update = true
}

resource "google_compute_firewall" "conductr_core" {
  name    = "allow-conductr-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9004", "9005", "9006", "10000-10999"]
  }

  target_tags = ["conductr"]

  source_tags = ["conductr"]
}

resource "google_compute_firewall" "conductr_executions_access" {
  name    = "allow-conductr-executions-access-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["10000-10999"]
  }

  target_tags = ["conductr"]

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-access-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["${var.agent_access_source_ranges}"]
}
