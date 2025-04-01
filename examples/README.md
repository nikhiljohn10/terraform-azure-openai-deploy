# Azure OpenAI Deployment Module Example

### Sample of `terraform.tfvars` file

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

### Example Steps

1. Install Terraform and Azure CLI.
2. Go to [Microsoft Entra ID](https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/Overview) service and copy "Tenant ID".
3. Login to Azure using `az login --tenant TENANT_ID`. Replace `TENANT_ID` in command with Tenant ID copyied from Azure portal.
4. Change directory to `examples`.
5. Save a file `terraform.tfvars` with content in README. You can modify the content as your need.
6. Create a `main.tf` file as given [here](main.tf).
7. Execute `./deploy.sh` to deploy the open ai models in Azure.

The example will save the api endpoint and api key of Azure AI Instance as environment file in same folder.

### Command Usage

```bash
Usage: ./deploy.sh [-d|-r]
Options:
    -d  : Destroy the resource and revert to previous state
    -r  : Reset account, remove cache and login back
```