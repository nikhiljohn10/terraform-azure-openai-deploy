# terraform-azure-openai-deploy
Azure OpenAI Deployment Module for Terraform

### 


### Example of `terraform.tfvars`

```
subscription_id     = "00000000-0000-0000-0000-000000000000"
resource_group_name = "openai-services"
location            = "swedencentral"

open_ai_instance = {
  name                  = "openai-terraform"
  region                = "swedencentral"
  sku                   = "S0"
  custom_subdomain_name = "openai-terraform-swedencentral"
  models = [
    {
      name    = "gpt-4o-mini"
      version = "2024-07-18"
    },
    {
      name    = "gpt-4o"
      version = "2024-05-13"
    },
  ]
}
```