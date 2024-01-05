
output "subnet_01_address_rang" {
  value = var.hackmaze_subnet_01_address_rang
}

output "vnet_address_range" {
  value = var.hackmaze_vnet_address_range
}

output "subnet_id" {
  value = azurerm_subnet.hackmaze-subnet-01.id
}