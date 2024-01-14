output "jump_sg_id" {
  value = azurerm_network_security_group.jump-sg-01.id
}

output "control_sg_id" {
  value = azurerm_network_security_group.control-sg-01.id
}

output "worker_sg_id" {
  value = azurerm_network_security_group.worker-sg-01.id
}