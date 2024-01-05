#worker 1
resource "azurerm_availability_set" "worker-set" {
  name                = "worker-set"
  location            = azurerm_resource_group.test-group.location
  resource_group_name = azurerm_resource_group.test-group.name
}


resource "azurerm_network_interface" "nic-worker-01" {
  name                = "nic-worker-01"
  location            = azurerm_resource_group.hackmaze-group.location
  resource_group_name = azurerm_resource_group.hackmaze-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hackmaze-subnet-01.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.worker1_static_private_ip  # Use the variable here
  }

  tags = azurerm_resource_group.hackmaze-group.tags
}



resource "azurerm_linux_virtual_machine" "hackmaze-worker-vm-01" {
  name                  = "hackmaze-worker-vm-01"
  resource_group_name   = azurerm_resource_group.hackmaze-group.name
  location              = azurerm_resource_group.hackmaze-group.location
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
    public_key = file(var.admin_ssh_public_key_path)
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
   location           = azurerm_resource_group.hackmaze-group.location
  resource_group_name = azurerm_resource_group.hackmaze-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hackmaze-subnet-01.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.worker2_static_private_ip  # Use the variable here
  }

  tags = azurerm_resource_group.hackmaze-group.tags
}



resource "azurerm_linux_virtual_machine" "hackmaze-worker-vm-02" {
  name                  = "hackmaze-worker-vm-02"
  resource_group_name   = azurerm_resource_group.hackmaze-group.name
  location              = azurerm_resource_group.hackmaze-group.location
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
    public_key = file(var.admin_ssh_public_key_path)
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
