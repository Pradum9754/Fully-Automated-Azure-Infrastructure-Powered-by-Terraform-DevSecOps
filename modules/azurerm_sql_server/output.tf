output "sql_server_ids" {
  value = {
    for k, v in azurerm_mssql_server.sql_server_infra : k => v.id
  }
}
