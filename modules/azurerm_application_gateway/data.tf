data "azurerm_subnet" "agw_subnet" {
  for_each            = var.app_gateways
  name                = "agw-subnet"   # must match VNet module
  virtual_network_name = "vnet-dev"
  resource_group_name  = "todoapp-rg-dev"
}
