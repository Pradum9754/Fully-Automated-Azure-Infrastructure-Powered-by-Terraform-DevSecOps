output "pip_ip_ids" {
  value = { for k, v in azurerm_public_ip.pip_infra : k => v.id }
}

output "pip_ip_names" {
  value = { for k, v in azurerm_public_ip.pip_infra : k => v.name }
}
