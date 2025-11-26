variable "aks_cluster" {
  description = "Map of AKS cluster configurations"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    dns_prefix          = string
    node_count          = number
    node_vm_size        = string
    tags                = map(string)
  }))
}
