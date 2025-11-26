# For ASG - IDs and Names
output "asg_ids" {
  value = { for k, v in azurerm_application_security_group.asg_infra : k => v.id }
}

output "asg_names" {
  value = { for k, v in azurerm_application_security_group.asg_infra : k => v.name }
}

# For NSG - IDs and Names
output "nsg_ids" {
  value = { for k, v in azurerm_network_security_group.nsg_infra : k => v.id }
}

output "nsg_names" {
  value = { for k, v in azurerm_network_security_group.nsg_infra : k => v.name }
}
