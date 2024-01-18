resource "azurerm_public_ip" "jump_server_ip" {
 name                = "jump-server-ip"
 location            = var.rc-location
 resource_group_name = var.rc-name
 allocation_method   = "Static"
 domain_name_label   = "${var.dns_name}"
 tags                = var.rc-tags
}


data "azurerm_public_ip" "jump_server_ip_data" {
 name                = azurerm_public_ip.jump_server_ip.name
 resource_group_name = var.rc-name
}


resource "azurerm_public_ip" "loadbalancer_ip" {
 name                = "LB-IP"
 location            = var.rc-location
 resource_group_name = var.rc-name
 allocation_method   = "Static"
 sku                 = "Standard"
 tags                = var.rc-tags
}
