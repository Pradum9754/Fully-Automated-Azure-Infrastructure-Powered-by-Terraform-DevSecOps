variable "vm_todo_infra" {
  type = map(object({
    name                  = string
    resource_group_name   = string
    location              = string
    size                  = string
    admin_username        = string
    nic_key               = string            # required in tfvars
    network_interface_ids = optional(list(string))  # optional now
    public_key            = optional(string)        # optional now
    caching               = string
    storage_account_type  = string
    publisher             = string
    offer                 = string
    sku                   = string
    version               = string
  }))
}

