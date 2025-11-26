output "role_assignment_ids" {
  value = { for k, v in azurerm_role_assignment.aks_roles : k => v.id }
}

# child outputs.tf
output "aks_principal_id" {
  value = data.azurerm_kubernetes_cluster.aks.identity[0].principal_id
}
