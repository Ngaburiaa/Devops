#!/bin/bash
# Deploy Lambda via Terraform

echo "Deploying Lambda function via Terraform..."

# Build deployment package first
./scripts/build.sh

if [ ! -f "deployment.zip" ]; then
    echo "Error: deployment.zip not found. Build failed."
    exit 1
fi

# Navigate to terraform directory
cd ../../terraform || exit

echo "Initializing Terraform..."
terraform init

echo "Planning Lambda deployment..."
terraform plan -target=module.lambda_email_service

echo "Applying Lambda deployment..."
terraform apply -target=module.lambda_email_service -auto-approve

echo "Lambda function deployed successfully"
