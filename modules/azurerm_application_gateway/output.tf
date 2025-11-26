output "application_gateway_ids" {
  value       = [for ag in azurerm_application_gateway.todo_app_gateways : ag.id]
  description = "Internal Application Gateway IDs"
}

output "application_gateway_private_ips" {
  value = {
    for ag_key, ag in azurerm_application_gateway.todo_app_gateways :
    ag_key => ag.frontend_ip_configuration[0].private_ip_address
  }
}
