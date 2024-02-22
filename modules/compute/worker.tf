#worker 1
resource "azurerm_availability_set" "worker-set" {
  name                = "worker-set"
  location            = var.rc-location
  resource_group_name = var.rc-name
}


resource "azurerm_network_interface" "nic-worker1-01" {
  name                = "nic-worker-01"
  location            = var.rc-location
  resource_group_name = var.rc-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.worker1_static_private_ip  # Use the variable here
  }

  tags = var.rc-tags
}



resource "azurerm_linux_virtual_machine" "hackmaze-worker-vm-01" {
  name                  = "hackmaze-worker-vm-01"
  location              = var.rc-location
  resource_group_name   = var.rc-name
  size                  = var.worker1_vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic-worker1-01.id]
  availability_set_id   = azurerm_availability_set.worker-set.id

  depends_on = [
    azurerm_availability_set.worker-set,
    azurerm_network_interface.nic-worker1-01
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

resource "azurerm_network_interface" "nic-worker2-01" {
  name                = "nic-worker2-01"
  location              = var.rc-location
  resource_group_name   = var.rc-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.worker2_static_private_ip  # Use the variable here
  }

  tags = var.rc-tags
}



resource "azurerm_linux_virtual_machine" "hackmaze-worker-vm-02" {
  name                  = "hackmaze-worker-vm-02"
  location              = var.rc-location
  resource_group_name   = var.rc-name
  size                  = var.worker2_vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic-worker2-01.id]
  availability_set_id   = azurerm_availability_set.worker-set.id

  depends_on = [
    azurerm_availability_set.worker-set,
    azurerm_network_interface.nic-worker2-01
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
