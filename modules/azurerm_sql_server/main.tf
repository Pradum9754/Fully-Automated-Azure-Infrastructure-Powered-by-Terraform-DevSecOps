resource "azurerm_mssql_server" "sql_server_infra" {
  for_each = var.sql_server_infra
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
}
