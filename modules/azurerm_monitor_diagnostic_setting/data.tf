# Get existing resources
data "azurerm_storage_account" "stg" {
  name                = var.storage_account_name
  resource_group_name = var.rg_name
}

data "azurerm_mssql_server" "sql" {
  name                = var.sql_server_name
  resource_group_name = var.rg_name
}