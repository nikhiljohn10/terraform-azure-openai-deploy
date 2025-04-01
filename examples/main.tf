terraform {
  required_version = ">= 1.11.0"
}

module "terraform_azure_openai_deploy" {
    source          = "github.com/nikhiljohn10/terraform-azure-openai-deploy.git?ref=v0.0.1"
    subscription_id = "00000000-0000-0000-0000-000000000000"
}

resource "local_file" "api_info" {
  content  = <<EOT
API_ENDPOINT=${terraform_azure_openai_deploy.api_endpoint}
API_KEY=${terraform_azure_openai_deploy.api_key}
EOT
  filename = "${path.module}/../.env.openai"
}
