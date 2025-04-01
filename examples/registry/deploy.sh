#!/usr/bin/bash

set -e

# Check if Terraform is installed
if [ ! -x "$(type -P terraform)" ]; then
    echo "Error: Terraform is not installed or not in PATH. Please install Terraform from https://developer.hashicorp.com/terraform/downloads and try again."
    exit 1
fi

# destroy the infrastructure if -d flag is passed
# Usage: ./deploy.sh -d
if [ "$1" == "-d" ]; then
    terraform destroy -auto-approve && rm -f tfplan
    exit 0
fi

# Check if Azure CLI is installed
if [ ! -x "$(type -P az)" ]; then
    echo "Error: Azure CLI is not installed or not in PATH. Please install Azure CLI from https://learn.microsoft.com/en-us/cli/azure/install-azure-cli and try again."
    exit 1
fi

# Check if the user is logged in to Azure
if ! az account show > /dev/null 2>&1; then
    echo "Error: You are not logged in to Azure. Please log in using 'az login --tenant TENANT_ID' and try again."
    exit 1
fi

# Retrieve Azure subscription ID
TF_VAR_subscription_id=$(az account show --query "id" -o tsv)
if [ -z "$TF_VAR_subscription_id" ]; then
    echo "Error: Unable to retrieve Azure subscription ID. Please ensure you are logged in to Azure."
    exit 1
fi

# Reset account
# Usage: ./deploy.sh -r
if [ "$1" == "-r" ]; then
    TENANT_ID=$(az account show --query "tenantId" -o tsv)
    az logout
    az account clear
    if [ "$OS" == "Windows_NT" ] && [ -d "/c/Users/me/AppData/Local/Microsoft/IdentityCache" ]; then
        rm -rf /c/Users/me/AppData/Local/Microsoft/IdentityCache/*
    fi
    rm -rf terraform.tfstate* .terraform .terraform*
    az login --tenant $TENANT_ID
fi

# Check if terraform.tfvars file exists
if [ ! -s "terraform.tfvars" ]; then
    echo "Error: terraform.tfvars file is missing or empty. Please create and populate it before proceeding."
    exit 1
fi

# Run Terraform commands
terraform init -upgrade
terraform validate
terraform plan -out=tfplan
terraform apply tfplan