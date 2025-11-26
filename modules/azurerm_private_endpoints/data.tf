data "azurerm_subnet" "frontend_sub" {
  name                 = "todo_frontend_sub"
  virtual_network_name = "vnet-dev"
  resource_group_name  = "todoapp-rg-dev"
}

data "azurerm_subnet" "backend_sub" {
  name                 = "todo_backend_sub"
  virtual_network_name = "vnet-dev"
  resource_group_name  = "todoapp-rg-dev"
}
