variable "todo_asg_nsg" {
  description = "Combined configuration for NSGs and ASGs"
  type = map(object({
    asg = object({
      name                = string
      location            = string
      resource_group_name = string
      tags                = map(string)
    })
    nsg = object({
      name                = string
      location            = string
      resource_group_name = string
      tags                = map(string)
      security_rules = list(object({
        name                       = string
        priority                   = number
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = string
        source_address_prefix      = string
        destination_address_prefix = string

        # optional for ASG use
        source_application_security_group_ids      = optional(list(string))
        destination_application_security_group_ids = optional(list(string))
      }))
    })
  }))
}
