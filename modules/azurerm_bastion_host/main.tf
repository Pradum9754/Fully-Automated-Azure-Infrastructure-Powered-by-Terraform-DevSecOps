resource "azurerm_bastion_host" "bastion_infra" {
  for_each            = var.bastion_todo_infra
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "ip_configuration" {
    for_each = [each.value]
    content {
      name                 = each.value.ip_config_name
      public_ip_address_id = var.bastion_public_ip_ids["frontend_pip"]
      subnet_id            = data.azurerm_subnet.bastion_subnet.id
    }
  }
}
