output "subnet_ids" {
  value = {
    for k, vnet in azurerm_virtual_network.vnet_sub_infra :
    k => {
      for s in vnet.subnet :
      s.name => s.id
    }
  }
}

