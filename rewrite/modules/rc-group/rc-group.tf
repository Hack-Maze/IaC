resource "azurerm_resource_group" "hackmaze-group" {
  name     = var.name
  location = var.location
  tags     = var.tags
}



