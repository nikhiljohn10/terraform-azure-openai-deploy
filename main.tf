resource "azurerm_resource_group" "ai_resource_group" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_cognitive_account" "ai_services" {
  name                          = var.open_ai_instance.name
  location                      = var.open_ai_instance.region
  resource_group_name           = azurerm_resource_group.ai_resource_group.name
  kind                          = "OpenAI"
  sku_name                      = var.open_ai_instance.sku
  custom_subdomain_name         = var.open_ai_instance.custom_subdomain_name
  public_network_access_enabled = true
}

resource "azurerm_cognitive_deployment" "model" {
  for_each = { for open_ai_instance_model in local.open_ai_instance_models : open_ai_instance_model.model_name => open_ai_instance_model }

  name                 = each.value.model_name
  cognitive_account_id = azurerm_cognitive_account.ai_services.id

  model {
    format  = "OpenAI"
    name    = each.value.model_name
    version = each.value.model_version
  }

  sku {
    name = each.value.model_type
  }
}