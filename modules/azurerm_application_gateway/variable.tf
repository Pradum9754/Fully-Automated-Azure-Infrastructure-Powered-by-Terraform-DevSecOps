variable "app_gateways" {
  description = "Map of application gateways"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    frontend_to_backend = map(number)
    backend_vm_keys     = list(string)
  }))
}

variable "vm_private_ips" {
  description = "Private IPs of backend/frontend VMs"
  type        = map(string)
}
