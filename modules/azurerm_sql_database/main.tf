resource "azurerm_mssql_database" "sql_database_infra" {
  for_each  = var.sql_database_infra
  name      = each.value.name
  server_id = var.sql_server_ids[each.value.server_key]  # link to SQL Server
  collation = each.value.collation
  sku_name  = each.value.sku_name
}
