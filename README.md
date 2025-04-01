# Azure OpenAI Deployment Module for Terraform

### Module Code

```
module "terraform_azure_openai_deploy" {
  source              = "github.com/nikhiljohn10/terraform-azure-openai-deploy.git?ref=v0.1.1"
  subscription_id     = var.subscription_id
  resource_group_name = var.resource_group_name
  location            = var.location
  open_ai_instance    = var.open_ai_instance
}
```
The 4 attributes are mandatory for the module to work.

### Sample `variables.tf` file format

```
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
```

For tfvars file sameple, check [here](examples/README.md#sample-of-terraformtfvars-file)

For example, see [here](examples/README.md)