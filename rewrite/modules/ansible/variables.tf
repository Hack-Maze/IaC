variable "jump_public_ip" {
 description = "Description of the variable"
 type       = string
 default    = ""
}

variable "control_static_private_ip" {
 description = "Description of the variable"
 type       = string
 default    = ""
}

variable "worker1_static_private_ip" {
 description = "Description of the variable"
 type       = string
 default    = ""
}

variable "worker2_static_private_ip" {
 description = "Description of the variable"
 type       = string
 default    = ""
}


variable "admin_username" {
 description = "Description of the variable"
 type       = string
 default    = ""
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


variable "jump_private_key_content" {
 description = "Description of the variable"
 type       = string
 default    = ""
}