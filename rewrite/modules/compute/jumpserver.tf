



# Jump Server
resource "azurerm_public_ip" "jump_server_ip" {
 name               = "jump-server-ip"
 location            = module.rc-group.location
 resource_group_name = module.rc-group.name
 allocation_method  = "Dynamic"
 tags = module.rc-group.tags
}

resource "azurerm_network_interface" "jump_server_nic" {
 name               = "jump-server-nic"
 location            = module.rc-group.location
 resource_group_name = module.rc-group.name

 ip_configuration {
    name                          = "internal"
    subnet_id                     = module.network.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.jump_static_private_ip  # Use the variable here
}
 tags = module.rc-group.tags
}

resource "azurerm_linux_virtual_machine" "jump_server" {
 name                = "jump-server"
 location            = module.rc-group.location
 resource_group_name = module.rc-group.name
 size                  = var.jump_vm_size
 admin_username        = var.admin_username
 network_interface_ids = [azurerm_network_interface.jump_server_nic.id]

 admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.jump_server_ssh_key.public_key_openssh
 }

 os_disk {
   caching             = "ReadWrite"
   storage_account_type = "Standard_LRS"
 }

  source_image_reference {
    publisher = var.source_image_publisher  # Use the variable here
    offer     = var.source_image_offer  # Use the variable here
    sku       = var.source_image_sku  # Use the variable here
    version   = var.source_image_version  # Use the variable here
  }
}