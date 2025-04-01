variable "subscription_id" {
  description = "The Azure subscription ID where resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where resources will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  default     = "japaneast"
  type        = string
}

variable "open_ai_instance" {
  description = "An OpenAI instance with their models."
  type = object({
    name                 = string
    region               = string
    sku                  = string
    custom_subdomain_name = string
    models = list(object({
      name    = string
      version = string
      type    = optional(string, "Standard")
    }))
  })
  validation {
    condition     = alltrue([for model in var.open_ai_instance.models: contains(["Standard", "DataZoneBatch", "DataZoneProvisionedManaged", "DataZoneStandard", "GlobalBatch", "GlobalProvisionedManaged", "GlobalStandard", "ProvisionedManaged"], model.type)]) 
    error_message = "Invalid model type. Valid types are: Standard, DataZoneBatch, DataZoneProvisionedManaged, DataZoneStandard, GlobalBatch, GlobalProvisionedManaged, GlobalStandard, ProvisionedManaged."
  }
}