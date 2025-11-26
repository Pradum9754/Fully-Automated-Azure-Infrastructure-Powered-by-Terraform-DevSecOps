# For RG

output "resource_group_ids" {
  value = module.todo_rg_infra_module.rg_ids
}

output "resource_group_names" {
  value = module.todo_rg_infra_module.rg_names
}

# For Private Endpoints

output "private_endpoint_ids" {
  value = module.PE_todo.private_endpoint_ids
}

output "private_endpoint_ips" {
  value = module.PE_todo.private_endpoint_ips
}

# For Diagnostic Setting

output "diagnostic_setting_ids" {
  value       = module.todo_diag.diagnostic_ids
  description = "IDs of all diagnostic settings created"
}

# For Log Analytics Workspace

output "log_analytics_workspace_id" {
  value = module.todo_logs_ana.log_analytics_ids["workspace1"]
}

# For AKS Cluster

# Outputs
output "aks_cluster_ids" {
  value = module.aks.aks_cluster_ids
}

output "aks_cluster_fqdn" {
  value = module.aks.aks_cluster_fqdn
}

output "aks_client_certificate" {
  value     = module.aks.client_certificate
  sensitive = true
}

output "aks_kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}





