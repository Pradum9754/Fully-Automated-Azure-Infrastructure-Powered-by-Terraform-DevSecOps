output "instrumentation_keys" {
  value = { for k, v in azurerm_application_insights.todo_application_insights : k => v.instrumentation_key }
}

output "app_ids" {
  value = { for k, v in azurerm_application_insights.todo_application_insights : k => v.app_id }
}
