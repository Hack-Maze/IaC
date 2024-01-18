
resource "azurerm_network_security_group" "worker-sg-01" {
  name                = "worker-sg-01"
  location            = var.rc-location
  resource_group_name = var.rc-name
  tags                = var.rc-tags
}




resource "azurerm_network_security_rule" "NodePort_worker_rule" {
  name                        = "AllowNodePort3000-32767"
  priority                    = 100 
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "30000-32767"
  source_port_range           = "*"
  source_address_prefix       = var.hackmaze_vnet_address_range[0]
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
  source_address_prefix       = var.hackmaze_vnet_address_range[0]
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.worker-sg-01.name
}

resource "azurerm_network_security_rule" "ssh_worker_rule" {
  name                        = "AllowSSH22"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "22"
  source_port_range           = "*"
  source_address_prefix       = var.jump_static_private_ip
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.worker-sg-01.name
}




resource "azurerm_network_security_rule" "fannel8285_rule" {
  name                        = "Allowfannel8285"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Udp"
  destination_port_range      = "8285"
  source_port_range           = "*"
  source_address_prefix       = var.hackmaze_vnet_address_range[0]
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.worker-sg-01.name
}


resource "azurerm_network_security_rule" "fannel8472_rule" {
  name                        = "Allowfannel8472"
  priority                    = 104
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Udp"
  destination_port_range      = "8472"
  source_port_range           = "*"
  source_address_prefix       = var.hackmaze_vnet_address_range[0]
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.worker-sg-01.name
}




resource "azurerm_network_interface_security_group_association" "hackmaze-worker1-sga-01" {
  network_interface_id      = var.worker1_nic_id
  network_security_group_id = azurerm_network_security_group.worker-sg-01.id
}

resource "azurerm_network_interface_security_group_association" "hackmaze-worker2-sga-01" {
  network_interface_id      = var.worker2_nic_id
  network_security_group_id = azurerm_network_security_group.worker-sg-01.id
}