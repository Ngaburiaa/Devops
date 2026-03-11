# Quick Reference: GitHub Secrets for Staging

## Copy-Paste Values (Update with your actual values)

### 1. AWS_ACCESS_KEY_ID_STAGING
```
AKIAIOSFODNN7EXAMPLE
```

### 2. AWS_SECRET_ACCESS_KEY_STAGING
```
wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

### 3. AWS_REGION_STAGING
```
us-east-1
```

### 4. AWS_ACCOUNT_ID_STAGING
```
875486186130
```

### 5. ECR_REGISTRY_STAGING
```
875486186130.dkr.ecr.us-east-1.amazonaws.com
```

### 6. BACKEND_REPOSITORY_STAGING
```
DevopsApp-api
```

### 7. FRONTEND_REPOSITORY_STAGING
```
DevopsApp-ui
```

### 8. ECS_CLUSTER_STAGING
```
DevopsApp-cluster-staging
```

### 9. ECS_BACKEND_SERVICE_STAGING
```
DevopsApp-backend-service-staging
```

### 10. ECS_FRONTEND_SERVICE_STAGING
```
DevopsApp-frontend-service-staging
```

### 11. BACKEND_TASK_DEFINITION_STAGING
```
DevopsApp-backend-staging
```

### 12. FRONTEND_TASK_DEFINITION_STAGING
```
DevopsApp-frontend-staging
```

### 13. ALB_NAME_STAGING
```
DevopsApp-alb-staging
```

### 14. DB_PASSWORD_STAGING
```
YourSecurePassword123!
```

---

## Where to Add These

1. Go to: `https://github.com/GRIFFINGlobalTech/rs-feb-25/settings/secrets/actions`
2. Click **New repository secret** for each one
3. Copy the name and value exactly as shown above
4. Click **Add secret**

## Important Notes

✅ Replace example AWS keys with your actual AWS access keys  
✅ Use a strong, unique password for DB_PASSWORD_STAGING  
✅ All resource names will be created by Terraform  
✅ ECR_REGISTRY format: `{account-id}.dkr.ecr.{region}.amazonaws.com`
