terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.78.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test-group" {
  name     = "test-group"
  location = "East Us"
  tags = {
    environment = "test-demo"
  }
}

resource "azurerm_virtual_network" "test-virtual-net" {
  name                = "test-vertual-net"
  location            = azurerm_resource_group.test-group.location
  resource_group_name = azurerm_resource_group.test-group.name
  address_space       = ["10.0.0.0/16"]

  tags = azurerm_resource_group.test-group.tags
}

resource "azurerm_subnet" "test-subnet-01" {
  name                 = "test-subnet-01"
  resource_group_name  = azurerm_resource_group.test-group.name
  virtual_network_name = azurerm_virtual_network.test-virtual-net.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_network_security_group" "test-control-sg-01" {
  name                = "test-control-sg-01"
  location            = azurerm_resource_group.test-group.location
  resource_group_name = azurerm_resource_group.test-group.name
  tags                = azurerm_resource_group.test-group.tags

}







# rules


resource "azurerm_network_security_rule" "rule-01" {
  name                        = "AllowInboundTCP6443"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "6443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test-group.name
  network_security_group_name = azurerm_network_security_group.test-control-sg-01.name
}

resource "azurerm_network_security_rule" "rule-02" {
  name                        = "AllowInboundTCP2379-2380"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "2379-2380"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test-group.name
  network_security_group_name = azurerm_network_security_group.test-control-sg-01.name
}

resource "azurerm_network_security_rule" "rule-03" {
  name                        = "AllowInboundTCP10250"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "10250"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test-group.name
  network_security_group_name = azurerm_network_security_group.test-control-sg-01.name
}

resource "azurerm_network_security_rule" "rule-04" {
  name                        = "AllowInboundTCP10259"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "10259"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test-group.name
  network_security_group_name = azurerm_network_security_group.test-control-sg-01.name
}

resource "azurerm_network_security_rule" "rule-05" {
  name                        = "AllowInboundTCP10257"
  priority                    = 104
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "10257"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test-group.name
  network_security_group_name = azurerm_network_security_group.test-control-sg-01.name
}

resource "azurerm_network_security_rule" "rule-06" {
  name                        = "AllowInboundTCP3000-32767"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "3000-32767"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test-group.name
  network_security_group_name = azurerm_network_security_group.test-control-sg-01.name
}

resource "azurerm_network_security_rule" "rule-07" {
  name                        = "AllowInboundTCP22"
  priority                    = 106
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "22"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test-group.name
  network_security_group_name = azurerm_network_security_group.test-control-sg-01.name
}


resource "azurerm_subnet_network_security_group_association" "test-sga-01" {
  subnet_id                 = azurerm_subnet.test-subnet-01.id
  network_security_group_id = azurerm_network_security_group.test-control-sg-01.id
}











# control 1  IP , NIC , VM



resource "azurerm_public_ip" "test-ip-control-01" {
  name                = "test-ip-control-01"
  resource_group_name = azurerm_resource_group.test-group.name
  location            = azurerm_resource_group.test-group.location
  allocation_method   = "Dynamic"

  tags = azurerm_resource_group.test-group.tags
}

resource "azurerm_network_interface" "nic-control-01" {
  name                = "nic-control-01"
  location            = azurerm_resource_group.test-group.location
  resource_group_name = azurerm_resource_group.test-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.test-subnet-01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.test-ip-control-01.id

  }

  tags = azurerm_resource_group.test-group.tags
}



