resource "azurerm_kubernetes_cluster" "aks_clusters" {
  for_each            = var.aks_cluster
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = each.value.node_count
    vm_size    = each.value.node_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = each.value.tags
}
