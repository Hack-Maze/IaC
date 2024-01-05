
resource "azurerm_network_security_group" "jump-sg-01" {
  name                = "jump-sg-01"
  location            = module.rc-group.location
  resource_group_name = module.rc-group.name
  tags                = module.rc-group.tags
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
  resource_group_name         = module.rc-group.name
  network_security_group_name = azurerm_network_security_group.jump-sg-01.name
}


# resource "azurerm_subnet_network_security_group_association" "hackmaze-worker-sga-01" {
#   subnet_id                 = azurerm_subnet.hackmaze-subnet-01.id
#   network_security_group_id = azurerm_network_security_group.hackmaze-worker-sg-01.id
# }
