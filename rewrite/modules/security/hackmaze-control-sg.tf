
resource "azurerm_network_security_group" "hackmaze-control-sg-01" {
  name                = "hackmaze-control-sg-01"
  location            = azurerm_resource_group.hackmaze-group.location
  resource_group_name = azurerm_resource_group.hackmaze-group.name
  tags                = azurerm_resource_group.hackmaze-group.tags

}




resource "azurerm_network_security_rule" "api_server_rule" {
  name                        = "AllowAPI6443"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "6443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.hackmaze-group.name
  network_security_group_name = azurerm_network_security_group.hackmaze-control-sg-01.name
}

resource "azurerm_network_security_rule" "ETCD" {
  name                        = "AllowETCD2379-2380"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "2379-2380"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.hackmaze-group.name
  network_security_group_name = azurerm_network_security_group.hackmaze-control-sg-01.name
}

resource "azurerm_network_security_rule" "kubelet_rule" {
  name                        = "AllowKUBELET10250"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "10250"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.hackmaze-group.name
  network_security_group_name = azurerm_network_security_group.hackmaze-control-sg-01.name
}

resource "azurerm_network_security_rule" "kube-scheduler-rule" {
  name                        = "Allowkube-scheduler10259"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "10259"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.hackmaze-group.name
  network_security_group_name = azurerm_network_security_group.hackmaze-control-sg-01.name
}

resource "azurerm_network_security_rule" "kube-controller-manager-rule" {
  name                        = "Allowkube-controller-manager10257"
  priority                    = 104
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "10257"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.hackmaze-group.name
  network_security_group_name = azurerm_network_security_group.hackmaze-control-sg-01.name
}

resource "azurerm_network_security_rule" "NodePort-rule" {
  name                        = "AllowNodePort3000-32767"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "3000-32767"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.hackmaze-group.name
  network_security_group_name = azurerm_network_security_group.hackmaze-control-sg-01.name
}

resource "azurerm_network_security_rule" "ssh_rule" {
  name                        = "AllowSSH22"
  priority                    = 106
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "22"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.hackmaze-group.name
  network_security_group_name = azurerm_network_security_group.hackmaze-control-sg-01.name
}


# resource "azurerm_subnet_network_security_group_association" "hackmaze-sga-01" {
#   subnet_id                 = azurerm_subnet.hackmaze-subnet-01.id
#   network_security_group_id = azurerm_network_security_group.hackmaze-control-sg-01.id
# }





