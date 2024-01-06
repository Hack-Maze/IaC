
resource "azurerm_network_security_group" "worker-sg-01" {
  name                = "worker-sg-01"
  location            = var.rc-location
  resource_group_name = var.rc-name
  tags                = var.rc-tags
}




resource "azurerm_network_security_rule" "NodePort_worker-rule" {
  name                        = "AllowNodePort3000-32767"
  priority                    = 100 
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "3000-32767"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.worker-sg-01.name
}

resource "azurerm_network_security_rule" "kubelet_worker_rule" {
  name                        = "AllowKUBELET10250"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "10250"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.worker-sg-01.name
}


# resource "azurerm_subnet_network_security_group_association" "hackmaze-worker-sga-01" {
#   subnet_id                 = azurerm_subnet.hackmaze-subnet-01.id
#   network_security_group_id = azurerm_network_security_group.worker-sg-01.id
# }
