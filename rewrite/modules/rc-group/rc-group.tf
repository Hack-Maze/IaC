
resource "azurerm_resource_group" "test-group" {
  name     = "test-group"
  location = "East Us"
  tags = {
    environment = "test-demo"
  }
}


resource "azurerm_resource_group" "hackmaze-group" {
  name     = var.name
  location = var.location
  tags     = var.tags
}



