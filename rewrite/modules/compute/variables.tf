variable "control_vm_size" {
  description = "Size of the control virtual machine"
  type        = string
  default     = "Standard_B1s"  # Update with your preferred default size
}

variable "worker_vm_size" {
  description = "Size of the control virtual machine"
  type        = string
  default     = "Standard_B1s"  # Update with your preferred default size
}

variable "jump_vm_size" {
  description = "Size of the control virtual machine"
  type        = string
  default     = "Standard_B1s"  # Update with your preferred default size
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
  default     = "10.0.244.11"  # Update with your desired static IP
}
variable "worker1_static_private_ip" {
  description = "Static private IP address for the NIC"
  type        = string
  default     = "10.0.244.12"  # Update with your desired static IP
}
variable "worker2_static_private_ip" {
  description = "Static private IP address for the NIC"
  type        = string
  default     = "10.0.244.13"  # Update with your desired static IP
}

variable "jump_static_private_ip" {
  description = "Static private IP address for the NIC"
  type        = string
  default     = "10.0.244.10"  # Update with your desired static IP
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




       # input vars

#rc vars

variable "rc-name" {
 description = "Description of the variable"
 type       = string
 default    = ""
}

variable "rc-location" {
 description = "Description of the variable"
 type       = string
 default    = ""
}

variable "rc-tags" {
 description = "Description of the variable"
 type       = map(string)
 default    = {}
}



#network vars

variable "subnet_id" {
 description = "ID of the subnet"
 type       = string
 default    = ""
}

variable "jump_public_ip_id" {
 description = "Description of the variable"
 type       = string
 default    = ""
}

variable "jump_public_ip" {
 description = "Description of the variable"
 type       = string
 default    = ""
}

variable "jump_sg_id" {
 description = "Description of the variable"
 type       = string
 default    = ""
}


variable "control_sg_id" {
 description = "Description of the variable"
 type       = string
 default    = ""
}

variable "worker_sg_id" {
 description = "Description of the variable"
 type       = string
 default    = ""
}
