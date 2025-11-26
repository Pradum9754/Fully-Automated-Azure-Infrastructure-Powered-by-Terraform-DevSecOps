output "bastion_ids" {
  value = { for k, v in azurerm_bastion_host.bastion_infra : k => v.id }
}

output "bastion_public_ips" {
  value = { for k, v in azurerm_bastion_host.bastion_infra : k => v.ip_configuration[0].public_ip_address_id }
}

