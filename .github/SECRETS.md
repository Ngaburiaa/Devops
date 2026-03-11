# GitHub Secrets Configuration

This document lists all the required GitHub secrets for the CI/CD pipeline.

## Required Secrets for Staging Environment

Navigate to your GitHub repository → **Settings** → **Secrets and variables** → **Actions** → **New repository secret**

**Note:** All secrets end with `_STAGING` suffix to separate staging from production secrets.

### AWS Configuration

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `AWS_ACCESS_KEY_ID_STAGING` | AWS IAM access key ID | `AKIAIOSFODNN7EXAMPLE` |
| `AWS_SECRET_ACCESS_KEY_STAGING` | AWS IAM secret access key | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` |
| `AWS_REGION_STAGING` | AWS region where resources are deployed | `us-east-1` |
| `AWS_ACCOUNT_ID_STAGING` | Your AWS account ID | `875486186130` |

### ECR Configuration

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `ECR_REGISTRY_STAGING` | ECR registry URL | `875486186130.dkr.ecr.us-east-1.amazonaws.com` |
| `BACKEND_REPOSITORY_STAGING` | Backend ECR repository name | `DevopsApp-api` |
| `FRONTEND_REPOSITORY_STAGING` | Frontend ECR repository name | `DevopsApp-ui` |

### ECS Configuration

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `ECS_CLUSTER_STAGING` | ECS cluster name | `DevopsApp-cluster-staging` |
| `ECS_BACKEND_SERVICE_STAGING` | Backend ECS service name | `DevopsApp-backend-service-staging` |
| `ECS_FRONTEND_SERVICE_STAGING` | Frontend ECS service name | `DevopsApp-frontend-service-staging` |
| `BACKEND_TASK_DEFINITION_STAGING` | Backend task definition name | `DevopsApp-backend-staging` |
| `FRONTEND_TASK_DEFINITION_STAGING` | Frontend task definition name | `DevopsApp-frontend-staging` |

### Load Balancer Configuration

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `ALB_NAME_STAGING` | Application Load Balancer name | `DevopsApp-alb-staging` |

### Database Configuration

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `DB_PASSWORD_STAGING` | Database password for RDS | `YourSecurePassword123!` |

## How to Add Secrets

1. Go to your GitHub repository
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Enter the **Name** (exactly as shown above)
5. Enter the **Value**
6. Click **Add secret**

## Security Best Practices

- ✅ Never commit secrets to your repository
- ✅ Use strong, unique passwords for sensitive values
- ✅ Rotate secrets regularly
- ✅ Limit AWS IAM permissions to only what's needed
- ✅ Use environment-specific secrets for staging vs production
- ✅ Monitor secret usage in GitHub Actions logs

## Verification

After adding all secrets, you can verify by:

1. Going to **Actions** tab in your repository
2. Running the workflow manually or pushing to the main branch
3. Check that the workflow runs without "secret not found" errors

## Troubleshooting

If you see errors like `Context access might be invalid: SECRET_NAME`:
- Ensure the secret name matches exactly (case-sensitive)
- Verify the secret is added at the repository level (not organization level)
- Re-run the workflow after adding secrets
