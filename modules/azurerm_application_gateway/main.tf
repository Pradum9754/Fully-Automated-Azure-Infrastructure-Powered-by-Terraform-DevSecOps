# Public IP for AGW

resource "azurerm_public_ip" "agw_public_ip" {
  for_each = var.app_gateways

  name                = "agw-public-ip-${each.key}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = "Standard"
  allocation_method   = "Static"
}

# Application Gateway

resource "azurerm_application_gateway" "todo_app_gateways" {
  for_each = var.app_gateways

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gateway-ip-${each.key}"
    subnet_id = data.azurerm_subnet.agw_subnet[each.key].id
  }

  # Frontend IP with public IP
  frontend_ip_configuration {
    name                 = "frontend-ip-${each.key}"
    public_ip_address_id = azurerm_public_ip.agw_public_ip[each.key].id
  }

  # Frontend ports

  dynamic "frontend_port" {
    for_each = each.value.frontend_to_backend
    content {
      name = "frontend-port-${frontend_port.key}"
      port = frontend_port.value
    }
  }

  # Backend pools

  dynamic "backend_address_pool" {
    for_each = each.value.backend_vm_keys
    content {
      name = "backend-pool-${backend_address_pool.value}"
    }
  }

  # Backend HTTP settings

  dynamic "backend_http_settings" {
    for_each = each.value.frontend_to_backend
    content {
      name                  = "http-setting-${backend_http_settings.key}"
      port                  = backend_http_settings.value
      protocol              = "Http"
      cookie_based_affinity = "Disabled"
      request_timeout       = 60
    }
  }

  # HTTP listeners

  dynamic "http_listener" {
    for_each = each.value.frontend_to_backend
    content {
      name                           = "listener-${http_listener.key}"
      frontend_ip_configuration_name = "frontend-ip-${each.key}"
      frontend_port_name             = "frontend-port-${http_listener.key}"
      protocol                       = "Http"
      ssl_certificate_name           = null
    }
  }

  # Request routing rules

  dynamic "request_routing_rule" {
    for_each = each.value.frontend_to_backend
    content {
      name                       = "rule-${request_routing_rule.key}"
      rule_type                  = "Basic"
      priority                   = 100
      http_listener_name         = "listener-${request_routing_rule.key}"
      backend_address_pool_name  = "backend-pool-${each.value.backend_vm_keys[0]}"
      backend_http_settings_name = "http-setting-${request_routing_rule.key}"
    }
  }
}
