output "storage_ids" {
  value = { for k, v in azurerm_storage_account.storage_infra : k => v.id }
}
