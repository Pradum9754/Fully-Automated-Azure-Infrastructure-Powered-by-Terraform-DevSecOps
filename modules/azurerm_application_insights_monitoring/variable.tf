variable "todo_apps_insights" {
  description = "Map of Application Insights to create"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    application_type    = string
  }))
  default = {}
}
