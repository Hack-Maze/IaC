variable "hackmaze_vnet_address_range" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

variable "hackmaze_subnet_01_address_rang" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}


variable "dns_name" {                                   # ask
  description = "dns name of the jump virtual machine"
  type        = string
  default     = "hm-jump-server"  # Update with your preferred default size
}





# input vars 



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