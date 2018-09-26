output "ansible_service_account" {
  value = {
    account     = "${google_service_account.ansible.name}"
    private_key = "${google_service_account_key.ansible.private_key}"
  }
}
