# DevOps Infrastructure

This repository contains the complete DevOps infrastructure and automation for the  application, including Terraform infrastructure as code, AWS Lambda functions, and CI/CD pipelines.

## 📁 Repository Structure

### 🔧 `/terraform`
Infrastructure as Code (IaC) for provisioning and managing AWS resources.

- **`main.tf`** - Root Terraform configuration
- **`variables.tf`** - Input variables for Terraform
- **`outputs.tf`** - Output values from Terraform
- **`environments/`** - Environment-specific configurations (staging, production)
- **`modules/`** - Reusable Terraform modules:
  - **`vpc/`** - Virtual Private Cloud networking
  - **`ecs/`** - Elastic Container Service for API hosting
  - **`rds/`** - Relational Database Service (PostgreSQL)
  - **`dynamodb/`** - NoSQL database tables
  - **`s3/`** - S3 buckets for storage
  - **`s3_hosting/`** - S3 static website hosting
  - **`cloudfront/`** - CDN distribution
  - **`lambda/`** - Lambda function infrastructure
  - **`ecr/`** - Elastic Container Registry
  - **`route53/`** - DNS management
  - **`security/`** - Security groups and network ACLs
  - **`secrets/`** - AWS Secrets Manager
  - **`monitoring/`** - CloudWatch alarms and dashboards
  - **`backup/`** - Backup and disaster recovery
  - **`waf/`** - Web Application Firewall
  - **`bastion/`** - Bastion host for secure access
- **`staging-architecture/`** - Detailed staging environment documentation

### ⚡ `/lambda`
AWS Lambda functions for serverless operations.

- **`email-service/`** - Email service using Microsoft Graph API
  - Sends emails via Azure AD integrated authentication
  - Supports HTML/text emails and attachments
  - No external dependencies (uses native Node.js fetch)
  - See [lambda/email-service/README.md](lambda/email-service/README.md) for details

### 🔄 `/.github/workflows`
GitHub Actions CI/CD pipelines for automated deployments.

**API Workflows:**
- `api-pr.yml` - API pull request validation
- `api-unit-tests-pr.yaml` - API unit testing on PRs
- `deploy-staging-api.yml` - Deploy API to staging
- `deploy-prod-api.yml` - Deploy API to production

**UI Workflows:**
- `ui-pr.yml` - UI pull request validation
- `deploy-staging-ui.yml` - Deploy UI to staging
- `deploy-prod-ui.yml` - Deploy UI to production

**Lambda Workflows:**
- `deploy-develop-lambda.yml` - Deploy Lambda to development
- `deploy-prod-lambda.yml` - Deploy Lambda to production

**Other:**
- `automation-scripts.yaml` - Automation scripts workflow

## 🏗️ Architecture Overview

The infrastructure supports a full-stack application with:

- **Frontend**: React UI hosted on S3 + CloudFront CDN
- **Backend**: Node.js API running on ECS (Fargate)
- **Databases**: PostgreSQL (RDS) + DynamoDB
- **Email Service**: Serverless Lambda function
- **Networking**: VPC with public/private subnets across multiple AZs
- **Security**: WAF, Security Groups, Secrets Manager
- **Monitoring**: CloudWatch Logs, Metrics, and Alarms
- **Backup**: Automated RDS backups and snapshots

See [terraform/staging-architecture/ARCHITECTURE.md](terraform/staging-architecture/ARCHITECTURE.md) for detailed architecture diagrams.

## 🚀 Quick Start

### Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0
- Node.js >= 20.x (for Lambda development)
- GitHub Actions secrets configured (see `.github/SECRETS.md`)

### Deploy Infrastructure

```bash
# Navigate to terraform directory
cd terraform

# Initialize Terraform
terraform init -backend-config=environments/staging.backend.conf

# Plan deployment
terraform plan -var-file=environments/staging.tfvars

# Apply changes
terraform apply -var-file=environments/staging.tfvars
```

### Deploy Lambda Email Service

```bash
cd lambda/email-service
./scripts/build.sh
./scripts/deploy.sh
```

See [lambda/email-service/README.md](lambda/email-service/README.md) for detailed deployment options.

## 📚 Documentation

- **[Staging Architecture](terraform/staging-architecture/ARCHITECTURE.md)** - Complete staging environment architecture
- **[Staging Setup Guide](terraform/staging-architecture/QUICKSTART.md)** - Quick start for staging deployment
- **[IAM Role Setup](terraform/staging-architecture/IAM-ROLE-SETUP.md)** - GitHub Actions IAM configuration
- **[Secrets Reference](.github/QUICK-SECRETS-REFERENCE.md)** - GitHub Actions secrets
- **[Staging Secrets Setup](.github/STAGING-SECRETS-SETUP.md)** - Staging environment secrets

## 🔐 Security

- Secrets are managed via AWS Secrets Manager and GitHub Secrets
- All traffic encrypted in transit (HTTPS/TLS)
- Private subnets for database and application servers
- WAF rules to protect against common web exploits
- Security groups restrict access to minimum required ports
- IAM roles follow principle of least privilege

## 🌍 Environments

- **Development** - For active development and testing
- **Staging** - Pre-production environment for final testing
- **Production** - Live production environment

Each environment has isolated infrastructure and configuration files in `terraform/environments/`.

## 📝 Contributing

1. Create a feature branch from `develop`
2. Make your changes
3. Submit a pull request (PR checks will run automatically)
4. Merge after approval and successful CI/CD validation

## 📧 Support

For infrastructure issues or questions, please contact the DevOps team.

## 📄 License

[Your License Here]
