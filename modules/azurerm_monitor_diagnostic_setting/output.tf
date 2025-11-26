output "diagnostic_ids" {
  value       = { for k, v in azurerm_monitor_diagnostic_setting.todo_diagnostic : k => v.id }
  description = "IDs of the created diagnostic settings"
}
