# GitHub Secrets - Actual Values for Staging Environment

## ✅ Terraform Infrastructure Successfully Created!

All 93 AWS resources have been provisioned. Use these actual values to configure your GitHub secrets.

---

## 📋 Required GitHub Secrets

### AWS Credentials
```
AWS_ACCESS_KEY_ID_STAGING
Value: <Your AWS Access Key ID>

AWS_SECRET_ACCESS_KEY_STAGING
Value: <Your AWS Secret Access Key>

AWS_REGION_STAGING
Value: us-east-1

AWS_ACCOUNT_ID_STAGING
Value: 471744311346
```

### ECR (Container Registry)
```
ECR_REGISTRY_STAGING
Value: 471744311346.dkr.ecr.us-east-1.amazonaws.com

BACKEND_REPOSITORY_STAGING
Value: itrack-api

FRONTEND_REPOSITORY_STAGING
Value: itrack-ui
```

### ECS (Container Service)
```
ECS_CLUSTER_STAGING
Value: itrack-cluster-staging

ECS_BACKEND_SERVICE_STAGING
Value: itrack-backend-service-staging

ECS_FRONTEND_SERVICE_STAGING
Value: itrack-frontend-service-staging

BACKEND_TASK_DEFINITION_STAGING
Value: itrack-backend-staging

FRONTEND_TASK_DEFINITION_STAGING
Value: itrack-frontend-staging
```

### Load Balancer
```
ALB_NAME_STAGING
Value: itrack-alb-staging
```

### Database Password
```
DB_PASSWORD_STAGING
Value: <Set your secure database password>
Note: Use the same password you configured in staging.tfvars or generate a new secure one
```

---

## 🔗 Additional Resource Information

### ALB (Application Load Balancer)
- **DNS Name**: itrack-alb-staging-191190332.us-east-1.elb.amazonaws.com
- **ARN**: arn:aws:elasticloadbalancing:us-east-1:471744311346:loadbalancer/app/itrack-alb-staging/edd058782d9001fe

### ECR Repository URLs
- **Backend**: 471744311346.dkr.ecr.us-east-1.amazonaws.com/itrack-api
- **Frontend**: 471744311346.dkr.ecr.us-east-1.amazonaws.com/itrack-ui

### API Gateway
- **URL**: https://wg5bibsh2h.execute-api.us-east-1.amazonaws.com/staging
- **ID**: wg5bibsh2h

### CloudFront CDN
- **Domain**: d2qfetadoitbbt.cloudfront.net
- **Distribution ID**: EQ2HKU33EE0HF

### S3 Bucket
- **Name**: itrack-assets-staging

### VPC
- **ID**: vpc-03af82164f9e4ae4f

### DynamoDB Table
- **Name**: itrack-itrack-items-staging

### Backup Vault
- **ARN**: arn:aws:backup:us-east-1:471744311346:backup-vault:itrack-backup-vault-staging

---

## 🚀 How to Add Secrets to GitHub

1. Go to your GitHub repository: https://github.com/GRIFFINGlobalTech/rs-feb-25

2. Navigate to: **Settings** → **Secrets and variables** → **Actions**

3. Create a new **Environment** named `staging`:
   - Click on **Environments** (left sidebar)
   - Click **New environment**
   - Name it: `staging`
   - Click **Configure environment**

4. Add each secret from the list above:
   - Click **Add secret**
   - Name: (use the exact name from above, e.g., `ECS_CLUSTER_STAGING`)
   - Value: (copy the corresponding value)
   - Click **Add secret**

5. Repeat for all 14 secrets

---

## ✅ Verification Checklist

- [ ] AWS_ACCESS_KEY_ID_STAGING
- [ ] AWS_SECRET_ACCESS_KEY_STAGING
- [ ] AWS_REGION_STAGING = us-east-1
- [ ] AWS_ACCOUNT_ID_STAGING = 471744311346
- [ ] ECR_REGISTRY_STAGING = 471744311346.dkr.ecr.us-east-1.amazonaws.com
- [ ] BACKEND_REPOSITORY_STAGING = itrack-api
- [ ] FRONTEND_REPOSITORY_STAGING = itrack-ui
- [ ] ECS_CLUSTER_STAGING = itrack-cluster-staging
- [ ] ECS_BACKEND_SERVICE_STAGING = itrack-backend-service-staging
- [ ] ECS_FRONTEND_SERVICE_STAGING = itrack-frontend-service-staging
- [ ] BACKEND_TASK_DEFINITION_STAGING = itrack-backend-staging
- [ ] FRONTEND_TASK_DEFINITION_STAGING = itrack-frontend-staging
- [ ] ALB_NAME_STAGING = itrack-alb-staging
- [ ] DB_PASSWORD_STAGING = <your-secure-password>

---

## 📌 Next Steps

1. Add all 14 secrets to GitHub (see instructions above)
2. Push a commit to `feature/staging-v1` branch to trigger the workflow
3. Monitor the GitHub Actions workflow execution
4. Verify deployments to ECS services
5. Access your application at: http://itrack-alb-staging-191190332.us-east-1.elb.amazonaws.com

---

## 🔐 Security Notes

- Never commit AWS credentials to the repository
- Rotate AWS Access Keys regularly
- Use strong, random passwords for DB_PASSWORD_STAGING
- Consider using AWS Secrets Manager for production credentials

---

**Generated**: October 24, 2025  
**Environment**: staging  
**Infrastructure**: AWS (us-east-1)  
**Managed by**: Terraform
