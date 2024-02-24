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


#discord urls

variable "mostafawtoken" {
 description = "The URL stored as a secret in Terraform Cloud"
 type        = string
 default    = ""
} 


variable "mostafawid" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
  default    = ""
}


variable "mrymwtoken" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
  default    = ""
} 


variable "mrymwid" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
  default    = ""
}

variable "yusufwtoken" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
  default    = ""
} 


variable "yusufwid" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
  default    = ""
}

variable "moaliwtoken" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
  default    = ""
} 


variable "moaliwid" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
  default    = ""
}


variable "jubawtoken" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
  default    = ""
} 


variable "jubawid" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
  default    = ""
}


variable "nourwtoken" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
  default    = ""
} 


variable "nourwid" {
  description = "The URL stored as a secret in Terraform Cloud"
  type        = string
  default    = ""
}






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