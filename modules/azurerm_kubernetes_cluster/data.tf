# # Get log analytics workspaces dynamically
# data "azurerm_log_analytics_workspace" "todo_workspace" {
#   for_each = var.todo_logs_ana

#   name                = each.value.name
#   resource_group_name = each.value.resource_group_name
# }
