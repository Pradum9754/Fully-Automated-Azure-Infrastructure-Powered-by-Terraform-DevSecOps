resource "azurerm_storage_account" "storage_infra" {
  for_each                 = var.stg_todo_infra
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  tags                     = each.value.tags
}
  
