variable "nic_todo_infra" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = map(string)
    ip_configurations = list(object({
      name                          = string
      subnet_ref                    = string   # <-- here we are using subnet_ref, not subnet_id
      private_ip_address_allocation = string
      
    }))
  }))
}
