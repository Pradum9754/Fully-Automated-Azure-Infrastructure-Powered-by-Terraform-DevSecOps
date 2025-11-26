# Resource Group (RG)

module "todo_rg_infra_module" {
  source        = "../../modules/azurerm_resource_group"
  rg_todo_infra = var.rg_todo_infra
}

# Virtual Network (VNet) + Subnets

module "todo_vnet_subs_module" {
  depends_on     = [module.todo_rg_infra_module]
  source         = "../../modules/azurerm_vnet_subnets"
  todo_vnet_subs = var.todo_vnet_subs
}

# Application Security Group
# Network Security Group

module "todo_asg_nsg" {
  depends_on   = [module.todo_vnet_subs_module]
  source       = "../../modules/azurerm_asg_nsg"
  todo_asg_nsg = var.todo_asg_nsg
}

# Public IP Address

module "todo_pip_ip" {
  depends_on = [module.todo_rg_infra_module]
  source     = "../../modules/azurerm_public_ip"
  todo_pip   = var.todo_pip
}

# Network Interface Card

module "todo_nic" {
  depends_on = [
    module.todo_vnet_subs_module,
    module.todo_asg_nsg
  ]
  source         = "../../modules/azurerm_network_interface"
  nic_todo_infra = var.nic_todo_infra
}

# Virtual Machine (VM)

locals {
  vm_final = {
    for k, v in var.vm_todo_infra :
    k => merge(
      v,
      {
        network_interface_ids = [module.todo_nic.nic_ids[v.nic_key]],
        public_key            = file("C:/Users/pradu/.ssh/id_rsa.pub")
      }
    )
  }
}

module "todo_vm" {
  depends_on    = [module.todo_nic]
  source        = "../../modules/azurerm_virtual_machine"
  vm_todo_infra = local.vm_final
}

# Azure Bastion Host

module "todo_bastion" {
  depends_on = [
    module.todo_rg_infra_module,
    module.todo_vnet_subs_module,
    module.todo_pip_ip
  ]

  source                = "../../modules/azurerm_bastion_host"
  bastion_todo_infra    = var.bastion_todo_infra
  bastion_public_ip_ids = module.todo_pip_ip.pip_ip_ids
}

# Key Vault (KV)

module "todo_kv" {
  depends_on      = [module.todo_rg_infra_module]
  source          = "../../modules/azurerm_key_vault"
  key_vault_infra = var.key_vault_infra
}

# SQL Server

module "todo_sql_server" {
  depends_on       = [module.todo_rg_infra_module] # <-- FIXED
  source           = "../../modules/azurerm_sql_server"
  sql_server_infra = var.sql_server_infra
}

# SQL Database

module "todo_sql_database" {
  depends_on = [
    module.todo_rg_infra_module,
    module.todo_sql_server # <-- FIXED
  ]
  source             = "../../modules/azurerm_sql_database"
  sql_database_infra = var.sql_database_infra
  sql_server_ids     = module.todo_sql_server.sql_server_ids
}

# Storage Account

module "todo_storage" {
  depends_on     = [module.todo_rg_infra_module]
  source         = "../../modules/azurerm_storage_account"
  stg_todo_infra = var.stg_todo_infra
}

# Private Endpoint (PE)

module "PE_todo" {
  source = "../../modules/azurerm_private_endpoints"

  depends_on = [
    module.todo_vnet_subs_module,
    module.todo_storage,
    module.todo_sql_server
  ]

  todo_private_endpoints = var.todo_private_endpoints
  storage_ids    = module.todo_storage.storage_ids
  sql_server_ids = module.todo_sql_server.sql_server_ids
}

# Log Analytics Workspace (LAW)

module "todo_logs_ana" {
  depends_on    = [module.todo_rg_infra_module]
  source        = "../../modules/azurerm_log_analytics_workspace"
  todo_logs_ana = var.todo_logs_ana
}

# Diagnostic Settings
# Call the diagnostic settings child module
module "todo_diag" {
  source               = "../../modules/azurerm_monitor_diagnostic_setting"
  rg_name              = var.rg_name
  storage_account_name = var.storage_account_name
  sql_server_name      = var.sql_server_name
  sql_database_name    = var.sql_database_name
  todo_diag_set        = var.todo_diag_set             # Pass workspace ID dynamically from todo_logs_ana module
  log_analytics_workspace_id = module.todo_logs_ana.log_analytics_ids["workspace1"]

  depends_on = [
  module.todo_logs_ana,
  module.todo_vm,
  module.todo_storage,
  module.todo_sql_server,
  module.todo_sql_database
]
}

# Application Gateway (AppGW)

module "app_gateway" {
  depends_on = [
    module.todo_vm,
    module.todo_vnet_subs_module,
    module.todo_asg_nsg,
    module.todo_pip_ip
  ]
  source         = "../../modules/azurerm_application_gateway"
  app_gateways   = var.app_gateways
  vm_private_ips = var.vm_private_ips
}

# Azure Container Registry

module "todo_acr_module" {
  depends_on     = [module.todo_rg_infra_module]
  source         = "../../modules/azurerm_container_registry"
  todo_acr_infra = var.todo_acr_infra
}

# Azure Kubernetes Service

module "aks" {
  source      = "../../modules/azurerm_kubernetes_cluster"
  aks_cluster = var.aks_cluster
  depends_on = [
    module.todo_vnet_subs_module,
    module.todo_storage,    # <-- correct module name
    module.todo_kv,         # <-- correct module name
    module.todo_logs_ana,
    module.todo_acr_module
  ]
}

# root module main.tf (environments/dev/main.tf)
data "azurerm_kubernetes_cluster" "aks" {
  name                = "dev-aks"
  resource_group_name = "todoapp-rg-dev"
}

# Role Assignments (RBAC)

module "role_assignments" {
  source = "../../modules/azurerm_role_assignments"

  role_assignments = {
    aks_to_acr = {
      scope                = module.todo_acr_module.acr_ids["todo_acr"]
      role_definition_name = "AcrPull"
      principal_id         = data.azurerm_kubernetes_cluster.aks.identity[0].principal_id
    }
    aks_to_kv = {
      scope                = module.todo_kv.key_vault_ids["kv1"]
      role_definition_name = "Key Vault Reader"
      principal_id         = data.azurerm_kubernetes_cluster.aks.identity[0].principal_id
    }
  }

  depends_on = [
    module.todo_acr_module,
    module.todo_kv
  ]
}

# Azure Monitor Insights

module "apps_insights" {
  depends_on = [module.todo_rg_infra_module, module.todo_logs_ana ]
  source = "../../modules/azurerm_application_insights_monitoring"
  todo_apps_insights = var.todo_apps_insights
}