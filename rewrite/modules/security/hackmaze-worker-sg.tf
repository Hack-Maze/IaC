
resource "azurerm_network_security_group" "hackmaze-worker-sg-01" {
  name                = "hackmaze-worker-sg-01"
  location            = azurerm_resource_group.hackmaze-group.location
  resource_group_name = azurerm_resource_group.hackmaze-group.name
  tags                = azurerm_resource_group.hackmaze-group.tags
}





resource "azurerm_network_security_rule" "NodePort-worker-rule" {
  name                        = "AllowNodePort3000-32767"
  priority                    = 100 
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "3000-32767"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.hackmaze-group.name
  network_security_group_name = azurerm_network_security_group.hackmaze-worker-sg-01.name
}

resource "azurerm_network_security_rule" "kubelet-worker_rule" {
  name                        = "AllowKUBELET10250"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "10250"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.hackmaze-group.name
  network_security_group_name = azurerm_network_security_group.hackmaze-worker-sg-01.name
}


# resource "azurerm_subnet_network_security_group_association" "hackmaze-worker-sga-01" {
#   subnet_id                 = azurerm_subnet.hackmaze-subnet-01.id
#   network_security_group_id = azurerm_network_security_group.hackmaze-worker-sg-01.id
# }
