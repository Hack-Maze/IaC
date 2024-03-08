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



resource "azurerm_lb_probe" "httpPorbe30080" {
  loadbalancer_id = azurerm_lb.hm-lb.id
  name            = "httpPorbe30080"
  port            = 30080
}


resource "azurerm_lb_rule" "httprule30080" {
  loadbalancer_id                = azurerm_lb.hm-lb.id
  name                           = "httpRule80"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 30080
  frontend_ip_configuration_name = "LB-IP"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb-backend-pool.id]
  probe_id                       = azurerm_lb_probe.httpPorbe30080.id
  disable_outbound_snat         = true
} 


resource "azurerm_lb_probe" "httpPorbe30443" {
  loadbalancer_id = azurerm_lb.hm-lb.id
  name            = "httpPorbe30443"
  port            = 30443
}


resource "azurerm_lb_rule" "httprule30443" {
  loadbalancer_id                = azurerm_lb.hm-lb.id
  name                           = "httpRule443"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 30443
  frontend_ip_configuration_name = "LB-IP"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb-backend-pool.id]
  probe_id                       = azurerm_lb_probe.httpPorbe30443.id
  disable_outbound_snat         = true
} 


resource "azurerm_lb_outbound_rule" "Outbound" {
  name                    = "OutboundRule"
  loadbalancer_id         = azurerm_lb.hm-lb.id
  protocol                = "All"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb-backend-pool.id
  frontend_ip_configuration {
    name = "LB-IP"
  }
}




resource "azurerm_lb_backend_address_pool" "lb-postgres-pool" {
 loadbalancer_id = azurerm_lb.hm-lb.id
 name            = "PostgresPool"
}

resource "azurerm_lb_backend_address_pool_address" "controlpostgres" {
  name                    = "controlpostgres"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb-postgres-pool.id
  virtual_network_id      = azurerm_virtual_network.hackmaze-virtual-net.id
  ip_address              = var.control_static_private_ip
}

resource "azurerm_lb_nat_rule" "postgres_rule" {
 resource_group_name            = var.rc-name
 loadbalancer_id                = azurerm_lb.hm-lb.id
 name                           = "postgresAccess"
 protocol                       = "Tcp"
 frontend_port_start            = 5432
 frontend_port_end              = 5432
 backend_port                   = 30543
 backend_address_pool_id        = azurerm_lb_backend_address_pool.lb-postgres-pool.id
 frontend_ip_configuration_name = "LB-IP"
}
