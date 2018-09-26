variable "ssh_public_key_file" {
  description = "SSH key to be used for access to instances"
}

variable "agent_access_source_ranges" {
  type        = "list"
  description = "IP range to permit access to conductr agent API"
}

variable "conductr_machine_type" {
  description = "Machine type for conductr instances"
  default     = "custom-1-2816"
}

variable "conductr_base_image" {
  description = "Base image for conductr instances"
  default     = "ubuntu-1804-lts"
}
