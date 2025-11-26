# parent to child  main.tf
data "azurerm_kubernetes_cluster" "aks" {
  name                = "dev-aks"
  resource_group_name = "todoapp-rg-dev"
}


