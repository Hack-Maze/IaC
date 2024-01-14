
resource "azurerm_virtual_network" "hackmaze-virtual-net" {
  name                = "hackmaze-vertual-net"
  location            = var.rc-location
  resource_group_name = var.rc-name
  address_space       = var.hackmaze_vnet_address_range   # Use the variable here

  tags = var.rc-tags
}

resource "azurerm_subnet" "hackmaze-subnet-01" {
  name                 = "hackmaze-subnet-01"
  resource_group_name  = var.rc-name
  virtual_network_name = azurerm_virtual_network.hackmaze-virtual-net.name
  address_prefixes     = var.hackmaze_subnet_01_address_rang   # Use the variable here
}


