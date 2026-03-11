# GitHub Secrets & Variables Configuration for Staging Environment

## Overview
This document lists all the GitHub repository secrets and variables required for the new staging deployment workflows.

## Required Secrets (Repository > Settings > Secrets and variables > Actions)

### AWS Credentials
- **AWS_ACCESS_KEY_ID_STAGING**: AWS access key for staging environment
- **AWS_SECRET_ACCESS_KEY_STAGING**: AWS secret access key for staging environment
- **AWS_REGION_STAGING**: `us-east-1`

### AWS Account & ECR
- **AWS_ACCOUNT_ID_STAGING**: `471744311346`
- **ECR_REGISTRY_STAGING**: `471744311346.dkr.ecr.us-east-1.amazonaws.com`
- **BACKEND_REPOSITORY_STAGING**: `DevopsApp-api`

### ECS Configuration
- **ECS_CLUSTER_STAGING**: `DevopsApp-cluster-staging`
- **ECS_BACKEND_SERVICE_STAGING**: `DevopsApp-backend-staging`
- **BACKEND_TASK_DEFINITION_STAGING**: `DevopsApp-backend-staging`
- **ALB_NAME_STAGING**: `DevopsApp-alb-staging`

### Database
- **DB_PASSWORD_STAGING**: `TempPassword123!` (RDS PostgreSQL password)

### Frontend Environment
- **VITE_API_URL_STAGING**: `http://DevopsApp-alb-staging-191190332.us-east-1.elb.amazonaws.com`
  - Note: This should be updated to use CloudFront or custom domain if available

## Workflow Files

### 1. staging-api.yml
**Purpose**: Deploy backend API to ECS  
**Triggers**: 
- Push to `feature/staging-v1` branch
- Pull requests to `feature/staging-v1`
- Manual workflow dispatch

**Jobs**:
- `terraform-plan`: Validates Terraform changes on PRs
- `build-and-push`: Builds backend Docker image and pushes to ECR
- `deploy-backend`: Deploys new task definition to ECS and waits for stability
- `notify`: Sends deployment status notifications

### 2. staging-ui.yml
**Purpose**: Deploy frontend UI to S3 + CloudFront  
**Triggers**: 
- Push to `feature/staging-v1` branch
- Manual workflow dispatch

**Jobs**:
- `build-and-deploy`: Builds UI with Vite, syncs to S3, invalidates CloudFront cache
- `notify`: Sends deployment status notifications

**Hardcoded Values** (already exist in Terraform):
- S3 Bucket: `DevopsApp-assets-staging`
- CloudFront Distribution ID: `EQ2HKU33EE0HF`

## Cost Comparison

### Old Architecture (Removed)
- Frontend ECS Service: ~$26-31/month
- API Gateway: ~$3.50/month
- Lambda Functions: ~$5/month
- WAF (API Gateway): ~$5/month
- **Total removed**: ~$40-45/month

### New Architecture
- Backend ECS Service: ~$26-31/month
- Frontend S3 + CloudFront: ~$2-5/month
- **Total**: ~$28-36/month
- **Savings**: ~50% reduction (~$40-45/month saved)

## Deployment URLs

### Backend API
- **Load Balancer**: http://DevopsApp-alb-staging-191190332.us-east-1.elb.amazonaws.com
- **Health Check**: http://DevopsApp-alb-staging-191190332.us-east-1.elb.amazonaws.com/health
- **Login Endpoint**: http://DevopsApp-alb-staging-191190332.us-east-1.elb.amazonaws.com/auth/login

### Frontend UI
- **CloudFront URL**: Check distribution EQ2HKU33EE0HF for domain
- **S3 Bucket**: DevopsApp-assets-staging (not public direct access)

## Next Steps

1. **Configure GitHub Secrets**: Add all required secrets listed above to the repository
2. **Test Workflows**: 
   - Make a small change to backend code, push to `feature/staging-v1`, verify `staging-api.yml` runs
   - Make a small change to frontend code, push to `feature/staging-v1`, verify `staging-ui.yml` runs
3. **Apply Terraform Changes**: Run `terraform apply staging-cleanup.tfplan` to remove unused resources
4. **Update DNS/Domain**: Consider setting up custom domain for API and UI instead of using raw AWS URLs
5. **Monitor Costs**: Check AWS Cost Explorer after changes to confirm ~$40-45/month savings

## Troubleshooting

### If workflows fail due to missing secrets:
1. Go to Repository > Settings > Secrets and variables > Actions
2. Add missing secrets under "Repository secrets"
3. Re-run the failed workflow

### If ECS deployment hangs:
- Check ECS console for service health
- Verify task definition has correct environment variables
- Check CloudWatch logs for container errors

### If S3 deployment fails:
- Verify S3 bucket `DevopsApp-assets-staging` exists
- Check bucket permissions allow sync from GitHub Actions
- Verify CloudFront distribution ID `EQ2HKU33EE0HF` is correct

### If CloudFront invalidation fails:
- Check IAM permissions for CloudFront invalidation
- Verify distribution ID is correct
- Monitor invalidation status in CloudFront console
