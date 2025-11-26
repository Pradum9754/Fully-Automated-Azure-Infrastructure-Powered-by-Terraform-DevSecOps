output "sql_database_ids" {
  value = {
    for k, v in azurerm_mssql_database.sql_database_infra : k => v.id
  }
}
