terraform {
  backend "azurerm" {
    resource_group_name  = "todoapp-rg-dev"
    storage_account_name = "todostgdev"  # you can use same stg account depend on project otherwise u can deploy diff- diff subscriptions
    container_name       = "containerdev"    # same for container
    key                  = "dev.terraform.tfstate"  
  }
}