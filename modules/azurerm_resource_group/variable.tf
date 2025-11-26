variable "rg_todo_infra" {
  description = "Map of Resource Groups"
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}
