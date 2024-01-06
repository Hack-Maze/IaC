

# resource "azurerm_public_ip" "hackmaze-ip-control-01" {
#   name                = "hackmaze-ip-control-01"
#   resource_group_name = azurerm_resource_group.hackmaze-group.name
#   location            = azurerm_resource_group.hackmaze-group.location
#   allocation_method   = "Dynamic"

#   tags = azurerm_resource_group.hackmaze-group.tags
# }





resource "azurerm_network_interface" "nic-control-01" {
  name                = "nic-control-01"
  location            = var.rc-location
  resource_group_name = var.rc-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.control_static_private_ip  # Use the variable here
  }

  tags = var.rc-tags
}


resource "azurerm_linux_virtual_machine" "hackmaze-control-vm-01" {
  name                  = "hackmaze-control-vm-01"
  location              = var.rc-location
  resource_group_name   = var.rc-name
  size                  = var.control_vm_size  # Use the variable here
  admin_username        = var.admin_username  # Use the variable here
  network_interface_ids = [azurerm_network_interface.nic-control-01.id]

 admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.control_server_ssh_key.public_key_openssh
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

