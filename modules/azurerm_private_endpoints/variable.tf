variable "todo_private_endpoints" {
  description = "Map of private endpoints to create"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_key          = string
    connections = list(object({
      name               = string
      resource_key       = string   # module key, "todo_stg" or "dev"
      subresource_names  = list(string)
    }))
    tags = map(string)
  }))
}
variable "storage_ids" {
  type = map(string)
}

variable "sql_server_ids" {
  type = map(string)
}
