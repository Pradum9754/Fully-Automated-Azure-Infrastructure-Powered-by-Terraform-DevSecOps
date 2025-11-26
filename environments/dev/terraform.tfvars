# Resource Group (RG)

rg_todo_infra = {
  infra_rg = {
    name       = "todoapp-rg-dev"
    location   = "centralindia"
    managed_by = "devops_insiders_teams"
    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
    }
  }
}

# Virtual Network (VNet) + Subnets

todo_vnet_subs = {
  vnet_todo = {
    name                = "vnet-dev"
    location            = "centralindia"
    resource_group_name = "todoapp-rg-dev"
    address_space       = ["10.0.0.0/16"]
    managed_by          = "devops_insiders_teams"
    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
    }
    subnets = {
      frontend_sub = {
        name             = "todo_frontend_sub"
        address_prefixes = ["10.0.1.0/24"]
      }
      backend_sub = {
        name             = "todo_backend_sub"
        address_prefixes = ["10.0.2.0/24"]
      }

      bastion_sub = {
        name             = "AzureBastionSubnet" # ✔ MUST
        address_prefixes = ["10.0.3.0/26"]      # ✔ REQUIRED
      }
      agw_subnet = { # ✔ Add this ✔ REQUIRED
        name             = "agw-subnet"
        address_prefixes = ["10.0.4.0/24"]
      }
    }
  }
}

# Network Security Group
# Application Security Group

todo_asg_nsg = {
  "frontend" = {
    asg = {
      name                = "frontend-asg"
      location            = "centralindia"
      resource_group_name = "todoapp-rg-dev"
      tags = {
        Environment = "Development"
        Project     = "todoapp"
        Owner       = "devops-insiders"
      }
    }
    nsg = {
      name                = "frontend-nsg"
      location            = "centralindia"
      resource_group_name = "todoapp-rg-dev"
      tags = {
        Environment = "Development"
        Project     = "todoapp"
        Owner       = "devops-insiders"
      }
      security_rules = [
        {
          name                       = "Allow_HTTP"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "Allow_HTTPS"
          priority                   = 101
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                                  = "Allow_SSH"
          priority                              = 102
          direction                             = "Inbound"
          access                                = "Allow"
          protocol                              = "Tcp"
          source_port_range                     = "*"
          destination_port_range                = "22"
          source_address_prefix                 = "*"
          destination_address_prefix            = "*"
          source_application_security_group_ids = [] # Will be filled by code logic
        }
      ]
    }
  },
  "backend" = {
    asg = {
      name                = "backend-asg"
      location            = "centralindia"
      resource_group_name = "todoapp-rg-dev"
      tags = {
        Environment = "Development"
        Project     = "todoapp"
        Owner       = "devops-insiders"
      }
    }
    nsg = {
      name                = "backend-nsg"
      location            = "centralindia"
      resource_group_name = "todoapp-rg-dev"
      tags = {
        Environment = "Development"
        Project     = "todoapp"
        Owner       = "devops-insiders"
      }
      security_rules = [
        {
          name                       = "Allow_HTTP"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "Allow_HTTPS"
          priority                   = 101
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        { name                                  = "Allow_SSH"
          priority                              = 102
          direction                             = "Inbound"
          access                                = "Allow"
          protocol                              = "Tcp"
          source_port_range                     = "*"
          destination_port_range                = "22"
          source_address_prefix                 = "*"
          destination_address_prefix            = "*"
          source_application_security_group_ids = [] # Will be filled by code logic
        }
      ]
    }
  }
}

# Public IP Address

todo_pip = {
  frontend_pip = {
    name                = "frontend-pip-dev"
    resource_group_name = "todoapp-rg-dev"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
      ManagedBy   = "devops_insiders_teams"
    }
  }
  backend_pip = {
    name                = "backend-pip-dev"
    resource_group_name = "todoapp-rg-dev"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
      ManagedBy   = "devops_insiders_teams"
    }
  }
}

