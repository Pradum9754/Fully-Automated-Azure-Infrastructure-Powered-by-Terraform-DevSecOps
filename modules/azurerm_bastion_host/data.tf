data "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = "vnet-dev"
  resource_group_name  = "todoapp-rg-dev"
}
