output "key_vault_ids" {
  description = "IDs of the created Key Vaults"
  value       = { for k, v in azurerm_key_vault.KV_Infra : k => v.id }
}

output "key_vault_names" {
  description = "Names of the created Key Vaults"
  value       = { for k, v in azurerm_key_vault.KV_Infra : k => v.name }
}

output "key_vault_uris" {
  description = "Vault URI for accessing secrets"
  value       = { for k, v in azurerm_key_vault.KV_Infra : k => v.vault_uri }
}
