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

variable "hackmaze_vnet_address_range" {
 description = "Description of the variable"
 type       = list(string)
 default    = []
}


variable "subnet_id" {
 description = "Description of the variable"
 type       = string
 default    = ""
}

variable "control_nic_id" {
 description = "Description of the variable"
 type       = string
 default    = ""
}

variable "jump_nic_id" {
 description = "Description of the variable"
 type       = string
 default    = ""
}
variable "worker1_nic_id" {
 description = "Description of the variable"
 type       = string
 default    = ""
}
variable "worker2_nic_id" {
 description = "Description of the variable"
 type       = string
 default    = ""
}
