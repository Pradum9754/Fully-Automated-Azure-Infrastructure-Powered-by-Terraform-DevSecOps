resource "azurerm_container_registry" "acr_infra" {
  for_each            = var.todo_acr_infra
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku
  admin_enabled       = each.value.admin_enabled
  tags = each.value.tags
}