
output "subnet_01_address_rang" {
  value = var.hackmaze_subnet_01_address_rang
}

output "vnet_address_range" {
  value = var.hackmaze_vnet_address_range
}

output "subnet_id" {
  value = azurerm_subnet.hackmaze-subnet-01.id
}

output "jump_public_ip_id" {
  value = azurerm_public_ip.jump_server_ip.id
}

# output "jump_public_ip" {
#   value = azurerm_public_ip.jump_server_ip.ip_address
# }




data "azurerm_public_ip" "data_jump_public_ip" {
  name                = azurerm_public_ip.jump_server_ip.name
  resource_group_name = var.rc-name
}

output "jump_public_ip" {
  value = data.azurerm_public_ip.data_jump_public_ip.ip_address
}







output "hackmaze_vnet_address_range" {
  value = var.hackmaze_vnet_address_range
}

output "hackmaze_subnet_01_address_rang" {
  value = var.hackmaze_subnet_01_address_rang
}