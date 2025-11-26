variable "rg_name" {
  type        = string
  description = "Resource group name where resources exist"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the Storage Account"
}

variable "sql_server_name" {
  type        = string
  description = "Name of the SQL Server"
}

variable "sql_database_name" {
  type        = string
  description = "Name of the SQL Database"
}

variable "todo_diag_set" {
  type = map(object({
    name         = string
    resource_key = string
  }))
  description = "Map of diagnostic settings to create"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "ID of the Log Analytics workspace for diagnostics"
}
