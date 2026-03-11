# GitHub Secrets Setup for Staging Environment

## Step 1: Create GitHub Environment

1. Go to your GitHub repository: `https://github.com/GRIFFINGlobalTech/rs-feb-25`
2. Click **Settings** tab
3. In the left sidebar, click **Environments**
4. Click **New environment**
5. Name: `staging` (or `production` as used in workflow)
6. Click **Configure environment**

## Step 2: Add Repository Secrets

Go to **Settings** → **Secrets and variables** → **Actions** → **New repository secret**

### Complete List of Required Secrets (15 Total)

Copy and paste these values into GitHub. Replace the example values with your actual values.

---

## 🔐 AWS Authentication (2 secrets)

### 1. AWS_ACCESS_KEY_ID_STAGING
**Value:** 
```
AKIAIOSFODNN7EXAMPLE
```
**Description:** AWS IAM access key ID for staging deployments
**How to get:** AWS Console → IAM → Users → Security credentials → Create access key

---

### 2. AWS_SECRET_ACCESS_KEY_STAGING
**Value:** 
```
wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```
**Description:** AWS IAM secret access key for staging deployments
**How to get:** Generated when you create the access key (save it immediately!)

---

## 🌍 AWS Configuration (2 secrets)

### 3. AWS_REGION_STAGING
**Value:** 
```
us-east-1
```
**Description:** AWS region where staging resources are deployed

---

### 4. AWS_ACCOUNT_ID_STAGING
**Value:** 
```
875486186130
```
**Description:** Your AWS account ID
**How to get:** AWS Console → Click account name (top right) → Copy Account ID

---

## 📦 ECR Configuration (3 secrets)

### 5. ECR_REGISTRY_STAGING
**Value:** 
```
875486186130.dkr.ecr.us-east-1.amazonaws.com
```
**Description:** ECR registry URL
**Format:** `{AWS_ACCOUNT_ID}.dkr.ecr.{AWS_REGION}.amazonaws.com`

---

### 6. BACKEND_REPOSITORY_STAGING
**Value:** 
```
DevopsApp-api
```
**Description:** Backend ECR repository name
**Note:** Must match the repository name created in ECR

---

### 7. FRONTEND_REPOSITORY_STAGING
**Value:** 
```
DevopsApp-ui
```
**Description:** Frontend ECR repository name
**Note:** Must match the repository name created in ECR

---

## 🚀 ECS Configuration (5 secrets)

### 8. ECS_CLUSTER_STAGING
**Value:** 
```
DevopsApp-cluster-staging
```
**Description:** ECS cluster name for staging
**Note:** Must match the cluster name created by Terraform

---

### 9. ECS_BACKEND_SERVICE_STAGING
**Value:** 
```
DevopsApp-backend-service-staging
```
**Description:** Backend ECS service name
**Note:** Must match the service name created by Terraform

---

### 10. ECS_FRONTEND_SERVICE_STAGING
**Value:** 
```
DevopsApp-frontend-service-staging
```
**Description:** Frontend ECS service name
**Note:** Must match the service name created by Terraform

---

### 11. BACKEND_TASK_DEFINITION_STAGING
**Value:** 
```
DevopsApp-backend-staging
```
**Description:** Backend ECS task definition name
**Note:** Must match the task definition created by Terraform

---

### 12. FRONTEND_TASK_DEFINITION_STAGING
**Value:** 
```
DevopsApp-frontend-staging
```
**Description:** Frontend ECS task definition name
**Note:** Must match the task definition created by Terraform

---

## ⚖️ Load Balancer Configuration (1 secret)

### 13. ALB_NAME_STAGING
**Value:** 
```
DevopsApp-alb-staging
```
**Description:** Application Load Balancer name
**Note:** Must match the ALB name created by Terraform

---

## 🗄️ Database Configuration (1 secret)

### 14. DB_PASSWORD_STAGING
**Value:** 
```
YourSecurePassword123!
```
**Description:** RDS PostgreSQL database password for staging
**Requirements:**
- Minimum 8 characters
- Must contain uppercase, lowercase, numbers
- Must contain special characters
- Do NOT use: `@`, `/`, `"`, or spaces

---

## 📋 Quick Copy-Paste Checklist

Use this checklist to ensure all secrets are added:

- [ ] AWS_ACCESS_KEY_ID_STAGING
- [ ] AWS_SECRET_ACCESS_KEY_STAGING
- [ ] AWS_REGION_STAGING
- [ ] AWS_ACCOUNT_ID_STAGING
- [ ] ECR_REGISTRY_STAGING
- [ ] BACKEND_REPOSITORY_STAGING
- [ ] FRONTEND_REPOSITORY_STAGING
- [ ] ECS_CLUSTER_STAGING
- [ ] ECS_BACKEND_SERVICE_STAGING
- [ ] ECS_FRONTEND_SERVICE_STAGING
- [ ] BACKEND_TASK_DEFINITION_STAGING
- [ ] FRONTEND_TASK_DEFINITION_STAGING
- [ ] ALB_NAME_STAGING
- [ ] DB_PASSWORD_STAGING

