
resource "azurerm_network_security_group" "jump-sg-01" {
  name                = "jump-sg-01"
  location            = var.rc-location
  resource_group_name = var.rc-name
  tags                = var.rc-tags
}


resource "azurerm_network_security_rule" "ssh_jump_rule" {
  name                        = "AllowSSH22"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "22"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rc-name
  network_security_group_name = azurerm_network_security_group.jump-sg-01.name
}


resource "azurerm_network_interface_security_group_association" "hackmaze-jump-sga-01" {
  network_interface_id      = var.jump_nic_id
  network_security_group_id = azurerm_network_security_group.jump-sg-01.id
}