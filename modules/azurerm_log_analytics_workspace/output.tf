output "log_analytics_ids" {
  value = {
    for k, v in azurerm_log_analytics_workspace.log_infra : k => v.id
  }
}

output "log_analytics_workspace_ids" {
  value = {
    for k, v in azurerm_log_analytics_workspace.log_infra : k => v.workspace_id
  }
}

output "log_analytics_primary_keys" {
  value = {
    for k, v in azurerm_log_analytics_workspace.log_infra : k => v.primary_shared_key
  }
}

output "log_analytics_secondary_keys" {
  value = {
    for k, v in azurerm_log_analytics_workspace.log_infra : k => v.secondary_shared_key
  }
}