---

## 📝 Complete Values Summary (for easy reference)

| # | Secret Name | Example Value | Type |
|---|-------------|---------------|------|
| 1 | `AWS_ACCESS_KEY_ID_STAGING` | `AKIAIOSFODNN7EXAMPLE` | AWS Credentials |
| 2 | `AWS_SECRET_ACCESS_KEY_STAGING` | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` | AWS Credentials |
| 3 | `AWS_REGION_STAGING` | `us-east-1` | AWS Config |
| 4 | `AWS_ACCOUNT_ID_STAGING` | `875486186130` | AWS Config |
| 5 | `ECR_REGISTRY_STAGING` | `875486186130.dkr.ecr.us-east-1.amazonaws.com` | ECR |
| 6 | `BACKEND_REPOSITORY_STAGING` | `DevopsApp-api` | ECR |
| 7 | `FRONTEND_REPOSITORY_STAGING` | `DevopsApp-ui` | ECR |
| 8 | `ECS_CLUSTER_STAGING` | `DevopsApp-cluster-staging` | ECS |
| 9 | `ECS_BACKEND_SERVICE_STAGING` | `DevopsApp-backend-service-staging` | ECS |
| 10 | `ECS_FRONTEND_SERVICE_STAGING` | `DevopsApp-frontend-service-staging` | ECS |
| 11 | `BACKEND_TASK_DEFINITION_STAGING` | `DevopsApp-backend-staging` | ECS |
| 12 | `FRONTEND_TASK_DEFINITION_STAGING` | `DevopsApp-frontend-staging` | ECS |
| 13 | `ALB_NAME_STAGING` | `DevopsApp-alb-staging` | Load Balancer |
| 14 | `DB_PASSWORD_STAGING` | `YourSecurePassword123!` | Database |

---

## 🔑 How to Get AWS Access Keys

If you don't have AWS access keys yet:

1. Go to AWS Console → **IAM**
2. Click **Users** in the left sidebar
3. Click on your username (or create a new deployment user)
4. Click **Security credentials** tab
5. Scroll to **Access keys**
6. Click **Create access key**
7. Select **Use case**: Application running outside AWS
8. Click **Next** → **Create access key**
9. **IMPORTANT:** Copy both the Access Key ID and Secret Access Key immediately
10. Store them securely (you won't be able to see the secret again)

---

## 🏗️ Resource Naming Convention

For staging environment, all resources follow this pattern:

```
DevopsApp-{resource-type}-staging
```

Examples:
- Cluster: `DevopsApp-cluster-staging`
- Backend Service: `DevopsApp-backend-service-staging`
- Frontend Service: `DevopsApp-frontend-service-staging`
- Backend Task: `DevopsApp-backend-staging`
- Frontend Task: `DevopsApp-frontend-staging`
- Load Balancer: `DevopsApp-alb-staging`
- ECR Repos: `DevopsApp-api`, `DevopsApp-ui`

---

## ✅ Verification Steps

After adding all secrets:

1. Go to **Settings** → **Secrets and variables** → **Actions**
2. You should see 14 repository secrets ending with `_STAGING`
3. Click on each secret to verify the name (values are hidden for security)
4. Go to **Settings** → **Environments**
5. Verify the `staging` or `production` environment exists

---

## 🚀 Test the Setup

After adding all secrets, test by:

1. Make a small change to your code
2. Commit and push to `main` or `develop` branch
3. Go to **Actions** tab in GitHub
4. Check that the workflow runs without "secret not found" errors
5. Review the workflow logs for any issues

---

## 🆘 Troubleshooting

### Error: "Context access might be invalid: SECRET_NAME"
**Solution:** Ensure the secret name matches exactly (case-sensitive) in GitHub

### Error: "Unable to locate credentials"
**Solution:** Check `AWS_ACCESS_KEY_ID_STAGING` and `AWS_SECRET_ACCESS_KEY_STAGING` are set correctly

### Error: "An error occurred (ResourceNotFoundException)"
**Solution:** Verify the resource names (cluster, service, ALB) match what's in AWS

### Secrets not showing up in workflow
**Solution:** Ensure secrets are added at **repository** level, not organization level

---

## 📧 Support

For issues:
1. Check this document for correct secret names
2. Verify all 14 secrets are added in GitHub
3. Check AWS Console to confirm resource names
4. Review GitHub Actions workflow logs

---

**Last Updated:** October 24, 2025  
**Environment:** Staging  
**Total Secrets Required:** 14
