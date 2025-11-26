variable "todo_vnet_subs" {
  description = "Combined configuration for VNETs and their subnets"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = map(string)
    subnets = map(object({
      name             = string
      address_prefixes = list(string)
    }))
  }))
}

