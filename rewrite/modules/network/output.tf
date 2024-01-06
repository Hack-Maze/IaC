
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

output "jump_public_ip" {
  value = azurerm_public_ip.jump_server_ip.ip_address
}