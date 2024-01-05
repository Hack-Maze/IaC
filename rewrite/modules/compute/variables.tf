variable "control_vm_size" {
  description = "Size of the control virtual machine"
  type        = string
  default     = "Standard_B2s"  # Update with your preferred default size
}

variable "worker_vm_size" {
  description = "Size of the control virtual machine"
  type        = string
  default     = "Standard_B2s"  # Update with your preferred default size
}

variable "jump_vm_size" {
  description = "Size of the control virtual machine"
  type        = string
  default     = "Standard_B2s"  # Update with your preferred default size
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
  default     = "hackmaze-user"  # Update with your preferred default username
}

variable "admin_ssh_public_key_path" {
  description = "Path to the public SSH key file"
  type        = string
  default     = "~/.ssh/hackmaze-azure-key.pub"  # Update with your public key file path
}

variable "control_static_private_ip" {
  description = "Static private IP address for the NIC"
  type        = string
  default     = "10.244.0.2"  # Update with your desired static IP
}
variable "worker1_static_private_ip" {
  description = "Static private IP address for the NIC"
  type        = string
  default     = "10.244.0.3"  # Update with your desired static IP
}
variable "worker2_static_private_ip" {
  description = "Static private IP address for the NIC"
  type        = string
  default     = "10.244.0.4"  # Update with your desired static IP
}

variable "worker_static_private_ips" {
  type = map(string)
  default = {
    "1" = "10.244.0.3"  # Define your private IPs here for each worker
    "2" = "10.244.0.4"  # Adjust with your actual IPs
    # Add more IPs as needed
  }
}
variable "jump_static_private_ip" {
  description = "Static private IP address for the NIC"
  type        = string
  default     = "10.244.0.1"  # Update with your desired static IP
}

variable "source_image_publisher" {
  description = "Publisher for the source image"
  type        = string
  default     = "Canonical"  # Update with your preferred source image publisher
}

variable "source_image_offer" {
  description = "Offer for the source image"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"  # Update with your preferred source image offer
}

variable "source_image_sku" {
  description = "SKU for the source image"
  type        = string
  default     = "22_04-lts-gen2"  # Update with your preferred source image SKU
}

variable "source_image_version" {
  description = "Version for the source image"
  type        = string
  default     = "latest"  # Update with your preferred source image version
}
