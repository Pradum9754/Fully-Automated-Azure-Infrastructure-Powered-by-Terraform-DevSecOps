resource "azurerm_public_ip" "pip_infra" {
  for_each            = var.todo_pip
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  tags                = each.value.tags
}


