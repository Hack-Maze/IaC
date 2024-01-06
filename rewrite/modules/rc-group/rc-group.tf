resource "azurerm_resource_group" "hackmaze-rc" {
  name     = var.name
  location = var.location
  tags     = var.tags
}



