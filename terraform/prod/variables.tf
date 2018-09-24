variable "ssh_public_key_file" {
  description = "SSH key to be used for access to instances"
}

variable "agent_access_source_ranges" {
  description = "IP range to permit access to conductr agent API"
}
