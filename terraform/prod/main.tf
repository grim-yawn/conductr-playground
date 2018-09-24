terraform {
  backend "gcs" {
    bucket = "harbinger-212217-state"
    prefix = "prod"
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
  tags = ["conductr", "prod"]

  machine_type = "g1-small"

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.ssh_public_key_file)}"
  }
}

resource "google_compute_firewall" "conductr_core" {
  name    = "allow-conductr-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9004", "9006", "10000-10999"]
  }

  target_tags = ["conductr"]

  source_tags = ["conductr"]
}

resource "google_compute_firewall" "conductr_agent_access" {
  name    = "allow-conductr-agent-access-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9005"]
  }

  target_tags = ["conductr"]

  source_ranges = ["${var.agent_access_source_ranges}"]
}
