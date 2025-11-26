# IDs of all created Linux VMs
output "vm_ids" {
  description = "IDs of the created Linux virtual machines"
  value       = { for k, v in azurerm_linux_virtual_machine.vm_infra : k => v.id }
}

# Names of all Linux VMs
output "vm_names" {
  description = "Names of the created Linux virtual machines"
  value       = { for k, v in azurerm_linux_virtual_machine.vm_infra : k => v.name }
}
