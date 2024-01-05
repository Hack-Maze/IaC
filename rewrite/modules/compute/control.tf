

# resource "azurerm_public_ip" "hackmaze-ip-control-01" {
#   name                = "hackmaze-ip-control-01"
#   resource_group_name = azurerm_resource_group.hackmaze-group.name
#   location            = azurerm_resource_group.hackmaze-group.location
#   allocation_method   = "Dynamic"

#   tags = azurerm_resource_group.hackmaze-group.tags
# }

module "rc-group" {
 source = "../rc-group"
 
 
 // ... other variables
}
module "network" {
 source = "../network"
 
 
 // ... other variables
}




resource "azurerm_network_interface" "nic-control-01" {
  name                = "nic-control-01"
  location            = module.rc-group.location
  resource_group_name = module.rc-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.network.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.control_static_private_ip  # Use the variable here
  }

  tags = module.rc-group.tags
}


resource "azurerm_linux_virtual_machine" "hackmaze-control-vm-01" {
  name                  = "hackmaze-control-vm-01"
  location              = module.rc-group.location
  resource_group_name   = module.rc-group.name
  size                  = var.control_vm_size  # Use the variable here
  admin_username        = var.admin_username  # Use the variable here
  network_interface_ids = [azurerm_network_interface.nic-control-01.id]

  admin_ssh_key {
    username   = var.admin_username  # Use the variable here
    public_key = file(var.admin_ssh_public_key_path)  # Use the variable here
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.source_image_publisher  # Use the variable here
    offer     = var.source_image_offer  # Use the variable here
    sku       = var.source_image_sku  # Use the variable here
    version   = var.source_image_version  # Use the variable here
  }
}

