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


#discord urls

variable "mostafawtoken" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
} 


variable "mostafawid" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
}


variable "mrymwtoken" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
} 


variable "mrymwid" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
}

variable "yusufwtoken" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
} 


variable "yusufwid" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
}

variable "moaliwtoken" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
} 


variable "moaliwid" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
}


variable "jubawtoken" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
} 


variable "jubawid" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
}


variable "nourwtoken" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
} 


variable "nourwid" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
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