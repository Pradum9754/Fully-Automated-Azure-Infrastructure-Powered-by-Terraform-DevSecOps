variable "role_assignments" {
  description = "Map of role assignments to create. Each entry should have scope, role_definition_name and principal_id."
  type        = map(object({
    scope                = string
    role_definition_name = string
    principal_id         = string
  }))
  default = {}
}
