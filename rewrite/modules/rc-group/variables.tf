variable "name" {
  description = "The name of the Azure resource group"
  type        = string
  default     = "hackmaze-group"
}

variable "location" {
  description = "The location of the Azure resource group"
  type        = string
  default     = "East US"
}

variable "tags" {
  description = "Additional tags for the resource group"
  type        = map(string)
  default     = {
    environment = "testing"
    owner       = "1337"
    project     = "Hackmaze"
    }
}