# Network Interface Card

nic_todo_infra = {
  frontend_nic = {
    name                = "frontend-nic"
    location            = "centralindia"
    resource_group_name = "todoapp-rg-dev"
    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
    }
    ip_configurations = [
      {
        name                          = "frontend-ipconfig"
        subnet_ref                    = "frontend" # it will be match from data block
        private_ip_address_allocation = "Dynamic"

      }
    ]
  }

  backend_nic = {
    name                = "backend-nic"
    location            = "centralindia"
    resource_group_name = "todoapp-rg-dev"
    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
    }
    ip_configurations = [
      {
        name                          = "backend-ipconfig"
        subnet_ref                    = "backend" # it will be match from data block
        private_ip_address_allocation = "Dynamic"

      }
    ]
  }
}

# Virtual Machine (VM)

vm_todo_infra = {
  frontend_vm = {
    name                 = "frontend-vm-dev"
    resource_group_name  = "todoapp-rg-dev"
    location             = "centralindia"
    size                 = "Standard_B2s"
    admin_username       = "adminuser"
    nic_key              = "frontend_nic"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    publisher            = "Canonical"
    offer                = "0001-com-ubuntu-server-jammy"
    sku                  = "22_04-lts"
    version              = "latest"
  }
  backend_vm = {
    name                 = "backend-vm-dev"
    resource_group_name  = "todoapp-rg-dev"
    location             = "centralindia"
    size                 = "Standard_B2s"
    admin_username       = "adminuser"
    nic_key              = "backend_nic"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    publisher            = "Canonical"
    offer                = "0001-com-ubuntu-server-jammy"
    sku                  = "22_04-lts"
    version              = "latest"
  }
}

# Azure Bastion Host

bastion_todo_infra = {
  bastion_frontend = {
    bastion_name        = "todo-bastion-dev1"
    location            = "centralindia"
    resource_group_name = "todoapp-rg-dev"
    ip_config_name      = "bastion-ipconfig"
    subnet_ref          = "AzureBastionSubnet" # ✔ FIXED
  }
}

# Key Vault (KV)

key_vault_infra = {
  kv1 = {
    name                        = "kv-vault-infra-dev03" # add unique suffix
    location                    = "centralindia"
    resource_group_name         = "todoapp-rg-dev"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false # on production true
    sku_name                    = "standard"
  }
}

# SQL Server

sql_server_infra = {
  dev = {
    name                         = "sqlserver-dev04"
    resource_group_name          = "todoapp-rg-dev"
    location                     = "centralindia"
    version                      = "12.0"
    administrator_login          = "adminuser"
    administrator_login_password = "Praboss@9754"
  }
}

# SQL Database

sql_database_infra = {
  devdb = {
    name       = "sqldb-dev04"
    server_key = "dev"
    collation  = "SQL_Latin1_General_CP1_CI_AS"
    sku_name   = "Basic"
  }
}

# Storage Account

stg_todo_infra = {
  todo_stg = {
    name                     = "todostgdev"
    resource_group_name      = "todoapp-rg-dev"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
      ManagedBy   = "devops_insiders_teams"
    }
  }
}

# Private Endpoint (PE)

