variable "todo_acr_infra" {
  description = "Map of ACRs to create"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    admin_enabled       = bool
    tags = optional(map(string))
  }))
}
