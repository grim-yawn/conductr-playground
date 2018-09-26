output "seed_external_ip" {
  value = "${google_compute_instance.conductr.0.network_interface.0.access_config.0.assigned_nat_ip}"
}
