output "nic_ids" {
  description = "IDs of the created network interfaces"
  value       = { for k, v in azurerm_network_interface.nic_infra : k => v.id }
}

output "nic_private_ips" {
  description = "Private IP addresses of the NICs"
  value = {
    for k, nic in azurerm_network_interface.nic_infra : 
    k => [
      for ip_conf in nic.ip_configuration : ip_conf.private_ip_address
    ]
  }
}
