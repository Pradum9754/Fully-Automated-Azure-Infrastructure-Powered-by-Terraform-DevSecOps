resource "azurerm_private_endpoint" "todo_infra" {
  for_each = var.todo_private_endpoints

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags

  subnet_id = lookup(
    {
      frontend = data.azurerm_subnet.frontend_sub.id
      backend  = data.azurerm_subnet.backend_sub.id
    },
    each.value.subnet_key
  )

  dynamic "private_service_connection" {
    for_each = each.value.connections
    content {
      name                           = private_service_connection.value.name

      private_connection_resource_id = lookup(
        merge(var.storage_ids, var.sql_server_ids),
        private_service_connection.value.resource_key
      )

      subresource_names = private_service_connection.value.subresource_names
      is_manual_connection = false
    }
  }
}