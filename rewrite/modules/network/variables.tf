variable "hackmaze_vnet_address_range" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "hackmaze_subnet_01_address_rang" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.244.0.0/24"]
}
