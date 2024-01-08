
resource "azurerm_network_security_group" "control-sg-01" {
  name                = "control-sg-01"
  location            = var.rc-location
  resource_group_name = var.rc-name
  tags                = var.rc-tags
}




resource "azurerm_network_security_rule" "api_server_rule" {
  name                        = "AllowAPI6443"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "6443"
  source_address_prefix       = var.hackmaze_vnet_address_range[0]
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.control-sg-01.name
}

resource "azurerm_network_security_rule" "ETCD" {
  name                        = "AllowETCD2379-2380"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "2379-2380"
  source_address_prefix       = var.hackmaze_vnet_address_range[0]
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.control-sg-01.name
}

resource "azurerm_network_security_rule" "kubelet_control_rule" {
  name                        = "AllowKUBELET10250"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "10250"
  source_port_range           = "*"
  source_address_prefix       = var.hackmaze_vnet_address_range[0]
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.control-sg-01.name
}

resource "azurerm_network_security_rule" "kube_scheduler-rule" {
  name                        = "Allowkube_scheduler10259"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "10259"
  source_port_range           = "*"
  source_address_prefix       = var.hackmaze_vnet_address_range[0]
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.control-sg-01.name
}

resource "azurerm_network_security_rule" "kube_controller_manager_rule" {
  name                        = "Allowkube_controller_manager10257"
  priority                    = 104
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "10257"
  source_port_range           = "*"
  source_address_prefix       = var.hackmaze_vnet_address_range[0]
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.control-sg-01.name
}

resource "azurerm_network_security_rule" "NodePort_control_rule" {
  name                        = "AllowNodePort3000-32767"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "3000-32767"
  source_port_range           = "*"
  source_address_prefix       = var.hackmaze_vnet_address_range[0]
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.control-sg-01.name
}

resource "azurerm_network_security_rule" "ssh_control_rule" {
  name                        = "AllowSSH22"
  priority                    = 106
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "22"
  source_port_range           = "*"
  source_address_prefix       = var.jump_static_private_ip
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.control-sg-01.name
}

resource "azurerm_network_security_rule" "Allow_Api_8080" {
  name                        = "AllowSSH8080"
  priority                    = 106
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "8080"
  source_port_range           = "*"
  source_address_prefix       = var.hackmaze_vnet_address_range[0]
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.control-sg-01.name
}

resource "azurerm_network_interface_security_group_association" "hackmaze-control-sga-01" {
  network_interface_id      = var.control_nic_id
  network_security_group_id = azurerm_network_security_group.control-sg-01.id
}






