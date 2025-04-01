if [ -x "$(type -P az)" ] && [ -x "$(type -P terraform)" ]; then
    SUB_ID=$(az account show | grep "id" | cut -d"\"" -f4)
    if [ -z "$SUB_ID" ]; then
        echo "No subscription found. Please login to Azure."
        exit 1
    fi
    if [ ! -f "terraform.tfvars" ]; then
        echo "Error: terraform.tfvars file not found. Please create one before proceeding."
        exit 1
    fi
    echo "export TF_VAR_subscription_id=$SUB_ID" > .env.subscription
    source .env.subscription
    cd terraform
    if [ ! -d ".terraform" ]; then
        terraform init
    else
        terraform init -upgrade
    fi
    terraform validate
    terraform plan -out=tfplan
    terraform apply tfplan
fi