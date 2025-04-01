output "api_endpoint" {
  value = azurerm_cognitive_account.ai_services.endpoint
  description = "Value of the endpoint of the instance"
}

output "api_key" {
  value = azurerm_cognitive_account.ai_services.primary_access_key
  description = "Value of the primary access key of the instance"
  sensitive = true
}
