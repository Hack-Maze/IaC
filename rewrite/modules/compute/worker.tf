#worker 1
resource "azurerm_availability_set" "worker-set" {
  name                = "worker-set"
  location            = module.rc-group.location
  resource_group_name = module.rc-group.name
}


resource "azurerm_network_interface" "nic-worker-01" {
  name                = "nic-worker-01"
  location            = module.rc-group.location
  resource_group_name = module.rc-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.network.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.worker1_static_private_ip  # Use the variable here
  }

  tags = module.rc-group.tags
}



resource "azurerm_linux_virtual_machine" "hackmaze-worker-vm-01" {
  name                  = "hackmaze-worker-vm-01"
  location              = module.rc-group.location
  resource_group_name   = module.rc-group.name
  size                  = var.worker_vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic-worker-01.id]
  availability_set_id   = azurerm_availability_set.worker-set.id

  depends_on = [
    azurerm_availability_set.worker-set,
    azurerm_network_interface.nic-worker-01
  ]

 admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.worker1_server_ssh_key.public_key_openssh
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






#worker2

resource "azurerm_network_interface" "nic-worker-02" {
  name                = "nic-worker-02"
  location              = module.rc-group.location
  resource_group_name   = module.rc-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.network.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.worker2_static_private_ip  # Use the variable here
  }

  tags = module.rc-group.tags
}



resource "azurerm_linux_virtual_machine" "hackmaze-worker-vm-02" {
  name                  = "hackmaze-worker-vm-02"
  location            = module.rc-group.location
  resource_group_name = module.rc-group.name
  size                  = var.worker_vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic-worker-02.id]
  availability_set_id   = azurerm_availability_set.worker-set.id

  depends_on = [
    azurerm_availability_set.worker-set,
    azurerm_network_interface.nic-worker-02
  ]

 admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.worker2_server_ssh_key.public_key_openssh
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
