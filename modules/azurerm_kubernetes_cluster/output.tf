output "client_certificate" {
  description = "Client certificate for AKS clusters"
  value = { for k, v in azurerm_kubernetes_cluster.aks_clusters : k => v.kube_config[0].client_certificate }
  sensitive = true
}

output "kube_config" {
  description = "Raw kubeconfig for AKS clusters"
  value = { for k, v in azurerm_kubernetes_cluster.aks_clusters : k => v.kube_config_raw }
  sensitive = true
}

output "aks_cluster_ids" {
  description = "IDs of AKS clusters"
  value = { for k, v in azurerm_kubernetes_cluster.aks_clusters : k => v.id }
}

output "aks_cluster_fqdn" {
  description = "FQDN of AKS clusters"
  value = { for k, v in azurerm_kubernetes_cluster.aks_clusters : k => v.fqdn }
}

output "aks_principal_ids" {
  description = "SystemAssigned identity principal IDs of AKS clusters"
  value       = { for k, v in azurerm_kubernetes_cluster.aks_clusters : k => v.identity[0].principal_id }
}
