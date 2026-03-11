# Terraform Configuration for DevopsApp Staging IAM Role

# Data source for current AWS account
data "aws_caller_identity" "current" {}

# GitHub OIDC Provider (create if it doesn't exist)
resource "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]

  tags = {
    Name        = "GitHub Actions OIDC Provider"
    Environment = "staging"
    ManagedBy   = "Terraform"
  }
}

# IAM Role for GitHub Actions Deployment
resource "aws_iam_role" "DevopsApp_staging_deployment" {
  name        = "DevopsApp-Staging-Environment-Role"
  description = "Deployment role for DevopsApp staging environment with comprehensive AWS service permissions"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github_actions.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:GRIFFINGlobalTech/rs-feb-25:*"
          }
        }
      }
    ]
  })

  max_session_duration = 3600 # 1 hour

  tags = {
    Name        = "DevopsApp-Staging-Environment-Role"
    Environment = "staging"
    Project     = "DevopsApp"
    ManagedBy   = "Terraform"
    Purpose     = "CICD-Deployment"
  }
}

# IAM Policy for Deployment
resource "aws_iam_policy" "DevopsApp_staging_deployment" {
  name        = "DevopsApp-Staging-Deployment-Policy"
  description = "Comprehensive deployment permissions for DevopsApp staging environment"
  policy      = file("${path.module}/deployment-policy.json")

  tags = {
    Name        = "DevopsApp-Staging-Deployment-Policy"
    Environment = "staging"
    Project     = "DevopsApp"
    ManagedBy   = "Terraform"
  }
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "DevopsApp_staging_deployment" {
  role       = aws_iam_role.DevopsApp_staging_deployment.name
  policy_arn = aws_iam_policy.DevopsApp_staging_deployment.arn
}

# Outputs
output "deployment_role_arn" {
  description = "ARN of the deployment role for GitHub Actions"
  value       = aws_iam_role.DevopsApp_staging_deployment.arn
}

output "deployment_role_name" {
  description = "Name of the deployment role"
  value       = aws_iam_role.DevopsApp_staging_deployment.name
}

output "deployment_policy_arn" {
  description = "ARN of the deployment policy"
  value       = aws_iam_policy.DevopsApp_staging_deployment.arn
}

output "github_oidc_provider_arn" {
  description = "ARN of the GitHub OIDC provider"
  value       = aws_iam_openid_connect_provider.github_actions.arn
}

output "aws_account_id" {
  description = "AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}
