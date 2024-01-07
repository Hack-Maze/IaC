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

output "admin_username" {
  value = var.admin_username
}


output "control_nic_id" {
  value = azurerm_network_interface.nic-control-01.id
}

output "jump_nic_id" {
  value = azurerm_network_interface.jump_server_nic-01.id
}

output "worker1_nic_id" {
  value = azurerm_network_interface.nic-worker1-01.id
}

output "worker2_nic_id" {
  value = azurerm_network_interface.nic-worker2-01.id
}


output "jump_private_key_content" {
  value = local_file.jump_private_key.content
}


