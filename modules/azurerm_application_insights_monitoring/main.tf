resource "azurerm_application_insights" "todo_application_insights" {
  for_each            = var.todo_apps_insights
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  application_type    = each.value.application_type
}
