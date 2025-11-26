output "rg_ids" {
  value = { for k, rg in azurerm_resource_group.rg_infra : k => rg.id }
}

output "rg_names" {
  value = { for k, rg in azurerm_resource_group.rg_infra : k => rg.name }
}
