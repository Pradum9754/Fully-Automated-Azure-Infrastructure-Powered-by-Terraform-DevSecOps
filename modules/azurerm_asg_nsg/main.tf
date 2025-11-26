resource "azurerm_application_security_group" "asg_infra" {
  for_each = var.todo_asg_nsg

  name                = each.value.asg.name
  location            = each.value.asg.location
  resource_group_name = each.value.asg.resource_group_name
  tags                = each.value.asg.tags
}

resource "azurerm_network_security_group" "nsg_infra" {
  for_each = var.todo_asg_nsg

  name                = each.value.nsg.name
  location            = each.value.nsg.location
  resource_group_name = each.value.nsg.resource_group_name
  tags                = each.value.nsg.tags

  dynamic "security_rule" {
    for_each = each.value.nsg.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix

      # optional linking with ASG
      source_application_security_group_ids      = security_rule.value.source_application_security_group_ids
      destination_application_security_group_ids = security_rule.value.destination_application_security_group_ids
    }
  }
}
