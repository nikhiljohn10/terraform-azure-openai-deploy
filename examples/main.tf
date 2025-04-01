terraform {
  required_version = ">= 1.11.0"
}

variable "subscription_id" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "open_ai_instance" {
  type = object({
    name                  = string
    region                = string
    sku                   = string
    custom_subdomain_name = string
    models = list(object({
      name    = string
      version = string
      type    = optional(string, "Standard")
    }))
  })
}

module "terraform_azure_openai_deploy" {
  source              = "github.com/nikhiljohn10/terraform-azure-openai-deploy.git?ref=v0.1.2"
  subscription_id     = var.subscription_id
  resource_group_name = var.resource_group_name
  location            = var.location
  open_ai_instance    = var.open_ai_instance
}

resource "local_file" "api_info" {
  content  = <<EOT
API_ENDPOINT=${module.terraform_azure_openai_deploy.api_endpoint}
API_KEY=${module.terraform_azure_openai_deploy.api_key}
EOT
  filename = "${path.module}/.env.openai"
}
