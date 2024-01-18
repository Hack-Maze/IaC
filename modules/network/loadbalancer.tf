resource "azurerm_lb" "hm-lb" {
 name               = "hm-lb"
 location            = var.rc-location
 resource_group_name = var.rc-name
 sku                = "Standard"


 frontend_ip_configuration {
   name                = "LB-IP"
   public_ip_address_id = azurerm_public_ip.loadbalancer_ip.id
 }
}



resource "azurerm_lb_backend_address_pool" "lb-backend-pool" {
 loadbalancer_id = azurerm_lb.hm-lb.id
 name            = "BackendPool"
}



resource "azurerm_lb_backend_address_pool_address" "contorl" {
  name                    = "control"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb-backend-pool.id
  virtual_network_id      = azurerm_virtual_network.hackmaze-virtual-net.id
  ip_address              = var.control_static_private_ip
}

resource "azurerm_lb_backend_address_pool_address" "worker1" {
  name                    = "worker1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb-backend-pool.id
  virtual_network_id      = azurerm_virtual_network.hackmaze-virtual-net.id
  ip_address              = var.worker1_static_private_ip
}


resource "azurerm_lb_backend_address_pool_address" "worker2" {
  name                    = "worker2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb-backend-pool.id
  virtual_network_id      = azurerm_virtual_network.hackmaze-virtual-net.id
  ip_address              = var.worker2_static_private_ip
}


resource "azurerm_lb_probe" "httpPorbe" {
  loadbalancer_id = azurerm_lb.hm-lb.id
  name            = "httpPorbe80"
  port            = 80
}


resource "azurerm_lb_rule" "httprule" {
  loadbalancer_id                = azurerm_lb.hm-lb.id
  name                           = "httpRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "LB-IP"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb-backend-pool.id]
  probe_id                       = azurerm_lb_probe.httpPorbe.id
  disable_outbound_snat         = false
} 


# resource "azurerm_lb_outbound_rule" "Outbound" {
#   name                    = "OutboundRule"
#   loadbalancer_id         = azurerm_lb.hm-lb.id
#   protocol                = "All"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.lb-backend-pool.id
#   frontend_ip_configuration {
#     name = "LB-IP"
#   }
# }