variable "sql_database_infra" {
  type = map(object({
    name       = string
    server_key = string  # This key is used to match the SQL server map
    collation  = string
    sku_name   = string
  }))
}

variable "sql_server_ids" {
  description = "Map of SQL Server IDs from the SQL Server module"
  type        = map(string)
}
