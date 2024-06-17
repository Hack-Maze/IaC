variable "name" {
  description = "The name of the Azure resource group"
  type        = string
  default     = "HM-rc"
}

variable "location" {
  description = "The location of the Azure resource group"
  type        = string
  default     = "Italy North"
}

variable "tags" {
  description = "Additional tags for the resource group"
  type        = map(string)
  default     = {
    environment = "testing"
    owner       = "1337"
    project     = "HM"
    }
}
