



# Jump Server


resource "azurerm_network_interface" "jump_server_nic-01" {
 name                = "jump-server-nic-01"
 location            = var.rc-location
 resource_group_name = var.rc-name

 ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.jump_static_private_ip  # Use the variable here
    public_ip_address_id          = var.jump_public_ip_id
      


}
 
 tags = var.rc-tags
}

resource "azurerm_linux_virtual_machine" "jump_server" {
 name                  = "jump-server"
 location              = var.rc-location
 resource_group_name   = var.rc-name
 size                  = var.jump_vm_size
 admin_username        = var.admin_username
 network_interface_ids = [azurerm_network_interface.jump_server_nic-01.id]

 admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.jump_server_ssh_key.public_key_openssh
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



