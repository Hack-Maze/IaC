output "jump_static_private_ip" {
  value = var.jump_static_private_ip
}

output "control_static_private_ip" {
  value = var.control_static_private_ip
}

output "worker1_static_private_ip" {
  value = var.worker1_static_private_ip
}

output "worker2_static_private_ip" {
  value = var.worker2_static_private_ip
}
output "jump_public_ip" {
  value = azurerm_public_ip.jump_server_ip.ip_address
}


output "admin_username" {
  value = var.admin_username
}