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