resource "azurerm_linux_virtual_machine" "test-control-vm-01" {
  name                  = "test-control-vm-01"
  resource_group_name   = azurerm_resource_group.test-group.name
  location              = azurerm_resource_group.test-group.location
  size                  = "Standard_B2s"
  admin_username        = "test-user"
  network_interface_ids = [azurerm_network_interface.nic-control-01.id]

  custom_data = filebase64("control-test-customdata.tpl")

  admin_ssh_key {
    username   = "test-user"
    public_key = file("~/.ssh/test-azure-key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}








# av-workers

resource "azurerm_availability_set" "worker-set" {
  name                = "worker-set"
  location            = azurerm_resource_group.test-group.location
  resource_group_name = azurerm_resource_group.test-group.name
}







# worker 1  IP , NIC , VM




resource "azurerm_public_ip" "test-ip-worker-01" {
  name                = "test-ip-worker-01"
  resource_group_name = azurerm_resource_group.test-group.name
  location            = azurerm_resource_group.test-group.location
  allocation_method   = "Dynamic"

  tags = azurerm_resource_group.test-group.tags
}

resource "azurerm_network_interface" "nic-worker-01" {
  name                = "nic-worker-01"
  location            = azurerm_resource_group.test-group.location
  resource_group_name = azurerm_resource_group.test-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.test-subnet-01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.test-ip-worker-01.id

  }

  tags = azurerm_resource_group.test-group.tags
}



resource "azurerm_linux_virtual_machine" "test-worker-vm-01" {
  name                  = "test-worker-vm-01"
  resource_group_name   = azurerm_resource_group.test-group.name
  location              = azurerm_resource_group.test-group.location
  size                  = "Standard_B2s"
  admin_username        = "test-user"
  network_interface_ids = [azurerm_network_interface.nic-worker-01.id]
  availability_set_id   = azurerm_availability_set.worker-set.id


  #custom_data = filebase64("worker-test-customdata.tpl")


  depends_on = [
    azurerm_availability_set.worker-set,
    azurerm_network_interface.nic-worker-01
  ]

  admin_ssh_key {
    username   = "test-user"
    public_key = file("~/.ssh/test-azure-key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}







# control 

# 20.25.99.110



# worker

# 172.191.46.145


#admin 

#  156.203.157.222


# worker 2  IP , NIC , VM




# resource "azurerm_public_ip" "test-ip-worker-02" {
#   name                = "test-ip-worker-02"
#   resource_group_name = azurerm_resource_group.test-group.name
#   location            = azurerm_resource_group.test-group.location
#   allocation_method   = "Dynamic"

#   tags = azurerm_resource_group.test-group.tags
# }

# resource "azurerm_network_interface" "nic-worker-02" {
#   name                = "nic-worker-02"
#   location            = azurerm_resource_group.test-group.location
#   resource_group_name = azurerm_resource_group.test-group.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.test-subnet-01.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.test-ip-worker-02.id

#   }

#   tags = azurerm_resource_group.test-group.tags
# }

# resource "azurerm_linux_virtual_machine" "test-worker-vm-02" {
#   name                  = "test-worker-vm-02"
#   resource_group_name   = azurerm_resource_group.test-group.name
#   location              = azurerm_resource_group.test-group.location
#   size                  = "Standard_B2s"
#   admin_username        = "test-user"
#   network_interface_ids = [azurerm_network_interface.nic-worker-02.id]
#   availability_set_id   = azurerm_availability_set.worker-set.id

#   #custom_data = filebase64("worker-test-customdata.tpl")

#   depends_on = [
#     azurerm_availability_set.worker-set,
#     azurerm_network_interface.nic-worker-02
#   ]

#   admin_ssh_key {
#     username   = "test-user"
#     public_key = file("~/.ssh/test-azure-key.pub")
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts-gen2"
#     version   = "latest"
#   }
# }








# resource "azurerm_public_ip" "bastion_ip" {
#   name                = "bastion-ip"
#   resource_group_name = azurerm_resource_group.test-group.name
#   location            = azurerm_resource_group.test-group.location
#   allocation_method   = "Dynamic"

#   tags = azurerm_resource_group.test-group.tags
# }

# resource "azurerm_network_interface" "nic-bastion" {
#   name                = "nic-bastion"
#   location            = azurerm_resource_group.test-group.location
#   resource_group_name = azurerm_resource_group.test-group.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.test-subnet-01.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.bastion_ip.id
#   }



# }

# resource "azurerm_virtual_machine" "test-bastion" {
#   name                = "test-bastion"
#   resource_group_name = azurerm_resource_group.test-group.name
#   location            = azurerm_resource_group.test-group.location
#   vm_size             = "Standard_B1s"

#   admin_ssh_key {
#     username   = "test-user"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }
  


#   storage_os_disk {
#     name              = "bastion-os-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }

#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts-gen2"
#     version   = "latest"
#   }

#   network_interface_ids = [azurerm_network_interface.nic-bastion.id]
# }



