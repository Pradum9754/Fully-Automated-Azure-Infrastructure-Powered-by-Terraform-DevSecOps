variable "bastion_todo_infra" {
  description = "Map of Bastion hosts to create"
  type = map(object({
    bastion_name        = string
    location            = string
    resource_group_name = string
    ip_config_name      = string
    subnet_ref          = string
  }))
  default = {}
}

variable "bastion_public_ip_ids" {
  description = "Map of Public IP IDs for Bastion"
  type        = map(string)
}
