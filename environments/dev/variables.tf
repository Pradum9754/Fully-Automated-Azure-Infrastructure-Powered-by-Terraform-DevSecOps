variable "rg_todo_infra" {
  description = "Map of Resource Groups"
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}

variable "todo_vnet_subs" {
  description = "Combined configuration for VNETs and their subnets"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = map(string)
    subnets = map(object({
      name             = string
      address_prefixes = list(string)
    }))
  }))
}

variable "todo_asg_nsg" {
  description = "Combined configuration for NSGs and ASGs"
  type = map(object({
    asg = object({
      name                = string
      location            = string
      resource_group_name = string
      tags                = map(string)
    })
    nsg = object({
      name                = string
      location            = string
      resource_group_name = string
      tags                = map(string)
      security_rules = list(object({
        name                       = string
        priority                   = number
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = string
        source_address_prefix      = string
        destination_address_prefix = string

        # optional for ASG use
        source_application_security_group_ids      = optional(list(string))
        destination_application_security_group_ids = optional(list(string))
      }))
    })
  }))
}

variable "todo_pip" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    tags                = optional(map(string))
  }))
}

variable "nic_todo_infra" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = map(string)
    ip_configurations = list(object({
      name                          = string
      subnet_ref                    = string # <-- here i am using subnet_ref this is best, not subnet_id
      private_ip_address_allocation = string

    }))
  }))
}

variable "vm_todo_infra" {
  type = map(object({
    name                  = string
    resource_group_name   = string
    location              = string
    size                  = string
    admin_username        = string
    nic_key               = string                 # required in tfvars
    network_interface_ids = optional(list(string)) # optional now
    public_key            = optional(string)       # optional now
    caching               = string
    storage_account_type  = string
    publisher             = string
    offer                 = string
    sku                   = string
    version               = string
  }))
}

variable "bastion_todo_infra" {
  type = map(object({
    bastion_name        = string
    location            = string
    resource_group_name = string
    ip_config_name      = string
    subnet_ref          = string
  }))
}

variable "key_vault_infra" {
  description = "Map of Key Vault configurations"
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    sku_name                    = string
  }))
}

variable "sql_server_infra" {
  type = map(object({
    name                         = string
    resource_group_name          = string
    location                     = string
    version                      = string
    administrator_login          = string
    administrator_login_password = string
  }))
}

variable "sql_database_infra" {
  type = map(object({
    name       = string
    server_key = string
    collation  = string
    sku_name   = string
  }))
}

variable "stg_todo_infra" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    account_tier        = string
    account_replication_type = string
    tags                = optional(map(string))
  }))
}

variable "todo_private_endpoints" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_key          = string
    connections = list(object({
      name               = string
      resource_key       = string
      subresource_names  = list(string)
    }))
    tags = map(string)
  }))
}

variable "todo_logs_ana" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    retention_in_days   = number
    tags                = optional(map(string))
  }))
}

variable "rg_name" {
  type        = string
  description = "Name of the Resource Group"
}

variable "location" {
  type        = string
  description = "Azure region for resources"
}

variable "workspace_name" {
  type        = string
  description = "Log Analytics Workspace name"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the Storage Account"
}

variable "sql_server_name" {
  type        = string
  description = "Name of the SQL Server"
}

variable "sql_database_name" {
  type        = string
  description = "Name of the SQL Database"
}

variable "todo_diag_set" {
  type = map(object({
    name         = string
    resource_key = string
  }))
  description = "Map of diagnostic settings to create"
}

variable "app_gateways" {
  description = "Application Gateways configuration"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    frontend_to_backend = map(number)
    backend_vm_keys     = list(string)
  }))
}

variable "vm_private_ips" {
  description = "Private IPs of backend and frontend VMs"
  type        = map(string)
}

variable "todo_acr_infra" {
  description = "Map of ACRs to create"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    admin_enabled       = bool
    tags = optional(map(string))
  }))
}

variable "aks_cluster" {
  description = "Map of AKS clusters to create"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    dns_prefix          = string
    node_count          = number
    node_vm_size        = string
    tags                = map(string)
  }))
}

variable "role_assignments" {
  description = "Map of role assignments to create. Each entry should have scope, role_definition_name and principal_id."
  type        = map(object({
    scope                = string
    role_definition_name = string
    principal_id         = string
  }))
  default = {}
}

variable "todo_apps_insights" {
  description = "Map of Application Insights to create"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    application_type    = string
  }))
  default = {}
}
