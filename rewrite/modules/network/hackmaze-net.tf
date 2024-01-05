
resource "azurerm_virtual_network" "hackmaze-virtual-net" {
  name                = "hackmaze-vertual-net"
  location            = module.rc-group.location
  resource_group_name = module.rc-group.name
  address_space       = var.hackmaze_vnet_address_range   # Use the variable here

  tags = module.rc-group.tags
}

resource "azurerm_subnet" "hackmaze-subnet-01" {
  name                 = "hackmaze-subnet-01"
  resource_group_name  = module.rc-group.name
  virtual_network_name = azurerm_virtual_network.hackmaze-virtual-net.name
  address_prefixes     = var.hackmaze_subnet_01_address_rang   # Use the variable here
}