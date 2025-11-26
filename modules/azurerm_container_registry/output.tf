output "acr_ids" {
  description = "IDs of all created Azure Container Registries"
  value       = { for k, v in azurerm_container_registry.acr_infra : k => v.id }
}

output "acr_login_servers" {
  description = "Login servers of all created Azure Container Registries"
  value       = { for k, v in azurerm_container_registry.acr_infra : k => v.login_server }
}

output "acr_admin_usernames" {
  description = "Admin usernames of all ACRs (if enabled)"
  value       = { for k, v in azurerm_container_registry.acr_infra : k => (v.admin_enabled ? v.admin_username : null) }
}

output "acr_admin_passwords" {
  description = "Admin passwords of all ACRs (if enabled)"
  value       = { for k, v in azurerm_container_registry.acr_infra : k => (v.admin_enabled ? v.admin_password : null) }
  sensitive   = true
}
