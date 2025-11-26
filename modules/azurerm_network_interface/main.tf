resource "azurerm_network_interface" "nic_infra" {
  for_each            = var.nic_todo_infra
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations
    content {
      name                          = ip_configuration.value.name
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      
      subnet_id = lookup(
        {
          frontend = data.azurerm_subnet.frontend_sub.id
          backend  = data.azurerm_subnet.backend_sub.id
        },
        ip_configuration.value.subnet_ref,
        null
      )
    }
  }
}


# here i am using subnet_ref which is "frontend" or "backend" .

# it is match with data block keys.
# { frontend = ..., backend = ... }

# This makes a map where you choose the keys yourself: "frontend" & "backend".

# We are assigning real subnet IDs to the values.
# here we are assigning real subnet I'ds in values 