todo_private_endpoints = {
  # Storage: Blob
  pe_backend_blob = {
    name                = "pe-dev-storage-blob"
    location            = "centralindia"
    resource_group_name = "todoapp-rg-dev"
    subnet_key          = "backend"

    connections = [
      {
        name              = "psc-todo-storage-blob"
        resource_key      = "todo_stg"
        subresource_names = ["blob"]
      }
    ]

    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
      ManagedBy   = "devops_insiders_teams"
    }
  }

  # Storage: File
  pe_backend_file = {
    name                = "pe-dev-storage-file"
    location            = "centralindia"
    resource_group_name = "todoapp-rg-dev"
    subnet_key          = "backend"

    connections = [
      {
        name              = "psc-todo-storage-file"
        resource_key      = "todo_stg"
        subresource_names = ["file"]
      }
    ]

    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
      ManagedBy   = "devops_insiders_teams"
    }
  }

  # Storage: Table
  pe_backend_table = {
    name                = "pe-dev-storage-table"
    location            = "centralindia"
    resource_group_name = "todoapp-rg-dev"
    subnet_key          = "backend"

    connections = [
      {
        name              = "psc-todo-storage-table"
        resource_key      = "todo_stg"
        subresource_names = ["table"]
      }
    ]

    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
      ManagedBy   = "devops_insiders_teams"
    }
  }

  # Storage: Queue
  pe_backend_queue = {
    name                = "pe-dev-storage-queue"
    location            = "centralindia"
    resource_group_name = "todoapp-rg-dev"
    subnet_key          = "backend"

    connections = [
      {
        name              = "psc-todo-storage-queue"
        resource_key      = "todo_stg"
        subresource_names = ["queue"]
      }
    ]

    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
      ManagedBy   = "devops_insiders_teams"
    }
  }

  # SQL Server

  sql_backend = {
    name                = "pe-dev-sql"
    location            = "centralindia"
    resource_group_name = "todoapp-rg-dev"
    subnet_key          = "backend"

    connections = [
      {
        name              = "psc-todo-sql"
        resource_key      = "dev"
        subresource_names = ["sqlServer"]
      }
    ]

    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
      ManagedBy   = "devops_insiders_teams"
    }
  }
}

# Log Analytics Workspace (LAW)

todo_logs_ana = {
  workspace1 = {
    name                = "todo-loganalytics-dev"
    resource_group_name = "todoapp-rg-dev"
    location            = "centralindia"
    sku                 = "PerGB2018"
    retention_in_days   = 30
    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
      ManagedBy   = "devops_insiders_teams"
    }
  }
}

# Diagnostic Settings

rg_name              = "todoapp-rg-dev"
location             = "centralindia"
workspace_name       = "todoapp-law-dev"
storage_account_name = "todostgdev"
sql_server_name      = "sqlserver-dev04"
sql_database_name    = "sqldb-dev04"

todo_diag_set = {
  storage = {
    name         = "storage-diag"
    resource_key = "stg"
  }
  sql = {
    name         = "sql-diag"
    resource_key = "sql"
  }
}

# Application Gateway (AppGW)

app_gateways = {
  todo_agw = {
    name                = "todo-app-agw"
    resource_group_name = "todoapp-rg-dev"
    location            = "centralindia"
    frontend_to_backend = {
      "80" = 80
      # "443" = 443
    }
    backend_vm_keys = ["frontend_vm", "backend_vm"]
  }
}

vm_private_ips = {
  frontend_vm = "10.0.1.5"
  backend_vm  = "10.0.2.5"
}

# Azure Container Registry

todo_acr_infra = {
  todo_acr = {
    name                = "tododevacr1"
    resource_group_name = "todoapp-rg-dev"
    location            = "centralindia"
    sku                 = "Standard"
    admin_enabled       = false
    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
      ManagedBy   = "devops_insiders_teams"
    }
  }
}

# Azure Kubernetes Service

aks_cluster = {
  dev_aks = {
    name                = "dev-aks"
    resource_group_name = "todoapp-rg-dev"
    location            = "South India" # here i am using azure free subscription so quota is limited here i use diff- diff region for deploy ACR & AKS in dev
    dns_prefix          = "devaks"      # But in production we have to choose same region and follow good practice
    node_count          = 1
    node_vm_size        = "Standard_B2s"
    tags = {
      Environment = "Development"
      Project     = "todoapp"
      Owner       = "devops-insiders"
      ManagedBy   = "devops_insiders_teams"
    }
  }
}

# Azure Monitor Insights

todo_apps_insights = {
  todo_apps_ins = {
    name                = "todo-app-monitoring"
    location            = "centralindia"
    resource_group_name = "todoapp-rg-dev"
    application_type    = "web"
  }
}
