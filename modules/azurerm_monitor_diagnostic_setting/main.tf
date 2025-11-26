resource "azurerm_monitor_diagnostic_setting" "todo_diagnostic" {
  for_each = var.todo_diag_set

  name               = each.value.name
  target_resource_id = lookup(
    {
      stg = data.azurerm_storage_account.stg.id
      sql = data.azurerm_mssql_server.sql.id
    },
    each.value.resource_key
  )

  storage_account_id         = data.azurerm_storage_account.stg.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Comment out enabled_log for free-tier compatibility
  # enabled_log {
  #   category = "some_category"
  # }

  enabled_metric {
    category = "AllMetrics"
  }

   lifecycle {
    ignore_changes = all
  }
}

