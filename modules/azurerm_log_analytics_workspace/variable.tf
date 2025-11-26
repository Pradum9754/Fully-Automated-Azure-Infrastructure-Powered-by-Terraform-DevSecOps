variable "todo_logs_ana" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    retention_in_days   = number
    tags                = optional(map(string))
  }))
}
